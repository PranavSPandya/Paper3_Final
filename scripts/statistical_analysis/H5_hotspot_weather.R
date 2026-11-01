# H5 exploratory — repeated hotspot exposure × backpack environment (merged CSV only; engine: H5_hotspot_core.R)
# Person-level campaign baseline centering; RH1–RH4 LMMs; participant×hotspot heterogeneity (RH3 random slope + outlier table).
# Outputs: output/statistical_analysis/results/H5_exploratory/
#
# HOTSPOT (§8.0): corridor flat-cap buffer polygons per PhaseID (local copy under data/h5_buffers/).
# Epoch uCM GPS → seg_idx (walk 11 m / bike 35 m along-route cells); all assigned cells enter RH1 (no ≥9/11 rule).
# No cumulative route distance or pct-complete binning for hotspot identity.
# Hyperlocal env: hotspot-day medians from backpack uCM (and atmo/lys on person); NOT station weather in RH1.
# External archives (e.g. Weather Underground) are for optional grid/time enrichment vs uCM — see exposure_columns / future merge.
# Hotspot CHARACTERISTICS (place-intrinsic): SVF, TVF, BVF (CamUp); gps_segment_slope_pct (derived from ucm_GPS_alt).
# Momentary MODEL variables only (not hotspot definition): ucm_UTCI, ucm_AIR_temp, ucm_AIR_RH, ucm_WIND_AWS,
#   ucm_SUN_Gh, ucm_SND_dBA, ucm_PET, ucm_MRT, atmo_pm2.5_avg, lys_lux_avg. gvi_50m = sensitivity only, not definition.

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
paper3_source_statistical_common_if_needed()
paper3_statistical_bootstrap(
  required_packages = c("nlme", "lme4", "sf"),
  load_packages = c("nlme", "lme4", "sf")
)
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
    winslash = "/", mustWork = TRUE
  ),
  route_distance_bin_m = NULL,
  # Pilot: TRUE → WalkG only for shared-hotspot assignment and RH1; FALSE → all PAPER3_CORE_PHASES.
  pilot_walkg_only = FALSE,
  hotspot_inclusion_rule = "corridor_all_assigned",
  spatial_proximity_radius_m = NULL,
  min_participants_shared_place = NULL,
  min_participants_per_shared_bin = 2L,
  min_rows_per_model = 30L,
  min_replication_participant_hotspot_days = 5L,
  # 8-min merge yields ~1 epoch per hotspot-day pass; keep 1 here (use >=3 only if epoch cadence increases).
  min_epochs_per_hotspot_day = 1L,
  # Hotspot_id is PhaseID-specific; stratified RH1 avoids PhaseID + hotspot_f aliasing (61 levels).
  rh1_stratify_by_phase = TRUE,
  rh1_outcome_scope = "all",
  rh1_use_phase_median_response = FALSE,
  rh1_primary_outcomes = c(
    "empatica_eda_tonic", "empatica_skin_temperature",
    "eyetracker_pupil_diameter_avg", "eyetracker_fixation_rate"
  ),
  # Locked exploratory multiplicity (single p_value_FDR in H5_hotspot_core.R; hotspot_f vs env families differ).
  exploratory_fdr_family = "within_outcome_x_phase",
  # Temporary: RH1 only (RH2–RH4 and staged sensitivities disabled in core until restored).
  run_rh1_only = TRUE,
  # RH1 temporal lag (off): prior hotspot-day row UTCI within participant×phase.
  rh1_include_temporal_lag = FALSE,
  rh1_lag_term = "env_ucm_UTCI_lag1_c",
  # RH1 cumulative exposure (sensitivity): set TRUE + results_subdirectory = "cumulative" to rerun; off for primary RH1.
  rh1_include_cumulative_exposure = FALSE,
  rh1_cumulative_term = "env_ucm_UTCI_cum_c",
  results_subdirectory = "",
  # RH1 moderator: grand-mean centered median backpack uCM UTCI at hotspot-day (hyperlocal grid cell, not WU/station).
  environment_moderator_column = "ucm_UTCI",
  outlier_z_threshold = 2,
  # No terrain slope column in merged CSV; point-to-point grade from ucm_GPS_alt (see H5_hotspot_slope_audit.csv).
  slope_column = "gps_segment_slope_pct",
  slope_source = "derived_point_to_point_ucm_GPS_alt_over_haversine_step_m",
  slope_status = "derived_not_in_merge_csv",
  slope_min_horizontal_m = 1,
  derived_exposure_columns = "gps_segment_slope_pct",
  # Hotspot profile aggregation (epoch medians -> hotspot-day): intrinsic SVF/TVF/BVF/slope + momentary uCM/atmo for models.
  exposure_columns = c(
    "SVF", "TVF", "BVF", "gps_segment_slope_pct", "gvi_50m",
    "ucm_UTCI", "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh",
    "ucm_SND_dBA", "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg"
  ),
  # RH1 primary + RH1_sens_* : exactly one additional centered hotspot-day median per sensitivity run.
  sensitivity_covariate_columns = c(
    "ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_SUN_Gh", "ucm_SND_dBA",
    "ucm_PET", "ucm_MRT", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m"
  ),
  reactivity_outcomes = paper3_physiological_outcomes(),
  # (1–2) Campaign baseline: mean outcome across all participant epochs; hotspot rows use median(center_Y).
  use_campaign_baseline_centering = TRUE,
  # (3) RH3: random slope of buffer seg index | ParticipantID (when run_rh1_only = FALSE).
  fit_participant_hotspot_random_slopes = TRUE,
  exploratory_fdr_alpha = 0.05
)

h5_hotspot_spec <- paper3_attach_outcome_normalization(h5_hotspot_spec, PROJECT_ROOT)

# ==== EXPLICIT MODELS (merged CSV backpack env; §8.7 + participant baseline) ====
# Moderator term: env_ucm_UTCI_c = median_ucm_UTCI (hotspot-day) − grand mean.
# PRIMARY RH1 — per PhaseID when rh1_stratify_by_phase=TRUE:
#   lme(median_center_Y ~ env_ucm_UTCI_c + hotspot_f, random = ~1|ParticipantID)
# Else pooled: median_center_Y ~ PhaseID + env_ucm_UTCI_c + hotspot_f
# Sensitivity (optional flags): + env_ucm_UTCI_lag1_c → results/H5_exploratory/lag/;
#   + env_ucm_UTCI_cum_c → results/H5_exploratory/cumulative/ (not GAM/GAMM; same LMM + extra linear term).
# Writes H5_RH1_hotspot_FDR_all_tests.csv (term = PhaseID_gridN, e.g. BikeG_grid1 + p_value_FDR) and H5_RH1_hotspot_FDR_summary.csv;
#   per-outcome RH1_hotspot_coefficients_<outcome>.csv and other detail tables only with PAPER3_WRITE_DETAILS=1.
# Label map: H5_corridor_grid_label_map.csv (buffer seg_idx / route_bin -> BikeG_grid1, WalkU_grid2, …).
# PAUSED (run_rh1_only = TRUE): RH2 green_phase interaction; RH3 route_bin random slope; RH4 mobility_mode;
#   RH1_sens_<cov> staged +1 covariate runs — see h5s_fit_models_and_sensitivity() in H5_hotspot_core.R.

# ==== VIEW-FACTOR MODELS (merged 1 Nov 2026 from H5_hotspot_weather_svfclasses.R, now archived) ====
# Reads H5_hotspot_day.csv written by the RH1 run above (same out_dir). Per PhaseID x outcome:
#   lme(median_center_Y ~ UTCI_c + log10(lux + 1)_c [+ one site view factor OR Gong class],
#       random = ~1|ParticipantID, corAR1(~route_bin|ParticipantID), ML)
# Site view factors = median across visits of each hotspot (SVF, TVF, BVF; per 0.1 unit).
# Classes = Gong et al. 2019 dominance ratios (S, T, B, pairs, A); only classes with >= 3 hotspots tested.
# Lux added 1 Nov 2026 so pupil associations are not read as view effects when they reflect light.
# No hotspot fixed effects: site form is constant within hotspot and not separately identifiable.
# FDR: (1) BH across all continuous view-factor tests (outcomes x phases x SVF/TVF/BVF);
#      (2) separate BH across class omnibus likelihood-ratio tests. Not merged with RH1 families.
# Outputs (prefix H5_view_): model_coefficients (always); with PAPER3_WRITE_DETAILS=1 also site_classes,
#   class_coverage, site_factor_correlations, model_comparisons, skipped_models, README (output reduction 2026-11-01).
h5_run_view_models <- function(out_dir) {
  write_details <- identical(Sys.getenv("PAPER3_WRITE_DETAILS", unset = ""), "1")
  input <- file.path(out_dir, "H5_hotspot_day.csv")
  if (!file.exists(input)) stop("Missing hotspot-day input for view models: ", input, call. = FALSE)
  d <- read.csv(input, stringsAsFactors = FALSE, check.names = FALSE)
  names(d)[names(d) %in% c("participant_id", "phase_id")] <- c(participant_id = "ParticipantID", phase_id = "PhaseID")[names(d)[names(d) %in% c("participant_id", "phase_id")]]  # finalized file uses snake_case ids
  required <- c("ParticipantID", "PhaseID", "hotspot_id", "route_bin", "median_ucm_UTCI",
                "median_lys_lux_avg", "median_SVF", "median_TVF", "median_BVF")
  stopifnot(all(required %in% names(d)))
  for (v in c("route_bin", "median_ucm_UTCI", "median_lys_lux_avg", "median_SVF", "median_TVF", "median_BVF")) d[[v]] <- as.numeric(d[[v]])
  site <- aggregate(d[c("median_SVF", "median_TVF", "median_BVF")], list(hotspot_id = d$hotspot_id, PhaseID = d$PhaseID),
                    function(x) if (all(!is.finite(x))) NA_real_ else median(x, na.rm = TRUE))
  sv <- as.matrix(site[c("median_SVF", "median_TVF", "median_BVF")]); cls <- rep(NA_character_, nrow(site))
  for (i in seq_len(nrow(site))) {
    x <- sv[i, ]; if (any(!is.finite(x)) || any(x < 0) || sum(x) <= 0) next
    ord <- order(x, decreasing = TRUE); z <- x[ord]; lab <- c("S", "T", "B")[ord]
    cls[i] <- if (z[1] >= 2 * z[2]) lab[1] else if (z[2] >= 2 * z[3]) paste(sort(lab[1:2]), collapse = "") else "A"
  }
  site$class <- cls
  names(site)[3:5] <- c("site_SVF", "site_TVF", "site_BVF")
  d <- merge(d, site, by = c("hotspot_id", "PhaseID"), all.x = TRUE, sort = FALSE)
  if (write_details) write.csv(site, file.path(out_dir, "H5_view_site_classes.csv"), row.names = FALSE, na = "")
  coverage <- do.call(rbind, lapply(split(d, interaction(d$PhaseID, d$class, drop = TRUE)), function(x)
    data.frame(phase = x$PhaseID[1], class = x$class[1], rows = nrow(x), participants = length(unique(x$ParticipantID)),
               hotspots = length(unique(x$hotspot_id)))))
  if (write_details) write.csv(coverage, file.path(out_dir, "H5_view_class_coverage.csv"), row.names = FALSE)
  corr <- do.call(rbind, lapply(split(site, site$PhaseID), function(x) {
    m <- cor(x[c("site_SVF", "site_TVF", "site_BVF")], use = "pairwise.complete.obs")
    data.frame(phase = x$PhaseID[1], factor = rownames(m), m, row.names = NULL)
  }))
  if (write_details) write.csv(corr, file.path(out_dir, "H5_view_site_factor_correlations.csv"), row.names = FALSE, na = "")
  outcomes <- grep("^median_center_", names(d), value = TRUE)
  res <- list(); comp <- list(); skipped <- list()
  addskip <- function(ph, oc, mod, reason) {
    skipped[[length(skipped) + 1L]] <<- data.frame(phase = ph, outcome = oc, model = mod, reason = as.character(reason))
  }
  fit <- function(form, dat) nlme::lme(form, random = ~ 1 | ParticipantID,
    correlation = nlme::corAR1(form = ~ route_bin | ParticipantID), data = dat, method = "ML",
    na.action = na.fail, control = nlme::lmeControl(maxIter = 100, msMaxIter = 100, returnObject = FALSE))
  for (ph in unique(d$PhaseID)) for (oc in outcomes) for (kind in c("SVF", "TVF", "BVF", "class")) {
    x <- d[d$PhaseID == ph, , drop = FALSE]; v <- if (kind == "class") "class" else paste0("site_", kind)
    x <- x[is.finite(x[[oc]]) & is.finite(x$median_ucm_UTCI) & is.finite(x$median_lys_lux_avg) &
           x$median_lys_lux_avg >= 0 & is.finite(x$route_bin) & !is.na(x[[v]]), , drop = FALSE]
    if (kind != "class") x <- x[is.finite(x[[v]]), , drop = FALSE]
    x <- x[order(x$ParticipantID, x$route_bin), , drop = FALSE]
    if (nrow(x) < 30 || length(unique(x$ParticipantID)) < 6 || length(unique(x$hotspot_id)) < 5) {
      addskip(ph, oc, kind, "insufficient observations, participants or hotspots"); next
    }
    if (any(duplicated(x[c("ParticipantID", "route_bin")]))) { addskip(ph, oc, kind, "duplicate participant route position"); next }
    x$y <- x[[oc]]; x$utci <- x$median_ucm_UTCI - mean(x$median_ucm_UTCI)
    x$lux <- log10(x$median_lys_lux_avg + 1); x$lux <- x$lux - mean(x$lux)
    if (kind == "class") {
      tab <- table(x$class, x$hotspot_id) > 0; nsites <- rowSums(tab); eligible <- names(nsites)[nsites >= 3]
      x <- x[x$class %in% eligible, , drop = FALSE]; x$class <- droplevels(factor(x$class))
      if (nlevels(x$class) < 2 || nrow(x) < 30 || length(unique(x$ParticipantID)) < 6) {
        addskip(ph, oc, kind, "fewer than two classes with at least three hotspots"); next
      }
      x$exposure <- x$class
    } else {
      x$exposure <- x[[v]] * 10 # effect per 0.1 unit
      if (sd(x$exposure) < 1e-8) { addskip(ph, oc, kind, "no factor variation"); next }
    }
    base <- tryCatch(fit(y ~ utci + lux, x), error = function(e) e)
    full <- tryCatch(fit(y ~ utci + lux + exposure, x), error = function(e) e)
    if (inherits(base, "error") || inherits(full, "error")) {
      addskip(ph, oc, kind, paste(if (inherits(base, "error")) conditionMessage(base) else "",
                                  if (inherits(full, "error")) conditionMessage(full) else "")); next
    }
    tt <- summary(full)$tTable; b <- summary(base)$tTable
    lrt <- tryCatch(anova(base, full), error = function(e) NULL)
    lrp <- if (!is.null(lrt)) as.numeric(lrt$`p-value`[2]) else NA_real_
    for (term in rownames(tt)) res[[length(res) + 1L]] <- data.frame(
      phase = ph, outcome = sub("^median_center_", "", oc), model = kind, term = term,
      estimate = tt[term, "Value"], se = tt[term, "Std.Error"], df = tt[term, "DF"], p = tt[term, "p-value"],
      ci_low = tt[term, "Value"] - qt(.975, tt[term, "DF"]) * tt[term, "Std.Error"],
      ci_high = tt[term, "Value"] + qt(.975, tt[term, "DF"]) * tt[term, "Std.Error"],
      n = nrow(x), participants = length(unique(x$ParticipantID)), hotspots = length(unique(x$hotspot_id)),
      class_reference = if (kind == "class") levels(x$class)[1] else NA_character_,
      ar1 = as.numeric(coef(full$modelStruct$corStruct, unconstrained = FALSE)))
    comp[[length(comp) + 1L]] <- data.frame(
      phase = ph, outcome = sub("^median_center_", "", oc), model = kind, n = nrow(x),
      participants = length(unique(x$ParticipantID)), hotspots = length(unique(x$hotspot_id)),
      utci_before = b["utci", "Value"], utci_after = tt["utci", "Value"],
      lux_before = b["lux", "Value"], lux_after = tt["lux", "Value"],
      aic_baseline = AIC(base), aic_view = AIC(full), lrt_p = lrp)
  }
  if (length(res)) {
    r <- do.call(rbind, res); r$fdr_q <- NA_real_
    ix <- r$model != "class" & r$term == "exposure" & is.finite(r$p)
    r$fdr_q[ix] <- p.adjust(r$p[ix], method = "BH"); r$fdr_significant <- !is.na(r$fdr_q) & r$fdr_q < .05
    write.csv(r, file.path(out_dir, "H5_view_model_coefficients.csv"), row.names = FALSE, na = "")
  }
  if (length(comp)) {
    cc <- do.call(rbind, comp); cc$class_omnibus_fdr_q <- NA_real_
    ix <- cc$model == "class" & is.finite(cc$lrt_p)
    cc$class_omnibus_fdr_q[ix] <- p.adjust(cc$lrt_p[ix], method = "BH")
    if (write_details) write.csv(cc, file.path(out_dir, "H5_view_model_comparisons.csv"), row.names = FALSE, na = "")
  }
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
  invisible(list(coefficients = if (length(res)) r else NULL, comparisons = if (length(comp)) cc else NULL))
}

run_h5_hotspot_weather <- function() {
  core_path <- file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R")
  if (!file.exists(core_path)) stop("Missing H5 hotspot engine: ", core_path, call. = FALSE)
  source(core_path, local = FALSE)
  h5s_dispatch_run(
    spec = h5_hotspot_spec,
    project_root = PROJECT_ROOT,
    script_path = H5_SCRIPT_PATH,
    raw_data_path = RAW_DATA_PATH
  )
  h5_run_view_models(h5s_output_dir(PROJECT_ROOT, h5_hotspot_spec))
}

# --view-only: refit only the view-factor models from the existing H5_hotspot_day.csv (no RH1 rerun).
if (sys.nframe() == 0L) {
  if ("--view-only" %in% commandArgs(trailingOnly = TRUE)) {
    source(file.path(paper3_statistical_library_dir(), "H5_hotspot_core.R"), local = FALSE)
    h5_run_view_models(h5s_output_dir(PROJECT_ROOT, h5_hotspot_spec))
  } else {
    run_h5_hotspot_weather()
  }
}

# Normalize final CSV presentation only after all analysis/report calculations.
if (sys.nframe() == 0L) paper3_standardize_result_directory(file.path(resolve_project_root(), "output", "statistical_analysis", "results", "H5_exploratory"))
