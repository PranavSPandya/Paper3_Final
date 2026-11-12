# H4_old: thermal x sound product tests for the old-approach papers.
# Separate from H4_sound_literature_test.R. Nominal p only; no BH/FDR.
options(stringsAsFactors = FALSE)
entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(entry) || !file.exists(entry[1])) stop("Run with Rscript.")
entry <- normalizePath(entry[1], winslash = "/", mustWork = TRUE)
library_dir <- file.path(dirname(entry), "library")
code_paths <- c(entry, file.path(library_dir, c("Paper3_common.R", "H4_old_sound_literature_helpers.R")))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
suppressPackageStartupMessages(library(nlme))

root <- resolve_project_root()
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- H4_OLD_IO$read_epochs(root)

catalog <- h4_old_run_all(epochs)
summary_tab <- h4_old_summary(catalog)

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop("Code changed during run.")
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop("Input changed during run.")

notes <- c(
  "# H4_old source-informed product tests",
  paste("Run UTC:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
  paste("Input MD5:", unname(input_fingerprint)),
  paste("Code MD5:", basename(code_paths), unname(code_fingerprints)),
  "",
  "## Purpose",
  "Old H4: exposure to sound amplifies discomfort under thermally uncomfortable outdoor conditions.",
  "Each row is the local product-term test on 22 walking bouts (11 people x WalkG/WalkU).",
  "Assigned laboratory or occupational arms are not available; those papers use a median-split or continuous product analogue.",
  "Nominal p < 0.05. No BH/FDR.",
  "",
  "## Papers (amplification only)",
  "- Jin 2020: Type II ANOVA LAeq quartile x UTCI quartile on three comfort votes; continuous fallback if rank-deficient.",
  "- Chen 2023, Li 2025: Y ~ UTCI_z * dBA_z on three comfort votes.",
  "- Wu 2025: I(dBA>=60) x UTCI on overall_comfort (OCV); continuous fallback if the 60 dB split is empty.",
  "- Xu 2026: I(Ta>32) x I(dBA>65) on thermal comfort; continuous Ta x dBA if a 2x2 cell is empty.",
  "- Yousefinezhad, Dehghan: I(UTCI >= median) * I(dBA >= median) on comfort (and heart rate for Dehghan).",
  "- Bhattacharya, Abbasi, Molaeifar: Ta_z * dBA_z on comfort and/or heart rate.",
  "- Tohidi: heart rate ~ Ta_z * dBA_z.",
  "- Not run (thermal-acoustic screen, not amplification): Mohammadzadeh 2023, Gao 2025, Zhen 2025, Tang 2026, Wang 2026.",
  "",
  "## Local result",
  "k/n = significant interaction rows / interaction rows fitted for that paper."
)

H4_OLD_IO$write(catalog, summary_tab, notes, root)
print(summary_tab)
