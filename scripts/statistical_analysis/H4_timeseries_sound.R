# H4 time-series: ONLY Eq1, substituting one sound measure at a time for dBA.
# Run: Rscript scripts/statistical_analysis/H4_timeseries_sound.R --workers=4
# Output: output/statistical_analysis/results/H4_timeseries_sound/
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
if(sys.nframe()==0L)h4s_run('timeseries',Eq1,.entry)
