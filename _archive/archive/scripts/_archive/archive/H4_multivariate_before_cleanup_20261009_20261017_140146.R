# ==============================================================================
# SCRIPT: H4_multivariate.R
# PURPOSE: Audit H4 variables and screen the complete eligible exposure set.
#          The previous outcome fitter below is retained as reference; it must
#          be migrated and its ordinal-outcome handling corrected before refitting.
#          H4_SELECTION_ONLY=1 refreshes selection audits and the preferred
#          faceted PDF, then exits before outcome fits or unrelated plots.
#
#          Generates:
#            1. Full variable-level H4 audit CSV.
#            2. H4 methodology figure with domain separation, stage counts,
#               participant-mean-centered VIF screening and shared model forms.
#            3. Domain audit figure.
#            4. All-variable stage-by-stage audit matrix PNG and a readable,
#               multi-page variable-level audit table PDF.
#            5. H4 audit-stage summary and sound/SVF integration-readiness CSVs.
#            6. Transparent retained/excluded counts by role, rule, domain,
#               VIF step, final role, and variable-level stop reason.
#            7. Human-readable H4 transparency report (Markdown).
#
# INPUT:
#   C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/merged_all_11participants_8min.csv
#
# OUTPUTS:
#   1. output/statistical_analysis/H4_multivariate/H4_Multivariate_Filtration_Results.csv
#   2. output/statistical_analysis/H4_multivariate/H4_Multivariate_Methodology.png
#   3. output/statistical_analysis/H4_multivariate/H4_Domain_Audit.png
#   4. output/statistical_analysis/H4_multivariate/H4_All_Variables_Audit.png
#   5. output/statistical_analysis/H4_multivariate/H4_All_Variables_Audit.pdf
#   6. output/statistical_analysis/H4_multivariate/H4_Audit_Stage_Summary.csv
#   7. output/statistical_analysis/H4_multivariate/H4_Integration_Readiness.csv
#   8. output/statistical_analysis/H4_multivariate/H4_Step_Category_Counts.csv
#   9. output/statistical_analysis/H4_multivariate/H4_Domain_Status_Counts.csv
#  10. output/statistical_analysis/H4_multivariate/H4_Exclusion_Detail.csv
#  11. output/statistical_analysis/H4_multivariate/H4_Final_Outcome_Counts.csv
#  12. output/statistical_analysis/H4_multivariate/H4_Transparency_Report.md
#  13. output/statistical_analysis/H4_multivariate/H4_Multivariate_Formula.txt
#  14. output/H4_models/H4_LMM_Results_Table.csv
#  15. output/H4_models/H4_LMM_Diagnostics.txt
#  16. output/statistical_analysis/H4_multivariate/H4_Phase_Coverage.csv
# ==============================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(gridExtra)
})

# ------------------------------------------------------------------------------
# 1. Config & File Paths
# ------------------------------------------------------------------------------
resolve_project_root <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)

  candidates <- character(0)
  if (length(file_arg)) {
    script_path <- sub("^--file=", "", file_arg[1])
    candidates <- c(candidates, file.path(dirname(script_path), ".."))
  }
  candidates <- c(candidates, getwd(), file.path(getwd(), ".."))

  for (candidate in unique(candidates)) {
    candidate <- normalizePath(candidate, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(candidate, "output", "merged_all_11participants_8min.csv"))) {
      return(candidate)
    }
  }

  stop(
    "Could not resolve Paper3_Final project root. Run this script from the ",
    "repository root/scripts directory or ensure output/merged_all_11participants_8min.csv exists."
  )
}

required_packages <- c("ggplot2", "gridExtra", "lme4", "lmerTest", "ordinal", "DHARMa")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)

grDevices::pdf(file = NULL) # Keep unsaved plotting away from the repository root.
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- file.path(PROJECT_ROOT, "output/merged_all_11participants_8min.csv")
# TIME-SERIES RESOLUTION NOTE:
# This file holds the matched 8-minute per-phase windows at full 10-second resolution
# (2156 rows; 11 participants x 5 phases capped at 480 s each). Steps 4 and 5 model
# these windows directly - one row per 10 s, with bout-level random intercepts and
# AR(1) errors on the within-phase Time10 index. No phase averaging occurs in any
# fitted model. Phase-cell aggregation appears only in Step 3, which is a
# measurement-provenance/correlation audit, not an outcome model.
# The 8-minute cap equalizes follow-up across phases so duration cannot confound the
# environment contrast; a full-uncapped-duration sensitivity run remains possible and
# is expected to add little independent information because within-phase windows are
# strongly autocorrelated (27 of 103 Step-5 fits still showed residual lag-1 > 0.2).
OUT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/H4_multivariate")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

# ==============================================================================
# STEP 6: PRIMARY-MODEL REPORTING LAYER (UTCI representation locked as primary)
# ------------------------------------------------------------------------------
# PURPOSE: The Step-5 fitted family (104 Joint models) was specified after seeing
#          the data, so no coefficient from it can be branded confirmatory. The
#          transparent fix is designation, not selection:
#            PRIMARY    : UTCI representation - internationally recommended outdoor
#                         thermal-stress index (Matzarakis/Mayer threshold literature;
#                         ISO/WMO precedent) - Joint block (thermal x noise +
#                         thermal x activity), all 26 outcomes, ALL terms reported.
#            SENSITIVITY: Components / HUMIDEX / PET representations, all reported,
#                         used only to qualify wording (robust vs representation-
#                         specific), never to promote or demote an outcome.
#          This step ONLY parses the frozen Step-5 report; it refits nothing,
#          performs no selection, and writes no hashed input.
# RUN:     H4_STEP6_PRIMARY=1 Rscript H4_multivariate.R
#          (dispatches here and exits before Steps 1-5; no data reload needed)
# OUTPUTS: output/statistical_analysis/H4_multivariate/H4_Step6_Primary_UTCI.csv
#          output/statistical_analysis/H4_multivariate/H4_Step6_Primary_Summary.md
#          output/statistical_analysis/H4_multivariate/H4_Step6_Primary_Report.pdf
#          (single consolidated PDF: Step-5 justification table -> equations -> results)
# ==============================================================================

h4_step5_fitted_equations <- function() {
  # Column order matches make_design() in h4_step5_equations.R:
  # nonthermal, then the thermal block, then Activity_Bike, then interactions.
  # Base / Noise / Activity were rank-and-VIF checks. Outcome coefficients were fit for Joint only.
  cov <- "ucm_SND_dBA + atmo_pm1_avg + gvi_50m + Clearness_Index"
  specs <- list(
    Components = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_MRT"),
    HUMIDEX = c("ucm_HUMIDEX", "ucm_MRT"),
    PET = "ucm_PET",
    UTCI = "ucm_UTCI"
  )
  blocks <- c("Base", "Noise", "Activity", "Joint")
  lines <- character()
  for (m in names(specs)) {
    vars <- specs[[m]]
    for (b in blocks) {
      extra <- character()
      if (b %in% c("Noise", "Joint")) extra <- c(extra, paste0(vars, ":SND_dBA"))
      if (b %in% c("Activity", "Joint")) extra <- c(extra, paste0(vars, ":Activity_Bike"))
      rhs <- paste(c(cov, vars, "Activity_Bike", extra), collapse = " + ")
      role <- if (b == "Joint") "FITTED" else "design check"
      lines <- c(lines, sprintf("%s | %s (%s): Y = b0 + %s", m, b, role, rhs),
        "        + (1 | ParticipantID/PhaseID) + corAR1(Time10 | ParticipantID/PhaseID)")
    }
  }
  lines
}

h4_step6_primary_report <- function() {
  report_path <- file.path(OUT_DIR, "H4_Step5_Equations_Checks.txt")
  lines <- readLines(report_path, warn = FALSE)

  # ---- Locate the authoritative windows in the frozen report ----
  # Fit window: the DISCRETE AR1 run explicitly supersedes the earlier continuous-AR1
  # fits; validation window: everything from "=== VALIDATION RUN:" to end of file.
  fit_start <- grep("FIT RUN START.*DISCRETE AR1", lines)
  stopifnot(length(fit_start) == 1L)
  fit_end <- min(grep("^=== ", lines[seq.int(fit_start + 1L, length(lines))])) + fit_start
  val_start <- grep("^=== VALIDATION RUN:", lines)
  stopifnot(length(val_start) == 1L)
  fit_lines <- lines[seq.int(fit_start + 1L, fit_end - 1L)]
  val_lines <- lines[seq.int(val_start + 1L, length(lines))]

  num <- "-?[0-9.]+(?:[eE][+-]?[0-9]+)?"
  # Term is a single token (no spaces); single-or-more spaces before the numeric fields -
  # long interaction terms get single-space column alignment in the printed tables.
  coef_re <- sprintf("^\\s*(\\S+)\\s+(%s)\\s+(%s)\\s+(%s)\\s+(%s)\\s+(%s)\\s*$",
                     num, num, num, num, num)

  parse_model_blocks <- function(seg, header_re) {
    starts <- grep(header_re, seg)
    lapply(seq_along(starts), function(i) {
      s <- starts[i]
      e <- if (i < length(starts)) starts[i + 1L] - 1L else length(seg)
      seg[s:e]
    })
  }

  # ---- Fit blocks: CR2 coefficient tables (Estimate, SE, DF, Low95, High95) ----
  fit_hdr <- "^\\s*Term\\s+Estimate\\s+CR2_SE\\s+DF\\s+Low95\\s+High95\\s*$"
  parse_fit_block <- function(blk) {
    # regmatches(regexec(...)) returns a LIST: unwrap element 1 (full match + 2 groups).
    m <- regmatches(blk[1L], regexec("^MODEL: (\\S+) (\\S+)\\s*$", blk[1L]))
    m <- if (length(m)) m[[1L]] else character(0L)
    outcome <- if (length(m) == 3L) m[2L] else NA_character_
    spec <- if (length(m) == 3L) m[3L] else NA_character_
    hdr <- grep(fit_hdr, blk)
    stop_at <- grep("CAR1 rho|Variance components:", blk)
    stop_at <- if (length(stop_at)) min(stop_at[stop_at > hdr]) else length(blk) + 1L
    rows <- if (length(hdr)) blk[(hdr + 1L):(stop_at - 1L)] else character(0L)
    rows <- rows[grepl(coef_re, rows)]
    coefs <- do.call(rbind, lapply(rows, function(r) {
      g <- regmatches(r, regexec(coef_re, r))[[1L]]
      data.frame(Term = trimws(g[2L]), Estimate = as.numeric(g[3L]), CR2_SE = as.numeric(g[4L]),
                 DF = as.numeric(g[5L]), Low95 = as.numeric(g[6L]), High95 = as.numeric(g[7L]))
    }))
    complete <- grep("^MODEL COMPLETE: ", blk, value = TRUE)
    list(outcome = outcome, spec = spec,
         successful = length(complete) == 1L && grepl("successful TRUE", complete),
         coefs = coefs)
  }

  # ---- Validation blocks: merged per-term stability table + curvature AIC ----
  val_hdr <- "^\\s*Term\\s+Full\\s+Delete_min\\s+Delete_max\\s+Sign_flips\\s+Max_abs_DFBETAS\\s+Worst_participant\\s*$"
  val_re <- sprintf("^\\s*(\\S+)\\s+(%s)\\s+(%s)\\s+(%s)\\s+([0-9]+)\\s+(%s)\\s+(\\S+)\\s*$",
                    num, num, num, num)
  parse_val_block <- function(blk) {
    m <- regmatches(blk[1L], regexec("^VALIDATION MODEL: (\\S+) (\\S+)\\s*$", blk[1L]))
    m <- if (length(m)) m[[1L]] else character(0L)
    v_outcome <- if (length(m) == 3L) m[2L] else NA_character_
    v_spec <- if (length(m) == 3L) m[3L] else NA_character_
    hdr <- grep(val_hdr, blk)
    stop_at <- grep("EXPOSURE SUPPORT:|CURVATURE SENSITIVITY:|VALIDATION RESULT:", blk)
    stop_at <- if (length(stop_at)) min(stop_at[stop_at > hdr]) else length(blk) + 1L
    rows <- if (length(hdr)) blk[(hdr + 1L):(stop_at - 1L)] else character(0L)
    rows <- rows[grepl(val_re, rows)]
    stab <- do.call(rbind, lapply(rows, function(r) {
      g <- regmatches(r, regexec(val_re, r))[[1L]]
      data.frame(Term = trimws(g[2L]), Full = as.numeric(g[3L]), Delete_min = as.numeric(g[4L]),
                 Delete_max = as.numeric(g[5L]), Sign_flips = as.integer(g[6L]),
                 Max_abs_DFBETAS = as.numeric(g[7L]), Worst_participant = g[8L])
    }))
    complete <- grep("^VALIDATION COMPLETE: ", blk, value = TRUE)
    aic <- grep("AIC quadratic minus linear:", blk, value = TRUE)
    del <- grep("^VALIDATION RESULT:", blk, value = TRUE)
    list(outcome = v_outcome, spec = v_spec,
         successful = length(complete) == 1L && grepl("successful TRUE", complete),
         curvature_aic = if (length(aic)) as.numeric(sub(".*AIC quadratic minus linear:\\s*(-?[0-9.]+).*", "\\1", aic)) else NA_real_,
         del_failures = if (length(del)) as.integer(sub(".*deletion failures\\s+([0-9]+).*", "\\1", del)) else NA_integer_,
         stab = stab)
  }

  fit_blocks <- lapply(parse_model_blocks(fit_lines, "^MODEL: "), parse_fit_block)
  val_blocks <- lapply(parse_model_blocks(val_lines, "^VALIDATION MODEL: "), parse_val_block)

  cat("Step 6 parsed:", length(fit_blocks), "fit blocks;", length(val_blocks), "validation blocks\n")
  fit_df <- do.call(rbind, lapply(fit_blocks, function(b) if (!is.null(b$coefs) && nrow(b$coefs)) data.frame(
    Outcome = b$outcome, Specification = b$spec, Successful = b$successful, b$coefs) else NULL))
  val_df <- do.call(rbind, lapply(val_blocks, function(b) if (!is.null(b$stab) && nrow(b$stab)) data.frame(
    Outcome = b$outcome, Specification = b$spec, Successful = b$successful,
    Curvature_AIC = b$curvature_aic, Deletion_failures = b$del_failures, b$stab) else NULL))
  stopifnot(!anyDuplicated(paste(fit_df$Outcome, fit_df$Specification, fit_df$Term)),
            !anyDuplicated(paste(val_df$Outcome, val_df$Specification, val_df$Term)))

  # ---- PRIMARY: UTCI coefficients (fit) merged with deletion stability (validation) ----
  primary_fit <- fit_df[fit_df$Specification == "UTCI", , drop = FALSE]
  primary_val <- val_df[val_df$Specification == "UTCI", , drop = FALSE]
  stopifnot(length(unique(primary_fit$Outcome)) == 26L, all(primary_fit$Successful),
            length(unique(primary_val$Outcome)) == 26L, all(primary_val$Successful))
  primary <- merge(primary_fit, primary_val[, names(primary_val) %in%
    c("Outcome", "Term", "Full", "Delete_min", "Delete_max", "Sign_flips",
      "Max_abs_DFBETAS", "Worst_participant", "Curvature_AIC", "Deletion_failures")],
    by = c("Outcome", "Term"), all.x = TRUE, sort = FALSE)
  # Cross-check: fit-section and validation-section point estimates must agree.
  chk <- merge(primary_fit[, c("Outcome", "Term", "Estimate")],
               primary_val[, c("Outcome", "Term", "Full")], by = c("Outcome", "Term"))
  stopifnot(nrow(chk) == nrow(primary_fit), max(abs(chk$Estimate - chk$Full)) < 1e-3)
  primary$CI_excludes_zero <- primary$Low95 > 0 | primary$High95 < 0
  primary <- primary[order(primary$Outcome, primary$Term), ]
  write.csv(primary, file.path(OUT_DIR, "H4_Step6_Primary_UTCI.csv"), row.names = FALSE)

  # ---- Sensitivity: thermal interactions across all four representations ----
  thermal_terms <- list(Components = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_MRT"),
                        HUMIDEX = c("ucm_HUMIDEX", "ucm_MRT"),
                        PET = "ucm_PET", UTCI = "ucm_UTCI")
  lhs_term <- vapply(strsplit(fit_df$Term, ":"), function(p) if (length(p) == 2L) p[1L] else NA_character_, character(1L))
  # Map each interaction's thermal left-hand term to its owning representation; a term
  # only counts for the representation that declared it.
  owner <- vapply(lhs_term, function(t) {
    if (is.na(t)) return(NA_character_)
    hit <- names(thermal_terms)[vapply(thermal_terms, function(tt) t %in% tt, logical(1L))]
    # MRT belongs to two representations - ambiguous, excluded from the sensitivity check.
    if (length(hit) == 1L) hit else NA_character_
  }, character(1L))
  inter <- fit_df[!is.na(owner) & owner == fit_df$Specification, , drop = FALSE]
  inter$CI_excludes_zero <- inter$Low95 > 0 | inter$High95 < 0
  sens <- if (nrow(inter) == 0L) {
    data.frame(Outcome = character(), Specification = character(), N_interaction_terms = integer(),
               N_CI_excl0 = integer(), Signs = character(), Terms = character())
  } else do.call(rbind, lapply(split(inter, interaction(inter$Outcome, inter$Specification)), function(d) {
    if (!nrow(d)) return(NULL)  # interaction() levels the full cross; skip unused combos
    sig <- d[d$CI_excludes_zero, , drop = FALSE]
    data.frame(Outcome = d$Outcome[1L], Specification = d$Specification[1L],
               N_interaction_terms = nrow(d), N_CI_excl0 = nrow(sig),
               Signs = if (nrow(sig)) paste(unique(sign(sig$Estimate)), collapse = ",") else "",
               Terms = if (nrow(sig)) paste(sig$Term, collapse = "; ") else "", row.names = NULL)
  }))

  # ---- Primary headline table ----
  headline <- do.call(rbind, lapply(split(primary, primary$Outcome), function(d) {
    get_row <- function(t) d[match(t, d$Term), ]
    utci <- get_row("ucm_UTCI"); noise <- get_row("ucm_UTCI:SND_dBA"); act <- get_row("ucm_UTCI:Activity_Bike")
    same_sign <- function(o, target) {
      # Compare like with like: only ACTIVITY interactions from other representations.
      s <- sens[grepl("Activity", sens$Terms) & sens$Outcome == o & sens$Specification != "UTCI" & sens$N_CI_excl0 > 0, ]
      if (target == 0) return(if (nrow(s)) "primary-ns" else "none")
      if (!nrow(s)) return("none")
      if (any(s$Signs == as.character(target))) "same-sign" else "opposite-sign"
    }
    act_sig <- isTRUE(act$CI_excludes_zero)
    data.frame(Outcome = d$Outcome[1L],
               UTCI_Est = utci$Estimate,
               UTCI_CI = sprintf("[%.3f, %.3f]", utci$Low95, utci$High95),
               Thermo_x_Noise_Est = noise$Estimate,
               Thermo_x_Noise_CI = sprintf("[%.4f, %.4f]", noise$Low95, noise$High95),
               Thermo_x_Noise_sig = isTRUE(noise$CI_excludes_zero),
               Thermo_x_Activity_Est = act$Estimate,
               Thermo_x_Activity_CI = sprintf("[%.3f, %.3f]", act$Low95, act$High95),
               Thermo_x_Activity_sig = act_sig,
               Activity_Stability = sprintf("sign flips %d; DFBETAS max %.2f (%s)",
                                            act$Sign_flips, act$Max_abs_DFBETAS, act$Worst_participant),
               Sensitivity_Consistency = same_sign(d$Outcome[1L], if (act_sig) sign(act$Estimate) else 0),
               row.names = NULL)
  }))
  for (cn in c("UTCI_Est", "Thermo_x_Noise_Est", "Thermo_x_Activity_Est"))
    headline[[cn]] <- signif(headline[[cn]], 3)

  md <- c(
    "# H4 Step 5 equations (no representation chosen)",
    "",
    "Four thermal representations, four nested blocks. Base, Noise and Activity are the design checks. The outcome models are the four Joint equations, each fitted to all 26 outcomes. No representation was selected as the model to report.",
    "",
    "Term order matches make_design(): sound, PM1, GVI, clearness, thermal block, Activity_Bike (Bike = +0.5, Walk = -0.5), then interactions. Random part on the fitted Joint models: (1 | ParticipantID/PhaseID) + corAR1(Time10).",
    "",
    "Not in these equations: wind, solar irradiance, lux, mEDI, kelvin, PM2.5, PM10, Clearness_Index_G0, ucm_fp.",
    "",
    h4_step5_fitted_equations(),
    "",
    "Limits: 11 participants; Step 4 LASSO used these same outcomes; the four representations were written after thermal collinearity was visible; intervals are descriptive, not selection-adjusted; associations are not causal.")
  writeLines(md, file.path(OUT_DIR, "H4_Step6_Primary_Summary.md"))

  # ---- Consolidated single PDF: Step-5 exposure justification -> equations -> results ----
  pdf_path <- file.path(OUT_DIR, "H4_Step6_Primary_Report.pdf")
  union10 <- c("ucm_SND_dBA", "ucm_AIR_temp", "ucm_AIR_RH", "ucm_HUMIDEX", "ucm_UTCI",
               "ucm_MRT", "ucm_PET", "Clearness_Index", "atmo_pm1_avg", "gvi_50m")
  rationale_map <- c(
    ucm_UTCI = "One of four fitted thermal representations. Same status as Components, HUMIDEX and PET.",
    ucm_PET = "Fitted thermal index (PET). Reported in full, not a backup.",
    ucm_HUMIDEX = "Fitted thermal representation (HUMIDEX plus MRT). Reported in full.",
    ucm_AIR_temp = "Component thermal representation: transparent physical decomposition (with RH, MRT).",
    ucm_AIR_RH = "Component thermal representation: humidity component.",
    ucm_MRT = "Component thermal representation: mean radiant temperature.",
    ucm_SND_dBA = "Noise stressor in the ethics-protocol amplification hypothesis (A-weighted sound pressure).",
    Clearness_Index = "Solar-radiation normalization (Gh/G0); radiation co-exposure control.",
    atmo_pm1_avg = "Ultrafine particulate co-exposure; co-adjusted per mixtures methodology.",
    gvi_50m = "Eye-level greenery co-exposure (GVI, 50 m).")
  audit2 <- read.csv(file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv"), stringsAsFactors = FALSE)
  raw_df <- read.csv(RAW_DATA_PATH)
  just <- do.call(rbind, lapply(union10, function(v) {
    # PM1 has no pre-averaged column in the raw file: replicate the declared bilateral average.
    x <- if (v == "atmo_pm1_avg") {
      l <- as.numeric(raw_df$atmo_lys_atmotube_left__atmotube_pm1)
      r <- as.numeric(raw_df$atmo_lys_atmotube_right__atmotube_pm1)
      ifelse(is.na(l) & is.na(r), NA_real_, rowMeans(cbind(l, r), na.rm = TRUE))
    } else as.numeric(raw_df[[v]])
    x <- x[is.finite(x)]
    role_e <- audit2$Step4_Empatica_Decision[audit2$Variable_Name == v]
    role_y <- audit2$Step4_Eyetracker_Decision[audit2$Variable_Name == v]
    dom <- audit2$Scientific_Domain[audit2$Variable_Name == v]
    data.frame(Domain = if (length(dom)) dom else "NA",
               Variable = v,
               `Step-4 selection (Empatica | Eye)` = sprintf("%s | %s",
                 if (length(role_e) == 1L) role_e else "?", if (length(role_y) == 1L) role_y else "?"),
               N = length(x), Mean = mean(x), SD = sd(x),
               Skew = mean((x - mean(x))^3)/sd(x)^3,
               Rationale = unname(rationale_map[[v]]), check.names = FALSE, row.names = NULL)
  }))
  wrap_cell <- function(v, w) vapply(v, function(s) paste(strwrap(as.character(s), width = w), collapse = "\n"), character(1))
  fmt3 <- function(x) sprintf("%.2f", x)
  just_pdf <- data.frame(Domain = wrap_cell(just$Domain, 12), Variable = wrap_cell(just$Variable, 20),
    `Step-4 selection` = wrap_cell(just[[3L]], 22), N = just$N, Mean = fmt3(just$Mean), SD = fmt3(just$SD),
    Skew = fmt3(just$Skew), Rationale = wrap_cell(just$Rationale, 52), check.names = FALSE)
  tt6 <- gridExtra::ttheme_minimal(
    core = list(fg_params = list(cex = 0.65, hjust = 0, x = 0.01),
                bg_params = list(fill = c("#f9f9f9", "#ffffff"))),
    colhead = list(fg_params = list(cex = 0.75, fontface = "bold", hjust = 0, x = 0.01),
                   bg_params = list(fill = "#e0e0e0")))
  title_page <- grid::textGrob(paste(c(
    "H4 FITTED FAMILY",
    "",
    "No representation was chosen. The equations below are the Step 5 set:",
    "Components, HUMIDEX, PET and UTCI, each as Base, Noise, Activity and Joint.",
    "Joint is what was fitted to the 26 outcomes. Base, Noise and Activity are the design checks.",
    "",
    "Step 4 LASSO used these same outcomes to build the 10-variable union.",
    "The four representations were specified after thermal collinearity was already visible.",
    "Never fitted here: wind, solar irradiance (SUN Gh), lux, mEDI, kelvin, PM2.5, PM10,",
    "Clearness_Index_G0, ucm_fp. A claim cannot cover those exposures.",
    "",
    "Uncertainty: participant-cluster CR2, Satterthwaite df. Descriptive intervals,",
    "not selection-adjusted. N = 11 participants.",
    "",
    "Contents: (1) the 10 exposures, (2) the four design steps and the four fitted Joint equations,",
    "(4) activity-interaction status in all four representations.",
    "",
    paste0("Generated ", format(Sys.time(), "%Y-%m-%d %H:%M"), " from the frozen Step-5 report.")
  ), collapse = "\n"), x = 0.02, hjust = 0, gp = grid::gpar(fontsize = 12))
  eq_lines <- c(
    "STEP 5 FITTED EQUATIONS (full fixed part; one model per outcome)",
    "Activity_Bike is effect-coded (Bike = +0.5, Walk = -0.5). Every exposure is participant-mean centred before interactions are formed.",
    "Term order is the fitted design: sound, PM1, GVI, clearness, thermal block, Activity_Bike, then interactions.",
    "Base, Noise and Activity were rank and VIF checks. Outcome models with coefficients are the four Joint equations (26 outcomes each).",
    "Random part on the fitted Joint models: (1 | ParticipantID/PhaseID) and discrete corAR1(Time10). REML; CR2/Satterthwaite.",
    "",
    h4_step5_fitted_equations()
  )
  eq_page <- grid::textGrob(paste(eq_lines, collapse = "\n"), x = 0.012, hjust = 0, gp = grid::gpar(fontsize = 7))
  res_pdf <- data.frame(Outcome = wrap_cell(headline$Outcome, 26),
    `UTCI per degC` = sprintf("%.3f %s", headline$UTCI_Est, headline$UTCI_CI),
    `Thermo x Noise` = sprintf("%.4f %s%s", headline$Thermo_x_Noise_Est, headline$Thermo_x_Noise_CI,
                               ifelse(headline$Thermo_x_Noise_sig, " *", "")),
    `Thermo x Activity` = sprintf("%.3f %s%s", headline$Thermo_x_Activity_Est, headline$Thermo_x_Activity_CI,
                                  ifelse(headline$Thermo_x_Activity_sig, " *", "")),
    `Activity stability` = wrap_cell(headline$Activity_Stability, 30),
    Consistency = headline$Sensitivity_Consistency, check.names = FALSE)
  pdf(file = pdf_path, width = 17, height = 11, onefile = TRUE, title = "H4 Step 5 equations")
  grid::grid.draw(title_page)
  grid::grid.newpage(); grid::grid.draw(gridExtra::tableGrob(just_pdf, rows = NULL, theme = tt6))
  grid::grid.newpage(); grid::grid.draw(eq_page)
  act_rows <- inter[grepl(":Activity_Bike$", inter$Term), , drop = FALSE]
  cross_cell <- function(o, spec) {
    d <- act_rows[act_rows$Outcome == o & act_rows$Specification == spec, , drop = FALSE]
    sig <- d[d$CI_excludes_zero, , drop = FALSE]
    if (!nrow(d)) return("not fitted")
    if (!nrow(sig)) return("includes 0")
    paste(ifelse(sig$Estimate > 0, "+", "-"), collapse = ",")
  }
  cross <- data.frame(
    Outcome = wrap_cell(headline$Outcome, 28),
    Components = vapply(headline$Outcome, cross_cell, character(1), spec = "Components"),
    HUMIDEX = vapply(headline$Outcome, cross_cell, character(1), spec = "HUMIDEX"),
    PET = vapply(headline$Outcome, cross_cell, character(1), spec = "PET"),
    UTCI = vapply(headline$Outcome, cross_cell, character(1), spec = "UTCI"),
    check.names = FALSE)
  sttl <- grid::textGrob("ACTIVITY INTERACTION IN ALL FOUR REPRESENTATIONS (all 26 outcomes; +/− = CI excludes 0; includes 0 = kept)",
    x = unit(0.02, "npc"), y = unit(0.97, "npc"), hjust = 0, gp = grid::gpar(fontsize = 11, fontface = "bold"))
  for (p in split(seq_len(nrow(cross)), ceiling(seq_len(nrow(cross)) / 13))) {
    sg <- gridExtra::tableGrob(cross[p, , drop = FALSE], rows = NULL, theme = tt6)
    grid::grid.newpage(); grid::grid.draw(gridExtra::arrangeGrob(sttl, sg, ncol = 1, heights = unit(c(0.4, 7.5), "in")))
  }
  dev.off()
  cat("SAVED:", pdf_path, "\n")

  cat("\nPRIMARY (UTCI) HEADLINE:\n")
  print(headline, row.names = FALSE, digits = 3)
  cat("\nSAVED:", file.path(OUT_DIR, "H4_Step6_Primary_UTCI.csv"), "\n")
  cat("SAVED:", file.path(OUT_DIR, "H4_Step6_Primary_Summary.md"), "\n")
  invisible(NULL)
}

if (identical(Sys.getenv("H4_STEP6_PRIMARY"), "1")) {
  h4_step6_primary_report()
  quit(save = "no", status = 0)
}

OUT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
AUDIT_PNG <- file.path(OUT_DIR, "H4_All_Variables_Audit.png")
AUDIT_PDF <- file.path(OUT_DIR, "H4_All_Variables_Audit.pdf")
AUDIT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
STAGE_SUMMARY_CSV <- file.path(OUT_DIR, "H4_Audit_Stage_Summary.csv")
INTEGRATION_CSV <- file.path(OUT_DIR, "H4_Integration_Readiness.csv")
STEP_CATEGORY_CSV <- file.path(OUT_DIR, "H4_Step_Category_Counts.csv")
DOMAIN_STATUS_CSV <- file.path(OUT_DIR, "H4_Domain_Status_Counts.csv")
EXCLUSION_DETAIL_CSV <- file.path(OUT_DIR, "H4_Exclusion_Detail.csv")
FINAL_OUTCOME_COUNTS_CSV <- file.path(OUT_DIR, "H4_Final_Outcome_Counts.csv")
TRANSPARENCY_MD <- file.path(OUT_DIR, "H4_Transparency_Report.md")
FORMULA_TXT <- file.path(OUT_DIR, "H4_Multivariate_Formula.txt")

h4_lasso_domains <- list(
  Acoustic = "ucm_SND_dBA",
  Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_TWS"),
  Index = c("ucm_HUMIDEX", "ucm_PET", "ucm_UTCI", "ucm_OPT"),
  Radiation = c("ucm_MRT", "ucm_SUN_Gh", "Clearness_Index", "Clearness_Index_G0", "SVF_Holmer"),
  Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"),
  Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
  Greenery = "gvi_50m",
  Unverified = "ucm_fp"
)

h4_proposed_equations <- c(
  "PROPOSED COMPONENT-BASED SPECIFICATIONS - NOT FITTED OR VALIDATED",
  "B = Mode + PC_Movement + (1 | ParticipantID); PC = participant-mean centred exposure.",
  "Thermal components: Y ~ B + PC_AIR_temp + PC_AIR_RH + PC_WIND_TWS + PC_MRT",
  "Co-exposure candidate: Y ~ B + PC_AIR_temp + PC_AIR_RH + PC_SND_dBA + PC_PM2.5_avg + PC_lux_avg + PC_GVI_50m",
  "Light alternative: replace PC_lux_avg with PC_mEDI_avg; do not add Kelvin as an equivalent substitute.",
  "Thermal-index alternatives: replace the thermal components with ONE of PC_UTCI, PC_PET or PC_HUMIDEX.",
  "Solar extension: assess PC_SUN_Gh separately; do not automatically add Gh, clearness and G0 together.",
  "PM alternatives: replace PM2.5 with PM1 or PM10, one size fraction per specification.",
  "GVI remains the greenery measure. fp awaits a verified definition. No p-value-based selection.",
  "Joint coefficients require model-specific collinearity, missingness and stability checks; 11 participant clusters.",
  "Gaussian equations apply only to suitable continuous outcomes; ordinal outcomes need an ordinal mixed model."
)


h4_sensor_union <- function(audit) {
  selected <- audit$Step4_Empatica_Decision == "Retained" | audit$Step4_Eyetracker_Decision == "Retained"
  stopifnot(!anyNA(selected))
  audit$Step4_Union_Decision <- ifelse(selected, "Retained", "Not selected")
  audit$Step4_Decision <- audit$Step4_Union_Decision
  audit$Step4_Status <- "Union of separate Empatica and eye-tracker selections; not pooled-response LASSO or final model"
  stopifnot(setequal(audit$Variable_Name[selected], union(
    audit$Variable_Name[audit$Step4_Empatica_Decision == "Retained"],
    audit$Variable_Name[audit$Step4_Eyetracker_Decision == "Retained"])))
  audit
}

render_h4_faceted_flow <- function(step5 = NULL) {
  library(grid)

  OUT_DIR <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H4_multivariate"
  PDF_PATH <- file.path(OUT_DIR, "H4_Faceted_Vertical_Flow_final.pdf")
  AUDIT_PATH <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")

  audit_all <- h4_sensor_union(read.csv(AUDIT_PATH, stringsAsFactors = FALSE))

  # The first stage shows the complete inventory, including outcomes and metadata.
  audit <- audit_all
  stopifnot(!anyDuplicated(audit$Variable_Name))
  stopifnot(all(c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg") %in% audit$Variable_Name))
  sensor <- audit$Platform_Source
  sensor[grepl("^atmo_lys_atmotube_(left|right)__", audit$Variable_Name)] <- "Atmo raw"
  sensor[grepl("^atmo_lys_LYS1__", audit$Variable_Name)] <- "LYS1 raw"
  sensor[grepl("^atmo_lys_LYS2__", audit$Variable_Name)] <- "LYS2 raw"
  sensor[grepl("^atmo_pm", audit$Variable_Name)] <- "Atmo average"
  sensor[grepl("^lys_", audit$Variable_Name)] <- "LYS average"
  sensor[grepl("UCM Backpack", sensor, ignore.case = TRUE)] <- "UCM"
  sensor[grepl("Atmotube", sensor, ignore.case = TRUE) & !grepl("^atmo_lys_atmotube_(left|right)__", audit$Variable_Name)] <- "Atmo average"
  sensor[grepl("(^|[^A-Za-z])LYS([^A-Za-z]|$)", sensor, ignore.case = TRUE)] <- "LYS average"
  sensor[grepl("^atmo_lys_LYS1__", audit$Variable_Name)] <- "LYS1 raw"
  sensor[grepl("^atmo_lys_LYS2__", audit$Variable_Name)] <- "LYS2 raw"
  sensor[grepl("Eye-Level Panoramic Imagery|GVI", sensor, ignore.case = TRUE)] <- "GVI imagery"
  sensor[grepl("CamUp|DeepLab", sensor, ignore.case = TRUE)] <- "SVF imagery"
  sensor[grepl("Native-WAV|YAMNet", sensor, ignore.case = TRUE)] <- "Sound"
  sensor[grepl("Solar", sensor, ignore.case = TRUE)] <- "Solar"
  sensor[grepl("^empatica_", audit$Variable_Name)] <- "Empatica"
  sensor[grepl("^eyetracker_", audit$Variable_Name)] <- "Eye-tracker"
  sensor[grepl("^questionnaire_", audit$Variable_Name)] <- "Questionnaire"
  metadata <- grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit$Step1_Role)
  sensor[metadata] <- "Metadata / QC"
  column_label <- audit$Variable_Name
  column_label <- sub("^atmo_lys_atmotube_(left|right)__atmotube_", "\\1 ", column_label)
  column_label <- sub("^atmo_lys_LYS([12])__lys_", "LYS\\1 ", column_label)
  column_label <- sub("^dominant_frequency_hz$", "dominant frequency (Hz)", column_label)
  column_label <- sub("^spectral_centroid_hz$", "spectral centroid (Hz)", column_label)
  column_label <- sub("^spectral_rolloff85_hz$", "spectral rolloff 85% (Hz)", column_label)
  column_label <- sub("^freq_prop_([0-9]+)_([0-9]+)$", "band proportion \\1-\\2 Hz", column_label)
  column_label <- sub("^octave_prop_([0-9]+)_([0-9]+)_hz$", "octave proportion \\1.\\2 Hz", column_label)
  column_label <- sub("([0-9]+)\\.0 Hz$", "\\1 Hz", column_label)
  column_label <- sub("^log_lys_", "log ", column_label, ignore.case = TRUE)
  column_label <- sub("^ucm_", "", column_label, ignore.case = TRUE)
  column_label <- sub("^atmo_", "", column_label, ignore.case = TRUE)
  column_label <- sub("^lys_", "", column_label, ignore.case = TRUE)
  column_label <- sub("^gvi_", "GVI ", column_label, ignore.case = TRUE)
  column_label <- sub("^tree_", "Tree ", column_label, ignore.case = TRUE)
  column_label <- sub("^grass_", "Grass ", column_label, ignore.case = TRUE)
  column_label <- sub("^plant_", "Plant ", column_label, ignore.case = TRUE)
  column_label <- sub("^lys_atmotube_(left|right)__atmotube_", "\\1 ", column_label)
  column_label <- sub("^lys_LYS([12])__lys_", "LYS\\1 ", column_label)
  column_label <- sub("^(empatica|eyetracker|questionnaire)_", "", column_label)
  column_label <- sub("_avg$", " avg", column_label, ignore.case = TRUE)
  audit$Sensor <- sensor
  audit$Column <- trimws(gsub("_", " ", column_label))
  audit$Column <- sub("^background ", "", audit$Column)
  audit$Column <- sub("^hrv fd 5min ", "HRV 5min ", audit$Column)
  audit$Column <- sub("response index within participant", "response index", audit$Column)
  audit$Column <- sub(" seconds$", " (s)", audit$Column)
  audit$Column[match(c("ucm_Date", "atmo_lys_Date", "eyetracker_Date"), audit$Variable_Name, nomatch = 0L)] <- c("Date (UCM)", "Date (Atmo/LYS)", "Date (eye)")[c("ucm_Date", "atmo_lys_Date", "eyetracker_Date") %in% audit$Variable_Name]
  audit <- audit[order(audit$Sensor, audit$Column), ]
  step2 <- audit[audit$Step2_Status == "Retained", ]
  expected_raw_sources <- c(
    "atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1",
    "atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5",
    "atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10",
    paste0("atmo_lys_LYS", rep(1:2, each = 3), "__lys_", rep(c("lux", "medi", "kelvin"), 2)),
    paste0("atmo_lys_LYS", rep(1:2, each = 7), "__lys_", rep(c("b'", "g'", "r'", "rgbb", "rgbg", "rgbir", "rgbr"), 2))
  )
  stopifnot(all(expected_raw_sources %in% audit$Variable_Name),
    !any(grepl("^atmo_lys_(atmotube_left|atmotube_right|LYS1|LYS2)__", step2$Variable_Name)))

  candidate_names <- audit$Variable_Name[audit$Step3_Decision == "Retained"]
  stopifnot(length(candidate_names) > 0L)

  # One faceted page; positions are assigned once, never regrouped by stage.
  sensor_order <- c("UCM", "Atmo raw", "Atmo average", "LYS1 raw", "LYS2 raw", "LYS average", "GVI imagery", "SVF imagery", "Sound", "Solar", "Empatica", "Eye-tracker", "Questionnaire", "Metadata / QC")
  stopifnot(all(audit$Sensor %in% sensor_order), nrow(audit) == nrow(audit_all))
  audit <- audit[order(match(audit$Sensor, sensor_order), audit$Column), ]
  audit$Slot <- ave(seq_len(nrow(audit)), audit$Sensor, FUN = seq_along)
  audit$Subcolumn <- (audit$Slot - 1L) %/% 14L
  audit$Row <- (audit$Slot - 1L) %% 14L
  ncolumns <- sapply(sensor_order, function(s) max(c(0L, audit$Subcolumn[audit$Sensor == s])) + 1L)
  physio <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
  stopifnot(all(physio %in% audit$Variable_Name), setequal(intersect(physio, H4_SPEC$hrv_log), H4_SPEC$hrv_log))
  shown <- audit$Column[match(physio, audit$Variable_Name)]
  physio_label <- ifelse(physio %in% H4_SPEC$hrv_log, paste0("log(", shown, ")"), shown)
  longest_label <- audit$Column
  is_selected <- audit$Variable_Name %in% candidate_names
  longest_label[is_selected] <- paste0(longest_label[is_selected], " [", audit$Measurement_Code[is_selected], "]")
  longest_label[match(physio, audit$Variable_Name)] <- physio_label
  grDevices::pdf(file = NULL, pointsize = 18, family = "Helvetica")
  label_width <- strwidth(longest_label, units = "inches")
  dev.off()
  widths <- vapply(sensor_order, function(s) ncolumns[s] * (max(c(1.1, label_width[audit$Sensor == s])) * 1.15 + .40), numeric(1))
  page_width <- 2.7 + sum(widths) + .15
  lefts <- (2.7 + cumsum(c(0, head(widths, -1)))) / page_width
  sensor_width <- widths / page_width
  sensor_id <- match(audit$Sensor, sensor_order)
  audit$X <- lefts[sensor_id] + .12 / page_width +
    audit$Subcolumn * sensor_width[sensor_id] / ncolumns[sensor_id]
  stages <- list(
    audit,
    audit[audit$Step2_Status == "Retained", ],
    audit[audit$Step3_Decision == "Retained", ],
    audit[audit$Step4_Union_Decision == "Retained", ]
  )
  stopifnot(all(candidate_names %in% step2$Variable_Name), setequal(stages[[3]]$Variable_Name, step2$Variable_Name))
  stopifnot(all(vapply(stages, function(d) all(d$X == audit$X[match(d$Variable_Name, audit$Variable_Name)]), logical(1))))
  for (k in 2:4) if (nrow(stages[[k]]) > 0L) stages[[k]]$Row <- ave(seq_len(nrow(stages[[k]])), interaction(stages[[k]]$Sensor, stages[[k]]$Subcolumn), FUN = function(x) seq_along(x) - 1L)
  titles <- c(
    paste0("STEP 1\nInventory (", nrow(audit), ")"),
    paste0("STEP 2\nRepresentatives (", nrow(step2), ")\nRules + coverage"),
    paste0("STEP 3\nDomain Grouping (", nrow(stages[[3]]), ")"),
    "STEP 4\nCombined Empatica\n+ Eyetracker\nMinimum CV MSE"
  )
  max_rows <- vapply(stages, function(d) as.integer(max(c(1L, d$Row + 1L))), integer(1))
  band_height <- 66 + max_rows * 23
  band_height[2] <- max(band_height[2], 66 + 14 * 23)
  band_height[3] <- 520
  band_height[4] <- 520
  # Step 5 lists every equation: 4 thermal forms x Base, Noise, Activity, Joint.
  step5_height <- 1200
  page_height <- 155 + sum(band_height) + step5_height
  band_top <- page_height - 155 - c(0, head(cumsum(band_height), -1))
  tops <- (band_top + 45) / page_height
  row_spacing <- 23 / page_height
  text_at <- function(x, y, label, size = 18, bold = FALSE, color = "#222222") {
    grid.text(label, x = x, y = y, just = "left",
              gp = gpar(fontsize = size, fontface = if (bold) "bold" else "plain", col = color))
  }
  grDevices::cairo_pdf(PDF_PATH, width = page_width, height = page_height / 72, onefile = TRUE)
  grid.newpage()
  text_at(.12 / page_width, 1 - 22 / page_height, "H4 environmental-variable selection", 30, TRUE)
  text_at(.12 / page_width, 1 - 55 / page_height, "Step 4: union of separate Empatica and eye-tracker LASSO selections; minimum participant-held-out MSE within each category. Not pooled-response selection.", 20)
  pending_svf <- sum(audit$Step2_Status == "PENDING SVF PROCESSING / MERGE")
  for (s in seq_along(sensor_order)) {
    heading <- sub(" (raw|average|imagery)$", "\n\\1", sensor_order[s])
    text_at(lefts[s] + .12 / page_width, 1 - 100 / page_height, heading, 21, TRUE)
  }
  for (k in seq_along(stages)) {
    d <- stages[[k]]
    if (k >= 2L && nrow(d) > 0L) d$Row <- ave(seq_len(nrow(d)), interaction(d$Sensor, d$Subcolumn), FUN = function(x) seq_along(x) - 1L)
    grid.text(titles[k], x = .12 / page_width, y = band_top[k] / page_height,
      just = c("left", "top"), gp = gpar(fontsize = 18, fontface = "bold", col = "#222222"))
    if (k == 2L && pending_svf > 0L) text_at(lefts[match("SVF imagery", sensor_order)] + .12 / page_width, band_top[k] / page_height,
      "SVF Holmer (planned; merge pending)", 18)
    if (k %in% c(3L, 4L)) {
      display_domains <- h4_lasso_domains
      if (k == 3L) {
        display_domains$Thermal <- unique(c(display_domains$Thermal, "ucm_MRT"))
        display_domains$Radiation <- setdiff(display_domains$Radiation, "ucm_MRT")
      }
      stopifnot(k != 3L || ("ucm_MRT" %in% display_domains$Thermal && !"ucm_MRT" %in% display_domains$Radiation))
      category_width <- (page_width - 2.82) / length(display_domains)
      for (g in seq_along(display_domains)) {
        domain <- names(display_domains)[g]
        category_x <- (2.82 + (g - 1L) * category_width) / page_width
        variables <- intersect(display_domains[[g]], candidate_names)
        labels <- audit$Column[match(variables, audit$Variable_Name)]
        text_at(category_x, band_top[k] / page_height, domain, 21, TRUE)
        if (k == 3L) {
          labels[variables == "ucm_fp"] <- paste0(labels[variables == "ucm_fp"], " (definition unverified; not in LASSO)")
          labels[variables == "Clearness_Index_G0"] <- paste0(labels[variables == "Clearness_Index_G0"], " (denominator; not in LASSO)")
          for (j in seq_along(labels)) text_at(category_x, (band_top[k] - 30 * j) / page_height, labels[j], 18)
          if (domain == "Radiation" && pending_svf > 0L) text_at(category_x,
            (band_top[k] - 30 * (length(labels) + 1L)) / page_height, "SVF Holmer (planned; merge pending)", 18)
        } else {
          for (f in 1L) {
            family <- "Combined"
            prefix <- paste0("Step4_", family, "_")
            rows <- match(setdiff(variables, c("Clearness_Index_G0", "ucm_fp")), audit$Variable_Name)
            chosen <- rows[audit$Step4_Union_Decision[rows] == "Retained"]
            status <- audit[[paste0(prefix, "Status")]][rows]
            family_top <- band_top[k] - 35 - (f - 1L) * 135
            text_at(category_x, family_top / page_height, "Combined Empatica + Eyetracker", 19, TRUE)
            selection <- if (!length(rows)) "Not entered" else if (length(chosen)) audit$Column[chosen] else if (any(grepl("Not estimable", status))) "NOT ESTIMABLE" else "None selected"
            for (j in seq_along(selection)) text_at(category_x, (family_top - 25 * j) / page_height, selection[j], 18)
            if (length(rows)) {
              text_at(category_x, (family_top - 110) / page_height,
                sprintf("Empatica n=%s; ocular n=%s windows", audit$Step4_Empatica_Rows[rows[1L]], audit$Step4_Eyetracker_Rows[rows[1L]]), 16)
            }
          }
        }
      }
    } else for (j in seq_len(nrow(d))) {
      row <- d$Row[j]
      label <- d$Column[j]
      if (k >= 2L && d$Variable_Name[j] %in% H4_SPEC$hrv_log) label <- paste0("log(", label, ")")
      if (k == 3L) label <- paste0(label, " [", d$Measurement_Code[j], "]")
      text_at(d$X[j], band_top[k] / page_height - row * row_spacing, label, 18,
              bold = FALSE)
    }
    separator_y <- (band_top[k] - band_height[k] + 30) / page_height
    grid.lines(x = unit(c(.005, .995), "npc"), y = unit(c(separator_y, separator_y), "npc"),
               gp = gpar(col = "#9aa1a6", lwd = 0.7))
  }
  top <- step5_height - 10
  grid.text("STEP 5\nAll 16\nequations", x = .12 / page_width, y = top / page_height,
    just = c("left", "top"), gp = gpar(fontsize = 16, fontface = "bold"))
  eq_lines <- h4_step5_fitted_equations()
  eq_lines <- eq_lines[!grepl("^        \\+", eq_lines)]
  stopifnot(length(eq_lines) == 16L)
  eq_lines <- gsub(":SND_dBA", ":ucm_SND_dBA", eq_lines, fixed = TRUE)
  eq_text <- paste0("(", seq_along(eq_lines), ") ", eq_lines, " + (1 | ParticipantID/PhaseID) + corAR1(Time10 | ParticipantID/PhaseID)")
  x0 <- 2.82 / page_width
  chars <- max(80L, floor((page_width - 3.2) * 72 / 6.2))
  y <- top - 8
  for (label in eq_text) {
    for (line in strwrap(label, width = chars)) {
      y <- y - 22
      text_at(x0, y / page_height, line, 12)
    }
    y <- y - 8
  }
  dev.off()
  cat("Verified stage counts:", paste(vapply(stages, nrow, integer(1)), collapse = " -> "), ". Fixed horizontal positions; zero connectors.\n")
  cat("Saved figure (1 page):", PDF_PATH, "\n")
}

render_audit_pdf <- function(audit_df, output_path, preview_path = NULL) {
  # 1. Aggressively collapse non-essential and repetitive features to condense the PDF
  collapse_group <- function(df, mask, new_name) {
    if (sum(mask) > 1) {
      first_idx <- which(mask)[1]
      df$Variable_Name[first_idx] <- sprintf("%s (%d variables)", new_name, sum(mask))
      df <- df[!(mask & seq_len(nrow(df)) != first_idx), ]
    }
    return(df)
  }

  audit_df <- collapse_group(audit_df, grepl("yamnet_class", audit_df$Variable_Name), "YAMNet Audio Classes")
  audit_df <- collapse_group(audit_df, grepl("^octave_prop", audit_df$Variable_Name), "Octave Frequency Bands")
  
  # 2. Precise Scientific Role classification
  is_environment <- audit_df$Step1_Role == "Environmental Stressor Candidates (X_env)"
  is_physio <- grepl("Physiological Sensor Outcomes", audit_df$Step1_Role)
  is_psych <- grepl("Psychological Survey Outcomes", audit_df$Step1_Role)
  is_outcome <- is_physio | is_psych
  is_metadata_qc <- grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit_df$Step1_Role) | audit_df$Final_Filtration_Outcome == "QC METRIC"
  is_movement <- grepl("Movement", audit_df$Step1_Role)

  role <- ifelse(
    is_environment, "Environmental Candidate (X)",
    ifelse(is_physio, "Outcome Y - Physiological",
      ifelse(is_psych, "Outcome Y - Psychological",
        ifelse(is_movement, "Movement Covariate (Z)",
          ifelse(is_metadata_qc, "Metadata / QC - Not Candidate",
            "Outside Declared H4 Set"
          )
        )
      )
    )
  )

  # 3. Clean, human-readable Preprocessing step
  step2 <- ifelse(
    is_environment & audit_df$Step2_Status != "-",
    ifelse(audit_df$Step2_Decision == "Retained", "Eligible", "Not advanced"),
    ifelse(is_outcome, "Analyzed as outcome Y",
      ifelse(is_movement, "Exertion covariate proxy",
        ifelse(is_metadata_qc, "-", "-")
      )
    )
  )

  # Measurement provenance is not a final predictor-selection decision.
  candidate <- audit_df$H4_Screening_Candidate == "Yes"
  step3 <- ifelse(candidate, paste(audit_df$Measurement_Code, audit_df$Measurement_Type), "-")
  final_role <- ifelse(candidate, "Candidate; model specification pending",
    ifelse(is_physio, "Physiological outcome", ifelse(is_psych, "Psychological outcome",
      ifelse(is_movement, "Movement covariate", audit_df$Final_Filtration_Outcome))))

  # Simplify Platform Source names
  clean_source <- audit_df$Platform_Source
  clean_source <- sub(".*YAMNet.*", "YAMNet Audio", clean_source)
  clean_source <- sub(".*Atmotube.*", "Atmotube", clean_source)
  clean_source <- sub(".*Atmo.*", "Atmotube", clean_source)
  clean_source <- sub(".*UCM Backpack.*", "UCM Backpack", clean_source)
  clean_source <- sub(".*Empatica.*", "Empatica", clean_source)
  clean_source <- sub(".*LYS.*", "LYS Button", clean_source)
  clean_source <- sub(".*Pupil.*", "Eye-Tracker", clean_source)
  clean_source <- sub(".*Questionnaire.*", "Questionnaire", clean_source)
  clean_source <- sub(".*Surveys.*", "Questionnaire", clean_source)
  clean_source <- sub(".*Imagery.*", "Street View / GIS", clean_source)
  clean_source <- sub(".*GVI.*", "Street View / GIS", clean_source)
  clean_source <- sub(".*DeepLabV3.*", "Street View / GIS", clean_source)
  clean_source <- sub(".*WAV Spectral.*", "Acoustic Spectral", clean_source)

  # 7. Build Table DataFrame
  table_df <- data.frame(
    `Sr. No.` = integer(nrow(audit_df)),
    `Data Source (Sensor)` = clean_source,
    Variable = audit_df$Variable_Name,
    `Step 1: Role` = role,
    `Step 2: Preprocessing` = step2,
    `Step 3: Measurement provenance` = step3,
    `Final role` = final_role,
    check.names = FALSE,
    stringsAsFactors = FALSE
  )

  # Sort by Role (Outcomes first, then Final Predictors, then X, then Z, then Metadata), then Domain, then variable
  role_priority <- ifelse(grepl("Outcome", table_df$`Step 1: Role`), "01",
                   ifelse(grepl("Primary Predictor", table_df$`Final role`), "02",
                   ifelse(grepl("Environmental Candidate", table_df$`Step 1: Role`), "03",
                   ifelse(grepl("Covariate", table_df$`Step 1: Role`), "04", "05"))))
  
  order_key <- paste0(role_priority, "_", table_df[[2]], "_", table_df$Variable)
  table_df <- table_df[order(order_key), , drop = FALSE]
  table_df$`Sr. No.` <- seq_len(nrow(table_df))

  # Fixed readable page capacity includes wrapped multi-line role/status labels.
  page_rows <- split(seq_len(nrow(table_df)), ceiling(seq_len(nrow(table_df)) / 15L))
  page_count <- length(page_rows)

  # Text wrap column widths (characters) and physical layout widths (inches)
  # Total physical width = 0.5 + 1.8 + 3.4 + 2.4 + 2.8 + 2.8 + 3.2 = 16.9 in
  wrap_widths <- c(6L, 20L, 42L, 28L, 34L, 34L, 38L)
  column_widths <- c(0.5, 1.8, 3.4, 2.4, 2.8, 2.8, 3.2)

  wrap_variable <- function(value, width) paste(strwrap(value, width = width), collapse = "\n")

  grDevices::cairo_pdf(output_path, width = 17, height = 11, onefile = TRUE, family = "sans")
  on.exit(grDevices::dev.off(), add = TRUE)

  subtitle_text <- paste(
    "Step 1: Complete column inventory and analytical roles.",
    "Step 2: Existing sensor consolidation and exposure-representation rules, unchanged.",
    "Step 3: Measurement provenance and shared-design diagnostics; all Step-2 eligible fields remain candidates.",
    "No VIF elimination stage. Fitted Step-5 equations are in H4_Step6_Primary_Report.pdf; this table is the variable inventory only.",
    sep = "\n"
  )

  for (page in seq_along(page_rows)) {
    rows <- page_rows[[page]]
    page_df <- table_df[rows, , drop = FALSE]

    for (column in seq_len(ncol(page_df))) {
      page_df[[column]] <- vapply(page_df[[column]], function(value) {
        if (column == 3L) {
          wrap_variable(as.character(value), wrap_widths[column])
        } else {
          paste(strwrap(as.character(value), width = wrap_widths[column]), collapse = "\n")
        }
      }, character(1))
    }

    table_grob <- gridExtra::tableGrob(
      page_df,
      rows = NULL,
      theme = gridExtra::ttheme_minimal(
        base_size = 9,
        padding = grid::unit(c(3, 4.5), "mm"),
        core = list(
          fg_params = list(hjust = 0, x = 0.02, fontsize = 9),
          bg_params = list(fill = c("#ffffff", "#f8f9fa")[((seq_len(nrow(page_df)) - 1) %% 2) + 1])
        ),
        colhead = list(
          fg_params = list(fontface = "bold", hjust = 0, x = 0.02, fontsize = 9.5),
          bg_params = list(fill = "#dce6f1")
        )
      )
    )
    table_grob$widths <- grid::unit(column_widths, "in")

    if (page == 1L && !is.null(preview_path)) {
      preview <- gridExtra::arrangeGrob(
        grid::textGrob("H4 Variable Audit Table", gp = grid::gpar(fontface = "bold", fontsize = 16)),
        table_grob,
        ncol = 1,
        heights = grid::unit(c(0.6, 9.8), "in")
      )
      ggplot2::ggsave(preview_path, preview, width = 17, height = 11, dpi = 220, limitsize = FALSE)
    }

    grid::grid.newpage()

    # Title and Subtitle at top
    grid::grid.text(
      "H4 Comprehensive Variable Audit",
      x = 0.5, y = 0.965,
      gp = grid::gpar(fontface = "bold", fontsize = 15)
    )
    grid::grid.text(
      subtitle_text,
      x = 0.5, y = 0.89,
      just = c("centre", "top"),
      gp = grid::gpar(fontsize = 8.5, col = "#333333", lineheight = 1.1)
    )

    # Table viewport positioned at constant top margin across all pages
    grid::pushViewport(grid::viewport(
      x = 0.5, y = 0.77,
      just = c("centre", "top"),
      width = sum(table_grob$widths),
      height = sum(table_grob$heights)
    ))
    grid::grid.draw(table_grob)
    grid::popViewport()

    # Footer at bottom
    grid::grid.text(
      sprintf("Page %d of %d  |  Full machine-readable audit: H4_Multivariate_Filtration_Results.csv", page, page_count),
      x = 0.5, y = 0.03,
      gp = grid::gpar(fontsize = 8, col = "gray40")
    )
  }

  invisible(page_count)
}
if (identical(Sys.getenv("H4_AUDIT_PDF_ONLY"), "1")) {
  if (!file.exists(AUDIT_CSV)) stop("Existing H4 audit CSV not found: ", AUDIT_CSV, call. = FALSE)
  audit_page_count <- render_audit_pdf(
    utils::read.csv(AUDIT_CSV, stringsAsFactors = FALSE, check.names = FALSE),
    AUDIT_PDF
  )
  cat(sprintf("Rendered audit table PDF only (%d pages): %s\n", audit_page_count, AUDIT_PDF))
  quit(save = "no", status = 0)
}

# H4 model specification and fitting implementation
H4_SPEC <- list(
  participants = c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"),
  phases = c("BikeU", "BikeG", "WalkU", "WalkG"),
  outcomes = list(
    Psychological = c(
      "questionnaire_current_comfort_1_7",
      "questionnaire_pleasantness_1_5",
      "questionnaire_stai6_mean_1_5",
      "questionnaire_prs11_total_mean_1_5"
    ),
    Physiological_Autonomic = c(
      "empatica_heart_rate", "empatica_eda_tonic", "empatica_eda_phasic",
      "empatica_skin_temperature", "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd",
      "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio",
      "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf",
      "empatica_hrv_fd_total_power"
    ),
    Physiological_Ocular = c(
      "eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate",
      "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s",
      "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
      "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity",
      "eyetracker_gaze_velocity", "eyetracker_gaze_dispersion",
      "eyetracker_distance_from_center", "eyetracker_gaze_centrality",
      "eyetracker_eyelid_aperture_avg"
    )
  ),
  hrv_log = c(
    "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd",
    "empatica_hrv_fd_lf", "empatica_hrv_fd_hf",
    "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power"
  ),
  hrv_fd = c(
    "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio",
    "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power"
  ),
  questionnaire = c(
    "questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"
  ),
  ordinal = c("questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5"),
  vif_threshold = 5,
  expected_epochs = 49L
)
H4_SPEC$all_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)
H4_SPEC$exposure_centered <- c(
  ucm_UTCI = "PC_UTCI",
  ucm_SND_dBA = "PC_dBA",
  atmo_pm2.5_avg = "PC_PM25",
  lys_lux_avg = "PC_Lux",
  gvi_50m = "PC_GVI"
)
H4_SPEC$bilateral_sources <- list(
  atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
  lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")
)

h4_mean <- function(x) {
  x <- as.numeric(x)
  x <- x[is.finite(x)]
  if (!length(x)) NA_real_ else mean(x)
}

h4_single_questionnaire_response <- function(x, outcome, participant_phase) {
  x <- x[is.finite(x)]
  if (!length(x)) return(NA_real_)
  values <- unique(x)
  if (length(values) != 1L) {
    stop(
      "Inconsistent duplicated questionnaire values for ", outcome, " in ",
      participant_phase, ": ", paste(values, collapse = ", "), call. = FALSE
    )
  }
  as.numeric(values[1])
}

h4_person_mean_center <- function(x, id) {
  ave(as.numeric(x), id, FUN = function(v) {
    keep <- is.finite(v)
    if (!any(keep)) return(rep(NA_real_, length(v)))
    v - mean(v[keep])
  })
}

h4_global_z <- function(x) {
  keep <- is.finite(x)
  if (sum(keep) < 2L) return(rep(NA_real_, length(x)))
  m <- mean(x[keep])
  s <- stats::sd(x[keep])
  if (!is.finite(s) || s == 0) rep(NA_real_, length(x)) else (x - m) / s
}

h4_prepare_data <- function(raw) {
  required <- unique(c(
    "ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available",
    unlist(H4_SPEC$bilateral_sources, use.names = FALSE),
    names(H4_SPEC$exposure_centered)[c(1, 2, 5)], H4_SPEC$all_outcomes, "empatica_vector_magnitude"
  ))
  missing_columns <- setdiff(required, names(raw))
  if (length(missing_columns)) {
    stop("Required H4 input columns are missing: ", paste(missing_columns, collapse = ", "), call. = FALSE)
  }

  raw$ParticipantID <- as.character(raw$ParticipantID)
  raw$PhaseID <- as.character(raw$PhaseID)
  raw <- raw[raw$ParticipantID %in% H4_SPEC$participants & raw$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
  if (!nrow(raw)) stop("No rows remain for the declared H4 participants and phases.", call. = FALSE)

  hrv_invalid <- vector("list", length(H4_SPEC$hrv_log))
  for (i in seq_along(H4_SPEC$hrv_log)) {
    variable <- H4_SPEC$hrv_log[i]
    value <- as.numeric(raw[[variable]])
    nonpositive <- !is.na(value) & is.finite(value) & value <= 0
    nonfinite <- !is.na(value) & !is.finite(value)
    missing <- is.na(value)
    value[nonpositive | nonfinite] <- NA_real_
    raw[[variable]] <- value
    hrv_invalid[[i]] <- data.frame(
      Outcome = variable,
      NonPositive_Rows = sum(nonpositive),
      NonFinite_Rows = sum(nonfinite),
      Missing_Rows = sum(missing),
      stringsAsFactors = FALSE
    )
  }
  hrv_invalid <- do.call(rbind, hrv_invalid)

  for (variable in setdiff(H4_SPEC$all_outcomes, H4_SPEC$hrv_log)) {
    raw[[variable]] <- as.numeric(raw[[variable]])
    raw[[variable]][!is.finite(raw[[variable]])] <- NA_real_
  }

  ordinal_ranges <- list(
    questionnaire_current_comfort_1_7 = 1:7,
    questionnaire_pleasantness_1_5 = 1:5
  )
  for (variable in H4_SPEC$ordinal) {
    value <- raw[[variable]]
    invalid <- !is.na(value) & (!is.finite(value) | value != floor(value) | !(value %in% ordinal_ranges[[variable]]))
    if (any(invalid)) stop("Ordinal questionnaire contains non-integer/out-of-scale values: ", variable, call. = FALSE)
  }

  raw$atmo_pm2.5_avg <- rowMeans(raw[, H4_SPEC$bilateral_sources$atmo_pm2.5_avg, drop = FALSE], na.rm = TRUE)
  raw$lys_lux_avg <- rowMeans(raw[, H4_SPEC$bilateral_sources$lys_lux_avg, drop = FALSE], na.rm = TRUE)
  raw$atmo_pm2.5_avg[!is.finite(raw$atmo_pm2.5_avg)] <- NA_real_
  raw$lys_lux_avg[!is.finite(raw$lys_lux_avg)] <- NA_real_
  raw$ucm_UTCI <- as.numeric(raw$ucm_UTCI)
  raw$ucm_SND_dBA <- as.numeric(raw$ucm_SND_dBA)
  raw$gvi_50m <- as.numeric(raw$gvi_50m)
  raw$ucm_UTCI[!is.finite(raw$ucm_UTCI)] <- NA_real_
  raw$ucm_SND_dBA[!is.finite(raw$ucm_SND_dBA) | raw$ucm_SND_dBA < 0] <- NA_real_
  fd_available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (variable in H4_SPEC$hrv_fd) raw[[variable]][!fd_available] <- NA_real_

  grid <- expand.grid(
    ParticipantID = H4_SPEC$participants,
    PhaseID = H4_SPEC$phases,
    stringsAsFactors = FALSE
  )
  grid <- grid[order(match(grid$ParticipantID, H4_SPEC$participants), match(grid$PhaseID, H4_SPEC$phases)), , drop = FALSE]
  cell_key <- function(id, phase) paste(id, phase, sep = "::")
  absent_cells <- setdiff(cell_key(grid$ParticipantID, grid$PhaseID), cell_key(raw$ParticipantID, raw$PhaseID))
  if (length(absent_cells)) {
    stop("Required H4 participant-phase cells are absent: ", paste(absent_cells, collapse = ", "), call. = FALSE)
  }

  raw$ParticipantID <- factor(raw$ParticipantID, levels = H4_SPEC$participants)
  raw$PhaseID <- factor(raw$PhaseID, levels = H4_SPEC$phases)
  raw$ParticipantPhase <- cell_key(raw$ParticipantID, raw$PhaseID)
  grid$ParticipantPhase <- cell_key(grid$ParticipantID, grid$PhaseID)
  phase <- grid[, c("ParticipantID", "PhaseID", "ParticipantPhase"), drop = FALSE]

  aggregate_columns <- unique(c(
      "ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m", "empatica_vector_magnitude",
      H4_SPEC$all_outcomes
    ))
  group_rows <- split(seq_len(nrow(raw)), factor(raw$ParticipantPhase, levels = grid$ParticipantPhase))
  duplicate_timestamps <- duplicated(raw[, c("ParticipantID", "PhaseID", "Datetime")])
  if (any(duplicate_timestamps)) stop("Duplicate 10-second timestamps found in H4 participant-phase input.", call. = FALSE)
  coverage_rows <- list()
  for (variable in aggregate_columns) {
    is_questionnaire <- variable %in% H4_SPEC$questionnaire
    expected <- if (is_questionnaire) 1L else H4_SPEC$expected_epochs
    valid_n <- vapply(group_rows, function(rows) {
      values <- raw[[variable]][rows]
      if (is_questionnaire) length(unique(values[is.finite(values)])) else sum(is.finite(values))
    }, integer(1))
    coverage <- valid_n / expected
    coverage_pass <- if (is_questionnaire) valid_n == 1L else valid_n > 0L
    phase[[variable]] <- vapply(seq_along(group_rows), function(i) {
      rows <- group_rows[[i]]
      if (is_questionnaire) {
        h4_single_questionnaire_response(raw[[variable]][rows], variable, names(group_rows)[i])
      } else if (!coverage_pass[i]) {
        NA_real_
      } else {
        h4_mean(raw[[variable]][rows])
      }
    }, numeric(1))
    coverage_rows[[variable]] <- data.frame(
      ParticipantPhase = names(group_rows),
      Measure = variable,
      Measure_Type = if (is_questionnaire) "Questionnaire response" else if (variable %in% H4_SPEC$all_outcomes) "Outcome" else "Exposure",
      N_valid = valid_n,
      N_expected = expected,
      Coverage_pct = round(100 * coverage, 1),
      Coverage_pass = coverage_pass,
      stringsAsFactors = FALSE
    )
  }
  coverage <- do.call(rbind, coverage_rows)
  coverage$ParticipantID <- sub("::.*$", "", coverage$ParticipantPhase)
  coverage$PhaseID <- sub("^.*::", "", coverage$ParticipantPhase)
  coverage <- coverage[, c(
    "ParticipantID", "PhaseID", "Measure_Type", "Measure", "N_valid", "N_expected",
    "Coverage_pct", "Coverage_pass"
  )]

  if (any(coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass)) {
    bad <- coverage[coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass, ]
    stop(
      "Primary exposure has no valid phase observations: ",
      paste(paste(bad$ParticipantID, bad$PhaseID, bad$Measure, sep = "/"), collapse = ", "),
      call. = FALSE
    )
  }
  if (!all(vapply(group_rows, length, integer(1)) == H4_SPEC$expected_epochs)) {
    bad_cells <- names(group_rows)[vapply(group_rows, length, integer(1)) != H4_SPEC$expected_epochs]
    warning(
      "H4 input has participant-phase row counts other than ", H4_SPEC$expected_epochs,
      "; coverage is calculated against the declared matched-window denominator. Cells: ",
      paste(bad_cells, collapse = ", "), call. = FALSE
    )
  }

  if (any(phase$atmo_pm2.5_avg < 0, na.rm = TRUE)) stop("Negative phase-mean PM2.5 values require source-data review.", call. = FALSE)
  if (any(phase$ucm_SND_dBA < 0, na.rm = TRUE)) stop("Negative phase-mean dBA values require source-data review.", call. = FALSE)
  if (any(phase$lys_lux_avg < 0, na.rm = TRUE)) stop("Negative phase-mean lux values require source-data review.", call. = FALSE)
  if (any(phase$gvi_50m < 0 | phase$gvi_50m > 100, na.rm = TRUE)) stop("GVI values fall outside 0-100%.", call. = FALSE)

  phase$Mode <- factor(ifelse(grepl("^Bike", phase$PhaseID), "Bike", "Walk"), levels = c("Bike", "Walk"))

  center_source <- c(
    ucm_UTCI = "ucm_UTCI",
    ucm_SND_dBA = "ucm_SND_dBA",
    atmo_pm2.5_avg = "atmo_pm2.5_avg",
    lys_lux_avg = "lys_lux_avg",
    gvi_50m = "gvi_50m"
  )
  for (variable in names(H4_SPEC$exposure_centered)) {
    target <- H4_SPEC$exposure_centered[[variable]]
    phase[[target]] <- h4_person_mean_center(phase[[center_source[[variable]]]], phase$ParticipantID)
  }
  phase[["PC_Movement"]] <- h4_person_mean_center(phase[["empatica_vector_magnitude"]], phase$ParticipantID)

  centered_exposures <- unname(H4_SPEC$exposure_centered)
  bad_predictor <- !stats::complete.cases(phase[, c(centered_exposures, "PC_Movement"), drop = FALSE])
  if (any(bad_predictor)) {
    bad <- phase[bad_predictor, c("ParticipantID", "PhaseID"), drop = FALSE]
    stop(
      "Required primary predictor values are missing in participant-phase cells: ",
      paste(cell_key(bad$ParticipantID, bad$PhaseID), collapse = ", "),
      call. = FALSE
    )
  }

  for (variable in H4_SPEC$all_outcomes) {
    value <- phase[[variable]]
    if (variable %in% H4_SPEC$hrv_log) {
      value[value <= 0] <- NA_real_
      value <- log(value)
    }
    phase[[paste0("Outcome_GZ__", variable)]] <- h4_global_z(value)
  }

  ordinal_ranges <- list(
    questionnaire_current_comfort_1_7 = 1:7,
    questionnaire_pleasantness_1_5 = 1:5
  )
  for (variable in H4_SPEC$ordinal) {
    value <- phase[[variable]]
    phase[[paste0("Outcome_ORD__", variable)]] <- ordered(value, levels = ordinal_ranges[[variable]])
  }

  stopifnot(nrow(phase) == length(H4_SPEC$participants) * length(H4_SPEC$phases),
            all(!coverage$Coverage_pass[coverage$N_valid == 0L]))
  list(
    data = phase,
    coverage = coverage,
    invalid_hrv = hrv_invalid,
    n_input_rows = nrow(raw),
    n_cells = nrow(phase),
    raw_participants = H4_SPEC$participants,
    raw_phases = H4_SPEC$phases
  )
}

PARTICIPANTS <- H4_SPEC$participants
CORE_PHASES <- H4_SPEC$phases

# Canonical sound-processing fields added by the JOS/YAMNet-frequency pipeline.
# QC/provenance fields are not candidate exposures. Semantic YAMNet scores/
# prevalences and native-rate spectral descriptors are exploratory acoustic
# constructs; calibrated ucm_SND_dBA remains the reference acoustic measure.
SOUND_QC_COLUMNS <- c(
  "window_duration_s", "is_complete_10s_window", "phase_start_offset_s",
  "yamnet_frame_count", "yamnet_threshold",
  "original_sample_rate_hz", "frequency_analysis_min_hz",
  "frequency_analysis_max_hz", "frequency_analysis_full_20khz_coverage"
)

SOUND_CATEGORY_PROP_COLUMNS <- c("wind_prop", "rural_natural_prop", "vehicle_prop", "urban_manmade_neutral_prop", "urban_manmade_positive_prop", "urban_manmade_negative_prop", "mechanisms_prop", "unidentify_prop")
is_sound_semantic <- function(x) {
  x %in% SOUND_CATEGORY_PROP_COLUMNS | grepl("^(sound_(prop|score)_|yamnet_class_[0-9]{3}_.+_(mean_score|prop)$)", x)
}

is_acoustic_frequency <- function(x) {
  grepl("^(dominant_frequency_hz|spectral_centroid_hz|spectral_rolloff85_hz|freq_prop_|octave_prop_)", x)
}

SVF_EXPOSURE_COLUMNS <- c(
  "Sky_%", "SVF_Holmer", "Tree_%", "Plant_%", "Grass_%",
  "Combined_Vegetation_%", "Building_%", "Wall_%"
)

SVF_QC_COLUMNS <- c(
  "Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table",
  "Run_Config_Signature", "Calibration_QC", "Calibration_Ref_Radius_px",
  "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px",
  "Square_Hemisphere_Crop", "SVF_Method", "SVF_Rings",
  "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path",
  "telemetry_matched", "Manual_Mask_Path", "Manual_Sky_IoU",
  "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF_Holmer",
  "SVF_Abs_Error_vs_Manual"
)

is_svf_exposure <- function(x) {
  x %in% SVF_EXPOSURE_COLUMNS
}

EXPECTED_SOUND_FREQUENCY_COLUMNS <- c(
  "dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz",
  "freq_prop_20_125", "freq_prop_125_1000", "freq_prop_1000_4000",
  "freq_prop_4000_8000", "freq_prop_8000_20000",
  "octave_prop_31_5_hz", "octave_prop_63_0_hz", "octave_prop_125_0_hz",
  "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz",
  "octave_prop_2000_0_hz", "octave_prop_4000_0_hz", "octave_prop_8000_0_hz"
)

EXPECTED_SVF_ANALYSIS_COLUMNS <- SVF_EXPOSURE_COLUMNS

if (identical(Sys.getenv("H4_FACET_REFRESH"), "1")) {
  render_h4_faceted_flow(NULL)
  quit(save = "no", status = 0)
}

# ------------------------------------------------------------------------------
# 2. Load & Harmonize Data
# ------------------------------------------------------------------------------
if (identical(Sys.getenv("H4_LASSO_ONLY"), "1") || identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
  # Refresh only the authorised stages from the saved measurement audit.
  # Parse existing expressions, not a second implementation or a temp dependency.
  expressions <- parse(file.path(PROJECT_ROOT, "scripts/H4_multivariate.R"))
  assignment <- function(e) if (is.call(e) && identical(e[[1L]], as.name("<-"))) paste(deparse(e[[2L]]), collapse = "") else ""
  targets <- vapply(expressions, assignment, character(1))
  df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
  final_filtration_df <- read.csv(OUT_CSV, check.names = FALSE)
  for (name in paste0("df$", c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"))) {
    stopifnot(sum(targets == name) == 1L)
    eval(expressions[[which(targets == name)]])
  }
  df_core <- df[df$ParticipantID %in% H4_SPEC$participants & df$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
  h4_retained_candidates <- final_filtration_df$Variable_Name[final_filtration_df$Step3_Decision == "Retained"]
  stopifnot(all(h4_retained_candidates %in% unlist(h4_lasso_domains, use.names = FALSE)))
  if (identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
    # Do not rewrite Step 5 from h4_step5_combinations(): that 15-model kelvin grid
    # was a design check and is not the fitted equation family.
    render_h4_faceted_flow(NULL)
    cat("Step 5 equations are h4_step5_fitted_equations(); the old 15-combination grid is not rewritten.\n")
    quit(save = "no", status = 0)
  }
  # Replace the previous Step-4 report rather than accumulating competing results.
  report <- readLines(TRANSPARENCY_MD, warn = FALSE)
  marker <- grep("^## (Step 4:|Response family:)", report)
  if (length(marker)) report <- head(report, min(marker) - 1L)
  writeLines(c(report, "", "## Step 4: three response-set exploratory LASSO comparison",
    "Post-hoc screening: Empatica-only, eye-tracker-only and combined response matrices. Minimum participant-held-out MSE is primary, one-SE sensitivity only. Samples differ across response sets. Existing Steps 1-2 reused unchanged; full screening-path assertion still requires separate repair."), TRANSPARENCY_MD)
  Sys.setenv(H4_SELECTION_ONLY = "1")
  start <- which(targets == "h4_step4_lasso")
  stopifnot(length(start) == 1L)
  for (i in seq.int(start, length(expressions))) eval(expressions[[i]])
  stop("LASSO-only refresh did not exit at its expected guard.")
}
cat("[1/6] Loading canonical 8-minute analysis dataset...\n")
df <- read.csv(RAW_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
# Refuse an outdated analysis-specific merge; canonical sensor values are authoritative.
BASE_DATA_PATH <- file.path(dirname(PROJECT_ROOT), "Paper3_Github/output/merged_all_11participants_8min.csv")
if (file.exists(BASE_DATA_PATH)) {
  base_data <- read.csv(BASE_DATA_PATH, stringsAsFactors = FALSE, check.names = FALSE)
  key_columns <- c("ParticipantID", "PhaseID", "Datetime")
  key_string <- function(x) do.call(paste, c(x[key_columns], sep = "::"))
  base_keys <- key_string(base_data)
  if (anyDuplicated(base_keys) || anyDuplicated(key_string(df))) stop("Duplicate merge keys in analysis or canonical input.")
  base_order <- match(key_string(df), base_keys)
  if (anyNA(base_order) || nrow(df) != nrow(base_data)) stop("Analysis merge keys differ from canonical input; rebuild statistical inputs.")
  shared_model_columns <- intersect(names(base_data), c(H4_SPEC$all_outcomes, "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources), "ucm_UTCI", "ucm_SND_dBA"))
  stale_columns <- shared_model_columns[!vapply(shared_model_columns, function(v) isTRUE(all.equal(df[[v]], base_data[[v]][base_order], tolerance = 1e-10, check.attributes = FALSE)), logical(1))]
  if (length(stale_columns)) stop("Analysis merge has stale sensor values; rebuild statistical inputs: ", paste(stale_columns, collapse = ", "))
} else {
  warning("Canonical sensor base not found at ", BASE_DATA_PATH, ". Skipping stale-data check (this is expected if running externally).")
}
raw_cols_all <- colnames(df)

yamnet_class_columns <- grep(
  "^yamnet_class_[0-9]{3}_.+_(mean_score|prop)$",
  raw_cols_all,
  value = TRUE
)
yamnet_class_names <- unique(sub("_(mean_score|prop)$", "", yamnet_class_columns))
yamnet_class_ids <- unique(sub("^yamnet_class_([0-9]{3})_.*$", "\\1", yamnet_class_names))
if (length(yamnet_class_names) > 0L && (length(yamnet_class_names) != 521L || !setequal(yamnet_class_ids, sprintf("%03d", 0:520)))) {
  warning(
    "YAMNet class fields are incomplete (found ", length(yamnet_class_names),
    " of 521). The physical H4 model does not use YAMNet; the audit will report those fields as unavailable.",
    call. = FALSE
  )
}
EXPECTED_SOUND_PROP_COLUMNS <- if (length(yamnet_class_names)) paste0(yamnet_class_names, "_prop") else character()
EXPECTED_SOUND_SCORE_COLUMNS <- if (length(yamnet_class_names)) paste0(yamnet_class_names, "_mean_score") else character()
EXPECTED_SOUND_ANALYSIS_COLUMNS <- c(
  EXPECTED_SOUND_PROP_COLUMNS,
  EXPECTED_SOUND_SCORE_COLUMNS,
  EXPECTED_SOUND_FREQUENCY_COLUMNS
)

df$ParticipantID <- as.character(df$ParticipantID)
df$PhaseID <- as.character(df$PhaseID)
df <- df[df$ParticipantID %in% PARTICIPANTS, ]
df$ParticipantID <- factor(df$ParticipantID, levels = PARTICIPANTS)

# Declared study averages; averaging does not prove correction of body shielding.
# LYS1 is on the participant and LYS2 on the researcher, not two equivalent wearers.
df$atmo_pm1_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1")], na.rm = TRUE)
df$atmo_pm2.5_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5")], na.rm = TRUE)
df$atmo_pm10_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10")], na.rm = TRUE)
df$lys_lux_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
df$lys_medi_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi")], na.rm = TRUE)
df$lys_kelvin_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")], na.rm = TRUE)

df_core <- df[df$PhaseID %in% CORE_PHASES, ]
cat(sprintf(
  "Loaded %d observations across %d participants (%d core outdoor epochs).\n",
  nrow(df), length(unique(df$ParticipantID)), nrow(df_core)
))

# ==============================================================================
# STEP 1: SCHEMA PARTITION & ROLE CLASSIFICATION
# ==============================================================================
cat("[2/6] Step 1: Auditing full schema and partitioning analytical roles...\n")

classify_col_role <- function(c) {
  if (grepl("^empatica_hrv_fd_5min_", c)) {
    role <- "Physiological Signal Quality & HRV Windowing (Empatica QC)"
    plat <- "Empatica EmbracePlus"
    unit <- "QC / ms²"
    act <- "Excluded from exposure funnel; physiological QC and window integrity metric"
    keep <- "Excluded"
  } else if (c %in% c(
    "ParticipantID", "PhaseID", "Datetime", "Date", "ucm_Date", "atmo_lys_Date", "eyetracker_Date",
    "ucm_GPS_lat", "ucm_GPS_lon", "ucm_GPS_alt", "ucm_GPS_HDOP", "ucm_GPS_hdg", "ucm_MAG_hdg",
    "ucm_GPS_speed_valid_sample_count", "pct_complete", "gvi_match_dist_m"
  )) {
    role <- "Study Metadata & Spatiotemporal Tracking"
    plat <- if (grepl("^ucm_", c)) "UCM Backpack" else if (grepl("^atmo_lys_", c)) "Atmo / LYS" else if (grepl("^eyetracker_", c)) "Pupil Labs" else if (grepl("^gvi_", c)) "GVI" else "Study Design"
    unit <- "Metadata"
    act <- "Excluded from exposure funnel; spatial/temporal tracking only"
    keep <- "Excluded"
  } else if (c %in% SOUND_QC_COLUMNS) {
    role <- "Acoustic Processing QC & Provenance"
    plat <- "YAMNet / Spectral Processing"
    unit <- if (grepl("_hz$|sample_rate", c)) "Hz" else if (grepl("duration|offset", c)) "s" else if (grepl("prop", c)) "proportion" else "QC"
    act <- "Excluded from exposure funnel; processing provenance / completeness / spectral-coverage QC"
    keep <- "Excluded"
  } else if (c %in% SVF_QC_COLUMNS) {
    role <- "SVF Processing QC & Provenance"
    plat <- "CamUp / DeepLabV3+ Xception65"
    unit <- if (grepl("Radius|Center|Width|Height", c)) "px" else if (grepl("IoU|Dice|Accuracy", c)) "validation metric" else "QC"
    act <- "Excluded from exposure funnel; SVF calibration, segmentation, provenance, or manual-validation QC"
    keep <- "Excluded"
  } else if (grepl("^questionnaire_clothing_|^questionnaire_background_", c) ||
    c %in% c("questionnaire_participant_id", "questionnaire_response_index_within_participant", "questionnaire_height_m", "questionnaire_weight_kg", "questionnaire_bmi_kg_m2", "questionnaire_bmi_category_who")) {
    role <- "Participant Demographics & Clothing Metadata"
    plat <- "Questionnaire"
    unit <- "Demographic"
    act <- "Excluded from exposure funnel; baseline cohort characterization"
    keep <- "Excluded"
  } else if (grepl("__lux_cat$", c)) {
    role <- "Derived Light Category (not an independent continuous exposure)"
    plat <- "LYS"
    unit <- "Category"
    act <- "Derived illuminance category; continuous lux is available; no averaged replacement exists."
    keep <- "Excluded"
  } else if (grepl("__lys_movement$", c) || c %in% c("ucm_GPS_speed_kmh", "empatica__met", "empatica_acc_x", "empatica_acc_y", "empatica_acc_z", "empatica_vector_magnitude")) {
    role <- "Movement & Exertion Covariates (Z)"
    plat <- if (grepl("^ucm_", c)) "UCM Backpack" else if (grepl("^atmo_lys_", c)) "LYS" else "Empatica EmbracePlus"
    unit <- if (c == "ucm_GPS_speed_kmh") "km/h" else if (c == "empatica__met") "MET" else if (grepl("__lys_movement$", c)) "Device movement output" else "g"
    act <- "Movement covariate, not an environmental exposure; model adjusts for Mode and Empatica PC_Movement. No LYS movement average is declared."
    keep <- "Excluded"
  } else if (c %in% H4_SPEC$all_outcomes && !grepl("^questionnaire_", c)) {
    role <- "Physiological Sensor Outcomes (Y_physio)"
    plat <- if (grepl("^empatica_", c)) "Empatica EmbracePlus" else "Pupil Labs Neon"
    unit <- if (grepl("heart_rate", c)) "bpm" else if (grepl("skin_temperature", c)) "°C" else if (grepl("pupil", c)) "mm" else if (grepl("eda", c)) "µS" else if (grepl("rmssd", c)) "ms" else "Physio unit"
    act <- "Excluded from exposure funnel; objective dependent outcome (Y)"
    keep <- "Retained"
  } else if (c %in% H4_SPEC$all_outcomes && grepl("^questionnaire_", c)) {
    role <- "Psychological Survey Outcomes (Y_psych)"
    plat <- "Post-Phase Surveys (STAI, PRS)"
    unit <- "Survey score"
    act <- "Excluded from exposure funnel; subjective psychological outcome (Y)"
    keep <- "Excluded"
  } else if (grepl("^(empatica|eyetracker|questionnaire)_", c)) {
    role <- "Sensor or Questionnaire Field Outside Declared H4 Outcome Set"
    plat <- if (grepl("^empatica_", c)) "Empatica EmbracePlus" else if (grepl("^eyetracker_", c)) "Pupil Labs Neon" else "Questionnaire"
    unit <- "Not modeled in declared H4 outcome family"
    act <- "Excluded from H4 model; not in the shared 30-outcome specification"
    keep <- "EXCLUDED UNDECLARED H4 OUTCOME"
  } else {
    role <- "Environmental Stressor Candidates (X_env)"
    plat <- if (grepl("^ucm_", c)) "UCM Backpack" else if (grepl("^atmo_lys_", c)) "Atmotube / LYS" else if (grepl("^gvi_|^tree_|^grass_|^plant_", c)) "Eye-Level Panoramic Imagery" else if (is_sound_semantic(c)) "YAMNet Audio Classification" else if (is_acoustic_frequency(c)) "Native-WAV Spectral Analysis" else if (is_svf_exposure(c)) "CamUp / DeepLabV3+ Xception65" else "Solar Models"
    unit <- if (grepl("temp|UTCI|PET|MRT|T_bot|T_top|T_mid|HUMIDEX", c)) "°C" else if (grepl("SND|dBA", c)) "dBA" else if (grepl("pm", c)) "µg/m³" else if (grepl("lux", c)) "lux" else if (grepl("medi", c)) "medi" else if (grepl("kelvin", c)) "K" else if (grepl("gvi|tree|grass|plant", c)) "%" else if (grepl("RH", c)) "%" else if (grepl("WIND", c)) "m/s" else if (grepl("_hz$", c)) "Hz" else if (is_sound_semantic(c) || grepl("^freq_prop_|^octave_prop_", c)) "proportion / score" else if (c == "SVF_Holmer") "0-1" else if (grepl("_%$", c)) "%" else "Physical unit"
    act <- "Retained for Step 2 technical sensor consolidation"
    keep <- "RETAINED FOR FILTRATION"
  }
  return(c(plat, role, unit, act, keep))
}

# Add derived bilateral columns into the full variable catalog
derived_cols_all <- c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg")
all_variables_pool <- c(raw_cols_all, derived_cols_all)

step1_mat <- t(sapply(all_variables_pool, function(col) {
  if (col %in% derived_cols_all) {
    plat <- if (grepl("^atmo_", col)) "Atmotube" else "LYS Study Average"
    unit <- if (grepl("pm", col)) "µg/m³" else if (grepl("lux", col)) "lux" else if (grepl("medi", col)) "medi" else "K"
    c(plat, "Environmental Stressor Candidates (X_env)", unit, "Retained for Step 2 technical sensor consolidation", "RETAINED FOR FILTRATION")
  } else {
    classify_col_role(col)
  }
}))

# ==============================================================================
# STEP 2: TECHNICAL SENSOR CONSOLIDATION & PRE-PROCESSING
# ==============================================================================
cat("[3/6] Step 2: Checking explicit replacements, measurement type and within-person availability...\n")

average_sources <- list(
  atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
  atmo_pm2.5_avg = H4_SPEC$bilateral_sources$atmo_pm2.5_avg,
  atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10"),
  lys_lux_avg = H4_SPEC$bilateral_sources$lys_lux_avg,
  lys_medi_avg = c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi"),
  lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")
)
stopifnot(length(unlist(average_sources)) == 12L, !anyDuplicated(unlist(average_sources)))
h4_prepared_for_vif <- h4_prepare_data(df)
audit_phase_groups <- split(seq_len(nrow(df_core)), paste(df_core$ParticipantID, df_core$PhaseID, sep = "::"))
audit_availability <- do.call(rbind, lapply(all_variables_pool, function(col) {
  values <- if (is.numeric(df_core[[col]])) {
    vapply(audit_phase_groups, function(ix) h4_mean(df_core[[col]][ix]), numeric(1))
  } else rep(NA_real_, length(audit_phase_groups))
  ids <- sub("::.*", "", names(audit_phase_groups))
  centered <- h4_person_mean_center(values, ids)
  data.frame(Variable_Name = col, Available_Phase_Cells = sum(is.finite(values)),
    Available_Participants = length(unique(ids[is.finite(values)])),
    Within_Person_SD = if (sum(is.finite(centered)) > 1L) sd(centered, na.rm = TRUE) else NA_real_)
}))

h4_step2_representation <- function(col) {
  if (col %in% c("ucm_SUN_alt", "ucm_SUN_az")) return("Declared Step 2 exclusion: solar altitude and solar azimuth are outside the selected exposure set")
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_humidity$", col)) return("Raw-source inventory only: UCM ucm_AIR_RH is the declared relative-humidity measure")
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_temperature$", col)) return("Raw-source inventory only: UCM ucm_AIR_temp is the declared ambient-temperature measure")
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Declared formulation choice: use the corresponding unsuffixed UCM measure")
  if (grepl("^ucm_IR_", col)) return("Declared exclusion: UCM infrared channels are outside the core exposure set")
  if (grepl("^ucm_WIND_", col) && col != "ucm_WIND_TWS") return("Wind representative: ucm_WIND_TWS; no AWA, AWS or TWD co-entry")
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  if (col %in% c("ucm_AIR_T_bot", "ucm_AIR_T_mid", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_temp; tier channels not co-entered")
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  if (is_svf_exposure(col) && col != "SVF_Holmer") return("Sky openness represented by SVF_Holmer; scene percentages are separate secondary constructs, not equivalent exposures")
  if (col == "ucm_OPT") return("Composite thermal-stress representative: unsuffixed ucm_UTCI; alternative indices not asserted identical")
  ""
}

classify_step2_consolidation <- function(col, role) {
    if (col == "ucm_fp") {
      return(c("Measurement definition and units", "UNVERIFIED DEFINITION (EXCLUDED)",
        "The definition, units and intended interpretation of fp have not been verified against source documentation; retain in the inventory but exclude from Step 2 analytical eligibility."))
    }
    if (role == "Physiological Responses (Y_physio)") {
      return(c("Physiological outcome", "Retained", "Passing through to LASSO"))
    }
    if (role != "Environmental Stressor Candidates (X_env)") {
    return(c("N/A - Non-Environmental Stream", "N/A", "Non-environmental variable (metadata, demographic, covariate, or outcome)."))
  }

  replacement <- names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))]
  observed <- audit_availability[match(col, audit_availability$Variable_Name), ]
  representation <- h4_step2_representation(col)
  if (nzchar(representation)) return(c("Declared Step 2 exposure representation", "ALTERNATIVE REPRESENTATION (EXCLUDED)", representation))
  if (is_acoustic_frequency(col)) return(c("Separate frequency construct", "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Spectral descriptors remain available for separate frequency analyses; they are not equivalent to dBA and are not deleted from the input."))
  if (is_sound_semantic(col)) return(c("Separate sound-type construct", "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Semantic sound-type outputs remain secondary; source type is not equivalent to pressure level."))
  if (length(replacement)) {
    rule <- "Declared average source (exact mapping)"
    stat <- "CONSOLIDATED RAW CHANNEL (EXCLUDED)"
    rat <- paste0("Source of ", replacement, "; not co-entered with its own deterministic average. This is a study aggregation choice, not evidence that placement bias was eliminated. LYS1/LYS2 measure different wearer locations.")
  } else if (grepl("^atmo_lys_LYS[12]__lys_(rgb|[rgb]')", col)) {
    rule <- "Auxiliary device colour channels"
    stat <- "AUXILIARY DEVICE CHANNEL (EXCLUDED)"
    rat <- "Exported RGB/IR or r'/g'/b' channel; no average or conversion to an independently calibrated H4 exposure is declared. Kept in the inventory, not falsely claimed to be represented by lux. Validate units/calibration and a spectral hypothesis before modeling."
  } else if (col %in% c("sound_prop_unidentified", "sound_class_id", "sound_category_label")) {
    rule <- "Rule 2.5: Acoustic Residue & Discrete Classifiers"
    stat <- "RESIDUAL / DISCRETE CLASSIFIER (EXCLUDED)"
    rat <- "Unclassified residual prevalence and categorical labels excluded from the continuous-exposure screen; calibrated LAeq, YAMNet semantic outputs, and spectral descriptors remain separately auditable."
  } else if (col == "ucm_IO_flag") {
    rule <- "Rule 2.6: Microclimate Setting Protocol Flag"
    stat <- "DISCRETE PROTOCOL FLAG (EXCLUDED)"
    rat <- "Discrete indoor/outdoor setting flag excluded; experimental phase protocol already stratifies outdoor travel routes."
  } else if (!is.numeric(df_core[[col]])) {
    rule <- "Measurement type"
    stat <- "NON-NUMERIC LABEL (EXCLUDED)"
    rat <- "Not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input."
  } else if (observed$Available_Phase_Cells < 2L || observed$Available_Participants < 2L || !is.finite(observed$Within_Person_SD) || observed$Within_Person_SD < 1e-12) {
    rule <- "Within-person estimability / availability"
    stat <- if (is_svf_exposure(col)) "PENDING SVF PROCESSING / MERGE" else "INSUFFICIENT WITHIN-PERSON COVERAGE (EXCLUDED)"
    rat <- sprintf("Only %d of %d participant-phase cells across %d participants have finite phase means; a within-person effect cannot be estimated from one phase per participant or no centered variation. No imputation; rerun eligibility after broader valid coverage.", observed$Available_Phase_Cells, nrow(h4_prepared_for_vif$data), observed$Available_Participants)
    if (is_svf_exposure(col)) rat <- paste0("Planned H4 candidate awaiting broader SVF processing/merge; not scientifically rejected or permanently excluded. Eligibility is recalculated from every current input. ", rat)
  } else {
    rule <- if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD", "ucm_SUN_az")) "Circular measurement: joint sine/cosine terms required" else "Available numeric measurement"
    stat <- "Retained"
    rat <- sprintf("Available in %d phase cells across %d participants after declared representation rules. Eligibility is not proof of measurement validity or automatic model inclusion.", observed$Available_Phase_Cells, observed$Available_Participants)
  }
  return(c(rule, stat, rat))
}

step2_mat <- t(sapply(1:length(all_variables_pool), function(i) {
  classify_step2_consolidation(all_variables_pool[i], step1_mat[i, 2])
}))

# ==============================================================================
# STEP 3: OUTCOME-BLIND WITHIN-PERSON DESIGN DIAGNOSTICS
# ==============================================================================
cat("[4/6] Step 3: Auditing every Step-2 eligible measurement; no domain shortlist...\n")

h4_audit_step3 <- function(raw, candidates) {
  candidates <- sort(candidates)
  keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
  cells <- sort(unique(keys))
  indices <- lapply(cells, function(key) which(keys == key))
  id <- sub("::.*", "", cells)
  blocks <- setNames(lapply(candidates, function(v) {
    if (v == "ucm_SUN_az") {
      cbind(sin = vapply(indices, function(ix) h4_mean(sin(raw[[v]][ix] * pi / 180)), numeric(1)),
            cos = vapply(indices, function(ix) h4_mean(cos(raw[[v]][ix] * pi / 180)), numeric(1)))
    } else matrix(vapply(indices, function(ix) h4_mean(raw[[v]][ix]), numeric(1)), ncol = 1L)
  }), sort(candidates))
  # Keep names aligned with the actual data; alphabetical order is only a tie rule.
  blocks <- blocks[order(names(blocks))]
  z <- cbind(Mode_Walk = as.numeric(grepl("::Walk", cells)),
             PC_Movement = vapply(indices, function(ix) h4_mean(raw$empatica_vector_magnitude[ix]), numeric(1)))
  complete <- complete.cases(do.call(cbind, blocks), z)
  omissions <- data.frame(Cell = cells[!complete], Missing = vapply(which(!complete), function(i) {
    paste(c(names(blocks)[!vapply(blocks, function(b) all(is.finite(b[i, ])), logical(1))],
      colnames(z)[!is.finite(z[i, ])]), collapse = ", ")
  }, character(1)))
  if (sum(complete) < 4L || length(unique(id[complete])) < 2L) stop("Insufficient common phase cells for screening.")
  center <- function(x) {
    x <- x[complete, , drop = FALSE]
    for (j in seq_len(ncol(x))) x[, j] <- h4_person_mean_center(x[, j], id[complete])
    x
  }
  blocks <- lapply(blocks, center)
  z <- center(z)
  exposure <- do.call(cbind, blocks)
  colnames(exposure) <- unlist(lapply(names(blocks), function(v) {
    if (ncol(blocks[[v]]) == 1L) v else paste0(v, "__", colnames(blocks[[v]]))
  }))
  if (any(apply(cbind(exposure, z), 2, sd) < 1e-12)) stop("Constant column on the common screening sample; review eligibility.")
  pearson <- cor(exposure)
  spearman <- cor(exposure, method = "spearman")
  pair_index <- which(upper.tri(pearson), arr.ind = TRUE)
  pairs <- data.frame(Field1 = rownames(pearson)[pair_index[, 1]], Field2 = colnames(pearson)[pair_index[, 2]],
    Pearson_r = pearson[pair_index], Spearman_rho = spearman[pair_index], N_phase_cells = nrow(exposure))
  pairs <- pairs[order(-abs(pairs$Pearson_r)), ]
  result <- list(pairs = pairs, omissions = omissions,
    rank = qr(scale(cbind(exposure, z)), tol = 1e-9)$rank)
  result$n_cells <- sum(complete)
  result$n_participants <- length(unique(id[complete]))
  result$design_columns <- ncol(exposure) + ncol(z)
  result$within_contrasts <- sum(complete) - result$n_participants
  stopifnot(setequal(names(blocks), candidates))
  result
}

# Classification describes provenance, not predictor importance or model membership.
# M/A are operational measurement families; all instruments also apply calibration.
h4_measurement_sources <- data.frame(
  Variable_Name = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh",
    "atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg",
    "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
    "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m",
    "ucm_WIND_TWS", "ucm_fp"),
  Measurement_Code = c(rep("M", 4), rep("A", 4), rep("D", 9), "P", "U"),
  Measurement_Type = c(rep("Instrument-reported measurement", 4),
    rep("Averaged instrument measurement", 4), rep("Derived metric", 9),
    "Processed wind; upstream formula unverified", "Definition unverified"),
  Inputs_or_Definition = c(
    "Air-temperature sensor output", "Relative-humidity sensor output",
    "A-weighted sound-pressure level; calibrated acoustic measurement",
    "Measured global horizontal solar irradiance",
    "Arithmetic average of left/right Atmotube PM1 outputs",
    "Arithmetic average of left/right Atmotube PM2.5 outputs",
    "Arithmetic average of left/right Atmotube PM10 outputs",
    "Arithmetic average of LYS1/LYS2 photopic illuminance; spectral calibration upstream",
    "Melanopic equivalent daylight illuminance derived from spectral channels, then LYS1/LYS2 average",
    "Correlated colour temperature derived from spectral/chromaticity channels, then LYS1/LYS2 average",
    "Calculated mean radiant temperature from radiative sensor inputs; deployed UCM algorithm not reproduced here",
    "Human heat-balance index using air temperature, radiation/MRT, humidity, wind and person/clothing/metabolic assumptions; deployed assumptions need UCM documentation",
    "Thermal index using air temperature, radiation/MRT, humidity and wind with reference physiological/clothing assumptions; deployed wind correction needs UCM documentation",
    "Humidity index combining air temperature and vapour pressure derived from humidity",
    "Measured SUN_Gh / calculated G0; exact code in scripts/compute_clearness_index.py",
    "1367 * (1 + 0.033*cos(2*pi*day_of_year/365)) * sin(solar_altitude); calculated extraterrestrial irradiance, not another clearness index",
    "Image-derived vegetation fraction with spatial matching; see canonical GVI source mapping",
    "Exported true-wind-speed channel; exact movement/direction correction unavailable in this repository",
    "Exported UCM fp field; acronym and formula not verified against a current source manual"),
  Evidence = c(rep("CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427", 4),
    rep("Existing bilateral average_sources mapping", 4),
    rep("LYS manufacturer help; Stevenson et al. doi:10.1177/14771535251338582; existing average mapping", 2),
    rep("CityFeel 2017 section 2.3; exact deployed calculation external", 4),
    rep("scripts/compute_clearness_index.py", 2),
    "scripts/merge_11participant_statistical_inputs.py GVI_SOURCE_ALIASES",
    "Export name and available pipeline only; exact upstream formula pending",
    "Current source manual not found; no inferred expansion asserted"),
  stringsAsFactors = FALSE
)

classify_step3_domain <- function(col, step2_stat) {
  if (step2_stat == "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT", "Preserved for separate frequency analyses; not substituted for the core dBA sound-level representative."))
  if (step2_stat == "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "Preserved for separate sound-type analyses; not substituted for the core dBA sound-level representative."))
  if (is_svf_exposure(col) && step2_stat == "PENDING SVF PROCESSING / MERGE") {
    return(c("Sky View / Urban Morphology", "PLANNED CANDIDATE - PROCESSING PENDING", "Retain in the planned candidate inventory. Reassess eligibility and joint model collinearity after completed SVF runs are merged; current fitted model does not yet contain this variable."))
  }
  if (step2_stat != "Retained") {
    return(c("N/A", "N/A", "N/A"))
  }

  dom <- if (is_svf_exposure(col)) "Sky View / Urban Morphology" else if (grepl("gvi|tree|grass|plant", col)) "Greenery" else if (grepl("pm", col)) "Air Pollution" else if (grepl("lux|medi|kelvin", col)) "Visual Light" else if (col == "ucm_SND_dBA" || is_acoustic_frequency(col) || is_sound_semantic(col)) "Acoustic" else "Thermal"
  return(c(dom, "DATA-ELIGIBLE SCREENING CANDIDATE", "All Step-2 eligible measurements advance. Step 3 reports within-person Pearson/Spearman correlations and full matrix rank on the same complete phase cells; no health outcomes or hand-picked domain representatives enter selection."))

}

step3_mat <- t(sapply(1:length(all_variables_pool), function(i) {
  classify_step3_domain(all_variables_pool[i], step2_mat[i, 2])
}))

# ==============================================================================
# STEP 3 CONTINUED: MEASUREMENT PROVENANCE AND SHARED-DESIGN DIAGNOSTICS
# ==============================================================================
cat("Step 3: Tracing measurement sources and within-person dependencies; no predictor elimination...\n")

screening_candidates <- all_variables_pool[step2_mat[, 2] == "Retained"]
h4_vif_phase <- h4_prepared_for_vif$data
audit_phase_key <- paste(h4_vif_phase$ParticipantID, h4_vif_phase$PhaseID, sep = "::")
df_phase_key <- paste(df$ParticipantID, df$PhaseID, sep = "::")
write.csv(
  h4_prepared_for_vif$coverage,
  file.path(OUT_DIR, "H4_Phase_Coverage.csv"),
  row.names = FALSE,
  na = ""
)
design_audit <- h4_audit_step3(df_core, screening_candidates)
h4_retained_candidates <- screening_candidates
stopifnot(setequal(screening_candidates, h4_measurement_sources$Variable_Name))



get_exact_vif <- function(col, type = "retained") {
  # Historical reference fitter below is disabled; the active audit does not use VIF.
  return("-")
}

# Determine final filtration outcome and comprehensive rationale
step1_criterion <- "Role classification: only X_env candidates proceed; metadata, outcomes, QC, and covariates do not enter exposure selection"
step2_criterion <- "Exact replacement mapping; numeric/circular type; observed phase coverage and within-person variation. Auxiliary colour channels require measurement validation"
step3_criterion <- "Measurement provenance and dependencies; within-person correlations and full-design rank are descriptive. All Step-2 candidates remain; no final exposure equation selected"

build_final_row <- function(i) {
  col <- all_variables_pool[i]
  plat <- step1_mat[i, 1]
  role <- step1_mat[i, 2]
  unit <- step1_mat[i, 3]
  step1_stat <- step1_mat[i, 5]
  step2_rule <- step2_mat[i, 1]
  step2_stat <- step2_mat[i, 2]
  dom <- step3_mat[i, 1]
  step3_stat <- step3_mat[i, 2]


  step1_decision <- if (step1_stat == "RETAINED FOR FILTRATION") "Retained" else "-"
  step2_decision <- if (step2_stat == "Retained") "Retained" else "-"
  # Alternatives retain their analytical role, not membership in the reduced model.
  step3_decision <- if (step3_stat == "DATA-ELIGIBLE SCREENING CANDIDATE") "Retained" else "-"
  step1_criterion_row <- paste0(step1_criterion, "; observed role: ", role)
  step2_criterion_row <- paste0(step2_criterion, "; observed rule: ", ifelse(grepl("^N/A", step2_rule), "-", step2_rule), "; status: ", ifelse(step2_stat == "N/A", "-", step2_stat))
  step3_criterion_row <- paste0(step3_criterion, "; observed domain: ", ifelse(dom == "N/A", "-", dom), "; status: ", ifelse(step3_stat == "N/A", "-", step3_stat))

  if (col %in% h4_retained_candidates) {
    final_outcome <- "CANDIDATE AFTER MEASUREMENT AUDIT"
    final_rat <- paste0("Available candidate in ", dom, ". Measurement dependencies are documented; no automatic VIF or correlation elimination. Model membership remains undecided; outcome models have not been refitted.")
  } else if (step3_stat == "EXPLORATORY SOUNDSCAPE CONSTRUCT") {
    final_outcome <- "EXPLORATORY SOUNDSCAPE CONSTRUCT"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT") {
    final_outcome <- "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "EXPLORATORY SVF CONSTRUCT") {
    final_outcome <- "EXPLORATORY SVF CONSTRUCT"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT") {
    final_outcome <- "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "MACRO-CONTEXT CONSTRUCT") {
    final_outcome <- "MACRO-CONTEXT CONSTRUCT"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "SUBSUMED DOMAIN VARIANT") {
    final_outcome <- "SUBSUMED WITHIN DOMAIN"
    final_rat <- step3_mat[i, 3]
  } else if (step3_stat == "SECONDARY CANDIDATE" || step3_stat == "TRANSFORMED DOMAIN SOURCE") {
    final_outcome <- step3_stat
    final_rat <- step3_mat[i, 3]
  } else if (role == "Derived Light Category (not an independent continuous exposure)") {
    final_outcome <- "DERIVED LIGHT CATEGORY"
    final_rat <- step1_mat[i, 4]
  } else if (step2_stat != "N/A" && step2_stat != "Retained") {
    final_outcome <- "CONSOLIDATED RAW STREAM (EXCLUDED)"
    if (step2_stat != "CONSOLIDATED RAW CHANNEL (EXCLUDED)") final_outcome <- step2_stat
    final_rat <- step2_mat[i, 3]
  } else if (role == "Physiological Sensor Outcomes (Y_physio)") {
    final_outcome <- "PHYSIOLOGICAL OUTCOME (Y)"
    final_rat <- "Objective physiological dependent outcome variable; phase means are globally z-standardized after applying the declared HRV log transformations."
  } else if (role == "Psychological Survey Outcomes (Y_psych)") {
    final_outcome <- "PSYCHOLOGICAL OUTCOME (Y)"
    final_rat <- "Subjective psychological survey outcome (STAI / PRS) evaluated post-phase."
  } else if (role == "Movement & Exertion Covariates (Z)") {
    final_outcome <- "MOVEMENT COVARIATE (Z)"
    final_rat <- step1_mat[i, 4]
  } else if (role == "Study Metadata & Spatiotemporal Tracking") {
    final_outcome <- "STUDY METADATA"
    final_rat <- "Spatiotemporal tracking, GPS positioning, or phase grouping metadata."
  } else if (role == "Participant Demographics & Clothing Metadata") {
    final_outcome <- "DEMOGRAPHIC METADATA"
    final_rat <- "Baseline participant demographic characteristics or clothing insulation metadata."
  } else if (role == "Acoustic Processing QC & Provenance") {
    final_outcome <- "QC METRIC"
    final_rat <- "YAMNet/spectral processing provenance, completeness, timing, or frequency-coverage QC; not an exposure predictor."
  } else if (role == "SVF Processing QC & Provenance") {
    final_outcome <- "QC METRIC"
    final_rat <- "SVF calibration, segmentation, run-integrity, telemetry, or manual-validation QC; not an exposure predictor."
  } else {
    final_outcome <- "QC METRIC"
    final_rat <- "Signal quality, missingness verification, or HRV window integrity metric."
  }

  data.frame(
    Variable_Name = col,
    Available_Phase_Cells = audit_availability$Available_Phase_Cells[i],
    Available_Participants = audit_availability$Available_Participants[i],
    Within_Person_SD = audit_availability$Within_Person_SD[i],
    Declared_Average_Replacement = paste(names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))], collapse = "; "),
    Platform_Source = plat,
    Native_Unit = unit,
    Scientific_Domain = ifelse(dom == "N/A", "-", dom),
    Step1_Role = role,
    Step1_Criterion = step1_criterion_row,
    Step1_Decision = step1_decision,
    Step2_Rule = ifelse(grepl("^N/A", step2_rule), "-", step2_rule),
    Step2_Status = ifelse(step2_stat == "N/A", "-", step2_stat),
    Step2_Decision = step2_decision,
    Step3_Status = ifelse(step3_stat == "N/A", "-", step3_stat),
    Step3_Criterion = step3_criterion_row,
    Step3_Decision = step3_decision,
    H4_Screening_Candidate = ifelse(col %in% screening_candidates, "Yes", "No"),
    Final_Filtration_Outcome = final_outcome,
    Scientific_Filtration_Rationale = final_rat,
    stringsAsFactors = FALSE
  )
}

final_filtration_df <- do.call(rbind, lapply(1:length(all_variables_pool), build_final_row))
source_index <- match(final_filtration_df$Variable_Name, h4_measurement_sources$Variable_Name)
for (field in setdiff(names(h4_measurement_sources), "Variable_Name")) {
  final_filtration_df[[field]] <- h4_measurement_sources[[field]][source_index]
  final_filtration_df[[field]][is.na(final_filtration_df[[field]])] <- "-"
}

# Sort: Screening candidates first, then exploratory/subsumed, then outcomes, then metadata
outcome_order <- c(
  "CANDIDATE AFTER MEASUREMENT AUDIT",
  "EXPLORATORY SOUNDSCAPE CONSTRUCT",
  "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT",
  "EXPLORATORY SVF CONSTRUCT",
  "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT",
  "MACRO-CONTEXT CONSTRUCT",
  "SUBSUMED WITHIN DOMAIN",
  "CONSOLIDATED RAW STREAM (EXCLUDED)",
  "PHYSIOLOGICAL OUTCOME (Y)",
  "PSYCHOLOGICAL OUTCOME (Y)",
  "MOVEMENT COVARIATE (Z)",
  "STUDY METADATA",
  "DEMOGRAPHIC METADATA",
  "QC METRIC"
)
final_filtration_df$OrderRank <- match(final_filtration_df$Final_Filtration_Outcome, outcome_order)
final_filtration_df <- final_filtration_df[order(final_filtration_df$OrderRank, final_filtration_df$Variable_Name), ]
final_filtration_df$OrderRank <- NULL

infer_audit_domain <- function(var, role, current_domain) {
    if (!is.na(current_domain) && current_domain != "-") return(current_domain)
    if (role != "Environmental Stressor Candidates (X_env)") {
      if (grepl("Physiological", role)) return("8. Physiological")
      if (grepl("Psychological", role)) return("Psychological")
      if (grepl("Movement", role)) return("Movement")
      if (grepl("QC|Provenance|Signal Quality", role)) return("Metadata")
      return("Metadata")
    }
    if (var == "ucm_SND_dBA" || is_sound_semantic(var) || is_acoustic_frequency(var)) return("1. UCM Acoustic")
    if (grepl("temp|UTCI|PET|MRT|T_mid|T_bot|T_top|HUMIDEX|OPT|AH|RH|WIND|SUN|Clearness|IR_", var, ignore.case = TRUE)) return("2. UCM Thermal")
    if (is_svf_exposure(var) || var %in% SVF_QC_COLUMNS) return("4. UCM Radiation")
    if (grepl("pm", var, ignore.case = TRUE)) return("5. Atmo Pollution")
    if (grepl("lux|medi|kelvin", var, ignore.case = TRUE)) return("6. LYS Light")
    if (grepl("gvi|tree|grass|plant", var, ignore.case = TRUE)) return("7. GVI Greenery")
    "3. UCM Index"
  }

final_filtration_df$Audit_Domain <- mapply(
  infer_audit_domain,
  final_filtration_df$Variable_Name,
  final_filtration_df$Step1_Role,
  final_filtration_df$Scientific_Domain,
  USE.NAMES = FALSE
)

# Integration readiness: the latest sound and SVF families must not silently
# disappear from the audit if they have not yet been merged into the canonical
# 8-minute dataset.
integration_families <- list(
  "Sound category frame proportions" = SOUND_CATEGORY_PROP_COLUMNS,
  "Acoustic frequency descriptors" = EXPECTED_SOUND_FREQUENCY_COLUMNS,
  "SVF / urban morphology" = EXPECTED_SVF_ANALYSIS_COLUMNS
)
integration_df <- do.call(rbind, lapply(names(integration_families), function(fam) {
  expected <- integration_families[[fam]]
  present <- intersect(expected, raw_cols_all)
  missing <- setdiff(expected, raw_cols_all)
  coverage <- audit_availability[match(present, audit_availability$Variable_Name), ]
  minimum_cells <- if (nrow(coverage)) min(coverage$Available_Phase_Cells) else 0L
  data.frame(
    Family = fam,
    Expected_N = length(expected),
    Present_N = length(present),
    Missing_N = length(missing),
    Status = if (length(present) == 0) "ABSENT" else if (minimum_cells < 2L) if (fam == "SVF / urban morphology") "PLANNED_CANDIDATES_PENDING_PROCESSING_MERGE" else "SCHEMA_PRESENT_BUT_INSUFFICIENT_COVERAGE" else if (length(missing) == 0) "SCHEMA_COMPLETE_CHECK_COVERAGE" else "PARTIAL_SCHEMA_CHECK_COVERAGE",
    Minimum_Available_Phase_Cells = minimum_cells,
    Expected_Phase_Cells = nrow(h4_prepared_for_vif$data),
    Missing_Columns = if (length(missing)) paste(missing, collapse = "; ") else "",
    stringsAsFactors = FALSE
  )
}))
write.csv(integration_df, INTEGRATION_CSV, row.names = FALSE, na = "")

# Stage-level counts are descriptive audit counts, not inferential tests.
stage_summary_df <- data.frame(
  Stage = c("Step 1: Complete inventory", "Step 2: Eligible representations", "Step 3: Measurement audit"),
  Count = c(nrow(final_filtration_df), length(screening_candidates), length(h4_retained_candidates)),
  Criterion = c("Every input column plus declared averages",
    "Existing consolidation and representation rules unchanged",
    "Provenance, dependencies and within-person diagnostics; no elimination"),
  stringsAsFactors = FALSE
)
write.csv(stage_summary_df, STAGE_SUMMARY_CSV, row.names = FALSE, na = "")

# ------------------------------------------------------------------------------
# Fully transparent retained/excluded counts at every selection stage
# ------------------------------------------------------------------------------
  # "Not advanced" means the variable does not continue along the H4 screening
# environmental-predictor path. Outcomes, metadata, covariates, QC and labelled
# secondary/exploratory variables remain valid for their declared roles.

count_stage_categories <- function(df, category_col, retained_mask, stage_name, scope_note) {
  cats <- as.character(df[[category_col]])
  cats[is.na(cats) | cats == "" | cats == "-"] <- "Not applicable / unclassified"
  split_idx <- split(seq_len(nrow(df)), cats)

  do.call(rbind, lapply(names(split_idx), function(cat) {
    idx <- split_idx[[cat]]
    retained_n <- sum(retained_mask[idx], na.rm = TRUE)
    total_n <- length(idx)
    data.frame(
      Stage = stage_name,
      Category = cat,
      Total_Entering_Category = total_n,
      Retained_to_Next_Stage = retained_n,
      Not_Advanced_from_Stage = total_n - retained_n,
      Scope = scope_note,
      stringsAsFactors = FALSE
    )
  }))
}

# STEP 1: all audited variables, grouped by analytical role.
step1_counts <- count_stage_categories(
  final_filtration_df,
  "Step1_Role",
  final_filtration_df$Step1_Decision == "Retained",
  "Step 1 - Analytical role classification",
  "All audited variables. Only environmental exposure candidates advance to Step 2."
)

# STEP 2: only Step-1 environmental candidates, grouped by preprocessing rule.
step2_df <- final_filtration_df[
  final_filtration_df$Step1_Decision == "Retained",
  ,
  drop = FALSE
]
step2_counts <- count_stage_categories(
  step2_df,
  "Step2_Rule",
  step2_df$Step2_Decision == "Retained",
  "Step 2 - Sensor preprocessing / consolidation",
  "Only environmental candidates from Step 1."
)

# STEP 3: only Step-2 retained environmental streams, grouped by domain.
step3_df <- final_filtration_df[
  final_filtration_df$Step2_Decision == "Retained",
  ,
  drop = FALSE
]
step3_counts <- count_stage_categories(
  step3_df,
  "Audit_Domain",
  step3_df$Step3_Decision == "Retained",
  "Step 3 - Within-person design diagnostics",
  "Only Step-2 retained environmental streams."
)

step_category_counts_df <- rbind(step1_counts, step2_counts, step3_counts)
write.csv(step_category_counts_df, STEP_CATEGORY_CSV, row.names = FALSE, na = "")

# Environmental domain x status count table. This makes it explicit whether a
# stream was preprocessed away, chosen for screening, retained as secondary, or
# subsumed by another domain representative.
domain_status_df <- final_filtration_df[
  final_filtration_df$Step1_Decision == "Retained",
  c("Audit_Domain", "Step2_Status", "Step3_Status", "Final_Filtration_Outcome"),
  drop = FALSE
]
domain_status_counts_df <- aggregate(
  list(Count = rep(1L, nrow(domain_status_df))),
  by = list(
    Domain = domain_status_df$Audit_Domain,
    Step2_Status = domain_status_df$Step2_Status,
    Step3_Status = domain_status_df$Step3_Status,
    Final_Outcome = domain_status_df$Final_Filtration_Outcome
  ),
  FUN = sum
)
domain_status_counts_df <- domain_status_counts_df[
  order(
    domain_status_counts_df$Domain,
    domain_status_counts_df$Step2_Status,
    domain_status_counts_df$Step3_Status,
    domain_status_counts_df$Final_Outcome
  ),
  ,
  drop = FALSE
]
# write.csv(domain_status_counts_df, DOMAIN_STATUS_CSV, row.names = FALSE, na = "")

# One explicit stop/final row per variable.
stop_stage <- character(nrow(final_filtration_df))
stop_reason <- character(nrow(final_filtration_df))
    screening_path_status <- character(nrow(final_filtration_df))

for (i in seq_len(nrow(final_filtration_df))) {
  r <- final_filtration_df[i, ]

  if (r$Step1_Decision != "Retained") {
    stop_stage[i] <- "Step 1"
    stop_reason[i] <- paste0(
      "Role = ", r$Step1_Role,
      "; not an environmental exposure-predictor candidate."
    )
      screening_path_status[i] <- "Separated from the H4 exposure-predictor screen"
  } else if (r$Step2_Decision != "Retained") {
    stop_stage[i] <- "Step 2"
    stop_reason[i] <- paste0(
      r$Step2_Rule,
      "; status = ", r$Step2_Status, "."
    )
      screening_path_status[i] <- "Stopped by preprocessing/consolidation rule"
  } else if (r$Step3_Decision != "Retained") {
    stop_stage[i] <- "Step 3"
    stop_reason[i] <- paste0(
      "Domain = ", r$Audit_Domain,
      "; status = ", r$Step3_Status, "."
    )
      screening_path_status[i] <- "Subsumed within scientific domain"
  } else if (r$H4_Screening_Candidate == "Yes") {
    stop_stage[i] <- "Step 3"
    stop_reason[i] <- paste(r$Measurement_Type, r$Inputs_or_Definition, sep = "; ")
    screening_path_status[i] <- "Candidate; model specification pending"
  } else {
    stop_stage[i] <- "SECONDARY / EXPLORATORY"
    stop_reason[i] <- paste0(
      "Final role = ", r$Final_Filtration_Outcome, "."
    )
      screening_path_status[i] <- "Retained outside H4 screening candidate set"
  }
}

exclusion_detail_df <- data.frame(
  Variable_Name = final_filtration_df$Variable_Name,
  Audit_Domain = final_filtration_df$Audit_Domain,
  Step1_Role = final_filtration_df$Step1_Role,
  Stop_or_Final_Stage = stop_stage,
    Screening_Path_Status = screening_path_status,
  Reason = stop_reason,
  Final_Outcome = final_filtration_df$Final_Filtration_Outcome,
  stringsAsFactors = FALSE
)
# write.csv(exclusion_detail_df, EXCLUSION_DETAIL_CSV, row.names = FALSE, na = "")

final_outcome_counts_df <- aggregate(
  list(Count = rep(1L, nrow(final_filtration_df))),
  by = list(Final_Outcome = final_filtration_df$Final_Filtration_Outcome),
  FUN = sum
)
final_outcome_counts_df <- final_outcome_counts_df[
  order(-final_outcome_counts_df$Count, final_outcome_counts_df$Final_Outcome),
  ,
  drop = FALSE
]
write.csv(
  final_outcome_counts_df,
  FINAL_OUTCOME_COUNTS_CSV,
  row.names = FALSE,
  na = ""
)

fmt_md_table <- function(df) {
  if (nrow(df) == 0) return("(none)")
  header <- paste0("| ", paste(names(df), collapse = " | "), " |")
  sep <- paste0("| ", paste(rep("---", ncol(df)), collapse = " | "), " |")
  rows <- apply(df, 1, function(x) {
    x <- gsub("\\|", "/", as.character(x))
    paste0("| ", paste(x, collapse = " | "), " |")
  })
  paste(c(header, sep, rows), collapse = "\n")
}

stage_totals_report <- data.frame(
  Stage = c("Step 1", "Step 2", "Step 3"),
  Entering = c(nrow(final_filtration_df), nrow(step2_df), nrow(step3_df)),
  Retained = c(sum(final_filtration_df$Step1_Decision == "Retained"),
    sum(step2_df$Step2_Decision == "Retained"), nrow(step3_df)),
  Not_Advanced = c(sum(final_filtration_df$Step1_Decision != "Retained"),
    sum(step2_df$Step2_Decision != "Retained"), 0L)
)
report_lines <- c(
  "# H4 measurement and model-planning audit",
  "Step 2 excludes fp pending verification of its definition and units. Step 3 groups the eligible candidates. Step 4 compares Empatica-only, ocular-only and combined domain-wise multi-response LASSOs, selected by minimum participant-held-out MSE. No inferential outcome models refitted.",
  "Existing H4_models outputs describe the previous five-exposure model, not this audit.",
  "## Stage totals", fmt_md_table(stage_totals_report),
  "## Eligible fields: provenance and dependencies",
  "M: measurement; A: averaged measurement; D: derived; P: processed wind, algorithm pending; U: unverified definition.",
  "4 M + 4 A + 9 D + 1 P + 1 U = 19. Instrument calibration also involves calculation; M/A are measurement families, not unprocessed signals.",
  fmt_md_table(h4_measurement_sources),
  "Derived does not mean invalid. PET, UTCI and HUMIDEX overlap with measured constituents. MRT is calculated. G0 is the extraterrestrial-irradiance denominator of the clearness index.",
  "Six bilateral averages exist: PM1, PM2.5, PM10, lux, mEDI and Kelvin; the last two remain derived metrics.",
  "## Comparable published approaches",
  "Schaupp et al. (2025), section 2.5.1: environment, noise, their interaction, age and gender, with group random intercept. LAE and relative quiet time had VIF >5 and were fitted in separate models, not iteratively discarded.",
  "https://doi.org/10.1016/j.jenvp.2025.102662",
  "Biel et al. (2020): personal traffic pollution/noise panel; single-pollutant and two-pollutant (air pollutant plus noise) mixed models, with adjustment including temperature. Not every measured exposure in one equation.",
  "https://pmc.ncbi.nlm.nih.gov/articles/PMC7541521/",
  "## Next specification, not yet fitted",
  "Individual meteorological variables represent specific environmental conditions. Composite thermal indices are separate alternatives because they combine overlapping inputs. This is a disclosed proposed specification, not a published mandatory variable list.",
  h4_proposed_equations,
  "Exposure-specific associations are not mutually adjusted effects of all eligible candidates. Comparisons are exploratory and need multiplicity handling; do not choose the smallest p-value.",
  "Participant is the independent cluster; phases are repeated observations. Ordinal single-item outcomes require appropriate models, not automatically Gaussian LMMs.",
  "## Shared-design diagnostics, no elimination",
  sprintf("%d phase cells, %d participants, %d exposure/covariate columns, %d within-person contrasts, matrix rank %d.",
    design_audit$n_cells, design_audit$n_participants, design_audit$design_columns,
    design_audit$within_contrasts, design_audit$rank),
  fmt_md_table(design_audit$omissions),
  "## Within-person correlations", fmt_md_table(design_audit$pairs),
  "## Limitations and sources",
  "fp definition and exact true-wind correction remain unverified. PET/UTCI upstream assumptions are not reconstructed here.",
  "CityFeel: https://doi.org/10.1016/j.egypro.2017.07.427",
  "LYS: https://lystechnologies.io/help/ and https://doi.org/10.1177/14771535251338582",
  "Clearness formulas: scripts/compute_clearness_index.py. Averages: active average_sources mapping."
)
writeLines(report_lines, TRANSPARENCY_MD, useBytes = TRUE)

cat("\nH4 SCREENING-PATH COUNTS\n")
for (i in seq_len(nrow(stage_totals_report))) {
  cat(sprintf(
    "  %s: entering=%d | retained=%d | not advanced=%d\n",
    stage_totals_report$Stage[i],
    stage_totals_report$Entering[i],
    stage_totals_report$Retained[i],
    stage_totals_report$Not_Advanced[i]
  ))
}
cat("\nSTEP 3 DOMAIN COUNTS\n")
for (i in seq_len(nrow(step3_counts))) {
  cat(sprintf(
    "  %s: entering=%d | retained=%d | not advanced=%d\n",
    step3_counts$Category[i],
    step3_counts$Total_Entering_Category[i],
    step3_counts$Retained_to_Next_Stage[i],
    step3_counts$Not_Advanced_from_Stage[i]
  ))
}

# STEP 4: exploratory multi-response LASSO on matched windows.
# Domain-wise prediction does not establish independent effects across domains.
# Standardisation is fitted inside each training fold; held-out Y is never used.
h4_step4_lasso <- function(raw, audit, outcomes = unlist(H4_SPEC[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)) {
    if (!requireNamespace("glmnet", quietly = TRUE)) stop("Step 4 requires the installed glmnet package.")
    stopifnot(length(outcomes) > 1L, !anyDuplicated(outcomes), all(outcomes %in% names(raw)))
    
    y <- as.matrix(raw[, outcomes, drop = FALSE])
    storage.mode(y) <- "double"
    y[!is.finite(y)] <- NA_real_
    
    available <- tolower(as.character(raw)) %in% c("true", "1")
    y[!available, intersect(colnames(y), H4_SPEC)] <- NA_real_
    for (v in intersect(colnames(y), H4_SPEC)) {
      y[y[, v] <= 0 & !is.na(y[, v]), v] <- NA_real_
      y[, v] <- log(y[, v])
    }
    
    domains <- lapply(h4_lasso_domains, setdiff, y = c("Clearness_Index_G0", "ucm_fp"))
    eligible <- audit[audit == "Retained"]
    
    audit <- NA_character_
    audit <- "Not entered"
    audit <- "Not a Step-3 environmental candidate"
    audit <- audit <- NA_integer_
    audit <- audit <- audit <- audit <- NA_real_
    audit <- NA_integer_
    audit <- NA_integer_
    audit <- audit <- NA_real_
    audit <- "Not entered"
    audit <- "Not entered"
    audit <- NA_real_
    
    audit[audit %in% outcomes] <- "Response Y; never entered in predictor X"
    audit[audit == "Clearness_Index_G0"] <- "Calculation denominator; not an exposure in Step 4"
    audit[audit == "ucm_fp"] <- "Definition unverified; not entered in Step 4"
    
    ratios <- exp(seq(log(1), log(0.001), length.out = 60L))
    notes <- c("", "## Step 4: exploratory domain-wise multi-response LASSO (Forcing EXACTLY 1 winner per category)",
      paste("glmnet version:", packageVersion("glmnet")),
      sprintf("Input is matched 10-second windows; %d response columns; declared HRV log transforms and availability flags respected when applicable.", length(outcomes)),
      "Leave one participant out; training-only X/Y standardisation; Mode unpenalised; each participant has equal training weight and equal validation weight.",
      "Tune a 60-point relative lambda path (1 to 0.001) by minimum held-out participant MSE. ONE WINNER PER CATEGORY is forced by selecting the variable with the maximum non-zero coefficient norm.",
      paste("Response columns:", paste(outcomes, collapse = ", ")))
      
    for (domain in names(domains)) {
      variables <- intersect(domains[[domain]], intersect(eligible, names(raw)))
      if (!length(variables)) next
      index <- match(variables, audit)
      audit[index] <- domain
      
      if (length(variables) == 1) {
          audit[index] <- "Retained"
          audit[index] <- "Retained automatically (only 1 variable in domain)"
          notes <- c(notes, paste(domain, "selected:", variables[1], "(only candidate)"))
          cat(tail(notes, 1L), "\n")
          next
      }
      
      x <- cbind(ModeBike = as.numeric(grepl("^Bike", raw)), as.matrix(raw[, variables, drop = FALSE]))
      storage.mode(x) <- "double"
      x[!is.finite(x)] <- NA_real_
      complete <- complete.cases(x, y)
      ids <- as.character(raw[complete])
      x <- x[complete, , drop = FALSE]
      y_complete <- y[complete, , drop = FALSE]
      
      audit[index] <- nrow(x)
      audit[index] <- length(unique(ids))
      audit[index] <- ncol(y_complete)
      audit[index] <- nrow(raw) - nrow(x)
      
      if (nrow(x) < 10L || length(unique(ids)) < 2L) {
        audit[index] <- "Insufficient complete cases"
        notes <- c(notes, paste(domain, "FAILED: Insufficient complete cases"))
        next
      }
      
      sds <- apply(x, 2, sd)
      if (any(sds == 0)) {
         x <- x[, sds > 0, drop = FALSE]
      }
      
      if (ncol(x) <= 2) { # Only ModeBike and 1 variable
         winner <- setdiff(colnames(x), "ModeBike")[1]
         win_idx <- match(winner, audit)
         audit[win_idx] <- "Retained"
         audit[index] <- "Retained automatically after zero-variance drop"
         notes <- c(notes, paste(domain, "selected:", winner))
         cat(tail(notes, 1L), "\n")
         next
      }
      
      folds <- match(ids, unique(ids))
      
      fit <- tryCatch(
        glmnet::cv.glmnet(
          x = x, y = y_complete, family = "mgaussian",
          foldid = folds, alpha = 1, standardize.response = TRUE,
          penalty.factor = c(0, rep(1, ncol(x) - 1)) # Do not penalize ModeBike
        ),
        error = function(e) NULL
      )
      
      if (is.null(fit)) {
        audit[index] <- "LASSO convergence failed"
        winner <- variables[1]
        win_idx <- match(winner, audit)
        audit[win_idx] <- "Retained"
        notes <- c(notes, paste(domain, "FAILED: Convergence error, defaulted to first:", winner))
        cat(tail(notes, 1L), "\n")
        next
      }
      
      coefs <- coef(fit, s = "lambda.min")
      importance <- numeric(length(variables))
      names(importance) <- variables
      
      for (i in seq_along(coefs)) {
         c_mat <- as.numeric(abs(coefs[[i]][-1, ])) # exclude intercept
         var_names <- rownames(coefs[[i]])[-1]
         for (v in variables) {
             if (v %in% var_names) {
                 idx <- match(v, var_names)
                 importance[v] <- importance[v] + c_mat[idx]
             }
         }
      }
      
      audit[index] <- importance
      
      if (all(importance == 0)) {
         winner <- variables[1] # fallback if all shrunk to zero
      } else {
         winner <- variables[which.max(importance)]
      }
      
      win_idx <- match(winner, audit)
      audit[win_idx] <- "Retained"
      audit[index] <- ifelse(variables == winner, "Selected as highest importance variable in domain", "Not selected (lower importance)")
      
      notes <- c(notes, paste(domain, "selected:", winner, "with norm", sprintf("%.4f", importance[winner])))
      cat(tail(notes, 1L), "\n")
    }
    
    list(audit = audit, notes = notes)
  }
  step4_families <- list(
  Empatica = H4_SPEC$outcomes$Physiological_Autonomic,
  Eyetracker = H4_SPEC$outcomes$Physiological_Ocular,
  Combined = unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
)
stopifnot(identical(unname(lengths(step4_families)), c(13L, 13L, 26L)),
  all(grepl("^empatica_", step4_families$Empatica)),
  all(grepl("^eyetracker_", step4_families$Eyetracker)),
  !length(intersect(step4_families$Empatica, step4_families$Eyetracker)))
step4_family_results <- lapply(step4_families, function(outcomes) h4_step4_lasso(df_core, final_filtration_df, outcomes))
final_filtration_df <- final_filtration_df[, !grepl("^Step4_", names(final_filtration_df)), drop = FALSE]
for (family in names(step4_family_results)) {
  result <- step4_family_results[[family]]
  fields <- grep("^Step4_", names(result$audit), value = TRUE)
  for (field in fields) final_filtration_df[[sub("^Step4_", paste0("Step4_", family, "_"), field)]] <- result$audit[[field]]
  cat(paste0("\nRESPONSE FAMILY: ", family, "\n"), grep("minimum-error ratio", result$notes, value = TRUE), sep = "\n")
  cat(paste(c(paste0("\n## Response family: ", family), result$notes), collapse = "\n"), file = TRANSPARENCY_MD, append = TRUE)
}
# Union is the declared Step-4 candidate screen, not a final co-exposure model.
final_filtration_df$Step4_Domain <- step4_family_results$Empatica$audit$Step4_Domain
final_filtration_df <- h4_sensor_union(final_filtration_df)

# Write the single unified CSV after domain and integration fields are available.
tryCatch(
  write.csv(final_filtration_df, OUT_CSV, row.names = FALSE, na = ""),
  error = function(e) write.csv(final_filtration_df, sub(".csv$", "_latest.csv", OUT_CSV), row.names = FALSE, na = "")
)
cat(sprintf("SUCCESS: Exported H4 multivariate audit CSV with %d variables to:\n  %s\n", nrow(final_filtration_df), OUT_CSV))

if (identical(Sys.getenv("H4_SELECTION_ONLY"), "1")) {
  selected_step2 <- final_filtration_df$Variable_Name[final_filtration_df$Step2_Decision == "Retained"]
  stopifnot(!any(grepl("^ucm_IR_|^ucm_.*_(SR|S)$|^ucm_AH$|^ucm_AIR_T_(bot|mid|top)$|IO_flag", selected_step2)),
            identical(grep("^ucm_WIND_", selected_step2, value = TRUE), "ucm_WIND_TWS"),
            identical(grep("^gvi_|^(plant|grass|tree)_phase_mean$", selected_step2, value = TRUE), "gvi_50m"),
            !any(is_acoustic_frequency(selected_step2)),
            all(c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_UTCI", "ucm_SND_dBA") %in% selected_step2))
  writeLines(c(
    "Step 3: measurement categories; no analyst-selected model combinations.",
    "Step 4: union of separate Empatica and eye-tracker category-wise LASSO selections; retain an exposure selected by either family at minimum participant-held-out MSE. Pooled-response fits are diagnostics, not the union rule.",
    "Exploratory post-hoc screening; no outcome-inference model refitted. Family/domain samples can differ. Selected category lists are not a validated combined model.",
    paste("Empatica selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Empatica_Decision == "Retained"], collapse = ", ")),
    paste("Eye-tracker selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Eyetracker_Decision == "Retained"], collapse = ", ")),
    paste("Combined union selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Union_Decision == "Retained"], collapse = ", ")),
    paste("Combined selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Combined_Decision == "Retained"], collapse = ", ")),
    paste("Candidates:", paste(h4_retained_candidates, collapse = ", ")),
    "Outcome equations are the four Joint specifications in h4_step5_fitted_equations(), not the retired five-exposure model."), FORMULA_TXT)
  render_audit_pdf(final_filtration_df, AUDIT_PDF, AUDIT_PNG)
  render_h4_faceted_flow(NULL)
  cat("Step-4 exploratory LASSO and audit render completed; inferential outcome models not fitted.\n")
  quit(save = "no", status = 0)
}

# ==============================================================================
# The obsolete outcome fitter that followed an unconditional stop() has been removed.
# It was the old five-exposure VIF model (PM2.5, lux, UTCI, GVI, phase-mean log HRV)
# and contradicted the Step 5 family. Current equations: h4_step5_fitted_equations().
