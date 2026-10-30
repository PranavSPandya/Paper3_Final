# H5 hotspot urban-climate quality — exploratory participant subgroup.
# Run: Rscript scripts/statistical_analysis/H5_hotspot_uc_quality_grouped.R --group=fitness --level=fit

if (!exists("PAPER3_PARTICIPANTS", inherits = FALSE)) {
  .entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
  if (length(.entry)) {
    source(file.path(dirname(normalizePath(.entry[1], mustWork = FALSE)), "library", "Paper3_common.R"), local = FALSE)
  } else if (file.exists(file.path("library", "Paper3_common.R"))) {
    source(file.path("library", "Paper3_common.R"), local = FALSE)
  }
}
source(file.path(paper3_statistical_library_dir(), "H5_exploratory_group_dispatch.R"), local = FALSE)
paper3_h5_exploratory_group_run("quality", project_root = resolve_project_root())
