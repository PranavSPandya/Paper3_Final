# H4 time-series: ONLY Eq1, substituting one sound measure at a time for dBA (ucm_SND_dBA_bout_z).
# Run: Rscript scripts/statistical_analysis/H4_timeseries_sound.R --workers=4
# --band-contrasts: supplementary sound-band contrasts within UTCI strata b26_32 and gt32 only
#   (epochs subset before fit; no whole-route pooling). Output: H4_sound_band_contrasts.csv
# Default Eq1 grid: full cohort unless --exposure-stratum=b26_32|gt32 (default none).
# Output: output/statistical_analysis/results/H4_timeseries_sound/ (10 s CSVs at root;
#   wider bins under epoch_30s/, epoch_60s/, epoch_300s/). Default run: 30/60/300 only (keeps root 10 s).
# Primary H4_timeseries/ is never written.
# Wind QC (no dBA correction): --wind-sensitivity [--wind-max-aws=5] writes under .../wind_aws_le_5ms/
#   (per epoch subfolder). Excludes 10 s windows with ucm_WIND_AWS above threshold; see H4_sound_wind_screening_summary.csv.

# Merged-data columns that replace dBA one at a time (main {name}_bout_z + UTCI interaction).
# Indexed 1..N — edit h4s_sound_substitutes[[i]] to swap a single substitute by index (proportion/spectral only; no *_score).
h4s_sound_substitutes <- list(
  `1` = 'dominant_frequency_Hz',
  `2` = 'freq_proportion_2000_to_20000Hz',
  `3` = 'freq_proportion_200_to_2000Hz',
  `4` = 'freq_proportion_20_to_200Hz',
  `5` = 'mechanisms_proportion',
  `6` = 'octave_proportion_1000_0_Hz',
  `7` = 'octave_proportion_125_0_Hz',
  `8` = 'octave_proportion_2000_0_Hz',
  `9` = 'octave_proportion_250_0_Hz',
  `10` = 'octave_proportion_31_5_Hz',
  `11` = 'octave_proportion_4000_0_Hz',
  `12` = 'octave_proportion_500_0_Hz',
  `13` = 'octave_proportion_63_0_Hz',
  `14` = 'octave_proportion_8000_0_Hz',
  `15` = 'rural_natural_proportion',
  `16` = 'spectral_centroid_Hz',
  `17` = 'spectral_rolloff85_Hz',
  `18` = 'urban_manmade_negative_proportion',
  `19` = 'urban_manmade_neutral_proportion',
  `20` = 'urban_manmade_positive_proportion',
  `21` = 'vehicle_proportion',
  `22` = 'wind_proportion'
)

options(stringsAsFactors=FALSE)
.files <- vapply(sys.frames(),function(f)if(is.null(f$ofile))'' else as.character(f$ofile)[1],character(1))
.entry <- sub('^--file=','',grep('^--file=',commandArgs(FALSE),value=TRUE))
if(!length(.entry) || !file.exists(.entry[1])) .entry <- tail(.files[nzchar(.files)],1)
if(!length(.entry))stop('Cannot locate entry script')
.entry <- normalizePath(.entry[1],winslash='/',mustWork=TRUE)
source(file.path(dirname(.entry),'library','Paper3_common.R'),local=FALSE)
for(package in c('nlme','clubSandwich','car'))if(!requireNamespace(package,quietly=TRUE))stop('Required package missing: ',package)

# SOUND is replaced by the actual raw column name, both as a main effect and interaction.
Eq1 <- quote(nlme::lme(
  Y ~ ucm_UTCI_bout_z * SOUND_bout_z + ucm_SUN_Gh_bout_z + SVF_bout_z +
    atmo_pm2.5_avg_bout_z + lys_lux_avg_bout_z + lys_kelvin_avg_bout_z +
    gvi_50m_bout_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data=model_data,random=~1|ParticipantID/PhaseID,
  correlation=nlme::corAR1(value=.2,form=~Time10|ParticipantID/PhaseID),
  method='REML',na.action=na.fail
))
source(file.path(dirname(.entry),'library','H4_sound_core.R'),local=FALSE)
# Optional sound lag (default off; with no lag flag nothing below changes any run).
# CLI: --lag-sec=30,60 [--epoch-sec=10|30|60] [--workers=4]; epochs default to 10, 30, 60.
# Rscript -e route: h4s_run_lag('timeseries', Eq1, .entry, h4s_sound_substitutes, epoch_sec=10L, lag_sec=30L)
# For lag L s, the sound column of each row is replaced by the sound value L s earlier in the same
# ParticipantID x PhaseID bout, matched on the time index (10 s: Time10 from Datetime; wider epochs:
# the bin index, lag L/epoch_sec bins). No earlier row -> NA -> row dropped. Only sound is lagged;
# controls, random effects, AR1 and centering are those of H4_sound_core.R. A lag that is not a
# whole multiple of epoch_sec is skipped. Output: <epoch folder>/lag_<L>s/ with a README line.
h4s_lag_sec <- NA_integer_
h4s_lag_shift <- function(x, participant, phase, time_index, steps) {
  key <- paste(participant, phase, time_index, sep = '\r')
  stopifnot(!anyDuplicated(key))
  x[match(paste(participant, phase, time_index - steps, sep = '\r'), key)]
}
h4s_run_lag <- function(mode, template, script_path, sound_substitutes, epoch_sec = 10L, lag_sec = h4s_lag_sec) {
  stopifnot(mode == 'timeseries', length(lag_sec) == 1L, is.finite(lag_sec), lag_sec > 0)
  epoch_sec <- as.integer(epoch_sec); lag_sec <- as.integer(lag_sec)
  if (lag_sec %% epoch_sec != 0L) {
    cat('SKIPPED: lag', lag_sec, 's is not a whole multiple of epoch', epoch_sec, 's\n'); flush.console()
    return(invisible(NULL))
  }
  steps <- as.integer(lag_sec / epoch_sec)
  saved <- list(h4s_model_data = h4s_model_data, h4s_aggregate_epoch_sec = h4s_aggregate_epoch_sec, h4s_outdir = h4s_outdir)
  on.exit(for (n in names(saved)) assign(n, saved[[n]], envir = .GlobalEnv), add = TRUE)
  wrap_env <- new.env(parent = .GlobalEnv)
  wrap_env$orig_model_data <- saved$h4s_model_data
  wrap_env$orig_aggregate <- saved$h4s_aggregate_epoch_sec
  wrap_env$orig_outdir <- saved$h4s_outdir
  wrap_env$h4s_lag_shift <- h4s_lag_shift
  wrap_env$steps <- steps
  wrap_env$lag_sec <- lag_sec
  model_data_lag <- function(d, outcome, sound, mode, transforms, template, epoch_sec = 10L, wind_max_aws = NA_real_) {
    if (as.integer(epoch_sec) == 10L) {
      d[[sound]] <- h4s_lag_shift(d[[sound]], d$ParticipantID, d$PhaseID, d$Time10, steps)
    }
    orig_model_data(d, outcome, sound, mode, transforms, template, epoch_sec, wind_max_aws)
  }
  aggregate_lag <- function(epoch, eligibility, epoch_sec) {
    out <- orig_aggregate(epoch, eligibility, epoch_sec)
    if (as.integer(epoch_sec) == 10L) return(out)
    stopifnot(eligibility[1L] == 'ucm_UTCI')
    sound <- eligibility[2L]
    out[[sound]] <- h4s_lag_shift(out[[sound]], out$ParticipantID, out$PhaseID, out$Time10, steps)
    out <- out[is.finite(out[[sound]]), , drop = FALSE]
    if (!nrow(out)) stop('No eligible epochs after sound lag')
    out
  }
  outdir_lag <- function(root, mode, epoch_sec = 10L, wind_max_aws = NA_real_) {
    file.path(orig_outdir(root, mode, epoch_sec, wind_max_aws), paste0('lag_', lag_sec, 's'))
  }
  environment(model_data_lag) <- wrap_env
  environment(aggregate_lag) <- wrap_env
  environment(outdir_lag) <- wrap_env
  assign('h4s_model_data', model_data_lag, envir = .GlobalEnv)
  assign('h4s_aggregate_epoch_sec', aggregate_lag, envir = .GlobalEnv)
  assign('h4s_outdir', outdir_lag, envir = .GlobalEnv)
  res <- h4s_run(mode, template, script_path, sound_substitutes, epoch_sec = epoch_sec)
  root <- resolve_project_root()
  readme <- file.path(outdir_lag(root, mode, epoch_sec, NA_real_), 'README.txt')
  cat(paste0('Sound lag used: ', lag_sec, ' s (', steps, ' x ', epoch_sec,
    ' s time steps); the sound predictor (main effect and UTCI interaction) is the value from ', lag_sec,
    ' s earlier in the same ParticipantID x PhaseID bout, matched on the time index; rows without that earlier value are dropped. Outcome, UTCI and all controls are unlagged. The earlier README line saying no lag models are run describes the unlagged default only.'),
    file = readme, sep = '\n', append = TRUE)
  invisible(res)
}
if (sys.nframe() == 0L && length(grep('^--lag-sec=', commandArgs(trailingOnly = TRUE)))) {
  lag_args <- commandArgs(trailingOnly = TRUE)
  if (any(c('--band-contrasts', '--wind-sensitivity') %in% lag_args)) stop('--lag-sec is not combined with --band-contrasts or --wind-sensitivity')
  lag_values <- as.integer(strsplit(sub('^--lag-sec=', '', grep('^--lag-sec=', lag_args, value = TRUE)[1L]), ',', fixed = TRUE)[[1L]])
  stopifnot(length(lag_values) >= 1L, !anyNA(lag_values), all(lag_values > 0L))
  lag_one <- grep('^--epoch-sec=', lag_args, value = TRUE)
  lag_epochs <- if (length(lag_one)) as.integer(sub('^--epoch-sec=', '', lag_one[1L])) else c(10L, 30L, 60L)
  for (lag_epoch in lag_epochs) for (lag_value in lag_values) {
    h4s_run_lag('timeseries', Eq1, .entry, h4s_sound_substitutes, epoch_sec = lag_epoch, lag_sec = lag_value)
  }
  quit(save = 'no', status = 0L)
}
if(sys.nframe()==0L) {
  args <- commandArgs(trailingOnly = TRUE)
  # Supplementary only: categorical dBA bands within UTCI strata b26_32 and gt32 only
  # (epochs restricted before fit; n_participants logged). Eq1 continuous fit unchanged.
  if ('--band-contrasts' %in% args) {
    h4s_band_contrasts('timeseries', .entry)
  } else if ('--wind-sensitivity' %in% args) {
    wind_max <- 5
    argw <- grep('^--wind-max-aws=', args, value = TRUE)
    if (length(argw)) wind_max <- as.numeric(sub('^--wind-max-aws=', '', argw[1L]))
    one <- grep('^--epoch-sec=', args, value = TRUE)
    epochs <- if (length(one)) as.integer(sub('^--epoch-sec=', '', one[1L])) else c(10L, 30L, 60L, 300L)
    for (sec in epochs) {
      h4s_run('timeseries', Eq1, .entry, h4s_sound_substitutes, epoch_sec = sec, wind_max_aws = wind_max)
    }
  } else {
    one <- grep('^--epoch-sec=', args, value = TRUE)
    epochs <- if (length(one)) as.integer(sub('^--epoch-sec=', '', one[1L])) else c(30L, 60L, 300L)
    if (any(epochs == 10L)) stop('10 s writes H4_timeseries_sound/ root; default skips 10 s to preserve existing root outputs.')
    for (sec in epochs) h4s_run('timeseries', Eq1, .entry, h4s_sound_substitutes, epoch_sec = sec)
  }
}
