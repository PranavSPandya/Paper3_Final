# H4: included sources (Grapas Brussels, Cureau 2022, Rodrigues, Peng 2025,
# Baquero 2019) plus a separate present-study interaction analysis.
# Nominal p only; no BH/FDR.
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

# Walking only: that is the published design of the European sources.
# No cycling extension. No tram.
blocks <- list(
  cureau2022_w = H4_CUREAU2022$run(epochs, "walk"),
  grapas_w    = H4_GRAPAS$run(epochs, "walk"),
  rodrigues_w = H4_RODRIGUES$run(epochs, "walk"),
  peng_w      = H4_PENG2025$run(epochs, "walk"),
  baquero_w   = H4_BAQUERO2019$run(epochs, "walk"),
  cond_walk   = H4_CONDITIONAL_SLOPES$run(epochs, "walk"),
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
  "# H4 source-informed analyses and direct H4 test",
  paste("Run UTC:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
  paste("Input MD5:", unname(input_fingerprint)),
  paste("Code MD5:", basename(code_paths), unname(code_fingerprints)),
  "",
  "## Purpose",
  "Screened sources provide methodological precedents; local applications are adaptations, not exact replications.",
  "Outcome, instrument, timing, scope and formula differences are documented separately from the source procedures.",
  "",
  "## Local formulas (included sources)",
  paste0("- Cureau 2022      : ", H4_CUREAU2022$formula_fisher),
  paste0("                    ", H4_CUREAU2022$formula_mw),
  paste0("- Grapas 2026      : ", H4_GRAPAS$formula),
  paste0("- Rodrigues 2026   : ", H4_RODRIGUES$formula_noise),
  paste0("- Peng 2025        : ", H4_PENG2025$formula),
  paste0("- Baquero 2019     : ", H4_BAQUERO2019$formula),
  "Excluded (not run): Pigliautile 2021 (no test), Cureau 2023 (no test), Kraus 2013 (no thermal variable), Ueberham 2019 (perceived exposure, not comfort), Korpilo 2024 (soundscape quality to restoration, not discomfort), Moshammer 2019 (noise and PM on HRV, temperature as weather covariate, not thermal-acoustic discomfort), Grapas Rome 2026 (HR/EDA vs environment; physiology, not thermal-vote H4), Chiucchiù 2026 (NEXT.ROOM indoor chamber; not outdoor walking H4).",
  "",
  "## Direct H4 test (H4 conditional slope block)",
  paste0("- Interaction : ", H4_CONDITIONAL_SLOPES$formula_continuous),
  "  8 outcomes on walking bouts (source design). Each is reported at nominal p",
  "  with its predicted sign stated; no multiplicity correction is applied.",
  "  Predicted sign: negative for ratings (comfort, pleasantness, PRS) and HRV; positive for heart rate, EDA, skin temperature.",
  paste0("- Stratified : ", H4_CONDITIONAL_SLOPES$formula_stratified),
  "  With 2 bouts per person per mode each thermal half holds 1 bout per person, so the half slopes are",
  "  between-person and descriptive; the earlier Wald slope-difference test was removed.",
  "",
  "## Fixes applied 2026-11-10 (H4 audit)",
  "- A1 predicted sign per outcome (predicted_direction, in_predicted_direction).",
  "- A2 Chiucchiu C0/C1 labelled as green/urban route contrast (urban is not warmer for every cyclist).",
  "- A3 slope-difference test removed; stratified slopes descriptive; Mode added when modes are pooled.",
  "- A4 Chiucchiu Table 5 per-soundscape delta removed: lookup never matched and both groups would be the same people.",
  "- A5 Grapas: person-mean Pearson rows replaced by delay ~ exposure + Mode + (1|participant) on a cross-correlation latency proxy.",
  "- A6 Rodrigues TEMP_max = within-bout max of 10 s air temperature (was the mean); NOISE_max already the within-bout max.",
  "- B7 Cureau 2022: paired Wilcoxon signed-rank replaces Mann-Whitney; Fisher exact (seeded Monte Carlo fallback).",
  "- B8 Cureau 2022 multinomial logit: p not reported when LR df >= n/2 (overfitted).",
  "- B11 all models reported; the Moshammer SDNN comparison is selected post hoc for reporting, not preregistered.",
  "- B12 Korpilo crowd proxy renamed urban_negative_sound_share_z (YAMNet share, not a headcount).",
  "",
  "## Fixes applied 2026-11-10 (exact-source pass: replications repeat the published methods as-is)",
  "- C1 Moshammer: Mode covariate REMOVED (source is a walking study, no mode term); PM2.5 confounder RESTORED per the source formula; walk = source design.",
  "- C2 Rodrigues: Mode covariate REMOVED (source is walking trips only); walk = source design.",
  "- C3 Korpilo: Mode covariate REMOVED (source is group walks only); walk = source design.",
  "- C4 Grapas: Mode covariate REMOVED (source is walk sessions only); walk = source design.",
  "- D1 Pigliautile 2021, Cureau 2023, Kraus 2013, Ueberham 2019, Korpilo 2024, Moshammer 2019, Grapas Rome 2026 and Chiucchiù 2026 excluded from H4: they do not test thermal discomfort on measured outdoor noise (no test / no thermal variable / perceived exposure, not comfort / restoration / noise-PM HRV / physiology not a thermal vote / indoor NEXT.ROOM chamber).",
  "- Cureau 2022 already matched the source design and is unchanged.",
  "- No included source uses a thermal x sound product term as the test of H4.",
  "",
  "## Present study's own model (NOT a paper replication)",
  paste0("- H4 continuous (own model) : ", H4_CONTINUOUS$formula),
  "- No screened source provides an identical UTCI x personal-dBA model for these local comfort outcomes. This block is reported",
  "  separately and must not be described as a ported source test.",
  "",
  "## Inference",
  "- Nominal p for every row. Each source keeps its own published decision rule; no BH/FDR correction is applied.",
  "- paper_rule/source_reference_rule_met describe reference cutoffs only where applicable; analysis_rule/analysis_rule_met record the local decision. No source-replication success flag is exported.",
  "",
  "## H4 relevance filter",
  "Source-informed adaptations and the separate present-study model are tagged",
  "in `h4_relevance` with why it does or does not bear on H4:",
  "- `direct`     : the walking dBA x UTCI interactions (is_direct_h4_test = TRUE).",
  "- `contextual` : other thermal-acoustic associations; not direct amplification tests.",
  "- `supporting` : supplies a needed component (sound main effect or thermal",
  "                 main effect) but cannot establish amplification alone.",
  "- `not_h4`     : no thermal term, no sound term, or a non-comfort estimand.",
  "`H4_tests_relevant_to_hypothesis.csv` contains the direct, contextual and supporting rows; is_direct_h4_test identifies the walking interaction rows.",
  "",
  "## Scope",
  "Walking bouts only, matching the published European source designs. Cycling is not an H4 extension. Tram is not in H4.")
H4_IO$write(catalog, notes, root)
