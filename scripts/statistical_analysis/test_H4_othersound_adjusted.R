# test_H4_othersound_adjusted.R — Rodrigues-style trip LMMs with trip-level environment covariates.
# Companion to test_H4_othersound.R (unadjusted pilot). Does not modify locked H4 files.
# Run: Rscript scripts/statistical_analysis/test_H4_othersound_adjusted.R

options(stringsAsFactors = FALSE)
.entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop("Run with Rscript on this file")
.entry <- normalizePath(.entry[1], winslash = "/", mustWork = TRUE)
.common <- file.path(dirname(.entry), "library", "Paper3_common.R")
.h4_helpers <- file.path(dirname(.entry), "library", "H4_sound_literature_helpers.R")
source(.common, local = FALSE)
source(.h4_helpers, local = FALSE)
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
suppressPackageStartupMessages(library(nlme))

root <- resolve_project_root()
outdir <- file.path(root, "output", "statistical_analysis", "results", "H4_othersound_pilot", "adjusted")
unadj_dir <- file.path(root, "output", "statistical_analysis", "results", "H4_othersound_pilot")
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

ENV_COVARIATE_EPOCH_COLUMNS <- c("ucm_UTCI", "lys_lux_avg", "SVF", "ucm_WIND_AWS")
LYS_LUX_SOURCE_COLUMNS <- c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
EPOCH_FINITE_MIN_FRAC <- 0.30
TRIP_FINITE_MIN_FRAC <- 0.50
TRIP_SD_MIN <- 1e-8

normalize_sound_schema <- function(df) {
  renames <- c(
    spectral_centroid_Hz = "spectral_centroid_hz",
    dominant_frequency_Hz = "dominant_frequency_hz",
    spectral_rolloff85_Hz = "spectral_rolloff85_hz",
    octave_proportion_31_5_Hz = "octave_proportion_31.25Hz",
    octave_proportion_63_0_Hz = "octave_proportion_62.5Hz",
    octave_proportion_125_0_Hz = "octave_proportion_125Hz",
    octave_proportion_250_0_Hz = "octave_proportion_250Hz",
    octave_proportion_500_0_Hz = "octave_proportion_500Hz",
    octave_proportion_1000_0_Hz = "octave_proportion_1000Hz",
    octave_proportion_2000_0_Hz = "octave_proportion_2000Hz",
    octave_proportion_4000_0_Hz = "octave_proportion_4000Hz",
    octave_proportion_8000_0_Hz = "octave_proportion_8000Hz")
  for (old_nm in names(renames)) {
    if (old_nm %in% names(df) && !renames[[old_nm]] %in% names(df)) {
      names(df)[names(df) == old_nm] <- renames[[old_nm]]
    }
  }
  df
}

derive_lys_lux_avg <- function(epochs) {
  if ("lys_lux_avg" %in% names(epochs)) return(epochs)
  if (!all(LYS_LUX_SOURCE_COLUMNS %in% names(epochs))) return(epochs)
  epochs$lys_lux_avg <- rowMeans(epochs[, LYS_LUX_SOURCE_COLUMNS, drop = FALSE], na.rm = TRUE)
  epochs
}

select_env_covariates <- function(epochs, trip_summaries) {
  notes <- list()
  kept <- character(0)
  for (col in ENV_COVARIATE_EPOCH_COLUMNS) {
    if (col == "lys_lux_avg" && !col %in% names(epochs)) {
      notes[[col]] <- "missing in 8-min merge (LYS bilateral sources absent)"
      next
    }
    if (!col %in% names(epochs)) {
      notes[[col]] <- "missing column in 8-min merge"
      next
    }
    epoch_finite_frac <- mean(is.finite(epochs[[col]]))
    if (!is.finite(epoch_finite_frac) || epoch_finite_frac < EPOCH_FINITE_MIN_FRAC) {
      notes[[col]] <- sprintf(
        "too sparse at epoch level (%.1f%% finite; min %.0f%%)",
        100 * epoch_finite_frac, 100 * EPOCH_FINITE_MIN_FRAC)
      next
    }
    trip_col <- paste0(col, "__mean")
    if (!trip_col %in% names(trip_summaries)) {
      notes[[col]] <- "trip mean not computed"
      next
    }
    trip_vals <- trip_summaries[[trip_col]]
    trip_finite_frac <- mean(is.finite(trip_vals))
    trip_sd <- sd(trip_vals, na.rm = TRUE)
    if (!is.finite(trip_finite_frac) || trip_finite_frac < TRIP_FINITE_MIN_FRAC) {
      notes[[col]] <- sprintf(
        "too sparse at trip level (%.1f%% finite trips; min %.0f%%)",
        100 * trip_finite_frac, 100 * TRIP_FINITE_MIN_FRAC)
      next
    }
    if (!is.finite(trip_sd) || trip_sd < TRIP_SD_MIN) {
      notes[[col]] <- "zero variance at trip level (cannot z-score)"
      next
    }
    kept <- c(kept, col)
    notes[[col]] <- "included (trip mean z-scored in model)"
  }
  list(
    env_cols = kept,
    manifest = data.frame(
      covariate = ENV_COVARIATE_EPOCH_COLUMNS,
      status = ifelse(ENV_COVARIATE_EPOCH_COLUMNS %in% kept, "included", "dropped"),
      reason = vapply(ENV_COVARIATE_EPOCH_COLUMNS, function(c) notes[[c]] %||% "", character(1)),
      stringsAsFactors = FALSE))
}

`%||%` <- function(x, y) if (is.null(x) || length(x) == 0L) y else x

SOUND_CATEGORY_COLUMNS <- c(
  "wind_proportion", "rural_natural_proportion", "vehicle_proportion",
  "urban_manmade_neutral_proportion", "urban_manmade_positive_proportion",
  "urban_manmade_negative_proportion", "mechanisms_proportion", "unidentify_proportion")
SOUND_SPECTRAL_COLUMNS <- c(
  "dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz",
  "freq_proportion_20_to_200Hz", "freq_proportion_200_to_2000Hz", "freq_proportion_2000_to_20000Hz",
  "octave_proportion_31.25Hz", "octave_proportion_62.5Hz", "octave_proportion_125Hz",
  "octave_proportion_250Hz", "octave_proportion_500Hz", "octave_proportion_1000Hz",
  "octave_proportion_2000Hz", "octave_proportion_4000Hz", "octave_proportion_8000Hz")

build_trip_summaries_with_sound_and_env <- function(epochs, outcomes, participant_phase_bout, sound_cols, env_cols) {
  do.call(rbind, lapply(split(seq_len(nrow(epochs)), participant_phase_bout), function(ix) {
    trip_row <- data.frame(
      ParticipantID = epochs$ParticipantID[ix[1]],
      PhaseID = epochs$PhaseID[ix[1]],
      stringsAsFactors = FALSE)
    for (sc in sound_cols) {
      v <- epochs[[sc]][ix]
      trip_row[[paste0(sc, "__mean")]] <- mean(v, na.rm = TRUE)
      trip_row[[paste0(sc, "__max")]] <- max(v, na.rm = TRUE)
      trip_row[[paste0(sc, "__sd")]] <- sd(v, na.rm = TRUE)
    }
    for (ec in env_cols) {
      v <- epochs[[ec]][ix]
      trip_row[[paste0(ec, "__mean")]] <- mean(v, na.rm = TRUE)
    }
    for (outcome_name in outcomes) {
      bout_outcome <- epochs[[paste0(outcome_name, "__tr")]][ix]
      trip_row[[paste0(outcome_name, "__mean")]] <- mean(bout_outcome, na.rm = TRUE)
    }
    trip_row
  }))
}

rodrigues_lme_rows_adjusted <- function(
    trip_summaries, lme_optim_control, covariate_block, outcome_aggregation,
    outcome_name, trip_outcome_column, z_scored_terms, env_z_terms) {
  sound_fixed <- z_scored_terms
  env_fixed <- env_z_terms
  all_fixed <- c(sound_fixed, env_fixed)
  formula_str <- paste0("`", trip_outcome_column, "` ~ ", paste(all_fixed, collapse = " + "))
  mixed_model_fit <- tryCatch(
    lme(as.formula(formula_str),
      data = trip_summaries, random = ~ 1 | ParticipantID, method = "REML",
      na.action = na.omit, control = lme_optim_control),
    error = function(local_error) local_error)
  base <- data.frame(
    block = covariate_block, outcome_summary = outcome_aggregation, outcome = outcome_name,
    term = z_scored_terms, beta = NA, se = NA, z = NA, p = NA, n_obs = NA, note = "",
    stringsAsFactors = FALSE)
  if (inherits(mixed_model_fit, "error")) {
    base$note <- conditionMessage(mixed_model_fit)
    return(base)
  }
  coef_table <- summary(mixed_model_fit)$tTable
  if (is.null(rownames(coef_table))) {
    base$note <- "empty coefficient table (possible rank deficiency)"
    return(base)
  }
  missing_sound <- setdiff(sound_fixed, rownames(coef_table))
  if (length(missing_sound) > 0L) {
    base$note <- paste0(
      "rank deficiency: sound term(s) dropped from fit: ",
      paste(missing_sound, collapse = ", "))
  }
  for (i in seq_along(z_scored_terms)) {
    tn <- z_scored_terms[i]
    if (!tn %in% rownames(coef_table)) next
    base$beta[i] <- coef_table[tn, "Value"]
    base$se[i] <- coef_table[tn, "Std.Error"]
    base$z[i] <- coef_table[tn, "Value"] / coef_table[tn, "Std.Error"]
    base$p[i] <- 2 * pnorm(-abs(base$z[i]))
  }
  base$n_obs <- nobs(mixed_model_fit)
  base
}

run_rodrigues_sound_pilot_adjusted <- function(
    trip_summaries, outcomes, sound_col, env_z_terms, lme_optim_control) {
  terms <- c(
    paste0(sound_col, "__mean"),
    paste0(sound_col, "__max"),
    paste0(sound_col, "__sd"))
  for (tn in terms) trip_summaries[[paste0(tn, "_z")]] <- z_score(trip_summaries[[tn]])
  z_terms <- paste0(terms, "_z")
  do.call(rbind, lapply(outcomes, function(outcome_name) {
    rodrigues_lme_rows_adjusted(
      trip_summaries, lme_optim_control, sound_col, "mean",
      outcome_name, paste0(outcome_name, "__mean"), z_terms, env_z_terms)
  }))
}

family_q_counts <- function(results, sound_families) {
  do.call(rbind, lapply(names(sound_families), function(fam) {
    sub <- results[results$sound_family == fam, ]
    data.frame(
      sound_family = fam,
      n_q_lt_0.05 = sum(sub$sig_q05, na.rm = TRUE),
      stringsAsFactors = FALSE)
  }))
}

compare_unadjusted_hits <- function(unadj, adj) {
  hits <- unadj[is.finite(unadj$q_BH_26_per_term) & unadj$q_BH_26_per_term < 0.05, ]
  hits <- hits[order(hits$q_BH_26_per_term), ]
  key_cols <- c("sound_column", "outcome", "term")
  adj_key <- adj[, c(key_cols, "beta", "p", "q_BH_26_per_term", "note")]
  names(adj_key)[4:7] <- c("beta_adjusted", "p_adjusted", "q_adjusted", "note_adjusted")
  merged <- merge(
    hits[, c(key_cols, "sound_family", "outcome_summary", "beta", "p", "q_BH_26_per_term")],
    adj_key, by = key_cols, all.x = TRUE)
  names(merged)[names(merged) == "beta"] <- "beta_unadjusted"
  names(merged)[names(merged) == "p"] <- "p_unadjusted"
  names(merged)[names(merged) == "q_BH_26_per_term"] <- "q_unadjusted"
  merged$survives_q05_adjusted <- is.finite(merged$q_adjusted) & merged$q_adjusted < 0.05
  merged$beta_shrinkage_ratio <- ifelse(
    is.finite(merged$beta_unadjusted) & merged$beta_unadjusted != 0 & is.finite(merged$beta_adjusted),
    merged$beta_adjusted / merged$beta_unadjusted, NA_real_)
  merged
}

t0 <- proc.time()
outcomes <- paper3_physiological_outcomes()
transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
input <- paper3_merged_8min_path(root)
epochs <- read.csv(input, check.names = FALSE)
epochs <- normalize_sound_schema(epochs)
epochs <- derive_lys_lux_avg(epochs)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% PAPER3_CORE_PHASES, , drop = FALSE]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = "UTC")
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
hrv_window_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c("true", "1")
for (column_name in attr(outcomes, "empatica_hrv_fd_window")) {
  epochs[[column_name]][!hrv_window_available] <- NA_real_
}
participant_phase_bout <- interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)
for (local_outcome in outcomes) {
  epochs[[paste0(local_outcome, "__tr")]] <- paper3_apply_csv_transform(
    epochs[[local_outcome]], local_outcome, transforms)
}
lme_optim_control <- nlme::lmeControl(opt = "optim")

present <- function(cols) intersect(cols, names(epochs))
sound_families <- list(
  sound_level_reference = c("ucm_SND_dBA"),
  sound_category_proportion = present(SOUND_CATEGORY_COLUMNS),
  sound_spectral_descriptor = present(SOUND_SPECTRAL_COLUMNS))
sound_families <- sound_families[vapply(sound_families, length, 0L) > 0L]

all_sound_cols <- unique(unlist(sound_families))
trip_summaries <- build_trip_summaries_with_sound_and_env(
  epochs, outcomes, participant_phase_bout, all_sound_cols, ENV_COVARIATE_EPOCH_COLUMNS)
env_sel <- select_env_covariates(epochs, trip_summaries)
env_cols <- env_sel$env_cols
for (ec in env_cols) {
  trip_col <- paste0(ec, "__mean")
  trip_summaries[[paste0(ec, "__mean_z")]] <- z_score(trip_summaries[[trip_col]])
}
env_z_terms <- paste0(env_cols, "__mean_z")

pilot_rows <- list()
for (fam in names(sound_families)) {
  for (sc in sound_families[[fam]]) {
    block <- run_rodrigues_sound_pilot_adjusted(
      trip_summaries, outcomes, sc, env_z_terms, lme_optim_control)
    block$sound_family <- fam
    block$sound_column <- sc
    block$template <- "Rodrigues2026_noise_block_trip_mean_outcome_env_adjusted"
    block$env_covariates_in_model <- paste(env_cols, collapse = ";")
    pilot_rows[[paste(fam, sc, sep = "/")]] <- block
  }
}
results <- do.call(rbind, pilot_rows)
rownames(results) <- NULL
results$q_BH_26_per_term <- ave(
  results$p, results$sound_family, results$sound_column, results$term, FUN = benjamini_hochberg)
results$sig_p05 <- is.finite(results$p) & results$p < 0.05
results$sig_q05 <- is.finite(results$q_BH_26_per_term) & results$q_BH_26_per_term < 0.05

family_summary <- do.call(rbind, lapply(names(sound_families), function(fam) {
  sub <- results[results$sound_family == fam, ]
  data.frame(
    sound_family = fam,
    n_sound_columns = length(sound_families[[fam]]),
    n_tests = nrow(sub),
    n_fit = sum(is.finite(sub$p)),
    n_failed = sum(sub$note != "" & !is.na(sub$note)),
    n_p_lt_0.05 = sum(sub$sig_p05, na.rm = TRUE),
    n_q_lt_0.05 = sum(sub$sig_q05, na.rm = TRUE),
    env_covariates = paste(env_cols, collapse = ";"),
    stringsAsFactors = FALSE)
}))

column_summary <- do.call(rbind, lapply(split(results, results$sound_column), function(sub) {
  data.frame(
    sound_family = sub$sound_family[1],
    sound_column = sub$sound_column[1],
    n_tests = nrow(sub),
    n_p_lt_0.05 = sum(sub$sig_p05, na.rm = TRUE),
    n_q_lt_0.05 = sum(sub$sig_q05, na.rm = TRUE),
    stringsAsFactors = FALSE)
}))

runtime_sec <- (proc.time() - t0)[["elapsed"]]
runtime_notes <- data.frame(
  metric = c("runtime_sec", "n_trips", "n_env_covariates", "n_models_failed", "n_models_rank_note"),
  value = c(
    runtime_sec, nrow(trip_summaries), length(env_cols),
    sum(results$note != "" & !is.na(results$note)),
    sum(grepl("rank deficiency", results$note, ignore.case = TRUE))),
  stringsAsFactors = FALSE)

write.csv(results, file.path(outdir, "pilot_rodrigues_all_terms_env_adjusted.csv"), row.names = FALSE, na = "")
write.csv(family_summary, file.path(outdir, "FDR_summary_by_sound_family.csv"), row.names = FALSE, na = "")
write.csv(column_summary, file.path(outdir, "FDR_summary_by_sound_column.csv"), row.names = FALSE, na = "")
write.csv(env_sel$manifest, file.path(outdir, "env_covariate_manifest.csv"), row.names = FALSE, na = "")
write.csv(runtime_notes, file.path(outdir, "runtime_diagnostics.csv"), row.names = FALSE, na = "")

unadj_path <- file.path(unadj_dir, "pilot_rodrigues_all_terms.csv")
if (file.exists(unadj_path)) {
  unadj <- read.csv(unadj_path, stringsAsFactors = FALSE)
  unadj_fam <- read.csv(file.path(unadj_dir, "FDR_summary_by_sound_family.csv"), stringsAsFactors = FALSE)
  adj_fam <- family_q_counts(results, sound_families)
  fam_compare <- merge(
    unadj_fam[, c("sound_family", "n_q_lt_0.05")],
    adj_fam, by = "sound_family", suffixes = c("_unadjusted", "_adjusted"))
  write.csv(fam_compare, file.path(outdir, "compare_family_q_lt_0.05.csv"), row.names = FALSE, na = "")

  hit_compare <- compare_unadjusted_hits(unadj, results)
  write.csv(hit_compare, file.path(outdir, "unadjusted_hits_vs_adjusted.csv"), row.names = FALSE, na = "")
  survivors <- hit_compare[hit_compare$survives_q05_adjusted, ]
  write.csv(survivors, file.path(outdir, "unadjusted_hits_survivors_q05.csv"), row.names = FALSE, na = "")

  top10 <- head(hit_compare[order(hit_compare$q_unadjusted), ], 10L)
  top10$abs_beta_unadjusted <- abs(top10$beta_unadjusted)
  top10$abs_beta_adjusted <- abs(top10$beta_adjusted)
  top10$abs_shrinkage_ratio <- ifelse(
    is.finite(top10$abs_beta_unadjusted) & top10$abs_beta_unadjusted > 0 & is.finite(top10$abs_beta_adjusted),
    top10$abs_beta_adjusted / top10$abs_beta_unadjusted, NA_real_)
  write.csv(
    top10[, c("sound_family", "sound_column", "outcome", "term", "q_unadjusted",
      "beta_unadjusted", "beta_adjusted", "beta_shrinkage_ratio", "abs_shrinkage_ratio",
      "q_adjusted", "survives_q05_adjusted")],
    file.path(outdir, "top10_unadjusted_hits_shrinkage.csv"), row.names = FALSE, na = "")
}

cat("H4 other-sound environment-adjusted pilot complete.\n")
cat("Env covariates in model:", paste(env_cols, collapse = ", "), "\n")
print(family_summary[, c("sound_family", "n_q_lt_0.05")])
cat("Runtime (sec):", round(runtime_sec, 1), "\n")
cat("Outputs:", outdir, "\n")
