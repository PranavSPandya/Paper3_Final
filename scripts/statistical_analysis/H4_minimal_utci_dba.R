# Minimal sensitivity: UTCI x ucm_SND_dBA only (not primary H4 Eq1–7).
# Exploratory check of sound main and thermal×sound interaction with bout-centered predictors.
# Run: Rscript scripts/statistical_analysis/H4_minimal_utci_dba.R
# Output: output/statistical_analysis/results/H4_minimal_utci_dba/
# Wind QC (screening only, no dBA correction): --wind-sensitivity [--wind-max-aws=5]
#   -> .../H4_minimal_utci_dba/wind_aws_le_5ms/ (finite ucm_WIND_AWS <= threshold on 10 s rows;
#   helpers h4s_wind_keep_mask / h4s_write_wind_screening_report in library/H4_sound_core.R).
# Unscreened root CSV is not overwritten when --wind-sensitivity is on.

options(stringsAsFactors = FALSE)
.files <- vapply(sys.frames(), function(f) if (is.null(f$ofile)) "" else as.character(f$ofile)[1], character(1))
.entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) .entry <- tail(.files[nzchar(.files)], 1)
if (!length(.entry)) stop("Cannot locate entry script")
.entry <- normalizePath(.entry[1], winslash = "/", mustWork = TRUE)

source(file.path(dirname(.entry), "library", "Paper3_common.R"), local = FALSE)
for (package in c("nlme", "clubSandwich")) {
  if (!requireNamespace(package, quietly = TRUE)) stop("Required package missing: ", package)
}
source(file.path(dirname(.entry), "library", "H4_sound_core.R"), local = FALSE)
core <- file.path(dirname(.entry), "library", "H4_core.R")
h4_phase_design <- h4s_helper("h4_phase_design", core)

args <- commandArgs(trailingOnly = TRUE)
wind_max_aws <- NA_real_
if ("--wind-sensitivity" %in% args) {
  wind_max_aws <- 5
  argw <- grep("^--wind-max-aws=", args, value = TRUE)
  if (length(argw)) wind_max_aws <- as.numeric(sub("^--wind-max-aws=", "", argw[1L]))
}

root <- resolve_project_root()
outcomes <- paper3_physiological_outcomes()
transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
loaded <- h4s_load(root, outcomes)
d <- loaded$data
stopifnot("ucm_SND_dBA" %in% names(d))

n_rows_input <- nrow(d)
wind_screening_note <- character()
if (!is.na(wind_max_aws)) {
  outdir_wind <- file.path(
    root, "output", "statistical_analysis", "results", "H4_minimal_utci_dba",
    sprintf("wind_aws_le_%gms", wind_max_aws)
  )
  dir.create(outdir_wind, recursive = TRUE, showWarnings = FALSE)
  h4s_write_wind_screening_report(d, outdir_wind, wind_max_aws, epoch_sec = 10L)
  keep <- h4s_wind_keep_mask(d, wind_max_aws)
  n_kept <- sum(keep)
  n_excluded <- n_rows_input - n_kept
  d <- d[keep, , drop = FALSE]
  wind_screening_note <- c(
    paste("Wind screening: ucm_WIND_AWS <=", wind_max_aws, "m/s (10 s windows; screening only, not dBA correction)."),
    paste("Rows before filter:", n_rows_input, "| kept:", n_kept, "| excluded:", n_excluded),
    paste("Screening CSVs:", file.path(outdir_wind, "H4_sound_wind_screening_summary.csv"))
  )
}

h4m_fit_block <- function(dsub, label, single_phase = FALSE) {
  bout <- interaction(dsub$ParticipantID, dsub$PhaseID, drop = TRUE)
  dsub$ucm_UTCI_bout_z <- h4s_center(dsub$ucm_UTCI, bout)
  dsub$ucm_SND_dBA_bout_z <- h4s_center(dsub$ucm_SND_dBA, bout)
  if (!single_phase) {
    phase <- h4_phase_design(dsub$PhaseID)
    dsub <- cbind(dsub, phase)
  }
  rows <- list()
  for (out in as.character(outcomes)) {
    y <- paper3_apply_csv_transform(dsub[[out]], out, transforms)
    ok <- is.finite(y) & is.finite(dsub$ucm_UTCI_bout_z) & is.finite(dsub$ucm_SND_dBA_bout_z)
    if (!any(ok)) next
    a <- dsub[ok, c("ParticipantID", "PhaseID", "Time10", "ucm_UTCI_bout_z", "ucm_SND_dBA_bout_z")]
    if (!single_phase) {
      a <- cbind(a, dsub[ok, c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")])
    }
    a$Y <- y[ok]
    a$ParticipantID <- factor(a$ParticipantID)
    a$PhaseID <- factor(a$PhaseID)
    fml <- if (single_phase) {
      Y ~ ucm_UTCI_bout_z * ucm_SND_dBA_bout_z
    } else {
      Y ~ ucm_UTCI_bout_z * ucm_SND_dBA_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG
    }
    fit <- tryCatch(h4s_fit_time(fml, a)$fit, error = function(e) NULL)
    if (is.null(fit)) next
    beta <- nlme::fixef(fit)
    V <- clubSandwich::vcovCR(fit, cluster = a$ParticipantID, type = "CR2")
    for (term in c("ucm_SND_dBA_bout_z", "ucm_UTCI_bout_z:ucm_SND_dBA_bout_z")) {
      if (!term %in% names(beta)) next
      L <- matrix(0, 1, length(beta), dimnames = list(NULL, names(beta)))
      L[1, term] <- 1
      w <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
      rows[[length(rows) + 1L]] <- data.frame(
        model = label, outcome = out, term = term,
        Beta = as.numeric(L %*% beta), SE = sqrt(as.numeric(L %*% V %*% t(L))),
        df = w$df_denom, p = w$p_val, n = nrow(a), stringsAsFactors = FALSE
      )
    }
  }
  if (!length(rows)) return(NULL)
  out <- do.call(rbind, rows)
  out$term_type <- ifelse(out$term == "ucm_SND_dBA_bout_z", "sound", "thermal_x_sound")
  out$q_FDR <- NA_real_
  for (key in unique(out$term_type)) {
    ix <- which(out$term_type == key & is.finite(out$p))
    if (length(ix)) out$q_FDR[ix] <- p.adjust(out$p[ix], "BH", n = length(outcomes))
  }
  out$FDR_significant <- !is.na(out$q_FDR) & out$q_FDR < 0.05
  out
}

models <- list(
  pooled_all_phases = list(data = d, single_phase = FALSE),
  WalkU_only = list(data = d[d$PhaseID == "WalkU", , drop = FALSE], single_phase = TRUE),
  WalkG_only = list(data = d[d$PhaseID == "WalkG", , drop = FALSE], single_phase = TRUE),
  BikeU_only = list(data = d[d$PhaseID == "BikeU", , drop = FALSE], single_phase = TRUE),
  BikeG_only = list(data = d[d$PhaseID == "BikeG", , drop = FALSE], single_phase = TRUE)
)

res <- do.call(rbind, lapply(names(models), function(nm) {
  spec <- models[[nm]]
  h4m_fit_block(spec$data, nm, single_phase = spec$single_phase)
}))

outdir <- file.path(root, "output", "statistical_analysis", "results", "H4_minimal_utci_dba")
if (!is.na(wind_max_aws)) {
  outdir <- file.path(outdir, sprintf("wind_aws_le_%gms", wind_max_aws))
}
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
write.csv(res, file.path(outdir, "H4_minimal_utci_dba_coefficients.csv"), row.names = FALSE)

note <- c(
  "H4 minimal UTCI x ucm_SND_dBA sensitivity (exploratory; not primary H4 Eq1–7).",
  paste("Input:", loaded$path),
  "Pooled model: interaction + sum-to-zero phase offsets (PhaseSumWalkG/U, PhaseSumBikeG).",
  "Single-phase models: interaction only (phase offsets would be collinear).",
  "Predictors are bout-centered (within participant x phase); not absolute hottest-day UTCI.",
  "q_FDR / FDR_significant: BH across 26 outcomes per term type (sound vs thermal_x_sound) within each model block only.",
  "Not pooled across the five model blocks (pooled + four single-phase runs are separate sensitivity slices).",
  "Same random structure and AR1 fallback as H4 sound time-series (h4s_fit_time).",
  wind_screening_note
)
writeLines(note[nzchar(note)], file.path(outdir, "H4_minimal_utci_dba_README.txt"))

if (sys.nframe() == 0L) {
  ix <- res[res$term_type == "thermal_x_sound", ]
  ix <- ix[order(ix$p), ]
  cat("FINISHED:", outdir, "\n")
  if (!is.na(wind_max_aws)) {
    cat("Wind screening (10 s rows): kept", nrow(d), "of", n_rows_input,
        "(threshold ucm_WIND_AWS <=", wind_max_aws, "m/s)\n")
  }
  cat("Best raw p (thermal x sound) by model:\n")
  print(stats::aggregate(p ~ model, ix, min))
  fdr_tab <- aggregate(
    FDR_significant ~ model + term_type,
    data = res,
    FUN = function(x) sum(x, na.rm = TRUE)
  )
  names(fdr_tab)[3] <- "n_FDR_significant"
  cat("FDR_significant counts (q_FDR < 0.05) by model block and term_type:\n")
  print(fdr_tab)
}
