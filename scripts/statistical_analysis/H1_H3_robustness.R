#!/usr/bin/env Rscript
# Expanded to H1–H5. This file keeps the original command working.
# Output: output/statistical_analysis/results/Robustness_check/
args <- grep('^--file=', commandArgs(FALSE), value = TRUE)
if (!length(args)) stop('Run as Rscript scripts/statistical_analysis/H1_H3_robustness.R')
entry_dir <- dirname(normalizePath(sub('^--file=', '', args[1L]), mustWork = TRUE))
source(file.path(entry_dir, 'H1_H5_robustness.R'), local = FALSE)
