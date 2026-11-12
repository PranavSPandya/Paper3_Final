# H4: one test per screened paper, each implementing that paper's own formula (documents/H1_H5_papers_screened_final.md 4.0).
# Nominal p only; no catalogue-wide FDR.
options(stringsAsFactors = FALSE)
entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(entry) || !file.exists(entry[1])) stop("Run with Rscript.")
entry <- normalizePath(entry[1], winslash = "/", mustWork = TRUE)
library_dir <- file.path(dirname(entry), "library")
code_paths <- c(entry, file.path(library_dir, c("Paper3_common.R", "H4_sound_literature_helpers.R")))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
suppressPackageStartupMessages(library(nlme))
root <- resolve_project_root()
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- H4_IO$read_epochs(root)

blocks <- list(
  pigliautile = H4_PIGLIAUTILE$run(epochs),
  chiucchiu_w = H4_CHIUCCHIU$run(epochs, "walk"),
  chiucchiu_b = H4_CHIUCCHIU$run(epochs, "bike"),
  cureau2022_w = H4_CUREAU2022$run(epochs, "walk"),
  cureau2022_b = H4_CUREAU2022$run(epochs, "bike"),
  cureau2023  = H4_CUREAU2023$run(epochs),
  grapas      = H4_GRAPAS$run(epochs),
  moshammer   = H4_MOSHAMMER$run(epochs),
  rodrigues   = H4_RODRIGUES$run(epochs),
  korpilo     = H4_KORPILO$run(epochs),
  kraus       = H4_KRAUS$run(epochs),
  ueberham_b = H4_UEBERHAM$run(epochs, "bike"),
  ueberham_w = H4_UEBERHAM$run(epochs, "walk"),
  cond_walk   = H4_CONDITIONAL_SLOPES$run(epochs, "walk"),
  cond_bike   = H4_CONDITIONAL_SLOPES$run(epochs, "bike"),
  cond_both   = H4_CONDITIONAL_SLOPES$run(epochs, "both"),
  continuous  = H4_CONTINUOUS$run(epochs))
blocks <- Filter(Negate(is.null), blocks)
all_cols <- unique(unlist(lapply(blocks, names)))
blocks <- lapply(blocks, function(d) {
  for (col in setdiff(all_cols, names(d))) d[[col]] <- NA
  d[, all_cols, drop = FALSE]
})
catalog <- do.call(rbind, blocks)

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop("Code changed during run.")
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop("Input changed during run.")

notes <- c(
  "# H4 source-formula tests",
  paste("Run UTC:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
  paste("Input MD5:", unname(input_fingerprint)),
  paste("Code MD5:", basename(code_paths), unname(code_fingerprints)),
  "",
  "## Purpose",
  "Each European source paper's own published test, replicated exactly on this dataset.",
  "Sources are not modified to fit a different hypothesis.",
  "",
  "## Formula for each paper",
  paste0("- Pigliautile 2021 : ", H4_PIGLIAUTILE$formula),
  paste0("- Chiucchiu 2026   : ", H4_CHIUCCHIU$formula_paired),
  paste0("                    ", H4_CHIUCCHIU$formula_spearman),
  paste0("                    ", H4_CHIUCCHIU$formula_table5),
  paste0("- Cureau 2022      : ", H4_CUREAU2022$formula_fisher),
  paste0("                    ", H4_CUREAU2022$formula_mw),
  paste0("- Cureau 2023      : ", H4_CUREAU2023$formula),
  paste0("- Grapas 2026      : ", H4_GRAPAS$formula),
  paste0("- Moshammer 2019   : ", H4_MOSHAMMER$formula),
  paste0("- Rodrigues 2026   : ", H4_RODRIGUES$formula_noise),
  paste0("- Korpilo 2024     : ", H4_KORPILO$formula_eda),
  paste0("- Kraus 2013       : ", H4_KRAUS$formula),
  paste0("- Ueberham 2019    : ", H4_UEBERHAM$formula_spearman),
  "",
  "## Present study's own model (NOT a paper replication)",
  paste0("- H4 continuous (own model) : ", H4_CONTINUOUS$formula),
  "- No screened European paper specifies a UTCI x dBA term. This block is reported",
  "  separately and must not be described as a ported source test.",
  "",
  "## Inference",
  "- Nominal p-values only. No Benjamini-Hochberg or catalogue-wide FDR.",
  "- Each paper's own decision rule is applied and recorded in `paper_rule_met`.",
  "",
  "## H4 relevance filter",
  "Every paper's own test is kept exactly as published. Each row is then tagged",
  "in `h4_relevance` with why it does or does not bear on H4:",
  "- `core`       : addresses the H4 question (sound conditioned on thermal,",
  "                 thermal-acoustic coupling, or a thermal x sound product).",
  "- `supporting` : supplies a needed component (sound main effect or thermal",
  "                 main effect) but cannot establish amplification alone.",
  "- `not_h4`     : no thermal term, no sound term, or a non-comfort estimand.",
  "`H4_tests_relevant_to_hypothesis.csv` contains only the core and supporting rows.")
H4_IO$write(catalog, notes, root)
