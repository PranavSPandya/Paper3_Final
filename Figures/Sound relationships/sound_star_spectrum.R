this_file <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
this_dir <- if (length(this_file)) dirname(normalizePath(this_file[1], winslash = "/", mustWork = TRUE)) else {
  normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}
find_root <- function(start) {
  d <- normalizePath(start, winslash = "/", mustWork = FALSE)
  for (i in 1:8) {
    if (file.exists(file.path(d, "output", "merged_all_11participants_8min.csv"))) return(d)
    parent <- dirname(d)
    if (identical(parent, d)) break
    d <- parent
  }
  stop("Cannot find Paper3_Final root (merged_all_11participants_8min.csv).")
}
PROJECT_ROOT <- normalizePath(commandArgs(TRUE)[1], mustWork = TRUE)
FIGURE_DIR <- file.path(PROJECT_ROOT, "Figures", "Sound relationships")
OUT_DIR <- commandArgs(TRUE)[2]
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

LIBRARY_DIR <- file.path(PROJECT_ROOT, "scripts", "statistical_analysis", "library")
source(file.path(LIBRARY_DIR, "Paper3_common.R"), local = FALSE)
paper3_entry_load_packages(required_packages = "nlme", load_packages = "nlme")

study_wide_spec <- paper3_attach_outcome_normalization(list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()), PROJECT_ROOT)

PHASES <- c("WalkG", "WalkU", "BikeG", "BikeU")
PHYSIO_ALL <- paper3_physiological_outcomes()
PSYCH_ALL <- paper3_psych_questionnaire_outcomes()

# Copied from library/H1_H3_core.R so this script does not take H1/H3 side effects.
model_data_ok <- function(data, min_rows, min_participants) {
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(data$model_y)) && sd(data$model_y) != 0
}
h1_h3_degenerate_fit <- function(t_table) {
  se <- t_table[, "Std.Error"]
  any(!is.finite(se)) || any(se > 10)
}
fit_ar1_with_fallback <- function(epoch_data, model_call) {
  ar1_formula <- formula(eval(model_call$correlation))
  fit_one <- function(optimizer, is_primary) {
    control_settings <- if (is_primary) {
      lmeControl(opt = "optim", maxIter = 200, msMaxIter = 200, returnObject = FALSE)
    } else {
      lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = optimizer)
    }
    ar1_correlation <- if (is_primary) corAR1(form = ar1_formula) else corAR1(value = 0.2, form = ar1_formula)
    model_call[[2L]][[2L]] <- as.name("model_y")
    model_call$data <- quote(epoch_data)
    model_call$correlation <- quote(ar1_correlation)
    model_call$na.action <- quote(na.omit)
    model_call$control <- quote(control_settings)
    tryCatch(eval(model_call), error = function(local_error) NULL)
  }
  fitted_model <- fit_one("optim", TRUE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "optim (primary)"))
  fitted_model <- fit_one("nlminb", FALSE)
  if (!is.null(fitted_model)) return(list(fit = fitted_model, method = "nlminb (fallback)"))
  list(fit = NULL, method = "none (not converged)")
}

PerPhase_AR1_10s_LMM <- quote(
  nlme::lme(
    model_y ~ dBA_z,
    data = epoch_data,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID),
    method = "REML"))

energy_mean_db <- function(level_db) {
  level_db <- as.numeric(level_db)
  level_db <- level_db[is.finite(level_db)]
  if (!length(level_db)) return(NA_real_)
  10 * log10(mean(10^(level_db / 10)))
}

phase_z <- function(x) {
  x <- as.numeric(x)
  s <- stats::sd(x[is.finite(x)])
  if (!is.finite(s) || s == 0) return(rep(NA_real_, length(x)))
  (x - mean(x, na.rm = TRUE)) / s
}

# Same matched 8 min 10 s table as H4_10s_sound_timeseries.R (Families D/E).
load_matched_route <- function() {
  route <- read.csv(paper3_merged_8min_path(PROJECT_ROOT), check.names = FALSE, stringsAsFactors = FALSE)
  route <- route[route$ParticipantID %in% study_wide_spec$participants & route$PhaseID %in% PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantID <- factor(route$ParticipantID, levels = study_wide_spec$participants)
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60
  route <- paper3_merge_common_cap(route, PHASES, study_wide_spec$matched_cap_sec)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  route <- paper3_add_pair_means(route, list(
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
    lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")))
  route$time_10s_step <- round(route$time_in_phase_sec / 10)
  route$time_10s_step_integer <- as.integer(route$time_10s_step)
  route$ucm_SND_dBA <- as.numeric(route$ucm_SND_dBA)
  route
}

# Domain lists: sensor name then variable (column_name). D's 8 env + H5 10 s extras
# that exist on the 10 s table (HUMIDEX, PET, RH, wind, kelvin). Not dBA.
ENV_VARS <- data.frame(
  domain = "env",
  sensor = c(
    "Atmotube", "GVI", "LYS", "LYS", "Sky-view",
    "UCM", "UCM", "UCM", "UCM", "UCM", "UCM", "UCM", "UCM"),
  variable = c(
    "PM2.5", "GVI", "Kelvin", "Lux", "SVF",
    "Air RH", "Air T", "HUMIDEX", "MRT", "PET", "Solar Gh", "UTCI", "Wind"),
  column_name = c(
    "atmo_pm2.5_avg", "gvi_50m", "lys_kelvin_avg", "lys_lux_avg", "SVF",
    "ucm_AIR_RH", "ucm_AIR_T_mid", "ucm_HUMIDEX", "ucm_MRT", "ucm_PET",
    "ucm_SUN_Gh", "ucm_UTCI", "ucm_WIND_AWS"),
  stringsAsFactors = FALSE)

physio_sensor <- function(col) if (startsWith(col, "empatica_")) "Empatica" else "Pupil Labs"
physio_label <- c(
  empatica_eda_phasic = "EDA phasic",
  empatica_eda_tonic = "EDA tonic",
  empatica_heart_rate = "Heart rate",
  empatica_hrv_fd_hf = "HF",
  empatica_hrv_fd_hfnu = "HFnu",
  empatica_hrv_fd_lf = "LF",
  empatica_hrv_fd_lf_hf_ratio = "LF/HF",
  empatica_hrv_fd_lfnu = "LFnu",
  empatica_hrv_fd_total_power = "Total power",
  empatica_hrv_fd_vlf = "VLF",
  empatica_hrv_td_rmssd = "RMSSD",
  empatica_hrv_td_sdnn = "SDNN",
  empatica_skin_temperature = "Skin T",
  eyetracker_blink_duration_s = "Blink dur.",
  eyetracker_distance_from_center = "Dist. center",
  eyetracker_eyelid_aperture_avg = "Eyelid ap.",
  eyetracker_fixation_duration_s = "Fix. dur.",
  eyetracker_fixation_rate = "Fix. rate",
  eyetracker_gaze_centrality = "Gaze centr.",
  eyetracker_gaze_dispersion = "Gaze disp.",
  eyetracker_gaze_velocity = "Gaze vel.",
  eyetracker_pupil_change_rate = "Pupil change",
  eyetracker_pupil_diameter_avg = "Pupil diam.",
  eyetracker_saccade_amplitude = "Sacc. amp.",
  eyetracker_saccade_duration_s = "Sacc. dur.",
  eyetracker_saccade_peak_velocity = "Sacc. peak vel.")
PHYSIO_VARS <- data.frame(
  domain = "physio",
  sensor = vapply(PHYSIO_ALL, physio_sensor, character(1)),
  variable = unname(physio_label[PHYSIO_ALL]),
  column_name = PHYSIO_ALL,
  stringsAsFactors = FALSE)
PHYSIO_VARS <- PHYSIO_VARS[order(PHYSIO_VARS$sensor, PHYSIO_VARS$column_name), ]

psych_meta <- list(
  questionnaire_acoustic_comfort_1_5 = c("Comfort", "Acoustic comfort"),
  questionnaire_air_quality_comfort_1_5 = c("Comfort", "Air-quality comfort"),
  questionnaire_current_comfort_1_7 = c("Comfort", "Overall comfort"),
  questionnaire_odor_comfort_1_5 = c("Comfort", "Odor comfort"),
  questionnaire_pleasantness_1_5 = c("Comfort", "Pleasantness"),
  questionnaire_space_familiarity_1_5 = c("Comfort", "Familiarity"),
  questionnaire_thermal_comfort_1_5 = c("Comfort", "Thermal comfort"),
  questionnaire_visual_comfort_1_5 = c("Comfort", "Visual comfort"),
  questionnaire_prs11_being_away_mean_1_5 = c("PRS-11", "Being away"),
  questionnaire_prs11_coherence_mean_1_5 = c("PRS-11", "Coherence"),
  questionnaire_prs11_fascination_mean_1_5 = c("PRS-11", "Fascination"),
  questionnaire_prs11_scope_mean_1_5 = c("PRS-11", "Scope"),
  questionnaire_stai_calm_rev_1_5 = c("STAI-6", "Calm (rev)"),
  questionnaire_stai_content_rev_1_5 = c("STAI-6", "Content (rev)"),
  questionnaire_stai_relaxed_rev_1_5 = c("STAI-6", "Relaxed (rev)"),
  questionnaire_stai_tense_1_5 = c("STAI-6", "Tense"),
  questionnaire_stai_upset_1_5 = c("STAI-6", "Upset"),
  questionnaire_stai_worried_1_5 = c("STAI-6", "Worried")
)
stopifnot(all(PSYCH_ALL %in% names(psych_meta)))
PSYCH_VARS <- do.call(rbind, lapply(PSYCH_ALL, function(col) {
  data.frame(domain = "psycho", sensor = psych_meta[[col]][1],
             variable = psych_meta[[col]][2], column_name = col, stringsAsFactors = FALSE)
}))
PSYCH_VARS <- PSYCH_VARS[order(PSYCH_VARS$sensor, PSYCH_VARS$column_name), ]

number_domain <- function(tab, prefix) {
  tab <- tab[order(tab$sensor, tab$column_name), ]
  tab$id <- paste0(prefix, ".", seq_len(nrow(tab)))
  tab$figure_label <- paste(tab$id, tab$variable)
  tab
}
ENV_VARS <- number_domain(ENV_VARS, "1")
PHYSIO_VARS <- number_domain(PHYSIO_VARS, "2")
PSYCH_VARS <- number_domain(PSYCH_VARS, "3")
VARIABLE_INDEX <- rbind(ENV_VARS, PHYSIO_VARS, PSYCH_VARS)
rownames(VARIABLE_INDEX) <- NULL

empty_result <- function(phase, meta, n_obs, n_id, model, family, status) {
  data.frame(
    phase = phase, domain = meta$domain, id = meta$id, sensor = meta$sensor,
    variable = meta$variable, label = meta$figure_label, column_name = meta$column_name,
    n_obs = n_obs, n_id = n_id, beta_std = NA_real_, se = NA_real_,
    p = NA_real_, q_FDR = NA_real_, significant = FALSE,
    model = model, family = family, status = status, family_size = NA_integer_,
    rho_spearman = NA_real_, p_spearman = NA_real_, p_ols = NA_real_,
    stringsAsFactors = FALSE)
}

fit_lme_spoke <- function(phase_df, meta, phase) {
  col <- meta$column_name
  y_raw <- as.numeric(phase_df[[col]])
  if (meta$domain == "physio") {
    y_raw <- paper3_apply_csv_transform(y_raw, col, study_wide_spec$outcome_transforms_csv)
  }
  y_z <- paper3_within_person_z(y_raw, phase_df$ParticipantID)
  need <- c("ParticipantID", "time_min", "time_10s_step_integer", "dBA_z")
  epoch <- phase_df
  epoch$model_y <- y_z
  keep <- complete.cases(epoch[, c(need, "model_y")])
  epoch <- epoch[keep, ]
  epoch <- epoch[order(epoch$ParticipantID, epoch$time_10s_step_integer), ]
  n_obs <- nrow(epoch)
  n_id <- length(unique(epoch$ParticipantID))
  if (!model_data_ok(epoch, 100, 8) || !is.finite(sd(epoch$dBA_z)) || sd(epoch$dBA_z) == 0) {
    return(empty_result(phase, meta, n_obs, n_id, "lme_ar1", paste0(if (meta$domain == "env") "1_env" else "2_physio"),
                       "INSUFFICIENT_DATA"))
  }
  fitted <- fit_ar1_with_fallback(epoch, PerPhase_AR1_10s_LMM)
  tt <- if (!is.null(fitted$fit)) summary(fitted$fit)$tTable else NULL
  status <- if (is.null(tt)) "NOT_FIT_NO_CONVERGENCE" else if (h1_h3_degenerate_fit(tt)) "DEGENERATE_FIT" else "FIT"
  if (is.null(tt) || !"dBA_z" %in% rownames(tt)) {
    return(empty_result(phase, meta, n_obs, n_id, "lme_ar1",
                       paste0(if (meta$domain == "env") "1_env" else "2_physio"), status))
  }
  p <- if (status == "FIT") tt["dBA_z", "p-value"] else NA_real_
  data.frame(
    phase = phase, domain = meta$domain, id = meta$id, sensor = meta$sensor,
    variable = meta$variable, label = meta$figure_label, column_name = meta$column_name,
    n_obs = n_obs, n_id = n_id,
    beta_std = unname(tt["dBA_z", "Value"]), se = unname(tt["dBA_z", "Std.Error"]),
    p = unname(p), q_FDR = NA_real_, significant = FALSE,
    model = "lme_ar1",
    family = if (meta$domain == "env") "1_env" else "2_physio",
    status = status, family_size = NA_integer_,
    rho_spearman = NA_real_, p_spearman = NA_real_, p_ols = NA_real_,
    stringsAsFactors = FALSE)
}

bout_vote <- function(phase_df, col, sound_column) {
  split_rows <- split(seq_len(nrow(phase_df)), phase_df$ParticipantID)
  do.call(rbind, lapply(split_rows, function(idx) {
    b <- phase_df[idx, ]
    vote <- as.numeric(b[[col]])
    vote <- vote[is.finite(vote)]
    data.frame(
      ParticipantID = as.character(b$ParticipantID[1]),
      dba = if (sound_column == "ucm_SND_dBA") energy_mean_db(b[[sound_column]]) else mean(b[[sound_column]], na.rm = TRUE),
      vote = if (length(vote)) vote[1] else NA_real_,
      stringsAsFactors = FALSE)
  }))
}

fit_psycho_spoke <- function(phase_df, meta, phase, sound_column) {
  cells <- bout_vote(phase_df, meta$column_name, sound_column)
  ok <- is.finite(cells$dba) & is.finite(cells$vote)
  cells <- cells[ok, ]
  n_obs <- nrow(cells)
  n_id <- length(unique(cells$ParticipantID))
  fam <- "3_psycho"
  vote_var <- if (n_obs >= 2) stats::sd(cells$vote) else NA_real_
  dba_var <- if (n_obs >= 2) stats::sd(cells$dba) else NA_real_
  if (n_obs < 6 || !is.finite(vote_var) || vote_var == 0 || !is.finite(dba_var) || dba_var == 0) {
    st <- if (is.finite(vote_var) && vote_var == 0) "CONSTANT" else "INSUFFICIENT_DATA"
    return(empty_result(phase, meta, n_obs, n_id, "spearman_ols", fam, st))
  }
  ct <- suppressWarnings(stats::cor.test(cells$vote, cells$dba, method = "spearman", exact = FALSE))
  cells$vote_z <- phase_z(cells$vote)
  cells$dba_z <- phase_z(cells$dba)
  fit <- stats::lm(vote_z ~ dba_z, data = cells)
  sm <- summary(fit)
  coefs <- sm$coefficients
  if (!"dba_z" %in% rownames(coefs)) {
    return(empty_result(phase, meta, n_obs, n_id, "spearman_ols", fam, "NOT_FIT_NO_CONVERGENCE"))
  }
  beta <- unname(coefs["dba_z", "Estimate"])
  se <- unname(coefs["dba_z", "Std. Error"])
  p_ols <- unname(coefs["dba_z", "Pr(>|t|)"])
  p_sp <- unname(ct$p.value)
  status <- if (!is.finite(se) || se > 10) "DEGENERATE_FIT" else "FIT"
  p_bh <- if (status == "FIT") p_sp else NA_real_
  data.frame(
    phase = phase, domain = meta$domain, id = meta$id, sensor = meta$sensor,
    variable = meta$variable, label = meta$figure_label, column_name = meta$column_name,
    n_obs = n_obs, n_id = n_id, beta_std = beta, se = se,
    p = p_bh, q_FDR = NA_real_, significant = FALSE,
    model = "spearman_ols", family = fam, status = status, family_size = NA_integer_,
    rho_spearman = unname(ct$estimate), p_spearman = p_sp, p_ols = p_ols,
    stringsAsFactors = FALSE)
}

bh_family <- function(tab) {
  ok <- tab$status == "FIT" & is.finite(tab$p)
  tab$q_FDR <- NA_real_
  tab$family_size <- NA_integer_
  n_ok <- sum(ok)
  if (n_ok) {
    tab$q_FDR[ok] <- p.adjust(tab$p[ok], method = "BH")
    tab$family_size[ok] <- n_ok
    tab$family_size[!ok] <- n_ok
  }
  tab$significant <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab
}

write_csv_safe <- function(obj, path) {
  ok <- tryCatch({
    write.csv(obj, path, row.names = FALSE)
    TRUE
  }, error = function(e) FALSE)
  if (!ok) {
    alt <- sub("\\.csv$", paste0("_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv"), path)
    write.csv(obj, alt, row.names = FALSE)
    cat("CSV locked; wrote", alt, "\n")
    return(alt)
  }
  path
}


route <- load_matched_route()
sound_columns <- c("ucm_SND_dBA", grep("^(freq_proportion_|octave_proportion_|spectral_)|_proportion$", names(route), value = TRUE))
sound_columns <- unique(sound_columns)
for (column in unique(c(sound_columns, ENV_VARS$column_name))) route[[column]] <- as.numeric(route[[column]])
rows <- list()
for (phase in PHASES) {
  cat("Fitting", phase, "with", length(sound_columns), "sound measures\n")
  flush.console()
  phase_data <- route[as.character(route$PhaseID) == phase, ]
  for (column in sound_columns) {
    phase_data$dBA_z <- phase_z(phase_data[[column]])
    fits <- c(
      lapply(seq_len(nrow(ENV_VARS)), function(i) fit_lme_spoke(phase_data, ENV_VARS[i, ], phase)),
      lapply(seq_len(nrow(PHYSIO_VARS)), function(i) fit_lme_spoke(phase_data, PHYSIO_VARS[i, ], phase)),
      lapply(seq_len(nrow(PSYCH_VARS)), function(i) fit_psycho_spoke(phase_data, PSYCH_VARS[i, ], phase, column)))
    result <- do.call(rbind, fits)
    result$sound_measure <- column
    rows[[length(rows) + 1L]] <- result
  }
}
results <- do.call(rbind, rows)
results <- do.call(rbind, lapply(split(results, list(results$phase, results$family)), bh_family))
write.csv(results, file.path(OUT_DIR, "sound_spectrum_spokes.csv"), row.names = FALSE)
print(with(results, table(phase, family, significant)))
