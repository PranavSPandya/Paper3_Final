# Merged updated-H4 test for this campaign.
# Common core of Peng (comfort ~ sound/thermal)
# and Cureau (overall comfort from both domains), as one additive specification
# on Brussels bout means. No product term (that is original H4). No physiology,
# delay, spectrum, or occupancy. Walking bouts only (source design of the
# European outdoor studies). No cycling extension. No tram.
# Nominal p.
options(stringsAsFactors = FALSE)
entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(entry) || !file.exists(entry[1])) stop("Run with Rscript.")
entry <- normalizePath(entry[1], winslash = "/", mustWork = TRUE)
library_dir <- file.path(dirname(entry), "library")
for (path in file.path(library_dir, c("Paper3_common.R", "H4_sound_literature_helpers.R"))) {
  source(path, local = FALSE)
}
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
suppressPackageStartupMessages(library(nlme))
root <- resolve_project_root()
epochs <- H4_IO$read_epochs(root)

outcomes <- c("thermal_comfort", "acoustic_comfort", "overall_comfort")
fmt <- function(x) sprintf("%.3f", x)
fmtp <- function(p) {
  if (!is.finite(p)) return("NA")
  if (p < 0.0001) return("<0.0001")
  sprintf("%.3f", p)
}

rows <- list()
add_row <- function(..., std_error = NA_real_, df = NA_real_,
                    ci_lower = NA_real_, ci_upper = NA_real_) {
  rows[[length(rows) + 1L]] <<- data.frame(
    ..., std_error = std_error, df = df,
    ci_lower = ci_lower, ci_upper = ci_upper, stringsAsFactors = FALSE
  )
}

for (mode in c("walk")) {
  cells <- h4_walk_cells(epochs)
  cells$dba_z <- H4_UTIL$z(cells$dba)
  cells$utci_z <- H4_UTIL$z(cells$utci)
  cells$ParticipantID <- factor(cells$ParticipantID)

  for (oc in outcomes) {
    ok <- is.finite(cells[[oc]]) & is.finite(cells$dba_z) & is.finite(cells$utci_z)
    d <- cells[ok, , drop = FALSE]
    d$.y <- d[[oc]]
    fit <- tryCatch(
      nlme::lme(.y ~ dba_z + utci_z, random = ~ 1 | ParticipantID, data = d,
                method = "REML", na.action = na.fail, control = nlme::lmeControl(opt = "optim")),
      error = function(e) e
    )
    if (inherits(fit, "error")) {
      add_row(block = "measured_joint", scope = mode, outcome = oc, term = "FAIL",
              estimate = NA_real_, p = NA_real_, n = nrow(d), note = conditionMessage(fit))
      next
    }
    tt <- summary(fit)$tTable
    for (tm in c("dba_z", "utci_z")) {
      est <- unname(tt[tm, "Value"])
      se <- unname(tt[tm, "Std.Error"])
      dfv <- unname(tt[tm, "DF"])
      tcrit <- stats::qt(0.975, dfv)
      add_row(
        block = "measured_joint", scope = mode, outcome = oc, term = tm,
        estimate = est, p = unname(tt[tm, "p-value"]),
        n = nrow(d), note = "Y ~ dBA_z + UTCI_z + (1|participant)",
        std_error = se, df = dfv,
        ci_lower = est - tcrit * se, ci_upper = est + tcrit * se
      )
    }
  }

  per <- stats::aggregate(
    cells[, c("thermal_comfort", "acoustic_comfort", "overall_comfort")],
    by = list(ParticipantID = cells$ParticipantID),
    FUN = function(v) mean(v, na.rm = TRUE)
  )
  ct <- suppressWarnings(stats::cor.test(per$thermal_comfort, per$acoustic_comfort, method = "spearman"))
  add_row(
    block = "vote_coupling", scope = mode, outcome = "thermal_comfort ~ acoustic_comfort",
    term = "spearman", estimate = unname(ct$estimate), p = ct$p.value,
    n = sum(is.finite(per$thermal_comfort) & is.finite(per$acoustic_comfort)),
    note = "Spearman on 11 person-means (Peng TSV~ASV context)"
  )

  ok2 <- is.finite(cells$overall_comfort) & is.finite(cells$thermal_comfort) &
    is.finite(cells$acoustic_comfort)
  d2 <- cells[ok2, , drop = FALSE]
  d2$.y <- d2$overall_comfort
  fit2 <- tryCatch(
    nlme::lme(.y ~ thermal_comfort + acoustic_comfort, random = ~ 1 | ParticipantID,
              data = d2, method = "REML", na.action = na.fail,
              control = nlme::lmeControl(opt = "optim")),
    error = function(e) e
  )
  if (!inherits(fit2, "error")) {
    tt2 <- summary(fit2)$tTable
    for (tm in c("thermal_comfort", "acoustic_comfort")) {
      add_row(
        block = "cureau_votes", scope = mode, outcome = "overall_comfort", term = tm,
        estimate = unname(tt2[tm, "Value"]), p = unname(tt2[tm, "p-value"]),
        n = nrow(d2),
        note = "overall_comfort ~ thermal_comfort + acoustic_comfort + (1|participant)"
      )
    }
  }
}

out <- do.call(rbind, rows)
out_dir <- file.path(root, "output", "statistical_analysis", "results", "H4_updated_merged_test")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
write.csv(out, file.path(out_dir, "H4_updated_merged_tests.csv"), row.names = FALSE)

cat("\n=== measured joint: Y ~ dBA_z + UTCI_z ===\n")
mj <- out[out$block == "measured_joint", ]
for (mode in c("walk")) {
  cat("\n", toupper(mode), "\n", sep = "")
  cat(sprintf("%-18s %12s %10s %12s %10s\n", "outcome", "dBA", "p", "UTCI", "p"))
  for (oc in outcomes) {
    a <- mj[mj$scope == mode & mj$outcome == oc & mj$term == "dba_z", ]
    b <- mj[mj$scope == mode & mj$outcome == oc & mj$term == "utci_z", ]
    cat(sprintf(" %-18s %12s %10s %12s %10s\n", oc,
                fmt(a$estimate), fmtp(a$p), fmt(b$estimate), fmtp(b$p)))
  }
}
cat("\n=== vote coupling Spearman ===\n")
print(out[out$block == "vote_coupling", c("scope", "estimate", "p")])
cat("\n=== Cureau analogue: overall ~ thermal_vote + acoustic_vote ===\n")
print(out[out$block == "cureau_votes", c("scope", "term", "estimate", "p")])
cat("\nWrote", file.path(out_dir, "H4_updated_merged_tests.csv"), "\n")
