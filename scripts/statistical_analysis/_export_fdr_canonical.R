r <- read.csv(
  "output/statistical_analysis/results/_fdr_scan_hits_report.csv",
  stringsAsFactors = FALSE
)
cat(
  "coeff_rows",
  sum(grepl("coefficients", r$file, fixed = TRUE)),
  "exposure_rows",
  sum(grepl("exposure_tests", r$file, fixed = TRUE)),
  "\n"
)

u <- read.csv(
  "output/statistical_analysis/results/_fdr_scan_hits_unique.csv",
  stringsAsFactors = FALSE
)
u <- u[order(u$q_FDR, u$p, na.last = TRUE), ]

# Canonical: one row per analysis slice (drop wind mirror duplicate paths)
u$variant_canon <- sub("/wind_aws_le_5ms$", "", u$analysis_variant)
u$key2 <- paste(
  u$variant_canon,
  u$sound_variable,
  u$outcome,
  u$term_contrast,
  u$utci_stratum,
  u$epoch_sec,
  sep = "|"
)
c <- u[!duplicated(u$key2), ]
c <- c[order(c$q_FDR, c$p, na.last = TRUE), ]
write.csv(c, "output/statistical_analysis/results/_fdr_scan_hits_canonical.csv", row.names = FALSE)

cat("canonical_hits", nrow(c), "\n")
cat("term_type:\n")
print(table(c$term_type))
cat("variants:\n")
print(sort(table(c$variant_canon), decreasing = TRUE))

# sound-relevant subset
sound_terms <- c$term_type %in% c("sound", "thermal_x_sound", "thermal")
cat("sound_thermal_term_hits", sum(sound_terms), "\n")

# top 10
top10 <- head(c, 10)
write.csv(top10, "output/statistical_analysis/results/_fdr_top10.csv", row.names = FALSE)

# compact full list for markdown
short_file <- function(x) sub("^.*/output/statistical_analysis/results/", "results/", x)
md <- data.frame(
  analysis_variant = c$variant_canon,
  file = vapply(c$file, short_file, character(1)),
  outcome = c$outcome,
  term_contrast = c$term_contrast,
  term_type = c$term_type,
  sound_variable = c$sound_variable,
  stratum = c$utci_stratum,
  epoch_sec = c$epoch_sec,
  p = signif(c$p, 3),
  q_FDR = signif(c$q_FDR, 3),
  n_participants = c$n_participants,
  inference_eligible = c$inference_eligible,
  thermal_x_sound = c$thermal_x_sound,
  stringsAsFactors = FALSE
)
write.csv(md, "output/statistical_analysis/results/_fdr_canonical_compact.csv", row.names = FALSE)
cat("Wrote canonical", nrow(md), "rows\n")
