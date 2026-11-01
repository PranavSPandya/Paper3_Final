# H4 sound test by environment. Parameters for THIS folder's test:
OUTCOMES   <- "Quest"    # "Physio" (26 physiological) or "Quest" (Paper 3 questionnaires)
DATASET    <- "AllEnv"     # "AllEnv" (WalkU, BikeU, WalkG, BikeG) or "UrbanOnly" (WalkU, BikeU only)
FILTER     <- "UTCIgt26"      # "NoFilter" or "UTCIgtNN" (keep 10 s rows with ucm_UTCI > NN)
MODEL      <- "SoundOnly"       # "SoundPlusUTCI" (Y ~ S + UTCI) or "SoundOnly" (Y ~ S)
CONTROL    <- "WithMode"  # "WithEnv" (EnvSumUrban: urban +1, green -1), "WithMode" (ModeSumWalk: WalkU, WalkG +1; BikeU, BikeG -1) or "NoMode"
RESOLUTION <- "PhaseMean"  # "PhaseMean" (one row per participant x phase) or "TS10s" (10 s rows)
# Inputs (read-only). Override with environment variables when running elsewhere.
DATA     <- Sys.getenv("P3_DATA", "C:/Users/sanga/Documents/Codex/p3h/output/merged_all_11participants_8min.csv")
NORM     <- Sys.getenv("P3_NORM", "C:/Users/sanga/Desktop/Pranav Paper3_Final/output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_all_parameters.csv")
FORMULAS <- Sys.getenv("P3_FORMULAS", "C:/Users/sanga/Desktop/Pranav Paper3_Final/output/statistical_analysis/results/H4_timeseries_sound/H4_sound_Eq1_formulas.csv")
OUTDIR   <- Sys.getenv("P3_OUTDIR", ".")
WORKERS  <- as.integer(Sys.getenv("P3_WORKERS", "1"))   # parallel::mclapply cores for the model loop (1 = serial)
MIN_ROWS <- 6L   # cells (participant x phase) need >= 6 kept 10 s rows when a row filter is applied

if (dir.exists("~/R/library")) .libPaths(c("~/R/library", .libPaths()))
suppressPackageStartupMessages({ library(nlme); library(clubSandwich) })
stopifnot(DATASET %in% c("AllEnv","UrbanOnly"), MODEL %in% c("SoundPlusUTCI","SoundOnly"), RESOLUTION %in% c("PhaseMean","TS10s"),
  CONTROL %in% if (DATASET == "AllEnv") c("WithEnv","WithMode") else c("WithMode","NoMode"), !(OUTCOMES == "Quest" && RESOLUTION == "TS10s"))
P <- c("P4","P8","P9","P10","P11","P12","P13","P14","P15","P16","P17")
physio <- c("empatica_heart_rate","empatica_eda_tonic","empatica_eda_phasic","empatica_skin_temperature",
 "empatica_hrv_td_sdnn","empatica_hrv_td_rmssd","empatica_hrv_fd_lf","empatica_hrv_fd_hf",
 "empatica_hrv_fd_lf_hf_ratio","empatica_hrv_fd_lfnu","empatica_hrv_fd_hfnu","empatica_hrv_fd_vlf",
 "empatica_hrv_fd_total_power","eyetracker_pupil_diameter_avg","eyetracker_pupil_change_rate","eyetracker_blink_duration_s",
 "eyetracker_fixation_duration_s","eyetracker_fixation_rate","eyetracker_saccade_duration_s",
 "eyetracker_saccade_amplitude","eyetracker_saccade_peak_velocity","eyetracker_gaze_velocity",
 "eyetracker_gaze_dispersion","eyetracker_distance_from_center","eyetracker_gaze_centrality","eyetracker_eyelid_aperture_avg")
quest_core <- c("questionnaire_current_comfort_1_7","questionnaire_pleasantness_1_5","questionnaire_stai6_mean_1_5","questionnaire_prs11_total_mean_1_5")
quest_ext  <- c("questionnaire_thermal_comfort_1_5","questionnaire_environmental_comfort_mean_1_5","questionnaire_prs11_fascination_mean_1_5",
 "questionnaire_prs11_being_away_mean_1_5","questionnaire_prs11_coherence_mean_1_5","questionnaire_prs11_scope_mean_1_5")
outcomes <- if (OUTCOMES == "Physio") physio else c(quest_core, quest_ext)
sounds <- c("ucm_SND_dBA", read.csv(FORMULAS)$sound_variable); stopifnot(length(sounds) == 24)

d <- read.csv(DATA, check.names = FALSE, stringsAsFactors = FALSE)
d <- d[d$ParticipantID %in% P & d$PhaseID %in% c("BikeU","WalkU","BikeG","WalkG"), ]; stopifnot(nrow(d) == 2112)
if (OUTCOMES == "Physio") {
  norm <- read.csv(NORM, check.names = FALSE)
  tr <- setNames(norm$transformation_in_models[match(physio, norm$column_name)], physio); stopifnot(!anyNA(tr))
  for (o in physio) if (tr[o] == "Natural log") d[[o]] <- ifelse(is.finite(d[[o]]) & d[[o]] > 0, log(d[[o]]), NA)
  av <- tolower(as.character(d$empatica_hrv_fd_5min_available)) %in% c("true","1")
  for (v in physio[7:13]) d[[v]][!av] <- NA   # HRV frequency-domain 5-min window blanking
} else {
  # questionnaires are one value per participant x phase; no normalization rows exist -> raw values
  for (o in outcomes) stopifnot(all(tapply(d[[o]], paste(d$ParticipantID, d$PhaseID), function(z) length(unique(z))) == 1))
}
# Time10 = 10 s index from the first row of each participant x phase bout (computed on the full 4-phase data)
d$Datetime <- as.POSIXct(d$Datetime, tz = "UTC"); stopifnot(!anyNA(d$Datetime), !anyDuplicated(d[c("ParticipantID","PhaseID","Datetime")]))
d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), ]
bout0 <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
d$Time10 <- as.integer(round((as.numeric(d$Datetime) - ave(as.numeric(d$Datetime), bout0, FUN = min)) / 10))
if (DATASET == "UrbanOnly") d <- d[d$PhaseID %in% c("WalkU","BikeU"), ]

cell_id <- paste(d$ParticipantID, d$PhaseID)
all_cells <- data.frame(table(ParticipantID = d$ParticipantID, PhaseID = d$PhaseID)); names(all_cells)[3] <- "rows_total"
keep_row <- rep(TRUE, nrow(d))
if (FILTER != "NoFilter") {
  stopifnot(startsWith(FILTER, "UTCIgt"))
  thr <- as.numeric(sub("^UTCIgt", "", FILTER))
  keep_row <- is.finite(d$ucm_UTCI) & d$ucm_UTCI > thr
}
kept_cnt <- tapply(keep_row, cell_id, sum)
cells <- all_cells[all_cells$rows_total > 0, ]
cells$rows_after_filter <- as.integer(kept_cnt[paste(cells$ParticipantID, cells$PhaseID)])
cells$cell_kept <- if (FILTER == "NoFilter") TRUE else cells$rows_after_filter >= MIN_ROWS
keep_cell <- paste(cells$ParticipantID, cells$PhaseID)[cells$cell_kept]
d <- d[keep_row & cell_id %in% keep_cell, ]
cells$filter <- FILTER

# Sum-to-zero control columns
add_controls <- function(a) {
  ph <- as.character(a$PhaseID)
  a$EnvSumUrban <- ifelse(ph %in% c("WalkU","BikeU"), 1, -1)
  a$ModeSumWalk <- ifelse(ph %in% c("WalkU","WalkG"), 1, -1)
  a }
center <- function(x, g) { dev <- x - ave(x, g, FUN = mean); s <- sd(dev); if (is.finite(s) && s > 0) dev / s else dev }
# TS10s centring (H4_sound_core.R h4s_center): bout mean over finite values, one shared SD
center_bout <- function(x, g) { x[!is.finite(x)] <- NA_real_
  dev <- x - ave(x, g, FUN = function(v) mean(v, na.rm = TRUE)); s <- sd(dev[is.finite(dev)])
  if (is.finite(s) && s > 0) dev / s else dev }
rhs <- switch(MODEL, SoundPlusUTCI = "U + S", SoundOnly = "S")
rhs <- paste(rhs, switch(CONTROL, WithEnv = "+ EnvSumUrban", WithMode = "+ ModeSumWalk", NoMode = ""))
f <- as.formula(paste("Y ~", rhs))
terms_tested <- "sound"
coef_name <- c(sound = "S")

# TS10s fitter (H4_sound_core.R h4s_fit_time): nested participant/phase intercepts, AR(1) on Time10,
# ARMA(2,0) when AR(1) rho > 0.95, independent residuals only when AR(1) fails (then not inference eligible)
fit_time <- function(fml, data) {
  notes <- character()
  attempt <- function(correlation, label, opts = c("nlminb","optim")) {
    for (opt in opts) {
      fit <- tryCatch(withCallingHandlers(lme(fixed = fml, data = data,
        random = ~1 | ParticipantID/PhaseID, correlation = correlation, method = "REML", na.action = na.fail,
        control = lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)),
        warning = function(w) { notes <<- c(notes, paste(label, opt, conditionMessage(w))); invokeRestart("muffleWarning") }),
        error = function(e) { notes <<- c(notes, paste(label, opt, conditionMessage(e))); NULL })
      if (!is.null(fit)) return(fit)
    }
    NULL
  }
  fit <- attempt(corAR1(.2, form = ~Time10 | ParticipantID/PhaseID), "AR1"); structure <- "AR1"; rho <- NA_real_
  if (!is.null(fit)) {
    rho <- unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE))
    if (length(rho) == 1L && is.finite(rho) && rho > .95) {
      alt <- attempt(corARMA(c(.5, .2), form = ~Time10 | ParticipantID/PhaseID, p = 2, q = 0), "ARMA20")
      if (!is.null(alt)) { fit <- alt; structure <- "ARMA20" }
    }
  }
  if (is.null(fit)) { fit <- attempt(NULL, "independent_fallback", opts = "nlminb"); structure <- "independent_fallback" }
  list(fit = fit, structure = if (is.null(fit)) "not_fitted" else structure, notes = notes, rho = rho)
}

fit_one <- function(o, s) {
  out <- data.frame(outcome = o, sound_variable = s, term = terms_tested, n_cells = 0L, n_participants = 0L, n_rows = 0L,
    Beta = NA_real_, SE = NA_real_, df = NA_real_, p = NA_real_, min_df_model = NA_real_, singular_re = NA, note = "",
    residual_structure = "not_fitted", ar1_rho = NA_real_)
  valid <- is.finite(d[[o]]) & is.finite(d[[s]]) & is.finite(d$ucm_UTCI)
  if (!any(valid)) { out$note <- "no eligible rows"; return(out) }
  if (RESOLUTION == "PhaseMean") {
    e <- data.frame(d[valid, c("ParticipantID","PhaseID")], X = d[[s]][valid], Uraw = d$ucm_UTCI[valid], Y = d[[o]][valid])
    a <- aggregate(e[c("X","Uraw","Y")], e[c("ParticipantID","PhaseID")], mean)
    a$S <- center(a$X, a$ParticipantID); a$U <- center(a$Uraw, a$ParticipantID)
  } else {
    # whole-bout centring on all kept rows of the bout precedes outcome/sound row selection
    g <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
    a <- data.frame(d[, c("ParticipantID","PhaseID","Time10")], S = center_bout(d[[s]], g), U = center_bout(d$ucm_UTCI, g), Y = d[[o]])[valid, ]
    a$PhaseID <- factor(a$PhaseID, levels = c("WalkG","WalkU","BikeG","BikeU"))
    a <- a[order(a$ParticipantID, a$PhaseID, a$Time10), ]
  }
  a$ParticipantID <- factor(a$ParticipantID); a <- add_controls(a)
  out$n_cells <- nrow(unique(a[c("ParticipantID","PhaseID")])); out$n_participants <- nlevels(a$ParticipantID); out$n_rows <- sum(valid)
  X <- model.matrix(f, a)
  if (qr(X)$rank < ncol(X) || nrow(a) <= ncol(X)) { out$note <- "rank-deficient design or no residual df"; return(out) }
  notes <- character()
  if (RESOLUTION == "PhaseMean") {
    fit <- tryCatch(withCallingHandlers(lme(f, data = a, random = ~1 | ParticipantID, method = "REML", na.action = na.fail,
        control = lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)),
        warning = function(w) { notes <<- c(notes, conditionMessage(w)); invokeRestart("muffleWarning") }),
      error = function(err) { notes <<- c(notes, conditionMessage(err)); NULL })
    structure <- if (is.null(fit)) "not_fitted" else "phase_random_intercept"
  } else {
    fr <- fit_time(f, a); fit <- fr$fit; structure <- fr$structure; notes <- fr$notes
    if (length(fr$rho) == 1L) out$ar1_rho <- fr$rho
  }
  out$residual_structure <- structure
  if (is.null(fit)) { out$note <- gsub("\n", " ", paste(notes, collapse = "; ")); return(out) }
  rv <- suppressWarnings(as.numeric(VarCorr(fit)[, "Variance"])); out$singular_re <- any(rv[is.finite(rv)] < 1e-6 * sigma(fit)^2)
  ct <- tryCatch(coef_test(fit, vcov = "CR2", cluster = a$ParticipantID, test = "Satterthwaite"),
    error = function(err) { notes <<- c(notes, conditionMessage(err)); NULL })
  if (structure == "independent_fallback") notes <- c(notes, "AR1 failed; independent residuals; not inference eligible (p left blank)")
  out$note <- gsub("\n", " ", paste(unique(notes), collapse = "; "))
  if (is.null(ct)) return(out)
  out$min_df_model <- min(ct$df_Satt[rownames(ct) != "(Intercept)"])
  for (k in seq_len(nrow(out))) {
    i <- match(coef_name[out$term[k]], rownames(ct))
    out$Beta[k] <- ct$beta[i]; out$SE[k] <- ct$SE[i]; out$df[k] <- ct$df_Satt[i]
    if (structure != "independent_fallback" && is.finite(out$SE[k]) && out$SE[k] > 0 && is.finite(out$df[k]) && out$df[k] > 0)
      out$p[k] <- 2 * pt(-abs(out$Beta[k] / out$SE[k]), out$df[k])
  }
  out
}
jobs <- expand.grid(o = outcomes, s = sounds, stringsAsFactors = FALSE)
fits <- parallel::mclapply(seq_len(nrow(jobs)), function(i) fit_one(jobs$o[i], jobs$s[i]), mc.cores = WORKERS, mc.preschedule = FALSE)
stopifnot(all(vapply(fits, is.data.frame, logical(1))))
R <- do.call(rbind, fits)

# BH FDR per term: (a) within each sound variable across its K outcomes; (b) across all K x 24 tests. Failed tests count in n.
bh <- function(p, n) { q <- rep(NA_real_, length(p)); ok <- is.finite(p); q[ok] <- p.adjust(p[ok], "BH", n = n); q }
families <- if (OUTCOMES == "Physio") list(all26 = physio) else list(core4 = quest_core, ext10 = c(quest_core, quest_ext))
for (fam in names(families)) {
  qw <- rep(NA_real_, nrow(R)); qa <- rep(NA_real_, nrow(R)); K <- length(families[[fam]])
  for (t in unique(R$term)) {
    ix <- which(R$term == t & R$outcome %in% families[[fam]])
    qa[ix] <- bh(R$p[ix], K * length(sounds))
    for (s in sounds) { j <- ix[R$sound_variable[ix] == s]; qw[j] <- bh(R$p[j], K) }
  }
  R[[paste0("q_within_", fam)]] <- qw; R[[paste0("q_all_", fam)]] <- qa
}
# column "phase" holds the control label (WithEnv / WithMode / NoMode); data and resolution are appended at the end
extra <- c("residual_structure", "ar1_rho")
R <- cbind(outcomes_set = OUTCOMES, filter = FILTER, model = MODEL, phase = CONTROL, R[setdiff(names(R), extra)], R[extra],
  data = DATASET, resolution = RESOLUTION)

S <- do.call(rbind, lapply(names(families), function(fam) do.call(rbind, lapply(unique(R$term), function(t) {
  x <- R[R$term == t & R$outcome %in% families[[fam]], ]; f <- is.finite(x$p)
  qw <- x[[paste0("q_within_", fam)]]; qa <- x[[paste0("q_all_", fam)]]
  data.frame(outcomes_set = OUTCOMES, filter = FILTER, model = MODEL, phase = CONTROL,
    fdr_family = fam, K = length(families[[fam]]), term = t, planned_tests = nrow(x), tests_run = sum(f),
    n_q_within_lt05 = sum(qw < .05, na.rm = TRUE), n_q_all_lt05 = sum(qa < .05, na.rm = TRUE),
    min_q_within = if (any(f)) min(qw, na.rm = TRUE) else NA, min_q_all = if (any(f)) min(qa, na.rm = TRUE) else NA,
    n_raw_p_lt05 = sum(x$p < .05, na.rm = TRUE),
    df_min = if (any(f)) min(x$df[f]) else NA, df_max = if (any(f)) max(x$df[f]) else NA,
    n_models_min_df_lt4 = sum(x$min_df_model < 4, na.rm = TRUE),
    n_failed = sum(!f), n_singular_re = sum(x$singular_re, na.rm = TRUE),
    rows_kept = nrow(d), cells_kept = length(keep_cell), participants_kept = length(unique(d$ParticipantID)),
    n_cells_range = if (any(f)) paste(range(x$n_cells[f]), collapse = "-") else "",
    n_participants_range = if (any(f)) paste(range(x$n_participants[f]), collapse = "-") else "",
    data = DATASET, resolution = RESOLUTION,
    n_rows_range = if (any(f)) paste(range(x$n_rows[f]), collapse = "-") else "",
    n_independent_fallback = sum(x$residual_structure == "independent_fallback"),
    n_ARMA20 = sum(x$residual_structure == "ARMA20"))
}))))
write.csv(R, file.path(OUTDIR, "results.csv"), row.names = FALSE, na = "")
write.csv(S, file.path(OUTDIR, "summary.csv"), row.names = FALSE, na = "")
write.csv(cells[order(cells$ParticipantID, cells$PhaseID), ], file.path(OUTDIR, "cells.csv"), row.names = FALSE)
cat("done", OUTCOMES, DATASET, FILTER, MODEL, CONTROL, RESOLUTION, "\n")
