# Shared corridor buffer grid assignment (H5 buffer GPKG + Python join; H1–H4 timeseries grid_f).

paper3_corridor_buffer_gpkg_dir <- function() {
  "D:/Pranav/docker/ExpData/Experiment path_8min_buffer"
}

paper3_corridor_grid_cache_path <- function(root = resolve_project_root()) {
  file.path(root, "output", "statistical_analysis", "cache", "corridor_epoch_grid_assignment.csv")
}

paper3_corridor_grid_cache_md5_path <- function(root = resolve_project_root()) {
  paste0(paper3_corridor_grid_cache_path(root), ".merged_md5")
}

paper3_run_buffer_spatial_join <- function(merged_path, buffer_dir, out_csv) {
  py <- file.path(paper3_statistical_library_dir(), "H5_buffer_spatial_join.py")
  if (!file.exists(py)) stop("Missing ", py, call. = FALSE)
  dir.create(dirname(out_csv), recursive = TRUE, showWarnings = FALSE)
  out_csv <- normalizePath(out_csv, winslash = "/", mustWork = FALSE)
  merged_path <- normalizePath(merged_path, winslash = "/", mustWork = TRUE)
  buffer_dir <- normalizePath(buffer_dir, winslash = "/", mustWork = TRUE)
  pyexe <- Sys.which("python")
  if (!nzchar(pyexe)) stop("python not found on PATH", call. = FALSE)
  # Windows: paths with spaces (e.g. Experiment path_8min_buffer) must be shell-quoted.
  if (.Platform$OS.type == "windows") {
    cmd <- paste(
      shQuote(pyexe),
      shQuote(py),
      shQuote(merged_path),
      shQuote(buffer_dir),
      shQuote(out_csv),
      sep = " "
    )
    out <- system(cmd, intern = TRUE)
    status <- attr(out, "status")
  } else {
    args <- c(py, merged_path, buffer_dir, out_csv)
    out <- system2(pyexe, args, stdout = TRUE, stderr = TRUE)
    status <- attr(out, "status")
  }
  if (!is.null(status) && status != 0L) {
    stop("H5_buffer_spatial_join.py failed:\n", paste(out, collapse = "\n"), call. = FALSE)
  }
  if (!file.exists(out_csv)) {
    stop("H5_buffer_spatial_join.py did not create ", out_csv, ":\n", paste(out, collapse = "\n"), call. = FALSE)
  }
  invisible(out_csv)
}

paper3_ensure_corridor_grid_assignment <- function(root, merged_path) {
  merged_path <- normalizePath(merged_path, winslash = "/", mustWork = TRUE)
  if (!file.exists(merged_path)) stop("Merged CSV not found: ", merged_path, call. = FALSE)
  cache_path <- paper3_corridor_grid_cache_path(root)
  md5_path <- paper3_corridor_grid_cache_md5_path(root)
  merged_md5 <- unname(tools::md5sum(merged_path))
  stale <- !file.exists(cache_path)
  if (!stale && file.exists(md5_path)) {
    stored <- trimws(readLines(md5_path, warn = FALSE))
    if (!length(stored) || stored[1L] != merged_md5) stale <- TRUE
  } else if (!stale) {
    stale <- file.info(merged_path)$mtime > file.info(cache_path)$mtime
  }
  if (stale) {
    paper3_run_buffer_spatial_join(merged_path, paper3_corridor_buffer_gpkg_dir(), cache_path)
    writeLines(merged_md5, md5_path)
  }
  invisible(cache_path)
}

paper3_grid_number <- function(route_bin) {
  as.integer(route_bin) + 1L
}

paper3_grid_label <- function(phase_id, route_bin) {
  paste0(as.character(phase_id), "_grid", paper3_grid_number(route_bin))
}

paper3_merge_corridor_grid_columns <- function(df, root = resolve_project_root()) {
  merged_path <- paper3_merged_8min_path(root)
  paper3_ensure_corridor_grid_assignment(root, merged_path)
  joined <- read.csv(paper3_corridor_grid_cache_path(root), stringsAsFactors = FALSE, check.names = FALSE)
  joined$Datetime <- as.POSIXct(joined$Datetime, tz = "UTC")
  out <- df
  out$Datetime <- as.POSIXct(out$Datetime, tz = "UTC")
  key <- paste(out$ParticipantID, out$PhaseID, out$Datetime)
  jkey <- paste(joined$ParticipantID, joined$PhaseID, joined$Datetime)
  idx <- match(key, jkey)
  seg <- as.integer(joined$buffer_seg_idx[idx])
  out$buffer_seg_idx <- seg
  out$route_bin <- seg
  out$grid_label <- ifelse(is.finite(seg), mapply(paper3_grid_label, as.character(out$PhaseID), seg, USE.NAMES = FALSE), NA_character_)
  out
}

paper3_attach_grid_factor <- function(df) {
  if (!"grid_label" %in% names(df)) stop("grid_label missing; run paper3_merge_corridor_grid_columns first.", call. = FALSE)
  levels_all <- sort(unique(df$grid_label[!is.na(df$grid_label)]))
  df$grid_f <- factor(df$grid_label, levels = levels_all)
  df
}

paper3_mode_grid_label <- function(x) {
  x <- x[!is.na(x)]
  if (!length(x)) return(NA_character_)
  tb <- sort(table(x), decreasing = TRUE)
  names(tb)[1L]
}

paper3_grid_term_display <- function(term) {
  if (!grepl("^grid_f", term, fixed = FALSE)) return(term)
  sub("^grid_f", "", term, fixed = FALSE)
}

paper3_is_grid_lmm_term <- function(term) {
  grepl("^grid_f", term, fixed = FALSE)
}

paper3_write_epoch_grid_coverage <- function(df, path) {
  need <- c("PhaseID", "grid_label")
  if (!all(need %in% names(df))) stop("Coverage table requires PhaseID and grid_label.", call. = FALSE)
  sub <- df[!is.na(df$grid_label), need, drop = FALSE]
  if (!nrow(sub)) {
    utils::write.csv(data.frame(PhaseID = character(), grid_label = character(), n_epochs = integer()),
      path, row.names = FALSE, na = "")
    return(invisible(path))
  }
  agg <- as.data.frame(table(sub), stringsAsFactors = FALSE)
  names(agg) <- c("PhaseID", "grid_label", "n_epochs")
  utils::write.csv(agg[order(agg$PhaseID, agg$grid_label), , drop = FALSE], path, row.names = FALSE, na = "")
  invisible(path)
}

paper3_timeseries_attach_corridor_grid <- function(raw_df, root = resolve_project_root()) {
  if ("grid_f" %in% names(raw_df)) return(raw_df)
  paper3_attach_grid_factor(paper3_merge_corridor_grid_columns(raw_df, root))
}
