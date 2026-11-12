# H4 spectrum: the §2 family-table equations, once per sound encoding.
# dBA reference uses energy-mean. Octave/YAMNet columns as SHARE use arithmetic
# bout mean of octave/freq proportions. Band LEVEL encodings put loudness back:
# L = 10 log10 mean(share * 10^(dBA/10)). L_excess subtracts bout L90 first.
# H4 increase close is Peng thermal ~ sound_z, not dBA+UTCI.
# Walking only. Nominal p. Vote-only equations are sound_variable = "votes_unchanged".
options(stringsAsFactors = FALSE)
entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(entry) || !file.exists(entry[1])) stop("Run with Rscript.")
entry <- normalizePath(entry[1], winslash = "/", mustWork = TRUE)
library_dir <- file.path(dirname(entry), "library")
code_paths <- c(entry, file.path(library_dir, c("Paper3_common.R", "H4_sound_literature_helpers.R")))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
suppressPackageStartupMessages(library(nlme))
root <- resolve_project_root()
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs <- H4_IO$read_epochs(root)
base <- h4_walk_cells(epochs)
base$ParticipantID <- factor(base$ParticipantID)
ctrl <- nlme::lmeControl(opt = "optim", msMaxIter = 200)

SPECTRUM <- intersect(c(
  "vehicle_proportion", "rural_natural_proportion",
  "urban_manmade_negative_proportion", "urban_manmade_positive_proportion",
  "urban_manmade_neutral_proportion", "wind_proportion",
  "mechanisms_proportion", "unidentify_proportion",
  "spectral_centroid_Hz", "spectral_rolloff85_Hz",
  "freq_proportion_20_to_200Hz", "freq_proportion_200_to_2000Hz",
  "freq_proportion_2000_to_20000Hz",
  "octave_proportion_31_5_Hz", "octave_proportion_63_0_Hz",
  "octave_proportion_125_0_Hz", "octave_proportion_250_0_Hz",
  "octave_proportion_500_0_Hz", "octave_proportion_1000_0_Hz",
  "octave_proportion_2000_0_Hz", "octave_proportion_4000_0_Hz",
  "octave_proportion_8000_0_Hz"
), names(epochs))

# Summed octave shares already on walk cells.
SUM_ENCODINGS <- c("oct_low", "oct_mid", "oct_high")
LOW_OCT <- c("octave_proportion_31_5_Hz", "octave_proportion_63_0_Hz",
             "octave_proportion_125_0_Hz", "octave_proportion_250_0_Hz")

bout_sound <- function(epochs, col, energy_db = FALSE) {
  do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    b <- epochs[rows, ]
    x <- as.numeric(b[[col]])
    data.frame(
      ParticipantID = as.character(b$ParticipantID[1]),
      PhaseID = as.character(b$PhaseID[1]),
      sound = if (energy_db) H4_UTIL$energy_mean_db(x) else H4_UTIL$finite_mean(x),
      sound_max = H4_UTIL$finite_max(x),
      sound_sd = H4_UTIL$finite_sd(x),
      stringsAsFactors = FALSE)
  }))
}

attach_pet <- function(cells, epochs) {
  if (!"ucm_PET" %in% names(epochs)) {
    cells$pet <- NA_real_
    return(cells)
  }
  pet <- do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    b <- epochs[rows, ]
    data.frame(ParticipantID = as.character(b$ParticipantID[1]),
               PhaseID = as.character(b$PhaseID[1]),
               pet = H4_UTIL$finite_mean(b$ucm_PET), stringsAsFactors = FALSE)
  }))
  merge(cells, pet, by = c("ParticipantID", "PhaseID"), all.x = TRUE)
}

fam_row <- function(sound_variable, family, equation, outcome, term, estimate, p, paper) {
  data.frame(
    sound_variable = sound_variable, family = family, equation = equation,
    outcome = outcome, term = term, estimate = as.numeric(estimate)[1],
    p = as.numeric(p)[1], paper = paper, stringsAsFactors = FALSE)
}

lme_ok <- function(form, data) {
  tryCatch(nlme::lme(form, random = ~ 1 | ParticipantID, data = data,
                     method = "REML", na.action = na.fail, control = ctrl),
           error = function(e) e)
}

# Family equations that use the sound column (the ones that can change).
family_for_sound <- function(cells, label) {
  out <- list()
  cells$sound_z <- H4_UTIL$z(cells$sound)
  cells$utci_z <- H4_UTIL$z(cells$utci)
  cells$sound_max_z <- H4_UTIL$z(cells$sound_max)
  cells$sound_sd_z <- H4_UTIL$z(cells$sound_sd)

  # Spearman (thermal, sound) — Zhen
  ok <- is.finite(cells$thermal_comfort) & is.finite(cells$sound)
  if (sum(ok) >= 8L) {
    ct <- suppressWarnings(cor.test(cells$thermal_comfort[ok], cells$sound[ok],
                                    method = "spearman", exact = FALSE))
    out[[length(out) + 1L]] <- fam_row(label, "Spearman", "(thermal_comfort, sound)",
      "thermal_comfort", "spearman_thermal_sound", unname(ct$estimate), ct$p.value, "Zhen 2025")
  }

  # Wilcoxon urban-green on the sound column — Cureau dBA analogue
  w <- reshape(cells[, c("ParticipantID", "PhaseID", "sound", "thermal_comfort", "acoustic_comfort")],
               idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  a <- w$sound.WalkG; b <- w$sound.WalkU
  ok <- is.finite(a) & is.finite(b)
  if (sum(ok) >= 4L) {
    wt <- suppressWarnings(wilcox.test(b[ok], a[ok], paired = TRUE))
    out[[length(out) + 1L]] <- fam_row(label, "Wilcoxon", "sound_urban - sound_green",
      "sound", "wilcoxon_sound", median(b[ok] - a[ok]), wt$p.value, "Cureau 2022")
  }

  # Kruskal-Wallis physio ~ sound quartile | PET half — Tang
  d <- cells[is.finite(cells$pet) & is.finite(cells$sound), ]
  if (nrow(d) >= 8L) {
    d$hot <- d$pet >= median(d$pet, na.rm = TRUE)
    br <- unique(quantile(d$sound, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
    if (length(br) >= 3L) {
      d$q <- cut(d$sound, breaks = br, include.lowest = TRUE, labels = FALSE)
      for (oc in c("heart_rate", "sdnn", "rmssd")) {
        for (hot in c(FALSE, TRUE)) {
          dd <- d[d$hot == hot & is.finite(d[[oc]]) & !is.na(d$q), ]
          labh <- if (hot) "warm" else "cool"
          if (length(unique(dd$q)) < 2L || nrow(dd) < 4L) next
          kw <- kruskal.test(dd[[oc]] ~ factor(dd$q))
          out[[length(out) + 1L]] <- fam_row(label, "Kruskal-Wallis",
            paste0(oc, " ~ sound quartile within PET ", labh), oc,
            paste0("kw_", oc, "_", labh), unname(kw$statistic), kw$p.value, "Tang 2026")
        }
      }
    }
  }

  # Peng one-predictor: thermal~sound, thermal~acoustic, acoustic~sound
  peng <- list(
    list(y = "thermal_comfort", x = "sound_z", term = "peng_thermal_sound"),
    list(y = "thermal_comfort", x = "acoustic_comfort", term = "peng_thermal_acoustic"),
    list(y = "acoustic_comfort", x = "sound_z", term = "peng_acoustic_sound"))
  for (m in peng) {
    xv <- if (m$x == "sound_z") cells$sound_z else cells[[m$x]]
    ok <- is.finite(cells[[m$y]]) & is.finite(xv)
    dd <- cells[ok, ]
    if (nrow(dd) < 12L) next
    dd$.y <- dd[[m$y]]
    dd$pred <- if (m$x == "sound_z") dd$sound_z else dd[[m$x]]
    fit <- lme_ok(.y ~ pred, dd)
    if (inherits(fit, "error")) next
    tt <- summary(fit)$tTable
    if (!"pred" %in% rownames(tt)) next
    out[[length(out) + 1L]] <- fam_row(label, "LMM (one predictor)",
      paste0(m$y, " ~ ", m$x, " + (1|participant)"), m$y, m$term,
      tt["pred", "Value"], tt["pred", "p-value"], "Peng 2025")
  }

  # Not a source thermal-vote formula. Not the H4 close. Skip.

  # Rodrigues noise block
  for (oc in c("skin_temp", "heart_rate", "eda_tonic", "sdnn", "rmssd")) {
    ok <- is.finite(cells[[oc]]) & is.finite(cells$sound_max_z) & is.finite(cells$sound_sd_z)
    dd <- cells[ok, ]
    if (nrow(dd) < 8L) next
    dd$.y <- dd[[oc]]
    fit <- lme_ok(.y ~ sound_max_z + sound_sd_z, dd)
    if (inherits(fit, "error")) next
    tt <- summary(fit)$tTable
    for (tm in c("sound_max_z", "sound_sd_z")) {
      if (!tm %in% rownames(tt)) next
      out[[length(out) + 1L]] <- fam_row(label, "LMM (Noise_max + Noise_sd)",
        paste0(oc, " ~ sound_max_z + sound_sd_z + (1|participant)"), oc, tm,
        tt[tm, "Value"], tt[tm, "p-value"], "Rodrigues 2026")
    }
  }
  if (!length(out)) return(NULL)
  do.call(rbind, out)
}

# Vote-only family rows (do not use sound; run once). Chiucchiù indoor out.
vote_rows <- function(cells) {
  out <- list()
  w <- reshape(cells[, c("ParticipantID", "PhaseID", "thermal_comfort", "acoustic_comfort")],
               idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
  for (v in c("thermal_comfort", "acoustic_comfort")) {
    a <- w[[paste0(v, ".WalkG")]]; b <- w[[paste0(v, ".WalkU")]]
    ok <- is.finite(a) & is.finite(b)
    wt <- suppressWarnings(wilcox.test(b[ok], a[ok], paired = TRUE))
    out[[length(out) + 1L]] <- fam_row("votes_unchanged", "Wilcoxon", "Y_urban - Y_green",
      v, paste0("wilcoxon_", v), median(b[ok] - a[ok]), wt$p.value, "Cureau 2022")
  }
  for (ph in c("WalkG", "WalkU")) {
    d <- cells[cells$PhaseID == ph & is.finite(cells$thermal_comfort) & is.finite(cells$acoustic_comfort), ]
    tab <- table(d$thermal_comfort, d$acoustic_comfort)
    if (any(dim(tab) < 2L)) next
    ft <- tryCatch(fisher.test(tab, workspace = 2e8), error = function(e) {
      set.seed(20261110)
      fisher.test(tab, simulate.p.value = TRUE, B = 1e5)
    })
    out[[length(out) + 1L]] <- fam_row("votes_unchanged", "Fisher", "thermal x acoustic",
      "thermal_comfort x acoustic_comfort", paste0("fisher_", ph), NA_real_, ft$p.value, "Cureau 2022")
  }
  do.call(rbind, out)
}

base <- attach_pet(base, epochs)
blocks <- list(vote_rows(base))

band_walk <- function(epochs) {
  do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    b <- epochs[rows, ]
    dba <- as.numeric(b$ucm_SND_dBA)
    lin <- 10^(dba / 10)
    share_low <- rowSums(as.data.frame(lapply(LOW_OCT, function(nm) as.numeric(b[[nm]]))))
    f20 <- as.numeric(b$freq_proportion_20_to_200Hz)
    o63 <- as.numeric(b$octave_proportion_63_0_Hz)
    L90 <- if (sum(is.finite(dba)) >= 4L) as.numeric(stats::quantile(dba[is.finite(dba)], 0.10, names = FALSE)) else NA_real_
    lin90 <- if (is.finite(L90)) 10^(L90 / 10) else NA_real_
    excess <- pmax(lin - lin90, 0)
    em <- function(x) {
      x <- x[is.finite(x) & x >= 0]
      if (!length(x) || mean(x) <= 0) return(NA_real_)
      10 * log10(mean(x))
    }
    db10 <- function(share) {
      v <- 10 * log10(share * lin)
      data.frame(mx = H4_UTIL$finite_max(v), sd = H4_UTIL$finite_sd(v))
    }
    sl <- db10(share_low)
    data.frame(
      ParticipantID = as.character(b$ParticipantID[1]),
      PhaseID = as.character(b$PhaseID[1]),
      L_low = em(share_low * lin),
      L_f20 = em(f20 * lin),
      L_63 = em(o63 * lin),
      L_excess = em(excess),
      L_low_ex = em(share_low * excess),
      L_f20_ex = em(f20 * excess),
      L_low_max = sl$mx, L_low_sd = sl$sd,
      stringsAsFactors = FALSE)
  }))
}

# dBA reference: energy-mean + max/sd of 10 s dBA (same as §2).
ref <- base
ref$sound <- ref$dba
ref$sound_max <- ref$dba_max
ref$sound_sd <- ref$dba_sd
blocks[[length(blocks) + 1L]] <- family_for_sound(ref, "dBA_energy_mean")

# Band LEVEL (vote encoding). Share * linear energy, then energy-mean.
band <- band_walk(epochs)
band <- band[band$PhaseID %in% c("WalkG", "WalkU"), ]
for (col in c("L_low", "L_f20", "L_63", "L_excess", "L_low_ex", "L_f20_ex")) {
  cells <- merge(base, band, by = c("ParticipantID", "PhaseID"))
  cells$sound <- cells[[col]]
  cells$sound_max <- cells$L_low_max
  cells$sound_sd <- cells$L_low_sd
  row <- family_for_sound(cells, col)
  if (!is.null(row)) {
    if (!col %in% c("L_low", "L_f20", "L_63")) {
      row <- row[!(row$family == "LMM (Noise_max + Noise_sd)"), ]
    }
    blocks[[length(blocks) + 1L]] <- row
  }
}

# Summed octave shares already on cells (arithmetic mean).
for (col in SUM_ENCODINGS) {
  cells <- base
  cells$sound <- cells[[col]]
  cells$sound_max <- cells[[col]]
  cells$sound_sd <- NA_real_
  # max/sd of 10 s not stored for sums; skip Rodrigues if sd missing
  cells$sound_sd <- 0
  row <- family_for_sound(cells, col)
  if (!is.null(row)) {
    row <- row[!(row$family == "LMM (Noise_max + Noise_sd)"), ]
    blocks[[length(blocks) + 1L]] <- row
  }
}

for (col in SPECTRUM) {
  s <- bout_sound(epochs, col, energy_db = FALSE)
  s <- s[s$PhaseID %in% c("WalkG", "WalkU"), ]
  cells <- merge(base, s, by = c("ParticipantID", "PhaseID"))
  blocks[[length(blocks) + 1L]] <- family_for_sound(cells, col)
}

catalog <- do.call(rbind, Filter(Negate(is.null), blocks))
catalog$source_rule_met <- is.finite(catalog$p) & catalog$p < 0.05
rod <- catalog$paper == "Rodrigues 2026"
catalog$source_rule_met[rod] <- is.finite(catalog$p[rod]) & catalog$p[rod] < 0.05 &
  abs(catalog$estimate[rod]) > 0.1
# H4 increase close: Peng thermal ~ sound_z, predicted negative, p<0.05.
# Level encodings only (share and YAMNet classes are not this close).
peng <- catalog[catalog$family == "LMM (one predictor)" & catalog$term == "peng_thermal_sound", ]
h4_level <- c("dBA_energy_mean", "L_low", "L_f20", "L_63", "L_excess", "L_low_ex", "L_f20_ex")
close_ok <- tapply(seq_len(nrow(peng)), peng$sound_variable, function(i) {
  isTRUE(peng$sound_variable[i] %in% h4_level) &&
    isTRUE(peng$p[i] < 0.05) && isTRUE(peng$estimate[i] < 0)
})

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop("Code changed during run.")
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop("Input changed during run.")

notes <- c(
  "# H4 family-table spectrum duplicate",
  paste("Run UTC:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
  paste("Input MD5:", unname(input_fingerprint)),
  "- Family equations that use sound are repeated for dBA, octave SHARE, band LEVEL, L90-excess, and YAMNet/spectrum columns.",
  "- dBA_energy_mean = 10 log10 mean of 10^(dBA/10). SHARE encodings = arithmetic bout mean of octave/freq proportions.",
  "- Band LEVEL L_low/L_f20/L_63 = 10 log10 mean(share * 10^(dBA/10)). L_excess subtracts bout L90 in linear units first.",
  "- Y ~ dBA_z + UTCI_z is not run (not a source thermal-vote formula; not the H4 close).",
  "- H4 increase close = Peng thermal ~ sound_z, p<0.05."
)

staging <- tempfile("H4_specfam_")
dir.create(staging)
write.csv(catalog, file.path(staging, "H4_sound_literature_tests_spectrum.csv"), row.names = FALSE, na = "")
write.csv(catalog[catalog$sound_variable == "vehicle_proportion", ],
          file.path(staging, "H4_family_vehicle_proportion.csv"), row.names = FALSE, na = "")
write.csv(catalog[catalog$sound_variable == "dBA_energy_mean", ],
          file.path(staging, "H4_family_dBA.csv"), row.names = FALSE, na = "")
write.csv(catalog[catalog$sound_variable == "L_low", ],
          file.path(staging, "H4_family_L_low.csv"), row.names = FALSE, na = "")
writeLines(notes, file.path(staging, "METHODS_NOTES.md"))
output <- file.path(root, "output", "statistical_analysis", "results", "H4_sound_literature_test_spectrum")
dir.create(output, recursive = TRUE, showWarnings = FALSE)
invisible(file.copy(list.files(staging, full.names = TRUE), output, overwrite = TRUE))
cat("Saved", nrow(catalog), "rows to", output, "\n")

show <- function(label) {
  d <- catalog[catalog$sound_variable == label, c("family", "term", "outcome", "estimate", "p", "source_rule_met")]
  cat("\n======== ", label, " ========\n", sep = "")
  print(d, row.names = FALSE)
}
show("dBA_energy_mean")
show("L_low")
show("oct_low")
cat("\nH4 increase (Peng thermal ~ sound p<0.05) encodings: ",
    paste(names(close_ok)[unlist(close_ok)], collapse = ", "), "\n", sep = "")
cat("vehicle urban vs green means:\n")
s <- bout_sound(epochs, "vehicle_proportion")
s <- s[s$PhaseID %in% c("WalkG", "WalkU"), ]
print(aggregate(sound ~ PhaseID, s, mean))
