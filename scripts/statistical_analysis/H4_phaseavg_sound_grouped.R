# H4 phase-average sound substitution — exploratory participant subgroup.
# Run: Rscript scripts/statistical_analysis/H4_phaseavg_sound_grouped.R --group=fitness --level=fit
# Forwards same CLI as H4_phaseavg_sound.R (--wind-sensitivity, etc.).

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
paper3_apply_exploratory_group_from_cli(PROJECT_ROOT, "H4_phaseavg_sound", stop_if_nonempty = TRUE)
statdir <- paper3_statistical_script_dir()
source(file.path(statdir, "H4_phaseavg_sound.R"), local = FALSE)
h4s_sound_substitutes <- h4s_read_sound_substitutes_from_entry(file.path(statdir, "H4_timeseries_sound.R"))
args <- commandArgs(trailingOnly = TRUE)
wind_max <- if ("--wind-sensitivity" %in% args) {
  argw <- grep("^--wind-max-aws=", args, value = TRUE)
  if (length(argw)) as.numeric(sub("^--wind-max-aws=", "", argw[1L])) else 5
} else {
  NA_real_
}
h4s_run("phaseavg", Eq1, file.path(statdir, "H4_phaseavg_sound.R"), h4s_sound_substitutes, wind_max_aws = wind_max)
