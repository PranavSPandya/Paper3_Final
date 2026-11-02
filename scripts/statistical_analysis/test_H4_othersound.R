# test_H4_othersound.R — feasibility pilot: Rodrigues-style trip LMMs on non-dBA sound descriptors.
# Does not modify H4_sound_literature_tests.R. Reuses helpers only.
# Run: Rscript scripts/statistical_analysis/test_H4_othersound.R

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
outdir <- file.path(root, "output", "statistical_analysis", "results", "H4_othersound_pilot")
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

# Align merge column names with Analysis_combined_core (Hz suffix variants).
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

build_trip_summaries_with_sound <- function(epochs, outcomes, participant_phase_bout, sound_cols) {
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
    for (outcome_name in outcomes) {
      bout_outcome <- epochs[[paste0(outcome_name, "__tr")]][ix]
      trip_row[[paste0(outcome_name, "__mean")]] <- mean(bout_outcome, na.rm = TRUE)
    }
    trip_row
  }))
}

run_rodrigues_sound_pilot <- function(trip_summaries, outcomes, sound_col, lme_optim_control) {
  terms <- c(
    paste0(sound_col, "__mean"),
    paste0(sound_col, "__max"),
    paste0(sound_col, "__sd"))
  for (tn in terms) trip_summaries[[paste0(tn, "_z")]] <- z_score(trip_summaries[[tn]])
  z_terms <- paste0(terms, "_z")
  do.call(rbind, lapply(outcomes, function(outcome_name) {
    rodrigues_lme_rows(
      trip_summaries, lme_optim_control, sound_col, "mean",
      outcome_name, paste0(outcome_name, "__mean"), z_terms)
  }))
}

outcomes <- paper3_physiological_outcomes()
transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
input <- paper3_merged_8min_path(root)
epochs <- read.csv(input, check.names = FALSE)
epochs <- normalize_sound_schema(epochs)
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
trip_summaries <- build_trip_summaries_with_sound(epochs, outcomes, participant_phase_bout, all_sound_cols)

pilot_rows <- list()
for (fam in names(sound_families)) {
  for (sc in sound_families[[fam]]) {
    block <- run_rodrigues_sound_pilot(trip_summaries, outcomes, sc, lme_optim_control)
    block$sound_family <- fam
    block$sound_column <- sc
    block$template <- "Rodrigues2026_noise_block_trip_mean_outcome"
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

write.csv(results, file.path(outdir, "pilot_rodrigues_all_terms.csv"), row.names = FALSE, na = "")
write.csv(family_summary, file.path(outdir, "FDR_summary_by_sound_family.csv"), row.names = FALSE, na = "")
write.csv(column_summary, file.path(outdir, "FDR_summary_by_sound_column.csv"), row.names = FALSE, na = "")
write.csv(data.frame(
  sound_family = rep(names(sound_families), vapply(sound_families, length, 0L)),
  sound_column = unlist(sound_families, use.names = FALSE),
  in_merge_csv = TRUE,
  yamnet_class_columns = 0L,
  note = "Pilot uses Rodrigues trip noise block (mean/max/SD z-scored) on each descriptor; BH within column x term over 26 outcomes."
), file.path(outdir, "sound_columns_inventory.csv"), row.names = FALSE, na = "")

cat("H4 other-sound pilot complete.\n")
print(family_summary)
cat("Outputs:", outdir, "\n")
