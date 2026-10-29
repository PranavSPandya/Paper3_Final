# H4 phase-average: ONLY Eq1, substituting one sound measure at a time for dBA.
# Run: Rscript scripts/statistical_analysis/H4_phaseavg_sound.R --workers=4
# Output: output/statistical_analysis/results/H4_phaseavg_sound/
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
if(sys.nframe()==0L)h4s_run('phaseavg',Eq1,.entry)
