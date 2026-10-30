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
