# H4 phase-average — exploratory participant subgroup (clearness / fitness / activeness).
# Run: Rscript scripts/statistical_analysis/H4_phaseavg_grouped.R --group=fitness --level=fit
# Engine unchanged: H4_phaseavg.R + H4_core.R; outputs under results/H4_phaseavg_grouped_by_*.

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (!length(.entry)) {
    .trail <- commandArgs(trailingOnly = TRUE)
    if (length(.trail) && file.exists(.trail[1])) .entry <- .trail[1]
  }
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
PROJECT_ROOT <- resolve_project_root()
paper3_apply_exploratory_group_from_cli(PROJECT_ROOT, "H4_phaseavg", stop_if_nonempty = TRUE)
source(file.path(paper3_statistical_script_dir(), "H4_phaseavg.R"), local = FALSE)
run_h4_phaseavg()
