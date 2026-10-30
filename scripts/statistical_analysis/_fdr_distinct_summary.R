c <- read.csv("output/statistical_analysis/results/_fdr_scan_hits_canonical.csv", stringsAsFactors = FALSE)
c <- c[order(c$q_FDR, c$p, na.last = TRUE), ]

cat("=== DISTINCT FINDINGS (collapse 23 sound substitutes) ===\n")
c$finding <- paste(c$variant_canon, c$outcome, c$term_contrast, c$term_type, sep = " | ")
f <- c[!duplicated(c$finding), ]
f <- f[order(f$q_FDR, f$p, na.last = TRUE), ]
write.csv(f, "output/statistical_analysis/results/_fdr_distinct_findings.csv", row.names = FALSE)
cat("distinct_findings", nrow(f), "\n\n")
print(f[, c("q_FDR", "p", "variant_canon", "outcome", "term_contrast", "term_type", "n_participants")])

cat("\n=== phaseavg sound hits ===\n")
pa <- c[grepl("phaseavg", c$variant_canon), ]
print(table(pa$term_type))
print(pa[, c("q_FDR", "outcome", "term_contrast", "term_type", "sound_variable")])

cat("\n=== epoch breakdown ===\n")
print(table(c$variant_canon))
