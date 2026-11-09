# H4: literature-aligned partial ports per documents/H4_papers_screened_final.md (§0.6 screen; §3 items 6/8–10; item 9 tests) for 24 source blocks.
# Paper 3 H4 hypothesis: §0.3 primary interactions -> H4_primary_estimands_results.csv; full catalogue -> H4_sound_literature_tests.csv.
# Walk-only papers use WalkG/WalkU; Biel and Kraus use all four core phases; Ueberham uses BikeG/BikeU only.

options(stringsAsFactors = FALSE)
.entry <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
if (!length(.entry) || !file.exists(.entry[1])) stop('Run this file with Rscript')
.entry <- normalizePath(.entry[1], winslash = '/', mustWork = TRUE)
library_dir <- file.path(dirname(.entry), 'library')
code_paths <- c(.entry, file.path(library_dir, c('Paper3_common.R', 'H4_sound_literature_helpers.R')))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
# Outcome-window HRV and native RRI are identical across sound substitutions: cache them once within this run.
original_read_rri <- H4_MOSHAMMER$read_rri
cached_rri <- NULL
H4_MOSHAMMER$read_rri <- function() {
  if (is.null(cached_rri)) cached_rri <<- original_read_rri()
  cached_rri
}
original_window_hrv <- H4_MOSHAMMER$lf_hf
window_hrv_cache <- new.env(parent = emptyenv())
H4_MOSHAMMER$lf_hf <- function(peak_time, rri_ms, start, end) {
  key <- paste(as.numeric(start), as.numeric(end), length(rri_ms), sum(rri_ms, na.rm = TRUE),
    paste(head(rri_ms, 5L), collapse = ','), paste(tail(rri_ms, 5L), collapse = ','))
  if (!exists(key, envir = window_hrv_cache, inherits = FALSE))
    assign(key, original_window_hrv(peak_time, rri_ms, start, end), envir = window_hrv_cache)
  get(key, envir = window_hrv_cache, inherits = FALSE)
}
for (package in c('nlme', 'mgcv')) if (!requireNamespace(package, quietly = TRUE)) stop('Required package missing: ', package)
suppressPackageStartupMessages({ library(nlme); library(mgcv) })
lme_control <- nlme::lmeControl(opt = 'optim')
started <- Sys.time()
step_log <- function(label) cat(sprintf('[%6.1f s] %s\n', as.numeric(difftime(Sys.time(), started, units = 'secs')), label))

root <- resolve_project_root()
analysis_phases <- PAPER3_CORE_PHASES
H4_PHASE_BIKE <- c('BikeG', 'BikeU')
outdir <- file.path(root, 'output', 'statistical_analysis', 'results', 'H4_sound_literature_test')
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- read.csv(input, check.names = FALSE)
epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% analysis_phases, ]
epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = 'UTC')
stopifnot(!anyNA(epochs$Datetime), !anyDuplicated(epochs[c('ParticipantID', 'PhaseID', 'Datetime')]))
epochs <- epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
stopifnot(setequal(unique(epochs$ParticipantID), PAPER3_PARTICIPANTS))
stopifnot(length(H4_UTIL$bouts(epochs)) == length(PAPER3_PARTICIPANTS) * length(analysis_phases))

# Frequency-domain HRV only where the dataset's 5-min window passed QC; window bounds are needed by Kraus.
outcomes <- paper3_physiological_outcomes()
hrv_available <- tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true', '1')
for (column_name in attr(outcomes, 'empatica_hrv_fd_window')) epochs[[column_name]][!hrv_available] <- NA_real_
epochs$hrv_window_available <- hrv_available
epochs$hrv_seg_start <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_start)
epochs$hrv_seg_end <- H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_end)
epochs <- H4_SOUND$attach_encodings(epochs)
epochs_walk <- epochs[epochs$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]
epochs_bike <- epochs[epochs$PhaseID %in% H4_PHASE_BIKE, , drop = FALSE]

ratings <- c(thermal_comfort = 'questionnaire_thermal_comfort_1_5',
  acoustic_comfort = 'questionnaire_acoustic_comfort_1_5',
  visual_comfort = 'questionnaire_visual_comfort_1_5',
  overall_comfort = 'questionnaire_current_comfort_1_7')
cells_all <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
  cell <- data.frame(ParticipantID = epochs$ParticipantID[rows[1]], PhaseID = epochs$PhaseID[rows[1]],
    utci = H4_UTIL$finite_mean(epochs$ucm_UTCI[rows]),
    dba = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]))
  for (outcome in names(ratings)) {
    values <- unique(epochs[[ratings[[outcome]]]][rows])
    values <- values[is.finite(values)]
    if (length(values) > 1L) stop('More than one phase rating: ', outcome, ', ', cell$ParticipantID, ', ', cell$PhaseID)
    cell[[outcome]] <- if (length(values)) values[1] else NA_real_
  }
  cell
}))
cells_walk <- cells_all[cells_all$PhaseID %in% H4_PHASE_WALK, , drop = FALSE]
# Richer phase cells (RH, air temperature, wind, physiology, YAMNet shares, PRS) for the outdoor blocks.
outdoor_walk <- h4_outdoor_phase_cells(epochs_walk)
outdoor_bike <- h4_outdoor_phase_cells(epochs_bike)

source_papers <- c(
  Rodrigues = 'H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf',
  Jin = 'H4 Sound literature test/Included - Sound - Combined effects of the thermal-acoustic environment on subjective evaluations in urban squares.pdf',
  Cureau = 'Sound_evidence/Sound - Multi-domain human-oriented approach to evaluate human comfort in outdoor environments.pdf',
  Wu = 'Sound_evidence/Sound - Wu2025 - thermal acoustic overall comfort cold-region parks.pdf',
  Xu = 'Sound_evidence/Sound - Xu2026 - threshold thermal-acoustic urban public spaces.pdf')
# Other §3 source PDFs: fingerprinted when present; absence is reported, not fatal.
optional_papers <- c(
  Moshammer = 'H4 Sound literature test/Included - Sound - Moshammer et al 2019 IJERPH acute air pollution noise road traffic panel HRV.pdf',
  Biel = 'H1 to H4/H4 - Biel et al 2020 - Acute cardiovascular effects of air pollutants and noise.pdf',
  Kraus = 'Sound_evidence/Sound - Individual daytime noise exposure during routine activities and heart rate variability in adults - a repeated measures study.pdf',
  Chiucchiu = 'Anna Laura/Sound - The role of personality in multi-domain environmental perception An occupant-centric approach.pdf',
  Chen = 'Sound_evidence/Chen2023_Sensory_walking_thermal_acoustic.pdf',
  Ueberham = 'Sound_evidence/Ueberham2019_Cyclists_multiple_environmental_exposures.pdf',
  Li = 'Sound_evidence/Sound - Li2025 - autumn greenway noise thermal walking.pdf',
  Qin = 'Sound_evidence/Sound - Qin2024 - sound humidity outdoor thermal comfort cold regions.pdf',
  Mohammadzadeh = 'Sound_evidence/Sound - Mohammadzadeh2023 - thermal on acoustic comfort urban parks.pdf',
  Gao = 'Sound_evidence/Sound - GaoZhu2025 - thermal-acoustic psychological restoration greenways.pdf',
  Zhen = 'Sound_evidence/Sound - Zhen2025 - plaza OTC thermoacoustic Datang.pdf',
  ZhangSciRep = 'Sound_evidence/Sound - ZhangUchiyamaSato2026 - thermal acoustic aesthetic parks.pdf',
  ZhangBSim = 'Sound_evidence/Sound - Zhang2026 - historic spaces thermoacoustic Building Simulation.pdf',
  Tang = 'Sound_evidence/Sound - Tang2026 - soundscape diversity thermo physiological sex dimorphic.pdf',
  Peng = 'Sound_evidence/Sound - Peng2026 - Multisensory greenway plazas openness.pdf',
  Simsek = 'Sound_evidence/Sound - Simsek2026 - auditory comfort thermal visual urban parks.pdf')
pigliautile_pdf <- list.files(file.path(root, 'Experiment papers', 'Sound_evidence'),
  pattern = '^Sound - Environmental thermal influence over soundscape perception.*\\.pdf$')
if (length(pigliautile_pdf)) optional_papers <- c(Pigliautile = file.path('Sound_evidence', pigliautile_pdf[1]), optional_papers)
source_paths <- file.path(root, 'Experiment papers', source_papers)
if (!all(file.exists(source_paths))) stop('Verified source PDF missing: ', paste(source_papers[!file.exists(source_paths)], collapse = '; '))
optional_present <- file.exists(file.path(root, 'Experiment papers', optional_papers))
missing_optional <- optional_papers[!optional_present]
source_papers <- c(source_papers, optional_papers[optional_present])
source_paths <- file.path(root, 'Experiment papers', source_papers)
source_fingerprints <- tools::md5sum(source_paths)
results <- list()
fit_notes <- character()

result_row <- function(paper, test, outcome, predictor, data, estimate = NA_real_, se = NA_real_,
                       ci = c(NA_real_, NA_real_), statistic = NA_real_, df = NA, p = NA_real_,
                       statistic_test, model, note, sound_variable = 'ucm_SND_dBA',
                       source_column = unname(ratings[outcome]), transformation = 'raw questionnaire score') {
  data.frame(paper = paper, test = test, outcome = outcome,
    source_column = source_column, term = predictor,
    estimate = estimate, se = se, ci_low = ci[1], ci_high = ci[2], statistic = statistic, df = df, p = p,
    n_observations = nrow(data), n_participants = length(unique(data$ParticipantID)),
    statistic_test = statistic_test, paper_rule = 'p < 0.05',
    paper_rule_met = if (is.finite(p)) p < 0.05 else NA,
    transformation = transformation, term_units = 'see model_details',
    model_id = model, model_details = note, sound_variable = sound_variable)
}
with_sound <- function(block, value) {
  if (!'sound_variable' %in% names(block)) block$sound_variable <- value
  block
}
bind_rows <- function(rows) if (length(rows)) do.call(rbind, rows) else NULL
scopus_block <- function(paper) {
  out <- h4_scopus_outdoor_tests(epochs_walk, papers = paper)
  fit_notes <<- c(fit_notes, setdiff(out$notes, c('', '## Outdoor replications (this run)')))
  out$results
}
tag_alt <- function(block, label, suffix) { block$sound_variable <- label; block$test <- paste0(block$test, suffix); block }
alt_sounds <- c(H4_SOUND$four_ways(names(epochs)),
  H4_SOUND$alternatives(names(epochs))[intersect(H4_SOUND$spectral, names(epochs))])

# =============================================================================
# 3.1 Pigliautile 2021 — WalkG/WalkU; (a) warmer-cooler votes, (b) traffic-nature, (c) stratum Spearman.
# =============================================================================
step_log('3.1 Pigliautile 2021')
pig <- H4_PIGLIAUTILE$run(epochs_walk)
pig_cells <- pig$cells
pig_rows <- list()
for (name in c('thermal_comfort', 'visual_comfort', 'acoustic_comfort', 'air_quality_comfort')) {
  pair <- H4_AL$person_pair(pig_cells, name, by = 'thermal', a = 'cooler', b = 'warmer')
  pig_rows[[length(pig_rows) + 1L]] <- H4_AL$attach_sound(H4_AL$paired_t_row(pair, 'Pigliautile 2021',
    'paired C0 vs C1 analogue, comfort votes', name, H4_AL$votes[[name]],
    'warmer minus cooler', 'vote points (warmer minus cooler person mean)',
    paste(name, 'warmer - cooler | paired t by ParticipantID'),
    'Fig 3a analogue; WalkG/WalkU only; cooler/warmer = each person\'s own walk phases split at their mean air temperature'),
    'warmer vs cooler (no sound-source label)')
}
results$pigliautile <- rbind(bind_rows(pig_rows),
  pig$results[pig$results$test != 'paired C0 vs C1 analogue, comfort votes', , drop = FALSE])

# =============================================================================
# 3.2 Cureau 2022 — Fisher exact per WalkG and WalkU.
# =============================================================================
step_log('3.2 Cureau 2022')
results$cureau <- h4_additional_outdoor_tests(epochs_walk, papers = 'Cureau', include_scopus = FALSE)$results

# =============================================================================
# 3.3 Chiucchiù 2026 — WalkG/WalkU; paired physiology, Spearman domains, Table 5 analogue, vote-sound Spearman.
# =============================================================================
step_log('3.3 Chiucchiu 2026')
results$chiucchiu <- H4_CHIUCCHIU$run(epochs_walk)$results

# =============================================================================
# 3.4 Moshammer 2019 — WalkG/WalkU; 5-min exposure / 5-8 min outcome xtreg-re GLS (dBA + encodings 2-4 + 15 spectral).
# =============================================================================
step_log('3.4 Moshammer 2019')
mosh_primary <- H4_MOSHAMMER$run(epochs_walk)$results
mosh_primary <- mosh_primary[grepl('walking phases', mosh_primary$test, fixed = TRUE), , drop = FALSE]
mosh_rows <- list(with_sound(mosh_primary, 'ucm_SND_dBA'))
for (sound in alt_sounds) {
  alt_mosh <- H4_MOSHAMMER$run(epochs_walk, sound)$results
  alt_mosh <- alt_mosh[grepl('walking phases', alt_mosh$test, fixed = TRUE), , drop = FALSE]
  mosh_rows[[length(mosh_rows) + 1L]] <- tag_alt(alt_mosh, sound$column, paste0(' [', sound$column, ']'))
}
results$moshammer <- bind_rows(mosh_rows)

# =============================================================================
# 3.5 Jin 2020 — Type-II ANOVA on walk cells (source 5-dB bands x UTCI stress categories + encodings 2-4 + 15 spectral).
# =============================================================================
step_log('3.5 Jin 2020')
jin <- cells_walk
finite_sound <- jin$dba[is.finite(jin$dba)]
if (!length(finite_sound)) stop('Jin: no finite sound measurements')
sound_breaks <- seq(min(55, 5 * floor(min(finite_sound) / 5)),
  max(75, 5 * (floor(max(finite_sound) / 5) + 1)), by = 5)
jin$sound_level <- cut(jin$dba, sound_breaks, right = FALSE, include.lowest = TRUE)
jin$thermal_level <- cut(jin$utci, c(-Inf, -40, -27, -13, 0, 9, 26, 32, 38, 46, Inf), right = FALSE)
jin_rows <- list()
for (outcome in c('thermal_comfort', 'acoustic_comfort', 'overall_comfort')) {
  data <- droplevels(jin[complete.cases(jin[c(outcome, 'sound_level', 'thermal_level')]), ])
  data$ParticipantID <- factor(data$ParticipantID)
  if (nrow(data) < 2L || nlevels(data$sound_level) < 2L || nlevels(data$thermal_level) < 2L) {
    fit_notes <- c(fit_notes, paste('Jin 2020:', outcome, 'fewer than two observed levels in a required factor; not estimable.'))
    next
  }
  anova_table <- H4_JIN$anova_type2(data[[outcome]], data$sound_level, data$thermal_level, data$ParticipantID)
  if (is.null(anova_table)) next
  observed <- table(data$sound_level, data$thermal_level)
  nominal_df <- (nlevels(data$sound_level) - 1L) * (nlevels(data$thermal_level) - 1L)
  support <- sprintf('%d walk phase cells; %d of %d band x category cells empty; interaction rank df %s of nominal %d.',
    nrow(data), sum(observed == 0), length(observed), anova_table$df_term[3], nominal_df)
  for (index in seq_len(nrow(anova_table))) {
    estimable <- is.finite(anova_table$p[index])
    if (!estimable) fit_notes <- c(fit_notes, paste('Jin 2020:', outcome, anova_table$effect[index],
      'not identifiable (rank df', anova_table$df_term[index], ', residual df', anova_table$df_resid[index], '); not fitted.', support))
    jin_rows[[length(jin_rows) + 1L]] <- result_row('Jin 2020',
      'Two-way ANOVA: source-spaced sound bands x UTCI stress categories', outcome, anova_table$effect[index], data,
      statistic = anova_table$F[index], df = paste(anova_table$df_term[index], anova_table$df_resid[index], sep = ', '),
      p = anova_table$p[index],
      statistic_test = if (index < 3) 'f-test (Type-II main effect, participant block, full-model error)' else 'f-test (estimable interaction vs additive model, participant block, full-model error)',
      model = paste(outcome, '~ ParticipantID + sound_level * thermal_level'),
      note = paste('WalkG/WalkU only. Source 5-dB spacing; participant blocking is adaptation.', support))
  }
}
for (sound in alt_sounds)
  jin_rows[[length(jin_rows) + 1L]] <- tag_alt(H4_JIN$run(epochs_walk, sound)$results, sound$column, paste0(' [', sound$column, ']'))
results$jin <- bind_rows(jin_rows)
fit_notes <- c(fit_notes, 'Jin observed sound x UTCI category counts (walk only):',
  capture.output(print(table(droplevels(jin$sound_level), droplevels(jin$thermal_level)))))

# =============================================================================
# 3.6 Biel 2020 — all four phases; phase LMM (per IQR, RH by 10% rule) and repeated 2-min CAR(1) (dBA + encodings 2-4 + 15 spectral).
# =============================================================================
step_log('3.6 Biel 2020')
biel_rows <- list(
  with_sound(H4_BIEL$run(epochs, lme_control)$results, 'ucm_SND_dBA'),
  with_sound(H4_BIEL_REPEATED$run(epochs, lme_control)$results, 'ucm_SND_dBA'))
for (sound in alt_sounds) {
  suffix <- paste0(' [', sound$column, ']')
  biel_rows[[length(biel_rows) + 1L]] <- tag_alt(H4_BIEL$run(epochs, lme_control, sound)$results, sound$column, suffix)
  biel_rows[[length(biel_rows) + 1L]] <- tag_alt(H4_BIEL_REPEATED$run(epochs, lme_control, sound)$results, sound$column, suffix)
}
results$biel <- bind_rows(biel_rows)

# =============================================================================
# 3.7 Rodrigues 2026 — WalkG/WalkU trip LMM, separate noise and temperature blocks (dBA + encodings 2-4 + 15 spectral).
# =============================================================================
step_log('3.7 Rodrigues 2026')
rodrigues_block <- H4_RODRIGUES$run(epochs, lme_control)
rodrigues_block$results$sound_variable <- 'ucm_SND_dBA'
rodrigues_block$results$model_details <- paste(rodrigues_block$results$model_details,
  'Source H2 thematic model; WalkU/WalkG only.')
rodrigues_rows <- list(rodrigues_block$results)
for (sound in alt_sounds)
  rodrigues_rows[[length(rodrigues_rows) + 1L]] <- tag_alt(H4_RODRIGUES$run(epochs, lme_control, sound)$results,
    sound$column, paste0(' [', sound$column, ']'))
results$rodrigues <- bind_rows(rodrigues_rows)

# =============================================================================
# 3.8 Kraus 2013 — all four phases; 5-min interval additive mixed model, piecewise Leq at 65 dB(A) (dBA + encodings 2-4 + 15 spectral).
# =============================================================================
step_log('3.8 Kraus 2013 (AIC trend selection)')
kraus_block <- H4_KRAUS$run(epochs, lme_control)
kraus_rows <- list(with_sound(kraus_block$results, 'ucm_SND_dBA'))
alt_kraus_notes <- character(0)
for (sound in alt_sounds) {
  alt_kraus <- H4_KRAUS$run(epochs, lme_control, sound)
  kraus_rows[[length(kraus_rows) + 1L]] <- tag_alt(alt_kraus$results, sound$column, paste0(' [', sound$column, ']'))
  alt_kraus_notes <- c(alt_kraus_notes, sprintf('  - %s (%s): Kraus knot = median %.4g, slope per 1 SD = %.4g',
    sound$column, sound$family, alt_kraus$knot, alt_kraus$step))
}
results$kraus <- bind_rows(kraus_rows)
fit_notes <- c(fit_notes, 'Kraus 2013 AIC selection per outcome:',
  paste0('  - ', names(kraus_block$selection), ': ', unlist(kraus_block$selection)),
  'Kraus 2013 alternative sound variables (knot and SD per descriptor):', alt_kraus_notes)

# =============================================================================
# 3.9 Korpilo 2024 — WalkG/WalkU; ln tonic EDA ~ sound_x + temp + RH + PhaseID (NDSI analogue + encodings 1-4 + 15 spectral).
# =============================================================================
step_log('3.9 Korpilo 2024')
korpilo_sounds <- c(list(ucm_SND_dBA = H4_SOUND$primary), alt_sounds)
korpilo_rows <- list(with_sound(H4_KORPILO$run(epochs_walk, lme_control)$results, 'NDSI analogue (frequency-band proportions)'))
for (sound in korpilo_sounds)
  korpilo_rows[[length(korpilo_rows) + 1L]] <- with_sound(H4_KORPILO$run(epochs_walk, lme_control, sound)$results, sound$column)
results$korpilo <- bind_rows(korpilo_rows)

# =============================================================================
# 3.10 Chen 2023 — WalkG/WalkU; rating ~ zUTCI * zdBA + zNatural (+ encoding variants).
# =============================================================================
step_log('3.10 Chen 2023')
chen <- h4_additional_outdoor_tests(epochs_walk, papers = 'Chen', include_scopus = FALSE)
results$chen <- chen$results

# =============================================================================
# 3.11 Ueberham 2019 — BikeG/BikeU only; Spearman dBA vs AC and UTCI vs TC within each cycling phase.
# =============================================================================
step_log('3.11 Ueberham 2019')
ueberham_rows <- list()
for (phase in H4_PHASE_BIKE) {
  data <- outdoor_bike[outdoor_bike$PhaseID == phase, , drop = FALSE]
  for (spec in list(c('dba', 'acoustic_comfort', 'ucm_SND_dBA'), c('utci', 'thermal_comfort', 'ucm_UTCI'))) {
    row <- H4_AL$spearman_row(data[[spec[1]]], data[[spec[2]]], 'Ueberham 2019',
      paste('Spearman objective route mean vs comfort |', spec[1], 'vs', spec[2], '| phase', phase), spec[2],
      paste(ratings[[spec[2]]], spec[3], sep = ', '), 'Spearman rho',
      paste('spearman(', spec[1], ',', spec[2], ') within', phase),
      'Source Spearman of objective route means vs post-trip perceived intensity; comfort votes replace intensity items (not collected). BikeG/BikeU only.',
      length(unique(data$ParticipantID)), data$ParticipantID)
    ueberham_rows[[length(ueberham_rows) + 1L]] <- H4_AL$attach_sound(row, if (spec[1] == 'dba') 'dba' else 'temperature-only (UTCI)')
  }
}
results$ueberham <- bind_rows(ueberham_rows)

# =============================================================================
# 3.12 Li 2025 — WalkG/WalkU arrival-only analogue; linear vs quadratic dBA and UTCI x dBA LMMs; ML likelihood-ratio test.
# =============================================================================
step_log('3.12 Li 2025')
li_rows <- list()
for (outcome in c('thermal_comfort', 'acoustic_comfort', 'overall_comfort')) {
  data <- outdoor_walk[complete.cases(outdoor_walk[c(outcome, 'utci', 'dba')]), , drop = FALSE]
  data$Y <- data[[outcome]]
  li_note <- 'Li 2025 arrival-only analogue (no departure, no SLV); raw units; participant intercept.'
  li_rows[[length(li_rows) + 1L]] <- h4_phase_lmm_rows(data, Y ~ utci + dba + I(dba^2), c('utci', 'dba', 'I(dba^2)'),
    'Li 2025', 'quadratic LMM:', outcome, ratings[[outcome]], 'dba', li_note)
  li_rows[[length(li_rows) + 1L]] <- h4_phase_lmm_rows(data, Y ~ utci * dba, c('utci', 'dba', 'utci:dba'),
    'Li 2025', 'interaction LMM:', outcome, ratings[[outcome]], 'dba', li_note)
  data$ParticipantID <- factor(data$ParticipantID)
  lrt <- tryCatch({
    linear <- nlme::lme(Y ~ utci + dba, random = ~ 1 | ParticipantID, data = data, method = 'ML', control = lme_control)
    quadratic <- nlme::lme(Y ~ utci + dba + I(dba^2), random = ~ 1 | ParticipantID, data = data, method = 'ML', control = lme_control)
    a <- anova(linear, quadratic)
    list(stat = a$L.Ratio[2], p = a$`p-value`[2], aic = a$AIC)
  }, error = function(e) e)
  li_rows[[length(li_rows) + 1L]] <- result_row('Li 2025', 'linear vs quadratic dBA (ML likelihood-ratio test)', outcome,
    'I(dba^2) nested-model LRT', data,
    statistic = if (inherits(lrt, 'error')) NA_real_ else lrt$stat, df = 1,
    p = if (inherits(lrt, 'error')) NA_real_ else lrt$p,
    statistic_test = 'likelihood-ratio chi-square (ML LMM, participant intercept)',
    model = 'Y ~ utci + dba vs Y ~ utci + dba + I(dba^2) | (1|ParticipantID)',
    note = paste(li_note, if (inherits(lrt, 'error')) conditionMessage(lrt) else sprintf('AIC linear=%.3f, quadratic=%.3f.', lrt$aic[1], lrt$aic[2])),
    sound_variable = 'dba')
}
results$li <- bind_rows(li_rows)

# =============================================================================
# 3.13 Qin 2024 — WalkG/WalkU; TC ~ z(sound) * z(RH) for four encodings; Table-2 Pearson analogue.
# =============================================================================
step_log('3.13 Qin 2024')
qin_rows <- list(scopus_block('Qin'))
for (spec in list(c('dba', 'ucm_SND_dBA'), c('rh', 'ucm_AIR_RH'), c('pet', 'ucm_PET')))
  for (phase in H4_PHASE_WALK) {
    data <- outdoor_walk[outdoor_walk$PhaseID == phase, , drop = FALSE]
    qin_rows[[length(qin_rows) + 1L]] <- h4_pearson_row(data[[spec[1]]], data$thermal_comfort, 'Qin 2024',
      paste('Pearson Table 2 analogue: subjective thermal vs', spec[1], '| phase', phase), 'thermal_comfort', spec[1],
      ratings[['thermal_comfort']], if (spec[1] == 'dba') 'dba' else spec[2],
      'Source Table 2 style; outcome = domain thermal comfort (§2); bout-level means; n=11 independent people within phase (Xu/Simşek analogue, not pooled 22 cells).',
      length(unique(data$ParticipantID)))
  }
results$qin <- bind_rows(qin_rows)
qin_bins <- outdoor_walk[complete.cases(outdoor_walk[c('thermal_comfort', 'rh', 'dba')]), ]
qin_bins$rh_bin <- cut(qin_bins$rh, unique(quantile(qin_bins$rh, 0:4 / 4)), include.lowest = TRUE)
qin_bins$dba_bin <- cut(qin_bins$dba, unique(quantile(qin_bins$dba, 0:4 / 4)), include.lowest = TRUE)
fit_notes <- c(fit_notes, 'Qin 2024 descriptive mean TC by RH quartile (rows) x dBA quartile (columns), walk cells; no inferential test (cell n < 5):',
  capture.output(print(round(tapply(qin_bins$thermal_comfort, list(qin_bins$rh_bin, qin_bins$dba_bin), mean), 2))),
  'Cell counts:', capture.output(print(table(qin_bins$rh_bin, qin_bins$dba_bin))))

# =============================================================================
# 3.14 Mohammadzadeh 2023 — WalkG/WalkU; AC ~ UTCI, AC ~ TC, AC ~ UTCI x dBA; Pearson AC vs dBA and UTCI.
# =============================================================================
step_log('3.14 Mohammadzadeh 2023')
moh_rows <- list(scopus_block('Mohammadzadeh'))
for (spec in list(c('dba', 'dba'), c('utci', 'temperature-only (UTCI)')))
  for (phase in H4_PHASE_WALK) {
    data <- outdoor_walk[outdoor_walk$PhaseID == phase, , drop = FALSE]
    moh_rows[[length(moh_rows) + 1L]] <- h4_pearson_row(data[[spec[1]]], data$acoustic_comfort, 'Mohammadzadeh 2023',
      paste('Pearson AC vs', spec[1], '| phase', phase), 'acoustic_comfort', spec[1], ratings[['acoustic_comfort']], spec[2],
      'Source §2.5 Pearson style; n=11 independent people within phase (not pooled 22 walk cells or source plant-community strata).',
      length(unique(data$ParticipantID)))
  }
results$mohammadzadeh <- bind_rows(moh_rows)

# =============================================================================
# 3.15 Gao 2025 — WalkG/WalkU; PRS ~ zUTCI * zSound (four encodings); quartile ANOVA; veto cross-tab descriptive.
# =============================================================================
step_log('3.15 Gao 2025')
results$gao <- scopus_block('Gao')
veto <- outdoor_walk[complete.cases(outdoor_walk[c('thermal_comfort', 'acoustic_comfort')]), ]
veto$low_tc <- ifelse(veto$thermal_comfort <= 3, 'TC low', 'TC ok')
veto$low_ac <- ifelse(veto$acoustic_comfort <= 3, 'AC low', 'AC ok')
fit_notes <- c(fit_notes, 'Gao 2025 veto analogue (descriptive only; walk cells): counts and mean PRS (four-subscale mean):',
  capture.output(print(table(veto$low_tc, veto$low_ac))),
  capture.output(print(round(tapply(veto$prs_mean, list(veto$low_tc, veto$low_ac), mean, na.rm = TRUE), 2))))

# =============================================================================
# 3.16 Wu 2025 — published objective and subjective OC models on walk cells, plus four-way OC/TC encodings (§1.1, §3.16).
# =============================================================================
step_log('3.16 Wu 2025')
wu_rows <- list()
wu_models <- list(objective = overall_comfort ~ utci + dba,
                  subjective = overall_comfort ~ thermal_comfort + acoustic_comfort)
for (model_name in names(wu_models)) {
  formula <- wu_models[[model_name]]
  data <- cells_walk[complete.cases(cells_walk[all.vars(formula)]), ]
  data$ParticipantID <- factor(data$ParticipantID)
  fit <- tryCatch(nlme::lme(formula, random = ~ 1 | ParticipantID, data = data,
    method = 'REML', control = lme_control), error = function(error) error)
  for (predictor in attr(terms(formula), 'term.labels')) {
    coefficient <- if (!inherits(fit, 'error')) summary(fit)$tTable[predictor, ] else
      setNames(rep(NA_real_, 5), c('Value', 'Std.Error', 'DF', 't-value', 'p-value'))
    critical <- if (is.finite(coefficient['DF'])) qt(0.975, coefficient['DF']) else NA_real_
    wu_rows[[length(wu_rows) + 1L]] <- result_row('Wu 2025',
      paste('Published', model_name, 'additive predictor set'), 'overall_comfort', predictor, data,
      estimate = unname(coefficient['Value']),
      se = unname(coefficient['Std.Error']),
      ci = unname(coefficient['Value'] + c(-1, 1) * critical * coefficient['Std.Error']),
      statistic = unname(coefficient['t-value']), df = unname(coefficient['DF']), p = unname(coefficient['p-value']),
      statistic_test = 't-test (mixed regression coefficient; participant intercept)',
      model = paste(deparse(formula), collapse = ' '),
      note = paste('WalkG/WalkU only. Wu source equations 1/4 predictor sets.',
        if (inherits(fit, 'error')) conditionMessage(fit) else ''),
      sound_variable = if (model_name == 'objective') 'ucm_SND_dBA' else 'perceived acoustic comfort')
  }
}
wu_rows[[length(wu_rows) + 1L]] <- scopus_block('Wu')
results$wu <- bind_rows(wu_rows)

# =============================================================================
# 3.17 Xu 2026 — Pearson within WalkG and WalkU, plus linear AC ~ zSound on four encodings (§1.1, §3.17).
# =============================================================================
step_log('3.17 Xu 2026')
xu_rows <- list()
for (phase in H4_PHASE_WALK) {
  for (outcome in c('thermal_comfort', 'acoustic_comfort')) {
    data <- cells_walk[cells_walk$PhaseID == phase & complete.cases(cells_walk[c('dba', outcome)]), ]
    fit <- if (nrow(data) >= 3L && sd(data$dba) > 0 && sd(data[[outcome]]) > 0)
      cor.test(data$dba, data[[outcome]], method = 'pearson') else NULL
    xu_rows[[length(xu_rows) + 1L]] <- result_row('Xu 2026',
      'Pearson sound-comfort association (phase-stratified)', outcome, paste('dBA, phase', phase), data,
      estimate = if (!is.null(fit)) unname(fit$estimate) else NA_real_,
      ci = if (!is.null(fit) && !is.null(fit$conf.int)) unname(fit$conf.int) else c(NA_real_, NA_real_),
      statistic = if (!is.null(fit)) unname(fit$statistic) else NA_real_,
      df = if (!is.null(fit)) unname(fit$parameter) else NA_real_,
      p = if (!is.null(fit)) fit$p.value else NA_real_,
      statistic_test = 'Pearson correlation t-test (two-sided)',
      model = paste('Pearson(', outcome, ', dBA) within', phase),
      note = if (is.null(fit)) 'not estimable (fewer than 3 people or no variation).' else 'Source Table 3-style Pearson; no threshold/CART/SHAP.')
  }
}
xu_rows[[length(xu_rows) + 1L]] <- scopus_block('Xu')
results$xu <- bind_rows(xu_rows)
xu_air <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) data.frame(PhaseID = epochs$PhaseID[rows[1]],
  hot = H4_UTIL$finite_mean(epochs$ucm_AIR_temp[rows]) > 32, loud = H4_UTIL$energy_mean_db(epochs$ucm_SND_dBA[rows]) > 65)))
fit_notes <- c(fit_notes, sprintf('Xu 2026 combined condition (all 44 core cells): air_temp>32 %d yes / %d no; dBA>65 %d yes / %d no; both %d. Interaction not fitted (item 7).',
  sum(xu_air$hot), sum(!xu_air$hot), sum(xu_air$loud), sum(!xu_air$loud), sum(xu_air$hot & xu_air$loud)))

# =============================================================================
# 3.18 Zhen 2025 — WalkG/WalkU; pooled TC ~ UTCI * dBA; UTCI slopes within traffic vs nature majority; per-phase Spearman.
# =============================================================================
step_log('3.18 Zhen 2025')
zhen_rows <- list(scopus_block('Zhen'))
zhen <- outdoor_walk[complete.cases(outdoor_walk[c('thermal_comfort', 'utci', 'vehicle_proportion', 'rural_natural_proportion')]), ]
zhen$traffic <- as.numeric(zhen$vehicle_proportion > zhen$rural_natural_proportion)
zhen_note <- 'Sound-type analogue = phase-mean vehicle_proportion > rural_natural_proportion (binary; no positive/neutral/negative trichotomy). Source TSV blocks use domain thermal comfort (§2).'
for (stratum in c(nature = 0, traffic = 1)) {
  label <- if (stratum == 1) 'traffic-majority' else 'nature-majority'
  zhen_rows[[length(zhen_rows) + 1L]] <- h4_phase_lmm_rows(zhen[zhen$traffic == stratum, , drop = FALSE],
    thermal_comfort ~ utci, 'utci', 'Zhen 2025', paste('TC ~ UTCI within', label, 'phases:'), 'thermal_comfort',
    ratings[['thermal_comfort']], 'YAMNet vehicle vs rural_natural (phase label)', zhen_note)
}
zhen_rows[[length(zhen_rows) + 1L]] <- h4_phase_lmm_rows(zhen, thermal_comfort ~ utci * traffic, 'utci:traffic',
  'Zhen 2025', 'UTCI slope difference traffic vs nature:', 'thermal_comfort', ratings[['thermal_comfort']],
  'YAMNet vehicle vs rural_natural (phase label)', paste(zhen_note, 'Interaction compares beta(UTCI) between strata.'))
for (phase in H4_PHASE_WALK) {
  data <- outdoor_walk[outdoor_walk$PhaseID == phase, , drop = FALSE]
  zhen_rows[[length(zhen_rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(data$utci, data$thermal_comfort, 'Zhen 2025',
    paste('Spearman UTCI vs TC, phase', phase), 'thermal_comfort', paste(ratings[['thermal_comfort']], 'ucm_UTCI', sep = ', '),
    'Spearman rho', paste('spearman(utci, thermal_comfort) within', phase),
    'Source Spearman per plaza node; phase is the node analogue.', length(unique(data$ParticipantID)), data$ParticipantID),
    'temperature-only (UTCI)')
}
results$zhen <- bind_rows(zhen_rows)

# =============================================================================
# 3.19 Zhang SciRep 2026 — WalkG/WalkU; TC ~ z(AC) * z(UTCI), plus a dBA-adjusted variant.
# =============================================================================
step_log('3.19 Zhang 2026 SciRep')
zs <- outdoor_walk[complete.cases(outdoor_walk[c('thermal_comfort', 'acoustic_comfort', 'pet', 'dba')]), ]
zs$ac_z <- as.numeric(scale(zs$acoustic_comfort)); zs$pet_z <- as.numeric(scale(zs$pet)); zs$dba_z <- as.numeric(scale(zs$dba))
results$zhang_scirep <- rbind(scopus_block('ZhangSciRep'),
  h4_phase_lmm_rows(zs, thermal_comfort ~ ac_z * pet_z + dba_z, c('ac_z', 'pet_z', 'dba_z', 'ac_z:pet_z'),
    'Zhang 2026 SciRep', 'TC ~ AC x PET + dBA:', 'thermal_comfort', ratings[['thermal_comfort']], 'dba',
    'LAeq-extended acoustic-indicator model analogue; Gaussian LMM replaces ordered logit; ucm_PET per §2.'))

# =============================================================================
# 3.20 Zhang BSim 2026 — Spearman dBA vs each vote within WalkU and WalkG; optional meteorology vs TC.
# =============================================================================
step_log('3.20 Zhang 2026 BSim')
zb_rows <- list(scopus_block('ZhangBSim'))
for (phase in H4_PHASE_WALK) {
  data <- outdoor_walk[outdoor_walk$PhaseID == phase, , drop = FALSE]
  for (met in c('air_temp_c', 'rh', 'wind_aws', 'utci')) {
    if (!any(is.finite(data[[met]]))) next
    zb_rows[[length(zb_rows) + 1L]] <- H4_AL$attach_sound(H4_AL$spearman_row(data[[met]], data$thermal_comfort, 'Zhang 2026 BSim',
      paste('Spearman TC vs', met, ', phase', phase), 'thermal_comfort', paste(ratings[['thermal_comfort']], met, sep = ', '),
      'Spearman rho', paste('spearman(thermal_comfort,', met, ') within', phase),
      'Source §3.2.1.1 TSV–meteorology Spearman: subjective thermal = domain thermal comfort (§2).',
      length(unique(data$ParticipantID)), data$ParticipantID), paste('meteorology only:', met))
  }
}
results$zhang_bsim <- bind_rows(zb_rows)

# =============================================================================
# 3.21 Song — paired WalkU - WalkG on HR, SDNN, RMSSD, LF/HF; no sound or UTCI regressor.
# =============================================================================
step_log('3.21 Song')
song_cols <- c(heart_rate = 'empatica_heart_rate', sdnn = 'empatica_hrv_td_sdnn', rmssd = 'empatica_hrv_td_rmssd',
  lf_hf_ratio = 'empatica_hrv_fd_lf_hf_ratio')
song_cells <- do.call(rbind, lapply(H4_UTIL$bouts(epochs_walk), function(rows) {
  out <- data.frame(ParticipantID = epochs_walk$ParticipantID[rows[1]], route = epochs_walk$PhaseID[rows[1]])
  for (name in names(song_cols)) out[[name]] <- H4_UTIL$finite_mean(epochs_walk[[song_cols[[name]]]][rows])
  out
}))
song_rows <- list()
for (name in names(song_cols)) {
  pair <- H4_AL$person_pair(song_cells, name, by = 'route', a = 'WalkG', b = 'WalkU')
  row <- H4_AL$paired_t_row(pair, 'Song', 'paired park vs city walk (WalkU minus WalkG)', name, song_cols[[name]],
    'WalkU minus WalkG', 'phase-mean physiology (WalkU minus WalkG)', paste(name, 'WalkU - WalkG | paired t by ParticipantID'),
    'Park vs city walking contrast; no sound or UTCI regressor (faithful to source); does not test the H4 thermo-acoustic hypothesis')
  song_rows[[length(song_rows) + 1L]] <- H4_AL$attach_sound(row, 'green vs urban corridor (route contrast, no sound predictor)')
}
results$song <- bind_rows(song_rows)

# =============================================================================
# 3.22 Tang 2026 — WalkG/WalkU; physiology ~ dBA x PET, Shannon diversity x PET, Kruskal dBA quartiles within PET half.
# =============================================================================
step_log('3.22 Tang 2026')
results$tang <- scopus_block('Tang')

# =============================================================================
# 3.23 Peng 2026 — WalkG/WalkU; Kruskal WalkG vs WalkU, Spearman among votes and dBA, OC ~ thermal + acoustic + visual.
# =============================================================================
step_log('3.23 Peng 2026')
results$peng <- scopus_block('Peng')

# =============================================================================
# 3.24 Simsek 2026 — WalkG/WalkU; Pearson AC vs dBA/UTCI/RH/wind within phase, pooled LMM AC ~ z(env predictors).
# =============================================================================
step_log('3.24 Simsek 2026')
results$simsek <- scopus_block('Simsek')

results <- Filter(function(block) is.data.frame(block) && nrow(block), results)
catalog <- do.call(H4_REPORT$catalog, unname(results))
primary_estimands <- H4_PRIMARY$subset(catalog)
significance_summary <- H4_REPORT$summary(catalog)
stopifnot(all(is.finite(catalog$p)), all(catalog$p >= 0 & catalog$p <= 1))
if (nrow(primary_estimands)) stopifnot(all(is.finite(primary_estimands$p)))
paper_counts <- table(factor(catalog$paper, levels = unique(catalog$paper)))
expected_papers <- c('Pigliautile 2021', 'Cureau 2022', 'Chiucchiù 2026', 'Moshammer 2019', 'Jin 2020', 'Biel 2020',
  'Rodrigues 2026', 'Kraus 2013', 'Korpilo 2024', 'Chen 2023 (adapted)', 'Ueberham 2019', 'Li 2025', 'Qin 2024',
  'Mohammadzadeh 2023', 'Gao 2025', 'Wu 2025', 'Xu 2026', 'Zhen 2025', 'Zhang 2026 SciRep', 'Zhang 2026 BSim',
  'Song', 'Tang 2026', 'Peng 2026', 'Simsek 2026')
missing_papers <- setdiff(expected_papers, names(paper_counts))
if (length(missing_papers)) warning('No estimable rows for: ', paste(missing_papers, collapse = ', '))

notes <- c('# H4 literature-aligned partial ports (documents/H4_papers_screened_final.md sections 0.6 and 3)',
  paste('Phases:', paste(analysis_phases, collapse = ', '), '; walk-only papers use', paste(H4_PHASE_WALK, collapse = ', '),
    '; Biel/Kraus use all four; Ueberham uses', paste(H4_PHASE_BIKE, collapse = ', ')),
  paste('Input MD5:', unname(input_fingerprint)),
  paste('Code MD5:', basename(code_paths), unname(code_fingerprints)),
  paste('Source PDF MD5:', source_papers, unname(source_fingerprints)),
  if (length(missing_optional)) paste('Source PDF not found (not fingerprinted):', names(missing_optional), missing_optional),
  sprintf('Run time: %.1f s', as.numeric(difftime(Sys.time(), started, units = 'secs'))),
  '', '## Rows per paper (finite p)', sprintf('- %s: %d', names(paper_counts), as.integer(paper_counts)),
  if (length(missing_papers)) paste('- No estimable rows:', paste(missing_papers, collapse = ', ')),
  '', '## Methods (see documents/H4_papers_screened_final.md section 1.1 and section 3 item 9)',
  '- Pigliautile/Chiucchiu: person-mean paired t and participant-mean Spearman on WalkG/WalkU (thermal split within person).',
  '- Moshammer: walking-phase xtreg-re GLS, first-5-min Leq exposure, 5-8 min native-beat outcomes.',
  '- Jin/Cureau/Wu/Xu/Chen/Li/Qin/Mohammadzadeh/Gao/Zhen/Zhang/Song/Tang/Peng/Simsek/Korpilo/Rodrigues: WalkG/WalkU only.',
  '- Biel (phase LMM + repeated 2-min CAR1) and Kraus (5-min additive mixed model) on all four core phases.',
  '- Ueberham: Spearman within BikeG and within BikeU; optional polr not fitted.',
  '- Encodings 2-4 and 15 spectral descriptors substituted on Moshammer, Jin, Biel, Rodrigues, Kraus, and Korpilo (§1.1).',
  '- Inference: each row\'s paper_rule only (documents/H4_papers_screened_final.md §1.4); no catalogue-wide BH/FDR in this run.',
  '- Outputs: H4_primary_estimands_results.csv = Paper 3 H4 layer A (§0.3); H4_sound_literature_tests.csv = full catalogue layer B.',
  H4_PRIMARY$methods_notes(primary_estimands),
  '', '## Fit and support notes', fit_notes, chen$notes,
  H4_REPORT$not_estimable_notes(attr(catalog, 'not_estimable')))

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop('H4 code changed during run')
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop('Merged input changed during run')
if (!identical(unname(tools::md5sum(source_paths)), unname(source_fingerprints))) stop('Source PDFs changed during run')
staged_outdir <- tempfile('H4_results_')
dir.create(staged_outdir, recursive = TRUE)
write.csv(catalog[setdiff(names(catalog), c('paper_rule_met', 'model_details'))],
  file.path(staged_outdir, 'H4_sound_literature_tests.csv'), row.names = FALSE, na = '')
primary_export <- primary_estimands[setdiff(names(primary_estimands), c('paper_rule_met', 'model_details'))]
write.csv(primary_export, file.path(staged_outdir, 'H4_primary_estimands_results.csv'), row.names = FALSE, na = '')
write.csv(significance_summary, file.path(staged_outdir, 'SUMMARY_sound_tests_paper_rule.csv'), row.names = FALSE, na = '')
writeLines(notes, file.path(staged_outdir, 'METHODS_NOTES.md'))
p3_finalize_directory(staged_outdir)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
output_files <- list.files(staged_outdir, full.names = TRUE)
stopifnot(length(output_files) == 4L)
if (!all(file.copy(output_files, outdir, overwrite = TRUE))) stop('Failed to publish H4 files')
step_log(sprintf('%d catalogue rows (%d primary H4 estimands) from %d papers',
  nrow(catalog), nrow(primary_estimands), length(paper_counts)))
cat('Done:', outdir, paste(basename(output_files), collapse = ', '), '\n')
