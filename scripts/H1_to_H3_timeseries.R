# H1–H3 outcome-only time series — meeting spec (engine: H1_to_H3_time_series_core.R)
# H4 time-series bout models: scripts/H4_time_series.R

if (interactive() && sys.nframe() > 0L && exists("run_h1_to_h3_time_series", mode = "function", inherits = FALSE)) {
run_h1_to_h3_time_series()
}

if (interactive() && sys.nframe() > 0L) {
  on.exit({
    .time_series_autorun_lock <- ".__paper3_h1_h3_time_series_autorun_lock__"
    if (!exists(.time_series_autorun_lock, envir = .GlobalEnv, inherits = FALSE)) {
      assign(.time_series_autorun_lock, TRUE, envir = .GlobalEnv)
      on.exit(rm(list = .time_series_autorun_lock, envir = .GlobalEnv), add = TRUE)
      time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
      if (nzchar(time_series_hypothesis_arg) && exists("run_one_time_series", mode = "function", inherits = FALSE)) {
        run_one_time_series(time_series_hypothesis_arg)
      } else if (exists("run_h1_to_h3_time_series", mode = "function", inherits = FALSE)) {
        run_h1_to_h3_time_series()
      }
    }
  }, add = TRUE)
}

suppressPackageStartupMessages({
  library(nlme)
  library(emmeans)
})
emm_options(msg.interaction = FALSE)

required_packages <- c("nlme", "emmeans")
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

GLOBAL_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcomes = paper3_physiological_outcomes()
)
stopifnot(length(GLOBAL_SPEC$physiological_outcomes) == 26L)
GLOBAL_SPEC$hrv_log <- paper3_log_outcomes(GLOBAL_SPEC$physiological_outcomes, PROJECT_ROOT)
hrv_log_outcomes <- function() GLOBAL_SPEC$hrv_log
hrv_fd_outcomes <- function() attr(GLOBAL_SPEC$physiological_outcomes, "hrv_fd")

H1_SPEC <- list(outcomes = GLOBAL_SPEC$physiological_outcomes)
H3_SPEC <- list(outcomes = GLOBAL_SPEC$physiological_outcomes)
H2_SPEC <- list(
  physiological_outcomes = GLOBAL_SPEC$physiological_outcomes,
  psychological_outcomes = c(
    "questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"
  )
)

H1_SPEC$contrasts <- data.frame(
  Hypothesis = "H1",
  Sub_Hypothesis = c("H1.1", "H1.2"),
  Reference_PhaseID = c("BikeU", "WalkU"),
  Comparison_PhaseID = c("BikeG", "WalkG"),
  stringsAsFactors = FALSE
)
H1_SPEC$contrasts$Contrast <- paste(H1_SPEC$contrasts$Reference_PhaseID, H1_SPEC$contrasts$Comparison_PhaseID, sep = "_")

H3_SPEC$contrasts <- data.frame(
  Hypothesis = "H3",
  Sub_Hypothesis = c("H3.1", "H3.2"),
  Reference_PhaseID = c("BikeU", "BikeG"),
  Comparison_PhaseID = c("WalkU", "WalkG"),
  stringsAsFactors = FALSE
)
H3_SPEC$contrasts$Contrast <- paste(H3_SPEC$contrasts$Reference_PhaseID, H3_SPEC$contrasts$Comparison_PhaseID, sep = "_")

# Sum-to-zero PhaseID (contr.sum): three explicit columns; BikeU implicit (same coding as H4_time_series.R).
TIME_SERIES_PHASE_SUM_COLUMNS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

paper3_phase_sum_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing PhaseID for sum-to-zero contrasts")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- TIME_SERIES_PHASE_SUM_COLUMNS
  design
}


# ==============================================================================
# EXPLICIT MODELS — H1 time series (outcome-only, 10 s / 60 s)
# ==============================================================================

H1_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H1_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data_60s,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)


# ==============================================================================
# EXPLICIT MODELS — H2 time series (physio 10 s; psych once per phase)
# ==============================================================================

H2_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H2_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data_60s,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)

H2_rmcorr <- quote(
  lm(psychological ~ ParticipantID + physiological, data = participant_phase_means)
)


# ==============================================================================
# EXPLICIT MODELS — H3 time series (outcome-only; mode contrast interpretation)
# ==============================================================================

H3_TimeSeries_Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"
  )
)

H3_TimeSeries_Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    outcome_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = epoch_data_60s,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"
  )
)

stopifnot(
  identical(deparse(H1_TimeSeries_Temporal_AR1_10s_LMM[[2]]), deparse(H2_TimeSeries_Temporal_AR1_10s_LMM[[2]])),
  identical(deparse(H1_TimeSeries_Temporal_AR1_10s_LMM[[2]]), deparse(H3_TimeSeries_Temporal_AR1_10s_LMM[[2]]))
)


# ==============================================================================
# WORKFLOW
# ==============================================================================

assign_time_series_active_models <- function(hypothesis_id) {
  assign("TimeSeries_Temporal_AR1_10s_LMM", get(paste0(hypothesis_id, "_TimeSeries_Temporal_AR1_10s_LMM"), envir = .GlobalEnv), envir = .GlobalEnv)
  assign("TimeSeries_Temporal_AR1_60s_LMM", get(paste0(hypothesis_id, "_TimeSeries_Temporal_AR1_60s_LMM"), envir = .GlobalEnv), envir = .GlobalEnv)
}

clear_time_series_secondary_hook <- function() {
  if (exists("time_series_secondary_fit", envir = .GlobalEnv, inherits = FALSE)) {
    rm("time_series_secondary_fit", envir = .GlobalEnv)
  }
}

h2_time_series_secondary_fit <- function(context) {
  model_audit <- context$model_audit
  condition_name <- context$condition_name
  condition_data <- context$condition_data
  input_data <- context$input_data
  physiological_outcomes <- context$physiological_outcomes
  psychological_outcomes <- context$psychological_outcomes
  h2_physio_outcomes <- intersect(physiological_outcomes, names(input_data))
  h2_psych_outcomes <- intersect(psychological_outcomes, names(input_data))
  h2_results_list <- list()
  participant_phase_source <- condition_data[c("ParticipantID", "PhaseID", h2_psych_outcomes, h2_physio_outcomes)]
  participant_phase_means <- aggregate(participant_phase_source[c(h2_psych_outcomes, h2_physio_outcomes)], by = participant_phase_source[c("ParticipantID", "PhaseID")], FUN = mean_na)
  for (psychological_measure in h2_psych_outcomes) for (physiological_measure in h2_physio_outcomes) {
    pair_data <- participant_phase_means[complete.cases(participant_phase_means[c(psychological_measure, physiological_measure)]), c("ParticipantID", psychological_measure, physiological_measure)]
    pair_data <- pair_data[pair_data$ParticipantID %in% names(which(table(pair_data$ParticipantID) >= 2)), , drop = FALSE]
    names(pair_data) <- c("ParticipantID", "psychological_value", "physiological_value")
    pair_data$ParticipantID <- droplevels(factor(pair_data$ParticipantID))
    n_participants <- nlevels(pair_data$ParticipantID)
    if (nrow(pair_data) < 20 || n_participants < 8 || sd(pair_data$physiological_value) == 0) {
      model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", condition_name, psychological_measure, physiological_measure, "NOT_FIT_INSUFFICIENT_DATA", nrow(pair_data), n_participants,
        warn = "Fewer than 20 bouts or 8 participants")
      next
    }
    h2_call <- H2_rmcorr
    h2_call[[2L]] <- do.call("substitute", list(h2_call[[2L]], list(psychological = as.name("psychological_value"), physiological = as.name("physiological_value"))))
    h2_call$data <- quote(pair_data)
    rmcorr_fit <- eval(h2_call)
    physiological_coefficients <- summary(rmcorr_fit)$coefficients["physiological_value", ]
    residual_df <- rmcorr_fit$df.residual
    t_value <- physiological_coefficients[["t value"]]
    rmcorr_r <- sign(t_value) * sqrt(t_value^2 / (t_value^2 + residual_df))
    fisher_z_ci <- atanh(rmcorr_r) + c(-1, 1) * qnorm(0.975) / sqrt(residual_df - 1)
    model_audit[[length(model_audit) + 1]] <- audit_row("H2_rmcorr", condition_name, psychological_measure, physiological_measure, "FIT", nrow(pair_data), n_participants)
    h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
      Hypothesis = "H2", Analysis_Entry = "H2_time_series",
      Psychological_Measure = psychological_measure, Physiological_Measure = physiological_measure,
      Model_Formula = sprintf("rmcorr: lm(%s ~ ParticipantID + %s), Bakdash & Marusich 2017", psychological_measure, physiological_measure),
      Beta = physiological_coefficients[["Estimate"]], SE = physiological_coefficients[["Std. Error"]], CI95_low = tanh(fisher_z_ci[1]), CI95_high = tanh(fisher_z_ci[2]),
      t_stat = t_value, df = residual_df, p_value = physiological_coefficients[["Pr(>|t|)"]], Partial_r_Within = rmcorr_r,
      N_PhaseBouts = nrow(pair_data), N_Participants = n_participants, stringsAsFactors = FALSE)
  }
  h2_table <- safe_rbind(h2_results_list)
  if (nrow(h2_table) > 0) {
    h2_table$q_FDR <- p.adjust(h2_table$p_value, method = "BH")
    h2_table$FDR_significant <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05
  }
  list(table = h2_table, model_audit = model_audit)
}

run_one_time_series <- function(hypothesis_id) {
  hypothesis_id <- match.arg(hypothesis_id, c("H1", "H2", "H3"))
  clear_time_series_secondary_hook()
  assign_time_series_active_models(hypothesis_id)
  assign("TIME_SERIES_SPEC", list(hypothesis = hypothesis_id), envir = .GlobalEnv)
  manifest_extra <- list(
    PhaseID_Coding = "contr.sum(4): PhaseSumWalkG, PhaseSumWalkU, PhaseSumBikeG; BikeU implicit"
  )
  if (hypothesis_id == "H1") {
    manifest_extra$Planned_Phase_Contrasts <- paste(H1_SPEC$contrasts$Contrast, collapse = ", ")
  } else if (hypothesis_id == "H3") {
    manifest_extra$Planned_Phase_Contrasts <- paste(H3_SPEC$contrasts$Contrast, collapse = ", ")
  }
  assign("TIME_SERIES_MANIFEST_EXTRA", manifest_extra, envir = .GlobalEnv)
  if (hypothesis_id == "H2") {
    assign("TIME_SERIES_SECONDARY_CSV", "Physio_Psycho_Concordance.csv", envir = .GlobalEnv)
    assign("time_series_secondary_fit", h2_time_series_secondary_fit, envir = .GlobalEnv)
  }
  source(file.path(SCRIPT_DIR, "H1_to_H3_time_series_core.R"), local = FALSE)
  h1_h3_time_series_dispatch_run()
}

run_h1_time_series <- function() run_one_time_series("H1")
run_h2_time_series <- function() run_one_time_series("H2")
run_h3_time_series <- function() run_one_time_series("H3")

run_h1_to_h3_time_series <- function(hypotheses = c("H1", "H2", "H3")) {
  cat("==============================================================================\n")
  cat("Running H1–H3 time series (outcome-only 10 s AR(1); engine per hypothesis)\n")
  cat("==============================================================================\n")
  for (hypothesis_id in hypotheses) {
    cat(sprintf("\n--- %s ---\n", hypothesis_id))
    run_one_time_series(hypothesis_id)
  }
  cat("\nSUCCESS: H1–H3 time series dispatch finished.\n")
}

# Auto-run under Rscript (sys.nframe() == 0) and IDE source/play (interactive()). OR is safe: Rscript is not interactive().
# Re-entry guard prevents nested duplicate dispatch if the meeting file is sourced again mid-pipeline.
time_series_dispatch_from_cli_or_ide <- function() {
  time_series_hypothesis_arg <- Sys.getenv("PAPER3_TIME_SERIES_HYPOTHESIS", "")
  if (nzchar(time_series_hypothesis_arg)) run_one_time_series(time_series_hypothesis_arg) else run_h1_to_h3_time_series()
}
if (sys.nframe() == 0L || interactive()) {
  # Interactive source() (sys.nframe() > 0) dispatches via on.exit at file top; avoid double run here.
  if (!(interactive() && sys.nframe() > 0L)) {
    .time_series_autorun_lock <- ".__paper3_h1_h3_time_series_autorun_lock__"
    if (!exists(.time_series_autorun_lock, envir = .GlobalEnv, inherits = FALSE)) {
      assign(.time_series_autorun_lock, TRUE, envir = .GlobalEnv)
      on.exit(rm(list = .time_series_autorun_lock, envir = .GlobalEnv), add = TRUE)
      time_series_dispatch_from_cli_or_ide()
    }
  }
}
