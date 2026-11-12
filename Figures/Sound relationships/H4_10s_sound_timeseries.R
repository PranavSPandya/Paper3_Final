# Run with --natural-sound for the targeted bout-level questionnaire analysis.
run_natural_sound <- function(input, output_dir) {
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  outcomes <- c(pleasantness = "questionnaire_pleasantness_1_5",
    restoration = "questionnaire_prs11_total_mean_1_5")
  participants <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
  phases <- c("WalkG", "WalkU", "BikeG", "BikeU")
  epochs <- read.csv(input, check.names = FALSE)
  epochs <- epochs[epochs$PhaseID %in% phases & epochs$ParticipantID %in% participants, ]
  mean_finite <- function(x) mean(x[is.finite(x)])
  vote <- function(x) {
    observed <- unique(x[is.finite(x)])
    if (length(observed) > 1L) stop("Conflicting questionnaire votes within a bout.")
    if (length(observed)) observed else NA_real_
  }
  bouts <- do.call(rbind, lapply(split(epochs, list(epochs$ParticipantID, epochs$PhaseID), drop = TRUE), function(b) {
    data.frame(participant = b$ParticipantID[1], phase = b$PhaseID[1],
      natural = 10 * mean_finite(b$rural_natural_proportion),
      dba = 10 * log10(mean_finite(10^(b$ucm_SND_dBA / 10))),
      utci = mean_finite(b$ucm_UTCI), wind = mean_finite(b$ucm_WIND_AWS),
      pleasantness = vote(b[[outcomes["pleasantness"]]]),
      restoration = vote(b[[outcomes["restoration"]]]))
  }))
  stopifnot(nrow(bouts) == 44L, all(table(bouts$participant) == 4L))
  bouts$natural_between <- ave(bouts$natural, bouts$participant, FUN = mean_finite)
  bouts$natural_within <- bouts$natural - bouts$natural_between
  fit <- function(formula, data) nlme::lme(formula, random = ~1 | participant,
    data = data, method = "ML", na.action = na.fail, control = nlme::lmeControl(opt = "optim"))
  formulas <- list(phase_adjusted = y ~ phase + natural_within + natural_between,
    fully_adjusted = y ~ phase + dba + utci + wind + natural_within + natural_between)
  baseline <- y ~ phase + dba + utci + wind
  estimates <- list()
  folds <- list()
  for (outcome in names(outcomes)) {
    data <- bouts
    data$y <- data[[outcome]]
    data <- data[complete.cases(data[, all.vars(formulas$fully_adjusted)]), ]
    people <- unique(data$participant)
    for (spec in names(formulas)) {
      model <- fit(formulas[[spec]], data)
      row <- summary(model)$tTable["natural_within", ]
      margin <- qt(.975, row["DF"]) * row["Std.Error"]
      loo <- vapply(people, function(person) {
        training <- data[data$participant != person, ]
        nlme::fixef(fit(formulas[[spec]], training))[["natural_within"]]
      }, numeric(1))
      estimates[[length(estimates) + 1L]] <- data.frame(outcome, specification = spec,
        bouts = nrow(data), participants = length(people), estimate = unname(row["Value"]),
        ci_lower = unname(row["Value"] - margin), ci_upper = unname(row["Value"] + margin),
        p_nominal = unname(row["p-value"]), leave_one_out_min = min(loo), leave_one_out_max = max(loo))
    }
    for (person in people) {
      training <- data[data$participant != person, ]
      test <- data[data$participant == person, ]
      error <- function(formula) {
        prediction <- predict(fit(formula, training), test, level = 0)
        mean((test$y - prediction)^2)
      }
      folds[[length(folds) + 1L]] <- data.frame(outcome, participant = person,
        baseline_mse = error(baseline), natural_sound_mse = error(formulas$fully_adjusted))
    }
  }
  results <- do.call(rbind, estimates)
  errors <- do.call(rbind, folds)
  performance <- aggregate(cbind(baseline_mse, natural_sound_mse) ~ outcome, errors, mean)
  performance$baseline_rmse <- sqrt(performance$baseline_mse)
  performance$natural_sound_rmse <- sqrt(performance$natural_sound_mse)
  performance$rmse_change_percent <- 100 * (performance$natural_sound_rmse / performance$baseline_rmse - 1)
  write.csv(results, file.path(output_dir, "natural_sound_estimates.csv"), row.names = FALSE)
  write.csv(errors, file.path(output_dir, "natural_sound_held_out_participants.csv"), row.names = FALSE)
  write.csv(performance, file.path(output_dir, "natural_sound_prediction.csv"), row.names = FALSE)
  png(file.path(output_dir, "natural_sound_associations.png"), width = 1600, height = 850, res = 170)
  par(mar = c(5, 14, 3, 2))
  axis_labels <- paste(tools::toTitleCase(results$outcome),
    ifelse(results$specification == "phase_adjusted", "phase", "full adjustment"), sep = " | ")
  positions <- rev(seq_len(nrow(results)))
  plot(results$estimate, positions, xlim = range(0, results$ci_lower, results$ci_upper),
    yaxt = "n", ylab = "", xlab = "Rating points per 10 percentage points of natural-sound share",
    main = "Natural-sound share and bout ratings", pch = 19, col = "#176680")
  axis(2, at = positions, labels = axis_labels, las = 1, cex.axis = .85)
  abline(v = 0, lty = 2, col = "grey50")
  segments(results$ci_lower, positions, results$ci_upper, positions, col = "#176680", lwd = 2)
  invisible(dev.off())
  print(results, row.names = FALSE)
  print(performance, row.names = FALSE)
}

if ("--natural-sound" %in% commandArgs(trailingOnly = TRUE)) {
  entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1])
  sound_folder <- dirname(normalizePath(entry, mustWork = TRUE))
  project <- dirname(dirname(sound_folder))
  run_natural_sound(file.path(project, "output", "merged_all_11participants_8min.csv"),
    file.path(sound_folder, "output", "natural_sound"))
  quit(save = "no")
}

# 10 s tests on quantities that vary every 10 s (not questionnaire copies).
# A: sound/spectrum/YAMNet as outcomes, same AR(1) H1/H3 phase contrasts as physiology.
# B: physio ~ within-bout high vs low dBA (median split of 10 s level).
# C: physio ~ 10 s vehicle / rural / wind YAMNet share (z), phase held.
# D: 8 env metrics ~ dBA_z (BH of 8); optional same 8 env ~ vehicle_z (BH of 8).
# E: 26 physio ~ dBA_z, phase held (BH of 26). Unlike H5 10 s, E does not hold other env.
# BH: A = 8 outcomes per contrast x effect; B = 4 physio; C = 4 physio per source;
#     D = 8 env per predictor; E = 26 physio. Degenerate (SE>10): no p, not in BH.
# Not H4. Output: output/statistical_analysis/results/H4_10s_sound_timeseries/

source(file.path(
  dirname(normalizePath(sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE)[1]), mustWork = TRUE)),
  "library", "Paper3_common.R"), local = FALSE)
paper3_statistical_bootstrap(
  required_packages = "nlme",
  load_packages = "nlme")
PROJECT_ROOT <- resolve_project_root()
OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H4_10s_sound_timeseries")

study_wide_spec <- paper3_attach_outcome_normalization(list(
  participants = PAPER3_PARTICIPANTS,
  phases = PAPER3_CORE_PHASES,
  matched_cap_sec = PAPER3_MATCHED_CAP_SEC,
  physiological_outcome_names = paper3_physiological_outcomes()), PROJECT_ROOT)

Temporal_AR1_10s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"))
Temporal_AR1_60s_LMM <- quote(
  nlme::lme(
    Y_within_person_z ~ (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = sixty_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_60s_step | ParticipantID / PhaseID),
    method = "REML"))
Event_AR1_10s_LMM <- quote(
  nlme::lme(
    model_y ~ high_dBA + (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"))
Source_AR1_10s_LMM <- quote(
  nlme::lme(
    model_y ~ source_z + (PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG) * time_min,
    data = ten_second_epoch_table,
    random = ~ 1 | ParticipantID / PhaseID,
    correlation = nlme::corAR1(value = 0.2, form = ~ time_10s_step_integer | ParticipantID / PhaseID),
    method = "REML"))

source(file.path(LIBRARY_DIR, "H1_H3_core.R"), local = FALSE)

SOUND_OUTCOMES <- c(
  "ucm_SND_dBA",
  "spectral_centroid_Hz",
  "lowfreq_share_31_5_to_250",
  "vehicle_proportion",
  "rural_natural_proportion",
  "wind_proportion",
  "urban_manmade_negative_proportion",
  "mechanisms_proportion")
PHYSIO_EVENT <- c(
  "empatica_skin_temperature",
  "empatica_eda_tonic",
  "empatica_heart_rate",
  "eyetracker_pupil_diameter_avg")
SOURCE_PRED <- c(
  vehicle_proportion = "vehicle_z",
  rural_natural_proportion = "rural_z",
  wind_proportion = "wind_z")
ENV_OUTCOMES <- c(
  "ucm_UTCI",
  "ucm_AIR_T_mid",
  "ucm_MRT",
  "ucm_SUN_Gh",
  "SVF",
  "gvi_50m",
  "atmo_pm2.5_avg",
  "lys_lux_avg")
PHYSIO_ALL <- paper3_physiological_outcomes()

OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis", "results", "H4_10s_sound_timeseries")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

load_matched_route <- function() {
  route <- read.csv(paper3_merged_8min_path(PROJECT_ROOT), check.names = FALSE, stringsAsFactors = FALSE)
  route <- route[route$ParticipantID %in% study_wide_spec$participants & route$PhaseID %in% CORE_PHASES, ]
  route$Datetime <- as.POSIXct(route$Datetime, tz = "UTC")
  route$ParticipantID <- factor(route$ParticipantID, levels = study_wide_spec$participants)
  route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
  route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]
  route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID, FUN = function(x) x - min(x, na.rm = TRUE))
  route$time_min <- route$time_in_phase_sec / 60
  route <- paper3_merge_common_cap(route, CORE_PHASES, study_wide_spec$matched_cap_sec)
  route <- route[!is.na(route$Common_cap) & route$time_in_phase_sec <= route$Common_cap, ]
  route <- paper3_add_pair_means(route, list(
    atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")))
  oct <- c("octave_proportion_31_5_Hz", "octave_proportion_63_0_Hz",
           "octave_proportion_125_0_Hz", "octave_proportion_250_0_Hz")
  route$lowfreq_share_31_5_to_250 <- rowSums(route[oct])
  route
}

extract_term <- function(fit, outcome, term, status, family) {
  if (is.null(fit) || status == "NOT_FIT_NO_CONVERGENCE") {
    return(data.frame(family = family, outcome = outcome, term = term, estimate = NA_real_,
                      se = NA_real_, df = NA_real_, t_ratio = NA_real_, p_value = NA_real_,
                      status = status, stringsAsFactors = FALSE))
  }
  tt <- summary(fit)$tTable
  if (!term %in% rownames(tt)) {
    return(data.frame(family = family, outcome = outcome, term = term, estimate = NA_real_,
                      se = NA_real_, df = NA_real_, t_ratio = NA_real_, p_value = NA_real_,
                      status = "TERM_MISSING", stringsAsFactors = FALSE))
  }
  p <- if (status == "DEGENERATE_FIT") NA_real_ else tt[term, "p-value"]
  data.frame(family = family, outcome = outcome, term = term,
             estimate = tt[term, "Value"], se = tt[term, "Std.Error"],
             df = tt[term, "DF"], t_ratio = tt[term, "t-value"], p_value = p,
             status = status, stringsAsFactors = FALSE)
}

fit_one <- function(epoch_data, model_call) {
  fit_ar1_with_fallback(epoch_data, model_call)
}

cat("Loading matched 10 s rows...\n")
route <- load_matched_route()

# ---- A: sound as 10 s outcomes, H1/H3 contrasts ----
SENSOR_OUTCOMES <- SOUND_OUTCOMES
for (outcome in SOUND_OUTCOMES) {
  route[[outcome]] <- as.numeric(route[[outcome]])
  route[[paste0("within_person_z__", outcome)]] <- paper3_within_person_z(route[[outcome]], route$ParticipantID)
}
cat("A: sound outcomes AR(1)...\n")
sound_temporal <- h1_h3_fit_temporal_ar1(route)
planned_a <- sound_temporal$planned
planned_a$block <- "A_sound_as_outcome"
planned_a$comparison <- paste(planned_a$Comparison_PhaseID, planned_a$Reference_PhaseID, sep = " - ")

# ---- B and C: physio ~ 10 s sound, phase held ----
phys <- load_matched_route()
for (outcome in PHYSIO_EVENT) {
  phys[[outcome]] <- paper3_apply_csv_transform(phys[[outcome]], outcome, study_wide_spec$outcome_transforms_csv)
  phys[[paste0("within_person_z__", outcome)]] <- paper3_within_person_z(phys[[outcome]], phys$ParticipantID)
}
phys$high_dBA <- ave(as.numeric(phys$ucm_SND_dBA), phys$ParticipantPhaseID, FUN = function(x) {
  m <- median(x, na.rm = TRUE)
  as.numeric(x > m)
})
phys$vehicle_z <- as.numeric(scale(as.numeric(phys$vehicle_proportion)))
phys$rural_z <- as.numeric(scale(as.numeric(phys$rural_natural_proportion)))
phys$wind_z <- as.numeric(scale(as.numeric(phys$wind_proportion)))
phys$time_10s_step <- round(phys$time_in_phase_sec / 10)

fit_physio_term <- function(predictor_col, term_name, family) {
  rows <- list()
  for (outcome in PHYSIO_EVENT) {
    z_column <- paste0("within_person_z__", outcome)
    epoch_data <- phys[complete.cases(phys[, c("ParticipantID", "PhaseID", "time_min", "time_10s_step", z_column, predictor_col)]), ]
    epoch_data$model_y <- epoch_data[[z_column]]
    epoch_data$time_min <- epoch_data$time_min - mean(epoch_data$time_min)
    epoch_data <- attach_phase_sum_columns(epoch_data)
    epoch_data[[term_name]] <- epoch_data[[predictor_col]]
    epoch_data <- epoch_data[order(epoch_data$ParticipantID, epoch_data$PhaseID, epoch_data$time_10s_step), ]
    if (!model_data_ok(epoch_data, 100, 8)) {
      rows[[length(rows) + 1L]] <- extract_term(NULL, outcome, term_name, "NOT_FIT_NO_CONVERGENCE", family)
      next
    }
    call <- if (term_name == "high_dBA") Event_AR1_10s_LMM else Source_AR1_10s_LMM
    if (term_name != "high_dBA") epoch_data$source_z <- epoch_data[[predictor_col]]
    fitted <- fit_one(epoch_data, call)
    tt <- if (!is.null(fitted$fit)) summary(fitted$fit)$tTable
    status <- if (is.null(tt)) "NOT_FIT_NO_CONVERGENCE" else if (h1_h3_degenerate_fit(tt)) "DEGENERATE_FIT" else "FIT"
    rows[[length(rows) + 1L]] <- extract_term(fitted$fit, outcome, term_name, status, family)
  }
  tab <- do.call(rbind, rows)
  tab$q_value <- p.adjust(tab$p_value, method = "BH")
  tab
}

cat("B: high vs low dBA within bout...\n")
block_b <- fit_physio_term("high_dBA", "high_dBA", "B_high_vs_low_dBA")
cat("C: YAMNet shares...\n")
block_c <- rbind(
  fit_physio_term("vehicle_z", "source_z", "C_vehicle_share"),
  fit_physio_term("rural_z", "source_z", "C_rural_share"),
  fit_physio_term("wind_z", "source_z", "C_wind_share"))
block_c$term <- block_c$family

# Shared 10 s table for D/E: sample-wide dBA_z / vehicle_z; outcomes are within-person z.
# Family E holds phase (sum coding * time_min) but not other environment; H5 10 s already
# holds dBA + UTCI + SVF + solar + PM + light + GVI + phase (dBA: 0 BH there).
phys$dBA_z <- as.numeric(scale(as.numeric(phys$ucm_SND_dBA)))
if (!"vehicle_z" %in% names(phys)) {
  phys$vehicle_z <- as.numeric(scale(as.numeric(phys$vehicle_proportion)))
}
missing_env <- setdiff(ENV_OUTCOMES, names(phys))
if (length(missing_env)) stop("Family D env columns missing: ", paste(missing_env, collapse = ", "))
for (outcome in ENV_OUTCOMES) {
  phys[[outcome]] <- as.numeric(phys[[outcome]])
  phys[[paste0("within_person_z__", outcome)]] <- paper3_within_person_z(phys[[outcome]], phys$ParticipantID)
}
for (outcome in PHYSIO_ALL) {
  if (!outcome %in% PHYSIO_EVENT) {
    phys[[outcome]] <- paper3_apply_csv_transform(phys[[outcome]], outcome, study_wide_spec$outcome_transforms_csv)
    phys[[paste0("within_person_z__", outcome)]] <- paper3_within_person_z(phys[[outcome]], phys$ParticipantID)
  }
}

fit_predictor_family <- function(dat, outcomes, predictor_col, family) {
  rows <- list()
  for (outcome in outcomes) {
    cat("  ", family, outcome, "\n", sep = "")
    z_column <- paste0("within_person_z__", outcome)
    epoch_data <- dat[complete.cases(dat[, c("ParticipantID", "PhaseID", "time_min", "time_10s_step", z_column, predictor_col)]), ]
    epoch_data$model_y <- epoch_data[[z_column]]
    epoch_data$time_min <- epoch_data$time_min - mean(epoch_data$time_min)
    epoch_data <- attach_phase_sum_columns(epoch_data)
    epoch_data$source_z <- epoch_data[[predictor_col]]
    epoch_data <- epoch_data[order(epoch_data$ParticipantID, epoch_data$PhaseID, epoch_data$time_10s_step), ]
    if (!model_data_ok(epoch_data, 100, 8)) {
      rows[[length(rows) + 1L]] <- extract_term(NULL, outcome, predictor_col, "NOT_FIT_NO_CONVERGENCE", family)
      next
    }
    fitted <- fit_one(epoch_data, Source_AR1_10s_LMM)
    tt <- if (!is.null(fitted$fit)) summary(fitted$fit)$tTable
    status <- if (is.null(tt)) "NOT_FIT_NO_CONVERGENCE" else if (h1_h3_degenerate_fit(tt)) "DEGENERATE_FIT" else "FIT"
    row <- extract_term(fitted$fit, outcome, "source_z", status, family)
    row$term <- predictor_col
    rows[[length(rows) + 1L]] <- row
  }
  tab <- do.call(rbind, rows)
  ok <- is.finite(tab$p_value)
  tab$q_value <- NA_real_
  if (any(ok)) tab$q_value[ok] <- p.adjust(tab$p_value[ok], method = "BH")
  tab$family_size_tested <- sum(ok)
  tab
}

cat("D: env ~ dBA_z...\n")
block_d <- fit_predictor_family(phys, ENV_OUTCOMES, "dBA_z", "D_env_on_dBA")
cat("D2: env ~ vehicle_z (optional family)...\n")
block_d2 <- fit_predictor_family(phys, ENV_OUTCOMES, "vehicle_z", "D_env_on_vehicle")
cat("E: 26 physio ~ dBA_z (phase held; other env not held)...\n")
block_e <- fit_predictor_family(phys, PHYSIO_ALL, "dBA_z", "E_physio_on_dBA")

write.csv(planned_a, file.path(OUT_DIR, "A_sound_phase_contrasts_10s.csv"), row.names = FALSE)
write.csv(sound_temporal$temporal, file.path(OUT_DIR, "A_sound_AR1_terms_10s.csv"), row.names = FALSE)
write.csv(block_b, file.path(OUT_DIR, "B_physio_high_low_dBA_10s.csv"), row.names = FALSE)
write.csv(block_c, file.path(OUT_DIR, "C_physio_yamnet_share_10s.csv"), row.names = FALSE)
write.csv(block_d, file.path(OUT_DIR, "D_env_on_dBA_10s.csv"), row.names = FALSE)
write.csv(block_d2, file.path(OUT_DIR, "D_env_on_vehicle_z_10s.csv"), row.names = FALSE)
write.csv(block_e, file.path(OUT_DIR, "E_physio_on_dBA_10s.csv"), row.names = FALSE)

hits_a <- planned_a[planned_a$Effect == "phase_level" & !is.na(planned_a$q_FDR) & planned_a$q_FDR < 0.05, ]
hits_b <- block_b[!is.na(block_b$q_value) & block_b$q_value < 0.05, ]
hits_c <- block_c[!is.na(block_c$q_value) & block_c$q_value < 0.05, ]
hits_d <- block_d[!is.na(block_d$q_value) & block_d$q_value < 0.05, ]
hits_d2 <- block_d2[!is.na(block_d2$q_value) & block_d2$q_value < 0.05, ]
hits_e <- block_e[!is.na(block_e$q_value) & block_e$q_value < 0.05, ]

claim_q <- function(outcome, comparison) {
  row <- planned_a[planned_a$Outcome == outcome & planned_a$comparison == comparison &
                     planned_a$Effect == "phase_level", ]
  if (!nrow(row)) return(list(ok = FALSE, q = NA_real_, beta = NA_real_, status = "MISSING"))
  q <- row$q_FDR[1]
  list(ok = !is.na(q) && q < 0.05, q = q, beta = row$Beta[1], status = row$Status[1])
}
fmt_claim <- function(label, hits) {
  paste(sprintf("  %s: %s  beta=%s  q=%s", label,
                if (hits$ok) "YES BH" else "NO",
                format(hits$beta, digits = 4),
                format(hits$q, digits = 4, scientific = TRUE)), collapse = "")
}
c_quiet_bike <- claim_q("ucm_SND_dBA", "BikeG - BikeU")
c_quiet_walk <- claim_q("ucm_SND_dBA", "WalkG - WalkU")
c_rural_bike <- claim_q("rural_natural_proportion", "BikeG - BikeU")
c_rural_walk <- claim_q("rural_natural_proportion", "WalkG - WalkU")
c_wind_bike <- claim_q("wind_proportion", "BikeG - BikeU")
c_urbneg_bike <- claim_q("urban_manmade_negative_proportion", "BikeG - BikeU")
c_cent_walk <- claim_q("spectral_centroid_Hz", "WalkG - WalkU")
c_low_walk <- claim_q("lowfreq_share_31_5_to_250", "WalkG - WalkU")
c_veh_bike <- claim_q("vehicle_proportion", "BikeG - BikeU")
c_veh_walk <- claim_q("vehicle_proportion", "WalkG - WalkU")
# Vehicle-on-walk is the claimed null: survives only if NOT BH-significant.
c_veh_walk_null <- list(ok = !is.na(c_veh_walk$q) && c_veh_walk$q >= 0.05,
                        q = c_veh_walk$q, beta = c_veh_walk$beta)

summary_txt <- c(
  "10 s sound tests (not H4; not questionnaire).",
  sprintf("A phase-level BH q<0.05: %d of %d", nrow(hits_a), sum(planned_a$Effect == "phase_level" & planned_a$Status == "FIT")),
  sprintf("B high-dBA BH q<0.05: %d of 4", nrow(hits_b)),
  sprintf("C YAMNet-share BH q<0.05: %d of 12", nrow(hits_c)),
  sprintf("D env ~ dBA_z BH q<0.05: %d of %d tested (planned 8)", nrow(hits_d), unique(block_d$family_size_tested)),
  sprintf("D2 env ~ vehicle_z BH q<0.05: %d of %d tested (planned 8)", nrow(hits_d2), unique(block_d2$family_size_tested)),
  sprintf("E physio ~ dBA_z BH q<0.05: %d of %d tested (planned 26; phase held, other env not held; H5 10 s already holds env and found 0 BH for dBA)", nrow(hits_e), unique(block_e$family_size_tested)),
  "",
  "Quoted A phase-level claims vs q_FDR<0.05 (Comparison minus Reference):",
  fmt_claim("quieter on BikeG vs BikeU (ucm_SND_dBA)", c_quiet_bike),
  fmt_claim("quieter on WalkG vs WalkU (ucm_SND_dBA)", c_quiet_walk),
  fmt_claim("more rural/natural on BikeG vs BikeU", c_rural_bike),
  fmt_claim("more rural/natural on WalkG vs WalkU", c_rural_walk),
  fmt_claim("less wind on BikeG vs BikeU", c_wind_bike),
  fmt_claim("less urban-negative on BikeG vs BikeU", c_urbneg_bike),
  fmt_claim("WalkG higher centroid than WalkU", c_cent_walk),
  fmt_claim("WalkG less low-frequency than WalkU", c_low_walk),
  fmt_claim("vehicle share drops BikeG vs BikeU", c_veh_bike),
  sprintf("  vehicle share does NOT drop WalkG vs WalkU (claimed null): %s  beta=%s  q=%s",
          if (c_veh_walk_null$ok) "YES (q>=0.05)" else "NO (q<0.05)",
          format(c_veh_walk$beta, digits = 4),
          format(c_veh_walk$q, digits = 4, scientific = TRUE))
)
writeLines(summary_txt, file.path(OUT_DIR, "SUMMARY.txt"))
cat(paste(summary_txt, collapse = "\n"), "\n")
if (nrow(hits_a)) {
  cat("A hits:\n")
  print(hits_a[, c("Hypothesis", "Contrast", "Outcome", "Beta", "p_value", "q_FDR")])
}
if (nrow(hits_b)) {
  cat("B hits:\n")
  print(hits_b)
}
if (nrow(hits_c)) {
  cat("C hits:\n")
  print(hits_c)
}
if (nrow(hits_d)) {
  cat("D hits:\n")
  print(hits_d)
}
if (nrow(hits_d2)) {
  cat("D2 hits:\n")
  print(hits_d2)
}
if (nrow(hits_e)) {
  cat("E hits:\n")
  print(hits_e)
}
cat("wrote", OUT_DIR, "\n")

