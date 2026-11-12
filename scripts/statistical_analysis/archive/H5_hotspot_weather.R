# H5 exploratory: repeated hotspot exposure x backpack environment, RH1 LMMs and view-factor models (engine: library/H5_hotspot_core.R).
# Output: output/statistical_analysis/results/H5_hotspot_weather/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = c("nlme", "sf"),
  load_packages = c("nlme", "sf"))
PROJECT_ROOT <- resolve_project_root()
H5_SCRIPT_PATH <- paper3_entry_script_path("scripts/statistical_analysis/H5_hotspot_weather.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)

h5_hotspot_spec <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  physiological_outcome_names = paper3_physiological_outcomes(),
  green_phases = c("WalkG", "BikeG"),
  hotspot_definition = "corridor_buffer",
  buffer_gpkg_dir = normalizePath(
    file.path(paper3_statistical_script_dir(), "data", "h5_buffers"),
    winslash = "/", mustWork = TRUE),
  min_rows_per_model = 30L,
  # The 8-min merge gives about 1 epoch per hotspot-day pass, so keep 1.
  min_epochs_per_hotspot_day = 1L,
  # Hotspot ids are phase-specific; stratifying RH1 by phase avoids PhaseID/hotspot aliasing.
  rh1_stratify_by_phase = TRUE,
  rh1_outcome_scope = "all",
  rh1_use_phase_median_response = FALSE, i
  rh1_primary_outcomes = c(
    "empatica_eda_tonic", "empatica_skin_temperature",
    "eyetracker_pupil_diameter_avg", "eyetracker_fixation_rate"),
  # Exploratory BH family (hotspot_f and env terms use different families).
  exploratory_fdr_family = "within_outcome_x_phase",
  # Group every 3 adjacent corridor cells before the cell factor.
  adjacent_cell_group = 3L,
  # Within-person linear route trend removed before the cell model for slow signals.
  slow_drift_outcomes = c("empatica_skin_temperature", "empatica_eda_tonic"),
  # log1p only where the shared normalization table leaves the column untransformed.
  h5_log1p_outcomes = c(
    "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s",
    "eyetracker_saccade_duration_s", "eyetracker_saccade_amplitude",
    "eyetracker_saccade_peak_velocity", "eyetracker_gaze_velocity",
    "eyetracker_gaze_dispersion"),
  # RH1 moderator: grand-mean centred hotspot-day median of backpack UTCI, plus the previous cell.
  environment_moderator_column = "ucm_UTCI",
  rh1_include_temporal_lag = TRUE,
  rh1_lag_term = "env_ucm_UTCI_lag1_c",
  results_subdirectory = "",
  # No slope column in the merged CSV; the grade is computed from ucm_GPS_alt.
  slope_column = "gps_segment_slope_pct",
  slope_min_horizontal_m = 1,
  derived_exposure_columns = "gps_segment_slope_pct",
  # Hotspot-day medians of the epoch values (site SVF/TVF/BVF/slope and momentary uCM/atmo).
  exposure_columns = c(
    "SVF", "TVF", "BVF", "gps_segment_slope_pct", "gvi_50m",
    "ucm_UTCI", "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh",
    "ucm_SND_dBA", "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg"),
  # Centred hotspot-day covariates listed in the manifest.
  sensitivity_covariate_columns = c(
    "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh", "ucm_SND_dBA",
    "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m"),
  reactivity_outcomes = paper3_physiological_outcomes(),
  # (1-2) Campaign baseline: participant mean over all epochs; hotspot rows use median(center_Y).
  use_campaign_baseline_centering = TRUE,
  exploratory_fdr_alpha = 0.05)

h5_hotspot_spec <- paper3_attach_outcome_normalization(h5_hotspot_spec, PROJECT_ROOT)

# Primary RH1 per phase: lme(median_center_Y ~ env_ucm_UTCI_c + hotspot_f, random = ~1|ParticipantID, corAR1(~route_bin | ParticipantID/PhaseID)).

# View-factor models per phase x outcome: lme(median_center_Y ~ UTCI_c + log10(lux + 1)_c + one view factor or Gong et al. 2019 class, ML), BH per family.
h5_run_view_models <- function(out_dir) {
  write_details <- identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")
  input <- file.path(out_dir, "H5_hotspot_day.csv")
  if (!file.exists(input)) stop("Missing hotspot-day input for view models: ", input, call. = FALSE)
  grid_data <- read.csv(input, stringsAsFactors = FALSE, check.names = FALSE)
  names(grid_data)[names(grid_data) %in% c("participant_id", "phase_id")] <- c(participant_id = "ParticipantID", phase_id = "PhaseID")[names(grid_data)[names(grid_data) %in% c("participant_id", "phase_id")]]  # finalized file uses snake_case ids
  required <- c("ParticipantID", "PhaseID", "hotspot_id", "route_bin", "median_ucm_UTCI",
                "median_lys_lux_avg", "median_SVF", "median_TVF", "median_BVF")
  stopifnot(all(required %in% names(grid_data)))
  for (column_name in c("route_bin", "median_ucm_UTCI", "median_lys_lux_avg", "median_SVF", "median_TVF", "median_BVF")) grid_data[[column_name]] <- as.numeric(grid_data[[column_name]])
  site <- aggregate(grid_data[c("median_SVF", "median_TVF", "median_BVF")], list(hotspot_id = grid_data$hotspot_id, PhaseID = grid_data$PhaseID),
                    function(x) if (all(!is.finite(x))) NA_real_ else median(x, na.rm = TRUE))
  sv <- as.matrix(site[c("median_SVF", "median_TVF", "median_BVF")]); cls <- rep(NA_character_, nrow(site))
  for (index in seq_len(nrow(site))) {
    x <- sv[index, ]; if (any(!is.finite(x)) || any(x < 0) || sum(x) <= 0) next
    ord <- order(x, decreasing = TRUE); z <- x[ord]; lab <- c("S", "T", "B")[ord]
    cls[index] <- if (z[1] >= 2 * z[2]) lab[1] else if (z[2] >= 2 * z[3]) paste(sort(lab[1:2]), collapse = "") else "A"}
  site$class <- cls
  names(site)[3:5] <- c("site_SVF", "site_TVF", "site_BVF")
  grid_data <- merge(grid_data, site, by = c("hotspot_id", "PhaseID"), all.x = TRUE, sort = FALSE)
  if (write_details) write.csv(site, file.path(out_dir, "H5_view_site_classes.csv"), row.names = FALSE, na = "")
  coverage <- do.call(rbind, lapply(split(grid_data, interaction(grid_data$PhaseID, grid_data$class, drop = TRUE)), function(x)
    data.frame(phase = x$PhaseID[1], class = x$class[1], rows = nrow(x), participants = length(unique(x$ParticipantID)),
               hotspots = length(unique(x$hotspot_id)))))
  if (write_details) write.csv(coverage, file.path(out_dir, "H5_view_class_coverage.csv"), row.names = FALSE)
  corr <- do.call(rbind, lapply(split(site, site$PhaseID), function(x) {
    correlation_matrix <- cor(x[c("site_SVF", "site_TVF", "site_BVF")], use = "pairwise.complete.obs")
    data.frame(phase = x$PhaseID[1], factor = rownames(correlation_matrix), correlation_matrix, row.names = NULL)
  }))
  if (write_details) write.csv(corr, file.path(out_dir, "H5_view_site_factor_correlations.csv"), row.names = FALSE, na = "")
  outcomes <- grep("^median_center_", names(grid_data), value = TRUE)
  res <- list(); comp <- list(); skipped <- list()
  addskip <- function(local_phase, oc, mod, reason) {
    skipped[[length(skipped) + 1L]] <<- data.frame(phase = local_phase, outcome = oc, model = mod, reason = as.character(reason))}
  fit <- function(form, dat) nlme::lme(form, random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ route_bin | ParticipantID), data = dat, method = "ML",
    na.action = na.fail, control = nlme::lmeControl(maxIter = 100, msMaxIter = 100, returnObject = FALSE))
  for (local_phase in unique(grid_data$PhaseID)) for (oc in outcomes) for (kind in c("SVF", "TVF", "BVF", "class")) {
    x <- grid_data[grid_data$PhaseID == local_phase, , drop = FALSE]; column_name <- if (kind == "class") "class" else paste0("site_", kind)
    x <- x[is.finite(x[[oc]]) & is.finite(x$median_ucm_UTCI) & is.finite(x$median_lys_lux_avg) &
           x$median_lys_lux_avg >= 0 & is.finite(x$route_bin) & !is.na(x[[column_name]]), , drop = FALSE]
    if (kind != "class") x <- x[is.finite(x[[column_name]]), , drop = FALSE]
    x <- x[order(x$ParticipantID, x$route_bin), , drop = FALSE]
    if (nrow(x) < 30 || length(unique(x$ParticipantID)) < 6 || length(unique(x$hotspot_id)) < 5) {
      addskip(local_phase, oc, kind, "insufficient observations, participants or hotspots"); next}
    if (any(duplicated(x[c("ParticipantID", "route_bin")]))) { addskip(local_phase, oc, kind, "duplicate participant route position"); next }
    x$y <- x[[oc]]; x$utci <- x$median_ucm_UTCI - mean(x$median_ucm_UTCI)
    x$lux <- log10(x$median_lys_lux_avg + 1); x$lux <- x$lux - mean(x$lux)
    if (kind == "class") {
      tab <- table(x$class, x$hotspot_id) > 0; nsites <- rowSums(tab); eligible <- names(nsites)[nsites >= 3]
      x <- x[x$class %in% eligible, , drop = FALSE]; x$class <- droplevels(factor(x$class))
      if (nlevels(x$class) < 2 || nrow(x) < 30 || length(unique(x$ParticipantID)) < 6) {
        addskip(local_phase, oc, kind, "fewer than two classes with at least three hotspots"); next}
      x$exposure <- x$class
    } else {
      x$exposure <- x[[column_name]] * 10 # effect per 0.1 unit
      if (sd(x$exposure) < 1e-8) { addskip(local_phase, oc, kind, "no factor variation"); next }
    }
    base <- tryCatch(fit(y ~ utci + lux, x), error = function(local_error) local_error)
    full <- tryCatch(fit(y ~ utci + lux + exposure, x), error = function(local_error) local_error)
    if (inherits(base, "error") || inherits(full, "error")) {
      addskip(local_phase, oc, kind, paste(if (inherits(base, "error")) conditionMessage(base) else "",
                                  if (inherits(full, "error")) conditionMessage(full) else "")); next}
    tt <- summary(full)$tTable; baseline_coefficients <- summary(base)$tTable
    lrt <- tryCatch(anova(base, full), error = function(local_error) NULL)
    lrp <- if (!is.null(lrt)) as.numeric(lrt$`p-value`[2]) else NA_real_
    for (term in rownames(tt)) res[[length(res) + 1L]] <- data.frame(
      phase = local_phase, outcome = sub("^median_center_", "", oc), model = kind, term = term,
      estimate = tt[term, "Value"], se = tt[term, "Std.Error"], df = tt[term, "DF"], p = tt[term, "p-value"],
      ci_low = tt[term, "Value"] - qt(.975, tt[term, "DF"]) * tt[term, "Std.Error"],
      ci_high = tt[term, "Value"] + qt(.975, tt[term, "DF"]) * tt[term, "Std.Error"],
      n = nrow(x), participants = length(unique(x$ParticipantID)), hotspots = length(unique(x$hotspot_id)),
      class_reference = if (kind == "class") levels(x$class)[1] else NA_character_,
      ar1 = as.numeric(coef(full$modelStruct$corStruct, unconstrained = FALSE)))
    comp[[length(comp) + 1L]] <- data.frame(
      phase = local_phase, outcome = sub("^median_center_", "", oc), model = kind, n = nrow(x),
      participants = length(unique(x$ParticipantID)), hotspots = length(unique(x$hotspot_id)),
      utci_before = baseline_coefficients["utci", "Value"], utci_after = tt["utci", "Value"],
      lux_before = baseline_coefficients["lux", "Value"], lux_after = tt["lux", "Value"],
      aic_baseline = AIC(base), aic_view = AIC(full), lrt_p = lrp)}
  if (length(res)) {
    coefficient_results <- do.call(rbind, res); coefficient_results$fdr_q <- NA_real_
    ix <- coefficient_results$model != "class" & coefficient_results$term == "exposure" & is.finite(coefficient_results$p)
    coefficient_results$fdr_q[ix] <- p.adjust(coefficient_results$p[ix], method = "BH"); coefficient_results$fdr_significant <- !is.na(coefficient_results$fdr_q) & coefficient_results$fdr_q < .05
    # Each row without q says why it is outside the BH family.
    coefficient_results$fdr_note <- ifelse(ix, "",
      ifelse(coefficient_results$model == "class" & coefficient_results$term %in% c("(Intercept)", "utci", "lux"),
        "No q: intercept or UTCI/lux adjustment term of a class model; not a view-factor test (outside the BH family)",
      ifelse(coefficient_results$model == "class",
        "No q: class-level contrast vs the reference class; descriptive only. Class effects are tested by the omnibus LRT (separate BH family, H5_view_model_comparisons)",
      ifelse(coefficient_results$term != "exposure",
        "No q: intercept or UTCI/lux adjustment term; not a view-factor test (outside the BH family)",
        "No q: p value not finite"))))
    write.csv(coefficient_results, file.path(out_dir, "H5_view_model_coefficients.csv"), row.names = FALSE, na = "")}
  if (length(comp)) {
    cc <- do.call(rbind, comp); cc$class_omnibus_fdr_q <- NA_real_
    ix <- cc$model == "class" & is.finite(cc$lrt_p)
    cc$class_omnibus_fdr_q[ix] <- p.adjust(cc$lrt_p[ix], method = "BH")
    if (write_details) write.csv(cc, file.path(out_dir, "H5_view_model_comparisons.csv"), row.names = FALSE, na = "")}
  if (length(skipped) && write_details) write.csv(do.call(rbind, skipped), file.path(out_dir, "H5_view_skipped_models.csv"), row.names = FALSE, na = "")
  if (write_details) writeLines(c(
    "H5 view-factor models (merged into H5_hotspot_weather.R on 1 Nov 2026; formerly H5_hotspot_weather_svfclasses.R).",
    "Class labels use Gong et al. 2019 dominance ratios applied to upward camera view factors; an adaptation, not a validated thermal threshold. ST = Gong TS (alphabetical order).",
    "Each site factor is the median across visits to the same hotspot; separate models for SVF, TVF and BVF.",
    "Per phase and outcome: participant-centered response ~ UTCI_c + log10(lux + 1)_c + one site view factor OR class; random participant intercept; AR1 along route positions; ML.",
    "No hotspot fixed effects: site form and hotspot indicators are not separately identifiable.",
    "Class comparisons include only classes with >= 3 hotspots; reference class alphabetically first.",
    "Continuous view-factor coefficients are per 0.1 increase; some phase ranges are smaller than 0.1, so compare over observed ranges.",
    "FDR: BH across all continuous view-factor tests; separate BH across class omnibus LRTs; class level p values unadjusted, descriptive only. Not merged with RH1 FDR.",
    "Baseline for LRT and AIC = UTCI + lux model with the same rows and structure.",
    "Pupil outcomes may still reflect illumination not captured by the person-worn lux sensor.",
    "Input MD5:", unname(tools::md5sum(input))), file.path(out_dir, "H5_view_README.txt"))
  cat("[H5 view models] Wrote:", out_dir, " fits:", length(comp), " skips:", length(skipped), "\n")
  invisible(list(coefficients = if (length(res)) coefficient_results else NULL, comparisons = if (length(comp)) cc else NULL))}

run_h5_hotspot_weather <- function() {
  core_path <- file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R")
  if (!file.exists(core_path)) stop("Missing H5 hotspot engine: ", core_path, call. = FALSE)
  source(core_path, local = FALSE)
  h5s_archive_legacy_output_dir(PROJECT_ROOT)
  h5s_dispatch_run(
    spec = h5_hotspot_spec,
    project_root = PROJECT_ROOT,
    script_path = H5_SCRIPT_PATH,
    raw_data_path = RAW_DATA_PATH)
  h5_run_view_models(h5s_output_dir(PROJECT_ROOT, h5_hotspot_spec))}

# --view-only: refit only the view-factor models from the existing H5_hotspot_day.csv.
if (sys.nframe() == 0L) {
  if ("--view-only" %in% commandArgs(trailingOnly = TRUE)) {
    source(file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R"), local = FALSE)
    h5_run_view_models(h5s_output_dir(PROJECT_ROOT, h5_hotspot_spec))
  } else {
    run_h5_hotspot_weather()}
}

# Tidy final CSV presentation after all calculations.
if (sys.nframe() == 0L) p3_finalize_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "H5_hotspot_weather"))
