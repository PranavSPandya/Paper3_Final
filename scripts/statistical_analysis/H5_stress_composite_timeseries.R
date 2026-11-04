# H5 10 s epochs: prespecified within-person coupling LMMs with AR(1) (exploratory; shared code: library/H5_coupling_core.R).
# Output: output/statistical_analysis/results/H5_stress_composite_timeseries/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = c("nlme"),
  load_packages = c("nlme"))
PROJECT_ROOT <- resolve_project_root()
LIBRARY_DIR <- paper3_statistical_library_dir()

run_h5_stress_composite_timeseries <- function() {
  source(file.path(LIBRARY_DIR, "H5_coupling_core.R"), local = FALSE)
  h5_stress_composite_run("timeseries")}

if (sys.nframe() == 0L) {
  run_h5_stress_composite_timeseries()
  p3_finalize_directory(OUT_DIR)}
