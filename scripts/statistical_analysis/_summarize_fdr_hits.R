r <- read.csv(
  "output/statistical_analysis/results/_fdr_scan_hits_report.csv",
  stringsAsFactors = FALSE
)
r$key <- paste(
  sub("/wind_aws_le_5ms$", "", r$analysis_variant),
  r$sound_variable,
  r$outcome,
  r$term_contrast,
  r$utci_stratum,
  r$epoch_sec,
  sep = "|"
)
u <- r[!duplicated(r$key), ]
u <- u[order(u$q_FDR, u$p, na.last = TRUE), ]
write.csv(u, "output/statistical_analysis/results/_fdr_scan_hits_unique.csv", row.names = FALSE)
cat("unique_hits", nrow(u), "\n")
cat("thermal_x_sound", sum(u$thermal_x_sound, na.rm = TRUE), "\n")
if ("term_type" %in% names(u)) print(sort(table(u$term_type), decreasing = TRUE))
cat("sound_main_hits", sum(u$term_type == "sound", na.rm = TRUE), "\n")
cat("thermal_x_sound_type", sum(u$term_type == "thermal_x_sound", na.rm = TRUE), "\n")
print(head(u[, intersect(names(u), c("q_FDR", "p", "analysis_variant", "sound_variable", "outcome", "term_contrast", "term_type", "inference_eligible"))], 10))
print(sort(table(sub("/wind_aws_le_5ms$", "", u$analysis_variant)), decreasing = TRUE))
