# H4 spectrum: repeat Rodrigues sound models, replacing the sound column only.
options(stringsAsFactors=FALSE)
entry <- sub('^--file=','',grep('^--file=',commandArgs(FALSE),value=TRUE))
if (!length(entry) || !file.exists(entry[1])) stop('Run this file with Rscript.')
entry <- normalizePath(entry[1],winslash='/',mustWork=TRUE)
library_dir <- file.path(dirname(entry),'library')
code_paths <- c(entry,file.path(library_dir,c('Paper3_common.R','H4_sound_literature_helpers.R','H4_sound_literature_helpers_spectrum.R')))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path,local=FALSE)
if (!requireNamespace('nlme',quietly=TRUE)) stop('Required package missing: nlme')
suppressPackageStartupMessages(library(nlme))
lme_control <- nlme::lmeControl(opt='optim')
root <- resolve_project_root()
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs_walk <- H4_IO$read(root)
source_paths <- file.path(root,'Experiment papers',c(
  'H4 Sound literature test/Included - Sound - Rodrigues2026 - Repeated hotspot exposures Lisbon walks LMM.pdf'))
if (!all(file.exists(source_paths))) stop('An active source PDF is missing.')
source_fingerprints <- tools::md5sum(source_paths)
notes <- c('# H4 literature sound-variable substitutions', paste('Run UTC:',format(Sys.time(),tz='UTC',usetz=TRUE)),
  paste('Input MD5:',unname(input_fingerprint)),
  paste('Code MD5:',basename(code_paths),unname(code_fingerprints)),
  paste('Source PDF MD5:',basename(source_paths),unname(source_fingerprints)))
sounds <- H4_SOUND$spectrum_substitutions(names(epochs_walk))
if (!length(sounds)) stop('No measured sound substitutions are available.')
results <- lapply(sounds,function(sound) {
  block <- H4_RODRIGUES$run(epochs_walk,lme_control,sound)$results
  block$sound_variable <- sound$column
  block$test <- paste0(block$test,' [',sound$column,']')
  block
})
notes <- c(notes,paste('Sound substitutions:',length(sounds)),
  '- Same Rodrigues outcomes, max/SD summaries, scaling, formula, random effect and Wald-z inference as the primary sound block.',
  '- The selected replacement sound column occupies the noise predictor slots; no dBA covariate is retained.',
  '- No invented threshold, median split, environment-derived sound label or alternative model family.',
  '- These are user-requested exposure substitutions, not claims that the source paper tested these spectral/YAMNet variables.')
if (!identical(unname(tools::md5sum(code_paths)),unname(code_fingerprints))) stop('Code changed during run.')
if (!identical(unname(tools::md5sum(input)),unname(input_fingerprint))) stop('Input changed during run.')
if (!identical(unname(tools::md5sum(source_paths)),unname(source_fingerprints))) stop('Source PDFs changed during run.')
H4_IO$write(results,notes,root,TRUE)
