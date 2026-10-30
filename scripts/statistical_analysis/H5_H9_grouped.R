# H5 + H9 bundle entry retained for legacy CLI; default analysis is weather (use H9_stress_composite_grouped.R for stress).
# Run: Rscript scripts/statistical_analysis/H5_H9_grouped.R --group=fitness --level=fit

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
args <- commandArgs(trailingOnly = TRUE)
atype <- sub("^--analysis=", "", grep("^--analysis=", args, value = TRUE))
if (!length(atype)) atype <- "weather"
source(file.path(paper3_statistical_library_dir(), "H5_exploratory_group_dispatch.R"), local = FALSE)
paper3_h5_exploratory_group_run(atype[1L], project_root = resolve_project_root())
