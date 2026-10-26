# ==============================================================================
# SCRIPT: Normalization_Test.R
# PURPOSE: Auditable participant-phase inference for Paper 3 (Normalization Testing).
#          Key safeguards:
#            - H1/H3 sensor streams: one participant-phase mean per condition (REML LMM).
#            - H1/H3 questionnaires: one participant-phase row (never duplicated across 10-s epochs).
#            - Planned simple contrasts are explicit: BikeG-BikeU, WalkG-WalkU,
#              WalkU-BikeU, and WalkG-BikeG, plus marginal effects.
#            - Duration sensitivity: first 8 minutes and phase-mean subtraction using Indoor and Tram baselines.
#            - H2: psychological-physiological concurrence via person-mean-centered LMMs (Van Doren et al. 2021; Cuve et al. 2023).
#            - H4 environmental stressors: single-predictor REML LMMs across all physiological outcomes and environmental streams (PET, UTCI, noise, light, air pollution).
#            - 10-second epoch rows are not treated as independent inferential units.
#            - Failed/unstable models are written to Model_Audit.csv; never silently skipped.
# ==============================================================================

suppressPackageStartupMessages({
  library(nlme)
  library(emmeans)
  library(ggplot2)
})
emm_options(msg.interaction = FALSE)
set.seed(20260717)

# 1. Configuration & dictionaries ---------------------------------------------
WD <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
PROJECT_ROOT <- if (basename(WD) == "scripts") dirname(WD) else WD
SIBLING_DATA_ROOT <- file.path(dirname(PROJECT_ROOT), "Paper3_Github")

RAW_PATH <- Sys.getenv("PAPER3_RAW_PATH", file.path(SIBLING_DATA_ROOT, "output", "merged_all_11participants.csv"))
KEY_PATH <- Sys.getenv("PAPER3_KEY_PATH", file.path(SIBLING_DATA_ROOT, "output", "key.csv"))
OUT_DIR <- Sys.getenv("PAPER3_OUT_DIR", unset = file.path(PROJECT_ROOT, "output", "normalization_test"))
SCRIPT_PATH <- Sys.getenv("PAPER3_SCRIPT_PATH", unset = file.path(PROJECT_ROOT, "scripts", "Normalization_Test.R"))
MAKE_FIGURES <- tolower(Sys.getenv("PAPER3_MAKE_FIGURES", unset = "false")) %in% c("1", "true", "yes")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

PARTICIPANTS   <- c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17")
CORE_PHASES    <- c("BikeU", "WalkU", "BikeG", "WalkG")
H4_PHASES      <- c(CORE_PHASES, "Tram")
MATCHED_CAP_SEC <- 8 * 60

OUTCOMES <- list(
  Psychological = c("questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
                    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"),
  Physiological_Autonomic = c("empatica_heart_rate", "empatica_eda_tonic", "empatica_eda_phasic",
                              "empatica_skin_temperature", "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd"),
  Physiological_Ocular = c("eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate",
                           "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s",
                           "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
                           "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity",
                           "eyetracker_gaze_velocity", "eyetracker_gaze_dispersion",
                           "eyetracker_distance_from_center", "eyetracker_gaze_centrality",
                           "eyetracker_eyelid_aperture_avg")
)
all_outcomes      <- unlist(OUTCOMES, use.names = FALSE)
outcome_group_map <- setNames(rep(names(OUTCOMES), lengths(OUTCOMES)), all_outcomes)

clean_labels <- c(
  "questionnaire_current_comfort_1_7"   = "General Comfort (1-7)",
  "questionnaire_pleasantness_1_5"      = "Pleasantness (1-5)",
  "questionnaire_stai6_mean_1_5"        = "State Anxiety (STAI-6)",
  "questionnaire_prs11_total_mean_1_5"  = "Restorativeness (PRS-11)",
  "empatica_heart_rate"                 = "Heart Rate (bpm)",
  "empatica_eda_tonic"                  = "EDA Tonic Level (SCL)",
  "empatica_eda_phasic"                 = "EDA Phasic (SCR)",
  "empatica_skin_temperature"           = "Skin Temperature (°C)",
  "empatica_hrv_td_sdnn"                = "HRV (SDNN)",
  "empatica_hrv_td_rmssd"               = "HRV (RMSSD)",
  "eyetracker_pupil_diameter_avg"       = "Pupil Diameter (mm)",
  "eyetracker_pupil_change_rate"        = "Pupil Change Rate",
  "eyetracker_blink_duration_s"         = "Blink Duration (s)",
  "eyetracker_fixation_duration_s"      = "Fixation Duration (s)",
  "eyetracker_fixation_rate"            = "Fixation Rate (/s)",
  "eyetracker_saccade_duration_s"       = "Saccade Duration (s)",
  "eyetracker_saccade_amplitude"        = "Saccade Amplitude (°)",
  "eyetracker_saccade_peak_velocity"    = "Saccade Peak Velocity (°/s)",
  "eyetracker_gaze_velocity"            = "Gaze Velocity (°/s)",
  "eyetracker_gaze_dispersion"          = "Gaze Dispersion",
  "eyetracker_gaze_centrality"          = "Gaze Centrality",
  "eyetracker_distance_from_center"     = "Gaze Distance from Center (px)",
  "eyetracker_eyelid_aperture_avg"      = "Eyelid Aperture (mm)"
)

# 2. Reusable Helper Functions -------------------------------------------------
mean_na <- function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)
safe_rbind <- function(x) if (length(x) > 0) do.call(rbind, x) else data.frame()

safe_write_csv <- function(data, path) {
  res <- tryCatch({
    write.csv(data, path, row.names = FALSE, na = "")
    TRUE
  }, error = function(e) {
    warning(sprintf("File locked by Excel or another process: %s. Attempting fallback...", path))
    FALSE
  })
  if (!res) {
    alt_path <- sub("\\.csv$", "_latest.csv", path)
    tryCatch(write.csv(data, alt_path, row.names = FALSE, na = ""), error = function(e) NULL)
  }
}

fit_phase_lmm <- function(fml, data, method = "REML") {
  tryCatch(
    lme(as.formula(fml), random = ~ 1 | ParticipantID, data = data, method = method,
        na.action = na.omit,
        control = lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE)),
    error = function(e) NULL
  )
}

model_data_ok <- function(data, outcome, min_rows, min_participants) {
  x <- data[[outcome]]
  nrow(data) >= min_rows && length(unique(data$ParticipantID)) >= min_participants &&
    is.finite(sd(x, na.rm = TRUE)) && sd(x, na.rm = TRUE) != 0
}

within_person_z <- function(x, id) {
  ave(as.numeric(x), id, FUN = function(v) {
    m <- mean(v, na.rm = TRUE)
    s <- sd(v, na.rm = TRUE)
    if (!is.finite(s) || s == 0) rep(NA_real_, length(v)) else (v - m) / s
  })
}

add_group_adjustments <- function(tab, group_col) {
  if (nrow(tab) == 0) return(tab)
  groups <- tab[[group_col]]
  tab$q_FDR <- ave(tab$p_value, groups, FUN = function(p) p.adjust(p, method = "BH"))
  tab
}

model_cohens_d <- function(cnt, fit) {
  if (!inherits(fit, "lme")) {
    return(c(d = NA_real_, low = NA_real_, high = NA_real_))
  }
  vars <- as.numeric(VarCorr(fit)[, "Variance"])
  vars <- vars[is.finite(vars)]
  rand_var <- if (length(vars) > 1) sum(head(vars, -1L)) else 0
  res_var <- sigma(fit)^2
  sd_tot <- sqrt(rand_var + res_var)
  if (!is.finite(sd_tot) || sd_tot <= 0) {
    return(c(d = NA_real_, low = NA_real_, high = NA_real_))
  }
  c(d = cnt$estimate / sd_tot, low = cnt$lower.CL / sd_tot, high = cnt$upper.CL / sd_tot)
}

interaction_summary <- function(fit) {
  a <- tryCatch(as.data.frame(anova(fit))["Mode:Environment", , drop = FALSE],
                error = function(e) NULL)
  if (is.null(a) || nrow(a) == 0) return("NA")
  p <- suppressWarnings(as.numeric(a[["p-value"]][1]))
  f <- suppressWarnings(as.numeric(a[["F-value"]][1]))
  den <- suppressWarnings(as.numeric(a$denDF[1]))
  if (!is.finite(p)) return("NA")
  sprintf("F(1,%s)=%.2f, p=%.4f", ifelse(is.finite(den), as.character(round(den)), "NA"), f, p)
}

contrast_result <- function(contrast_id, estimate, outcome) {
  if (!is.finite(estimate)) return(NA_character_)
  route_pairs <- list(
    H1_Bike = c("BikeG", "BikeU"),
    H1_Walk = c("WalkG", "WalkU"),
    H3_Urban = c("WalkU", "BikeU"),
    H3_Green = c("WalkG", "BikeG")
  )
  if (!contrast_id %in% names(route_pairs)) return(NA_character_)
  pair <- route_pairs[[contrast_id]]
  if (estimate < 0) pair <- rev(pair)
  sprintf("%s > %s for %s", pair[1], pair[2], outcome)
}

make_result_row <- function(hypothesis, sub_hypothesis, contrast_id, contrast_label,
                            outcome, outcome_group, condition, duration, normalization,
                            family_set, fit, cnt, reference_mean, comparison_mean,
                            reference_n, comparison_n, model_formula, interaction_test) {
  d <- model_cohens_d(cnt, fit)
  data.frame(
    Sub_Hypothesis = sub_hypothesis,
    Contrast = contrast_label,
    Outcome_Group = outcome_group,
    Outcome = outcome,
    Predictor = ifelse(hypothesis == "H1", "Environment", "Mode"),
    Result = contrast_result(contrast_id, cnt$estimate, outcome),
    Condition = condition,
    Duration = duration,
    Normalization = normalization,
    Model_Formula = model_formula,
    Interaction_Test = interaction_test,
    Estimate_SD = cnt$estimate,
    SE = cnt$SE,
    df = cnt$df,
    p_value = cnt$p.value,
    Cohens_d_LMM = d["d"],
    CI95_low = d["low"],
    CI95_high = d["high"],
    Reference_Mean = reference_mean,
    Comparison_Mean = comparison_mean,
    Reference_N = reference_n,
    Comparison_N = comparison_n,
    # Internal keys kept for family adjustment and plotting; omitted before final CSV save
    Hypothesis = hypothesis,
    Contrast_ID = contrast_id,
    Family_Set = family_set,
    stringsAsFactors = FALSE
  )
}

extract_h1_h3 <- function(fit, d, value_col, outcome, outcome_group, condition,
                          duration, normalization, family_set, model_formula) {
  h1 <- list(); h3 <- list()
  int_txt <- interaction_summary(fit)
  add_row <- function(hyp, sub, cid, label, cnt, ref, comp) {
    row <- make_result_row(
      hyp, sub, cid, label, outcome, outcome_group, condition, duration, normalization,
      family_set, fit, cnt, mean(d[[value_col]][ref], na.rm = TRUE),
      mean(d[[value_col]][comp], na.rm = TRUE), sum(ref), sum(comp), model_formula, int_txt
    )
    if (hyp == "H1") h1[[length(h1) + 1]] <<- row else h3[[length(h3) + 1]] <<- row
  }

  em_h1 <- emmeans(fit, ~ Environment | Mode, weights = "equal")
  c_h1 <- as.data.frame(summary(contrast(
    em_h1, method = list(Green_minus_Urban = c(-1, 1)), infer = c(TRUE, TRUE)
  )))
  for (i in seq_len(nrow(c_h1))) {
    md <- as.character(c_h1$Mode[i])
    add_row("H1", ifelse(md == "Bike", "H1.1", "H1.2"),
            ifelse(md == "Bike", "H1_Bike", "H1_Walk"),
            sprintf("Green - Urban within %s", md), c_h1[i, ],
            d$Environment == "Urban" & d$Mode == md,
            d$Environment == "Green" & d$Mode == md)
  }

  em_h3 <- emmeans(fit, ~ Mode | Environment, weights = "equal")
  c_h3 <- as.data.frame(summary(contrast(
    em_h3, method = list(Walk_minus_Bike = c(-1, 1)), infer = c(TRUE, TRUE)
  )))
  for (i in seq_len(nrow(c_h3))) {
    ev <- as.character(c_h3$Environment[i])
    add_row("H3", ifelse(ev == "Urban", "H3.1", "H3.2"),
            ifelse(ev == "Urban", "H3_Urban", "H3_Green"),
            sprintf("Walk - Bike within %s", ev), c_h3[i, ],
            d$Mode == "Bike" & d$Environment == ev,
            d$Mode == "Walk" & d$Environment == ev)
  }

  list(h1 = h1, h3 = h3)
}

adjust_by_family <- function(tab, family_size_map = NULL) {
  if (nrow(tab) == 0) return(tab)
  tab$Correction_Family <- paste(tab$Hypothesis, tab$Family_Set, tab$Contrast_ID,
                                 tab$Normalization, sep = "__")
  tab$q_FDR <- NA_real_
  tab$Family_Size <- NA_integer_

  for (fam in unique(tab$Correction_Family)) {
    idx <- which(tab$Correction_Family == fam)
    p <- tab$p_value[idx]
    fs <- as.character(tab$Family_Set[idx[1]])
    planned_n <- if (!is.null(family_size_map) && fs %in% names(family_size_map)) {
      as.integer(family_size_map[[fs]])
    } else {
      sum(!is.na(p))
    }
    planned_n <- max(planned_n, sum(!is.na(p)))
    tab$q_FDR[idx] <- p.adjust(p, method = "BH")
    tab$Family_Size[idx] <- planned_n
  }

  tab$FDR_significance <- !is.na(tab$q_FDR) & tab$q_FDR < 0.05
  tab
}

within_subject_rank_corr <- function(data, x, y, id = "ParticipantID", covar_x = NULL, covar_y = NULL) {
  needed_cols <- c(id, x, y)
  if (!is.null(covar_x)) needed_cols <- c(needed_cols, covar_x)
  if (!is.null(covar_y)) needed_cols <- c(needed_cols, covar_y)
  missing_cols <- setdiff(needed_cols, names(data))
  if (length(missing_cols) > 0) return(NULL)
  d <- data[complete.cases(data[, needed_cols]), needed_cols, drop = FALSE]
  counts <- table(d[[id]])
  keep <- names(counts[counts >= 2])
  d <- d[d[[id]] %in% keep, , drop = FALSE]
  if (nrow(d) < 8 || length(unique(d[[id]])) < 3) return(NULL)

  # Rank transformation preserves monotonic/Spearman-like robustness.
  # Decompose the predictor into within-person and between-person components so
  # the primary coefficient represents concordance across phases WITHIN a person.
  d$ParticipantID <- factor(d[[id]])
  d$rx <- rank(d[[x]], ties.method = "average")
  d$ry <- rank(d[[y]], ties.method = "average")
  d$rx_person_mean <- ave(d$rx, d$ParticipantID, FUN = mean)
  d$rx_within <- d$rx - d$rx_person_mean

  if (!is.finite(sd(d$rx_within)) || sd(d$rx_within) == 0) return(NULL)

  # Model formula: basic within/between person decomposition, with optional
  # baseline rank covariates (Method 1: ANCOVA/Covariate adjustment)
  cov_terms <- character(0)
  if (!is.null(covar_x) && covar_x %in% names(d)) {
    d$rcov_x <- as.numeric(scale(rank(d[[covar_x]], ties.method = "average")))
    cov_terms <- c(cov_terms, "rcov_x")
  }
  if (!is.null(covar_y) && covar_y %in% names(d)) {
    d$rcov_y <- as.numeric(scale(rank(d[[covar_y]], ties.method = "average")))
    cov_terms <- c(cov_terms, "rcov_y")
  }

  fml_str <- paste("ry ~ rx_within + rx_person_mean",
                   if (length(cov_terms) > 0) paste("+", paste(cov_terms, collapse = " + ")) else "")

  fit <- tryCatch(
    lme(as.formula(fml_str), random = ~ 1 | ParticipantID,
        data = d, method = "REML", na.action = na.omit,
        control = lmeControl(opt = "optim", maxIter = 300, msMaxIter = 300, returnObject = TRUE)),
    error = function(e) NULL
  )
  if (is.null(fit)) return(NULL)
  tt <- summary(fit)$tTable
  if (!"rx_within" %in% rownames(tt)) return(NULL)

  tval <- as.numeric(tt["rx_within", "t-value"])
  dfree <- as.numeric(tt["rx_within", "DF"])
  p <- as.numeric(tt["rx_within", "p-value"])
  r_partial <- sign(tval) * sqrt(tval^2 / (tval^2 + dfree))

  naive <- suppressWarnings(cor.test(d[[x]], d[[y]], method = "spearman", exact = FALSE))
  list(r = r_partial, p = p, df = dfree, n = nrow(d),
       participants = length(unique(d$ParticipantID)),
       naive_rho = unname(naive$estimate), naive_p = naive$p.value)
}

# Canonical merged schema plus Indoor reconstruction ---------------------------
hms_to_sec <- function(x) {
  x <- as.character(x)
  out <- rep(NA_real_, length(x))
  good <- !is.na(x) & nzchar(x)
  if (any(good)) {
    sp <- strsplit(x[good], ":", fixed = TRUE)
    out[good] <- vapply(sp, function(z) {
      if (length(z) != 3) return(NA_real_)
      as.numeric(z[1]) * 3600 + as.numeric(z[2]) * 60 + as.numeric(z[3])
    }, numeric(1))
  }
  out
}

harmonize_schema <- function(data, key_path) {
  # The committed merged file leaves non-route epochs blank. Recover Indoor from
  # key.csv, but first align key.csv's clock to the merged Datetime clock. The
  # offset is derived independently for each participant from the already-labeled
  # Bike/Walk/Tram phase starts; this avoids hard-coding a timezone offset.
  if (file.exists(key_path) && all(c("ParticipantID", "PhaseID", "Datetime") %in% names(data))) {
    key <- read.csv(key_path, stringsAsFactors = FALSE, check.names = FALSE)
    ref_phases <- c("BikeU", "WalkU", "BikeG", "WalkG", "Tram")
    needed_key <- c("Participant_ID", "Indoor_start", "Indoor_end", paste0(ref_phases, "_start"))
    if (all(needed_key %in% names(key))) {
      row_sec <- hms_to_sec(format(as.POSIXct(data$Datetime, tz = "UTC"), "%H:%M:%S"))
      blank_phase <- is.na(data$PhaseID) | trimws(as.character(data$PhaseID)) == ""
      circular_diff <- function(a, b) {
        d <- a - b
        d[d > 43200] <- d[d > 43200] - 86400
        d[d < -43200] <- d[d < -43200] + 86400
        d
      }

      for (i in seq_len(nrow(key))) {
        pid_raw <- trimws(as.character(key$Participant_ID[i]))
        pid <- ifelse(grepl("^P", pid_raw, ignore.case = TRUE), toupper(pid_raw), paste0("P", pid_raw))
        diffs <- numeric(0)

        for (ph in ref_phases) {
          key_start <- hms_to_sec(key[[paste0(ph, "_start")]][i])
          idx_ph <- data$ParticipantID == pid & data$PhaseID == ph & is.finite(row_sec)
          if (!is.finite(key_start) || !any(idx_ph)) next
          observed_start <- min(row_sec[idx_ph], na.rm = TRUE)
          diffs <- c(diffs, circular_diff(observed_start, key_start))
        }

        # Require several independently labelled phases and a tight clock offset.
        # This prevents accidental relabelling of blank epochs as Indoor.
        if (length(diffs) < 3) next
        offset_spread <- max(diffs, na.rm = TRUE) - min(diffs, na.rm = TRUE)
        if (!is.finite(offset_spread) || offset_spread > 30) next
        offset <- median(diffs, na.rm = TRUE)
        st <- hms_to_sec(key$Indoor_start[i])
        en <- hms_to_sec(key$Indoor_end[i])
        if (!is.finite(st) || !is.finite(en)) next
        st_aligned <- (st + offset) %% 86400
        en_aligned <- (en + offset) %% 86400

        # 10-second epochs are rounded to a grid; allow half an epoch at boundaries.
        tol <- 5
        if (st_aligned <= en_aligned) {
          in_time <- row_sec >= (st_aligned - tol) & row_sec <= (en_aligned + tol)
        } else {
          in_time <- row_sec >= (st_aligned - tol) | row_sec <= (en_aligned + tol)
        }
        hit <- blank_phase & data$ParticipantID == pid & in_time
        data$PhaseID[hit] <- "Indoor"

      }
    }
  }

  data
}

# 3. Data Loading & Feature Engineering ----------------------------------------
cat("[1/6] Loading and formatting dataset...\n")
if (!file.exists(RAW_PATH)) stop("Input dataset not found: ", RAW_PATH)
df <- read.csv(RAW_PATH, check.names = FALSE, stringsAsFactors = FALSE)
df$ParticipantID <- as.character(df$ParticipantID)
df$PhaseID <- as.character(df$PhaseID)
df <- harmonize_schema(df, KEY_PATH)

missing_participants <- setdiff(PARTICIPANTS, unique(df$ParticipantID))
if (length(missing_participants) > 0) {
  stop("Verified 11-participant input is incomplete. Missing: ",
       paste(missing_participants, collapse = ", "))
}
phase_grid <- expand.grid(ParticipantID = PARTICIPANTS, PhaseID = CORE_PHASES,
                          stringsAsFactors = FALSE)
present_grid <- unique(df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES,
                          c("ParticipantID", "PhaseID")])
grid_key <- paste(phase_grid$ParticipantID, phase_grid$PhaseID, sep = "::")
present_key <- paste(present_grid$ParticipantID, present_grid$PhaseID, sep = "::")
missing_cells <- phase_grid[!grid_key %in% present_key, , drop = FALSE]
if (nrow(missing_cells) > 0) {
  stop("Core within-subject design is incomplete; missing participant-phase cells: ",
       paste(paste(missing_cells$ParticipantID, missing_cells$PhaseID, sep = "/"), collapse = ", "))
}
core_time_key <- paste(df$ParticipantID, df$PhaseID, df$Datetime, sep = "::")
core_idx <- df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% c(CORE_PHASES, "Tram")
if (anyDuplicated(core_time_key[core_idx])) {
  stop("Duplicate ParticipantID/PhaseID/Datetime keys detected in active/Tram data.")
}
cat("   Input:", RAW_PATH, "\n")
cat("   Rows/columns:", nrow(df), "/", ncol(df),
    "| Participants:", length(intersect(PARTICIPANTS, unique(df$ParticipantID))),
    "of", length(PARTICIPANTS), "| Indoor rows:",
    sum(df$PhaseID == "Indoor", na.rm = TRUE), "\n")

# Atmotube left/right were both carried by the researcher; average the pair
# as a contextual air-quality estimate. If a pair is unavailable, return NA
# instead of aborting the whole analysis.
safe_pair_mean <- function(data, left, right) {
  if (!all(c(left, right) %in% names(data))) return(rep(NA_real_, nrow(data)))
  z <- rowMeans(cbind(as.numeric(data[[left]]), as.numeric(data[[right]])), na.rm = TRUE)
  z[is.nan(z)] <- NA_real_
  z
}
pair_map <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
)
for (nm in names(pair_map)) df[[nm]] <- do.call(safe_pair_mean, c(list(df), pair_map[[nm]]))

lys_participant_map <- c(
  lys_lux_participant = "atmo_lys_LYS1__lys_lux"
)
for (nm in names(lys_participant_map)) {
  src <- lys_participant_map[[nm]]
  df[[nm]] <- if (src %in% names(df)) as.numeric(df[[src]]) else NA_real_
}

# Route Dataset Preparation ------------------------------------------------------
sensor_outcomes <- intersect(c(OUTCOMES$Physiological_Autonomic, OUTCOMES$Physiological_Ocular), names(df))
psych_outcomes  <- intersect(OUTCOMES$Psychological, names(df))
if (length(sensor_outcomes) == 0) stop("No declared physiological/ocular outcome columns are available after schema harmonization.")
if (length(psych_outcomes) == 0) warning("No declared psychological outcome columns are available; H1/H3 questionnaire and H2 analyses will be empty.")

# Identify complete, comprehensive environmental predictors set early (M outcomes x N environmental features)
exclude_env_metadata <- c(
  "atmo_lys_Date", "ucm_Date", "ucm_GPS_lat", "ucm_GPS_lon", "ucm_IO_flag",
  "atmo_lys_LYS1__lux_cat", "atmo_lys_LYS2__lux_cat", "ucm_fp", "ucm_GPS_speed_valid_sample_count"
)
all_env_candidates <- grep("^(atmo_|lys_|atmo_lys_|ucm_)", names(df), value = TRUE)
all_env_candidates <- setdiff(all_env_candidates, exclude_env_metadata)

env_predictors <- character(0)
for (nm in all_env_candidates) {
  val <- suppressWarnings(as.numeric(df[[nm]]))
  if (sum(!is.na(val)) > 50 && length(unique(na.omit(val))) > 1) {
    env_predictors <- c(env_predictors, nm)
  }
}
env_predictors <- unique(c(env_predictors, "atmo_pm2.5_avg", "lys_lux_avg"))
env_predictors <- intersect(env_predictors, names(df))

# Within-person standardization is calculated from all available observations for
# each participant before phase averaging, so full and matched analyses use the
# same personal reference distribution.
within_person_vars <- unique(c(sensor_outcomes, env_predictors))
within_person_vars <- intersect(within_person_vars, names(df))
for (outcome in within_person_vars) {
  df[[paste0("wpz__", outcome)]] <- within_person_z(df[[outcome]], df$ParticipantID)
}

route <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% CORE_PHASES, ]
route$Datetime           <- as.POSIXct(route$Datetime, tz = "UTC")
if (anyNA(route$Datetime)) stop("Unparseable Datetime values found in core route data.")
route$ParticipantID      <- factor(route$ParticipantID, levels = PARTICIPANTS)
route$Mode               <- factor(ifelse(grepl("^Bike", route$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))
route$Environment        <- factor(ifelse(grepl("U$", route$PhaseID), "Urban", "Green"), levels = c("Urban", "Green"))
route$ModeEnvironment    <- interaction(route$Mode, route$Environment, drop = TRUE)
route$ParticipantPhaseID <- interaction(route$ParticipantID, route$PhaseID, drop = TRUE)
route <- route[order(route$ParticipantID, route$PhaseID, route$Datetime), ]

route$time_in_phase_sec <- ave(as.numeric(route$Datetime), route$ParticipantPhaseID,
                               FUN = function(x) x - min(x, na.rm = TRUE))
route$time_min   <- route$time_in_phase_sec / 60
route$time_10sec <- route$time_in_phase_sec / 10

durations <- aggregate(time_in_phase_sec ~ ParticipantID + PhaseID, route, max, na.rm = TRUE)
dur_w <- reshape(durations, idvar = "ParticipantID", timevar = "PhaseID", direction = "wide")
names(dur_w) <- sub("time_in_phase_sec\\.", "", names(dur_w))
for (nm in CORE_PHASES) if (!nm %in% names(dur_w)) dur_w[[nm]] <- NA_real_
dur_w$Common_cap <- pmin(dur_w$BikeU, dur_w$BikeG, dur_w$WalkU, dur_w$WalkG,
                         MATCHED_CAP_SEC, na.rm = FALSE)
route <- merge(route, dur_w[c("ParticipantID", "Common_cap")],
               by = "ParticipantID", all.x = TRUE, sort = FALSE)
route$matched_cap_sec <- route$Common_cap

CONDITIONS <- list(
  "Primary: Full Duration" = route,
  "Sensitivity: Matched duration <=8 min" =
    route[!is.na(route$matched_cap_sec) & route$time_in_phase_sec <= route$matched_cap_sec, ]
)

# Participant-level baselines (Indoor = resting baseline, Tram = transit baseline)
base_all_outcomes <- unique(c(sensor_outcomes, psych_outcomes))
base_src <- df[df$ParticipantID %in% PARTICIPANTS & df$PhaseID %in% c("Indoor", "Tram"),
               unique(c("ParticipantID", "PhaseID", base_all_outcomes)), drop = FALSE]
base_phase <- if (nrow(base_src) > 0) {
  aggregate(base_src[base_all_outcomes], by = base_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
} else {
  z <- data.frame(ParticipantID = character(0), PhaseID = character(0), stringsAsFactors = FALSE)
  for (nm in base_all_outcomes) z[[nm]] <- numeric(0)
  z
}
base_phase$ParticipantID <- as.character(base_phase$ParticipantID)

# 4. H1/H3: sensors at 10-s resolution + questionnaires at phase resolution ----
cat("[2/6] Fitting corrected H1/H3 models...\n")
h1_list <- list(); h3_list <- list(); model_audit <- list()

declared_missing <- setdiff(all_outcomes, names(df))
if (length(declared_missing) > 0) {
  for (outcome in declared_missing) {
    model_audit[[length(model_audit) + 1]] <- data.frame(
      Analysis = "Input_schema", Condition = "All", Outcome = outcome,
      Status = "NOT_AVAILABLE_IN_INPUT", N_rows = 0, N_participants = 0,
      Temporal_Rho_Not_Used = NA_real_, Warning = "",
      Error = "Declared outcome could not be constructed because its source column is absent from this input.",
      stringsAsFactors = FALSE
    )
  }
}

# 4A. Continuous sensor outcomes: primary inference at participant-phase level.
# One mean per participant x phase keeps the experimental unit at the participant
# level and avoids treating thousands of 10-second epochs as independent.
# The matched first-8-minute analysis addresses duration variation across participants.
for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  family_set <- ifelse(grepl("^Primary", cname), "Primary", "Matched8min")

  value_cols <- c(sensor_outcomes, paste0("wpz__", sensor_outcomes))
  sensor_phase <- aggregate(
    d_cond[value_cols],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  sensor_phase$ParticipantID <- as.character(sensor_phase$ParticipantID)
  sensor_phase$Mode <- factor(sensor_phase$Mode, levels = c("Bike", "Walk"))
  sensor_phase$Environment <- factor(sensor_phase$Environment, levels = c("Urban", "Green"))

  for (outcome in sensor_outcomes) {
    for (norm_label in c("-", "Within-Person Z-score")) {
      value_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", outcome) else outcome
      d <- sensor_phase[complete.cases(sensor_phase[, c(value_col, "Mode", "Environment", "ParticipantID")]), ]

      model_cols <- c("Mode", "Environment", "ParticipantID", "outcome_z")
      d$outcome_z <- if (norm_label == "Within-Person Z-score") d[[value_col]] else as.numeric(scale(d[[value_col]]))
      d <- d[complete.cases(d[, model_cols, drop = FALSE]), , drop = FALSE]
      d$ParticipantID <- factor(d$ParticipantID, levels = PARTICIPANTS)
      n_pid <- length(unique(d$ParticipantID))

      if (!model_data_ok(d, "outcome_z", 28, 8)) next

      fml <- "outcome_z ~ Mode * Environment"
      fit <- fit_phase_lmm(fml, d, method = "REML")
      if (is.null(fit)) next

      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H1H3_sensor_phase_mean", Condition = cname, Outcome = outcome,
        Status = "FIT", N_rows = nrow(d), N_participants = n_pid,
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE
      )

      ex <- extract_h1_h3(
        fit, d, "outcome_z", outcome, outcome_group_map[outcome], cname,
        ifelse(family_set == "Primary", "Full", "Matched_start_8min"), norm_label,
        family_set, sprintf("%s_z ~ Mode * Environment + (1|ParticipantID)", outcome)
      )
      h1_list <- c(h1_list, ex$h1)
      h3_list <- c(h3_list, ex$h3)
    }
  }
}

# 4B. Psychological outcomes: participant-phase level.
# Evaluated across Duration ('Full', 'Matched_start_8min') and Normalization ('-', 'Covariate Indoor', 'Covariate Tram', 'Within-Person Z-score').
for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  family_set <- ifelse(grepl("^Primary", cname), "Primary", "Matched8min")
  dur_label <- ifelse(family_set == "Primary", "Full", "Matched_start_8min")

  psych_src <- d_cond[d_cond$ParticipantID %in% PARTICIPANTS & d_cond$PhaseID %in% CORE_PHASES,
                      unique(c("ParticipantID", "PhaseID", psych_outcomes)), drop = FALSE]
  psych_phase <- if (length(psych_outcomes) > 0 && nrow(psych_src) > 0) {
    aggregate(psych_src[psych_outcomes],
              by = psych_src[c("ParticipantID", "PhaseID")], FUN = mean_na)
  } else {
    data.frame(ParticipantID = character(0), PhaseID = character(0), stringsAsFactors = FALSE)
  }
  if (nrow(psych_phase) > 0) {
    psych_phase$ParticipantID <- factor(psych_phase$ParticipantID, levels = PARTICIPANTS)
    psych_phase$Mode <- factor(ifelse(grepl("^Bike", psych_phase$PhaseID), "Bike", "Walk"),
                               levels = c("Bike", "Walk"))
    psych_phase$Environment <- factor(ifelse(grepl("U$", psych_phase$PhaseID), "Urban", "Green"),
                                     levels = c("Urban", "Green"))
    for (outcome in psych_outcomes) {
      psych_phase[[paste0("wpz__", outcome)]] <- within_person_z(psych_phase[[outcome]], psych_phase$ParticipantID)
    }
  }

  for (outcome in psych_outcomes) {
    for (norm_label in c("-", "Within-Person Z-score")) {
      value_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", outcome) else outcome
      d <- psych_phase[complete.cases(psych_phase[, c(value_col, "Mode", "Environment", "ParticipantID")]), ]

      model_cols <- c("Mode", "Environment", "ParticipantID", "outcome_z")
      d$outcome_z <- if (norm_label == "Within-Person Z-score") d[[value_col]] else as.numeric(scale(d[[value_col]]))
      d <- d[complete.cases(d[, model_cols, drop = FALSE]), , drop = FALSE]
      if (!model_data_ok(d, "outcome_z", 28, 8)) next

      fml <- "outcome_z ~ Mode * Environment"
      fit <- fit_phase_lmm(fml, d, method = "REML")
      if (is.null(fit)) next

      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = "H1H3_questionnaire", Condition = cname, Outcome = outcome,
        Status = "FIT", N_rows = nrow(d), N_participants = length(unique(d$ParticipantID)),
        Temporal_Rho_Not_Used = NA_real_, Warning = "", Error = "", stringsAsFactors = FALSE)

      ex <- extract_h1_h3(
        fit, d, "outcome_z", outcome, outcome_group_map[outcome],
        cname, dur_label, norm_label,
        family_set, sprintf("%s_z ~ Mode * Environment + (1|ParticipantID)", outcome)
      )
      h1_list <- c(h1_list, ex$h1)
      h3_list <- c(h3_list, ex$h3)
    }
  }
}

N_PLANNED_SENSOR_OUTCOMES <- length(OUTCOMES$Physiological_Autonomic) + length(OUTCOMES$Physiological_Ocular)
N_PLANNED_ALL_OUTCOMES <- length(all_outcomes)

# 4C. Baseline sensitivity: participant-phase means minus Indoor / Tram baselines.
# Negative change scores are valid and mean "below baseline"; they are NOT
# negative physical conductance values. Evaluated across both Full and Matched 8-min durations.
for (cname in names(CONDITIONS)) {
  dur_label <- ifelse(grepl("^Primary", cname), "Full", "Matched_start_8min")
  active_df <- CONDITIONS[[cname]]
  active_phase <- aggregate(active_df[sensor_outcomes],
                            by = active_df[c("ParticipantID", "PhaseID")], FUN = mean_na)
  active_phase$ParticipantID <- as.character(active_phase$ParticipantID)
  active_phase$Mode <- factor(ifelse(grepl("^Bike", active_phase$PhaseID), "Bike", "Walk"),
                              levels = c("Bike", "Walk"))
  active_phase$Environment <- factor(ifelse(grepl("U$", active_phase$PhaseID), "Urban", "Green"),
                                     levels = c("Urban", "Green"))

  for (outcome in sensor_outcomes) {
    ind <- base_phase[base_phase$PhaseID == "Indoor", c("ParticipantID", outcome), drop = FALSE]
    names(ind)[2] <- "Indoor_baseline"
    trm <- base_phase[base_phase$PhaseID == "Tram", c("ParticipantID", outcome), drop = FALSE]
    names(trm)[2] <- "Tram_baseline"

    d0 <- merge(active_phase[, c("ParticipantID", "PhaseID", "Mode", "Environment", outcome), drop = FALSE],
                ind, by = "ParticipantID", all.x = TRUE)
    d0 <- merge(d0, trm, by = "ParticipantID", all.x = TRUE)

    for (bm in c("Indoor", "Tram")) {
      base_col <- paste0(bm, "_baseline")
      d <- d0
      d$analysis_value <- d[[outcome]] - d[[base_col]]
      d <- d[complete.cases(d[, c("analysis_value", "Mode", "Environment", "ParticipantID")]), ]
      d$ParticipantID <- factor(d$ParticipantID, levels = PARTICIPANTS)

      if (!model_data_ok(d, "analysis_value", 28, 7)) {
        model_audit[[length(model_audit) + 1]] <- data.frame(
          Analysis = paste0("Baseline_", bm), Condition = paste(cname, "phase means"), Outcome = outcome,
          Status = "NOT_FIT_INSUFFICIENT_BASELINE", N_rows = nrow(d),
          N_participants = length(unique(d$ParticipantID)), Temporal_Rho_Not_Used = NA_real_,
          Warning = "", Error = "", stringsAsFactors = FALSE)
        next
      }

      d$outcome_z <- as.numeric(scale(d$analysis_value))
      fit <- fit_phase_lmm("outcome_z ~ Mode * Environment", d, method = "REML")
      ok <- !is.null(fit)
      model_audit[[length(model_audit) + 1]] <- data.frame(
        Analysis = paste0("Baseline_", bm), Condition = paste(cname, "phase means"), Outcome = outcome,
        Status = ifelse(ok, "FIT", "NOT_FIT"), N_rows = nrow(d),
        N_participants = length(unique(d$ParticipantID)), Temporal_Rho_Not_Used = NA_real_,
        Warning = "", Error = "",
        stringsAsFactors = FALSE)
      if (!ok) next

      ex <- extract_h1_h3(
        fit, d, "analysis_value", outcome, outcome_group_map[outcome],
        paste0("Baseline sensitivity: ", bm, " subtraction"),
        dur_label, bm,
        paste0("Baseline_", gsub("\\+", "_", bm)),
        sprintf("(%s_phase_mean - %s_baseline)_z ~ Mode * Environment + (1|ParticipantID)", outcome, bm)
      )
      h1_list <- c(h1_list, ex$h1)
      h3_list <- c(h3_list, ex$h3)
    }
  }
}

# Adjust all H1/H3 families (Primary, Matched8min, Baseline_Indoor, Baseline_Tram)
all_h13_family_sizes <- c(
  Primary = N_PLANNED_ALL_OUTCOMES,
  Matched8min = N_PLANNED_SENSOR_OUTCOMES,
  Baseline_Indoor = N_PLANNED_SENSOR_OUTCOMES,
  Baseline_Tram = N_PLANNED_SENSOR_OUTCOMES
)
h1_table <- adjust_by_family(safe_rbind(h1_list), all_h13_family_sizes)
h3_table <- adjust_by_family(safe_rbind(h3_list), all_h13_family_sizes)

# 4D. Temporal Time-Series Mixed Models with AR(1) Autocorrelation -------------
# Evaluates longitudinal slopes over time and Environment/Mode interactions
# using all 10-second epoch observations while accounting for serial autocorrelation.
cat("[2b/6] Fitting 10-second temporal time-series LMMs with AR(1) autocorrelation...\n")
temporal_results_list <- list()

# Prepare 10-s epoch dataset with time steps for AR(1)
route_ar1 <- route
route_ar1$time_10s_step <- round(route_ar1$time_in_phase_sec / 10)
route_ar1$PhaseID <- factor(route_ar1$PhaseID, levels = CORE_PHASES)

for (outc in sensor_outcomes) {
  outc_grp <- outcome_group_map[outc]
  needed <- c("ParticipantID", "PhaseID", "Mode", "Environment", "time_min", "time_10s_step", outc)
  d_ts <- route_ar1[complete.cases(route_ar1[, needed, drop = FALSE]), needed, drop = FALSE]
  d_ts <- d_ts[!duplicated(paste(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step)), ]
  d_ts <- d_ts[order(d_ts$ParticipantID, d_ts$PhaseID, d_ts$time_10s_step), ]
  if (!model_data_ok(d_ts, outc, 100, 8)) next

  d_ts$outcome_z <- as.numeric(scale(d_ts[[outc]]))

  fit_ar1 <- tryCatch(
    lme(
      fixed = outcome_z ~ Mode * Environment * time_min,
      random = ~ 1 | ParticipantID / PhaseID,
      correlation = corAR1(form = ~ time_10s_step | ParticipantID / PhaseID),
      data = d_ts, method = "REML", na.action = na.omit,
      control = lmeControl(opt = "optim", maxIter = 100, msMaxIter = 100, returnObject = TRUE)
    ),
    error = function(e) NULL
  )

  if (!is.null(fit_ar1)) {
    tt <- as.data.frame(summary(fit_ar1)$tTable)
    phi_val <- tryCatch(as.numeric(coef(fit_ar1$modelStruct$corStruct, unconstrained = FALSE)),
                        error = function(e) NA_real_)

    for (term_nm in rownames(tt)) {
      temporal_results_list[[length(temporal_results_list) + 1]] <- data.frame(
        Analysis = "TimeSeries_AR1_LMM",
        Outcome_Group = outc_grp,
        Outcome = outc,
        Term = term_nm,
        Model_Formula = sprintf("%s_z ~ Mode * Environment * time_min + (1|ParticipantID/PhaseID) + corAR1(time_10s_step | ParticipantID/PhaseID)", outc),
        Estimate_Std = tt[term_nm, "Value"],
        SE = tt[term_nm, "Std.Error"],
        df = tt[term_nm, "DF"],
        t_value = tt[term_nm, "t-value"],
        p_value = tt[term_nm, "p-value"],
        AR1_Phi = phi_val,
        N_Epochs = nrow(d_ts),
        N_Participants = length(unique(d_ts$ParticipantID)),
        stringsAsFactors = FALSE
      )
    }
  }
}

temporal_table <- safe_rbind(temporal_results_list)
if (nrow(temporal_table) > 0) {
  temporal_table$q_FDR <- ave(temporal_table$p_value, temporal_table$Term,
                              FUN = function(p) p.adjust(p, method = "BH"))
  temporal_table$FDR_significance <- !is.na(temporal_table$q_FDR) & temporal_table$q_FDR < 0.05
}

# 5. H2: Psychological–Physiological Concurrence ----------------------------
# METHODOLOGICAL FOUNDATION (Van Doren et al., 2021; Cuve et al., 2023):
# Evaluates whether within-person changes in psychological state across experimental
# phases correspond to acute changes in autonomic physiology and ocular metrics.
# Both modalities are aggregated to the exact matching participant-phase level.
# Model architecture:
#   Physiology_z ~ Mode + scale(Psych_within) + scale(Psych_between) + (1 | ParticipantID)
#   Covariate branches add: + baseline_covariate_z
# Evaluated across all 4 Psychological scales x 19 Physiological outcomes (76 pairs)
# x Durations ('Full', 'Matched_start_8min') x Normalizations ('-', 'Within-Person Z-score', 'Covariate Indoor', 'Covariate Tram').
cat("[3/6] Evaluating H2 psychological-physiological concurrence (Van Doren 2021; Cuve 2023)...\n")

h2_physio_outcomes <- intersect(sensor_outcomes, names(df))
h2_psych_outcomes  <- intersect(psych_outcomes, names(df))

# Prepare baseline lookups for H2 Covariate branches
ind_base_phys <- base_phase[base_phase$PhaseID == "Indoor", c("ParticipantID", h2_physio_outcomes), drop = FALSE]
names(ind_base_phys)[-1] <- paste0(names(ind_base_phys)[-1], "_IndoorBase")

trm_base_phys <- base_phase[base_phase$PhaseID == "Tram", c("ParticipantID", h2_physio_outcomes), drop = FALSE]
names(trm_base_phys)[-1] <- paste0(names(trm_base_phys)[-1], "_TramBase")

h2_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- ifelse(grepl("^Primary", cname), "Full", "Matched_start_8min")

  # Phase aggregation across core route phases + Tram
  h2_needed_raw <- unique(c("ParticipantID", "PhaseID", "Mode", "Environment", h2_physio_outcomes, h2_psych_outcomes))
  h2_needed_raw <- intersect(h2_needed_raw, names(d_cond))

  h2_phase_df <- aggregate(
    d_cond[setdiff(h2_needed_raw, c("ParticipantID", "PhaseID", "Mode", "Environment"))],
    by = d_cond[c("ParticipantID", "PhaseID", "Mode", "Environment")],
    FUN = mean_na
  )
  if (nrow(h2_phase_df) == 0) next

  h2_phase_df$ParticipantID <- factor(h2_phase_df$ParticipantID, levels = PARTICIPANTS)
  h2_phase_df$Mode <- factor(h2_phase_df$Mode, levels = c("Bike", "Walk"))

  # Merge baseline lookups
  h2_phase_df <- merge(h2_phase_df, ind_base_phys, by = "ParticipantID", all.x = TRUE)
  h2_phase_df <- merge(h2_phase_df, trm_base_phys, by = "ParticipantID", all.x = TRUE)

  for (norm_label in c("-", "Within-Person Z-score")) {

    for (psych_var in h2_psych_outcomes) {
      clean_psych_name <- clean_labels[psych_var]
      if (is.na(clean_psych_name)) clean_psych_name <- psych_var

      for (phys_var in h2_physio_outcomes) {
        phys_grp <- outcome_group_map[phys_var]
        clean_phys_name <- clean_labels[phys_var]
        if (is.na(clean_phys_name)) clean_phys_name <- phys_var

        d_sub <- h2_phase_df

        # Check required columns
        needed_cols <- c("ParticipantID", "Mode", psych_var, phys_var)

        d_sub <- d_sub[complete.cases(d_sub[, needed_cols, drop = FALSE]), , drop = FALSE]
        if (!model_data_ok(d_sub, phys_var, 20, 8)) next

        # Physiological outcome transformation
        if (norm_label == "Within-Person Z-score") {
          d_sub$phys_z <- within_person_z(d_sub[[phys_var]], d_sub$ParticipantID)
          d_sub$psych_z <- within_person_z(d_sub[[psych_var]], d_sub$ParticipantID)
          fml_str <- "phys_z ~ Mode + psych_z"
          term_interest <- "psych_z"
        } else {
          # Person-mean-centering of psychological predictor (Van Doren et al. 2021)
          # Decomposes into within-person state deviation and between-person trait mean
          psych_between <- ave(d_sub[[psych_var]], d_sub$ParticipantID, FUN = mean_na)
          psych_within  <- d_sub[[psych_var]] - psych_between
          d_sub$psych_within_z  <- as.numeric(scale(psych_within))
          d_sub$psych_between_z <- as.numeric(scale(psych_between))
          d_sub$phys_z <- as.numeric(scale(d_sub[[phys_var]]))

          fml_str <- "phys_z ~ Mode + psych_within_z + psych_between_z"
          term_interest <- "psych_within_z"
        }

        fit_h2 <- fit_phase_lmm(fml_str, d_sub, method = "REML")
        if (is.null(fit_h2)) next

        tt_h2 <- summary(fit_h2)$tTable
        if (!term_interest %in% rownames(tt_h2)) next

        b_val  <- as.numeric(tt_h2[term_interest, "Value"])
        se_val <- as.numeric(tt_h2[term_interest, "Std.Error"])
        t_val  <- as.numeric(tt_h2[term_interest, "t-value"])
        df_val <- as.numeric(tt_h2[term_interest, "DF"])
        p_val  <- as.numeric(tt_h2[term_interest, "p-value"])
        r_part <- sign(t_val) * sqrt(t_val^2 / (t_val^2 + df_val))

        # Raw directional description (used only if FDR significant)
        raw_direction_desc <- if (b_val >= 0) {
          sprintf("Higher %s corresponds to higher %s", clean_psych_name, clean_phys_name)
        } else {
          sprintf("Higher %s corresponds to lower %s", clean_psych_name, clean_phys_name)
        }

        model_desc <- if (norm_label == "Within-Person Z-score") {
          sprintf("wpz(%s) ~ Mode + wpz(%s) + (1|ParticipantID)", phys_var, psych_var)
        } else {
          sprintf("%s_z ~ Mode + %s_within + %s_between + (1|ParticipantID)", phys_var, psych_var, psych_var)
        }

        h2_results_list[[length(h2_results_list) + 1]] <- data.frame(
          Sub_Hypothesis = "H2.1",
          Model_Type = "Psych_Physio_Concurrence",
          Psychological_Measure = psych_var,
          Physiological_Measure = phys_var,
          Outcome_Group = phys_grp,
          Duration = dur_label,
          Normalization = norm_label,
          Model_Formula = model_desc,
          Raw_Direction = raw_direction_desc,
          Beta_Within_Std = b_val,
          SE = se_val,
          t_stat = t_val,
          df = df_val,
          p_value = p_val,
          Partial_r_Within = r_part,
          N_PhaseBouts = nrow(d_sub),
          N_Participants = length(unique(d_sub$ParticipantID)),
          stringsAsFactors = FALSE
        )
      }
    }
  }
}

h2_table <- safe_rbind(h2_results_list)
if (nrow(h2_table) > 0) {
  # Omnibus FDR correction across all 76 psych-physio pairs per Duration x Normalization family
  h2_family_key <- paste(h2_table$Duration, h2_table$Normalization, sep = "__")
  h2_table$q_FDR <- ave(h2_table$p_value, h2_family_key,
                        FUN = function(p) p.adjust(p, method = "BH"))
  h2_table$FDR_significance <- !is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05

  # Literature-based expectation dictionary (grounded in established psychophysiology)
  # Physiological response to positive/restorative state (Comfort, Pleasantness, PRS):
  #   STAI-6 is an anxiety scale (higher = worse/more anxious), so expected sign is inverted.
  lit_dict <- list(
    empatica_heart_rate = list(
      pos_exp_sign = -1,
      interpretability = "Established",
      citation = "Van Doren et al. (2021) Biol Psychol; Ulrich et al. (1991) J Environ Psychol",
      note = "Heart rate decreases during positive/restorative states reflecting reduced cardiovascular strain"
    ),
    empatica_eda_tonic = list(
      pos_exp_sign = -1,
      interpretability = "Established",
      citation = "Boucsein (2012) Electrodermal Activity; Ulrich et al. (1991) J Environ Psychol",
      note = "Tonic skin conductance level (SCL) decreases with reduced sympathetic arousal"
    ),
    empatica_eda_phasic = list(
      pos_exp_sign = -1,
      interpretability = "Established",
      citation = "Boucsein (2012) Electrodermal Activity; Dawson et al. (2017) Cambridge Handb Psychophysiol",
      note = "Phasic skin conductance responses (SCR) decrease with lower acute sympathetic reactivity"
    ),
    empatica_hrv_td_rmssd = list(
      pos_exp_sign = 1,
      interpretability = "Established",
      citation = "Laborde et al. (2017) Front Psychol; Shaffer & Ginsberg (2017) Front Public Health",
      note = "RMSSD increases reflecting greater parasympathetic/vagal tone and autonomic recovery"
    ),
    empatica_hrv_td_sdnn = list(
      pos_exp_sign = 1,
      interpretability = "Moderate/Cautious",
      citation = "Shaffer & Ginsberg (2017) Front Public Health; Task Force ESC/NASPE (1996) Circulation",
      note = "SDNN reflects overall autonomic variability, generally higher with lower stress but sensitive to respiratory and physical activity"
    ),
    # Context-dependent metrics: No unconditional directional support/contradiction
    empatica_skin_temperature = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Romanovsky (2014) Handb Clin Neurol; Charkoudian (2010) Auton Neurosci",
      note = "Skin temperature reflects environmental thermal exchange, convective airflow, and vasomotor tone rather than pure psychological state"
    ),
    eyetracker_pupil_diameter_avg = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Cuve et al. (2023) Psychophysiology; Mathot (2018) Front Integr Neurosci",
      note = "Pupil diameter is heavily dominated by ambient retinal illuminance and cognitive visual exploration"
    ),
    eyetracker_pupil_change_rate = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Cuve et al. (2023) Psychophysiology",
      note = "Pupil change rate reflects rapid light transitions and active visual processing across outdoor environments"
    ),
    eyetracker_blink_duration_s = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Schleicher et al. (2008) Ergonomics; Bentivoglio et al. (1997) Mov Disord",
      note = "Blink duration is modulated by ambient airflow, fatigue, visual attention, and emotional valence"
    ),
    eyetracker_fixation_duration_s = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull; Berto et al. (2008) J Environ Psychol",
      note = "Fixation duration depends on scene complexity, visual task demands, and restorative soft fascination"
    ),
    eyetracker_fixation_rate = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Fixation rate varies with navigation scanning density and movement velocity"
    ),
    eyetracker_saccade_duration_s = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Saccade kinematics are task- and navigation-driven in active mobility"
    ),
    eyetracker_saccade_amplitude = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull; Franconeri et al. (2013) Trends Cogn Sci",
      note = "Saccade amplitude reflects spatial extent of visual scanning in urban vs green environments"
    ),
    eyetracker_saccade_peak_velocity = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Saccade peak velocity is constrained by the main sequence and motor exploration requirements"
    ),
    eyetracker_gaze_velocity = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Rayner (1998) Psychol Bull",
      note = "Overall gaze velocity reflects active physical mobility speed and environmental hazard tracking"
    ),
    eyetracker_gaze_dispersion = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Valtchanov & Ellard (2015) J Environ Psychol",
      note = "Visual dispersion reflects visual exploratory breadth vs concentrated forward path tracking"
    ),
    eyetracker_distance_from_center = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Tatler (2007) J Vis",
      note = "Central visual bias vs peripheral exploration depends on forward travel mode and route obstacles"
    ),
    eyetracker_gaze_centrality = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Tatler (2007) J Vis",
      note = "Forward gaze concentration is heavily governed by cycling vs walking navigation constraints"
    ),
    eyetracker_eyelid_aperture_avg = list(
      pos_exp_sign = NA_real_,
      interpretability = "Context-dependent",
      citation = "Stern et al. (1994) Psychophysiology",
      note = "Eyelid aperture is directly influenced by solar glare, wind speed, and alertness"
    )
  )

  # Assign literature metadata and conditional interpretation
  n_rows <- nrow(h2_table)
  lit_exp_dir <- character(n_rows)
  lit_interp_cat <- character(n_rows)
  lit_citation <- character(n_rows)
  h2_result_col <- character(n_rows)
  h2_interp_col <- character(n_rows)

  for (i in seq_len(n_rows)) {
    p_meas <- h2_table$Psychological_Measure[i]
    y_meas <- h2_table$Physiological_Measure[i]
    is_fdr_sig <- isTRUE(h2_table$FDR_significance[i])
    b_val <- h2_table$Beta_Within_Std[i]
    raw_dir <- h2_table$Raw_Direction[i]

    entry <- lit_dict[[y_meas]]
    interp_cat <- if (!is.null(entry)) entry$interpretability else "Unclassified"
    cit_val <- if (!is.null(entry)) entry$citation else ""

    # Expected sign based on psychological orientation:
    # Comfort, Pleasantness, PRS: higher = better state
    # STAI-6: higher = worse/more anxious state (inverted expectation)
    is_anxiety <- grepl("stai", p_meas, ignore.case = TRUE)
    pos_exp <- if (!is.null(entry)) entry$pos_exp_sign else NA_real_

    exp_sign <- if (!is.na(pos_exp)) {
      if (is_anxiety) -pos_exp else pos_exp
    } else {
      NA_real_
    }

    exp_dir_label <- if (is.na(exp_sign)) {
      "Context-dependent"
    } else if (exp_sign > 0) {
      "Positive (+)"
    } else {
      "Negative (-)"
    }

    lit_exp_dir[i] <- exp_dir_label
    lit_interp_cat[i] <- interp_cat
    lit_citation[i] <- cit_val

    # Interpretation logic per user requirements:
    # 1. Result column: only describe direction if FDR significant; otherwise "No FDR-significant concurrence"
    if (!is_fdr_sig) {
      h2_result_col[i] <- "No FDR-significant concurrence"
      h2_interp_col[i] <- "No evidence of concurrence (q_FDR >= 0.05)"
    } else {
      h2_result_col[i] <- raw_dir
      if (interp_cat == "Context-dependent" || is.na(exp_sign)) {
        h2_interp_col[i] <- "Significant concurrence; direction not uniquely interpretable"
      } else {
        obs_sign <- sign(b_val)
        if (obs_sign == exp_sign) {
          h2_interp_col[i] <- "Literature-consistent concurrence"
        } else {
          h2_interp_col[i] <- "Opposite to literature-expected direction"
        }
      }
    }
  }

  h2_table$Result <- h2_result_col
  h2_table$Literature_Expected_Direction <- lit_exp_dir
  h2_table$Literature_Interpretability <- lit_interp_cat
  h2_table$Literature_Citation <- lit_citation
  h2_table$H2_Interpretation <- h2_interp_col
  h2_table$Raw_Direction <- NULL
}

cat("[4/6] Evaluating comprehensive M x N environmental models across Duration & Normalization...\n")
h4_all_outcomes <- intersect(sensor_outcomes, names(df))
wpz_env_cols <- paste0("wpz__", env_predictors)
wpz_out_cols <- paste0("wpz__", h4_all_outcomes)
h4_needed_cols <- unique(c("ParticipantID", "PhaseID", h4_all_outcomes, env_predictors,
                           wpz_out_cols, wpz_env_cols))
h4_needed_cols <- intersect(h4_needed_cols, names(df))

# Prepare Indoor and Tram baseline tables for physiological outcomes
ind_base <- base_phase[base_phase$PhaseID == "Indoor", c("ParticipantID", h4_all_outcomes), drop = FALSE]
names(ind_base)[-1] <- paste0(names(ind_base)[-1], "_IndoorBase")

trm_base <- base_phase[base_phase$PhaseID == "Tram", c("ParticipantID", h4_all_outcomes), drop = FALSE]
names(trm_base)[-1] <- paste0(names(trm_base)[-1], "_TramBase")

h4_results_list <- list()

for (cname in names(CONDITIONS)) {
  d_cond <- CONDITIONS[[cname]]
  dur_label <- ifelse(grepl("^Primary", cname), "Full", "Matched_start_8min")

  # Aggregate route data by participant and phase
  cond_phase <- aggregate(
    d_cond[setdiff(h4_needed_cols, c("ParticipantID", "PhaseID"))],
    by = d_cond[c("ParticipantID", "PhaseID")],
    FUN = mean_na
  )
  cond_phase$ParticipantID <- factor(cond_phase$ParticipantID, levels = PARTICIPANTS)
  cond_phase$Mode <- factor(ifelse(grepl("^Bike", cond_phase$PhaseID), "Bike", "Walk"),
                            levels = c("Bike", "Walk"))
  cond_phase$Environment <- factor(ifelse(grepl("U$", cond_phase$PhaseID), "Urban", "Green"),
                                   levels = c("Urban", "Green"))

  # Merge indoor and tram baselines for subtraction sensitivity
  cond_phase_ind <- merge(cond_phase, ind_base, by = "ParticipantID", all.x = TRUE)
  cond_phase_ind <- merge(cond_phase_ind, trm_base, by = "ParticipantID", all.x = TRUE)

  for (norm_label in c("-", "Indoor", "Tram", "Within-Person Z-score")) {

    for (outc in h4_all_outcomes) {
      outc_grp <- outcome_group_map[outc]

      # Setup outcome data based on normalization. Indoor and Tram subtraction are baseline sensitivities.
      h4_curr_phase <- cond_phase_ind
      if (norm_label == "Indoor") {
        base_col <- paste0(outc, "_IndoorBase")
        if (!base_col %in% names(h4_curr_phase)) next
        h4_curr_phase$curr_outc <- h4_curr_phase[[outc]] - h4_curr_phase[[base_col]]
      } else if (norm_label == "Tram") {
        base_col <- paste0(outc, "_TramBase")
        if (!base_col %in% names(h4_curr_phase)) next
        h4_curr_phase$curr_outc <- h4_curr_phase[[outc]] - h4_curr_phase[[base_col]]
      } else if (norm_label == "Within-Person Z-score") {
        wpz_col <- paste0("wpz__", outc)
        if (!wpz_col %in% names(h4_curr_phase)) next
        h4_curr_phase$curr_outc <- h4_curr_phase[[wpz_col]]
      } else {
        h4_curr_phase$curr_outc <- h4_curr_phase[[outc]]
      }

      # ------------------------------------------------------------------------
      # H4.1: Single-Predictor (Univariable) Models: Outcome ~ Mode + Predictor
      # Evaluated across all environmental variables (PET, UTCI, MRT, SND, Atmotube, LYS, etc.)
      # ------------------------------------------------------------------------
      for (pred in env_predictors) {
        pred_col <- if (norm_label == "Within-Person Z-score") paste0("wpz__", pred) else pred
        needed_s <- c("curr_outc", pred_col, "Mode", "ParticipantID")
        if (!all(needed_s %in% names(h4_curr_phase))) next
        d_s <- h4_curr_phase[complete.cases(h4_curr_phase[, needed_s, drop = FALSE]), , drop = FALSE]
        if (!model_data_ok(d_s, "curr_outc", 20, 8)) next

        d_s$outcome_z <- if (norm_label == "Within-Person Z-score") d_s$curr_outc else as.numeric(scale(d_s$curr_outc))
        d_s$pred_z <- if (norm_label == "Within-Person Z-score") d_s[[pred_col]] else as.numeric(scale(d_s[[pred_col]]))

        fml_s <- "outcome_z ~ Mode + pred_z"
        fit_s <- fit_phase_lmm(fml_s, d_s, method = "REML")
        if (!is.null(fit_s)) {
          tt_s <- summary(fit_s)$tTable
          if ("pred_z" %in% rownames(tt_s)) {
            h4_results_list[[length(h4_results_list) + 1]] <- data.frame(
              Sub_Hypothesis = "H4.1",
              Model_Type = "Single_Predictor",
              Predictor = pred,
              Duration = dur_label,
              Normalization = norm_label,
              Outcome_Group = outc_grp,
              Outcome = outc,
              Model_Formula = sprintf("%s_z ~ Mode + %s + (1|ParticipantID)", outc,
                                      ifelse(norm_label == "Within-Person Z-score",
                                             paste0("wpz(", pred, ")"), paste0("scale(", pred, ")"))),
              Beta_Std = tt_s["pred_z", "Value"],
              SE = tt_s["pred_z", "Std.Error"],
              t_stat = tt_s["pred_z", "t-value"],
              df = tt_s["pred_z", "DF"],
              p_value = tt_s["pred_z", "p-value"],
              Result = ifelse(tt_s["pred_z", "Value"] >= 0,
                              sprintf("Higher %s is associated with higher %s", pred, outc),
                              sprintf("Higher %s is associated with lower %s", pred, outc)),
              N_rows = nrow(d_s),
              stringsAsFactors = FALSE
            )
          }
        }
      }

    }
  }
}

h4_table <- safe_rbind(h4_results_list)
if (nrow(h4_table) > 0) {
  h4_table$Correction_Family <- paste(h4_table$Sub_Hypothesis, h4_table$Predictor,
                                      h4_table$Duration, h4_table$Normalization, sep = "__")
  h4_table$q_FDR <- ave(h4_table$p_value, h4_table$Correction_Family, FUN = function(p) p.adjust(p, method = "BH"))
  h4_table$Correction_Family <- NULL
  h4_table$FDR_significance <- !is.na(h4_table$q_FDR) & h4_table$q_FDR < 0.05
}

# 7. Write Dedicated CSV Tables ------------------------------------------------
cat("[5/6] Writing corrected outputs...\n")

# Clean output columns: drop internal keys (Hypothesis, Contrast_ID, Family_Set, Correction_Family, Family_Size, and boolean flags)
h1_cols_keep <- c("Sub_Hypothesis", "Contrast", "Outcome_Group", "Outcome", "Condition", "Duration",
                  "Predictor", "Result", "Normalization", "Model_Formula", "Interaction_Test", "Estimate_SD", "SE", "df",
                  "p_value", "q_FDR", "FDR_significance", "Cohens_d_LMM", "CI95_low", "CI95_high",
                  "Reference_Mean", "Comparison_Mean", "Reference_N", "Comparison_N")
h1_clean_table <- h1_table[, intersect(h1_cols_keep, names(h1_table)), drop = FALSE]
h3_clean_table <- h3_table[, intersect(h1_cols_keep, names(h3_table)), drop = FALSE]

h2_cols_keep <- c("Sub_Hypothesis", "Model_Type", "Psychological_Measure", "Physiological_Measure",
                  "Outcome_Group", "Duration", "Normalization", "Model_Formula", "Result",
                  "Beta_Within_Std", "SE", "t_stat", "df", "p_value", "Partial_r_Within",
                  "N_PhaseBouts", "N_Participants", "q_FDR", "FDR_significance",
                  "Literature_Expected_Direction", "Literature_Interpretability",
                  "Literature_Citation", "H2_Interpretation")
h2_clean_table <- h2_table[, intersect(h2_cols_keep, names(h2_table)), drop = FALSE]

h4_cols_keep <- c("Sub_Hypothesis", "Model_Type", "Predictor", "Duration", "Normalization", "Outcome_Group", "Outcome", "Model_Formula",
                  "Result", "Beta_Std", "SE", "t_stat", "df", "p_value", "q_FDR", "FDR_significance", "N_rows")

h4_single_table <- h4_table[, intersect(h4_cols_keep, names(h4_table)), drop = FALSE]

safe_write_csv(h1_clean_table, file.path(OUT_DIR, "H1_Green_vs_Urban.csv"))
safe_write_csv(h3_clean_table, file.path(OUT_DIR, "H3_Walk_vs_Bike.csv"))
safe_write_csv(h2_clean_table, file.path(OUT_DIR, "H2_Physio_Psycho_Concordance.csv"))

# Dedicated companion literature interpretation reference table
lit_companion_df <- do.call(rbind, lapply(names(lit_dict), function(mname) {
  item <- lit_dict[[mname]]
  data.frame(
    Physiological_Measure = mname,
    Outcome_Group = if (grepl("^empatica", mname)) "Physiological_Autonomic" else "Physiological_Ocular",
    Expected_Direction_Positive_State = if (is.na(item$pos_exp_sign)) "Context-dependent" else if (item$pos_exp_sign > 0) "Higher (+)" else "Lower (-)",
    Expected_Direction_Anxious_State_STAI = if (is.na(item$pos_exp_sign)) "Context-dependent" else if (item$pos_exp_sign > 0) "Lower (-)" else "Higher (+)",
    Interpretability = item$interpretability,
    Literature_Citation = item$citation,
    Theoretical_Note = item$note,
    stringsAsFactors = FALSE
  )
}))
safe_write_csv(lit_companion_df, file.path(OUT_DIR, "H2_Literature_Interpretation.csv"))
safe_write_csv(h4_single_table, file.path(OUT_DIR, "H4_Environmental_Stressors.csv"))
safe_write_csv(temporal_table, file.path(OUT_DIR, "H1_H3_Temporal_TimeSeries_AR1.csv"))
model_audit_df <- safe_rbind(model_audit)
safe_write_csv(model_audit_df, file.path(OUT_DIR, "Model_Audit.csv"))

# 8. Forest Plots: primary marginal H1/H3 only -------------------------------
if (MAKE_FIGURES) cat("[6/6] Rendering primary forest plots...\n") else cat("[6/6] Figures disabled; statistical outputs only.\n")
plot_df <- data.frame()
if (nrow(h1_table) > 0 && nrow(h3_table) > 0 &&
    all(c("Family_Set", "Contrast_ID") %in% names(h1_table)) &&
    all(c("Family_Set", "Contrast_ID") %in% names(h3_table))) {
  plot_h1 <- h1_table[h1_table$Family_Set == "Primary" & h1_table$Contrast_ID %in% c("H1_Bike", "H1_Walk"), , drop = FALSE]
  plot_h3 <- h3_table[h3_table$Family_Set == "Primary" & h3_table$Contrast_ID %in% c("H3_Urban", "H3_Green"), , drop = FALSE]
  if (nrow(plot_h1) > 0) plot_h1$Plot_Hypothesis <- "H1: Green vs Urban"
  if (nrow(plot_h3) > 0) plot_h3$Plot_Hypothesis <- "H3: Walk vs Bike"
  plot_df <- rbind(plot_h1, plot_h3)
}

if (MAKE_FIGURES && nrow(plot_df) > 0) {
  plot_df$Clean_Outcome <- clean_labels[plot_df$Outcome]
  plot_df$Clean_Outcome[is.na(plot_df$Clean_Outcome)] <- plot_df$Outcome[is.na(plot_df$Clean_Outcome)]
  plot_df$Direction <- ifelse(
    plot_df$Hypothesis == "H1",
    ifelse(plot_df$Cohens_d_LMM >= 0, "Higher in Green", "Higher in Urban"),
    ifelse(plot_df$Cohens_d_LMM >= 0, "Higher in Walking", "Higher in Biking")
  )
  plot_df$Label <- sprintf("d=%.2f%s", plot_df$Cohens_d_LMM,
                           ifelse(!is.na(plot_df$q_FDR) & plot_df$q_FDR < 0.05, "*", ""))

  p_forest <- ggplot(plot_df, aes(x = Cohens_d_LMM,
                                  y = reorder(Clean_Outcome, Cohens_d_LMM))) +
    geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6) +
    geom_errorbar(aes(xmin = CI95_low, xmax = CI95_high),
                  orientation = "y", width = 0.3, linewidth = 0.8) +
    geom_point(size = 3) +
    geom_text(aes(label = Label), vjust = -0.7, size = 3, show.legend = FALSE) +
    facet_wrap(~ Plot_Hypothesis, scales = "free_x") +
    labs(
      title = "Paper 3 primary mixed-model effect sizes",
      subtitle = "Sensors and questionnaires use one participant-phase value for primary inference. * FDR q < 0.05.",
      x = "Cohen's d_LMM (95% CI)", y = ""
    ) +
    theme_minimal(base_size = 11)
  ggsave(file.path(OUT_DIR, "Statistical_Results_ForestPlot.png"),
         plot = p_forest, width = 13.5, height = 9, dpi = 300)
}

# H4 plot
if (MAKE_FIGURES && nrow(h4_table) > 0) {
  h4_plot_df <- h4_table[h4_table$Sub_Hypothesis == "H4.1" & h4_table$Duration == "Full" & h4_table$Normalization == "-" & h4_table$Outcome_Group != "Psychological", ]
  h4_plot_df$CI_low <- h4_plot_df$Beta_Std - 1.96 * h4_plot_df$SE
  h4_plot_df$CI_high <- h4_plot_df$Beta_Std + 1.96 * h4_plot_df$SE
  h4_plot_df$Clean_Outcome <- clean_labels[h4_plot_df$Outcome]
  h4_plot_df$Clean_Outcome[is.na(h4_plot_df$Clean_Outcome)] <- h4_plot_df$Outcome[is.na(h4_plot_df$Clean_Outcome)]
  h4_plot_df$Clean_Predictor <- h4_plot_df$Predictor

  p_forest_h4 <- ggplot(h4_plot_df, aes(x = Beta_Std,
                                        y = reorder(Clean_Outcome, Beta_Std))) +
    geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.6) +
    geom_errorbar(aes(xmin = CI_low, xmax = CI_high),
                  orientation = "y", width = 0.3, linewidth = 0.7) +
    geom_point(size = 2.8) +
    facet_wrap(~ Clean_Predictor, scales = "free_x", ncol = 2) +
    labs(
      title = "H4: Environmental stressor models (Outcome ~ Mode + Predictor)",
      subtitle = "Phase-level mixed models; inferential model fitted with REML.",
      x = "Standardized beta (95% CI)", y = ""
    ) +
    theme_minimal(base_size = 10)
  ggsave(file.path(OUT_DIR, "ForestPlot_H4_Environmental_Stressors.png"),
         plot = p_forest_h4, width = 13.5, height = 11, dpi = 300)
}

# 9. Run Manifest --------------------------------------------------------------
script_path <- normalizePath(SCRIPT_PATH, winslash = "/", mustWork = FALSE)

manifest <- data.frame(
  Script = script_path,
  Script_MD5 = tryCatch(unname(tools::md5sum(script_path)), error = function(e) NA_character_),
  Input_File = RAW_PATH,
  Key_File = ifelse(file.exists(KEY_PATH), KEY_PATH, NA_character_),
  Input_Schema = "Prefixed validated schema",
  Input_MD5 = tryCatch(unname(tools::md5sum(RAW_PATH)), error = function(e) NA_character_),
  Input_Rows = nrow(df),
  Input_Columns = ncol(df),
  Input_Indoor_Rows = sum(df$PhaseID == "Indoor", na.rm = TRUE),
  Input_Tram_Rows = sum(df$PhaseID == "Tram", na.rm = TRUE),
  Available_Declared_Outcomes = length(intersect(all_outcomes, names(df))),
  Missing_Declared_Outcomes = paste(setdiff(all_outcomes, names(df)), collapse = ","),
  Common_Duration_Min_Sec = if (any(is.finite(route$matched_cap_sec))) min(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
  Common_Duration_Max_Sec = if (any(is.finite(route$matched_cap_sec))) max(route$matched_cap_sec, na.rm = TRUE) else NA_real_,
  Primary_Sensor_Model = "REML participant-phase-mean LMM; Mode*Environment + random Participant; 10-sec epochs are aggregated before inferential testing",
  Primary_Questionnaire_Model = "REML phase-level LMM; one participant-phase row; Mode*Environment + random Participant",
  Matched_Duration_Sensitivity = "Participant-specific common duration across BikeU/BikeG/WalkU/WalkG, capped at 8 minutes from phase start",
  Baseline_Sensitivities = "Phase mean minus Indoor and Tram subtraction sensitivities; Within-Person Z-score branch",
  H2_Method = "Psychological-physiological concurrence via person-mean-centered LMMs (Van Doren et al. 2021; Cuve et al. 2023) across 76 pairs (4 questionnaires x 19 autonomic/ocular outcomes); within-person state deviation and between-person trait mean decomposition",
  H4_Model_Selection = "H4.1 single-predictor REML models; no unified multivariable model; participant-worn LYS1 is primary light exposure",
  Multiple_Testing = "Benjamini-Hochberg FDR within each H1/H3 hypothesis, duration, and normalization family; H2 omnibus FDR across all 76 pairs per duration and normalization; H4 FDR by predictor, duration, and normalization",
  N_Participants = length(PARTICIPANTS),
  N_Declared_Outcomes = length(all_outcomes),
  Completed_At = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
  H1_Primary_Significant_FDR = if (nrow(h1_table) > 0) sum(h1_table$Family_Set == "Primary" & !is.na(h1_table$q_FDR) & h1_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H3_Primary_Significant_FDR = if (nrow(h3_table) > 0) sum(h3_table$Family_Set == "Primary" & !is.na(h3_table$q_FDR) & h3_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  H2_Significant_FDR = if (nrow(h2_table) > 0) sum(!is.na(h2_table$q_FDR) & h2_table$q_FDR < 0.05, na.rm = TRUE) else 0,
  Failed_or_Unstable_Models = if (nrow(model_audit_df) > 0) {
    sum(grepl("NOT_FIT|UNSTABLE", model_audit_df$Status))
  } else 0,
  stringsAsFactors = FALSE
)
write.csv(manifest, file.path(OUT_DIR, "Run_Manifest.csv"), row.names = FALSE, na = "")

# 10. Combined H1-H4 results ---------------------------------------------------
result_tables <- list(H1 = h1_clean_table, H2 = h2_clean_table,
                      H3 = h3_clean_table, H4 = h4_single_table)
result_tables <- Map(function(tab, hyp) {
  tab$Hypothesis <- hyp
  tab
}, result_tables, names(result_tables))
all_result_cols <- unique(unlist(lapply(result_tables, names)))
results_h1_4 <- do.call(rbind, lapply(result_tables, function(tab) {
  for (nm in setdiff(all_result_cols, names(tab))) tab[[nm]] <- NA
  tab[all_result_cols]
}))
rownames(results_h1_4) <- NULL
safe_write_csv(results_h1_4, file.path(OUT_DIR, "results_H1-4.csv"))
cat("   Combined H1-H4 results:", nrow(results_h1_4), "rows /",
    ncol(results_h1_4), "columns\n")

results_h1_h3 <- rbind(result_tables$H1, result_tables$H3)
safe_write_csv(results_h1_h3, file.path(OUT_DIR, "results_H1_H3.csv"))
cat("   Combined H1-H3 results:", nrow(results_h1_h3), "rows /",
    ncol(results_h1_h3), "columns\n")

cat("\nSUCCESS: corrected statistical pipeline completed.\n")
