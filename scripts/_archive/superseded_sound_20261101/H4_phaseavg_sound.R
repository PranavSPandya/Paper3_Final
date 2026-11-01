# H4 phase-average: ONLY Eq1, substituting one sound measure at a time for dBA (ucm_SND_dBA_phase_z).
# --band-contrasts: phase means from UTCI-stratum epochs only (b26_32, gt32); no whole-route fits.
# Default Eq1: full cohort unless --exposure-stratum=b26_32|gt32 (default none).
# Sound substitute list (canonical edit): scripts/statistical_analysis/H4_timeseries_sound.R
# Run: Rscript scripts/statistical_analysis/H4_phaseavg_sound.R --workers=4
# Output: output/statistical_analysis/results/H4_phaseavg_sound/ (not H4_phaseavg/).
# Wind QC: --wind-sensitivity -> .../H4_phaseavg_sound/wind_aws_le_5ms/ (10 s windows with ucm_WIND_AWS <= 5 m/s before phase means).
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
  Y ~ ucm_UTCI_phase_z * SOUND_phase_z + SVF_phase_z + atmo_pm2.5_avg_phase_z +
    lys_lux_avg_phase_z + lys_kelvin_avg_phase_z + PhaseSumWalkG + PhaseSumWalkU + PhaseSumBikeG,
  data=model_data,random=~1|ParticipantID,method='REML',na.action=na.fail,
  control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE)
))
source(file.path(dirname(.entry),'library','H4_sound_core.R'),local=FALSE)
if(sys.nframe()==0L) {
  h4s_sound_substitutes <- h4s_read_sound_substitutes_from_entry(
    file.path(dirname(.entry), 'H4_timeseries_sound.R'))
  args <- commandArgs(trailingOnly = TRUE)
  wind_max <- if ('--wind-sensitivity' %in% args) {
    argw <- grep('^--wind-max-aws=', args, value = TRUE)
    if (length(argw)) as.numeric(sub('^--wind-max-aws=', '', argw[1L])) else 5
  } else {
    NA_real_
  }
  if ('--band-contrasts' %in% args) {
    h4s_band_contrasts('phaseavg', .entry)
  } else {
    h4s_run('phaseavg', Eq1, .entry, h4s_sound_substitutes, wind_max_aws = wind_max)
  }
}
