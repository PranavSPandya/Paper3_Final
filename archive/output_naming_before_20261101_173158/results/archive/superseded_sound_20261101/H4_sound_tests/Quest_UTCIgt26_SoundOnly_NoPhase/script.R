# H4 sound phase-mean test. Parameters for THIS folder's test:
OUTCOMES <- "Quest"   # "Physio" (26 physiological) or "Quest" (Paper 3 questionnaires)
FILTER   <- "UTCIgt26"     # "NoFilter", "dBAgtNN" (ucm_SND_dBA > NN) or "UTCIgtNN" (ucm_UTCI > NN)
MODEL    <- "SoundOnly"      # "SoundPlusUTCI" (Y ~ S + UTCI), "SoundxUTCI" (Y ~ UTCI * S), "SoundOnly" (Y ~ S)
PHASE    <- FALSE        # TRUE adds sum-to-zero PhaseID contrasts
# Inputs (read-only). Override with environment variables when running elsewhere.
DATA     <- Sys.getenv("P3_DATA", "C:/Users/sanga/Documents/Codex/p3h/output/merged_all_11participants_8min.csv")
NORM     <- Sys.getenv("P3_NORM", "C:/Users/sanga/Desktop/Pranav Paper3_Final/output/statistical_analysis/Normalization & Parameter Screening/Normalization/Normalization_H1toH4_all_parameters.csv")
FORMULAS <- Sys.getenv("P3_FORMULAS", "C:/Users/sanga/Desktop/Pranav Paper3_Final/output/statistical_analysis/results/H4_timeseries_sound/H4_sound_Eq1_formulas.csv")
OUTDIR   <- Sys.getenv("P3_OUTDIR", ".")
MIN_ROWS <- 6L   # cells (participant x phase) need >= 6 kept 10 s rows when a row filter is applied

if (dir.exists("~/R/library")) .libPaths(c("~/R/library", .libPaths()))
suppressPackageStartupMessages({ library(nlme); library(clubSandwich) })
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
cell_id <- paste(d$ParticipantID, d$PhaseID)
all_cells <- data.frame(table(ParticipantID = d$ParticipantID, PhaseID = d$PhaseID)); names(all_cells)[3] <- "rows_total"
keep_row <- rep(TRUE, nrow(d))
if (FILTER != "NoFilter") {
  var <- if (startsWith(FILTER, "dBAgt")) "ucm_SND_dBA" else "ucm_UTCI"
  thr <- as.numeric(sub("^(dBA|UTCI)gt", "", FILTER))
  keep_row <- is.finite(d[[var]]) & d[[var]] > thr
}
kept_cnt <- tapply(keep_row, cell_id, sum)
cells <- all_cells[all_cells$rows_total > 0, ]
cells$rows_after_filter <- as.integer(kept_cnt[paste(cells$ParticipantID, cells$PhaseID)])
cells$cell_kept <- if (FILTER == "NoFilter") TRUE else cells$rows_after_filter >= MIN_ROWS
keep_cell <- paste(cells$ParticipantID, cells$PhaseID)[cells$cell_kept]
d <- d[keep_row & cell_id %in% keep_cell, ]
cells$filter <- FILTER

phase_design <- function(phase) { phase <- factor(as.character(phase), levels = c("WalkG","WalkU","BikeG","BikeU"))
  m <- model.matrix(~phase, contrasts.arg = list(phase = contr.sum(4L)))[, -1, drop = FALSE]
  colnames(m) <- c("PhaseSumWalkG","PhaseSumWalkU","PhaseSumBikeG"); m }
center <- function(x, g) { dev <- x - ave(x, g, FUN = mean); s <- sd(dev); if (is.finite(s) && s > 0) dev / s else dev }
terms_tested <- switch(MODEL, SoundPlusUTCI = "sound", SoundOnly = "sound", SoundxUTCI = c("sound", "UTCIxsound"))
coef_name <- c(sound = "S", UTCIxsound = "U:S")

fit_one <- function(o, s) {
  out <- data.frame(outcome = o, sound_variable = s, term = terms_tested, n_cells = 0L, n_participants = 0L, n_rows = 0L,
    Beta = NA_real_, SE = NA_real_, df = NA_real_, p = NA_real_, min_df_model = NA_real_, singular_re = NA, note = "")
  valid <- is.finite(d[[o]]) & is.finite(d[[s]]) & is.finite(d$ucm_UTCI)
  if (!any(valid)) { out$note <- "no eligible rows"; return(out) }
  e <- data.frame(d[valid, c("ParticipantID","PhaseID")], X = d[[s]][valid], Uraw = d$ucm_UTCI[valid], Y = d[[o]][valid])
  a <- aggregate(e[c("X","Uraw","Y")], e[c("ParticipantID","PhaseID")], mean)
  a$S <- center(a$X, a$ParticipantID); a$U <- center(a$Uraw, a$ParticipantID)
  a$ParticipantID <- factor(a$ParticipantID); a <- cbind(a, phase_design(a$PhaseID))
  out$n_cells <- nrow(a); out$n_participants <- nlevels(a$ParticipantID); out$n_rows <- sum(valid)
  rhs <- switch(MODEL, SoundPlusUTCI = "U + S", SoundxUTCI = "U * S", SoundOnly = "S")
  if (PHASE) rhs <- paste(rhs, "+ PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG")
  f <- as.formula(paste("Y ~", rhs)); X <- model.matrix(f, a)
  if (qr(X)$rank < ncol(X) || nrow(a) <= ncol(X)) { out$note <- "rank-deficient design or no residual df"; return(out) }
  notes <- character()
  fit <- tryCatch(withCallingHandlers(lme(f, data = a, random = ~1 | ParticipantID, method = "REML", na.action = na.fail,
      control = lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)),
      warning = function(w) { notes <<- c(notes, conditionMessage(w)); invokeRestart("muffleWarning") }),
    error = function(err) { notes <<- c(notes, conditionMessage(err)); NULL })
  if (is.null(fit)) { out$note <- gsub("\n", " ", paste(notes, collapse = "; ")); return(out) }
  rv <- as.numeric(VarCorr(fit)[, "Variance"]); out$singular_re <- any(rv[is.finite(rv)] < 1e-6 * sigma(fit)^2)
  ct <- tryCatch(coef_test(fit, vcov = "CR2", cluster = a$ParticipantID, test = "Satterthwaite"),
    error = function(err) { notes <<- c(notes, conditionMessage(err)); NULL })
  out$note <- gsub("\n", " ", paste(unique(notes), collapse = "; "))
  if (is.null(ct)) return(out)
  out$min_df_model <- min(ct$df_Satt[rownames(ct) != "(Intercept)"])
  for (k in seq_len(nrow(out))) {
    i <- match(coef_name[out$term[k]], rownames(ct))
    out$Beta[k] <- ct$beta[i]; out$SE[k] <- ct$SE[i]; out$df[k] <- ct$df_Satt[i]
    if (is.finite(out$SE[k]) && out$SE[k] > 0 && is.finite(out$df[k]) && out$df[k] > 0)
      out$p[k] <- 2 * pt(-abs(out$Beta[k] / out$SE[k]), out$df[k])
  }
  out
}
R <- do.call(rbind, lapply(sounds, function(s) do.call(rbind, lapply(outcomes, function(o) fit_one(o, s)))))

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
R <- cbind(outcomes_set = OUTCOMES, filter = FILTER, model = MODEL, phase = ifelse(PHASE, "WithPhase", "NoPhase"), R)

S <- do.call(rbind, lapply(names(families), function(fam) do.call(rbind, lapply(unique(R$term), function(t) {
  x <- R[R$term == t & R$outcome %in% families[[fam]], ]; f <- is.finite(x$p)
  qw <- x[[paste0("q_within_", fam)]]; qa <- x[[paste0("q_all_", fam)]]
  data.frame(outcomes_set = OUTCOMES, filter = FILTER, model = MODEL, phase = ifelse(PHASE, "WithPhase", "NoPhase"),
    fdr_family = fam, K = length(families[[fam]]), term = t, planned_tests = nrow(x), tests_run = sum(f),
    n_q_within_lt05 = sum(qw < .05, na.rm = TRUE), n_q_all_lt05 = sum(qa < .05, na.rm = TRUE),
    min_q_within = if (any(f)) min(qw, na.rm = TRUE) else NA, min_q_all = if (any(f)) min(qa, na.rm = TRUE) else NA,
    n_raw_p_lt05 = sum(x$p < .05, na.rm = TRUE),
    df_min = if (any(f)) min(x$df[f]) else NA, df_max = if (any(f)) max(x$df[f]) else NA,
    n_models_min_df_lt4 = sum(x$min_df_model < 4, na.rm = TRUE),
    n_failed = sum(!f), n_singular_re = sum(x$singular_re, na.rm = TRUE),
    rows_kept = nrow(d), cells_kept = length(keep_cell), participants_kept = length(unique(d$ParticipantID)),
    n_cells_range = if (any(f)) paste(range(x$n_cells[f]), collapse = "-") else "",
    n_participants_range = if (any(f)) paste(range(x$n_participants[f]), collapse = "-") else "")
}))))
write.csv(R, file.path(OUTDIR, "results.csv"), row.names = FALSE, na = "")
write.csv(S, file.path(OUTDIR, "summary.csv"), row.names = FALSE, na = "")
write.csv(cells[order(cells$ParticipantID, cells$PhaseID), ], file.path(OUTDIR, "cells.csv"), row.names = FALSE)
cat("done", OUTCOMES, FILTER, MODEL, PHASE, "\n")
