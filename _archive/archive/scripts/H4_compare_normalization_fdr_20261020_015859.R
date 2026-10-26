# Compare FDR (thermal hypothesis rows, q < 0.05) across outcome-normalization profiles.
# step5 = Normalization_results.md "Transformation in Step 5" (default H4 contract).
# literature_eda = sqrt on tonic/phasic (EDA literature winner; not Step 5).

args <- commandArgs(trailingOnly = TRUE)
profiles <- if (length(args)) args else c("step5", "literature_eda")

script_dir <- dirname(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]))
if (!length(script_dir) || script_dir == ".") script_dir <- file.path(getwd(), "scripts")
source(file.path(script_dir, "H4_multivariate.R"), local = FALSE)

count_fdr <- function(path) {
  if (!file.exists(path)) return(NA_integer_)
  h <- read.csv(path, stringsAsFactors = FALSE)
  sum(is.finite(h$q) & h$q < 0.05, na.rm = TRUE)
}

baseline_path <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results/timeseries/_work/H4_models/H4_hypothesis.csv")
rows <- data.frame(profile = character(), fdr_q05 = integer(), hypothesis_rows = integer(), stringsAsFactors = FALSE)
if (file.exists(baseline_path)) {
  h0 <- read.csv(baseline_path, stringsAsFactors = FALSE)
  rows <- rbind(rows, data.frame(profile = "previous_run_on_disk", fdr_q05 = count_fdr(baseline_path),
    hypothesis_rows = nrow(h0), stringsAsFactors = FALSE))
}

for (profile in profiles) {
  Sys.setenv(H4_OUTCOME_NORMALIZATION = profile)
  message("\n=== Outcome normalization profile: ", profile, " ===")
  invisible(run_h4())
  hyp_path <- file.path(OUT_DIR, "H4_models", "H4_hypothesis.csv")
  h <- read.csv(hyp_path, stringsAsFactors = FALSE)
  rows <- rbind(rows, data.frame(profile = profile, fdr_q05 = count_fdr(hyp_path),
    hypothesis_rows = nrow(h), stringsAsFactors = FALSE))
}

out_csv <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results/timeseries/_work/H4_normalization_fdr_comparison.csv")
write.csv(rows, out_csv, row.names = FALSE)
print(rows)
cat("\nWrote:", out_csv, "\n")
