# H1–H3 participant-phase inferential analysis — meeting spec (engine: H1_H3_core.R)
# H4: scripts/H4_multivariate.R

suppressPackageStartupMessages({
  library(nlme)
  library(emmeans)
  library(ggplot2)
  library(statpsych)
})
emm_options(msg.interaction = FALSE)

required_packages <- c("nlme", "emmeans", "ggplot2", "statpsych")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) {
  dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE))
} else {
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "scripts") wd else file.path(wd, "scripts")
}
source(file.path(SCRIPT_DIR, "Paper3_common.R"), local = FALSE)

PROJECT_ROOT <- resolve_project_root()
H1_TO_H3_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/H1_to_H3.R")
RAW_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
if (basename(RAW_PATH) != "merged_all_11participants_8min.csv") stop("H1_to_H3.R must use merged_all_11participants_8min.csv only.")
SIBLING_DATA_ROOT <- file.path(dirname(PROJECT_ROOT), "Paper3_Github")
KEY_PATH <- Sys.getenv("PAPER3_KEY_PATH", file.path(PROJECT_ROOT, "output", "key.csv"))
if (!file.exists(KEY_PATH)) KEY_PATH <- file.path(SIBLING_DATA_ROOT, "output", "key.csv")
OUT_DIR <- Sys.getenv("PAPER3_OUT_DIR", file.path(PROJECT_ROOT, "output", "statistical_analysis", "results"))
MAKE_FIGURES <- Sys.getenv("PAPER3_MAKE_FIGURES", "TRUE") == "TRUE"

# Cohort and outcome specification
# H1 and H3 Y: 26 physiological time-series outcomes only (10 s epochs → phase means or wpz LMMs).
# Questionnaires are one value per participant × phase (end of bout) — H2 rmcorr only, not H1 or H3 LMM Y.
# physiological: indices 1–13 empatica, 14–26 eyetracker; HRV log subset = attr(..., "hrv_log").
H1_TO_H3_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  outcomes = list(physiological = paper3_physiological_outcomes()),
  h2_psychological = c(
    "questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"
  )
)
stopifnot(length(H1_TO_H3_SPEC$outcomes$physiological) == 26L)
# H1 and H3 share the same 26 physiological LMM outcomes (phase means + temporal AR(1)).
H1_TO_H3_SPEC$phase_lmm_outcomes <- H1_TO_H3_SPEC$outcomes$physiological
H1_TO_H3_SPEC$all_declared_columns <- c(H1_TO_H3_SPEC$h2_psychological, H1_TO_H3_SPEC$phase_lmm_outcomes)

hrv_log_outcomes <- function() attr(H1_TO_H3_SPEC$outcomes$physiological, "hrv_log")
hrv_fd_outcomes <- function() attr(H1_TO_H3_SPEC$outcomes$physiological, "hrv_fd")

# Planned contrasts (Beta = Comparison minus Reference; emmeans reference level = BikeU)
H1_TO_H3_SPEC$h1_contrasts <- data.frame(
  Hypothesis = "H1",
  Sub_Hypothesis = c("H1.1", "H1.2"),
  Reference_PhaseID = c("BikeU", "WalkU"),
  Comparison_PhaseID = c("BikeG", "WalkG"),
  stringsAsFactors = FALSE
)
H1_TO_H3_SPEC$h3_contrasts <- data.frame(
  Hypothesis = "H3",
  Sub_Hypothesis = c("H3.1", "H3.2"),
  Reference_PhaseID = c("BikeU", "BikeG"),
  Comparison_PhaseID = c("WalkU", "WalkG"),
  stringsAsFactors = FALSE
)
H1_TO_H3_SPEC$h1_contrasts$Contrast <- paste(H1_TO_H3_SPEC$h1_contrasts$Reference_PhaseID, H1_TO_H3_SPEC$h1_contrasts$Comparison_PhaseID, sep = "_")
H1_TO_H3_SPEC$h3_contrasts$Contrast <- paste(H1_TO_H3_SPEC$h3_contrasts$Reference_PhaseID, H1_TO_H3_SPEC$h3_contrasts$Comparison_PhaseID, sep = "_")

# Difference-of-differences on the 2×2 PhaseID layout (reported alongside planned contrasts):
#   (BikeG − BikeU) − (WalkG − WalkU)


# ==============================================================================
# EXPLICIT MODELS — H1 (green infrastructure vs reference routes)
# ==============================================================================
# Outcome Y: each of the 26 physiological measures. Inference: H1.1 BikeG−BikeU, H1.2 WalkG−WalkU.

# H1 — participant-phase means (N = 44), primary analysis units
H1_PhaseMean_Primary_LMM <- quote(
  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)

# H1 — same layout, within-person z across the 4 core phases (sensitivity)
H1_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(wpz_outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)

# H1 — temporal sensitivity: 10 s epochs, matched first 8 min; wpz Y; reference PhaseID = BikeU
H1_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = epoch_data,
    method = "REML"
  )
)

# H1 — temporal sensitivity: 60 s epoch aggregation (robustness to AR(1) grid)
H1_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = epoch_data_60s,
    method = "REML"
  )
)


# ==============================================================================
# EXPLICIT MODELS — H3 (active travel mode contrasts)
# ==============================================================================
# Same LMM shells as H1 (one PhaseID factor model per outcome); emmeans extracts H3.1 WalkU−BikeU, H3.2 WalkG−BikeG.
# Temporal AR(1) models share PhaseID × time_min fixed effects — H3 contrasts read from the same fits.

H3_PhaseMean_Primary_LMM <- quote(
  nlme::lme(outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)

H3_PhaseMean_Sensitivity_WPZ_LMM <- quote(
  nlme::lme(wpz_outcome ~ PhaseID, random = ~ 1 | ParticipantID, data = phase_mean_data, method = "REML")
)

H3_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
    data = epoch_data,
    method = "REML"
  )
)

H3_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    wpz_outcome ~ PhaseID * time_min,
    random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ time_60s_step | ParticipantID / PhaseID),
    data = epoch_data_60s,
    method = "REML"
  )
)


# ==============================================================================
# EXPLICIT MODEL — H2 (psychophysiological concurrence)
# ==============================================================================
# One questionnaire value per participant × phase; paired with phase-mean physiological Y (not 10 s LMM).

H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)
)

# FDR families: H1 primary / H1 WPZ / H3 primary / H3 WPZ (26 outcomes × 2 contrasts each within hypothesis);
# H2 one family (4 questionnaires × 26 physiological = 104 pairs);
# temporal one family per fixed-effect Term (26 outcomes; supports H1 & H3 phase contrasts from shared PhaseID effects).


# ==============================================================================
# WORKFLOW
# ==============================================================================

run_h1_and_h3 <- function() {
  source(file.path(SCRIPT_DIR, "H1_H3_core.R"), local = FALSE)
  dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
  cat("==============================================================================\n")
  cat("Running H1 and H3 (plus H2): phase contrasts, rmcorr, temporal AR(1)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(H1_TO_H3_SPEC$participants), paste(H1_TO_H3_SPEC$participants, collapse = ", ")))
  cat(sprintf("Core phases (%d): %s\n", length(H1_TO_H3_SPEC$phases), paste(H1_TO_H3_SPEC$phases, collapse = ", ")))
  cat(sprintf("H1 and H3 LMM outcomes (%d): empatica [1:13] + eyetracker [14:26] (physiological time series)\n",
              length(H1_TO_H3_SPEC$phase_lmm_outcomes)))
  cat(sprintf("H2 psychological (%d): end-of-phase questionnaires only (rmcorr, not H1 or H3 LMM)\n",
              length(H1_TO_H3_SPEC$h2_psychological)))
  cat(sprintf("H1 contrasts: %s | H3 contrasts: %s\n\n",
              paste(H1_TO_H3_SPEC$h1_contrasts$Contrast, collapse = ", "),
              paste(H1_TO_H3_SPEC$h3_contrasts$Contrast, collapse = ", ")))
  h1_to_h3_pipeline_run()
}

if (sys.nframe() == 0L) run_h1_and_h3()
