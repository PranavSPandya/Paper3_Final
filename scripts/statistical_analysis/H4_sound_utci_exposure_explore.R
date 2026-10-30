# H4 exploratory: sound & UTCI exposure by participant × phase (matched 8-min rows).
# Cohort selection for supplementary H4 sound testing — not primary Eq1–7 pipeline.
# Run: Rscript scripts/statistical_analysis/H4_sound_utci_exposure_explore.R
# Optional: --root=D:/path/to/Paper3_Final

options(stringsAsFactors = FALSE)

participants <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
phases <- c("BikeU", "WalkU", "BikeG", "WalkG")

# --- Threshold definitions (documented in H4_sound_utci_thresholds.txt) ---
# Agreed exploratory bands: 55–65, 65–75, >75 dBA (below 55 kept as reference band).
SOUND_BAND_55 <- 55
SOUND_BAND_65 <- 65
SOUND_BAND_75 <- 75
SOUND_HIGH_DBA <- SOUND_BAND_65
# UTCI heat-stress scale (Blazejczyk et al., 2013 / UTCI-FEBS):
#   9–26 °C no thermal stress; 26–32 °C moderate heat stress; 32–38 °C strong;
#   38–46 °C very strong; >46 °C extreme. Strata A/B/C use cutpoints at 26 and 32 °C.
UTCI_HIGH_LIT_C <- 26
UTCI_STRONG_HEAT_C <- 32
UTCI_STRATA <- c(
  A = "A_UTCI_lt26",
  B = "B_UTCI_26_to_32_moderate",
  C = "C_UTCI_ge32_strong_plus"
)
# Supplementary H4 sound subset: enough co-exposure of loud + thermally stressful epochs.
SUGGEST_MIN_ROWS <- 40L
SUGGEST_MIN_PCT_SOUND <- 20
SUGGEST_MIN_PCT_UTCI <- 20
SUGGEST_MIN_PCT_BOTH <- 5

sound_band_breaks <- c(-Inf, SOUND_BAND_55, SOUND_BAND_65, SOUND_BAND_75, Inf)
sound_band_labels <- c("<55", "55–65", "65–75", ">75")

arg <- commandArgs(trailingOnly = TRUE)
root_arg <- sub("^--root=", "", grep("^--root=", arg, value = TRUE))

find_root <- function() {
  if (length(root_arg)) return(normalizePath(root_arg[1], mustWork = TRUE))
  script_arg <- grep("^--file=", commandArgs(), value = TRUE)
  pos <- if (length(script_arg)) {
    dirname(normalizePath(sub("^--file=", "", script_arg[1]), mustWork = TRUE))
  } else {
    normalizePath(getwd(), mustWork = TRUE)
  }
  for (i in 1:6) {
    if (file.exists(file.path(pos, "output", "merged_all_11participants_8min.csv"))) return(pos)
    nextpos <- dirname(pos)
    if (nextpos == pos) break
    pos <- nextpos
  }
  stop("Cannot locate Paper3_Final/output/merged_all_11participants_8min.csv. Use --root=...")
}

root <- find_root()
input <- file.path(root, "output", "merged_all_11participants_8min.csv")
out_dir <- file.path(root, "output", "statistical_analysis", "results", "H4_exploratory_sound_utci")
fig_dir <- file.path(root, "output", "Figures", "H4_exploratory_sound_utci")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

needed <- c("ParticipantID", "PhaseID", "Datetime", "ucm_SND_dBA", "ucm_UTCI")
header <- names(read.csv(input, nrows = 0, check.names = FALSE))
missing <- setdiff(needed, header)
if (length(missing)) stop("Absent required input columns: ", paste(missing, collapse = ", "))

cls <- ifelse(header %in% needed, "character", "NULL")
raw <- read.csv(input, check.names = FALSE, colClasses = cls, na.strings = c("", "NA", "NaN", "null"))
for (nm in c("ucm_SND_dBA", "ucm_UTCI")) raw[[nm]] <- suppressWarnings(as.numeric(raw[[nm]]))

d <- raw[raw$ParticipantID %in% participants & raw$PhaseID %in% phases, , drop = FALSE]
d$Datetime <- as.POSIXct(
  d$Datetime, tz = "UTC",
  tryFormats = c("%Y-%m-%d %H:%M:%OS", "%Y-%m-%dT%H:%M:%OS")
)
d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), , drop = FALSE]

# Phase-specific UTCI tertile (relative high thermal exposure within route type).
utci_tertile_by_phase <- tapply(
  d$ucm_UTCI[is.finite(d$ucm_UTCI)],
  d$PhaseID[is.finite(d$ucm_UTCI)],
  quantile, probs = 2 / 3, na.rm = TRUE, names = FALSE
)
d$utci_tertile_cut <- utci_tertile_by_phase[d$PhaseID]

d$high_sound <- is.finite(d$ucm_SND_dBA) & d$ucm_SND_dBA >= SOUND_HIGH_DBA
d$high_utci_lit <- is.finite(d$ucm_UTCI) & d$ucm_UTCI >= UTCI_HIGH_LIT_C
d$high_utci_tert <- is.finite(d$ucm_UTCI) & is.finite(d$utci_tertile_cut) & d$ucm_UTCI >= d$utci_tertile_cut
d$high_utci <- d$high_utci_lit
d$both_high <- d$high_sound & d$high_utci
d$both_high_strong_utci <- d$high_sound & is.finite(d$ucm_UTCI) & d$ucm_UTCI >= UTCI_STRONG_HEAT_C

d$sound_band <- cut(d$ucm_SND_dBA, breaks = sound_band_breaks, labels = sound_band_labels, right = FALSE)

d$utci_stratum <- ifelse(
  !is.finite(d$ucm_UTCI), NA_character_,
  ifelse(
    d$ucm_UTCI < UTCI_HIGH_LIT_C, UTCI_STRATA[["A"]],
    ifelse(d$ucm_UTCI < UTCI_STRONG_HEAT_C, UTCI_STRATA[["B"]], UTCI_STRATA[["C"]])
  )
)
d$utci_stratum <- factor(d$utci_stratum, levels = unname(UTCI_STRATA))

strata_dba_tab <- as.data.frame(
  table(
    ParticipantID = d$ParticipantID,
    PhaseID = d$PhaseID,
    utci_stratum = d$utci_stratum,
    sound_band = d$sound_band,
    useNA = "no"
  ),
  stringsAsFactors = FALSE
)
names(strata_dba_tab)[names(strata_dba_tab) == "Freq"] <- "n_epochs"
strata_dba_tab$sound_band <- factor(strata_dba_tab$sound_band, levels = sound_band_labels)
strata_dba_tab$utci_stratum <- factor(strata_dba_tab$utci_stratum, levels = unname(UTCI_STRATA))

strata_den <- aggregate(n_epochs ~ ParticipantID + PhaseID + utci_stratum, data = strata_dba_tab, FUN = sum)
names(strata_den)[4] <- "n_stratum_total"
strata_dba_tab <- merge(strata_dba_tab, strata_den, by = c("ParticipantID", "PhaseID", "utci_stratum"), all.x = TRUE)
strata_dba_tab$pct_within_stratum <- 100 * strata_dba_tab$n_epochs / strata_dba_tab$n_stratum_total

strata_dba_csv <- file.path(out_dir, "H4_sound_dba_bands_by_utci_stratum_participant_phase.csv")
write.csv(strata_dba_tab, strata_dba_csv, row.names = FALSE)

d$coexp_loud_in_B <- d$high_sound & d$utci_stratum == UTCI_STRATA[["B"]]
d$coexp_loud_in_C <- d$high_sound & d$utci_stratum == UTCI_STRATA[["C"]]

coexp_pp <- aggregate(
  cbind(
    n_rows_fin = as.integer(is.finite(d$ucm_SND_dBA) & is.finite(d$ucm_UTCI)),
    n_utci_B = as.integer(d$utci_stratum == UTCI_STRATA[["B"]]),
    n_utci_C = as.integer(d$utci_stratum == UTCI_STRATA[["C"]]),
    n_loud_B = as.integer(d$coexp_loud_in_B),
    n_loud_C = as.integer(d$coexp_loud_in_C)
  ),
  by = list(ParticipantID = d$ParticipantID, PhaseID = d$PhaseID),
  FUN = sum
)
coexp_pp$pct_loud_given_B <- ifelse(coexp_pp$n_utci_B > 0L, 100 * coexp_pp$n_loud_B / coexp_pp$n_utci_B, NA_real_)
coexp_pp$pct_loud_given_C <- ifelse(coexp_pp$n_utci_C > 0L, 100 * coexp_pp$n_loud_C / coexp_pp$n_utci_C, NA_real_)
coexp_pp$pct_epochs_loud_and_B <- 100 * coexp_pp$n_loud_B / coexp_pp$n_rows_fin
coexp_pp$pct_epochs_loud_and_C <- 100 * coexp_pp$n_loud_C / coexp_pp$n_rows_fin
coexp_pp <- coexp_pp[order(coexp_pp$ParticipantID, match(coexp_pp$PhaseID, phases)), , drop = FALSE]

coexp_csv <- file.path(out_dir, "H4_coexposure_dba70_utci_B_vs_C_by_participant_phase.csv")
write.csv(coexp_pp, coexp_csv, row.names = FALSE)

cohort_strata <- aggregate(n_epochs ~ utci_stratum + sound_band, data = strata_dba_tab, FUN = sum)
cohort_den <- aggregate(n_epochs ~ utci_stratum, data = cohort_strata, FUN = sum)
names(cohort_den)[2] <- "n_stratum_total"
cohort_strata <- merge(cohort_strata, cohort_den, by = "utci_stratum")
cohort_strata$pct_within_stratum <- 100 * cohort_strata$n_epochs / cohort_strata$n_stratum_total
cohort_strata_csv <- file.path(out_dir, "H4_sound_dba_bands_by_utci_stratum_cohort.csv")
write.csv(cohort_strata, cohort_strata_csv, row.names = FALSE)

n_loud_B_cohort <- sum(d$coexp_loud_in_B, na.rm = TRUE)
n_loud_C_cohort <- sum(d$coexp_loud_in_C, na.rm = TRUE)
n_B_cohort <- sum(d$utci_stratum == UTCI_STRATA[["B"]], na.rm = TRUE)
n_C_cohort <- sum(d$utci_stratum == UTCI_STRATA[["C"]], na.rm = TRUE)
pct_loud_given_B <- 100 * n_loud_B_cohort / n_B_cohort
pct_loud_given_C <- 100 * n_loud_C_cohort / n_C_cohort

dom_B <- aggregate(n_loud_B ~ ParticipantID, data = coexp_pp, FUN = sum)
dom_C <- aggregate(n_loud_C ~ ParticipantID, data = coexp_pp, FUN = sum)
names(dom_B)[2] <- "n_loud_utci_B_epochs"
names(dom_C)[2] <- "n_loud_utci_C_epochs"
dom <- merge(dom_B, dom_C, by = "ParticipantID", all = TRUE)
dom$n_loud_utci_B_epochs[is.na(dom$n_loud_utci_B_epochs)] <- 0L
dom$n_loud_utci_C_epochs[is.na(dom$n_loud_utci_C_epochs)] <- 0L
dom <- dom[order(-dom$n_loud_utci_B_epochs, -dom$n_loud_utci_C_epochs), , drop = FALSE]
dom_csv <- file.path(out_dir, "H4_coexposure_dba70_utci_B_vs_C_dominance_by_participant.csv")
write.csv(dom, dom_csv, row.names = FALSE)

coexp_summary_txt <- file.path(out_dir, "H4_coexposure_dba70_utci_B_vs_C_summary.txt")
writeLines(
  c(
    "Co-exposure: ucm_SND_dBA >= 70 within UTCI stratum (matched 10 s epochs, core cohort)",
    paste0("Cohort rows: ", nrow(d)),
    "",
    "UTCI strata (Blazejczyk / UTCI-FEBS heat bands):",
    paste0("  A: UTCI < ", UTCI_HIGH_LIT_C, " degC (no thermal stress, 9–26 degC band)"),
    paste0("  B: ", UTCI_HIGH_LIT_C, " <= UTCI < ", UTCI_STRONG_HEAT_C, " degC (moderate heat stress)"),
    paste0("  C: UTCI >= ", UTCI_STRONG_HEAT_C, " degC (strong + very strong + extreme heat stress)"),
    "",
    paste0("Epochs in stratum B: ", n_B_cohort, " (", sprintf("%.1f", 100 * n_B_cohort / nrow(d)), "% of rows)"),
    paste0("Epochs in stratum C: ", n_C_cohort, " (", sprintf("%.1f", 100 * n_C_cohort / nrow(d)), "% of rows)"),
    "",
    paste0("Loud (>=", SOUND_HIGH_DBA, " dBA) AND stratum B: ", n_loud_B_cohort,
           " epochs (", sprintf("%.1f", pct_loud_given_B), "% of B epochs; ",
           sprintf("%.1f", 100 * n_loud_B_cohort / nrow(d)), "% of all rows)"),
    paste0("Loud (>=", SOUND_HIGH_DBA, " dBA) AND stratum C: ", n_loud_C_cohort,
           " epochs (", sprintf("%.1f", pct_loud_given_C), "% of C epochs; ",
           sprintf("%.1f", 100 * n_loud_C_cohort / nrow(d)), "% of all rows)"),
    "",
    paste0("Participant-phases with >=1 loud+B epoch: ", sum(coexp_pp$n_loud_B > 0L), " of ", nrow(coexp_pp)),
    paste0("Participant-phases with >=1 loud+C epoch: ", sum(coexp_pp$n_loud_C > 0L), " of ", nrow(coexp_pp)),
    "",
    "Top participants by loud+thermal co-exposure epoch count (see dominance CSV):",
    paste0("  B stratum leaders: ", paste(head(dom$ParticipantID[order(-dom$n_loud_utci_B_epochs)], 5L), collapse = ", ")),
    paste0("  C stratum leaders: ", paste(head(dom$ParticipantID[order(-dom$n_loud_utci_C_epochs)], 5L), collapse = ", "))
  ),
  coexp_summary_txt
)

pct_true <- function(x) 100 * mean(x, na.rm = TRUE)

summ <- aggregate(
  cbind(
    n_rows = rep(1, nrow(d)),
    n_sound_fin = as.integer(is.finite(d$ucm_SND_dBA)),
    n_utci_fin = as.integer(is.finite(d$ucm_UTCI)),
    pct_high_sound = d$high_sound,
    pct_high_UTCI = d$high_utci,
    pct_high_UTCI_tertile = d$high_utci_tert,
    pct_both_high = d$both_high
  ),
  by = list(ParticipantID = d$ParticipantID, PhaseID = d$PhaseID),
  FUN = function(x) if (is.logical(x)) pct_true(x) else sum(x)
)

summ$suggested_for_H4_sound <- with(
  summ,
  n_rows >= SUGGEST_MIN_ROWS &
    pct_high_sound >= SUGGEST_MIN_PCT_SOUND &
    pct_high_UTCI >= SUGGEST_MIN_PCT_UTCI &
    pct_both_high >= SUGGEST_MIN_PCT_BOTH
)
summ$suggested_for_H4_sound <- ifelse(summ$suggested_for_H4_sound, "Y", "N")

summ <- summ[order(summ$ParticipantID, match(summ$PhaseID, phases)), , drop = FALSE]

pp_any_both_26 <- aggregate(
  both_high ~ ParticipantID + PhaseID, data = d,
  FUN = function(x) any(x, na.rm = TRUE)
)
pp_any_both_32 <- aggregate(
  both_high_strong_utci ~ ParticipantID + PhaseID, data = d,
  FUN = function(x) any(x, na.rm = TRUE)
)
n_pp_both_26 <- sum(pp_any_both_26$both_high)
n_pp_both_32 <- sum(pp_any_both_32$both_high_strong_utci)

csv_out <- file.path(out_dir, "H4_sound_utci_exposure_by_participant_phase.csv")
write.csv(summ, csv_out, row.names = FALSE)

part_summ <- aggregate(
  cbind(pct_high_sound, pct_high_UTCI, pct_both_high) ~ ParticipantID,
  data = summ,
  FUN = mean, na.rm = TRUE
)
part_summ$n_phases_suggested <- vapply(
  part_summ$ParticipantID,
  function(pid) sum(summ$suggested_for_H4_sound[summ$ParticipantID == pid] == "Y"),
  integer(1)
)
part_summ$suggested_participant <- ifelse(part_summ$n_phases_suggested >= 1L, "Y", "N")
part_csv <- file.path(out_dir, "H4_sound_utci_exposure_by_participant.csv")
write.csv(part_summ, part_csv, row.names = FALSE)

epochs_both <- d[d$both_high, c("ParticipantID", "PhaseID", "Datetime", "ucm_SND_dBA", "ucm_UTCI")]
epochs_both <- epochs_both[order(epochs_both$ParticipantID, epochs_both$PhaseID, epochs_both$Datetime), ]
epochs_csv <- file.path(out_dir, "H4_epochs_both_high_sound_utci.csv")
write.csv(epochs_both, epochs_csv, row.names = FALSE)

threshold_txt <- file.path(out_dir, "H4_sound_utci_thresholds.txt")
writeLines(
  c(
    "H4 exploratory sound × UTCI exposure thresholds",
    paste0("Input: ", normalizePath(input, winslash = "/")),
    paste0("Rows (core cohort): ", nrow(d)),
    "",
    paste0("high_sound: ucm_SND_dBA >= ", SOUND_HIGH_DBA, " dBA (traffic/annoyance band; aligns with user figure bands from 70 dBA upward)"),
    paste0("high_UTCI (primary): ucm_UTCI >= ", UTCI_HIGH_LIT_C,
           " degC — lower bound of moderate heat stress (no stress ends at 26 degC; Blazejczyk UTCI)"),
    paste0("UTCI strata A/B/C: <", UTCI_HIGH_LIT_C, " / [", UTCI_HIGH_LIT_C, ",", UTCI_STRONG_HEAT_C,
           ") / >=", UTCI_STRONG_HEAT_C, " degC (moderate vs strong+ heat stress bands)"),
    "high_UTCI_tertile (reported): within PhaseID, value >= 67th percentile of finite ucm_UTCI in this matched table",
    paste0("both_high: high_sound AND high_UTCI (primary lit threshold)"),
    "",
    "suggested_for_H4_sound (participant-phase) = Y when ALL of:",
    paste0("  n_rows >= ", SUGGEST_MIN_ROWS),
    paste0("  pct_high_sound >= ", SUGGEST_MIN_PCT_SOUND),
    paste0("  pct_high_UTCI >= ", SUGGEST_MIN_PCT_UTCI),
    paste0("  pct_both_high >= ", SUGGEST_MIN_PCT_BOTH),
    "",
    paste0("Phase-specific UTCI tertile cuts (degC): ",
           paste(names(utci_tertile_by_phase), round(utci_tertile_by_phase, 2), sep = "=", collapse = "; ")),
    "",
    paste0("Participant-phases with >=1 epoch: dBA>=", SOUND_HIGH_DBA, " AND UTCI>=", UTCI_HIGH_LIT_C,
           " degC: ", n_pp_both_26, " of ", nrow(pp_any_both_26)),
    paste0("Participant-phases with >=1 epoch: dBA>=", SOUND_HIGH_DBA, " AND UTCI>=", UTCI_STRONG_HEAT_C,
           " degC (strong heat): ", n_pp_both_32, " of ", nrow(pp_any_both_32)),
    "",
    "UTCI 26 vs 32 degC (recommendation):",
    paste0("  ", UTCI_HIGH_LIT_C, " degC = inclusive screen (any moderate+ heat: UTCI >= 26 degC)."),
    paste0("  ", UTCI_STRONG_HEAT_C, " degC = strong-heat subset only (UTCI >= 32 degC; excludes moderate 26–32 band)."),
    paste0("  Strata CSV: ", basename(strata_dba_csv)),
    paste0("  B vs C co-exposure: ", basename(coexp_summary_txt))
  ),
  threshold_txt
)

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  message("ggplot2 not installed — CSV and threshold doc written; skipping figures.")
  quit(save = "no", status = 0)
}

suppressPackageStartupMessages(library(ggplot2))

d$PhaseID <- factor(d$PhaseID, levels = phases)
d$ParticipantID <- factor(d$ParticipantID, levels = participants)
summ$PhaseID <- factor(summ$PhaseID, levels = phases)
summ$ParticipantID <- factor(summ$ParticipantID, levels = participants)

# --- Dual-axis exposure profile (participant x phase) ---
# Per-participant medians on a shared x-axis let sound (dBA) and UTCI be read on comparable
# scales within each phase, unlike joint scatter/circle plots that mix axes and hide who
# drives co-exposure. Use with suggested_for_H4_sound in the participant-phase CSV for subset picks.
# Full cohort H4 sound (Eq1-7) remains primary; this figure supports supplementary high co-exposure testing.

dual_axis_rationale_txt <- file.path(out_dir, "H4_dual_axis_plot_rationale.txt")
writeLines(
  c(
    "Dual-axis sound + UTCI by participant and phase",
    "",
    "Why this over circled joint scatter: each participant keeps the same horizontal position",
    "across both exposures, with dBA (left) and UTCI (right) on calibrated axes — so loud vs",
    "thermally stressful profiles are directly comparable for cohort selection.",
    "",
    paste0("Figure: ", file.path(fig_dir, "sound_utci_dual_axis_by_participant_phase.png")),
    paste0("Suggested subset flags: ", csv_out, " (column suggested_for_H4_sound)"),
    "",
    "Note: primary H4 sound inference uses the full core cohort; this plot identifies",
    "participant-phases with enough joint high sound + UTCI for supplementary H4 sound runs.",
    "",
    paste0("Sound >= ", SOUND_HIGH_DBA, " dBA: aligned with the user's sound-band figure (>=70 dBA band) and",
           " common traffic/exposure banding in exploratory plots; not a WHO limit — exploratory threshold",
           " for co-exposure selection."),
    "",
    paste0("UTCI dashed orange line: ", UTCI_HIGH_LIT_C, " degC (onset of moderate heat stress; no stress is 9–26 degC).",
           " Gray dashed at ", UTCI_STRONG_HEAT_C, " degC = onset of strong heat stress (32–38 degC band)."),
    paste0("Participant-phases with any epoch dBA>=", SOUND_HIGH_DBA, " & UTCI>=", UTCI_HIGH_LIT_C, ": ",
           n_pp_both_26, "; at UTCI>=", UTCI_STRONG_HEAT_C, ": ", n_pp_both_32, "."),
    "",
    paste0("Recommendation: ", UTCI_HIGH_LIT_C, " degC = inclusive co-exposure screen; ",
           UTCI_STRONG_HEAT_C, " degC = stricter strong-heat subset for supplementary H4 sound."),
    "",
    "Dual-axis x-axis: standard participant ID labels per phase panel."
  ),
  dual_axis_rationale_txt
)

participant_phase_medians <- function(dat) {
  keys <- interaction(dat$ParticipantID, dat$PhaseID, drop = TRUE)
  chunks <- split(dat, keys, drop = TRUE)
  do.call(rbind, lapply(chunks, function(df) {
    dba <- df$ucm_SND_dBA[is.finite(df$ucm_SND_dBA)]
    utci <- df$ucm_UTCI[is.finite(df$ucm_UTCI)]
    data.frame(
      ParticipantID = df$ParticipantID[1],
      PhaseID = df$PhaseID[1],
      med_dBA = if (length(dba)) median(dba) else NA_real_,
      q25_dBA = if (length(dba)) unname(quantile(dba, 0.25)) else NA_real_,
      q75_dBA = if (length(dba)) unname(quantile(dba, 0.75)) else NA_real_,
      med_UTCI = if (length(utci)) median(utci) else NA_real_,
      q25_UTCI = if (length(utci)) unname(quantile(utci, 0.25)) else NA_real_,
      q75_UTCI = if (length(utci)) unname(quantile(utci, 0.75)) else NA_real_,
      n_fin = sum(is.finite(df$ucm_SND_dBA) & is.finite(df$ucm_UTCI)),
      stringsAsFactors = FALSE
    )
  }))
}

med_pp <- participant_phase_medians(d)
med_pp$ParticipantID <- factor(med_pp$ParticipantID, levels = participants)
med_pp$PhaseID <- factor(med_pp$PhaseID, levels = phases)

dba_lim <- range(d$ucm_SND_dBA, na.rm = TRUE)
utci_lim <- range(d$ucm_UTCI, na.rm = TRUE)
dba_span <- diff(dba_lim)
utci_span <- diff(utci_lim)
if (!is.finite(dba_span) || dba_span <= 0) dba_span <- 1
if (!is.finite(utci_span) || utci_span <= 0) utci_span <- 1
utci_to_y <- function(u) (u - utci_lim[1L]) / utci_span * dba_span + dba_lim[1L]
y_to_utci <- function(y) (y - dba_lim[1L]) / dba_span * utci_span + utci_lim[1L]

d_dual <- d[is.finite(d$ucm_SND_dBA) & is.finite(d$ucm_UTCI), , drop = FALSE]
d_dual$y_utci_scaled <- utci_to_y(d_dual$ucm_UTCI)
med_pp$y_med_utci <- utci_to_y(med_pp$med_UTCI)
med_pp$y_q25_utci <- utci_to_y(med_pp$q25_UTCI)
med_pp$y_q75_utci <- utci_to_y(med_pp$q75_UTCI)

p_dual_axis <- ggplot(d_dual, aes(x = ParticipantID)) +
  geom_point(
    aes(y = ucm_SND_dBA),
    color = "#2171b5", alpha = 0.12, size = 0.55, position = position_jitter(width = 0.18, height = 0)
  ) +
  geom_point(
    aes(y = y_utci_scaled),
    color = "#d94801", alpha = 0.12, size = 0.55, position = position_jitter(width = 0.18, height = 0)
  ) +
  geom_errorbar(
    data = med_pp,
    aes(x = ParticipantID, y = med_dBA, ymin = q25_dBA, ymax = q75_dBA),
    inherit.aes = FALSE,
    width = 0.22, linewidth = 0.45, color = "#2171b5", alpha = 0.95
  ) +
  geom_point(
    data = med_pp,
    aes(x = ParticipantID, y = med_dBA),
    inherit.aes = FALSE,
    size = 2.2, color = "#08519c"
  ) +
  geom_errorbar(
    data = med_pp,
    aes(x = ParticipantID, y = y_med_utci, ymin = y_q25_utci, ymax = y_q75_utci),
    inherit.aes = FALSE,
    width = 0.22, linewidth = 0.45, color = "#d94801", alpha = 0.95
  ) +
  geom_point(
    data = med_pp,
    aes(x = ParticipantID, y = y_med_utci),
    inherit.aes = FALSE,
    size = 2.2, color = "#a63603"
  ) +
  geom_hline(yintercept = SOUND_HIGH_DBA, linetype = "dashed", linewidth = 0.3, color = "#2171b5", alpha = 0.6) +
  geom_hline(
    yintercept = utci_to_y(UTCI_HIGH_LIT_C), linetype = "dashed", linewidth = 0.3, color = "#d94801", alpha = 0.6
  ) +
  geom_hline(
    yintercept = utci_to_y(UTCI_STRONG_HEAT_C), linetype = "dashed", linewidth = 0.3, color = "gray50", alpha = 0.75
  ) +
  facet_wrap(~PhaseID, nrow = 1) +
  scale_y_continuous(
    name = "Sound level (dBA)",
    limits = c(dba_lim[1L], dba_lim[2L]),
    expand = expansion(mult = c(0, 0.02)),
    sec.axis = sec_axis(~ y_to_utci(.), name = "UTCI (\u00B0C)")
  ) +
  labs(
    title = "Matched 10 s exposure profile by participant and phase",
    subtitle = paste0(
      "Faint dots = all epochs; points + IQR = medians (blue = dBA, orange = UTCI); ",
      "dashed blue/orange = ", SOUND_HIGH_DBA, " dBA (exploratory band, aligned with sound-band figure) / ",
      UTCI_HIGH_LIT_C, " \u00B0C UTCI; gray = ", UTCI_STRONG_HEAT_C, " \u00B0C strong heat"
    ),
    x = "Participant"
  ) +
  theme_bw(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 7),
    axis.title.y.right = element_text(color = "#a63603"),
    axis.text.y.right = element_text(color = "#a63603"),
    axis.title.y.left = element_text(color = "#08519c"),
    axis.text.y.left = element_text(color = "#08519c")
  )

dual_axis_png <- file.path(fig_dir, "sound_utci_dual_axis_by_participant_phase.png")
ggsave(dual_axis_png, p_dual_axis, width = 14, height = 5.5, dpi = 220)

d_joint_fin <- d[is.finite(d$ucm_SND_dBA) & is.finite(d$ucm_UTCI), , drop = FALSE]

p_dba_utci <- ggplot(d_joint_fin, aes(x = ucm_UTCI, y = ucm_SND_dBA, color = ParticipantID)) +
  geom_point(alpha = 0.4, size = 0.9) +
  geom_vline(xintercept = UTCI_HIGH_LIT_C, linetype = "dashed", linewidth = 0.35, color = "gray35") +
  geom_hline(yintercept = SOUND_HIGH_DBA, linetype = "dashed", linewidth = 0.35, color = "gray35") +
  facet_wrap(~PhaseID, nrow = 2) +
  labs(
    title = "Joint sound and UTCI exposure by phase",
    subtitle = paste0(
      "Dashed: UTCI = ", UTCI_HIGH_LIT_C, " degC; sound = ", SOUND_HIGH_DBA, " dBA (n=",
      nrow(d_joint_fin), " epochs)"
    ),
    x = "UTCI (degC)", y = "Sound level (dBA)"
  ) +
  theme_bw(base_size = 10) +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(nrow = 2, override.aes = list(alpha = 1, size = 2.5)))

ggsave(
  file.path(fig_dir, "sound_dba_vs_utci_scatter_by_phase.png"),
  p_dba_utci, width = 10, height = 8, dpi = 220
)

cat("Input:", normalizePath(input, winslash = "/"), "\n")
cat("Summary CSV:", normalizePath(csv_out, winslash = "/"), "\n")
cat("Participant CSV:", normalizePath(part_csv, winslash = "/"), "\n")
cat("Thresholds:", normalizePath(threshold_txt, winslash = "/"), "\n")
cat("Strata dBA CSV:", normalizePath(strata_dba_csv, winslash = "/"), "\n")
cat("B vs C co-exposure summary:", normalizePath(coexp_summary_txt, winslash = "/"), "\n")
cat(
  "Cohort loud+UTCI B vs C: n=", n_loud_B_cohort, " (", sprintf("%.1f", pct_loud_given_B),
  "% of B) vs n=", n_loud_C_cohort, " (", sprintf("%.1f", pct_loud_given_C), "% of C)\n",
  sep = ""
)
cat("Figures:", normalizePath(fig_dir, winslash = "/"), "\n")
cat("Dual-axis figure:", normalizePath(dual_axis_png, winslash = "/"), "\n")
cat("Dual-axis rationale:", normalizePath(dual_axis_rationale_txt, winslash = "/"), "\n")
cat("Suggested subset CSV (suggested_for_H4_sound):", normalizePath(csv_out, winslash = "/"), "\n")
cat("Suggested participant-phases (Y):", sum(summ$suggested_for_H4_sound == "Y"), "of", nrow(summ), "\n")
cat(
  "Note: full-cohort H4 sound (primary Eq1-7) unchanged; dual-axis plot + CSV flags support supplementary high co-exposure H4 sound runs.\n"
)
cat(
  "Participant-phases with any epoch dBA>=",
  SOUND_HIGH_DBA, " & UTCI>=", UTCI_HIGH_LIT_C, ": ", n_pp_both_26,
  "; UTCI>=", UTCI_STRONG_HEAT_C, ": ", n_pp_both_32, "\n",
  sep = ""
)
