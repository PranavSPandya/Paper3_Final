# H1–H3 participant-phase (phase-average, non-time-series) inferential analysis — meeting spec (engine: H1_H3_core.R)
# Outputs: output/statistical_analysis/results/H1_to_H3_phase_average/ (files prefixed H1_/H2_/H3_/H1_to_H3_)
# H4: scripts/H4_time_series.R

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

# Shared study settings
GLOBAL_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcomes = paper3_physiological_outcomes()
)

# Separate hypothesis specifications; the outcome definitions share one source.
H1_SPEC <- list(outcomes = GLOBAL_SPEC$physiological_outcomes)
H3_SPEC <- list(outcomes = GLOBAL_SPEC$physiological_outcomes)
H2_SPEC <- list(
  physiological_outcomes = GLOBAL_SPEC$physiological_outcomes,
  psychological_outcomes = c(
    "questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"
  )
)
stopifnot(length(H1_SPEC$outcomes) == 26L, length(H3_SPEC$outcomes) == 26L)

GLOBAL_SPEC$hrv_log <- paper3_log_outcomes(GLOBAL_SPEC$physiological_outcomes, PROJECT_ROOT)
hrv_log_outcomes <- function() GLOBAL_SPEC$hrv_log
hrv_fd_outcomes <- function() attr(GLOBAL_SPEC$physiological_outcomes, "hrv_fd")

# Planned contrasts (Beta = Comparison minus Reference; emmeans reference level = BikeU)
H1_SPEC$contrasts <- data.frame(
  Hypothesis = "H1",
  Sub_Hypothesis = c("H1.1", "H1.2"),
  Reference_PhaseID = c("BikeU", "WalkU"),
  Comparison_PhaseID = c("BikeG", "WalkG"),
  stringsAsFactors = FALSE
)
H3_SPEC$contrasts <- data.frame(
  Hypothesis = "H3",
  Sub_Hypothesis = c("H3.1", "H3.2"),
  Reference_PhaseID = c("BikeU", "BikeG"),
  Comparison_PhaseID = c("WalkU", "WalkG"),
  stringsAsFactors = FALSE
)
H1_SPEC$contrasts$Contrast <- paste(H1_SPEC$contrasts$Reference_PhaseID, H1_SPEC$contrasts$Comparison_PhaseID, sep = "_")
H3_SPEC$contrasts$Contrast <- paste(H3_SPEC$contrasts$Reference_PhaseID, H3_SPEC$contrasts$Comparison_PhaseID, sep = "_")

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

# Standardise each participant's 10-second values across all four routes, then
# average by phase. This checks sensitivity to participants' measurement scales.
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
# Temporal models report phase coefficients relative to BikeU and phase-specific
# time trends; these are not the four planned phase-mean H1/H3 comparisons.

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
# Primary: average each physiological outcome within participant and phase
# (up to 11 x 4 = 44 rows), then estimate the specified H1 and H3 differences.
# Standardisation sensitivity: repeat those differences using phase means of
# within-person standardised 10-second values.
# Temporal sensitivity: retain repeated observations to estimate starting levels
# and linear changes during each route; AR(1) models residual serial correlation.
# H2: pair each end-of-phase questionnaire with the corresponding physiological
# phase mean. The questionnaire is not a 10-second repeated outcome.

run_h1_and_h3 <- function() {
  source(file.path(SCRIPT_DIR, "H1_H3_core.R"), local = FALSE)
  cat("==============================================================================\n")
  cat("Running H1 and H3 (plus H2): phase contrasts, rmcorr, temporal AR(1)\n")
  cat("==============================================================================\n")
  cat(sprintf("Participants (%d): %s\n", length(GLOBAL_SPEC$participants), paste(GLOBAL_SPEC$participants, collapse = ", ")))
  cat(sprintf("Core phases (%d): %s\n", length(GLOBAL_SPEC$phases), paste(GLOBAL_SPEC$phases, collapse = ", ")))
  cat(sprintf("H1 and H3 LMM outcomes (%d): empatica [1:13] + eyetracker [14:26] (physiological time series)\n",
              length(H1_SPEC$outcomes)))
  cat(sprintf("H2 psychological (%d): end-of-phase questionnaires only (rmcorr, not H1 or H3 LMM)\n",
              length(H2_SPEC$psychological_outcomes)))
  cat(sprintf("H1 contrasts: %s | H3 contrasts: %s\n\n",
              paste(H1_SPEC$contrasts$Contrast, collapse = ", "),
              paste(H3_SPEC$contrasts$Contrast, collapse = ", ")))
  h1_to_h3_pipeline_run()
}

if (sys.nframe() == 0L && !isTRUE(getOption("paper3_skip_auto_run", FALSE))) run_h1_and_h3()
