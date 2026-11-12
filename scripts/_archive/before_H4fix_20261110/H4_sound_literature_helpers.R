# H4_sound_literature_test.R — one test per screened paper, each implementing that paper's own formula.
# Nominal p only; no catalogue-wide FDR. Every function states the formula it reproduces.

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
      air_rh = H4_UTIL$finite_mean(b$ucm_AIR_RH),
      dba = H4_UTIL$energy_mean_db(b$ucm_SND_dBA),
      dba_max = H4_UTIL$finite_max(b$ucm_SND_dBA),
      dba_sd = H4_UTIL$finite_sd(b$ucm_SND_dBA),
      # NDSI derived from octave bands, matching Korpilo's definition:
      # biophonic = 2-8 kHz (octaves 2000 + 4000 + 8000 Hz),
      # anthrophonic = 1-2 kHz (octave 1000 Hz).
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
      # Korpilo ROS analogue: PRS-11 total mean (perceived restorativeness).
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
# H4 relevance filter. Each paper's own test is kept exactly as published, then
# tagged by whether it can bear on H4 (sound amplifies discomfort under thermal
# stress). No test is altered; irrelevant rows are simply flagged and separated.
#
#   core       = the test directly addresses the H4 question: a sound effect
#                conditioned on thermal, a thermal-acoustic coupling, or a
#                thermal x sound product. These are the H4 results.
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

    # ---- core: sound conditioned on thermal, or thermal-acoustic coupling ----
    core <- FALSE
    reason <- NA_character_

    if (pap == "Chiucchiu 2026") {
      # Thermal vs acoustic vote coupling is the paper's cross-domain result.
      if (grepl("^spearman_(tc|ac)", trm) && grepl("_(ac|tc|pl)$", trm)) {
        core <- TRUE; reason <- "thermal-acoustic vote coupling"
      }
      # Table 5: thermal C0->C1 delta within each soundscape stratum.
      if (grepl("^delta_", trm)) {
        core <- TRUE; reason <- "thermal effect within sound stratum (Table 5 analogue)"
      }
    }
    if (pap == "Cureau 2022" && grepl("^fisher_(tc|oc)_ac", trm)) {
      core <- TRUE; reason <- "comfort-domain dependence incl. acoustic (Fisher cross-tab)"
    }
    if (pap == "Korpilo 2024" && grepl(":", trm, fixed = TRUE)) {
      core <- TRUE; reason <- "two-way interaction term retained-tested by the source"
    }
    if (pap == "Grapas 2026" && grepl("pearson_utci_dba|pearson_dba_utci", trm)) {
      core <- TRUE; reason <- "direct sound-thermal SOR edge"
    }
    if (pap == "H4 conditional slope") {
      core <- TRUE
      reason <- if (identical(trm, "slope_diff_warmer_minus_cooler"))
        "sound slope contrast warmer vs cooler" else "dBA x UTCI interaction"
    }

    if (core) { d$h4_relevance[i] <- "core"; d$h4_reason[i] <- reason; next }

    # ---- supporting: one component of the joint hypothesis ----
    supporting <- FALSE
    if (pap %in% c("Chiucchiu 2026", "Pigliautile 2021", "Cureau 2023") &&
        grepl("C0|delta", tst)) {
      supporting <- TRUE
      reason <- "thermal main effect on comfort/physiology"
    }
    if (pap == "Cureau 2022" && grepl("^mannwhitney$", trm)) {
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
    if (pap == "Grapas 2026" && grepl("pearson_", trm)) {
      supporting <- TRUE; reason <- "single-domain SOR edge"
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
H4_CONDITIONAL_SLOPES <- list(
  formula_stratified = paste(
    "Within thermal stratum s: Y_ij = b0_s + b1_s*dBA_z_ij + u_0i + e_ij ;",
    "H4 = b1_warmer - b1_cooler (more negative = amplification)"),
  formula_continuous = paste(
    "Y_ij = b0 + b1*dBA_z + b2*UTCI_z + b3*(dBA_z x UTCI_z) + u_0i + e_ij ;",
    "H4 = b3 (negative = sound hurts more as UTCI rises)"),
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
    scope <- switch(mode,
      walk = "walk (source scope)",
      bike = "bike (extension)",
      both = "all phases")
    out <- list()

    # (A) Stratified slopes: sound slope within warmer vs cooler half,
    #     then the slope difference. Strata are person-relative.
    cells$thermal_stratum <- NA_character_
    for (p in unique(cells$ParticipantID)) {
      i <- which(cells$ParticipantID == p)
      if (length(i) < 2L || !any(is.finite(cells$utci[i]))) next
      med <- stats::median(cells$utci[i], na.rm = TRUE)
      cells$thermal_stratum[i] <- ifelse(cells$utci[i] > med, "warmer", "cooler")
    }
    for (oc in H4_CONDITIONAL_SLOPES$outcomes) {
      if (!oc %in% names(cells)) next
      slopes <- list()
      for (st in c("cooler", "warmer")) {
        d <- cells[!is.na(cells$thermal_stratum) & cells$thermal_stratum == st &
                   is.finite(cells[[oc]]) & is.finite(cells$dba_z), , drop = FALSE]
        if (nrow(d) < 6L || length(unique(d$ParticipantID)) < 3L) next
        d$ParticipantID <- droplevels(d$ParticipantID)
        fit <- tryCatch(nlme::lme(stats::as.formula(paste0(oc, " ~ dba_z")),
          random = ~ 1 | ParticipantID, data = d, method = "REML", na.action = na.fail,
          control = nlme::lmeControl(opt = "optim")), error = function(e) e)
        if (inherits(fit, "error")) next
        tt <- summary(fit)$tTable
        if (!"dba_z" %in% rownames(tt)) next
        slopes[[st]] <- c(est = tt["dba_z", "Value"], se = tt["dba_z", "Std.Error"],
                          p = tt["dba_z", "p-value"], n = nrow(d))
        out[[length(out) + 1L]] <- h4_result(
          "H4 conditional slope", paste0("dBA slope | ", st, " [", scope, "]"),
          H4_CONDITIONAL_SLOPES$formula_stratified, oc,
          estimate = tt["dba_z", "Value"], se = tt["dba_z", "Std.Error"],
          df = tt["dba_z", "DF"], statistic = tt["dba_z", "t-value"],
          p = tt["dba_z", "p-value"], n_obs = nrow(d),
          n_participants = nlevels(d$ParticipantID),
          statistic_test = "sound slope within thermal stratum (LMM)",
          note = sprintf("Sound-discomfort slope in the %s half. H4 predicts a MORE NEGATIVE slope in the warmer half.", st),
          term = paste0("dba_z_within_", st))
      }
      if (length(slopes) == 2L) {
        diff_est <- slopes$warmer["est"] - slopes$cooler["est"]
        diff_se <- sqrt(slopes$warmer["se"]^2 + slopes$cooler["se"]^2)
        z <- diff_est / diff_se
        out[[length(out) + 1L]] <- h4_result(
          "H4 conditional slope", paste0("SLOPE DIFF warmer - cooler [", scope, "]"),
          H4_CONDITIONAL_SLOPES$formula_stratified, oc,
          estimate = diff_est, se = diff_se, statistic = z,
          p = 2 * stats::pnorm(abs(z), lower.tail = FALSE),
          n_obs = sum(slopes$warmer["n"], slopes$cooler["n"]),
          n_participants = NA_integer_,
          statistic_test = "difference of stratified sound slopes (Wald z)",
          note = "Negative = sound association is more adverse under warmer conditions. This is the H4 estimand as a slope contrast.",
          term = "slope_diff_warmer_minus_cooler")
      }
    }

    # (B) Continuous interaction in the papers' model form
    for (oc in H4_CONDITIONAL_SLOPES$outcomes) {
      if (!oc %in% names(cells)) next
      ok <- is.finite(cells[[oc]]) & is.finite(cells$dba_z) & is.finite(cells$utci_z)
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 12L) next
      y <- d[[oc]]
      if (oc %in% c("skin_temp", "heart_rate", "eda_tonic") && all(y > 0, na.rm = TRUE)) {
        d$.y <- log(y); lab <- "log"
      } else { d$.y <- y; lab <- "native" }
      fit <- tryCatch(nlme::lme(.y ~ dba_z * utci_z, random = ~ 1 | ParticipantID,
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
        note = sprintf("Continuous form of the same H4 question. Outcome scale = %s. Negative = sound hurts more as UTCI rises.", lab),
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
      grepl("utci_z:dba_z|ndsi_z:temp_z|temp_z:ndsi_z", term_value),
    estimate = one(estimate), se = one(se), df = one(df), statistic = one(statistic),
    p = one(p), n_observations = one(n_obs), n_participants = one(n_participants),
    statistic_test = one(statistic_test), note = one(note),
    stringsAsFactors = FALSE)
}

# ===========================================================================
# Pigliautile 2021 — source has NO test statistic. Reported values are means.
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
        statistic_test = "none — source reports descriptive means only",
        note = "Source Fig. 3a reports 'averaged thermal comfort vote decreased from +1.0 to +0.5'. No test exists to replicate.",
        term = "delta_C1_C0")
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Cureau 2022 — Fisher exact (per park), Mann-Whitney, multinomial logit.
# The acoustic exposure in every test is the acoustic-quality VOTE, not dBA.
# ===========================================================================
H4_CUREAU2022 <- list(
  formula_fisher = "Fisher exact on comfort-domain contingency table, computed separately per park/walk",
  formula_mw = "U = n1*n2 + n1*(n1+1)/2 - R1",
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    cells <- if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs)
    green <- if (mode == "walk") "WalkG" else "BikeG"
    urban <- if (mode == "walk") "WalkU" else "BikeU"
    scope <- if (mode == "walk") "walk (source replication)" else "bike (method extension)"
    out <- list()
    # Fisher: thermal sensation/comfort x acoustic quality, per phase
    for (ph in c(green, urban)) {
      d <- cells[cells$PhaseID == ph, , drop = FALSE]
      d <- d[is.finite(d$thermal_comfort) & is.finite(d$acoustic_comfort), , drop = FALSE]
      if (nrow(d) < 4L) next
      tab <- table(d$thermal_comfort, d$acoustic_comfort)
      if (any(dim(tab) < 2L)) next
      ft <- tryCatch(stats::fisher.test(tab, simulate.p.value = TRUE, B = 1e5),
        error = function(e) NULL)
      if (is.null(ft)) next
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Fisher thermal x acoustic comfort | ", ph, " [", scope, "]"),
        H4_CUREAU2022$formula_fisher, "thermal_comfort x acoustic_comfort",
        statistic = unname(ft$statistic), p = ft$p.value,
        n_obs = nrow(d), n_participants = nrow(d),
        statistic_test = "Fisher exact test (simulated p, B = 1e5)",
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
      ft <- tryCatch(stats::fisher.test(tab, simulate.p.value = TRUE, B = 1e5),
        error = function(e) NULL)
      if (is.null(ft)) next
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Fisher overall x acoustic comfort | ", ph, " [", scope, "]"),
        H4_CUREAU2022$formula_fisher, "overall_comfort x acoustic_comfort",
        statistic = unname(ft$statistic), p = ft$p.value,
        n_obs = nrow(d), n_participants = nrow(d),
        statistic_test = "Fisher exact test (simulated p, B = 1e5)",
        note = sprintf("Source reports acoustic quality vs overall comfort: Park 1 p<0.001, Park 2 p=0.083. Scope: %s.", scope),
        term = "fisher_oc_ac")
    }
    # Mann-Whitney: green vs urban phase on each parameter
    p1 <- cells[cells$PhaseID == green, , drop = FALSE]
    p2 <- cells[cells$PhaseID == urban, , drop = FALSE]
    for (v in c("dba", "air_temp", "utci", "thermal_comfort", "acoustic_comfort")) {
      a <- p1[[v]]; b <- p2[[v]]
      ok <- is.finite(a) & is.finite(b)
      if (sum(ok) < 4L) next
      wt <- suppressWarnings(stats::wilcox.test(a[ok], b[ok]))
      out[[length(out) + 1L]] <- h4_result(
        "Cureau 2022", paste0("Mann-Whitney ", green, " vs ", urban, " | ", v, " [", scope, "]"),
        H4_CUREAU2022$formula_mw, v,
        statistic = unname(wt$statistic), p = wt$p.value,
        n_obs = sum(ok) * 2, n_participants = sum(ok),
        statistic_test = "Mann-Whitney U (two-sided)",
        note = sprintf("Source repeats Mann-Whitney 63 times (9 parameters x 7 walks). Scope: %s.", scope),
        term = "mannwhitney")
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
          mcfadden <- 1 - (ll1 / ll0)
          out[[length(out) + 1L]] <- h4_result(
            "Cureau 2022", paste0("Multinomial logit: thermal + visual + acoustic -> overall comfort [", scope, "]"),
            "ln[P(Y=j)/P(Y=J)] = alpha_j + x'beta_j ; McFadden pseudo-R2 = 1 - LL(model)/LL(null)",
            "overall_comfort",
            statistic = lr, df = df_lr, p = p_lr,
            n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = "likelihood-ratio chi-square for the multinomial model",
            note = sprintf(paste("Source best model = thermal + visual + acoustic questions,",
              "R2 = 0.820 (Park 1) / 0.806 (Park 2). McFadden pseudo-R2 here = %.3f.", mcfadden),
              mcfadden),
            term = "multinom_lr")
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Cureau 2023 — source has NO test. Descriptive means + spectral comparison.
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
        statistic_test = "none — source reports descriptive means only",
        note = "Source states: 'additional data collection should be performed to verify the significance of these findings through statistical methods.'",
        term = "delta_descriptive")
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Grafias 2026 — bootstrap pathway + Granger latency + mixed model on delays.
# Replicated as a mixed model on within-bout exposure->response delay proxies.
# ===========================================================================
H4_GRAPAS <- list(
  formula = "delay_ij = b0 + b1*exposure_ij + (1 | participant)   [SOR network analogue]",
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$ParticipantID <- factor(cells$ParticipantID)
    out <- list()
    # Pairwise associations within the SOR web: exposures x biomarkers x votes
    per <- do.call(rbind, lapply(split(cells, cells$ParticipantID), function(d)
      data.frame(ParticipantID = d$ParticipantID[1],
        utci = mean(d$utci, na.rm = TRUE), dba = mean(d$dba, na.rm = TRUE),
        tc = mean(d$thermal_comfort, na.rm = TRUE),
        hr = mean(d$heart_rate, na.rm = TRUE),
        eda = mean(d$eda_tonic, na.rm = TRUE))))
    pairs <- list(c("dba","tc"), c("utci","tc"), c("dba","hr"), c("utci","hr"),
                  c("dba","eda"), c("utci","eda"))
    for (pr in pairs) {
      x <- per[[pr[1]]]; y <- per[[pr[2]]]
      ok <- is.finite(x) & is.finite(y)
      if (sum(ok) < 5L) next
      ct <- suppressWarnings(stats::cor.test(x[ok], y[ok], method = "pearson"))
      out[[length(out) + 1L]] <- h4_result(
        "Grapas 2026", paste0("SOR edge: ", pr[1], " ~ ", pr[2]), H4_GRAPAS$formula,
        paste0(pr[1], " ~ ", pr[2]),
        estimate = unname(ct$estimate), statistic = unname(ct$statistic), p = ct$p.value,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "Pearson correlation across participant means (SOR edge analogue)",
        note = "Source uses bootstrap pathway strength and Granger latency inside an SOR web. Not ported; this is the phase-mean Pearson edge analogue.",
        term = paste0("pearson_", pr[1], "_", pr[2]))
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# 4.0.2.2 Chiucchiu 2026
#  (1) paired t on d_i = Y_C1 - Y_C0, Cohen's d_z = mean(d)/sd(d)
#  (2) Spearman rho between perceptual domains
#  (3) Table 5 delta per soundscape x descriptor
# ===========================================================================
H4_CHIUCCHIU <- list(
  formula_paired = "d_i = Y_i,C1 - Y_i,C0;  t = mean(d)/(sd(d)/sqrt(n));  d_z = mean(d)/sd(d)",
  formula_spearman = "rho_S = 1 - 6*sum(d_k^2)/(n*(n^2-1))  among domain votes",
  formula_table5 = "Delta_s,k = mean(Y_s,k,C1) - mean(Y_s,k,C0)  per soundscape s and descriptor k",
  run = function(epochs, mode = c("walk", "bike")) {
    mode <- match.arg(mode)
    wide <- h4_mode_wide(epochs, mode)
    cells <- h4_add_strata(if (mode == "walk") h4_walk_cells(epochs) else h4_bike_cells(epochs))
    out <- list()
    scope <- if (mode == "walk") "walk (source replication)" else "bike (method extension)"
    green <- if (mode == "walk") "WalkG" else "BikeG"
    urban <- if (mode == "walk") "WalkU" else "BikeU"

    # (1) paired t + Cohen's d_z — physiology and the vote domains the source tested
    for (v in c("eda_tonic", "heart_rate", "skin_temp", "thermal_comfort", "acoustic_comfort")) {
      c0 <- wide[[paste0(v, ".", green)]]; c1 <- wide[[paste0(v, ".", urban)]]
      ok <- is.finite(c0) & is.finite(c1)
      d <- c1[ok] - c0[ok]
      if (sum(ok) < 3L) next
      tt <- stats::t.test(d)
      out[[length(out) + 1L]] <- h4_result(
        "Chiucchiu 2026", paste0("Paired t C0 vs C1 (+ Cohen d_z) [", scope, "]"),
        H4_CHIUCCHIU$formula_paired, v,
        estimate = mean(d), se = unname(tt$stderr), df = unname(tt$parameter),
        statistic = unname(tt$statistic), p = tt$p.value,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "paired t-test",
        note = sprintf("Cohen d_z = %+.2f. Source rule p<0.05; met = %s. C0=%s (cooler), C1=%s (warmer). Scope: %s.",
          mean(d) / stats::sd(d), if (tt$p.value < 0.05) "MET" else "not met", green, urban, scope),
        term = "C1_minus_C0")
    }

    # (2) Spearman among perceptual domains — source tested thermal vs acoustic,
    #     thermal vs pleasantness, acoustic vs pleasantness (participant means).
    per <- do.call(rbind, lapply(split(cells, cells$ParticipantID), function(d)
      data.frame(ParticipantID = d$ParticipantID[1],
        tc = mean(d$thermal_comfort, na.rm = TRUE),
        ac = mean(d$acoustic_comfort, na.rm = TRUE),
        pl = mean(d$pleasantness, na.rm = TRUE),
        oc = mean(d$overall_comfort, na.rm = TRUE))))
    for (pr in list(c("tc", "ac"), c("tc", "pl"), c("ac", "pl"), c("tc", "oc"), c("ac", "oc"))) {
      x <- per[[pr[1]]]; y <- per[[pr[2]]]; ok <- is.finite(x) & is.finite(y)
      if (sum(ok) < 4L) next
      ct <- suppressWarnings(stats::cor.test(x[ok], y[ok], method = "spearman"))
      out[[length(out) + 1L]] <- h4_result(
        "Chiucchiu 2026", paste0("Spearman ", pr[1], " vs ", pr[2], " [", scope, "]"), H4_CHIUCCHIU$formula_spearman,
        paste0(pr[1], " ~ ", pr[2]),
        estimate = unname(ct$estimate), statistic = unname(ct$statistic), p = ct$p.value,
        n_obs = sum(ok), n_participants = sum(ok),
        statistic_test = "Spearman rank correlation",
        note = sprintf("Participant means, one value per person. Source: correlations among perceptual evaluations of different domains. Scope: %s.", scope),
        term = paste0("spearman_", pr[1], "_", pr[2]))
    }

    # (3) Table 5: delta C1-C0 per descriptor WITHIN each soundscape, asterisk at p<0.05
    for (st in c("quieter", "louder")) {
      sel <- wide[wide[[paste0("sound_stratum.", green)]] %in% st |
                  wide[[paste0("sound_stratum.", urban)]] %in% st, , drop = FALSE]
      if (!nrow(sel)) next
      for (v in c("thermal_comfort", "acoustic_comfort", "overall_comfort", "pleasantness")) {
        c0 <- sel[[paste0(v, ".", green)]]; c1 <- sel[[paste0(v, ".", urban)]]
        ok <- is.finite(c0) & is.finite(c1)
        if (sum(ok) < 3L) next
        d <- c1[ok] - c0[ok]
        tt <- stats::t.test(d)
        out[[length(out) + 1L]] <- h4_result(
          "Chiucchiu 2026", paste0("Table 5 delta | ", st, " soundscape [", scope, "]"),
          H4_CHIUCCHIU$formula_table5, v,
          estimate = mean(d), se = unname(tt$stderr), df = unname(tt$parameter),
          statistic = unname(tt$statistic), p = tt$p.value,
          n_obs = sum(ok), n_participants = sum(ok),
          statistic_test = "paired t-test on the delta",
          note = sprintf("%s* where p<0.05, as in Table 5. Scope: %s.",
            if (tt$p.value < 0.05) "" else "not ", scope),
          term = paste0("delta_", st))
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# REMOVED: Cureau 2022 — no sound variable in any of its three analyses
# (Fisher exact, Mann-Whitney, multinomial logit). Nothing to moderate. See 4.0.3.
# ===========================================================================

# ===========================================================================
# 4.0.2.3 Moshammer 2019 — random-effects GLS:
#   Y_it = a + b1*Leq_{i,t-1} + b2*T_it + u_i + e_it
#   exposure = preceding 5 min, outcome = following 3 min
# ===========================================================================
H4_MOSHAMMER <- list(
  formula = "Y_it = a + b1*Leq(i,t-1) + b2*T_it + b3*Mode_i + u_i + e_it   [xtreg, re; additive]",
  exposure_seconds = 300,
  # Green = BikeG + WalkG; Urban = BikeU + WalkU. Both modes are included so the
  # environment contrast (green vs urban) is estimated from both, and mode enters
  # as a fixed-effect control rather than being dropped.
  phases = c("BikeG", "BikeU", "WalkG", "WalkU"),
  run = function(epochs, controls = TRUE) {
    out <- list()
    H4_MOSHAMMER$cache <- list()
    use_epochs <- epochs[epochs$PhaseID %in% H4_MOSHAMMER$phases, , drop = FALSE]
    for (rows in H4_UTIL$bouts(use_epochs)) {
      b <- use_epochs[rows, ]
      secs <- as.numeric(difftime(b$Datetime, min(b$Datetime), units = "secs"))
      exp_r <- secs < H4_MOSHAMMER$exposure_seconds
      out_r <- secs >= H4_MOSHAMMER$exposure_seconds
      if (!any(out_r) || sum(is.finite(b$ucm_SND_dBA[exp_r])) < 20L) next
      H4_MOSHAMMER$cache[[length(H4_MOSHAMMER$cache) + 1L]] <- data.frame(
        ParticipantID = b$ParticipantID[1], PhaseID = b$PhaseID[1],
        leq_prev = H4_UTIL$energy_mean_db(b$ucm_SND_dBA[exp_r]),
        air_temp = H4_UTIL$finite_mean(b$ucm_AIR_temp[out_r]),
        sdnn = H4_UTIL$finite_mean(b$empatica_hrv_td_sdnn[out_r]),
        rmssd = H4_UTIL$finite_mean(b$empatica_hrv_td_rmssd[out_r]),
        heart_rate = H4_UTIL$finite_mean(b$empatica_heart_rate[out_r]),
        Mode = if (grepl("^Bike", b$PhaseID[1])) "Bike" else "Walk",
        Environment = if (grepl("G$", b$PhaseID[1])) "Green" else "Urban",
        stringsAsFactors = FALSE)
    }
    d <- do.call(rbind, H4_MOSHAMMER$cache)
    if (is.null(d) || nrow(d) < 5L) return(NULL)
    d$ParticipantID <- factor(d$ParticipantID)
    d$Mode <- factor(d$Mode, levels = c("Walk", "Bike"))
    # Source fits BOTH the unadjusted noise-only model (Table A2) and the
    # temperature-adjusted model (Methods). Mode is added as a control so that
    # green = {BikeG, WalkG} and urban = {BikeU, WalkU} both contribute.
    for (spec in list(list(ctrl = FALSE, label = "unadjusted (Table A2)"),
                      list(ctrl = TRUE,  label = "temperature-adjusted"))) {
      for (oc in c("sdnn", "rmssd", "heart_rate")) {
        rhs <- if (spec$ctrl) "leq_prev + air_temp + Mode" else "leq_prev + Mode"
        resp <- if (oc == "heart_rate") oc else paste0("log(", oc, ")")
        fml <- stats::as.formula(paste(resp, "~", rhs))
        fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
          method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
          error = function(e) e)
        if (inherits(fit, "error")) next
        tt <- summary(fit)$tTable
        if (!"leq_prev" %in% rownames(tt)) next
        # temperature terms are reported too: the source claims they do not confound
        tms <- c("leq_prev", if (spec$ctrl) "air_temp")
        for (tm in tms) {
          if (!tm %in% rownames(tt)) next
          # Mode is a nuisance control, not a source term, so never reported.
          if (grepl("^Mode", tm)) next
          out[[length(out) + 1L]] <- h4_result(
            "Moshammer 2019", paste0("RE GLS ", tm, " -> ", oc, " [", spec$label, "]"),
            H4_MOSHAMMER$formula, oc,
            estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"],
            df = tt[tm, "DF"], statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
            n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
            statistic_test = "random-effects LMM (xtreg, re analogue)",
            note = paste("First 5 min = exposure window, 5-8 min = outcome window.",
              "Additive model: the source has no thermal x sound product term,",
              "and reports that temperature did not confound the noise estimate."),
            term = tm)
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  },
  cache = list())

# ===========================================================================
# 4.0.2.3 Rodrigues 2026 — participant-intercept MixedLM.
#   Source: five thematic blocks tested in SEPARATE models.
#     Noise block:       Y_ij = b0 + b1*z(NOISE_max) + b2*z(NOISE_sd) + u_0i + e_ij
#     Temperature block: Y_ij = b0 + b1*z(TEMP_max)  + b2*z(TEMP_sd)  + u_0i + e_ij
#   Retention: p < 0.05 AND |beta| > 0.1
#   The source never multiplies the blocks, so H4 is not estimated. Both blocks
#   are fitted here so the source's own reported contrast can be compared.
# ===========================================================================
H4_RODRIGUES <- list(
  formula_noise = "Y_ij = b0 + b1*z(NOISE_max_ij) + b2*z(NOISE_sd_ij) + u_0i + e_ij",
  formula_temp = "Y_ij = b0 + b1*z(TEMP_max_ij) + b2*z(TEMP_sd_ij) + u_0i + e_ij",
  outcomes = c("heart_rate", "eda_tonic", "skin_temp", "sdnn", "rmssd"),
  # Green = BikeG + WalkG; Urban = BikeU + WalkU. Both modes included so the
  # environment contrast uses all four phases; Mode enters as a fixed control.
  phases = c("BikeG", "BikeU", "WalkG", "WalkU"),
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells <- cells[cells$PhaseID %in% H4_RODRIGUES$phases, , drop = FALSE]
    cells$Noise_max_z <- H4_UTIL$z(cells$dba_max)
    cells$Noise_sd_z <- H4_UTIL$z(cells$dba_sd)
    cells$Temp_max_z <- H4_UTIL$z(cells$air_temp)
    cells$Temp_sd_z <- H4_UTIL$z(cells$temp_sd)
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$Mode <- factor(ifelse(grepl("^Bike", cells$PhaseID), "Bike", "Walk"),
      levels = c("Walk", "Bike"))
    out <- list()
    blocks <- list(
      noise = list(pred = c("Noise_max_z", "Noise_sd_z"), label = "Noise block",
        formula = H4_RODRIGUES$formula_noise),
      temperature = list(pred = c("Temp_max_z", "Temp_sd_z"), label = "Temperature block",
        formula = H4_RODRIGUES$formula_temp))
    for (blk in blocks) {
      for (oc in H4_RODRIGUES$outcomes) {
        ok <- is.finite(cells[[oc]]) & Reduce(`&`, lapply(blk$pred, function(v) is.finite(cells[[v]])))
        d <- cells[ok, , drop = FALSE]
        if (nrow(d) < 8L) next
        fml <- stats::as.formula(paste0(oc, " ~ ", paste(c(blk$pred, "Mode"), collapse = " + ")))
        fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
          method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
          error = function(e) e)
        if (inherits(fit, "error")) next
        tt <- summary(fit)$tTable
        for (tm in blk$pred) {
          if (!tm %in% rownames(tt)) next
          if (grepl("^Mode", tm)) next
          met <- is.finite(tt[tm, "p-value"]) && tt[tm, "p-value"] < 0.05 && abs(tt[tm, "Value"]) > 0.1
          out[[length(out) + 1L]] <- h4_result(
            "Rodrigues 2026", blk$label, blk$formula, oc,
            estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
            statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
            n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
            statistic_test = "participant-intercept LMM (MixedLM)",
            note = sprintf("%s; source retention (p<.05 & |beta|>0.1) = %s. Blocks fitted separately: no thermal x sound term exists in the source.",
              tm, if (met) "MET" else "not met"),
            term = tm)
        }
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Kraus 2013 — additive mixed model with piecewise breakpoint at 65 dB(A).
#   ln(Y_it) = b0 + b1*Leq + b2*(Leq-65)+ + b3*activity + u_i + e_it
# Source has NO thermal variable; replicated as published (sound only).
# ===========================================================================
H4_KRAUS <- list(
  formula = "ln(Y_it) = b0 + b1*Leq_it + b2*(Leq_it - 65)+ + b3*activity_it + u_i + e_it",
  breakpoint_db = 65,
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells$Leq <- cells$dba
    cells$Leq_over65 <- pmax(0, cells$dba - H4_KRAUS$breakpoint_db)
    cells$ParticipantID <- factor(cells$ParticipantID)
    out <- list()
    for (oc in c("sdnn", "rmssd", "heart_rate")) {
      d <- cells[is.finite(cells[[oc]]) & cells[[oc]] > 0 & is.finite(cells$Leq), , drop = FALSE]
      if (nrow(d) < 8L) next
      resp <- if (oc == "heart_rate") oc else paste0("log(", oc, ")")
      fit <- tryCatch(nlme::lme(stats::as.formula(paste0(resp, " ~ Leq + Leq_over65")),
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
          note = "Source contains no thermal variable; replicated as published (sound only). Additive, no product term.",
          term = tm)
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# Ueberham 2019 — Spearman + ordinal proportional-odds regression of
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
    # Spearman on phase-level objective vs perceived exposure proxies
    pairs <- list(c("dba", "acoustic_comfort"), c("air_temp", "thermal_comfort"))
    for (pr in pairs) {
      x <- cells[[pr[1]]]; y <- cells[[pr[2]]]
      ok <- is.finite(x) & is.finite(y)
      if (sum(ok) < 6L) next
      ct <- suppressWarnings(stats::cor.test(x[ok], y[ok], method = "spearman"))
      out[[length(out) + 1L]] <- h4_result(
        "Ueberham 2019", paste0("Spearman ", pr[1], " vs ", pr[2], " [", scope, "]"),
        H4_UEBERHAM$formula_spearman,
        paste0(pr[1], " ~ ", pr[2]),
        estimate = unname(ct$estimate), statistic = unname(ct$statistic), p = ct$p.value,
        n_obs = sum(ok), n_participants = length(unique(cells$ParticipantID)),
        statistic_test = "Spearman rank correlation",
        note = sprintf("Source correlates objective route means with post-trip subjective ratings on 1-5 scales. Scope: %s.", scope),
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
            "Ueberham 2019", paste0("Ordinal regression: acoustic comfort ~ dBA class [", scope, "]"),
            H4_UEBERHAM$formula_ordinal, "acoustic_comfort",
            estimate = ct[1, "Value"], se = ct[1, "Std. Error"],
            statistic = ct[1, "t value"],
            p = 2 * stats::pt(abs(ct[1, "t value"]), df = nrow(d) - length(coef(fit)), lower.tail = FALSE),
            n_obs = nrow(d), n_participants = length(unique(d$ParticipantID)),
            statistic_test = "proportional-odds ordinal regression (polr)",
            note = sprintf("Source categorises both objective and subjective exposures into ordered groups before the ordinal model. Scope: %s.", scope),
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
# 4.0.2.4 Korpilo 2024 — two GLMMs (beta-logit for EDA, Gaussian for ROS),
#   with ALL two-way interactions tested and retained at p < 0.10.
#   Source formula: logit(E[EDA]) = b0 + b1*NDSI + b2*T + b3*RH + b4*(N_people)
#                   + all two-way interactions + (1|respondent)
#   The interaction that survives in the source is N_people x NDSI, NOT
#   temperature x NDSI. Both are fitted here so that is verifiable.
# ===========================================================================
H4_KORPILO <- list(
  formula_eda = paste("logit(E[EDA_ij]) = b0 + b1*NDSI_j + b2*T_j + b3*RH_j + b4*Crowd_j",
                      "+ two-way interactions, retained at p<0.10 + u_i"),
  formula_ros = paste("E[ROS_ij] = b0 + b1*NDSI_j + b2*T_j + b3*RH_j + b4*Crowd_j",
                      "+ two-way interactions, retained at p<0.10 + u_i"),
  retention_p = 0.10,
  # Green = BikeG + WalkG; Urban = BikeU + WalkU. Both modes included so the
  # environment contrast uses all four phases; Mode enters as a fixed control.
  phases = c("BikeG", "BikeU", "WalkG", "WalkU"),
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells <- cells[cells$PhaseID %in% H4_KORPILO$phases, , drop = FALSE]
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$Mode <- factor(ifelse(grepl("^Bike", cells$PhaseID), "Bike", "Walk"),
      levels = c("Walk", "Bike"))
    cells$eda_z <- H4_UTIL$z(cells$eda_tonic)
    cells$ros_z <- H4_UTIL$z(cells$prs_total)
    cells$temp_z <- H4_UTIL$z(cells$air_temp)
    cells$rh_z <- H4_UTIL$z(cells$air_rh)
    cells$ndsi_z <- H4_UTIL$z(cells$ndsi_octave)
    # Crowd analogue: the source used number of people present. Our field data
    # have no headcount, so the urban-manmade-negative share (anthropogenic
    # presence) is used as the closest available proxy.
    cells$crowd_z <- H4_UTIL$z(cells$urban_negative)
    pred <- c("ndsi_z", "temp_z", "rh_z", "crowd_z")
    out <- list()
    for (resp in list(list(col = "eda_z", label = "EDA level (Gaussian analogue)", f = H4_KORPILO$formula_eda),
                      list(col = "ros_z", label = "ROS / PRS-11 (Gaussian)", f = H4_KORPILO$formula_ros))) {
      ok <- is.finite(cells[[resp$col]]) &
        Reduce(`&`, lapply(pred, function(v) is.finite(cells[[v]])))
      d <- cells[ok, , drop = FALSE]
      if (nrow(d) < 8L) next
      fml <- stats::as.formula(paste0(resp$col, " ~ (", paste(pred, collapse = " + "), ")^2 + Mode"))
      fit <- tryCatch(nlme::lme(fml, random = ~ 1 | ParticipantID, data = d,
        method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
        error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      for (tm in rownames(tt)) {
        if (tm == "(Intercept)") next
        # Mode is a nuisance control only. The source paper has no mode term,
        # so it is never reported as a result.
        if (grepl("^Mode", tm)) next
        is_inter <- grepl(":", tm, fixed = TRUE)
        pv <- tt[tm, "p-value"]
        retained <- is.finite(pv) && pv < H4_KORPILO$retention_p
        out[[length(out) + 1L]] <- h4_result(
          "Korpilo 2024", resp$label, resp$f, resp$col,
          estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
          statistic = tt[tm, "t-value"], p = pv,
          n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
          statistic_test = "LMM with all two-way interactions (GLMM analogue)",
          note = sprintf("%s%s; source retention at p<0.10 = %s. Source retained N_people x NDSI, not temperature x NDSI.",
            tm, if (is_inter) " [interaction]" else " [main effect]",
            if (retained) "MET" else "not met"),
          term = tm)
      }
    }
    if (!length(out)) return(NULL)
    do.call(rbind, out)
  })

# ===========================================================================
# REMOVED: Jin 2020 — product term is sound type x sound level (no thermal factor).
# Season is stratified (ANOVA run per season), never crossed with sound, and this
# study has no seasonal campaign. Cannot supply an H4 formula. See 4.0.3.
# ===========================================================================

# ===========================================================================
# NOT A PAPER REPLICATION. This is the present study's own model, kept separate
# so it is never mistaken for a ported source test. No screened European paper
# specifies a UTCI x dBA term; this block exists only to report it explicitly.
# ===========================================================================
H4_CONTINUOUS <- list(
  formula = "Y_ij = b0 + b1*UTCI_z + b2*dBA_z + b3*(UTCI_z x dBA_z) + Mode + u_0i + e_ij",
  outcomes = c(
    # votes
    "thermal_comfort", "acoustic_comfort", "overall_comfort",
    # physiology the retained papers report
    "heart_rate", "eda_tonic", "skin_temp", "sdnn", "rmssd",
    # additional available outcomes
    "visual_comfort", "prs_total", "pleasantness"),
  run = function(epochs) {
    cells <- h4_phase_cells(epochs)
    cells$utci_z <- H4_UTIL$z(cells$utci)
    cells$dba_z <- H4_UTIL$z(cells$dba)
    cells$ParticipantID <- factor(cells$ParticipantID)
    cells$Mode <- factor(ifelse(grepl("^Bike", cells$PhaseID), "Bike", "Walk"),
      levels = c("Walk", "Bike"))
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
      fit <- tryCatch(nlme::lme(.y ~ utci_z * dba_z + Mode,
        random = ~ 1 | ParticipantID, data = d, method = "REML", na.action = na.fail,
        control = nlme::lmeControl(opt = "optim")), error = function(e) e)
      if (inherits(fit, "error")) next
      tt <- summary(fit)$tTable
      for (tm in rownames(tt)) {
        if (tm == "(Intercept)") next
        if (grepl("^Mode", tm)) next
        out[[length(out) + 1L]] <- h4_result(
          "H4 continuous (own model)", "UTCI x dBA interaction model", H4_CONTINUOUS$formula, oc,
          estimate = tt[tm, "Value"], se = tt[tm, "Std.Error"], df = tt[tm, "DF"],
          statistic = tt[tm, "t-value"], p = tt[tm, "p-value"],
          n_obs = nrow(d), n_participants = nlevels(d$ParticipantID),
          statistic_test = "LMM (participant intercept), Mode controlled",
          note = sprintf(paste("All four phases, Mode controlled, outcome scale = %s.",
            "Interaction identified only because BikeG/BikeU break the walk heat-noise collinearity."),
            scale_lab),
          term = tm)
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
  write = function(catalog, notes, root) {
    if (!nrow(catalog)) stop("No H4 results to write.")
    catalog$paper_rule <- "p < 0.05 (nominal; no catalogue FDR)"
    catalog$paper_rule_met <- is.finite(catalog$p) & catalog$p < 0.05
    staging <- tempfile("H4_")
    dir.create(staging)
    catalog <- h4_classify_relevance(catalog)
    write.csv(catalog, file.path(staging, "H4_sound_literature_tests.csv"), row.names = FALSE, na = "")
    # H4-relevant subset: the tests that can actually bear on the hypothesis.
    h4_only <- catalog[catalog$h4_relevance %in% c("core", "supporting"), ]
    h4_only <- h4_only[order(factor(h4_only$h4_relevance, c("core", "supporting")), h4_only$paper, h4_only$p), ]
    write.csv(h4_only, file.path(staging, "H4_tests_relevant_to_hypothesis.csv"), row.names = FALSE, na = "")
    summary <- do.call(rbind, lapply(split(catalog, catalog$paper), function(d)
      data.frame(paper = d$paper[1], n_tests = nrow(d),
        n_core = sum(d$h4_relevance == "core"),
        n_supporting = sum(d$h4_relevance == "supporting"),
        n_not_h4 = sum(d$h4_relevance == "not_h4"),
        n_p_lt_05 = sum(is.finite(d$p) & d$p < 0.05),
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
