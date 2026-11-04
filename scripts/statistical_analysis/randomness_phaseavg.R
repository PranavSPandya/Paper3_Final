# Check for chronological sequence/order effects (Bout 1 to 4) on participant-phase means.
# Tests whether experimental habituation, fatigue, or novelty confounded the counterbalanced study design.
# Output: results/randomness_phaseavg/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(required_packages = c("nlme"))

PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
spec <- paper3_combined_study_spec(PROJECT_ROOT)

OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "randomness_phaseavg")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PSYCH_OUTCOMES <- paper3_psych_questionnaire_outcomes()

PHYSIO_OUTCOMES <- spec$physiological_outcome_names

run_randomness_check <- function() {
  raw_df <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
  raw_df <- raw_df[raw_df$ParticipantID %in% spec$participants & raw_df$PhaseID %in% spec$phases, , drop = FALSE]
  raw_df$Datetime_parsed <- as.POSIXct(raw_df$Datetime, tz = "UTC")

  # Order chronological bouts per participant based on earliest timestamp in phase
  bout_order_df <- aggregate(Datetime_parsed ~ ParticipantID + PhaseID, data = raw_df, FUN = min)
  bout_order_df <- bout_order_df[order(bout_order_df$ParticipantID, bout_order_df$Datetime_parsed), ]
  bout_order_df$BoutOrder <- unlist(lapply(split(bout_order_df$Datetime_parsed, bout_order_df$ParticipantID), seq_along))
  bout_order_df$Datetime_parsed <- NULL

  # Phase averages
  all_vars <- unique(c(PHYSIO_OUTCOMES, PSYCH_OUTCOMES))
  available_vars <- intersect(all_vars, names(raw_df))
  
  mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
  phase_means <- aggregate(raw_df[available_vars], by = raw_df[c("ParticipantID", "PhaseID")], FUN = mean_na)
  
  merged_df <- merge(phase_means, bout_order_df, by = c("ParticipantID", "PhaseID"))
  merged_df$ParticipantID <- factor(merged_df$ParticipantID)

  results <- list()

  test_variable <- function(var_name, var_type) {
    sub_data <- merged_df[!is.na(merged_df[[var_name]]), c("ParticipantID", "PhaseID", "BoutOrder", var_name)]
    if (nrow(sub_data) < 10 || length(unique(sub_data$ParticipantID)) < 3 || sd(sub_data[[var_name]]) == 0) {
      return(NULL)
    }
    
    # Linear Mixed Model: Outcome ~ BoutOrder, random = ~ 1 | ParticipantID
    form <- as.formula(paste(var_name, "~ BoutOrder"))
    fit <- tryCatch(
      nlme::lme(form, random = ~ 1 | ParticipantID, data = sub_data, method = "REML", na.action = na.omit),
      error = function(e) NULL
    )
    if (is.null(fit)) return(NULL)
    
    ttab <- summary(fit)$tTable
    if (!"BoutOrder" %in% rownames(ttab)) return(NULL)
    
    data.frame(
      Variable_Type = var_type,
      Variable = var_name,
      Estimate_per_bout = ttab["BoutOrder", "Value"],
      SE = ttab["BoutOrder", "Std.Error"],
      DF = ttab["BoutOrder", "DF"],
      t_value = ttab["BoutOrder", "t-value"],
      p_value = ttab["BoutOrder", "p-value"],
      N_obs = nrow(sub_data),
      N_participants = length(unique(sub_data$ParticipantID)),
      stringsAsFactors = FALSE
    )
  }

  for (v in intersect(PHYSIO_OUTCOMES, available_vars)) {
    res <- test_variable(v, "Physiological")
    if (!is.null(res)) results[[length(results) + 1L]] <- res
  }

  for (v in intersect(PSYCH_OUTCOMES, available_vars)) {
    res <- test_variable(v, "Questionnaire")
    if (!is.null(res)) results[[length(results) + 1L]] <- res
  }

  out_df <- do.call(rbind, results)
  
  # FDR per Variable_Type family
  out_df$q_FDR <- NA_real_
  for (vt in unique(out_df$Variable_Type)) {
    idx <- which(out_df$Variable_Type == vt)
    out_df$q_FDR[idx] <- p.adjust(out_df$p_value[idx], method = "BH")
  }

  out_csv <- file.path(OUT_DIR, "randomness_sequence_check_summary.csv")
  write.csv(out_df, out_csv, row.names = FALSE)
  message("Randomness sequence check saved to: ", out_csv)

  sig_raw <- sum(out_df$p_value < 0.05, na.rm = TRUE)
  sig_fdr <- sum(out_df$q_FDR < 0.05, na.rm = TRUE)
  cat(sprintf("\n=== Randomness Sequence Audit Summary ===\nTotal outcomes tested: %d\nSignificant raw p < 0.05: %d\nSignificant FDR q < 0.05: %d\n\n",
              nrow(out_df), sig_raw, sig_fdr))

  return(out_df)
}

if (!interactive()) {
  run_randomness_check()
}
