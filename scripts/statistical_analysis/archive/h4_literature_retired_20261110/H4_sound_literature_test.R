# H4 source tests with available matching outcomes/model structure; unavailable methods are skipped.
options(stringsAsFactors=FALSE)
entry <- sub('^--file=','',grep('^--file=',commandArgs(FALSE),value=TRUE))
if (!length(entry) || !file.exists(entry[1])) stop('Run this file with Rscript.')
entry <- normalizePath(entry[1],winslash='/',mustWork=TRUE)
library_dir <- file.path(dirname(entry),'library')
code_paths <- c(entry,file.path(library_dir,c('Paper3_common.R','H4_sound_literature_helpers.R')))
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
notes <- c('# H4 literature tests: source methods with explicitly mapped variables', paste('Run UTC:',format(Sys.time(),tz='UTC',usetz=TRUE)),
  paste('Input MD5:',unname(input_fingerprint)),
  paste('Code MD5:',basename(code_paths),unname(code_fingerprints)),
  paste('Source PDF MD5:',basename(source_paths),unname(source_fingerprints)))
results <- list(rodrigues = H4_RODRIGUES$run(epochs_walk, lme_control)$results)
results$rodrigues$sound_variable <- 'ucm_SND_dBA'
notes <- c(notes, '- Active: Rodrigues 2026 Noise block only (trip max/SD of ucm_SND_dBA → physiology summaries).')
if (!identical(unname(tools::md5sum(code_paths)),unname(code_fingerprints))) stop('Code changed during run.')
if (!identical(unname(tools::md5sum(input)),unname(input_fingerprint))) stop('Input changed during run.')
if (!identical(unname(tools::md5sum(source_paths)),unname(source_fingerprints))) stop('Source PDFs changed during run.')
H4_IO$write(results,notes,root,FALSE)
