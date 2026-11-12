# H4_old: source-informed thermal x sound product tests on Brussels walking bouts.
# Separate from the updated H4 helpers. Nominal p only; no BH/FDR.

H4_OLD_UTIL <- list(
  bouts = function(epochs) split(seq_len(nrow(epochs)), interaction(epochs$ParticipantID, epochs$PhaseID, drop = TRUE)),
  finite_mean = function(x) { x <- x[is.finite(x)]; if (length(x)) mean(x) else NA_real_ },
  energy_mean_db = function(level_db) {
    level_db <- level_db[is.finite(level_db)]
    if (!length(level_db)) return(NA_real_)
    10 * log10(mean(10^(level_db / 10)))
  },
  z = function(x) {
    x <- as.numeric(x)
    s <- stats::sd(x[is.finite(x)])
    if (!is.finite(s) || s == 0) x else (x - mean(x, na.rm = TRUE)) / s
  }
)

h4_old_walk_cells <- function(epochs) {
  walk <- epochs[epochs$PhaseID %in% c("WalkG", "WalkU"), , drop = FALSE]
  do.call(rbind, lapply(H4_OLD_UTIL$bouts(walk), function(rows) {
    b <- walk[rows, ]
    data.frame(
      ParticipantID = as.character(b$ParticipantID[1]),
      PhaseID = as.character(b$PhaseID[1]),
      urban = as.integer(b$PhaseID[1] == "WalkU"),
      utci = H4_OLD_UTIL$finite_mean(b$ucm_UTCI),
      air_temp = H4_OLD_UTIL$finite_mean(b$ucm_AIR_temp),
      pet = if ("ucm_PET" %in% names(b)) H4_OLD_UTIL$finite_mean(b$ucm_PET) else NA_real_,
      dba = H4_OLD_UTIL$energy_mean_db(b$ucm_SND_dBA),
      thermal_comfort = H4_OLD_UTIL$finite_mean(b$questionnaire_thermal_comfort_1_5),
      acoustic_comfort = H4_OLD_UTIL$finite_mean(b$questionnaire_acoustic_comfort_1_5),
      overall_comfort = H4_OLD_UTIL$finite_mean(b$questionnaire_current_comfort_1_7),
      prs_score = H4_OLD_UTIL$finite_mean(b$questionnaire_prs11_total_mean_1_5),
      heart_rate = H4_OLD_UTIL$finite_mean(b$empatica_heart_rate),
      sdnn = H4_OLD_UTIL$finite_mean(b$empatica_hrv_td_sdnn),
      rmssd = H4_OLD_UTIL$finite_mean(b$empatica_hrv_td_rmssd),
      stringsAsFactors = FALSE)
  }))
}

h4_old_empty_row <- function(paper, test, outcome, term, n, np, formula, note) {
  data.frame(
    paper = paper, test = test, outcome = outcome, term = term,
    estimate = NA_real_, se = NA_real_, statistic = NA_real_, df = NA_real_, p = NA_real_,
    n_observations = n, n_participants = np,
    statistic_test = "t-test (REML LMM interaction)",
    formula = formula, note = note,
    analysis_rule_met = FALSE,
    estimable = FALSE,
    stringsAsFactors = FALSE)
}

# One interaction coefficient: Y ~ thermal_z * sound_z + (1 | participant).
h4_old_product_row <- function(data, y, thermal, sound, paper, test, formula, note,
                               thermal_name = "thermal_z", sound_name = "sound_z") {
  keep <- is.finite(data[[y]]) & is.finite(data[[thermal]]) & is.finite(data[[sound]])
  d <- data[keep, , drop = FALSE]
  np <- length(unique(d$ParticipantID))
  n <- nrow(d)
  term <- paste0(thermal_name, ":", sound_name)
  if (n < 8L || np < 3L || length(unique(d[[thermal]])) < 2L || length(unique(d[[sound]])) < 2L) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula, paste(note, "not estimable (too few cells).")))
  }
  d$Y <- d[[y]]
  d[[thermal_name]] <- H4_OLD_UTIL$z(d[[thermal]])
  d[[sound_name]] <- H4_OLD_UTIL$z(d[[sound]])
  d$ParticipantID <- factor(d$ParticipantID)
  rhs <- paste(thermal_name, "*", sound_name)
  fit <- tryCatch(
    nlme::lme(stats::as.formula(paste("Y ~", rhs)), data = d, random = ~ 1 | ParticipantID,
              method = "REML", na.action = stats::na.fail,
              control = nlme::lmeControl(opt = "optim", returnObject = FALSE)),
    error = function(e) e)
  if (inherits(fit, "error")) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula, paste(note, conditionMessage(fit))))
  }
  tab <- summary(fit)$tTable
  if (!term %in% rownames(tab)) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula, paste(note, "interaction coefficient missing.")))
  }
  coef <- tab[term, ]
  data.frame(
    paper = paper, test = test, outcome = y, term = term,
    estimate = unname(coef[["Value"]]), se = unname(coef[["Std.Error"]]),
    statistic = unname(coef[["t-value"]]), df = unname(coef[["DF"]]),
    p = unname(coef[["p-value"]]),
    n_observations = n, n_participants = np,
    statistic_test = "t-test (REML LMM interaction)",
    formula = formula, note = note,
    analysis_rule_met = is.finite(coef[["p-value"]]) && coef[["p-value"]] < 0.05,
    estimable = TRUE,
    stringsAsFactors = FALSE)
}

# Factorial product without z-scoring (for I(hot)*I(loud) and loud60*UTCI).
h4_old_factor_product_row <- function(data, y, a, b, paper, test, formula, note) {
  keep <- is.finite(data[[y]]) & is.finite(data[[a]]) & is.finite(data[[b]])
  d <- data[keep, , drop = FALSE]
  np <- length(unique(d$ParticipantID))
  n <- nrow(d)
  term <- paste0(a, ":", b)
  counts <- table(factor(d[[a]]), factor(d[[b]]))
  if (n < 8L || np < 3L || any(counts == 0L) || length(unique(d[[a]])) < 2L || length(unique(d[[b]])) < 2L) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula,
      paste(note, "2x2 not estimable; empty or single-level cell.")))
  }
  d$Y <- d[[y]]
  d$ParticipantID <- factor(d$ParticipantID)
  fit <- tryCatch(
    nlme::lme(stats::as.formula(paste("Y ~", a, "*", b)), data = d, random = ~ 1 | ParticipantID,
              method = "REML", na.action = stats::na.fail,
              control = nlme::lmeControl(opt = "optim", returnObject = FALSE)),
    error = function(e) e)
  if (inherits(fit, "error")) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula, paste(note, conditionMessage(fit))))
  }
  tab <- summary(fit)$tTable
  if (!term %in% rownames(tab)) {
    return(h4_old_empty_row(paper, test, y, term, n, np, formula, paste(note, "interaction coefficient missing.")))
  }
  coef <- tab[term, ]
  data.frame(
    paper = paper, test = test, outcome = y, term = term,
    estimate = unname(coef[["Value"]]), se = unname(coef[["Std.Error"]]),
    statistic = unname(coef[["t-value"]]), df = unname(coef[["DF"]]),
    p = unname(coef[["p-value"]]),
    n_observations = n, n_participants = np,
    statistic_test = "t-test (REML LMM interaction)",
    formula = formula, note = note,
    analysis_rule_met = is.finite(coef[["p-value"]]) && coef[["p-value"]] < 0.05,
    estimable = TRUE,
    stringsAsFactors = FALSE)
}

# Jin Type II two-way ANOVA interaction vs additive model, participant block.
h4_old_anova_interaction <- function(y, sound_f, thermal_f, participant, paper, test, outcome, formula, note) {
  a <- droplevels(factor(sound_f)); b <- droplevels(factor(thermal_f))
  participant <- factor(participant)
  n <- length(y); np <- nlevels(participant)
  if (n < 8L || nlevels(a) < 2L || nlevels(b) < 2L) {
    return(h4_old_empty_row(paper, test, outcome, "LAeq x UTCI", n, np, formula, paste(note, "ANOVA not estimable.")))
  }
  rss <- function(X) { q <- qr(X); list(rss = sum(qr.resid(q, y)^2), rank = q$rank) }
  block <- if (nlevels(participant) > 1L) stats::model.matrix(~ participant) else matrix(1, n, 1L)
  design <- function(fml) cbind(block, stats::model.matrix(fml)[, -1, drop = FALSE])
  full <- rss(design(~ a * b)); additive <- rss(design(~ a + b))
  df_term <- full$rank - additive$rank
  df_res <- n - full$rank
  if (df_term < 1L || df_res < 1L) {
    return(h4_old_empty_row(paper, test, outcome, "LAeq x UTCI", n, np, formula, paste(note, "rank-deficient interaction.")))
  }
  F_value <- ((additive$rss - full$rss) / df_term) / (full$rss / df_res)
  p <- stats::pf(F_value, df_term, df_res, lower.tail = FALSE)
  data.frame(
    paper = paper, test = test, outcome = outcome, term = "LAeq x UTCI",
    estimate = NA_real_, se = NA_real_, statistic = F_value, df = df_res, p = p,
    n_observations = n, n_participants = np,
    statistic_test = "F-test (Type II ANOVA interaction vs additive, participant block)",
    formula = formula, note = note,
    analysis_rule_met = is.finite(p) && p < 0.05,
    estimable = TRUE,
    stringsAsFactors = FALSE)
}

h4_old_quartile <- function(x, prefix) {
  br <- unique(stats::quantile(x, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE))
  if (length(br) < 3L) return(factor(rep(NA, length(x))))
  cut(x, br, paste0(prefix, seq_len(length(br) - 1L)), include.lowest = TRUE)
}

H4_OLD_PAPERS <- list(
  jin = function(cells) {
    out <- list()
    cells$laeq_level <- h4_old_quartile(cells$dba, "Q")
    cells$utci_category <- h4_old_quartile(cells$utci, "T")
    for (oc in c("thermal_comfort", "acoustic_comfort", "overall_comfort")) {
      use <- is.finite(cells[[oc]]) & !is.na(cells$laeq_level) & !is.na(cells$utci_category)
      d <- cells[use, ]
      row <- h4_old_anova_interaction(
        d[[oc]], d$laeq_level, d$utci_category, d$ParticipantID,
        "Jin 2020", paste("LAeq quartile x UTCI quartile |", oc), oc,
        "Y ~ ParticipantID + LAeq_band * UTCI_category",
        "Jin 2020 two-way ANOVA analogue. Quartiles of 22 walk cells, not source 5 dB / UTCI stress bins.")
      if (!isTRUE(row$estimable)) {
        row <- h4_old_product_row(d, oc, "utci", "dba", "Jin 2020",
          paste("continuous UTCI x dBA fallback |", oc),
          "Y ~ UTCI_z * dBA_z + (1 | participant)",
          "ANOVA interaction not estimable; continuous product on the same walk cells.")
      }
      out[[length(out) + 1L]] <- row
    }
    do.call(rbind, out)
  },
  chen = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "overall_comfort"), function(oc) {
      h4_old_product_row(cells, oc, "utci", "dba", "Chen 2023",
        paste("UTCI x dBA |", oc),
        "Y ~ UTCI_z * dBA_z + (1 | participant)",
        "Chen 2023 RM-ANOVA analogue on walk cells. Continuous LMM; not the published site factorial.")
    }))
  },
  li = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "overall_comfort"), function(oc) {
      h4_old_product_row(cells, oc, "utci", "dba", "Li 2025",
        paste("UTCI x dBA |", oc),
        "Y ~ UTCI_z * dBA_z + (1 | participant)",
        "Li 2025 SPL x UTCI analogue. Quadratic SPL term omitted; H4 is the product.")
    }))
  },
  mohammadzadeh = function(cells) {
    h4_old_product_row(cells, "acoustic_comfort", "utci", "dba", "Mohammadzadeh 2023",
      "AC ~ UTCI x LAeq",
      "AC ~ UTCI_z * dBA_z + (1 | participant)",
      "Mohammadzadeh 2023 acoustic comfort on UTCI x LAeq.")
  },
  gao = function(cells) {
    h4_old_product_row(cells, "prs_score", "utci", "dba", "Gao 2025",
      "prs_score ~ UTCI x LAeq",
      "prs_score ~ UTCI_z * dBA_z + (1 | participant)",
      "Gao 2025 ROS analogue. Local prs_score is questionnaire_prs11_total_mean_1_5.")
  },
  wu = function(cells) {
    d <- cells
    d$loud60 <- as.numeric(d$dba >= 60)
    row <- h4_old_factor_product_row(d, "overall_comfort", "loud60", "utci", "Wu 2025",
      "OCV ~ I(dBA>=60) x UTCI",
      "overall_comfort ~ I(dBA>=60) * UTCI + (1 | participant)",
      "Wu 2025 published 60 dB(A) cutoff on overall comfort vote.")
    if (!isTRUE(row$estimable)) {
      row <- h4_old_product_row(cells, "overall_comfort", "utci", "dba", "Wu 2025",
        "OCV ~ UTCI x dBA fallback",
        "overall_comfort ~ UTCI_z * dBA_z + (1 | participant)",
        "60 dB split not estimable on 22 walk cells; continuous product.")
    }
    row
  },
  xu = function(cells) {
    d <- cells
    d$hot <- as.numeric(d$air_temp > 32)
    d$loud <- as.numeric(d$dba > 65)
    row <- h4_old_factor_product_row(d, "thermal_comfort", "hot", "loud", "Xu 2026",
      "TC ~ I(Ta>32) x I(SPL>65)",
      "TC ~ I(air_temp>32) * I(dBA>65) + (1 | participant)",
      "Xu 2026 published hot x loud thresholds.")
    if (!isTRUE(row$estimable)) {
      row <- h4_old_product_row(cells, "thermal_comfort", "air_temp", "dba", "Xu 2026",
        "TC ~ Ta x dBA fallback",
        "TC ~ Ta_z * dBA_z + (1 | participant)",
        "2x2 hot x loud cell empty; continuous air temperature x dBA on walk cells.")
    }
    row
  },
  zhen = function(cells) {
    h4_old_product_row(cells, "thermal_comfort", "utci", "dba", "Zhen 2025",
      "TC ~ UTCI x SPL",
      "TC ~ UTCI_z * dBA_z + (1 | participant)",
      "Zhen 2025 TSV ~ UTCI x SPL analogue; local thermal comfort.")
  },
  tang = function(cells) {
    thermal <- if (all(is.finite(cells$pet))) "pet" else "utci"
    do.call(rbind, lapply(c("heart_rate", "sdnn", "rmssd"), function(oc) {
      h4_old_product_row(cells, oc, thermal, "dba", "Tang 2026",
        paste("physiology ~ dBA x", thermal, "|", oc),
        paste0(oc, " ~ dBA_z * ", thermal, "_z + (1 | participant)"),
        "Tang 2026 soundscape-within-thermal-stratum analogue. Assigned playbacks not available; field product on walk cells.")
    }))
  },
  yousefinezhad = function(cells) {
    d <- cells
    d$hot <- as.numeric(d$utci >= stats::median(d$utci, na.rm = TRUE))
    d$loud <- as.numeric(d$dba >= stats::median(d$dba, na.rm = TRUE))
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "overall_comfort"), function(oc) {
      row <- h4_old_factor_product_row(d, oc, "hot", "loud", "Yousefinezhad 2026",
        paste("heat x noise arms |", oc),
        paste0(oc, " ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)"),
        "Assigned lab arms not available. Median-split heat x noise analogue on walk cells.")
      if (!isTRUE(row$estimable)) {
        row <- h4_old_product_row(cells, oc, "utci", "dba", "Yousefinezhad 2026",
          paste("UTCI x dBA fallback |", oc),
          "Y ~ UTCI_z * dBA_z + (1 | participant)",
          "2x2 arms not estimable; continuous product.")
      }
      row
    }))
  },
  bhattacharya = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "heart_rate"), function(oc) {
      h4_old_product_row(cells, oc, "air_temp", "dba", "Bhattacharya 1991",
        paste("noise x heat |", oc),
        "Y ~ Ta_z * dBA_z + (1 | participant)",
        "Assigned occupational noise x heat arms not available. Local product on walk cells.")
    }))
  },
  abbasi = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "heart_rate"), function(oc) {
      h4_old_product_row(cells, oc, "air_temp", "dba", "Abbasi 2020",
        paste("temperature x dBA |", oc),
        "Y ~ Ta_z * dBA_z + (1 | participant)",
        "Assigned laboratory temperature x dBA arms not available. Local product on walk cells.")
    }))
  },
  tohidi = function(cells) {
    h4_old_product_row(cells, "heart_rate", "air_temp", "dba", "Tohidi 2025",
      "HR ~ T x noise_level",
      "HR ~ Ta_z * dBA_z + (1 | participant)",
      "Assigned sound-type x level x temperature arms not available. Local HR product on walk cells.")
  },
  dehghan = function(cells) {
    d <- cells
    d$hot <- as.numeric(d$utci >= stats::median(d$utci, na.rm = TRUE))
    d$loud <- as.numeric(d$dba >= stats::median(d$dba, na.rm = TRUE))
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "heart_rate"), function(oc) {
      row <- h4_old_factor_product_row(d, oc, "hot", "loud", "Dehghan 2017",
        paste("heat x noise |", oc),
        paste0(oc, " ~ I(UTCI >= median) * I(dBA >= median) + (1 | participant)"),
        "Assigned heat / noise / combined arms not available. Median-split analogue on walk cells.")
      if (!isTRUE(row$estimable)) {
        row <- h4_old_product_row(cells, oc, "utci", "dba", "Dehghan 2017",
          paste("UTCI x dBA fallback |", oc),
          "Y ~ UTCI_z * dBA_z + (1 | participant)",
          "2x2 not estimable; continuous product.")
      }
      row
    }))
  },
  molaeifar = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "heart_rate"), function(oc) {
      h4_old_product_row(cells, oc, "air_temp", "dba", "Molaeifar 2020",
        paste("sound x heat |", oc),
        "Y ~ Ta_z * dBA_z + (1 | participant)",
        "Assigned concomitant sound + heat + workload not available. Local product; no workload term.")
    }))
  },
  wang = function(cells) {
    do.call(rbind, lapply(c("thermal_comfort", "acoustic_comfort", "overall_comfort"), function(oc) {
      h4_old_product_row(cells, oc, "utci", "urban", "Wang 2026",
        paste("soundscape type x UTCI |", oc),
        "Y ~ UTCI_z * urban + (1 | participant)",
        "Wang stimulus-type at 26/28/32 C analogue. WalkU vs WalkG stands in for stimulus type.")
    }))
  }
)

# Only sources that published amplification (product, 2x2 heat x noise, or LAeq x UTCI ANOVA).
# Not run: mohammadzadeh (thermal -> acoustic), gao (restoration), zhen (no product),
# tang (stratum Kruskal-Wallis), wang (nature audio, no interaction).
H4_OLD_AMPLIFICATION <- c(
  "jin", "chen", "li", "wu", "xu", "yousefinezhad",
  "bhattacharya", "abbasi", "tohidi", "dehghan", "molaeifar")

h4_old_run_all <- function(epochs) {
  cells <- h4_old_walk_cells(epochs)
  blocks <- lapply(H4_OLD_AMPLIFICATION, function(nm) H4_OLD_PAPERS[[nm]](cells))
  catalog <- do.call(rbind, blocks)
  rownames(catalog) <- NULL
  catalog
}

h4_old_summary <- function(catalog) {
  split_cat <- split(catalog, catalog$paper)
  do.call(rbind, lapply(split_cat, function(d) {
    data.frame(
      paper = d$paper[1],
      n_tests = nrow(d),
      n_estimable = sum(d$estimable, na.rm = TRUE),
      n_significant = sum(d$analysis_rule_met, na.rm = TRUE),
      local_result = paste0(sum(d$analysis_rule_met, na.rm = TRUE), "/", nrow(d)),
      stringsAsFactors = FALSE)
  }))
}

H4_OLD_IO <- list(
  read_epochs = function(root) {
    epochs <- read.csv(paper3_merged_8min_path(root), check.names = FALSE)
    epochs <- epochs[epochs$ParticipantID %in% PAPER3_PARTICIPANTS & epochs$PhaseID %in% PAPER3_CORE_PHASES, ]
    epochs$Datetime <- as.POSIXct(epochs$Datetime, tz = "UTC")
    epochs[order(epochs$ParticipantID, epochs$PhaseID, epochs$Datetime), ]
  },
  write = function(catalog, summary, notes, root) {
    output <- file.path(root, "output", "statistical_analysis", "results", "H4_old_sound_literature_test")
    dir.create(output, recursive = TRUE, showWarnings = FALSE)
    tests_path <- file.path(output, "H4_old_sound_literature_tests.csv")
    summary_path <- file.path(output, "H4_old_summary.csv")
    notes_path <- file.path(output, "METHODS_NOTES.md")
    write.csv(catalog, tests_path, row.names = FALSE)
    write.csv(summary, summary_path, row.names = FALSE)
    writeLines(notes, notes_path)
    cat("Saved", nrow(catalog), "rows to", output, "\n")
    invisible(list(catalog = catalog, summary = summary, output = output))
  }
)
