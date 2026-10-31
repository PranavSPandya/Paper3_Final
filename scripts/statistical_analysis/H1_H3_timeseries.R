# H1–H3 outcome-only time series — meeting spec (engine: H1_H3_core.R)
# Outputs: output/statistical_analysis/results/H1_H3_timeseries/ (H1_, H2_, H3_ prefixes)
# H4 time-series bout models: scripts/statistical_analysis/H4_timeseries.R

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]
  }
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("nlme", "emmeans"),
  load_packages = c("nlme", "emmeans"),
  extra_setup = function() emmeans::emm_options(msg.interaction = FALSE)
)
PROJECT_ROOT <- resolve_project_root()
H1_H3_TIMESERIES_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/H1_H3_timeseries.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H1_H3_TIMESERIES_START_MD5 <- unname(tools::md5sum(c(H1_H3_TIMESERIES_SCRIPT_PATH, RAW_DATA_PATH)))

study_wide_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()
)

study_wide_spec <- paper3_attach_outcome_normalization(study_wide_spec, PROJECT_ROOT)
NORMALIZATION_CSV_PATH <- study_wide_spec$normalization_csv_path
OUTCOME_TRANSFORMS_CSV <- study_wide_spec$outcome_transforms_csv
PAPER3_APPLY_CSV_TRANSFORM <- function(x, column_name) {
  paper3_apply_csv_transform(x, column_name, OUTCOME_TRANSFORMS_CSV)
}
PAPER3_OUTCOME_WITHIN_PERSON_Z <- paper3_within_person_z

h1_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h3_hypothesis_spec <- list(physiological_outcome_names = study_wide_spec$physiological_outcome_names)
h2_hypothesis_spec <- list(
  physiological_outcome_names = study_wide_spec$physiological_outcome_names,
  psychological_outcomes = c(
    "questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"
  )
)

planned_h1_h3 <- paper3_h1_h3_planned_contrast_tables()
h1_hypothesis_spec$contrasts <- planned_h1_h3$h1
h3_hypothesis_spec$contrasts <- planned_h1_h3$h3

# ==============================================================================
# EXPLICIT MODELS — H1 / H2 / H3 time series (outcome-only; sum-to-zero PhaseID)
# ==============================================================================
# Y_within_person_z: PAPER3_APPLY_CSV_TRANSFORM then PAPER3_OUTCOME_WITHIN_PERSON_Z (H1_H3_core.R fits outcome_z on 10 s rows).
H1_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H1_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)

H3_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H3_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)

H2_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H2_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)

H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_mean_table)
)

h1_h3_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE)
}
H1_H3_TIME_SERIES_FIXED_10s <- h1_h3_fixed_terms_from_lme_quote(H1_TimeSeries_Temporal_AR1_10s_LMM)
stopifnot(
  identical(H1_H3_TIME_SERIES_FIXED_10s, h1_h3_fixed_terms_from_lme_quote(H2_TimeSeries_Temporal_AR1_10s_LMM)),
  identical(H1_H3_TIME_SERIES_FIXED_10s, h1_h3_fixed_terms_from_lme_quote(H3_TimeSeries_Temporal_AR1_10s_LMM)),
  identical(deparse(H1_TimeSeries_Temporal_AR1_10s_LMM[[2]]), deparse(H2_TimeSeries_Temporal_AR1_10s_LMM[[2]])),
  identical(deparse(H1_TimeSeries_Temporal_AR1_10s_LMM[[2]]), deparse(H3_TimeSeries_Temporal_AR1_10s_LMM[[2]]))
)

run_h1_h3_timeseries <- function() {
  assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
  assign("TIME_SERIES_SCRIPT_PATH", H1_H3_TIMESERIES_SCRIPT_PATH, envir = .GlobalEnv)
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_install_time_series_globals()
  h1_h3_time_series_dispatch_from_env()
}

run_one_time_series <- function(hypothesis_id) {
  assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
  assign("TIME_SERIES_SCRIPT_PATH", H1_H3_TIMESERIES_SCRIPT_PATH, envir = .GlobalEnv)
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_install_time_series_globals()
  h1_h3_run_one_time_series(hypothesis_id)
}

run_h1_to_h3_time_series <- function(hypotheses = c("H1", "H2", "H3")) {
  assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
  assign("TIME_SERIES_SCRIPT_PATH", H1_H3_TIMESERIES_SCRIPT_PATH, envir = .GlobalEnv)
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_install_time_series_globals()
  h1_h3_run_all_time_series(hypotheses)
}

run_h1_time_series <- function() run_one_time_series("H1")
run_h2_time_series <- function() run_one_time_series("H2")
run_h3_time_series <- function() run_one_time_series("H3")

if (sys.nframe() == 0L) {
  run_h1_h3_timeseries()
} else {
  assign("PAPER3_TIME_SERIES_ENGINE", TRUE, envir = .GlobalEnv)
  assign("TIME_SERIES_SCRIPT_PATH", H1_H3_TIMESERIES_SCRIPT_PATH, envir = .GlobalEnv)
  source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)
  h1_h3_install_time_series_globals()
  h1_h3_time_series_autostart(
    function() h1_h3_run_all_time_series(),
    function(hypothesis_id) h1_h3_run_one_time_series(hypothesis_id)
  )
}
