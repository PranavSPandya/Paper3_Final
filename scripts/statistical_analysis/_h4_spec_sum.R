d <- read.csv("output/statistical_analysis/results/H4_sound_literature_test_spectrum/H4_sound_literature_tests_spectrum.csv", check.names = FALSE)
th <- d[d$outcome == "thermal_comfort" & d$term %in% c("spearman_thermal_spectrum", "peng_tsv_laeq", "dba_z"),
        c("paper", "sound_variable", "term", "estimate", "p", "source_rule_met")]
th <- th[order(th$p), ]
cat("--- thermal p<0.05 ---\n")
print(th[is.finite(th$p) & th$p < 0.05, ], row.names = FALSE)
cat("\n--- vehicle_proportion all ---\n")
v <- d[d$sound_variable == "vehicle_proportion", c("paper", "term", "outcome", "estimate", "p", "source_rule_met")]
print(v, row.names = FALSE)
cat("\n--- all source_rule_met TRUE ---\n")
h <- d[d$source_rule_met %in% TRUE, c("paper", "sound_variable", "term", "outcome", "estimate", "p")]
h <- h[order(h$p), ]
print(h, row.names = FALSE)
unlink("scripts/statistical_analysis/_h4_spec_sum.R")
