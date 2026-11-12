source("scripts/statistical_analysis/library/Paper3_common.R")
source("scripts/statistical_analysis/library/H4_sound_literature_helpers.R")
suppressPackageStartupMessages(library(nlme))
root <- resolve_project_root()
epochs <- H4_IO$read_epochs(root)
cells <- h4_walk_cells(epochs)
cells$dba_z <- H4_UTIL$z(cells$dba)
cells$urban <- as.integer(cells$PhaseID == "WalkU")
cells$ParticipantID <- factor(cells$ParticipantID)
med <- function(ph, col) {
  median(tapply(cells[[col]][cells$PhaseID == ph],
                cells$ParticipantID[cells$PhaseID == ph],
                median, na.rm = TRUE), na.rm = TRUE)
}
cat("n=", nrow(cells), "\n")
cat("UTCI medG", med("WalkG", "utci"), "medU", med("WalkU", "utci"), "\n")
cat("dBA medG", med("WalkG", "dba"), "medU", med("WalkU", "dba"), "\n")
fit <- nlme::lme(thermal_comfort ~ dba_z + urban, random = ~ 1 | ParticipantID,
                 data = cells, method = "REML", na.action = na.fail,
                 control = nlme::lmeControl(opt = "optim"))
print(summary(fit)$tTable)
g <- cells$thermal_comfort[cells$PhaseID == "WalkG"]
u <- cells$thermal_comfort[order(cells$ParticipantID[cells$PhaseID == "WalkU"])]
# align by participant
w <- reshape(cells[, c("ParticipantID", "PhaseID", "thermal_comfort", "dba", "utci")],
             idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
tt <- t.test(w$thermal_comfort.WalkU, w$thermal_comfort.WalkG, paired = TRUE)
cat("paired t thermal p=", tt$p.value, "est=", unname(tt$estimate), "\n")
cat("median of 11 WalkG utci", median(w$utci.WalkG), "WalkU", median(w$utci.WalkU), "\n")
cat("median of 11 WalkG dba", median(w$dba.WalkG), "WalkU", median(w$dba.WalkU), "\n")
cat("mean WalkG utci", mean(w$utci.WalkG), "WalkU", mean(w$utci.WalkU), "\n")
cat("mean WalkG dba", mean(w$dba.WalkG), "WalkU", mean(w$dba.WalkU), "\n")
# 10 s medians of participant medians
ep <- epochs[epochs$PhaseID %in% c("WalkG", "WalkU"), ]
pm <- do.call(rbind, lapply(split(ep, list(ep$ParticipantID, ep$PhaseID), drop = TRUE), function(d) {
  data.frame(ParticipantID = d$ParticipantID[1], PhaseID = d$PhaseID[1],
             utci = median(d$ucm_UTCI, na.rm = TRUE),
             dba_med = median(d$ucm_SND_dBA, na.rm = TRUE),
             dba_em = H4_UTIL$energy_mean_db(d$ucm_SND_dBA))
}))
for (ph in c("WalkG", "WalkU")) {
  x <- pm[pm$PhaseID == ph, ]
  cat(ph, "median-of-person-median UTCI", median(x$utci),
      "dBA_med", median(x$dba_med), "dBA_em", median(x$dba_em), "\n")
}

