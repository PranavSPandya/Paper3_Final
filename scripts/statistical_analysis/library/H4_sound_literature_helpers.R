# H4 source-informed adaptations plus the present-study interaction analysis; not exact source replications.
# Nominal p only. Each source keeps its own published decision rule; no FDR correction is applied.

H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
H4_PAIR_AVERAGES <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))

H4_UTIL <- list(
  bouts = function(epochs) split(seq_len(nrow(epochs)), interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)),
  finite_mean = function(x) { x <- x[is.finite(x)]; if (length(x)) mean(x) else NA_real_ },
  finite_sd = function(x) { x <- x[is.finite(x)]; if (length(x) > 1) stats::sd(x) else NA_real_ },
  finite_max = function(x) { x <- x[is.finite(x)]; if (length(x)) max(x) else NA_real_ },
  energy_mean_db = function(level_db) {
    level_db <- level_db[is.finite(level_db)]
    if (!length(level_db)) return(NA_real_)
    10 * log10(mean(10^(level_db / 10)))},
  z = function(x) {
    x <- as.numeric(x)
    s <- stats::sd(x[is.finite(x)])
    if (!is.finite(s) || s == 0) x else (x - mean(x, na.rm = TRUE)) / s},
  row = function(...) data.frame(..., stringsAsFactors = FALSE))

# ---------------------------------------------------------------------------
# Phase cell frame: one row per participant x phase (44 cells, 11 people).
# ---------------------------------------------------------------------------
h4_phase_cells <- function(epochs) {
  do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    b <- epochs[rows, ]
    data.frame(
      ParticipantID = as.character(b$ParticipantID[1]),
      PhaseID = as.character(b$PhaseID[1]),
      utci = H4_UTIL$finite_mean(b$ucm_UTCI),
      air_temp = H4_UTIL$finite_mean(b$ucm_AIR_temp),
      temp_sd = H4_UTIL$finite_sd(b$ucm_AIR_temp),
      # H4 fix A6 (2026-11-10): Rodrigues TEMP_max = within-bout max of the 10 s values (was the bout mean).
      air_temp_max = H4_UTIL$finite_max(b$ucm_AIR_temp),
      air_rh = H4_UTIL$finite_mean(b$ucm_AIR_RH),
      dba = H4_UTIL$energy_mean_db(b$ucm_SND_dBA),
      dba_max = H4_UTIL$finite_max(b$ucm_SND_dBA),
      dba_sd = H4_UTIL$finite_sd(b$ucm_SND_dBA),
      # NDSI derived from octave bands, an octave-band proxy, not exact Korpilo frequency integration:
      # proxy numerator bands have octave centres at 2000, 4000 and 8000 Hz; their edges are not exactly 2-8 kHz,
      # proxy denominator contribution is the 1000-Hz octave, not an exact 1-2-kHz band.
      # NDSI = (bio - anthro) / (bio + anthro), on a -1..+1 scale.
      ndsi_octave = {
        bio <- sum(vapply(c("octave_proportion_2000_0_Hz", "octave_proportion_4000_0_Hz",
                            "octave_proportion_8000_0_Hz"),
          function(nm) H4_UTIL$finite_mean(b[[nm]]), numeric(1)))
        ant <- H4_UTIL$finite_mean(b$octave_proportion_1000_0_Hz)
        tot <- bio + ant
        if (is.finite(tot) && tot > 0) (bio - ant) / tot else NA_real_
      },
      # YAMNet share-based fallback (natural minus vehicle proportion).
      ndsi = {
        nat <- H4_UTIL$finite_mean(b$rural_natural_proportion)
        ant <- H4_UTIL$finite_mean(b$vehicle_proportion)
        if (is.finite(nat) && is.finite(ant)) (nat - ant) else NA_real_
      },
      urban_negative = H4_UTIL$finite_mean(b$urban_manmade_negative_proportion),
      # PRS-11 perceived restorativeness is a different instrument from the source ROS restoration outcome.
      prs_total = H4_UTIL$finite_mean(b$questionnaire_prs11_total_mean_1_5),
      pleasantness = H4_UTIL$finite_mean(b$questionnaire_pleasantness_1_5),
      thermal_comfort = H4_UTIL$finite_mean(b$questionnaire_thermal_comfort_1_5),
      acoustic_comfort = H4_UTIL$finite_mean(b$questionnaire_acoustic_comfort_1_5),
      visual_comfort = H4_UTIL$finite_mean(b$questionnaire_visual_comfort_1_5),
      overall_comfort = H4_UTIL$finite_mean(b$questionnaire_current_comfort_1_7),
      eda_tonic = H4_UTIL$finite_mean(b$empatica_eda_tonic),
      heart_rate = H4_UTIL$finite_mean(b$empatica_heart_rate),
      skin_temp = H4_UTIL$finite_mean(b$empatica_skin_temperature),
      sdnn = H4_UTIL$finite_mean(b$empatica_hrv_td_sdnn),
      rmssd = H4_UTIL$finite_mean(b$empatica_hrv_td_rmssd),
      pm25 = {
        left <- H4_UTIL$finite_mean(b[["atmo_lys_atmotube_left__atmotube_pm2.5"]])
        right <- H4_UTIL$finite_mean(b[["atmo_lys_atmotube_right__atmotube_pm2.5"]])
        H4_UTIL$finite_mean(c(left, right))
      },
      wind_aws = H4_UTIL$finite_mean(b$ucm_WIND_AWS),
      oct_low = sum(vapply(c("octave_proportion_31_5_Hz", "octave_proportion_63_0_Hz",
          "octave_proportion_125_0_Hz", "octave_proportion_250_0_Hz"),
        function(nm) H4_UTIL$finite_mean(b[[nm]]), numeric(1))),
      oct_mid = sum(vapply(c("octave_proportion_500_0_Hz", "octave_proportion_1000_0_Hz",
          "octave_proportion_2000_0_Hz"),
        function(nm) H4_UTIL$finite_mean(b[[nm]]), numeric(1))),
      oct_high = sum(vapply(c("octave_proportion_4000_0_Hz", "octave_proportion_8000_0_Hz"),
        function(nm) H4_UTIL$finite_mean(b[[nm]]), numeric(1))),
      stringsAsFactors = FALSE)
  }))
}

# Walking-only frame: the phase set every H4 port uses (item 6 = WalkG + WalkU).
h4_walk_cells <- function(epochs) {
  cells <- h4_phase_cells(epochs)
  cells[cells$PhaseID %in% c("WalkG", "WalkU"), , drop = FALSE]
}

# Biking-only frame: the same method extended to BikeG + BikeU.
h4_bike_cells <- function(epochs) {
  cells <- h4_phase_cells(epochs)
  cells[cells$PhaseID %in% c("BikeG", "BikeU"), , drop = FALSE]
}

# Seated tram: one bout per person, no green-urban pair. Exploratory extra only.
h4_tram_cells <- function(epochs) {
  cells <- h4_phase_cells(epochs)
  cells[cells$PhaseID == "Tram", , drop = FALSE]
}

# Wide frame: one row per participant, green vs urban side by side.
# mode = "walk" (default, the source replication) or "bike" (extension).
h4_mode_wide <- function(epochs, mode = c("walk", "bike")) {
  mode <- match.arg(mode)
  cells <- if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs)
  reshape(cells, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
}

# Backwards-compatible alias for the walking replication.
h4_walk_wide <- function(epochs) h4_mode_wide(epochs, "walk")

# Within-person sound and thermal strata (2 walks each -> median split is exact).
h4_add_strata <- function(cells) {
  cells$thermal_stratum <- NA_character_
  cells$sound_stratum <- NA_character_
  for (p in unique(cells$ParticipantID)) {
    i <- which(cells$ParticipantID == p)
    if (length(i) == 2L) {
      cells$thermal_stratum[i] <- ifelse(cells$utci[i] == max(cells$utci[i], na.rm = TRUE), "warmer", "cooler")
      cells$sound_stratum[i] <- ifelse(cells$dba[i] == max(cells$dba[i], na.rm = TRUE), "louder", "quieter")
    }
  }
  cells
}

# ---------------------------------------------------------------------------
# Contextual relevance filter. Source-informed adaptations are
# tagged by whether they provide context for H4 (sound associations under thermal
# variation). Only the designated walking interaction tests test the amplification hypothesis directly.
#
#   core       = the test directly addresses the H4 question: a sound effect
#                conditioned on thermal, a thermal-acoustic coupling, or a
#                thermal x sound product. This broad tag does not itself establish amplification.
#   supporting = provides a needed component (sound main effect or thermal main
#                effect) but cannot establish amplification on its own.
#   not_h4     = no thermal variable, no sound variable, or a purely descriptive
#                or non-comfort estimand. Cannot bear on H4 either way.
# ---------------------------------------------------------------------------
h4_classify_relevance <- function(d) {
  d$h4_relevance <- "not_h4"
  d$h4_reason <- NA_character_

  for (i in seq_len(nrow(d))) {
    pap <- d$paper[i]; tst <- d$test[i]; oc <- d$outcome[i]; trm <- d$term[i]
    if (grepl("^Tram exploratory", pap) || grepl("tram \\(exploratory", tst, ignore.case = TRUE)) {
      d$h4_relevance[i] <- "not_h4"
      d$h4_reason[i] <- "tram exploratory extra; seated; one bout per person; no green-urban pair; cannot support H4"
      next
    }

    # ---- core: sound conditioned on thermal, or thermal-acoustic coupling ----
    core <- FALSE
    reason <- NA_character_

    if (pap == "Cureau 2022" && grepl("^fisher_(tc|oc)_ac", trm)) {
      core <- TRUE; reason <- "comfort-domain dependence incl. acoustic (Fisher cross-tab)"
    }
    if (pap == "Korpilo 2024" && grepl(":", trm, fixed = TRUE)) {
      core <- TRUE; reason <- "two-way interaction term retained-tested by the source"
    }
    if (pap == "H4 conditional slope" && grepl(":", trm, fixed = TRUE)) {
      core <- TRUE; reason <- "direct H4 test: dBA x UTCI interaction"
    }

    if (core) { d$h4_relevance[i] <- "core"; d$h4_reason[i] <- reason; next }

    # ---- supporting: one component of the joint hypothesis ----
    supporting <- FALSE
    if (pap %in% c("Pigliautile 2021", "Cureau 2023") &&
        grepl("C0|delta", tst)) {
      supporting <- TRUE
      reason <- "thermal main effect on comfort/physiology"
    }
    if (pap == "H4 conditional slope" && !grepl(":", trm, fixed = TRUE)) {
      supporting <- TRUE; reason <- "descriptive between-person sound slope within a thermal half"
    }
    if (pap == "Cureau 2022" && grepl("^wilcoxon_signed_rank$", trm)) {
      supporting <- TRUE; reason <- "between-condition contrast on sound or thermal"
    }
    if (pap == "Cureau 2022" && grepl("^multinom_lr$", trm)) {
      supporting <- TRUE; reason <- "joint vote model incl. acoustic predictor"
    }
    if (pap == "Korpilo 2024" && !grepl(":", trm, fixed = TRUE)) {
      supporting <- TRUE; reason <- "main effect (NDSI, temperature, RH or crowd)"
    }
    if (pap == "Rodrigues 2026") {
      supporting <- TRUE
      reason <- if (grepl("Noise", tst)) "noise block main effect" else "temperature block main effect"
    }
    if (pap == "Moshammer 2019") {
      supporting <- TRUE
      reason <- if (grepl("leq_prev", trm)) "sound main effect on physiology" else "thermal main effect on physiology"
    }
    if (pap == "Ueberham 2019") {
      supporting <- TRUE
      reason <- "objective exposure vs subjective rating"
    }
    if (pap == "Grapas 2026" && grepl("^grapas_delay_", trm)) {
      supporting <- TRUE; reason <- "single-exposure response-delay model"
    }
    if (pap == "Peng 2025") {
      supporting <- TRUE
      reason <- "cross-domain mixed regression (TSV/ASV with UTCI/LAeq); not a product term"
    }
    if (pap == "Baquero 2019") {
      supporting <- TRUE
      reason <- "source occupancy vs thermal and acoustic environment; local DV is overall_comfort"
    }
    if (pap == "Kraus 2013") {
      supporting <- FALSE
      reason <- "no thermal variable: cannot bear on H4"
    }
    if (pap == "H4 continuous (own model)") {
      supporting <- TRUE
      reason <- if (grepl(":", trm, fixed = TRUE)) "own interaction term" else "own main effect"
    }

    if (supporting) { d$h4_relevance[i] <- "supporting"; d$h4_reason[i] <- reason }
    else if (is.na(d$h4_reason[i])) d$h4_reason[i] <- "no thermal term or not a comfort estimand"
  }
  d
}


# ---------------------------------------------------------------------------
# Condition-specific sound slopes: the papers' own tests ask their questions
# (main effects, correlations, contrasts). H4 asks whether the sound-discomfort
# association is MORE ADVERSE when thermal conditions are uncomfortable.
# This block answers that directly, in each paper's model form.
# ---------------------------------------------------------------------------
# H4 fix A1 (2026-11-10): predicted sign of amplification per outcome.
# Ratings (higher = more comfortable) and HRV (higher = less strain): amplification = negative.
# Strain outcomes (heart rate, EDA, skin temperature): amplification = positive.
H4_PREDICTED_SIGN <- c(thermal_comfort = -1, acoustic_comfort = -1, overall_comfort = -1,
  visual_comfort = -1, pleasantness = -1, prs_total = -1, sdnn = -1, rmssd = -1,
  heart_rate = 1, eda_tonic = 1, skin_temp = 1)

# Outcome scale used by every direct-test model (log for positive physiology).
h4_outcome_scale <- function(d, oc) {
  y <- d[[oc]]
  if (oc %in% c("skin_temp", "heart_rate", "eda_tonic", "sdnn", "rmssd") && all(y > 0, na.rm = TRUE)) {
    d$.y <- log(y); attr(d, "scale_lab") <- "log"
  } else { d$.y <- y; attr(d, "scale_lab") <- "native" }
  d
}

H4_CONDITIONAL_SLOPES <- list(
  # H4 fix A3 (2026-11-10): with 2 bouts per person per mode, a within-person median split puts
  # exactly one bout per person in each half, so the half-specific slope is between-person only
  # and the Wald slope-difference test (same people in both halves) is invalid. Slopes are kept
  # as DESCRIPTIVE rows only; the slope-difference test is removed. Mode is a fixed covariate
  # whenever both modes are pooled ("both").
  formula_stratified = paste(
    "Descriptive: within thermal half s: Y_i = b0_s + b1_s*dBA_z_i (+ Mode + u_0i when both modes pooled);",
    "between-person slope, no inferential contrast between halves"),
  formula_continuous = paste(
    "Y_ij = b0 + b1*dBA_z + b2*UTCI_z + b3*(dBA_z x UTCI_z) (+ Mode when both modes pooled) + u_0i + e_ij ;",
    "H4 = b3 in the predicted direction (negative for ratings, positive for HR/EDA/skin temperature)"),
  outcomes = c("thermal_comfort", "acoustic_comfort", "overall_comfort",
               "pleasantness", "prs_total", "skin_temp", "heart_rate", "eda_tonic"),
  run = function(epochs, mode = c("walk", "bike", "both")) {
    mode <- match.arg(mode)
    cells <- switch(mode,
      walk = h4_walk_cells(epochs),
      bike = h4_bike_cells(epochs),
      both = h4_phase_cells(epochs))
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$Mode <- factor(ifelse(grepl("^Bike", cells$PhaseID), "Bike", "Walk"), levels = c("Walk", "Bike"))
    scope <- switch(mode,
      walk = "walk",
      bike = "bike",
      both = "all phases, Mode controlled")
    out <- list()

    # (A) Descriptive stratified slopes (person-relative thermal halves).
    cells$thermal_stratum <- NA_character_
    for (p in unique(cells$ParticipantID)) {
      i <- which(cells$ParticipantID == p)
      if (length(i) < 2L || !any(is.finite(cells$utci[i]))) next
      med <- stats::median(cells$utci[i], na.rm = TRUE)
      cells$thermal_stratum[i] <- ifelse(cells$utci[i] > med, "warmer", "cooler")
    }
    for (oc in H4_CONDITIONAL_SLOPES$outcomes) {
      if (!oc %in% names(cells)) next
      for (st in c("cooler", "warmer")) {
        d <- cells[!is.na(cells$thermal_stratum) & cells$thermal_stratum == st &
                   is.finite(cells[[oc]]) & is.finite(cells$dba_z), , drop = FALSE]
        if (nrow(d) < 6L || length(unique(d$ParticipantID)) < 3L) next
        d$ParticipantID <- droplevels(d$ParticipantID)
        d <- h4_outcome_scale(d, oc); lab <- attr(d, "scale_lab")
        if (mode == "both") {
          rhs <- if (nlevels(droplevels(d$Mode)) > 1L) ".y ~ dba_z + Mode" else ".y ~ dba_z"
          fit <- tryCatch(nlme::lme(stats::as.formula(rhs), random = ~ 1 | ParticipantID, data = d,
            method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
            error = function(e) e)
          if (inherits(fit, "error")) next
          tt <- summary(fit)$tTable
          cn <- c("Value", "Std.Error", "DF", "t-value", "p-value")
          how <- "descriptive sound slope within thermal half (LMM + Mode, 2 bouts per person)"
        } else {
          # One bout per person in each half: ordinary least squares, between-person only.
          fit <- stats::lm(.y ~ dba_z, data = d)
          tt <- summary(fit)$coefficients
          tt <- cbind(tt[, 1:2, drop = FALSE], DF = fit$df.residual, tt[, 3:4, drop = FALSE])
          cn <- colnames(tt)
          how <- "descriptive between-person sound slope within thermal half (OLS, 1 bout per person)"
        }
        if (!"dba_z" %in% rownames(tt)) next
        out[[length(out) + 1L]] <- h4_result(
          "H4 conditional slope", paste0("dBA slope | ", st, " half [", scope, "]"),
          H4_CONDITIONAL_SLOPES$formula_stratified, oc,
          estimate = tt["dba_z", cn[1]], se = tt["dba_z", cn[2]],
          df = tt["dba_z", cn[3]], statistic = tt["dba_z", cn[4]],
          p = tt["dba_z", cn[5]], n_obs = nrow(d),
          n_participants = nlevels(d$ParticipantID),
          statistic_test = how,
          note = sprintf("DESCRIPTIVE only (outcome scale = %s). Not a test of H4; no slope-difference test is made between halves.", lab),
          term = paste0("dba_z_within_", st))
      }
    }

    # (B) Direct H4 test: continuous dBA x UTCI interaction.
    for (oc in H4_CONDITIONAL_SLOPES$outcomes) {
      if (!oc %in% names(cells)) next
      ok <- is.finite(cells[[oc]]) & is.finite(cells$dba_z) & is.finite(cells$utci_z)
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 12L) next
      d <- h4_outcome_scale(d, oc); lab <- attr(d, "scale_lab")
      fml <- if (mode == "both") .y ~ dba_z * utci_z + Mode else .y ~ dba_z * utci_z
      fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID,
        data = d, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(opt = "optim")), error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      tm <- "dba_z:utci_z"
      if (!tm %in% rownames(tt)) next
      out[[length(out) + 1L]] <- h4_result(
        "H4 conditional slope", paste0("dBA x UTCI interaction [", scope, "]"),
        H4_CONDITIONAL_SLOPES$formula_continuous, oc,
        estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
        statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
        n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
        statistic_test = "LMM interaction term (dBA x UTCI)",
        note = sprintf("Direct H4 test. Outcome scale = %s. Predicted sign: %s.", lab,
          if (H4_PREDICTED_SIGN[[oc]] < 0) "negative (rating)" else "positive (strain)"),
        term = tm)
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

h4_result <- function(paper, test, formula, outcome, estimate = NA_real_, se = NA_real_, df = NA_real_,
                      statistic = NA_real_, p, n_obs, n_participants, statistic_test,
                      note = "", term = NA_character_) {
  one <- function(v) { if (is.null(v) || !length(v)) NA else v[1] }
  term_value <- one(term)
  data.frame(
    paper = one(paper), test = one(test), formula = one(formula), outcome = one(outcome),
    term = term_value,
    # is_h4_test = TRUE only when the term is a thermal x sound product.
    is_h4_test = !is.na(term_value) & grepl(":", term_value, fixed = TRUE) &
      grepl("utci_z:dba_z|dba_z:utci_z|ndsi_z:temp_z|temp_z:ndsi_z", term_value),
    estimate = one(estimate), se = one(se), df = one(df), statistic = one(statistic),
    p = one(p), n_observations = one(n_obs), n_participants = one(n_participants),
    statistic_test = one(statistic_test), note = one(note),
    stringsAsFactors = FALSE)
}

# ===========================================================================
# Pigliautile 2021 - source has NO test statistic. Reported values are means.
# Replicated faithfully: report the same descriptive deltas, p = NA.
# ===========================================================================
H4_PIGLIAUTILE <- list(
  formula = "Delta_domain = mean(Y | C1) - mean(Y | C0)   [descriptive only; source reports no p-value]",
  run = function(epochs) {
    wide <- h4_walk_wide(epochs)
    out <- list()
    for (v in c("thermal_comfort", "acoustic_comfort", "visual_comfort", "overall_comfort")) {
      c0 <- wide[[paste0(v, ".WalkG")]]; c1 <- wide[[paste0(v, ".WalkU")]]
      ok <- is.finite(c0) & is.finite(c1)
      if (sum(ok) < 3L) next
      out[[length(out) + 1L]] <- h4_result(
        "Pigliautile 2021", "Delta C0 -> C1 (descriptive)", H4_PIGLIAUTILE$formula, v,
        estimate = mean(c1[ok]) - mean(c0[ok]), p = NA_real_,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "none - source reports descriptive means only",
        note = "Source Fig. 3a reports 'averaged thermal comfort vote decreased from +1.0 to +0.5'. No test exists to replicate.",
        term = "delta_C1_C0")
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Cureau 2022 - Fisher exact (per park), Mann-Whitney, multinomial logit.
# Source Fisher tests use acoustic-quality votes; source environmental multinomial model 2 also includes measured sound pressure.
# ===========================================================================
H4_CUREAU2022 <- list(
  formula_fisher = "Fisher exact on comfort-domain contingency table, computed separately per park/walk",
  # H4 fix B7 (2026-11-10): green and urban bouts come from the same people, so the
  # between-condition test is the paired Wilcoxon signed-rank test (was Mann-Whitney U).
  formula_mw = "Wilcoxon signed-rank on d_i = Y_i,urban - Y_i,green (paired; source used Mann-Whitney U between parks)",
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    cells <- if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs)
    green <- if (mode == "walk") "WalkG" else "BikeG"
    urban <- if (mode == "walk") "WalkU" else "BikeU"
    scope <- if (mode == "walk") "walk (adaptation)" else "bike (adaptation)"
    out <- list()
    # Fisher: thermal sensation/comfort x acoustic quality, per phase
    for (ph in c(green, urban)) {
      d <- cells[cells$PhaseID == ph, , drop = FALSE]
      d <- d[is.finite(d$thermal_comfort) & is.finite(d$acoustic_comfort), , drop = FALSE]
      if (nrow(d) < 4L) next
      tab <- table(d$thermal_comfort, d$acoustic_comfort)
      if (any(dim(tab) < 2L)) next
      # H4 fix B7: exact Fisher test; seeded Monte Carlo only if the exact network is too large.
      ft <- tryCatch(stats::fisher.test(tab, workspace = 2e8),
        error = function(e) { set.seed(20261110); tryCatch(stats::fisher.test(tab, simulate.p.value = TRUE, B = 1e5), error = function(e2) NULL) })
      if (is.null(ft)) next
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Fisher thermal x acoustic comfort | ", ph, " [", scope, "]"),
        H4_CUREAU2022$formula_fisher, "thermal_comfort x acoustic_comfort",
        statistic = unname(ft$statistic), p = ft$p.value,
        n_obs = nrow(d), n_participants = nrow(d),
        statistic_test = "Fisher exact test (one bout per person per table)",
        note = sprintf("%s. Source tests comfort-domain dependence per park; acoustic exposure is the acoustic-quality vote, not dBA. Scope: %s.", ph, scope),
        term = "fisher_tc_ac")
    }
    # Fisher: overall comfort x acoustic quality, per phase
    for (ph in c(green, urban)) {
      d <- cells[cells$PhaseID == ph, , drop = FALSE]
      d <- d[is.finite(d$overall_comfort) & is.finite(d$acoustic_comfort), , drop = FALSE]
      if (nrow(d) < 4L) next
      tab <- table(d$overall_comfort, d$acoustic_comfort)
      if (any(dim(tab) < 2L)) next
      # H4 fix B7: exact Fisher test; seeded Monte Carlo only if the exact network is too large.
      ft <- tryCatch(stats::fisher.test(tab, workspace = 2e8),
        error = function(e) { set.seed(20261110); tryCatch(stats::fisher.test(tab, simulate.p.value = TRUE, B = 1e5), error = function(e2) NULL) })
      if (is.null(ft)) next
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Fisher overall x acoustic comfort | ", ph, " [", scope, "]"),
        H4_CUREAU2022$formula_fisher, "overall_comfort x acoustic_comfort",
        statistic = unname(ft$statistic), p = ft$p.value,
        n_obs = nrow(d), n_participants = nrow(d),
        statistic_test = "Fisher exact test (one bout per person per table)",
        note = sprintf("Source reports acoustic quality vs overall comfort: Park 1 p<0.001, Park 2 p=0.083. Scope: %s.", scope),
        term = "fisher_oc_ac")
    }
    # Mann-Whitney: green vs urban phase on each parameter
    p1 <- cells[cells$PhaseID == green, , drop = FALSE]
    p2 <- cells[cells$PhaseID == urban, , drop = FALSE]
    pw <- merge(p1, p2, by = "ParticipantID", suffixes = c(".g", ".u"))  # pair by person
    for (v in c("dba", "air_temp", "utci", "thermal_comfort", "acoustic_comfort")) {
      a <- pw[[paste0(v, ".g")]]; b <- pw[[paste0(v, ".u")]]
      ok <- is.finite(a) & is.finite(b)
      if (sum(ok) < 4L) next
      wt <- suppressWarnings(stats::wilcox.test(b[ok], a[ok], paired = TRUE))
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Wilcoxon signed-rank ", urban, " vs ", green, " | ", v, " [", scope, "]"),
        H4_CUREAU2022$formula_mw, v,
        estimate = stats::median(b[ok] - a[ok]),
        statistic = unname(wt$statistic), p = wt$p.value,
        n_obs = sum(ok) * 2, n_participants = sum(ok),
        statistic_test = "Wilcoxon signed-rank (paired, two-sided)",
        note = sprintf("Estimate = median urban - green difference. Paired replacement for the source's Mann-Whitney U (independent parks). Scope: %s.", scope),
        term = "wilcoxon_signed_rank")
    }
    # Multinomial logit: the source's BEST model used thermal + visual + acoustic
    # survey questions together (R2 = 0.820 Park 1, 0.806 Park 2).
    d <- cells[is.finite(cells$overall_comfort) & is.finite(cells$thermal_comfort) &
               is.finite(cells$acoustic_comfort) & is.finite(cells$visual_comfort), , drop = FALSE]
    if (nrow(d) >= 10L) {
      d$oc_f <- factor(d$overall_comfort)
      if (nlevels(d$oc_f) >= 3L) {
        fit <- tryCatch(nnet::multinom(oc_f ~ thermal_comfort + visual_comfort + acoustic_comfort,
          data = d, trace = FALSE), error = function(e) NULL)
        null_fit <- tryCatch(nnet::multinom(oc_f ~ 1, data = d, trace = FALSE), error = function(e) NULL)
        if (!is.null(fit) && !is.null(null_fit)) {
          ll1 <- as.numeric(stats::logLik(fit)); ll0 <- as.numeric(stats::logLik(null_fit))
          lr <- 2 * (ll1 - ll0)
          df_lr <- attr(stats::logLik(fit), "df") - attr(stats::logLik(null_fit), "df")
          p_lr <- if (is.finite(lr) && df_lr > 0) stats::pchisq(lr, df_lr, lower.tail = FALSE) else NA_real_
          # Local reportability heuristic only: suppress p when df >= n/2; not a source rule or proof of non-estimability.
          estimable <- is.finite(df_lr) && df_lr < nrow(d) / 2
          if (!estimable) p_lr <- NA_real_
          mcfadden <- 1 - (ll1 / ll0)
          out[[length(out) + 1L]] <- h4_result(
            "Cureau 2022", paste0("Multinomial logit: thermal + visual + acoustic -> overall comfort [", scope, "]"),
            "ln[P(Y=j)/P(Y=J)] = alpha_j + x'beta_j ; McFadden pseudo-R2 = 1 - LL(model)/LL(null)",
            "overall_comfort",
            statistic = lr, df = df_lr, p = p_lr,
            n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = "likelihood-ratio chi-square for the multinomial model",
            note = if (estimable) sprintf(paste("Source best model = thermal + visual + acoustic questions,",
              "R2 = 0.820 (Park 1) / 0.806 (Park 2). McFadden pseudo-R2 here = %.3f."), mcfadden) else
              sprintf("Not reported by local complexity gate (n = %d bouts, 2 per person; LR df = %d >= n/2). This heuristic does not establish mathematical non-estimability.", nrow(d), as.integer(df_lr)),
            term = "multinom_lr")
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Peng 2025 (ICUC-12-816, Schiphol) - mixed-linear regression on TSV, ASV,
# UTCI and LAeq. Abstract reports five confound hypotheses, not a product.
# Walk = published transect design; bike = labelled extension.
# ===========================================================================
H4_PENG2025 <- list(
  formula = paste(
    "Y_ij = b0 + b1*X_ij + u_0i + e_ij ;",
    "five models: TSV ~ LAeq, TSV ~ ASV, ASV ~ UTCI, ASV ~ LAeq, ASV ~ TSV"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    cells <- if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs)
    scope <- if (mode == "walk") "walk (source design)" else "bike (labelled extension)"
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$ParticipantID <- factor(cells$ParticipantID)
    models <- list(
      list(y = "thermal_comfort", x = "dba_z", lab = "TSV ~ LAeq", term = "peng_tsv_laeq"),
      list(y = "thermal_comfort", x = "acoustic_comfort", lab = "TSV ~ ASV", term = "peng_tsv_asv"),
      list(y = "acoustic_comfort", x = "utci_z", lab = "ASV ~ UTCI", term = "peng_asv_utci"),
      list(y = "acoustic_comfort", x = "dba_z", lab = "ASV ~ LAeq", term = "peng_asv_laeq"),
      list(y = "acoustic_comfort", x = "thermal_comfort", lab = "ASV ~ TSV", term = "peng_asv_tsv"))
    out <- list()
    for (m in models) {
      ok <- is.finite(cells[[m$y]]) & is.finite(cells[[m$x]])
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 12L || nlevels(droplevels(d$ParticipantID)) < 3L) next
      d$ParticipantID <- droplevels(d$ParticipantID)
      d$.y <- d[[m$y]]
      d$predictor <- d[[m$x]]
      fit <- tryCatch(nlme::lme(.y ~ predictor, random = ~ 1 | ParticipantID, data = d,
        method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
        error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      if (!"predictor" %in% rownames(tt)) next
      out[[length(out) + 1L]] <- h4_result(
        "Peng 2025", paste0("Mixed linear: ", m$lab, " [", scope, "]"), H4_PENG2025$formula,
        m$y,
        estimate = tt["predictor", "Value"], se = tt["predictor", "Std.Error"],
        df = tt["predictor", "DF"], statistic = tt["predictor", "t-value"], p = tt["predictor", "p-value"],
        n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
        statistic_test = "LMM (participant intercept); source mixed-linear confound hypotheses",
        note = sprintf("Source is a one-page ICUC-12 abstract (Schiphol walking transects). Coefficients were not published. Scope: %s. Predictor = %s.", scope, m$x),
        term = m$term)
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Grapas Rome 2026 EXCLUDED 2026-11-12: HR/EDA vs UTCI/dBA/PM/octaves.
# Physiology, not thermal-vote H4. run() returns NULL.
# ===========================================================================
H4_GRAPAS_ROME <- list(
  formula = "EXCLUDED: physiology, not thermal-vote H4",
  run = function(epochs, mode = c("walk", "bike")) NULL)

# ===========================================================================
# Baquero Larriva & Higueras 2019 (Madrid) - Pearson of occupancy with Ta,
# RH, dB, wind; Spearman of occupancy with thermal sensation and noise;
# multiple regression of occupancy (only wind entered). Walk = outdoor public
# space; bike = labelled extension. Local DV is overall_comfort: there is no
# stay-count series.
# ===========================================================================
H4_BAQUERO2019 <- list(
  formula = paste(
    "Pearson: stay ~ Ta, RH, dB, wind;",
    "Spearman: stay ~ TSV, noise;",
    "stay = b0 + b1*Ta + b2*RH + b3*dB + b4*wind   [local stay -> overall_comfort]"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    cells <- if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs)
    scope <- if (mode == "walk") "walk (source design)" else "bike (labelled extension)"
    y <- cells$overall_comfort
    pearson_x <- list(air_temp = cells$air_temp, air_rh = cells$air_rh,
                      dba = cells$dba, wind_aws = cells$wind_aws)
    out <- list()
    for (xn in names(pearson_x)) {
      xv <- pearson_x[[xn]]
      ok <- is.finite(y) & is.finite(xv)
      if (sum(ok) < 8L || stats::sd(y[ok]) == 0 || stats::sd(xv[ok]) == 0) next
      ct <- stats::cor.test(xv[ok], y[ok], method = "pearson")
      out[[length(out) + 1L]] <- h4_result(
        "Baquero 2019",
        paste0("Pearson: overall_comfort ~ ", xn, " [", scope, "]"),
        H4_BAQUERO2019$formula, "overall_comfort",
        estimate = unname(ct$estimate), statistic = unname(ct$statistic),
        df = if (!is.null(ct$parameter)) unname(ct$parameter) else NA_real_,
        p = ct$p.value, n_obs = sum(ok), n_participants = length(unique(cells$ParticipantID[ok])),
        statistic_test = "Pearson r; source correlated stay counts with the same environmental variables",
        note = sprintf("Source DV = number of older adults staying. Local DV = overall_comfort. Scope: %s.", scope),
        term = paste0("baquero_pearson_", xn))
    }
    spearman_x <- list(thermal_comfort = cells$thermal_comfort, acoustic_comfort = cells$acoustic_comfort)
    for (xn in names(spearman_x)) {
      xv <- spearman_x[[xn]]
      ok <- is.finite(y) & is.finite(xv)
      if (sum(ok) < 8L || stats::sd(y[ok]) == 0 || stats::sd(xv[ok]) == 0) next
      ct <- stats::cor.test(xv[ok], y[ok], method = "spearman", exact = FALSE)
      out[[length(out) + 1L]] <- h4_result(
        "Baquero 2019",
        paste0("Spearman: overall_comfort ~ ", xn, " [", scope, "]"),
        H4_BAQUERO2019$formula, "overall_comfort",
        estimate = unname(ct$estimate), statistic = unname(ct$statistic),
        p = ct$p.value, n_obs = sum(ok), n_participants = length(unique(cells$ParticipantID[ok])),
        statistic_test = "Spearman rho; source correlated stay with thermal sensation and noise perception",
        note = sprintf("Source DV = stay counts. Local DV = overall_comfort. Scope: %s.", scope),
        term = paste0("baquero_spearman_", xn))
    }
    cells$air_temp_z <- H4_UTIL$z(cells$air_temp)
    cells$air_rh_z <- H4_UTIL$z(cells$air_rh)
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$wind_z <- H4_UTIL$z(cells$wind_aws)
    cells$ParticipantID <- factor(cells$ParticipantID)
    ok <- is.finite(cells$overall_comfort) & is.finite(cells$air_temp_z) & is.finite(cells$air_rh_z) &
      is.finite(cells$dba_z) & is.finite(cells$wind_z)
    d <- cells[ok, , drop = FALSE]
    if (nrow(d) >= 12L && nlevels(droplevels(d$ParticipantID)) >= 3L) {
      d$ParticipantID <- droplevels(d$ParticipantID)
      fit <- tryCatch(nlme::lme(overall_comfort ~ air_temp_z + air_rh_z + dba_z + wind_z,
        random = ~ 1 | ParticipantID, data = d, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(opt = "optim")), error = function(e) e)
      if (!inherits(fit, "error")) {
        tt <- summary(fit)$tTable
        for (trm in c("air_temp_z", "air_rh_z", "dba_z", "wind_z")) {
          if (!trm %in% rownames(tt)) next
          out[[length(out) + 1L]] <- h4_result(
            "Baquero 2019",
            paste0("Multiple regression: overall_comfort ~ Ta + RH + dBA + wind | term ", trm, " [", scope, "]"),
            H4_BAQUERO2019$formula, "overall_comfort",
            estimate = tt[trm, "Value"], se = tt[trm, "Std.Error"],
            df = tt[trm, "DF"], statistic = tt[trm, "t-value"], p = tt[trm, "p-value"],
            n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
            statistic_test = "LMM; source OLS of stay, only wind entered (R2 = 0.07)",
            note = sprintf("Source DV = stay counts; local DV = overall_comfort. Source retained only max wind. Scope: %s.", scope),
            term = paste0("baquero_lm_", trm))
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Cureau 2023 - source has NO test. Descriptive means + spectral comparison.
# ===========================================================================
H4_CUREAU2023 <- list(
  formula = "Delta_dba = mean(dBA | park) - mean(dBA | commercial hub)   [descriptive only]",
  run = function(epochs) {
    cells <- h4_walk_cells(epochs)
    out <- list()
    for (v in c("dba", "thermal_comfort", "acoustic_comfort", "overall_comfort")) {
      a <- cells[[v]][cells$PhaseID == "WalkG"]
      b <- cells[[v]][cells$PhaseID == "WalkU"]
      ok <- is.finite(a) & is.finite(b)
      if (sum(ok) < 3L) next
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2023", "Delta park vs commercial hub (descriptive)", H4_CUREAU2023$formula, v,
        estimate = mean(b[ok]) - mean(a[ok]), p = NA_real_,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "none - source reports descriptive means only",
        note = "Source states: 'additional data collection should be performed to verify the significance of these findings through statistical methods.'",
        term = "delta_descriptive")
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Grapas 2026 - source: bootstrap SOR pathways, Granger-style latency, and a
# mixed model on response delays: delay ~ exposure + (1 | participant).
# H4 fix A5 (2026-11-10): the person-mean Pearson "edges" are dropped. The delay
# model is implemented with a crude latency proxy: within each bout, the lag
# (0-180 s, 10 s steps) of the largest absolute cross-correlation between the
# 10 s exposure and response series. Bootstrap pathways and Granger tests are
# not ported. All four exposure-response pairs are reported (no selection).
# ===========================================================================
H4_GRAPAS <- list(
  formula = "delay_ij = b0 + b1*exposure_z_ij + (1 | participant)   [delay = lag of peak |cross-correlation|, 0-180 s; no mode term in the source]",
  max_lag = 18L,
  epoch_seconds = 10L,
  min_overlap = 10L,
  # H4 fix C4 (2026-11-10): EXACT source specification. The source is a WALKING
  # study (36 walk sessions) with no mode term; an earlier port added a Mode
  # covariate and pooled all four phases. Corrected: no Mode term, walk is the
  # source design, bike is the extension.
  phases_native = c("WalkG", "WalkU"),
  phases_extension = c("BikeG", "BikeU"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    phases <- if (mode == "walk") H4_GRAPAS$phases_native else H4_GRAPAS$phases_extension
    scope <- if (mode == "walk") "walk (source design)" else "bike (extension)"
    use_epochs <- epochs[epochs$PhaseID %in% phases, , drop = FALSE]
    rows <- list()
    for (idx in H4_UTIL$bouts(use_epochs)) {
      b <- use_epochs[idx, ]
      b <- b[order(b$Datetime), ]
      n <- nrow(b)
      ov <- H4_GRAPAS$min_overlap
      step <- H4_GRAPAS$epoch_seconds
      k_max <- min(H4_GRAPAS$max_lag, max(0L, n - ov))
      for (ex in c("ucm_SND_dBA", "ucm_UTCI")) for (rs in c("empatica_heart_rate", "empatica_eda_tonic")) {
        x <- as.numeric(b[[ex]]); y <- as.numeric(b[[rs]])
        best_k <- NA_integer_; best_r <- -Inf
        if (n >= ov) for (k in 0:k_max) {
          xx <- x[seq_len(n - k)]; yy <- y[(1L + k):n]
          ok <- is.finite(xx) & is.finite(yy)
          if (sum(ok) < ov || stats::sd(xx[ok]) == 0 || stats::sd(yy[ok]) == 0) next
          r <- abs(stats::cor(xx[ok], yy[ok]))
          if (r > best_r) { best_r <- r; best_k <- k }
        }
        rows[[length(rows) + 1L]] <- data.frame(
          ParticipantID = as.character(b$ParticipantID[1]), PhaseID = as.character(b$PhaseID[1]),
          exposure = ex, response = rs, delay_s = best_k * step,
          exposure_level = {
            if (ex != "ucm_SND_dBA") H4_UTIL$finite_mean(x) else {
              xx <- x[is.finite(x)]
              if (!length(xx) || min(xx) < 0 || max(xx) > 150) H4_UTIL$finite_mean(x) else H4_UTIL$energy_mean_db(x)
            }
          },
          stringsAsFactors = FALSE)
      }
    }
    dd <- do.call(rbind, rows)
    out <- list()
    lab <- c(ucm_SND_dBA = "dba", ucm_UTCI = "utci", empatica_heart_rate = "hr", empatica_eda_tonic = "eda")
    for (ex in c("ucm_SND_dBA", "ucm_UTCI")) for (rs in c("empatica_heart_rate", "empatica_eda_tonic")) {
      d <- dd[dd$exposure == ex & dd$response == rs & is.finite(dd$delay_s) & is.finite(dd$exposure_level), , drop = FALSE]
      if (nrow(d) < 12L) next
      d$exposure_z <- H4_UTIL$z(d$exposure_level)
      d$ParticipantID <- factor(d$ParticipantID)
      fit <- tryCatch(nlme::lme(delay_s ~ exposure_z, random = ~ 1 | ParticipantID, data = d,
        method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
        error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      out[[length(out) + 1L]] <- h4_result(
        "Grapas 2026", paste0("Response delay model: ", lab[[ex]], " -> ", lab[[rs]], " [", scope, "]"), H4_GRAPAS$formula,
        paste0("delay_", lab[[rs]], "_after_", lab[[ex]]),
        estimate = tt["exposure_z", "Value"], se = tt["exposure_z", "Std.Error"],
        df = tt["exposure_z", "DF"], statistic = tt["exposure_z", "t-value"], p = tt["exposure_z", "p-value"],
        n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
        statistic_test = "LMM on bout-level response delay (participant intercept)",
        note = sprintf("Seconds of delay per SD of bout-mean exposure. Mean delay = %.0f s. Fitted exactly as published (no Mode term). Latency is a cross-correlation proxy, not Granger; no bootstrap pathways. Scope: %s.", mean(d$delay_s), scope),
        term = paste0("grapas_delay_", lab[[ex]], "_", lab[[rs]]))
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Chiucchiù 2026 EXCLUDED 2026-11-12: NEXT.ROOM indoor chamber
# (21 vs 23 °C × headphone soundscapes). Hand search. Not outdoor walking H4.
# Cureau 2022 (same group, Perugia parks) is outdoor and stays.
# ===========================================================================
H4_CHIUCCHIU <- list(
  formula_paired = "EXCLUDED: indoor NEXT.ROOM, not outdoor walking H4",
  formula_spearman = "EXCLUDED: indoor NEXT.ROOM, not outdoor walking H4",
  formula_table5 = "EXCLUDED",
  run = function(epochs, mode = c("walk", "bike")) NULL)

# ===========================================================================
# REMOVED: Cureau 2022 - no sound variable in any of its three analyses
# (Fisher exact, Mann-Whitney, multinomial logit). Nothing to moderate. See 4.0.3.
# ===========================================================================

# ===========================================================================
# 4.0.2.3 Moshammer 2019 - random-effects GLS:
#   Y_it = a + b1*Leq_{i,t-1} + b2*PM_it + b3*T_it + u_i + e_it
#   exposure = preceding 5 min, outcome = following 3 min
# H4 fix C1 (2026-11-10): EXACT source specification. The source is a WALKING
# study with no mode term; an earlier port added a Mode covariate and dropped
# the source's PM confounder. Both are corrected: no Mode term anywhere, PM2.5
# (mean of the two Atmotube units) restored per the source formula. Walk is the
# source design; bike is the extension.
# ===========================================================================
H4_MOSHAMMER <- list(
  formula = "Y_it = a + b1*Leq(i,t-1) + b2*PM_it + b3*T_it + u_i + e_it   [xtreg, re; additive; no mode term in the source]",
  formula_unadjusted = "Y_it = a + b1*Leq(i,t-1) + u_i + e_it   [source Table A2, noise only]",
  exposure_seconds = 300,
  # Source design = walking only (1-h walks in four settings).
  phases_native = c("WalkG", "WalkU"),
  phases_extension = c("BikeG", "BikeU"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    phases <- if (mode == "walk") H4_MOSHAMMER$phases_native else H4_MOSHAMMER$phases_extension
    scope <- if (mode == "walk") "walk (source design)" else "bike (extension)"
    out <- list()
    cache <- list()
    use_epochs <- epochs[epochs$PhaseID %in% phases, , drop = FALSE]
    for (rows in H4_UTIL$bouts(use_epochs)) {
      b <- use_epochs[rows, ]
      secs <- as.numeric(difftime(b$Datetime, min(b$Datetime), units = "secs"))
      exp_r <- secs < H4_MOSHAMMER$exposure_seconds
      out_r <- secs >= H4_MOSHAMMER$exposure_seconds
      if (!any(out_r) || sum(is.finite(b$ucm_SND_dBA[exp_r])) < 20L) next
      cache[[length(cache) + 1L]] <- data.frame(
        ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1],
        leq_prev = H4_UTIL$energy_mean_db(b$ucm_SND_dBA[exp_r]),
        pm25 = H4_UTIL$finite_mean(c(b$atmo_lys_atmotube_left__atmotube_pm2.5[out_r],
                                     b$atmo_lys_atmotube_right__atmotube_pm2.5[out_r])),
        air_temp = H4_UTIL$finite_mean(b$ucm_AIR_temp[out_r]),
        sdnn = H4_UTIL$finite_mean(b$empatica_hrv_td_sdnn[out_r]),
        rmssd = H4_UTIL$finite_mean(b$empatica_hrv_td_rmssd[out_r]),
        heart_rate = H4_UTIL$finite_mean(b$empatica_heart_rate[out_r]),
        stringsAsFactors = FALSE)
    }
    d <- do.call(rbind, cache)
    if (is.null(d) || nrow(d) < 5L) return(NULL)
    d$ParticipantID <- factor(d$ParticipantID)
    # Source fits BOTH the unadjusted noise-only model (Table A2) and the
    # PM- and temperature-adjusted model (Methods). Fitted exactly as published.
    for (spec in list(list(ctrl = FALSE, label = "unadjusted (Table A2)"),
                      list(ctrl = TRUE,  label = "PM- and temperature-adjusted"))) {
      for (oc in c("sdnn", "rmssd", "heart_rate")) {
        rhs <- if (spec$ctrl) "leq_prev + pm25 + air_temp" else "leq_prev"
        resp <- if (oc == "heart_rate") oc else paste0("log(", oc, ")")
        fml <- stats::as.formula(paste(resp, "~", rhs))
        fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
          method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
          error = function(e) e)
        if (inherits(fit, "error")) next
        tt <- summary(fit)$tTable
        if (!"leq_prev" %in% rownames(tt)) next
        # temperature/PM terms are reported too: the source claims they do not confound
        tms <- c("leq_prev", if (spec$ctrl) c("pm25", "air_temp"))
        for (tm in tms) {
          if (!tm %in% rownames(tt)) next
          # H4 fix B11: no best-of-k selection. The source's prespecified primary test is
          # SDNN ~ Leq(t-1) in the adjusted model; all other rows are secondary and reported at nominal p.
          out[[length(out) + 1L]] <- h4_result(
            "Moshammer 2019", paste0("RE GLS ", tm, " -> ", oc, " [", spec$label, ", ", scope, "]"),
            if (spec$ctrl) H4_MOSHAMMER$formula else H4_MOSHAMMER$formula_unadjusted, oc,
            estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"],
            df = tt[tm, "DF"], statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
            n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
            statistic_test = "random-effects LMM (xtreg, re analogue)",
            note = paste("First 5 min = exposure window, 5-8 min = outcome window.",
              "Exact source specification: additive, no Mode term, PM2.5 confounder restored.",
              "The source has no thermal x sound product term and reports that temperature did not confound the noise estimate.",
              "Scope:", scope),
            term = tm)
          out[[length(out)]]$source_primary <- spec$ctrl && oc == "sdnn" && tm == "leq_prev" && mode == "walk"
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# 4.0.2.3 Rodrigues 2026 - participant-intercept MixedLM.
#   Source: five thematic blocks tested in SEPARATE models.
#     Noise block:       Y_ij = b0 + b1*z(NOISE_max) + b2*z(NOISE_sd) + u_0i + e_ij
#     Temperature block: Y_ij = b0 + b1*z(TEMP_max)  + b2*z(TEMP_mean)  + u_0i + e_ij
#   Retention: p < 0.05 AND |beta| > 0.1
#   The source never multiplies the blocks, so H4 is not estimated. Both blocks
#   are fitted here so the source's own reported contrast can be compared.
# ===========================================================================
H4_RODRIGUES <- list(
  formula_noise = "Y_ij = b0 + b1*z(NOISE_max_ij) + b2*z(NOISE_sd_ij) + u_0i + e_ij",
  formula_temp = "Y_ij = b0 + b1*z(TEMP_max_ij) + b2*z(TEMP_mean_ij) + u_0i + e_ij",
  outcomes = c("heart_rate", "eda_tonic", "skin_temp", "sdnn", "rmssd"),
  # H4 fix C2 (2026-11-10): EXACT source specification. The source is a WALKING
  # study (2,207 walking trips) with no mode term; an earlier port added a Mode
  # covariate and pooled all four phases. Corrected: no Mode term, walk is the
  # source design, bike is the extension.
  phases_native = c("WalkG", "WalkU"),
  phases_extension = c("BikeG", "BikeU"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    phases <- if (mode == "walk") H4_RODRIGUES$phases_native else H4_RODRIGUES$phases_extension
    scope <- if (mode == "walk") "walk (source design)" else "bike (extension)"
    cells <- h4_phase_cells(epochs)
    cells <- cells[cells$PhaseID %in% phases, , drop = FALSE]
    cells$Noise_max_z <- H4_UTIL$z(cells$dba_max)
    cells$Noise_sd_z <- H4_UTIL$z(cells$dba_sd)
    cells$Temp_max_z <- H4_UTIL$z(cells$air_temp_max)  # H4 fix A6: within-bout max (was bout mean); Noise_max = within-bout max of 10 s dBA
    cells$Temp_mean_z <- H4_UTIL$z(cells$air_temp)
    cells$ParticipantID <- factor(cells$ParticipantID)
    out <- list()
    blocks <- list(
      noise = list(pred = c("Noise_max_z", "Noise_sd_z"), label = "Noise block",
        formula = H4_RODRIGUES$formula_noise),
      temperature = list(pred = c("Temp_max_z", "Temp_mean_z"), label = "Temperature block",
        formula = H4_RODRIGUES$formula_temp))
    for (blk in blocks) {
      for (oc in H4_RODRIGUES$outcomes) {
        ok <- is.finite(cells[[oc]]) & Reduce(`&`, lapply(blk$pred, function(v) is.finite(cells[[v]])))
        d <- cells[ok, , drop = FALSE]
        if (nrow(d) < 8L) next
        fml <- stats::as.formula(paste0(oc, " ~ ", paste(blk$pred, collapse = " + ")))
        fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
          method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
          error = function(e) e)
        if (inherits(fit, "error")) next
        tt <- summary(fit)$tTable
        for (tm in blk$pred) {
          if (!tm %in% rownames(tt)) next
          met <- is.finite(tt[tm, "p-value"]) && tt[tm, "p-value"] < 0.05 && abs(tt[tm, "Value"]) > 0.1
          out[[length(out) + 1L]] <- h4_result(
            "Rodrigues 2026", paste0(blk$label, " [", scope, "]"), blk$formula, oc,
            estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
            statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
            n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
            statistic_test = "participant-intercept LMM (MixedLM)",
            note = sprintf("%s; source retention (p<.05 & |beta|>0.1) = %s. Separate source predictor blocks (no Mode term), fitted to local outcome summaries with nlme t-reference inference. Scope: %s.",
              tm, if (met) "MET" else "not met", scope),
            term = tm)
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Kraus 2013 - additive mixed model with piecewise breakpoint at 65 dB(A).
#   ln(Y_it) = b0 + b1*Leq + b2*(Leq-65)+ + b3*activity + u_i + e_it
# Source has NO thermal variable; replicated as published (sound only).
# ===========================================================================
H4_KRAUS <- list(
  formula = "ln(Y_it) = b0 + b1*Leq_it + b2*(Leq_it - 65)+ + b3*activity_it + u_i + e_it   [HRV models additionally adjust for heart rate]",
  breakpoint_db = 65,
  # H4 fix C5 (2026-11-10): EXACT source specification. The source adjusts for
  # physical activity, and its HRV models additionally adjust for heart rate;
  # an earlier port dropped both. Corrected: activity (= travel mode) restored
  # per the source formula and heart rate added to the SDNN/RMSSD models.
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells$Leq <- cells$dba
    cells$Leq_over65 <- pmax(0, cells$dba - H4_KRAUS$breakpoint_db)
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$activity <- factor(ifelse(grepl("^Bike", cells$PhaseID), "Bike", "Walk"),
      levels = c("Walk", "Bike"))
    out <- list()
    for (oc in c("sdnn", "rmssd", "heart_rate")) {
      need_hr <- oc %in% c("sdnn", "rmssd")
      ok <- is.finite(cells[[oc]]) & cells[[oc]] > 0 & is.finite(cells$Leq)
      if (need_hr) ok <- ok & is.finite(cells$heart_rate)
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 8L) next
      resp <- if (oc == "heart_rate") oc else paste0("log(", oc, ")")
      rhs <- if (need_hr) "Leq + Leq_over65 + activity + heart_rate" else "Leq + Leq_over65 + activity"
      fit <- tryCatch(nlme::lme(stats::as.formula(paste0(resp, " ~ ", rhs)),
        random = ~ 1 | ParticipantID, data = d, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(opt = "optim")), error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      for (tm in c("Leq", "Leq_over65")) {
        if (!tm %in% rownames(tt)) next
        out[[length(out) + 1L]] <- h4_result(
          "Kraus 2013", "Piecewise Leq at 65 dB(A)", H4_KRAUS$formula, oc,
          estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
          statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
          n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
          statistic_test = "additive LMM (participant intercept), piecewise Leq",
          note = paste0("Source contains no thermal variable; replicated as published (sound only, activity-adjusted",
            if (need_hr) ", heart-rate-adjusted" else "", "). Additive, no product term."),
          term = tm)
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Ueberham 2019 - Spearman + ordinal proportional-odds regression of
#   objective exposure class against subjective exposure rating.
# ===========================================================================
H4_UEBERHAM <- list(
  formula_spearman = "rho_S between objective route mean (dBA, temperature) and subjective rating (1-5)",
  formula_ordinal = "logit[P(Y <= j)] = theta_j - x'beta   [proportional odds]",
  # Source is a CYCLING study (Leipzig, 66 cyclists, 730 routes). Cycling is its
  # native condition; walking is the extension.
  phases_native = c("BikeG", "BikeU"),
  phases_extension = c("WalkG", "WalkU"),
  run = function(epochs, mode = c("bike", "walk")) {
    mode <- match.arg(mode)
    phases <- if (mode == "bike") H4_UEBERHAM$phases_native else H4_UEBERHAM$phases_extension
    scope <- if (mode == "bike") "bike (source design)" else "walk (extension)"
    cells <- h4_phase_cells(epochs)
    cells <- cells[cells$PhaseID %in% phases, , drop = FALSE]
    out <- list()
    # H4 fix B9 (2026-11-10): Spearman on person means (one value per person, n = 11);
    # the earlier 22 pooled bouts (2 per person) were not independent.
    per <- stats::aggregate(cells[, c("dba", "acoustic_comfort", "air_temp", "thermal_comfort")],
      by = list(ParticipantID = cells$ParticipantID), FUN = function(v) mean(v, na.rm = TRUE))
    pairs <- list(c("dba", "acoustic_comfort"), c("air_temp", "thermal_comfort"))
    for (pr in pairs) {
      x <- per[[pr[1]]]; y <- per[[pr[2]]]
      ok <- is.finite(x) & is.finite(y)
      if (sum(ok) < 6L) next
      ct <- suppressWarnings(stats::cor.test(x[ok], y[ok], method = "spearman"))
      out[[length(out) + 1L]] <- h4_result(
        "Ueberham 2019", paste0("Spearman ", pr[1], " vs ", pr[2], " (person means) [", scope, "]"),
        H4_UEBERHAM$formula_spearman,
        paste0(pr[1], " ~ ", pr[2]),
        estimate = unname(ct$estimate), statistic = unname(ct$statistic), p = ct$p.value,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "Spearman rank correlation (person means)",
        note = sprintf("One value per person (mean of the two bouts in this mode). Source correlates route means with post-trip ratings on 1-5 scales. Scope: %s.", scope),
        term = paste0("spearman_", pr[1], "_", pr[2]))
    }
    # Ordinal regression: acoustic comfort class ~ dBA class
    d <- cells[is.finite(cells$acoustic_comfort) & is.finite(cells$dba), , drop = FALSE]
    if (nrow(d) >= 8L && length(unique(d$acoustic_comfort)) >= 3L) {
      d$ac_class <- factor(as.integer(cut(d$dba, breaks = stats::quantile(d$dba, c(0, 1/3, 2/3, 1),
        na.rm = TRUE), include.lowest = TRUE, labels = FALSE)))
      d$ac_out <- factor(d$acoustic_comfort, ordered = TRUE)
      fit <- tryCatch(MASS::polr(ac_out ~ ac_class, data = d, Hess = TRUE), error = function(e) NULL)
      if (!is.null(fit)) {
        ct <- summary(fit)$coefficients
        if (nrow(ct) >= 1L) {
          out[[length(out) + 1L]] <- h4_result(
            "Ueberham 2019", paste0("Ordinal regression: acoustic comfort ~ dBA class (pooled bouts) [", scope, "]"),
            H4_UEBERHAM$formula_ordinal, "acoustic_comfort",
            estimate = ct[1, "Value"], se = ct[1, "Std. Error"],
            statistic = ct[1, "t value"],
            p = 2 * stats::pt(abs(ct[1, "t value"]), df = nrow(d) - length(coef(fit)), lower.tail = FALSE),
            n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = "proportional-odds ordinal regression (polr)",
            note = sprintf("POOLED 22 bouts, 2 per person: pseudo-replicated, p is optimistic. Source categorises both exposures into ordered groups. Scope: %s.", scope),
            term = "polr_dba_class")
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# REMOVED: Kraus 2013 placeholder (now implemented above).
# ===========================================================================

# ===========================================================================
# 4.0.2.4 Korpilo 2024 - two GLMMs (beta-logit for EDA, Gaussian for ROS),
#   with ALL two-way interactions tested and retained at p < 0.10.
#   Source formula: logit(E[EDA]) = b0 + b1*NDSI + b2*T + b3*RH + b4*(N_people)
#                   + all two-way interactions + (1|respondent)
#   The interaction that survives in the source is N_people x NDSI, NOT
#   temperature x NDSI. Both are fitted here so that is verifiable.
# ===========================================================================
H4_KORPILO <- list(
  formula_eda = paste("EDA_z_ij = b0 + b1*NDSI_j + b2*T_j + b3*RH_j + b4*UrbanNegSoundShare_j (source: logit, Crowd_j)",
                      "+ two-way interactions, retained at p<0.10 + u_i"),
  formula_ros = paste("ROS_z_ij = b0 + b1*NDSI_j + b2*T_j + b3*RH_j + b4*UrbanNegSoundShare_j (source: Crowd_j)",
                      "+ two-way interactions, retained at p<0.10 + u_i"),
  retention_p = 0.10,
  # H4 fix C3 (2026-11-10): EXACT source specification. The source is a WALKING
  # study (group walks) with no mode term; an earlier port added a Mode
  # covariate and pooled all four phases. Corrected: no Mode term, walk is the
  # source design, bike is the extension.
  phases_native = c("WalkG", "WalkU"),
  phases_extension = c("BikeG", "BikeU"),
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    phases <- if (mode == "walk") H4_KORPILO$phases_native else H4_KORPILO$phases_extension
    scope <- if (mode == "walk") "walk (source design)" else "bike (extension)"
    cells <- h4_phase_cells(epochs)
    cells <- cells[cells$PhaseID %in% phases, , drop = FALSE]
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$eda_z <- H4_UTIL$z(cells$eda_tonic)
    cells$ros_z <- H4_UTIL$z(cells$prs_total)
    cells$temp_z <- H4_UTIL$z(cells$air_temp)
    cells$rh_z <- H4_UTIL$z(cells$air_rh)
    cells$ndsi_z <- H4_UTIL$z(cells$ndsi_octave)
    # The source used observed people counts. The field dataset
    # has no headcount; negative sound share is an additional sound predictor,
    # not a validated substitute for people counts.
    # H4 fix B12: named for what it is (YAMNet urban/man-made negative sound share), not "crowd".
    cells$urban_negative_sound_share_z <- H4_UTIL$z(cells$urban_negative)
    pred <- c("ndsi_z", "temp_z", "rh_z", "urban_negative_sound_share_z")
    out <- list()
    for (resp in list(list(col = "eda_z", label = "EDA level (Gaussian analogue)", f = H4_KORPILO$formula_eda),
                      list(col = "ros_z", label = "ROS / PRS-11 (Gaussian)", f = H4_KORPILO$formula_ros))) {
      ok <- is.finite(cells[[resp$col]]) &
        Reduce(`&`, lapply(pred, function(v) is.finite(cells[[v]])))
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 8L) next
      fml <- stats::as.formula(paste0(resp$col, " ~ (", paste(pred, collapse = " + "), ")^2"))
      fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
        method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
        error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      for (tm in rownames(tt)) {
        if (tm == "(Intercept)") next
        is_inter <- grepl(":", tm, fixed = TRUE)
        pv <- tt[tm, "p-value"]
        retained <- is.finite(pv) && pv < H4_KORPILO$retention_p
        out[[length(out) + 1L]] <- h4_result(
          "Korpilo 2024", paste0(resp$label, " [", scope, "]"), resp$f, resp$col,
          estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
          statistic = tt[tm, "t-value"], p = pv,
          n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
          statistic_test = "LMM with all two-way interactions (GLMM analogue)",
          note = sprintf("%s%s; source retention at p<0.10 = %s. Fitted exactly as published (no Mode term). Source retained N_people x NDSI, not temperature x NDSI. Scope: %s.",
            tm, if (is_inter) " [interaction]" else " [main effect]",
            if (retained) "MET" else "not met", scope),
          term = tm)
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# REMOVED: Jin 2020 - product term is sound type x sound level (no thermal factor).
# Season is stratified (ANOVA run per season), never crossed with sound, and this
# study has no seasonal campaign. Cannot supply an H4 formula. See 4.0.3.
# ===========================================================================

# ===========================================================================
# NOT A PAPER REPLICATION. This is the present study's own model, kept separate
# so it is never mistaken for a ported source test. No screened European paper
# specifies a UTCI x dBA term; this block exists only to report it explicitly.
# ===========================================================================
H4_CONTINUOUS <- list(
  formula = "Y_ij = b0 + b1*UTCI_z + b2*dBA_z + b3*(UTCI_z x dBA_z) + u_0i + e_ij",
  outcomes = c(
    # votes
    "thermal_comfort", "acoustic_comfort", "overall_comfort",
    # physiology the retained papers report
    "heart_rate", "eda_tonic", "skin_temp", "sdnn", "rmssd",
    # additional available outcomes
    "visual_comfort", "prs_total", "pleasantness"),
  run = function(epochs) {
    cells <- h4_walk_cells(epochs)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$ParticipantID <- factor(cells$ParticipantID)
    out <- list()
    for (oc in H4_CONTINUOUS$outcomes) {
      if (!oc %in% names(cells)) next
      ok <- is.finite(cells[[oc]]) & is.finite(cells$utci_z) & is.finite(cells$dba_z)
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 12L) next
      y <- d[[oc]]
      if (oc %in% c("heart_rate", "eda_tonic", "skin_temp", "sdnn", "rmssd")) {
        if (all(y > 0, na.rm = TRUE)) { d$.y <- log(y); scale_lab <- "log" }
        else { d$.y <- y; scale_lab <- "native" }
      } else { d$.y <- y; scale_lab <- "native" }
      fit <- tryCatch(nlme::lme(.y ~ utci_z * dba_z,
        random = ~ 1 | ParticipantID, data = d, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(opt = "optim")), error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      for (tm in rownames(tt)) {
        if (tm == "(Intercept)") next
        # H4 fix A3: for the 8 direct-test outcomes this interaction equals the walking
        # direct test (same data, same model); reported once, in the direct-test block.
        if (grepl(":", tm, fixed = TRUE) && oc %in% H4_CONDITIONAL_SLOPES$outcomes) next
        out[[length(out) + 1L]] <- h4_result(
          "H4 continuous (own model)", "UTCI x dBA interaction model", H4_CONTINUOUS$formula, oc,
          estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
          statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
          n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
          statistic_test = "LMM (participant intercept); walking bouts",
          note = sprintf(paste("Walking bouts only, outcome scale = %s.",
            "Main effects are conditional on the other exposure at its mean."),
            scale_lab),
          term = tm)
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Tram exploratory extra. Not H4. Seated, one bout per person, no green-urban
# pair. LMM with (1|participant) is not identified; OLS and correlations only.
# Cureau Wilcoxon is skipped (needs two phases).
# A small p here cannot support H4.
# ===========================================================================
H4_TRAM_EXPLORATORY <- list(
  scope = "tram (exploratory extra)",
  formula = "OLS on 11 seated tram bouts; no random intercept; no green-urban pair",
  run = function(tram_epochs) {
    cells <- h4_tram_cells(tram_epochs)
    if (!nrow(cells)) return(NULL)
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$Noise_max_z <- H4_UTIL$z(cells$dba_max)
    cells$Noise_sd_z <- H4_UTIL$z(cells$dba_sd)
    cells$Temp_max_z <- H4_UTIL$z(cells$air_temp_max)
    cells$Temp_mean_z <- H4_UTIL$z(cells$air_temp)
    cells$air_temp_z <- H4_UTIL$z(cells$air_temp)
    cells$air_rh_z <- H4_UTIL$z(cells$air_rh)
    cells$wind_z <- H4_UTIL$z(cells$wind_aws)
    scope <- H4_TRAM_EXPLORATORY$scope
    out <- list()
    add_lm_terms <- function(paper, test, formula, d, fml, outcome, terms, statistic_test, note) {
      fit <- tryCatch(stats::lm(fml, data = d), error = function(e) e)
      if (inherits(fit, "error")) return()
      sm <- summary(fit)$coefficients
      for (tm in terms) {
        if (!tm %in% rownames(sm)) next
        out[[length(out) + 1L]] <<- h4_result(
          paper, test, formula, outcome,
          estimate = sm[tm, "Estimate"], se = sm[tm, "Std. Error"],
          df = fit$df.residual, statistic = sm[tm, "t value"], p = sm[tm, "Pr(>|t|)"],
          n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
          statistic_test = statistic_test, note = note, term = tm)
      }
    }

    # 1. Updated H4 analogue (OLS): cannot identify (1|participant) on 1 bout/person.
    for (oc in c("thermal_comfort", "acoustic_comfort", "overall_comfort")) {
      ok <- is.finite(cells[[oc]]) & is.finite(cells$dba_z) & is.finite(cells$utci_z)
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 8L) next
      d$.y <- d[[oc]]
      add_lm_terms(
        "Tram exploratory — updated H4 analogue",
        paste0("OLS Y ~ dBA_z + UTCI_z [", scope, "]"),
        "Y = b0 + b1*dBA_z + b2*UTCI_z   [OLS; 11 seated bouts]",
        d, .y ~ dba_z + utci_z, oc, c("dba_z", "utci_z"),
        "OLS (tram has one bout per person; LMM not identified)",
        "Exploratory extra. Between-person seated tram, not within-person green vs urban. Cannot support H4.")
    }

    # 2. Peng five models as OLS.
    peng <- list(
      list(y = "thermal_comfort", x = "dba_z", lab = "TSV ~ LAeq"),
      list(y = "thermal_comfort", x = "acoustic_comfort", lab = "TSV ~ ASV"),
      list(y = "acoustic_comfort", x = "utci_z", lab = "ASV ~ UTCI"),
      list(y = "acoustic_comfort", x = "dba_z", lab = "ASV ~ LAeq"),
      list(y = "acoustic_comfort", x = "thermal_comfort", lab = "ASV ~ TSV"))
    for (m in peng) {
      ok <- is.finite(cells[[m$y]]) & is.finite(cells[[m$x]])
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 8L) next
      d$.y <- d[[m$y]]
      d$predictor <- d[[m$x]]
      add_lm_terms(
        "Tram exploratory — Peng 2025",
        paste0("OLS mixed-linear analogue: ", m$lab, " [", scope, "]"),
        H4_PENG2025$formula, d, .y ~ predictor, m$y, "predictor",
        "OLS (tram; source mixed-linear not identified on 1 bout/person)",
        sprintf("Exploratory extra. Predictor = %s. Cannot support H4.", m$x))
    }

    # 3. Cureau Fisher on Tram only (Wilcoxon urban-green skipped).
    for (pair in list(
      c("thermal_comfort", "acoustic_comfort", "fisher_tc_ac"),
      c("overall_comfort", "acoustic_comfort", "fisher_oc_ac"))) {
      d <- cells[is.finite(cells[[pair[1]]]) & is.finite(cells[[pair[2]]]), , drop = FALSE]
      if (nrow(d) < 4L) next
      tab <- table(d[[pair[1]]], d[[pair[2]]])
      if (any(dim(tab) < 2L)) next
      ft <- tryCatch(stats::fisher.test(tab, workspace = 2e8),
        error = function(e) { set.seed(20261110); tryCatch(stats::fisher.test(tab, simulate.p.value = TRUE, B = 1e5), error = function(e2) NULL) })
      if (is.null(ft)) next
      out[[length(out) + 1L]] <- h4_result(
        "Tram exploratory — Cureau 2022",
        paste0("Fisher ", pair[1], " x ", pair[2], " | Tram [", scope, "]"),
        H4_CUREAU2022$formula_fisher, paste0(pair[1], " x ", pair[2]),
        statistic = unname(ft$statistic), p = ft$p.value,
        n_obs = nrow(d), n_participants = nrow(d),
        statistic_test = "Fisher exact test (one tram bout per person)",
        note = "Exploratory extra. Wilcoxon urban-green skipped. Cannot support H4.",
        term = pair[3])
    }

    # 5. Rodrigues blocks as OLS.
    rod_blocks <- list(
      list(pred = c("Noise_max_z", "Noise_sd_z"), label = "Noise block", formula = H4_RODRIGUES$formula_noise),
      list(pred = c("Temp_max_z", "Temp_mean_z"), label = "Temperature block", formula = H4_RODRIGUES$formula_temp))
    for (blk in rod_blocks) {
      for (oc in H4_RODRIGUES$outcomes) {
        ok <- is.finite(cells[[oc]]) & Reduce(`&`, lapply(blk$pred, function(v) is.finite(cells[[v]])))
        d <- cells[ok, , drop = FALSE]
        if (nrow(d) < 8L) next
        fml <- stats::as.formula(paste0(oc, " ~ ", paste(blk$pred, collapse = " + ")))
        fit <- tryCatch(stats::lm(fml, data = d), error = function(e) e)
        if (inherits(fit, "error")) next
        sm <- summary(fit)$coefficients
        for (tm in blk$pred) {
          if (!tm %in% rownames(sm)) next
          pv <- sm[tm, "Pr(>|t|)"]
          est <- sm[tm, "Estimate"]
          met <- is.finite(pv) && pv < 0.05 && abs(est) > 0.1
          out[[length(out) + 1L]] <- h4_result(
            "Tram exploratory — Rodrigues 2026",
            paste0(blk$label, " [", scope, "]"), blk$formula, oc,
            estimate = est, se = sm[tm, "Std. Error"], df = fit$df.residual,
            statistic = sm[tm, "t value"], p = pv,
            n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = "OLS (tram; source MixedLM not identified on 1 bout/person)",
            note = sprintf("%s; source retention (p<.05 & |beta|>0.1) = %s. Exploratory extra. Cannot support H4.",
              tm, if (met) "MET" else "not met"),
            term = tm)
        }
      }
    }

    # 7. Baquero Pearson/Spearman (MLR with 4 predictors on n=11 skipped).
    y <- cells$overall_comfort
    pearson_x <- list(air_temp = cells$air_temp, air_rh = cells$air_rh,
                      dba = cells$dba, wind_aws = cells$wind_aws)
    for (xn in names(pearson_x)) {
      xv <- pearson_x[[xn]]
      ok <- is.finite(y) & is.finite(xv)
      if (sum(ok) < 8L || stats::sd(y[ok]) == 0 || stats::sd(xv[ok]) == 0) next
      ct <- stats::cor.test(xv[ok], y[ok], method = "pearson")
      out[[length(out) + 1L]] <- h4_result(
        "Tram exploratory — Baquero 2019",
        paste0("Pearson: overall_comfort ~ ", xn, " [", scope, "]"),
        H4_BAQUERO2019$formula, "overall_comfort",
        estimate = unname(ct$estimate), statistic = unname(ct$statistic),
        df = if (!is.null(ct$parameter)) unname(ct$parameter) else NA_real_,
        p = ct$p.value, n_obs = sum(ok),
        n_participants = length(unique(cells$ParticipantID[ok])),
        statistic_test = "Pearson r",
        note = "Exploratory extra. Source DV = stay counts. Cannot support H4.",
        term = paste0("baquero_pearson_", xn))
    }
    spearman_x <- list(thermal_comfort = cells$thermal_comfort, acoustic_comfort = cells$acoustic_comfort)
    for (xn in names(spearman_x)) {
      xv <- spearman_x[[xn]]
      ok <- is.finite(y) & is.finite(xv)
      if (sum(ok) < 8L || stats::sd(y[ok]) == 0 || stats::sd(xv[ok]) == 0) next
      ct <- stats::cor.test(xv[ok], y[ok], method = "spearman", exact = FALSE)
      out[[length(out) + 1L]] <- h4_result(
        "Tram exploratory — Baquero 2019",
        paste0("Spearman: overall_comfort ~ ", xn, " [", scope, "]"),
        H4_BAQUERO2019$formula, "overall_comfort",
        estimate = unname(ct$estimate), statistic = unname(ct$statistic),
        p = ct$p.value, n_obs = sum(ok),
        n_participants = length(unique(cells$ParticipantID[ok])),
        statistic_test = "Spearman rho",
        note = "Exploratory extra. Source DV = stay counts. Cannot support H4.",
        term = paste0("baquero_spearman_", xn))
    }

    # 8. Grapas delay OLS (11 delays; LMM not identified).
    rows <- list()
    for (idx in H4_UTIL$bouts(tram_epochs)) {
      b <- tram_epochs[idx, ]
      b <- b[order(b$Datetime), ]
      n <- nrow(b)
      ov <- H4_GRAPAS$min_overlap
      step <- H4_GRAPAS$epoch_seconds
      k_max <- min(H4_GRAPAS$max_lag, max(0L, n - ov))
      for (ex in c("ucm_SND_dBA", "ucm_UTCI")) for (rs in c("empatica_heart_rate", "empatica_eda_tonic")) {
        x <- as.numeric(b[[ex]]); y <- as.numeric(b[[rs]])
        best_k <- NA_integer_; best_r <- -Inf
        if (n >= ov) for (k in 0:k_max) {
          xx <- x[seq_len(n - k)]; yy <- y[(1L + k):n]
          ok <- is.finite(xx) & is.finite(yy)
          if (sum(ok) < ov || stats::sd(xx[ok]) == 0 || stats::sd(yy[ok]) == 0) next
          r <- abs(stats::cor(xx[ok], yy[ok]))
          if (r > best_r) { best_r <- r; best_k <- k }
        }
        rows[[length(rows) + 1L]] <- data.frame(
          ParticipantID = as.character(b$ParticipantID[1]),
          exposure = ex, response = rs, delay_s = best_k * step,
          exposure_level = {
            if (ex != "ucm_SND_dBA") H4_UTIL$finite_mean(x) else {
              xx <- x[is.finite(x)]
              if (!length(xx) || min(xx) < 0 || max(xx) > 150) H4_UTIL$finite_mean(x) else H4_UTIL$energy_mean_db(x)
            }
          },
          stringsAsFactors = FALSE)
      }
    }
    if (length(rows)) {
      dd <- do.call(rbind, rows)
      lab <- c(ucm_SND_dBA = "dba", ucm_UTCI = "utci", empatica_heart_rate = "hr", empatica_eda_tonic = "eda")
      for (ex in c("ucm_SND_dBA", "ucm_UTCI")) for (rs in c("empatica_heart_rate", "empatica_eda_tonic")) {
        d <- dd[dd$exposure == ex & dd$response == rs & is.finite(dd$delay_s) & is.finite(dd$exposure_level), , drop = FALSE]
        if (nrow(d) < 8L) next
        d$exposure_z <- H4_UTIL$z(d$exposure_level)
        fit <- tryCatch(stats::lm(delay_s ~ exposure_z, data = d), error = function(e) e)
        if (inherits(fit, "error")) next
        sm <- summary(fit)$coefficients
        if (!"exposure_z" %in% rownames(sm)) next
        out[[length(out) + 1L]] <- h4_result(
          "Tram exploratory — Grapas 2026",
          paste0("OLS delay: ", lab[[ex]], " -> ", lab[[rs]], " [", scope, "]"),
          H4_GRAPAS$formula,
          paste0("delay_", lab[[rs]], "_after_", lab[[ex]]),
          estimate = sm["exposure_z", "Estimate"], se = sm["exposure_z", "Std. Error"],
          df = fit$df.residual, statistic = sm["exposure_z", "t value"],
          p = sm["exposure_z", "Pr(>|t|)"],
          n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
          statistic_test = "OLS on bout-level delay (tram; LMM not identified)",
          note = sprintf("Exploratory extra. Mean delay = %.0f s. Cannot support H4.", mean(d$delay_s)),
          term = paste0("grapas_delay_", lab[[ex]], "_", lab[[rs]]))
      }
    }

    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ---------------------------------------------------------------------------
# I/O
# ---------------------------------------------------------------------------
H4_IO <- list(
  read_epochs = function(root) {
    epochs <- read.csv(paper3_merged_8min_path(root), check.names = FALSE)
    epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% PAPER3_CORE_PHASES, ]
    epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = "UTC")
    epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
  },
  read_tram_epochs = function(root) {
    epochs <- read.csv(paper3_merged_8min_path(root), check.names = FALSE)
    epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID == "Tram", ]
    epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = "UTC")
    epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
  },
  write = function(catalog, notes, root) {
    if (!nrow(catalog)) stop("No H4 results to write.")
    catalog$implementation_type <- ifelse(catalog$paper %in% c("H4 conditional slope", "H4 continuous (own model)"),
      "present-study model", "source-informed adaptation")
    catalog$paper_rule <- "source nominal p < 0.05; local measurement/design differs"
    catalog$source_reference_rule_met <- is.finite(catalog$p) & catalog$p < 0.05
    catalog$analysis_rule <- "local nominal p < 0.05 (not FDR confirmation)"
    catalog$analysis_rule_met <- is.finite(catalog$p) & catalog$p < 0.05
    rod <- catalog$paper == "Rodrigues 2026"
    catalog$paper_rule[rod] <- "source rounded Wald-z p < 0.05 AND rounded |beta| > 0.1; local t-reference adaptation differs"
    catalog$source_reference_rule_met[rod] <- NA
    catalog$analysis_rule[rod] <- "local t-reference p < 0.05 AND |beta| > 0.1"
    catalog$analysis_rule_met[rod] <- is.finite(catalog$p[rod]) & catalog$p[rod] < .05 & abs(catalog$estimate[rod]) > .1
    kor <- catalog$paper == "Korpilo 2024"
    catalog$paper_rule[kor] <- "source interaction-selection alpha 0.10 in different EDA/ROS models; not the local reporting rule"
    catalog$source_reference_rule_met[kor] <- NA
    proxy <- catalog$paper == "Grapas 2026"
    catalog$paper_rule[proxy] <- "source network/bootstrap/latency procedure not reproduced by cross-correlation proxy"
    catalog$source_reference_rule_met[proxy] <- NA
    peng <- catalog$paper == "Peng 2025"
    catalog$paper_rule[peng] <- "source mixed-linear p < 0.05 on TSV/ASV confound hypotheses; coefficients not in the ICUC-12 abstract"
    catalog$source_reference_rule_met[peng] <- NA
    catalog$analysis_rule[peng] <- "local t-reference p < 0.05"
    catalog$analysis_rule_met[peng] <- is.finite(catalog$p[peng]) & catalog$p[peng] < 0.05
    baq <- catalog$paper == "Baquero 2019"
    catalog$paper_rule[baq] <- "source p < 0.05 on occupancy correlations/regression; local DV is overall_comfort"
    catalog$source_reference_rule_met[baq] <- NA
    catalog$analysis_rule[baq] <- "local p < 0.05"
    catalog$analysis_rule_met[baq] <- is.finite(catalog$p[baq]) & catalog$p[baq] < 0.05
    own <- catalog$paper %in% c("H4 conditional slope", "H4 continuous (own model)")
    catalog$paper_rule[own] <- "not a source-paper test"
    catalog$source_reference_rule_met[own] <- NA
    if (!"source_primary" %in% names(catalog)) catalog$source_primary <- NA
    # H4 fix A1: predicted sign for every dBA x UTCI interaction term.
    is_int <- catalog$paper %in% c("H4 conditional slope", "H4 continuous (own model)") &
      grepl(":", catalog$term, fixed = TRUE)
    sgn <- unname(H4_PREDICTED_SIGN[catalog$outcome])
    catalog$predicted_direction <- ifelse(is_int & !is.na(sgn), ifelse(sgn < 0, "negative", "positive"), NA_character_)
    catalog$in_predicted_direction <- ifelse(is_int & !is.na(sgn), sign(catalog$estimate) == sgn, NA)
    # Direction is reported alongside nominal p. No BH/FDR correction is applied to
    # this catalogue: each source keeps its own decision rule and the direct H4
    # tests are reported at nominal p with the predicted sign stated.
    is_direct <- catalog$paper == "H4 conditional slope" & grepl(":", catalog$term, fixed = TRUE)
    i <- catalog$paper == "Moshammer 2019"
    catalog$analysis_rule[i] <- "prespecified SDNN comparison p < 0.05; others secondary"
    catalog$analysis_rule_met[i] <- catalog$source_primary[i] %in% TRUE & catalog$p[i] < 0.05
    i <- catalog$paper == "Grapas 2026"
    catalog$analysis_rule[i] <- "source rule p < 0.05 on any term; no single primary test"
    catalog$analysis_rule_met[i] <- is.finite(catalog$p[i]) & catalog$p[i] < 0.05
    i <- is_direct
    catalog$analysis_rule[i] <- "nominal p < 0.05 AND analysis-specified direction"
    catalog$analysis_rule_met[i] <- is.finite(catalog$p[i]) & catalog$p[i] < 0.05 &
      catalog$in_predicted_direction[i] %in% TRUE
    i <- catalog$paper == "H4 conditional slope" & !is_direct
    catalog$analysis_rule[i] <- "descriptive only (no decision rule)"
    catalog$analysis_rule_met[i] <- NA
    catalog$source_reference_rule_met[i] <- NA
    # Retire the ambiguous source-success flag; local and reference flags are separate.
    catalog$paper_rule_met <- NULL
    staging <- tempfile("H4_")
    dir.create(staging)
    catalog <- h4_classify_relevance(catalog)
    catalog$is_direct_h4_test <- is_direct
    catalog$h4_relevance[catalog$h4_relevance == "core"] <- "contextual"
    catalog$h4_relevance[is_direct] <- "direct"
    write.csv(catalog, file.path(staging, "H4_sound_literature_tests.csv"), row.names = FALSE, na = "")
    # H4-relevant subset: the tests that can actually bear on the hypothesis.
    h4_only <- catalog[catalog$h4_relevance %in% c("direct", "contextual", "supporting"), ]
    h4_only <- h4_only[order(factor(h4_only$h4_relevance, c("direct", "contextual", "supporting")), h4_only$paper, h4_only$p), ]
    write.csv(h4_only, file.path(staging, "H4_tests_relevant_to_hypothesis.csv"), row.names = FALSE, na = "")
    summary <- do.call(rbind, lapply(split(catalog, catalog$paper), function(d)
      data.frame(paper = d$paper[1], n_tests = nrow(d),
        n_direct_h4 = sum(d$is_direct_h4_test),
        n_contextual = sum(d$h4_relevance == "contextual"),
        n_supporting = sum(d$h4_relevance == "supporting"),
        n_not_h4 = sum(d$h4_relevance == "not_h4"),
        n_p_lt_05 = sum(is.finite(d$p) & d$p < 0.05),
        n_analysis_rule_met = sum(d$analysis_rule_met %in% TRUE),
        n_source_reference_cutoff_met = sum(d$source_reference_rule_met %in% TRUE),
        n_estimable = sum(is.finite(d$p)), stringsAsFactors = FALSE)))
    write.csv(summary, file.path(staging, "SUMMARY_sound_tests_paper_rule.csv"), row.names = FALSE, na = "")
    writeLines(notes, file.path(staging, "METHODS_NOTES.md"))
    output <- file.path(root, "output", "statistical_analysis", "results", "H4_sound_literature_test")
    dir.create(output, recursive = TRUE, showWarnings = FALSE)
    for (f in list.files(staging, full.names = TRUE)) {
      dest <- file.path(output, basename(f))
      ok <- suppressWarnings(try(file.copy(f, dest, overwrite = TRUE), silent = TRUE))
      if (!isTRUE(ok)) {
        # A viewer (Excel / IDE) may hold the file open. Write a timestamped
        # sibling instead of silently keeping a stale table.
        alt <- sub("\\.csv$", paste0("_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv"), dest)
        if (grepl("\\.csv$", dest)) {
          file.copy(f, alt, overwrite = TRUE)
          warning("Could not overwrite ", basename(dest), " (file locked). Wrote ", basename(alt), call. = FALSE)
        } else warning("Could not overwrite ", basename(dest), call. = FALSE)
      }
    }
    cat("Saved", nrow(catalog), "rows to", output, "\n")
    invisible(catalog)
  })
