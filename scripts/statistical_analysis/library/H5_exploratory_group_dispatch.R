# Shared dispatcher for H5/H9 exploratory subgroup runs (clearness / fitness / activeness).
# Sourced from H5_*_grouped.R entry scripts; primary H5/H9 meeting files unchanged.

paper3_h5_exploratory_group_run <- function(
  analysis_type = c("weather", "quality", "svfclasses", "stress"),
  output_root = NULL,
  project_root = resolve_project_root(),
  args = commandArgs(trailingOnly = TRUE)
) {
  analysis_type <- match.arg(analysis_type)
  cli <- paper3_parse_exploratory_group_cli(args)
  dimension <- cli$dimension
  level <- cli$level
  assignments <- paper3_exploratory_group_assignments(project_root)
  ids <- paper3_exploratory_group_participant_ids(dimension, level, assignments, project_root)
  suffix <- paper3_exploratory_group_output_suffix(dimension, level)
  basename_out <- switch(
    analysis_type,
    weather = "H5_hotspot_weather",
    quality = "H5_hotspot_uc_quality",
    svfclasses = "H5_hotspot_weather_svfclasses",
    stress = "H9_stress_composite",
    stop("unknown analysis type")
  )
  if (is.null(output_root)) {
    output_root <- file.path(project_root, "output", "statistical_analysis", "results")
  }
  outdir <- file.path(output_root, paste0(basename_out, suffix))
  dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
  paper3_write_exploratory_group_sidecar(
    list(
      dimension = dimension,
      level = level,
      participant_ids = ids,
      assignments = assignments,
      clearness_cutoff = assignments$clearness_cutoff[1L],
      output_suffix = suffix,
      out_dir = outdir
    ),
    outdir
  )

  statdir <- file.path(project_root, "scripts", "statistical_analysis")
  lib <- file.path(statdir, "library")

  if (analysis_type %in% c("weather", "quality", "stress")) {
    source(file.path(lib, "Paper3_common.R"), local = FALSE)
    assign("PAPER3_PARTICIPANTS", ids, envir = .GlobalEnv)
    options(paper3_exploratory_group_ids = ids)
    meeting <- switch(
      analysis_type,
      weather = "H5_hotspot_weather.R",
      quality = "H5_hotspot_uc_quality.R",
      stress = "H9_stress_composite.R"
    )
    source(file.path(statdir, meeting), local = FALSE)
    if (analysis_type == "stress") {
      H9_SPEC$participants <- ids
      source(file.path(lib, "H9_stress_composite_core.R"), local = FALSE)
      assign("OUT_DIR", outdir, envir = .GlobalEnv)
      dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
      h9_dispatch_run()
    } else {
      source(file.path(lib, "H5_hotspot_core.R"), local = FALSE)
      if (analysis_type == "weather") {
        spec <- h5_hotspot_spec
        spec$participants <- ids
        spec$output_dir <- outdir
        spec$write_rh1_per_outcome_coef_csvs <- FALSE
        h5s_dispatch_run(
          spec, project_root,
          file.path(statdir, meeting),
          paper3_merged_8min_path(project_root)
        )
      }
      if (analysis_type == "quality") {
        if (length(ids) < 9L) {
          utils::write.csv(
            data.frame(
              status = "NOT_RUN_INSUFFICIENT_PARTICIPANTS",
              reason = "Original quality script requires at least nine participants per hotspot; subgroup has fewer than nine.",
              n_participants = length(ids)
            ),
            file.path(outdir, paste0("model_status", suffix, ".csv")),
            row.names = FALSE
          )
          cat("Skipped: nine-of-eleven hotspot criterion cannot be met by subgroup.\n")
        } else {
          spec <- h5_uc_base_spec("", FALSE, FALSE)
          spec$participants <- ids
          spec$output_dir <- outdir
          h5s_dispatch_run(
            spec, project_root,
            file.path(statdir, meeting),
            paper3_merged_8min_path(project_root)
          )
        }
      }
    }
  } else {
    input <- file.path(output_root, paste0("H5_hotspot_weather", suffix), paste0("H5_hotspot_day", suffix, ".csv"))
    if (!file.exists(input)) {
      utils::write.csv(
        data.frame(status = "NOT_RUN_MISSING_GROUP_HOTSPOT_DAY", reason = input),
        file.path(outdir, paste0("model_status", suffix, ".csv")),
        row.names = FALSE
      )
      stop("Missing matching grouped hotspot-day input: ", input, call. = FALSE)
    }
    code <- readLines(file.path(statdir, "H5_hotspot_weather_svfclasses.R"), warn = FALSE)
    code[grep("^args <- commandArgs", code)] <- "args <- c(input,outdir)"
    at <- grep("^d <- read.csv\\(input", code)
    stopifnot(length(at) == 1L)
    code <- append(code, "d <- d[d$ParticipantID %in% ids, , drop=FALSE]", after = at)
    code <- gsub("'README.txt'", paste0("'README", suffix, ".txt'"), code, fixed = TRUE)
    assign("ids", ids, envir = .GlobalEnv)
    assign("input", input, envir = .GlobalEnv)
    assign("outdir", outdir, envir = .GlobalEnv)
    assign("suffix", suffix, envir = .GlobalEnv)
    eval(parse(text = code), envir = .GlobalEnv)
  }
  cat("GROUPED DONE", analysis_type, dimension, level, "\n")
  invisible(list(outdir = outdir, participant_ids = ids, suffix = suffix))
}
