# H4 phase-average interaction screen: outcome ~ ucm_UTCI * ucm_SND_dBA (+ random intercept).
#
# Scope: one simplified Eq1-style model per physiological outcome (26), no AR(1), no covariates.
# Sound (SND): ucm_SND_dBA — same bout-centered/scaled dBA index used in primary Eq1 (not PCA sound mains).
# Heat (UTCI): ucm_UTCI — same UCM thermal index as Eq1.
#
# Aggregation: epoch-level ucm_* and outcomes are averaged to participant x phase (WalkG/U, BikeG/U).
# Scaling: within-person center and scale on those phase means (matches temp/scripts/h4_phase_mean_fdr_quicktest.R),
#          not bout-level re-centering on phase aggregates.
#
# Inference: nlme::lme(REML), clubSandwich::coef_test(CR2, cluster = ParticipantID) when available.

suppressPackageStartupMessages({
  library(nlme)
  has_club <- requireNamespace("clubSandwich", quietly = TRUE)
  if (has_club) library(clubSandwich)
})

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) {
  dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE))
} else {
  normalizePath(getwd(), winslash = "/", mustWork = TRUE)
}
PROJECT_ROOT <- normalizePath(file.path(SCRIPT_DIR, ".."), winslash = "/", mustWork = FALSE)
source(file.path(PROJECT_ROOT, "scripts", "Paper3_common.R"), local = FALSE)
source(file.path(PROJECT_ROOT, "scripts", "H4_multivariate.R"), local = FALSE)
PROJECT_ROOT <- resolve_project_root()
source(file.path(PROJECT_ROOT, "scripts", "H4_core.R"), local = FALSE)

OUT_WORK <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results/_work")
OUT_CSV_PATH <- file.path(OUT_WORK, "h4_multi_phaseavg_utci_snd.csv")
UTCI_COL <- "ucm_UTCI"
SND_COL <- "ucm_SND_dBA"
IX_COL <- paste0(UTCI_COL, ":", SND_COL)

h4_mean <- function(x) {
  x <- x[is.finite(x)]
  if (!length(x)) return(NA_real_)
  mean(x)
}

h4_phase_aggregate <- function(raw_df, cols) {
  keys <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  lev <- unique(keys)
  out <- data.frame(
    ParticipantID = vapply(strsplit(lev, "::", fixed = TRUE), `[`, character(1), 1),
    PhaseID = vapply(strsplit(lev, "::", fixed = TRUE), `[`, character(1), 2),
    stringsAsFactors = FALSE
  )
  out$ParticipantID <- factor(out$ParticipantID, levels = H4_SPEC$participants)
  out$PhaseID <- factor(out$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  for (v in cols) {
    out[[v]] <- vapply(split(raw_df[[v]], keys)[lev], h4_mean, numeric(1))
  }
  out[order(out$ParticipantID, out$PhaseID), , drop = FALSE]
}

h4_person_center_scale <- function(raw_mat, person_id) {
  z <- raw_mat
  storage.mode(z) <- "double"
  for (j in seq_len(ncol(z))) {
    x <- z[, j]
    fin <- is.finite(x)
    if (!any(fin)) next
    pm <- tapply(x[fin], person_id[fin], mean)
    x_c <- x - unname(pm[person_id])
    sdx <- stats::sd(x_c[fin])
    if (is.finite(sdx) && sdx > 0) x_c <- x_c / sdx
    z[, j] <- x_c
  }
  z
}

fit_phase_utci_snd <- function(y, phase_df, hrv_log) {
  d <- phase_df[, c("ParticipantID", "PhaseID", UTCI_COL, SND_COL), drop = FALSE]
  d$Y <- phase_df[[y]]
  if (y %in% hrv_log) {
    keep <- is.finite(d$Y) & d$Y > 0
    d <- d[keep, , drop = FALSE]
    d$Y <- log(d$Y)
  }
  ok <- stats::complete.cases(d[, c("Y", UTCI_COL, SND_COL)])
  d <- d[ok, , drop = FALSE]
  d$ParticipantID <- factor(d$ParticipantID)
  n <- nrow(d)
  if (n < 10L) {
    return(list(success = FALSE, n = n, note = "too_few_rows", coef = NULL))
  }
  fml <- stats::as.formula(paste("Y ~", UTCI_COL, "*", SND_COL))
  fit <- tryCatch(
    nlme::lme(fml, data = d, random = ~ 1 | ParticipantID, method = "REML", na.action = na.fail),
    error = function(e) e
  )
  if (inherits(fit, "error")) {
    return(list(success = FALSE, n = n, note = fit$message, coef = NULL))
  }
  if (has_club) {
    robust <- tryCatch(
      clubSandwich::coef_test(fit, vcov = "CR2", cluster = d$ParticipantID, test = "Satterthwaite"),
      error = function(e) NULL
    )
    if (is.null(robust)) {
      return(list(success = FALSE, n = n, note = "CR2_failed", coef = NULL))
    }
    terms <- rownames(robust)
    p_val <- if ("p_Satt" %in% colnames(robust)) robust$p_Satt else 2 * stats::pt(-abs(robust$beta / robust$SE), robust$df_Satt)
    coef_df <- data.frame(
      outcome = y, term = terms, estimate = robust$beta, se = robust$SE, df = robust$df_Satt,
      p_value = p_val, n_phases = n, success = TRUE, note = "phase_mean_lme_cr2",
      stringsAsFactors = FALSE
    )
  } else {
    sm <- summary(fit)$tTable
    coef_df <- data.frame(
      outcome = y, term = rownames(sm), estimate = sm[, "Value"], se = sm[, "Std.Error"],
      df = sm[, "DF"], p_value = sm[, "p-value"], n_phases = n, success = TRUE,
      note = "phase_mean_lme_model_t", stringsAsFactors = FALSE
    )
  }
  list(success = TRUE, n = n, note = coef_df$note[1L], coef = coef_df)
}

t0 <- proc.time()
outcomes <- H4_SPEC$all_outcomes
hrv_log <- hrv_log_outcomes()

if (!file.exists(OUT_CSV)) stop("Audit CSV missing: ", OUT_CSV)
audit_df <- utils::read.csv(OUT_CSV, check.names = FALSE)
raw_df <- utils::read.csv(RAW_DATA_PATH, check.names = FALSE)
for (v in setdiff(names(average_sources), names(raw_df))) {
  raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
}
prep <- h4_step4_exposure_prep(audit_df, raw_df)
phase_cols <- unique(c(UTCI_COL, SND_COL, outcomes))
phase_raw <- h4_phase_aggregate(prep$raw_df, phase_cols)
person_id <- as.character(phase_raw$ParticipantID)
scaled <- h4_person_center_scale(as.matrix(phase_raw[, c(UTCI_COL, SND_COL), drop = FALSE]), person_id)
phase_raw[[UTCI_COL]] <- scaled[, UTCI_COL]
phase_raw[[SND_COL]] <- scaled[, SND_COL]

status_list <- coef_list <- list()
for (y in outcomes) {
  res <- fit_phase_utci_snd(y, phase_raw, hrv_log)
  status_list[[length(status_list) + 1L]] <- data.frame(
    outcome = y, success = res$success, n_phases = res$n, note = res$note, stringsAsFactors = FALSE
  )
  if (res$success && !is.null(res$coef)) coef_list[[length(coef_list) + 1L]] <- res$coef
}

status_all <- do.call(rbind, status_list)
coef_all <- if (length(coef_list)) do.call(rbind, coef_list) else NULL

# BH FDR: per term across m outcomes (matches H4.1 thermal_per_term family).
if (!is.null(coef_all) && nrow(coef_all)) {
  m_term <- length(outcomes)
  fdr_terms <- c(UTCI_COL, SND_COL, IX_COL)
  coef_all$q <- NA_real_
  for (term_name in fdr_terms) {
    idx <- which(coef_all$term == term_name & coef_all$success & is.finite(coef_all$p_value))
    if (length(idx)) coef_all$q[idx] <- stats::p.adjust(coef_all$p_value[idx], method = "BH", n = m_term)
  }
  coef_all$FDR_significant <- ifelse(is.na(coef_all$q), NA, coef_all$q < 0.05)
}

dir.create(OUT_WORK, recursive = TRUE, showWarnings = FALSE)
if (!is.null(coef_all) && nrow(coef_all)) {
  utils::write.csv(coef_all, OUT_CSV_PATH, row.names = FALSE, na = "")
} else {
  utils::write.csv(status_all, OUT_CSV_PATH, row.names = FALSE, na = "")
}

elapsed <- proc.time() - t0
n_phase_rows <- nrow(phase_raw)
n_success <- sum(status_all$success)
median_n <- if (n_success) stats::median(status_all$n_phases[status_all$success]) else NA_real_

count_p <- function(term_name) {
  if (is.null(coef_all)) return(0L)
  sub <- coef_all[coef_all$term == term_name & coef_all$success, , drop = FALSE]
  sum(sub$p_value < 0.05, na.rm = TRUE)
}
count_q <- function(term_name) {
  if (is.null(coef_all)) return(0L)
  sub <- coef_all[coef_all$term == term_name & coef_all$success, , drop = FALSE]
  sum(sub$FDR_significant %in% TRUE, na.rm = TRUE)
}

cat("=== H4 phase-average UTCI * SND (26 outcomes) ===\n")
cat(sprintf("Participant x phase grid rows: %d\n", n_phase_rows))
cat(sprintf("Models fit OK: %d / %d (median n phases per outcome: %s)\n",
            n_success, length(outcomes), format(median_n, digits = 4)))
cat(sprintf("Outcomes with p < 0.05 — %s: %d; %s: %d; %s: %d\n",
            UTCI_COL, count_p(UTCI_COL), SND_COL, count_p(SND_COL), IX_COL, count_p(IX_COL)))
cat(sprintf("Outcomes with q < 0.05 (BH, m=%d per term) — %s: %d; %s: %d; %s: %d\n",
            length(outcomes), UTCI_COL, count_q(UTCI_COL), SND_COL, count_q(SND_COL), IX_COL, count_q(IX_COL)))
cat(sprintf("Runtime: %.1f s\n", elapsed[["elapsed"]]))
cat("Wrote:", OUT_CSV_PATH, "\n")
if (any(!status_all$success)) {
  cat("\nFailures:\n")
  print(status_all[!status_all$success, c("outcome", "note")], row.names = FALSE)
}
