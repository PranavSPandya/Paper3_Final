# H4 time-series sound substitution — exploratory participant subgroup.
# Run: Rscript scripts/statistical_analysis/H4_timeseries_sound_grouped.R --group=fitness --level=fit
# Forwards same CLI as H4_timeseries_sound.R (--epoch-sec=, --wind-sensitivity, etc.).

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
paper3_apply_exploratory_group_from_cli(PROJECT_ROOT, "H4_timeseries_sound", stop_if_nonempty = TRUE)
statdir <- paper3_statistical_script_dir()
source(file.path(statdir, "H4_timeseries_sound.R"), local = FALSE)
args <- commandArgs(trailingOnly = TRUE)
if ("--wind-sensitivity" %in% args) {
  wind_max <- 5
  argw <- grep("^--wind-max-aws=", args, value = TRUE)
  if (length(argw)) wind_max <- as.numeric(sub("^--wind-max-aws=", "", argw[1L]))
  one <- grep("^--epoch-sec=", args, value = TRUE)
  epochs <- if (length(one)) as.integer(sub("^--epoch-sec=", "", one[1L])) else c(10L, 30L, 60L, 300L)
  for (sec in epochs) {
    h4s_run("timeseries", Eq1, file.path(statdir, "H4_timeseries_sound.R"), h4s_sound_substitutes, epoch_sec = sec, wind_max_aws = wind_max)
  }
} else {
  one <- grep("^--epoch-sec=", args, value = TRUE)
  epochs <- if (length(one)) as.integer(sub("^--epoch-sec=", "", one[1L])) else c(30L, 60L, 300L)
  if (any(epochs == 10L)) stop("10 s writes H4_timeseries_sound/ root; default skips 10 s to preserve existing root outputs.")
  for (sec in epochs) {
    h4s_run("timeseries", Eq1, file.path(statdir, "H4_timeseries_sound.R"), h4s_sound_substitutes, epoch_sec = sec)
  }
}
