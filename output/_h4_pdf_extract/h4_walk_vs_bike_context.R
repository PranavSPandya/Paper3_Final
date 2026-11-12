library(lme4)
library(lmerTest)

d <- read.csv("output/merged_all_11participants_8min.csv")
em <- function(x) {
  x <- x[is.finite(x)]
  10 * log10(mean(10^(x / 10)))
}

keep <- d$PhaseID %in% c("WalkU", "WalkG", "BikeU", "BikeG")
d <- d[keep, ]
spl <- split(d, list(d$ParticipantID, d$PhaseID), drop = TRUE)
bout <- do.call(rbind, lapply(spl, function(g) {
  data.frame(
    ParticipantID = g$ParticipantID[1],
    PhaseID = g$PhaseID[1],
    dBA = em(g$ucm_SND_dBA),
    UTCI = mean(g$ucm_UTCI, na.rm = TRUE),
    th = g$questionnaire_thermal_comfort_1_5[1],
    ac = g$questionnaire_acoustic_comfort_1_5[1],
    stringsAsFactors = FALSE
  )
}))
rownames(bout) <- NULL

fit_mode <- function(mode_label, phases) {
  sub <- bout[bout$PhaseID %in% phases, ]
  sub$dBA_z <- as.numeric(scale(sub$dBA))
  sub$UTCI_z <- as.numeric(scale(sub$UTCI))
  sp <- suppressWarnings(cor.test(sub$th, sub$dBA, method = "spearman"))
  m <- lmer(th ~ dBA_z + (1 | ParticipantID), data = sub, REML = TRUE)
  s <- summary(m)$coefficients
  m2 <- lmer(th ~ dBA_z + UTCI_z + (1 | ParticipantID), data = sub, REML = TRUE)
  s2 <- summary(m2)$coefficients
  urb <- ifelse(sub$PhaseID %in% c("WalkU", "BikeU"), 1, 0)
  sub$urban <- urb
  m3 <- lmer(th ~ dBA_z + urban + (1 | ParticipantID), data = sub, REML = TRUE)
  s3 <- summary(m3)$coefficients
  cat(sprintf(
    "\n=== %s n=%d ===\nSpearman th vs dBA rho=%.3f p=%.4g\nPeng th ~ dBA_z p=%.4g beta=%.3f\nJoint dBA p=%.4g UTCI p=%.4g\nUrban dummy leftover dBA p=%.4g\n",
    mode_label, nrow(sub), unname(sp$estimate), sp$p.value,
    s["dBA_z", "Pr(>|t|)"], s["dBA_z", "Estimate"],
    s2["dBA_z", "Pr(>|t|)"], s2["UTCI_z", "Pr(>|t|)"],
    s3["dBA_z", "Pr(>|t|)"]
  ))
}

fit_mode("WALK", c("WalkU", "WalkG"))
fit_mode("BIKE", c("BikeU", "BikeG"))
