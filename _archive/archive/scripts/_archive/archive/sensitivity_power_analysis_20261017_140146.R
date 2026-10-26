# ==============================================================================
# SCRIPT: sensitivity_power_analysis.R
# PURPOSE: Exact reproducible sensitivity power analysis for Paper 3 (N = 11).
#          Calculates minimum detectable within-person effect size (Cohen's d_z)
#          across statistical power levels (80%, 85%, 90%) at alpha = 0.05.
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
})

WD <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
PROJECT_ROOT <- if (basename(WD) == "scripts") dirname(WD) else WD
OUT_DIR <- file.path(PROJECT_ROOT, "output", "statistical_analysis")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

# 1. Base R exact analytical power calculation ---------------------------------
# For within-subject (repeated-measures / paired) comparisons with N = 11:
calc_80 <- power.t.test(n = 11, power = 0.80, sig.level = 0.05, type = "paired", alternative = "two.sided")
calc_85 <- power.t.test(n = 11, power = 0.85, sig.level = 0.05, type = "paired", alternative = "two.sided")
calc_90 <- power.t.test(n = 11, power = 0.90, sig.level = 0.05, type = "paired", alternative = "two.sided")

power_benchmarks <- data.frame(
  N_Participants = 11,
  Design = "Within-Subject (Paired / Repeated Measures)",
  Alpha = 0.05,
  Alternative = "Two-sided",
  Target_Power = c(0.80, 0.85, 0.90),
  Min_Detectable_Effect_dz = round(c(calc_80$delta, calc_85$delta, calc_90$delta), 4),
  Interpretation = c(
    "Large effect (d_z >= 0.94) reliably detectable at standard 80% power threshold",
    "Large effect (d_z >= 1.01) reliably detectable at 85% power",
    "Large-to-very-large effect (d_z >= 1.10) reliably detectable at 90% power"
  ),
  stringsAsFactors = FALSE
)

csv_path <- file.path(OUT_DIR, "Sensitivity_Power_Analysis_Summary.csv")
write.csv(power_benchmarks, csv_path, row.names = FALSE)
cat(sprintf("Saved sensitivity power summary to: %s\n", csv_path))

# 2. Continuous Power Curve (Effect Size d_z from 0.2 to 2.0) -------------------
d_seq <- seq(0.2, 2.0, by = 0.02)
power_curve_df <- data.frame(
  Effect_Size_dz = d_seq,
  Power = sapply(d_seq, function(d) {
    power.t.test(n = 11, d = d, sig.level = 0.05, type = "paired", alternative = "two.sided")$power
  })
)

# Plot Sensitivity Power Curve
p <- ggplot(power_curve_df, aes(x = Effect_Size_dz, y = Power)) +
  geom_line(color = "#1d3557", linewidth = 1.2) +
  geom_hline(yintercept = 0.80, linetype = "dashed", color = "#c0392b", linewidth = 0.8) +
  geom_vline(xintercept = calc_80$delta, linetype = "dashed", color = "#c0392b", linewidth = 0.8) +
  annotate("point", x = calc_80$delta, y = 0.80, color = "#c0392b", size = 3.5) +
  annotate("text", x = calc_80$delta + 0.05, y = 0.77,
           label = sprintf("Min detectable d_z = %.2f (Power = 80%%)", calc_80$delta),
           hjust = 0, fontface = "bold", color = "#c0392b") +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
  scale_x_continuous(limits = c(0.2, 2.0), breaks = seq(0.2, 2.0, by = 0.2)) +
  labs(
    title = "Paper 3 Sensitivity Power Analysis (N = 11, Within-Subject Design)",
    subtitle = "Two-sided paired design at alpha = 0.05. Minimum detectable effect size d_z = 0.94.",
    x = "Within-Subject Effect Size (Cohen's d_z)",
    y = "Statistical Power (1 - Beta)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

fig_path <- file.path(OUT_DIR, "Sensitivity_Power_Curve.png")
ggsave(fig_path, plot = p, width = 8, height = 5, dpi = 300)
cat(sprintf("Saved sensitivity power curve figure to: %s\n", fig_path))
cat("SUCCESS: sensitivity power script finished.\n")
