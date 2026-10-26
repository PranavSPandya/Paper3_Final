# H4 multivariate LME â€” meeting spec (engine: H4_core.R)
required_packages <- c("car", "nlme", "clubSandwich")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)

script_arg <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
SCRIPT_DIR <- if (length(script_arg)) {
  dirname(normalizePath(script_arg[1], winslash = "/", mustWork = FALSE))
} else {
  wd <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  if (basename(wd) == "scripts") wd else file.path(wd, "scripts")
}
source(file.path(SCRIPT_DIR, "Paper3_common.R"), local = FALSE)

PROJECT_ROOT <- resolve_project_root()
H4_SCRIPT_PATH <- if (length(script_arg) && file.exists(script_arg[1])) script_arg[1] else file.path(PROJECT_ROOT, "scripts/H4_multivariate.R")
RAW_DATA_PATH <- paper3_merged_8min_path(PROJECT_ROOT)
H4_START_MD5 <- unname(tools::md5sum(c(H4_SCRIPT_PATH, RAW_DATA_PATH)))

# Cohort, phase and outcome specification
# physiological: 26 fitted outcomes (indices 1-13 empatica, 14-26 eyetracker).
# Slice examples: empatica only [1:13]; eyetracker only [14:26]; HRV log-transform subset = attr(..., "hrv_log").
H4_SPEC <- list(
  participants = PAPER3_PARTICIPANTS,
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  outcomes = list(physiological = paper3_physiological_outcomes()),
  vif_threshold = 5,
  expected_epochs = 49L,
  # Eq 2 (sound sensitivity) is in the design/VIF catalog; Step 5 fits it only when TRUE.
  fit_sound_sensitivity = FALSE
)

stopifnot(length(H4_SPEC$outcomes$physiological) == 26L)
H4_SPEC$all_outcomes <- H4_SPEC$outcomes$physiological
H4_SPEC$h4_1_outcomes <- H4_SPEC$all_outcomes

hrv_log_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_log")
hrv_fd_outcomes <- function() attr(H4_SPEC$outcomes$physiological, "hrv_fd")

# Data-prep metadata (outcome_transform, bilateral_sources) is set in H4_core.R when sourced.


# ==============================================================================
# SEVEN EXPLICIT MULTIVARIATE LME MODELS (PRIMARY & SENSITIVITY)
# ==============================================================================

# PCA-informed sound mains for proposed Eq 2 (Sound_screening_pca_vif.md); Eq 1 structure unchanged.
H4_EQ2_SOUND_MAIN_TERMS <- c(
  "freq_prop_20_125", "urban_manmade_positive_prop", "vehicle_prop", "wind_prop",
  "freq_prop_8000_20000", "mechanisms_prop", "octave_prop_125_0_hz",
  "urban_manmade_neutral_prop", "freq_prop_4000_8000", "dominant_frequency_hz"
)

# UTCI in rows 1â€“2, 6â€“7: Eq1 primary; Eq2 sound sensitivity on UTCI+PM2.5; Eqs 6â€“7 PM size on UTCI.
equation_spec <- data.frame(
  equation_id = 1:7,
  heat_key = c("UTCI", "UTCI", "AIR_temp + AIR_RH + WIND_AWS", "HUMIDEX", "PET", "UTCI", "UTCI"),
  pm = c("atmo_pm2.5_avg", "atmo_pm2.5_avg", rep("atmo_pm2.5_avg", 3), "atmo_pm1_avg", "atmo_pm10_avg"),
  role = c("primary", "sound_sensitivity", "heat_sensitivity", "heat_sensitivity", "heat_sensitivity",
    "pm_size_sensitivity", "pm_size_sensitivity"),
  stringsAsFactors = FALSE
)

# Nested random intercepts: participant, then phase within participant (random effects, not fixed).
# AR(1) on residuals within bout (correlation structure, not a fixed effect).
# Eq 1 (Primary Model): UTCI * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 2 (Sound sensitivity): Eq 1 + ten PCA-screened sound main effects (freq/semantic props + dominant frequency)
Eq2 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + freq_prop_20_125 + urban_manmade_positive_prop + vehicle_prop + wind_prop + freq_prop_8000_20000 + mechanisms_prop + octave_prop_125_0_hz + urban_manmade_neutral_prop + freq_prop_4000_8000 + dominant_frequency_hz + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 3 (Heat sensitivity - MRT, air temp, RH, wind): MRT * Sound + air temp * Sound + RH * Sound + wind * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq3 <- quote(nlme::lme(
  Y ~ ucm_MRT * ucm_SND_dBA +  ucm_AIR_temp * ucm_SND_dBA + ucm_AIR_RH * ucm_SND_dBA + ucm_WIND_AWS * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 4 (Heat sensitivity â€” HUMIDEX): HUMIDEX * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq4 <- quote(nlme::lme(
  Y ~ ucm_HUMIDEX * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 5 (Heat sensitivity â€” PET): PET * Sound + solar irradiance + SVF (sky view) + PM2.5 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq5 <- quote(nlme::lme(
  Y ~ ucm_PET * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm2.5_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 6 (PM size sensitivity â€” PM1): UTCI * Sound + solar irradiance + SVF (sky view) + PM1 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq6 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm1_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Eq 7 (PM size sensitivity â€” PM10): UTCI * Sound + solar irradiance + SVF (sky view) + PM10 + lux + kelvin (light) + GVI (greenery) + phase WalkG + WalkU + BikeG (sum-to-zero contrasts)
Eq7 <- quote(nlme::lme(
  Y ~ ucm_UTCI * ucm_SND_dBA + ucm_SUN_Gh + SVF_Holmer + atmo_pm10_avg + lys_lux_avg + lys_kelvin_avg + gvi_50m + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data = model_data,
  random = ~ 1 | ParticipantID / PhaseID,
  correlation = nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID),
  method = "REML",
  na.action = na.fail
))

# Pipeline validation: fixed-effect order parsed from the seven formulas above (not edited separately).
h4_fixed_terms_from_lme_quote <- function(lme_quote) {
  fml <- as.formula(lme_quote[[2L]])
  gsub("`", "", attr(terms(fml), "term.labels"), fixed = TRUE)
}
H4_EQUATION_FIXED <- list(
  `1` = h4_fixed_terms_from_lme_quote(Eq1),
  `2` = h4_fixed_terms_from_lme_quote(Eq2),
  `3` = h4_fixed_terms_from_lme_quote(Eq3),
  `4` = h4_fixed_terms_from_lme_quote(Eq4),
  `5` = h4_fixed_terms_from_lme_quote(Eq5),
  `6` = h4_fixed_terms_from_lme_quote(Eq6),
  `7` = h4_fixed_terms_from_lme_quote(Eq7)
)
stopifnot(identical(H4_EQ2_SOUND_MAIN_TERMS, setdiff(H4_EQUATION_FIXED[["2"]], H4_EQUATION_FIXED[["1"]])))

# Equation design and collinearity checks
h4_equation_term_order <- function(eq_id) {
  if (!exists("H4_EQUATION_FIXED", envir = .GlobalEnv, inherits = FALSE)) {
    stop("H4_EQUATION_FIXED not defined; source scripts/H4_multivariate.R first.", call. = FALSE)
  }
  get("H4_EQUATION_FIXED", envir = .GlobalEnv)[[as.character(eq_id)]]
}

h4_equation_thermal_label <- function(row) {
  label <- paste(row$heat_key, row$pm, sep = " / ")
  if (identical(row$role, "sound_sensitivity")) paste0(label, " (sound sensitivity)") else label
}

h4_sound_interaction_terms <- function(terms_order) {
  terms_order[grepl(":", terms_order, fixed = TRUE) & grepl("ucm_SND_dBA", terms_order, fixed = TRUE)]
}

# Step 3 / Step 4 left-to-right domain order (Thermal -> Greenery); phases then sound interactions.
h4_design_main_column_order <- function(heat_vars, env_covars) {
  heat_vars <- unique(as.character(heat_vars))
  env_covars <- unique(as.character(env_covars))
  snd <- intersect("ucm_SND_dBA", env_covars)
  rest <- setdiff(env_covars, c(heat_vars, snd))
  rest <- rest[order(match(rest, unlist(H4_DOMAINS[H4_FLOW_DOMAIN_ORDER], use.names = FALSE)), na.last = TRUE)]
  if (length(heat_vars) && length(snd)) c(heat_vars[1L], snd, heat_vars[-1L], rest) else c(heat_vars, snd, rest)
}

h4_equation_catalog <- function(nonthermal, thermal, equation_spec) {
  expected_thermal <- vapply(seq_len(nrow(equation_spec)), function(i)
    h4_equation_thermal_label(equation_spec[i, , drop = FALSE]), character(1))
  stopifnot(nrow(equation_spec) == 7L, length(thermal) == 7L, identical(names(thermal), expected_thermal))
  out <- do.call(rbind, lapply(seq_len(nrow(equation_spec)), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = equation_spec$equation_id[id], heat_form = names(thermal)[id],
      pm_representation = attr(vars, "pm"), role = equation_spec$role[id],
      primary = equation_spec$role[id] == "primary", block = "heat_x_sound", test = "Noise",
      terms = paste(vapply(h4_equation_term_order(equation_spec$equation_id[id]), h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(equation_spec$heat_key[id], "only"),
      fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 7L, identical(out$equation_id, 1:7), sum(out$primary) == 1L, out$primary[1],
            out$role[1] == "primary", out$role[2] == "sound_sensitivity", !anyDuplicated(out$terms),
            out$pm_representation[1:5] == "atmo_pm2.5_avg",
            out$pm_representation[6:7] == c("atmo_pm1_avg", "atmo_pm10_avg"))
  out$analysis_role <- ifelse(out$primary, "pre-specified primary (UTCI + PM2.5)",
    ifelse(out$role == "sound_sensitivity", "sound-structure sensitivity (Eq1 + PCA sound mains)",
      ifelse(out$role == "heat_sensitivity", "heat-form sensitivity (PM2.5)", "PM size sensitivity (UTCI heat form)")))
  out
}



h4_complete_rows <- function(raw_df, outcome, equation_id, hrv_log = hrv_log_outcomes()) {
  terms <- setdiff(h4_equation_term_order(equation_id), H4_PHASE_SUM_COLS)
  needed <- unique(c(unlist(strsplit(terms, ":", fixed = TRUE)), outcome))
  values <- as.matrix(raw_df[, needed, drop = FALSE])
  storage.mode(values) <- "double"
  ok <- rowSums(!is.finite(values)) == 0L
  if (outcome %in% hrv_log) ok <- ok & raw_df[[outcome]] > 0
  ok
}

h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = H4_SPEC$vif_threshold, write = TRUE) {
  # Explicit local bindings from the Step 4 preparation (no list2env into this frame).
  raw_df <- prep$raw_df
  centered <- prep$centered
  selected <- prep$selected
  catalog <- prep$catalog
  make_design <- prep$make_design
  thermal <- prep$thermal
  if (!design_outcome %in% names(raw_df)) stop("GVIF design outcome not in data: ", design_outcome)
  term_rows <- eq_rows <- list()
  for (i in seq_len(nrow(catalog))) {
    eq <- catalog[i, ]
    ok <- h4_complete_rows(raw_df, design_outcome, eq$equation_id)
    z <- centered[ok, , drop = FALSE]
    phase_vec <- raw_df$PhaseID[ok]
    n_rows <- nrow(z)
    design <- make_design(z, thermal[[eq$heat_form]], phase_vec, test = eq$test,
      terms_order = h4_equation_term_order(eq$equation_id))
    vv <- h4_vif_per_term(design)
    gt <- attr(vv, "gvif_table")
    phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
    mx <- max(vv, na.rm = TRUE)
    id_cols <- data.frame(equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block, test = eq$test,
      design_outcome = design_outcome, n_design_rows = n_rows, stringsAsFactors = FALSE)
    term_rows[[i]] <- data.frame(id_cols, grouped_term = gt$term, GVIF = gt$GVIF, Df = gt$Df, GVIF_root = gt$GVIF_root,
      VIF_equivalent = gt$VIF_equivalent, flag_vif_gt_threshold = gt$Df == 1L & (gt$VIF_equivalent >= vif_threshold | !is.finite(gt$VIF_equivalent)),
      stringsAsFactors = FALSE, row.names = NULL)
    eq_rows[[i]] <- data.frame(id_cols, max_vif_equivalent = mx, worst_grouped_term = names(vv)[which.max(vv)],
      phase_GVIF = phase_gt$GVIF, phase_Df = phase_gt$Df, phase_GVIF_root = phase_gt$GVIF_root,
      phase_vif_equivalent = phase_gt$VIF_equivalent, rank = qr(cbind(1, design))$rank, expected_rank = ncol(design) + 1L,
      full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L, stringsAsFactors = FALSE, row.names = NULL)
  }
  term_df <- do.call(rbind, term_rows)
  by_equation <- do.call(rbind, eq_rows)
  csv_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.csv")
  if (write) {
    dir.create(file.path(OUT_DIR, "H4_models"), recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
  }
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path))
}

# A rank-deficient design blocks fitting; predictors are not removed automatically.
h4_design_preflight <- function(raw_df, centered, selected, catalog, thermal, make_design, fit_equation_ids, outcomes, hrv_log) {
  preflight <- list()
  for (check_y in outcomes) {
    for (check_eid in fit_equation_ids) {
      valid <- h4_complete_rows(raw_df, check_y, check_eid, hrv_log)
      check_z <- centered[valid, , drop = FALSE]
      check_phase <- raw_df$PhaseID[valid]
      check_eq <- catalog[catalog$equation_id == check_eid, ]
      check_x <- make_design(check_z, thermal[[check_eq$heat_form]], check_phase, test = check_eq$test,
        terms_order = h4_equation_term_order(check_eid))
      vv <- h4_vif_per_term(check_x)
      gt <- attr(vv, "gvif_table")
      phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
      if (!nrow(phase_gt)) phase_gt <- data.frame(GVIF = NA_real_, Df = 3L, GVIF_root = NA_real_, VIF_equivalent = NA_real_)
      exposure_terms <- intersect(colnames(check_x), selected)
      cells <- interaction(raw_df$ParticipantID[valid], check_phase, drop = TRUE)
      within_share <- vapply(exposure_terms, function(v) {
        x <- check_x[, v]
        total <- sum((x - mean(x))^2)
        if (total <= 0) return(NA_real_)
        sum((x - ave(x, cells, FUN = mean))^2) / total
      }, numeric(1))
      rr <- qr(cbind(Intercept = 1, check_x))$rank
      sigmas <- apply(check_x, 2L, stats::sd)
      singular <- svd(sweep(sweep(check_x, 2L, colMeans(check_x), "-"), 2L, ifelse(is.finite(sigmas) & sigmas > 0, sigmas, 1), "/"), nu = 0L, nv = 0L)$d
      mx <- max(vv)
      preflight[[length(preflight) + 1L]] <- data.frame(equation_id = check_eid, heat_form = check_eq$heat_form, block = check_eq$block,
        outcome = check_y, n = nrow(check_x), rank = rr, expected_rank = ncol(check_x) + 1L, full_rank = rr == ncol(check_x) + 1L,
        max_vif = mx, worst_term = names(vv)[which.max(vv)], diagnostic = "Design-only GVIF^(1/Df); ordinary VIF for Df=1",
        phase_df = phase_gt$Df, phase_gvif = phase_gt$GVIF, phase_gvif_root = phase_gt$GVIF_root, phase_vif_equivalent = phase_gt$VIF_equivalent,
        term_vif_equivalents = paste(names(vv), signif(vv, 6), sep = "=", collapse = ";"),
        within_participant_phase_variation_share = paste(names(within_share), signif(within_share, 6), sep = "=", collapse = ";"),
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= H4_SPEC$vif_threshold], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= H4_SPEC$vif_threshold, stringsAsFactors = FALSE)
    }
  }
  do.call(rbind, preflight)
}

# Workflow
run_h4 <- function() {
  source(file.path(SCRIPT_DIR, "H4_data_preparation.R"), local = FALSE)
  source(file.path(SCRIPT_DIR, "H4_core.R"), local = FALSE)
  old_modes <- c("H4_RENDER_FLOW_ONLY", "H4_AUDIT_PDF_ONLY", "H4_INCLUDE_AUDIT_PDF", "H4_STEP4_ONLY",
    "H4_GVIF_ONLY", "H4_FACET_REFRESH", "H4_STEP5_ONLY", "H4_STEP6_PRIMARY", "H4_TIME_SENSITIVITY")
  if (any(Sys.getenv(old_modes) == "1")) stop("Unset partial-run flags; this entry runs data preparation, design checks and models.")
  audit <- h4_run_audit()
  prep <- h4_step4_exposure_prep(audit$audit_df, audit$raw_df)
  equations <- if (isTRUE(H4_SPEC$fit_sound_sensitivity)) 1:7 else c(1L, 3:7)
  design_checks <- h4_design_preflight(prep$raw_df, prep$centered, prep$selected,
    prep$catalog, prep$thermal, prep$make_design, equations, H4_SPEC$all_outcomes, hrv_log_outcomes())
  result <- h4_fit(audit$audit_df, prep$raw_df, prep, design_checks)
  h4_write_results(audit$audit_df, result)
  invisible(result)
}

if (sys.nframe() == 0L) run_h4()
