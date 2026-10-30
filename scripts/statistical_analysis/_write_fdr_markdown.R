library(utils)
r <- read.csv(
  "output/statistical_analysis/results/_fdr_scan_hits_report.csv",
  stringsAsFactors = FALSE
)
r <- r[order(r$q_FDR, r$p, na.last = TRUE), ]
short <- function(x) sub("^.*/output/statistical_analysis/results/", "", x)

fmt <- function(x) format(signif(x, 4), scientific = TRUE)

lines <- c(
  "# H4 sound / thermal×sound FDR inventory (q < 0.05)",
  "",
  paste0("- Scanned **23** CSV files under `results/` (excludes `*Copy*` and `H4_timeseries_sound_30s`)."),
  paste0("- **Raw hit rows:** ", nrow(r), " (all coefficient rows meeting q_FDR<0.05 or FDR_significant)."),
  paste0("- **After deduping wind mirror paths:** 779 rows (`_fdr_scan_hits_canonical.csv`)."),
  paste0("- **Distinct findings (23 sound substitutes collapsed):** 36."),
  paste0("- **Stratum band contrasts (`H4_sound_band_contrasts.csv`):** 0 FDR hits."),
  paste0("- **`H4_sound_heat_sound_interaction_contrasts.csv`:** not present."),
  paste0("- **Primary `H4_phaseavg` / `H4_timeseries` UTCI×dBA interaction (`thermal_x_sound`):** 0 FDR hits."),
  paste0("- **`term_type=thermal_x_sound` or `sound` main in sound Eq1 CSVs:** 0 FDR hits."),
  "",
  "## Read this first (lowest q, distinct findings)",
  ""
)

f <- read.csv(
  "output/statistical_analysis/results/_fdr_distinct_findings.csv",
  stringsAsFactors = FALSE
)
f <- f[order(f$q_FDR, f$p, na.last = TRUE), ]
top10 <- head(f, 10)
for (i in seq_len(nrow(top10))) {
  row <- top10[i, ]
  lines <- c(
    lines,
    paste0(
      i, ". q=", fmt(row$q_FDR), " | ", row$variant_canon,
      " | ", row$outcome, " | ", row$term_contrast,
      " (", row$term_type, ")"
    )
  )
}

lines <- c(lines, "", "## Hit counts by analysis variant (canonical 779)", "")
c <- read.csv(
  "output/statistical_analysis/results/_fdr_scan_hits_canonical.csv",
  stringsAsFactors = FALSE
)
print_table <- sort(table(c$variant_canon), decreasing = TRUE)
for (nm in names(print_table)) {
  lines <- c(lines, paste0("- ", nm, ": ", print_table[[nm]]))
}

lines <- c(
  lines,
  "",
  "## Full canonical inventory (779 rows, sorted by q_FDR)",
  "",
  "| analysis_variant | file | sound_variable | outcome | term_contrast | term_type | stratum | epoch_sec | p | q_FDR | n_participants | inference_eligible | thermal_x_sound |",
  "|---|---|---|---|---|---|---|---:|---:|---:|---:|---|---|"
)

c <- c[order(c$q_FDR, c$p, na.last = TRUE), ]
for (i in seq_len(nrow(c))) {
  row <- c[i, ]
  lines <- c(
    lines,
    paste0(
      "| ", row$variant_canon,
      " | ", short(row$file),
      " | ", row$sound_variable,
      " | ", row$outcome,
      " | ", row$term_contrast,
      " | ", row$term_type,
      " | ", ifelse(is.na(row$utci_stratum), "", row$utci_stratum),
      " | ", ifelse(is.na(row$epoch_sec), "", row$epoch_sec),
      " | ", fmt(row$p),
      " | ", fmt(row$q_FDR),
      " | ", ifelse(is.na(row$n_participants), "", row$n_participants),
      " | ", row$inference_eligible,
      " | ", row$thermal_x_sound,
      " |"
    )
  )
}

writeLines(lines, "output/statistical_analysis/results/H4_sound_FDR_inventory.md")
cat("Wrote markdown", length(lines), "lines\n")
