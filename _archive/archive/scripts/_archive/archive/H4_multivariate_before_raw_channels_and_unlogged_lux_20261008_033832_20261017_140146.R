# ==============================================================================
# SCRIPT: H4_multivariate.R
# PURPOSE: Audit H4 variables, select the outcome-blind exposure set, fit all
#          declared outcomes, and report model diagnostics in this one script.
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
OUT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/H4_multivariate")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)

OUT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
FIGURE_PNG <- file.path(OUT_DIR, "H4_Multivariate_Methodology.png")
DOMAIN_PNG <- file.path(OUT_DIR, "H4_Domain_Audit.png")
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

render_h4_faceted_flow <- function() {
  library(grid)

  OUT_DIR <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final/output/statistical_analysis/H4_multivariate"
  SCRIPT <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final/scripts/H4_multivariate.R"
  PDF_PATH <- file.path(OUT_DIR, "H4_Faceted_Vertical_Flow_final.pdf")
  AUDIT_PATH <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
  MODEL_PATH <- file.path(OUT_DIR, "H4_models/H4_LMM_Results_Table.csv")
  DIAGNOSTICS_PATH <- file.path(OUT_DIR, "H4_models/H4_LMM_Diagnostics.txt")
  FORMULA_PATH <- file.path(OUT_DIR, "H4_Multivariate_Formula.txt")

  audit_all <- read.csv(AUDIT_PATH, stringsAsFactors = FALSE)
  model_results <- read.csv(MODEL_PATH, stringsAsFactors = FALSE)
  diagnostics <- readLines(DIAGNOSTICS_PATH, warn = FALSE)
  source_code <- readLines(SCRIPT, warn = FALSE)

  threshold_line <- grep("^ *vif_threshold *=", source_code, value = TRUE)
  stopifnot(length(threshold_line) == 1L)
  vif_threshold <- as.numeric(sub(".*= *([0-9.]+).*", "\\1", threshold_line))
  stopifnot(any(grepl(paste0("VIF threshold: ", vif_threshold, ";"), diagnostics, fixed = TRUE)))

  # Display averaged Atmo/LYS constructs only; hide the raw left/right streams.
  raw_env <- audit_all[grepl("X_env", audit_all$Step1_Role), ]
  raw_side <- grepl("^atmo_lys_(atmotube_left|atmotube_right|LYS1|LYS2)__", raw_env$Variable_Name)
  raw_sources <- raw_env[raw_side, , drop = FALSE]
  raw_sources$Sensor <- ifelse(grepl("atmotube_left|atmotube_right", raw_sources$Variable_Name), "Atmo raw",
    ifelse(grepl("LYS1", raw_sources$Variable_Name), "LYS1 raw", "LYS2 raw"))
  raw_sources$Column <- raw_sources$Variable_Name
  raw_sources$Column <- sub("^atmo_lys_atmotube_(left|right)__atmotube_", "\\1 ", raw_sources$Column)
  raw_sources$Column <- sub("^atmo_lys_LYS([12])__lys_", "LYS\\1 ", raw_sources$Column)
  raw_sources$Column <- trimws(gsub("_", " ", raw_sources$Column))
  audit <- rbind(raw_env[!raw_side | grepl("^(atmo_|lys_).+_avg$", raw_env$Variable_Name), ], raw_sources)
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
  sensor[grepl("Eye-Level Panoramic Imagery|GVI", sensor, ignore.case = TRUE)] <- "GVI imagery"
  sensor[grepl("CamUp|DeepLab", sensor, ignore.case = TRUE)] <- "SVF imagery"
  sensor[grepl("Native-WAV|YAMNet", sensor, ignore.case = TRUE)] <- "Sound"
  sensor[grepl("Solar", sensor, ignore.case = TRUE)] <- "Solar"
  column_label <- audit$Variable_Name
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
  column_label <- sub("_avg$", " avg", column_label, ignore.case = TRUE)
  audit$Sensor <- sensor
  audit$Column <- trimws(gsub("_", " ", column_label))
  audit <- audit[order(audit$Sensor, audit$Column), ]
  step2 <- audit[audit$Step2_Status == "Retained", ]
  stopifnot(!any(grepl("^atmo_lys_(atmotube_left|atmotube_right|LYS1|LYS2)__", audit$Variable_Name)))

  candidate_names <- c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m")
  candidate_labels <- c("UTCI (thermal)", "Calibrated LAeq / dBA (sound level)", "PM2.5 average (air)", "Mean lux (light)", "GVI at 50 m (greenery)")
  vif_rows <- audit_all[match(candidate_names, audit_all$Variable_Name), ]
  stopifnot(all(vif_rows$Final_Filtration_Outcome == "VIF-RETAINED SCREENING CANDIDATE"))

  vif_line <- grep("VIF final:", diagnostics, value = TRUE)
  stopifnot(length(vif_line) == 1L)
  vif_pairs <- strsplit(sub(".*VIF final: ", "", vif_line), "; ", fixed = TRUE)[[1]]
  vif_values_map <- setNames(
    as.numeric(sub("^[^=]+=", "", vif_pairs)),
    sub("=.*$", "", vif_pairs)
  )
  vif_values <- unname(vif_values_map[candidate_names])
  stopifnot(all(is.finite(vif_values)), all(vif_values < vif_threshold))

  model_formulas <- unique(model_results$Model_Formula)
  formula_patterns <- unique(sub("^[^~]+~", "Outcome ~", model_formulas))
  stopifnot(length(formula_patterns) == 1L)
  formula_text <- formula_patterns[1]
  formula_vars <- all.vars(stats::as.formula(model_formulas[1]))
  stopifnot(all(c("Mode", "PC_Movement", "PC_UTCI", "PC_dBA", "PC_PM25", "PC_Lux", "PC_GVI", "ParticipantID") %in% formula_vars))

  formula_reference <- readLines(FORMULA_PATH, warn = FALSE)
  formula_file_omits_movement <- !any(grepl("PC_Movement", formula_reference, fixed = TRUE))
  has_legacy_vif_five_text <- any(grepl("VIF < 5|VIF >= 5|threshold <5|threshold: 5", source_code, ignore.case = TRUE))
  has_legacy_gvi_exclusion_text <- any(grepl("GVI.*excluded.*VIF < 5", source_code, ignore.case = TRUE))

  # One faceted page; positions are assigned once, never regrouped by stage.
  sensor_order <- c("UCM", "Atmo raw", "Atmo average", "LYS1 raw", "LYS2 raw", "LYS average", "GVI imagery", "SVF imagery", "Sound", "Solar")
  widths <- c(12, 8, 4, 8, 8, 5, 5, 6, 11, 5)
  STEP_COLUMN <- .10
  lefts <- STEP_COLUMN + cumsum(c(0, head(widths, -1))) / sum(widths) * (1 - STEP_COLUMN)
  sensor_width <- widths / sum(widths) * (1 - STEP_COLUMN)
  audit <- audit[order(match(audit$Sensor, sensor_order), audit$Column), ]
  audit$Slot <- ave(seq_len(nrow(audit)), audit$Sensor, FUN = seq_along)
  audit$Subcolumn <- (audit$Slot - 1L) %/% 12L
  audit$Row <- (audit$Slot - 1L) %% 12L
  ncolumns <- sapply(sensor_order, function(s) max(audit$Subcolumn[audit$Sensor == s]) + 1L)
  sensor_id <- match(audit$Sensor, sensor_order)
  audit$X <- lefts[sensor_id] + .005 +
    audit$Subcolumn * sensor_width[sensor_id] / ncolumns[sensor_id]
  stages <- list(
    audit,
    audit[audit$Step2_Status == "Retained", ],
    audit[audit$Variable_Name %in% candidate_names, ],
    audit[audit$Variable_Name %in% candidate_names, ]
  )
  stopifnot(all(candidate_names %in% step2$Variable_Name), nrow(stages[[3]]) == 5L, nrow(stages[[4]]) == 5L)
  stopifnot(all(vapply(stages, function(d) all(d$X == audit$X[match(d$Variable_Name, audit$Variable_Name)]), logical(1))))
  titles <- c(
    paste0("STEP 1\nInventory (", nrow(audit), ")"),
    paste0("STEP 2\nRepresentatives (", nrow(step2), ")\nRules + coverage"),
    "STEP 3\nReduced set (5)\nConstruct rationale",
    paste0("STEP 4\nVIF retained (5; cutoff ", vif_threshold, ")")
  )
  tops <- c(.88, .54, .20, .105)
  row_spacing <- .023
  text_at <- function(x, y, label, size = 18, bold = FALSE, color = "#222222") {
    grid.text(label, x = x, y = y, just = "left",
              gp = gpar(fontsize = size, fontface = if (bold) "bold" else "plain", col = color))
  }
  grDevices::cairo_pdf(PDF_PATH, width = 48, height = 16, onefile = TRUE)
  grid.newpage()
  text_at(.005, .977, "H4 environmental-variable selection", 30, TRUE)
  text_at(.005, .947, "* existing-model exposure | Step 2: declared representations + coverage | Step 3: existing exploratory set, not all-candidate VIF winners", 20)
  pending_svf <- sum(audit$Step2_Status == "PENDING SVF PROCESSING / MERGE")
  if (pending_svf > 0L) text_at(lefts[5] + .005, .60, paste0(pending_svf, " planned SVF candidate\nAwaiting completed merge"), 17)
  for (s in seq_along(sensor_order)) {
    text_at(lefts[s] + .005, .916, sensor_order[s], 23, TRUE)
  }
  for (k in seq_along(stages)) {
    d <- stages[[k]]
    if (k >= 3L) d$Row <- ave(seq_len(nrow(d)), interaction(d$Sensor, d$Subcolumn), FUN = function(x) seq_along(x) - 1L)
    text_at(.005, tops[k] - .058, titles[k], 18, TRUE)
    if (k == 2L && pending_svf > 0L) text_at(lefts[5] + .005, tops[k] - .058,
      "SVF Holmer (planned; merge pending)", 18)
    for (j in seq_len(nrow(d))) {
      row <- d$Row[j]
      label <- d$Column[j]
      if (d$Variable_Name[j] %in% candidate_names) label <- paste0(label, " *")
      if (k == 4L) {
        label <- paste0(label, " | VIF ", formatC(vif_values_map[d$Variable_Name[j]], digits = 3, format = "f"))
      }
      text_at(d$X[j], tops[k] - .058 - row * row_spacing, label, 18,
              bold = d$Variable_Name[j] %in% candidate_names)
    }
    separator_y <- c(.555, .215, .105, .008)[k]
    grid.lines(x = unit(c(.005, .995), "npc"), y = unit(c(separator_y, separator_y), "npc"),
               gp = gpar(col = "#9aa1a6", lwd = 0.7))
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

  # 4. Step 3: Domain Decision
  step3 <- ifelse(
    is_environment & audit_df$Step3_Status != "-",
    ifelse(audit_df$Step3_Decision == "Retained", "Reduced exploratory set",
           ifelse(audit_df$Step3_Status == "Subsumed", "Subsumed (Excluded)", "Exploratory (Excluded)")),
    ifelse(is_outcome, "-",
      ifelse(is_movement, "-", "-")
    )
  )

  # 5. Extract VIF values for the 5 candidates
  candidate <- audit_df$H4_Screening_Candidate == "Yes"
  initial_vif <- suppressWarnings(as.numeric(audit_df$Initial_VIF))
  final_vif <- suppressWarnings(as.numeric(audit_df$Final_VIF))

  # 6. Final Role
  final_role <- ifelse(
    is_physio, "Outcome Y (Physiological)",
    ifelse(is_psych, "Outcome Y (Psychological)",
      ifelse(is_movement, "Movement Covariate (Z)",
        ifelse(audit_df$Final_Filtration_Outcome == "VIF-RETAINED SCREENING CANDIDATE", "Exploratory Predictor (H4 Model)",
          ifelse(grepl("^REMOVED BY VIF", audit_df$Final_Filtration_Outcome), "Excluded (VIF Collinear)",
            ifelse(grepl("^EXPLORATORY", audit_df$Final_Filtration_Outcome), "Secondary / Exploratory Stream",
              ifelse(grepl("SUBSUMED", audit_df$Final_Filtration_Outcome), "Subsumed within Domain",
                ifelse(grepl("CONSOLIDATED", audit_df$Final_Filtration_Outcome), "Consolidated Sensor Stream",
                  ifelse(grepl("MACRO-CONTEXT", audit_df$Final_Filtration_Outcome), "Macro-Context Construct",
                    ifelse(is_metadata_qc, "Metadata / QC", audit_df$Final_Filtration_Outcome)
                  )
                )
              )
            )
          )
        )
      )
    )
  )

  # Append VIF directly to Final Role for candidates so we don't have an empty column
  retained_candidate <- candidate & is.finite(final_vif)
  removed_candidate <- candidate & is.finite(initial_vif) & !is.finite(final_vif)
  
  final_role[retained_candidate] <- sprintf("%s [VIF: %.2f]", final_role[retained_candidate], final_vif[retained_candidate])
  final_role[removed_candidate] <- sprintf("%s [VIF: %.2f]", final_role[removed_candidate], initial_vif[removed_candidate])

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
    `Step 3: Domain decision` = step3,
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
    "Pipeline Rules:",
    "Step 1 (Role): Isolates candidate environmental stressors from outcomes, covariates, and metadata.",
    "Step 2: Declared exposure representations first; exact average mappings and observed within-person coverage second. UCM _S/_SR, IR, alternative wind/humidity/temperature-tier/vegetation channels do not advance. Frequency/type are separate secondary blocks.",
    "Step 3 (Constructs): Reduced exploratory model; alternative constructs remain separately available, not proven redundant.",
    "Step 4 (Collinearity): Uses the configured exposure-screen cutoff; full fixed-effect diagnostics are separate.",
    "Note: 30 outcome-specific models share participants and exposures; they are not independent tests. Review multiplicity and diagnostics.",
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
  vif_threshold = 10,
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

h4_vif <- function(data, candidates) {
  columns <- unname(H4_SPEC$exposure_centered[candidates])
  x <- as.data.frame(data[, columns, drop = FALSE])
  if (!nrow(x) || any(!stats::complete.cases(x))) stop("VIF input has incomplete exposure rows.", call. = FALSE)
  if (length(columns) == 1L) return(stats::setNames(if (stats::sd(x[[1]]) > 0) 1 else Inf, candidates))

  values <- vapply(seq_along(columns), function(i) {
    if (stats::sd(x[[i]]) == 0) return(Inf)
    fit <- stats::lm(x[[i]] ~ ., data = x[-i])
    r2 <- summary(fit)$r.squared
    if (!is.finite(r2) || r2 >= 1 - 1e-10) Inf else 1 / (1 - r2)
  }, numeric(1))
  names(values) <- candidates
  values
}

h4_select_predictors <- function(data) {
  retained <- names(H4_SPEC$exposure_centered)
  trace <- data.frame()
  step <- 1L
  repeat {
    current_vif <- h4_vif(data, retained)
    removed <- if (max(current_vif) >= H4_SPEC$vif_threshold) names(current_vif)[which.max(current_vif)] else ""
    trace <- rbind(trace, data.frame(
      Step = step,
      Predictors = paste(retained, collapse = " + "),
      VIFs = paste(names(current_vif), sprintf("%.3f", current_vif), sep = "=", collapse = "; "),
      Max_VIF = max(current_vif),
      Removed = removed,
      stringsAsFactors = FALSE
    ))
    if (!nzchar(removed)) break
    if (length(retained) == 1L) stop("No varying H4 exposure remains after VIF screening.", call. = FALSE)
    retained <- setdiff(retained, removed)
    step <- step + 1L
  }
  list(
    retained = retained,
    initial_vif = h4_vif(data, names(H4_SPEC$exposure_centered)),
    final_vif = h4_vif(data, retained),
    trace = trace
  )
}

h4_model_formula <- function(outcome, retained, ordinal = FALSE) {
  response <- if (ordinal) paste0("Outcome_ORD__", outcome) else paste0("Outcome_GZ__", outcome)
  paste(response, "~ Mode + PC_Movement +", paste(unname(H4_SPEC$exposure_centered[retained]), collapse = " + "), "+ (1 | ParticipantID)")
}

h4_run_model <- function(input_path, prepared, selection) {
  required_packages <- c("lme4", "lmerTest", "ordinal", "DHARMa")
  missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing_packages)) {
    stop(
      "Required published R packages are not installed: ", paste(missing_packages, collapse = ", "),
      ". Install them in the existing R library, then rerun; this script will not install packages automatically.",
      call. = FALSE
    )
  }

  input_path <- normalizePath(input_path, winslash = "/", mustWork = TRUE)
  out_dir <- file.path(OUT_DIR, "H4_models")
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

  data <- prepared$data
  retained <- selection$retained
  exposure_terms <- unname(H4_SPEC$exposure_centered[retained])
  planned_tests <- length(H4_SPEC$all_outcomes) * length(retained)

  result_rows <- list()
  diagnostic_blocks <- c(
    "H4 MODEL RUN",
    paste0("Timestamp: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")),
    paste0("Input: ", input_path),
    paste0("Input MD5: ", unname(tools::md5sum(input_path))),
    paste0("Canonical sensor base: ", BASE_DATA_PATH, "; MD5: ", unname(tools::md5sum(BASE_DATA_PATH))),
    "UTCI QC: UCM processing preserves all finite values in the existing broad plausibility range (-50 to 60 C), including negative and zero values; non-finite and out-of-range values are masked upstream.",
    paste0("Participants (fixed analysis scope): ", paste(H4_SPEC$participants, collapse = ", ")),
    "Cohort note: P4 and P8-P17 are the systematic analysis cohort specified for this study.",
    paste0("Phases: ", paste(H4_SPEC$phases, collapse = ", ")),
    paste0("Participant-phase cells: ", prepared$n_cells, " maximum; expected ", length(H4_SPEC$participants) * length(H4_SPEC$phases)),
    paste0("Outcomes declared: ", length(H4_SPEC$all_outcomes)),
    paste0("VIF threshold: ", H4_SPEC$vif_threshold, "; iteratively remove the current highest-VIF exposure and recalculate."),
    paste0("Retained exposure candidates: ", paste(retained, collapse = ", ")),
    paste0("VIF initial: ", paste(names(selection$initial_vif), sprintf("%.3f", selection$initial_vif), sep = "=", collapse = "; ")),
    paste0("VIF final: ", paste(names(selection$final_vif), sprintf("%.3f", selection$final_vif), sep = "=", collapse = "; ")),
    paste0("Planned BH family: ", planned_tests, " exposure coefficients (all declared outcomes x retained exposures); failed or ineligible tests remain counted in the family size."),
    "Predictors are phase mean minus each participant's mean across the four declared routes; no four-observation within-person SD or lux log transform is used. LYS lux is the declared LYS1/LYS2 arithmetic average, then participant-phase mean.",
    "Coverage: Phase means are computed using available valid matched rows. Coverage is transparently reported. Existing builder QC is respected: dBA < 0 is invalid; frequency-domain HRV requires the 5-minute availability flag; non-positive log-HRV values are missing; eye-tracker rows rely on the upstream valid-gaze-window rule. No arbitrary missingness thresholds are applied.",
    "Questionnaire handling: all four questionnaire variables must have exactly one unique finite response per participant-phase; duplicates are carried forward once, while inconsistent responses stop the run.",
    "Ordinal outcomes: comfort and pleasantness are fit with ordinal::clmm on their original ordered scales. Their diagnostics are convergence/gradient/Hessian/category checks; DHARMa does not list ordinal::clmm as supported, so they remain exploratory and are excluded from BH input pending dedicated goodness-of-fit review.",
    "Continuous mixed-model residual checks: DHARMa simulation-based uniformity, dispersion and outlier checks (250 simulations; fixed seed 20261007). Only continuous fits passing all declared checks enter BH input.",
    "HRV log-transform invalid-value counts (non-positive values are flagged and treated as missing; no replacement):"
  )
  diagnostic_blocks <- c(diagnostic_blocks, capture.output(print(prepared$invalid_hrv, row.names = FALSE)))
  diagnostic_blocks <- c(diagnostic_blocks, "", "VIF trace:", capture.output(print(selection$trace, row.names = FALSE)), "")
  diagnostic_blocks <- c(diagnostic_blocks, "Lowest 20 phase coverage records:", capture.output(print(utils::head(prepared$coverage[order(prepared$coverage$Coverage_pct), ], 20), row.names = FALSE)), "")

  for (outcome in H4_SPEC$all_outcomes) {
    is_ordinal <- FALSE # Modeled continuously via LMM due to sparse categories
    group <- names(H4_SPEC$outcomes)[vapply(H4_SPEC$outcomes, function(x) outcome %in% x, logical(1))][1]
    response <- if (is_ordinal) paste0("Outcome_ORD__", outcome) else paste0("Outcome_GZ__", outcome)
    needed <- c(response, "Mode", "ParticipantID", exposure_terms, "PC_Movement")
    complete <- stats::complete.cases(data[, needed, drop = FALSE])
    fit_data <- data[complete, , drop = FALSE]
    n_obs <- nrow(fit_data)
    n_participants <- length(unique(fit_data$ParticipantID))
    formula_text <- h4_model_formula(outcome, retained, ordinal = is_ordinal)
    model_formula <- stats::as.formula(formula_text)
    predictor_rows <- data.frame(
      Outcome = outcome,
      Outcome_Group = group,
      Model_Type = if (is_ordinal) "Cumulative_Logit_Mixed_Model" else "Gaussian_LMM",
      Transformation = if (is_ordinal) "Original ordered scale" else if (outcome %in% H4_SPEC$hrv_log) "log(phase mean HRV), then pooled z-score" else "Pooled z-score",
      Predictor = retained,
      Estimate = NA_real_,
      StdError = NA_real_,
      Statistic = NA_real_,
      df = NA_real_,
      p_value = NA_real_,
      CI_lower = NA_real_,
      CI_upper = NA_real_,
      Odds_Ratio = NA_real_,
      N_rows = n_obs,
      N_participants = n_participants,
      Missing_outcome_cells = sum(!complete.cases(data[, c(response, "ParticipantID", "PhaseID"), drop = FALSE])),
      Model_Formula = formula_text,
      Model_Status = "NOT_FIT",
      stringsAsFactors = FALSE
    )
    mode_row <- predictor_rows[1, , drop = FALSE]
    mode_row$Predictor <- "ModeWalk"

    if (n_obs <= length(exposure_terms) + 2L || n_participants < 2L) {
      predictor_rows$Model_Status <- mode_row$Model_Status <- "NOT_FIT_INSUFFICIENT_COMPLETE_CASES"
      result_rows[[length(result_rows) + 1L]] <- rbind(predictor_rows, mode_row)
      diagnostic_blocks <- c(diagnostic_blocks, paste0("Outcome: ", outcome), paste0("  Status: ", predictor_rows$Model_Status[1]), paste0("  N rows/participants: ", n_obs, "/", n_participants), "")
      next
    }

    fixed_formula <- stats::reformulate(c("Mode", exposure_terms), response = response)
    design <- stats::model.matrix(fixed_formula, data = fit_data)
    if (qr(design)$rank < ncol(design)) {
      predictor_rows$Model_Status <- mode_row$Model_Status <- "NOT_FIT_RANK_DEFICIENT_FIXED_EFFECTS"
      result_rows[[length(result_rows) + 1L]] <- rbind(predictor_rows, mode_row)
      diagnostic_blocks <- c(diagnostic_blocks, paste0("Outcome: ", outcome), "  Status: rank-deficient fixed-effects design; no coefficient estimates reported.", "")
      next
    }

    fixed_vif <- diag(solve(stats::cor(design[, colnames(design) != "(Intercept)", drop = FALSE])))
    warnings_seen <- character(0)
    messages_seen <- character(0)
    fit_error <- NULL
    model <- tryCatch(
      withCallingHandlers({
        if (is_ordinal) {
          ordinal::clmm(model_formula, data = fit_data, link = "logit", Hess = TRUE, nAGQ = 1L, na.action = stats::na.fail)
        } else {
          lmerTest::lmer(model_formula, data = fit_data, REML = TRUE, na.action = stats::na.fail)
        }
      },
      warning = function(w) warnings_seen <<- c(warnings_seen, conditionMessage(w)),
      message = function(m) messages_seen <<- c(messages_seen, conditionMessage(m))),
      error = function(e) { fit_error <<- conditionMessage(e); NULL }
    )

    if (is.null(model)) {
      predictor_rows$Model_Status <- mode_row$Model_Status <- "FAILED"
      result_rows[[length(result_rows) + 1L]] <- rbind(predictor_rows, mode_row)
      diagnostic_blocks <- c(diagnostic_blocks, paste0("Outcome: ", outcome), paste0("  Formula: ", formula_text), paste0("  Error: ", fit_error), paste0("  Warnings/messages: ", paste(c(warnings_seen, messages_seen), collapse = " | ")), "")
      next
    }

    if (is_ordinal) {
      coefficient_table <- summary(model)$coefficients
      optimizer_code <- model$optRes$convergence
      model_converged <- length(optimizer_code) == 1L && is.finite(optimizer_code) && optimizer_code == 0
      gradient_max <- if (length(model$gradient)) max(abs(model$gradient)) else NA_real_
      hessian_ok <- tryCatch({ chol(model$Hessian); TRUE }, error = function(e) FALSE)
      random_sd <- tryCatch(as.numeric(model$ST[[1]][1, 1]), error = function(e) NA_real_)
      singular <- !is.finite(random_sd) || random_sd <= 1e-6
      statistic_column <- "z value"
      p_column <- "Pr(>|z|)"
      df_column <- NA_character_
      ci_multiplier <- stats::qnorm(0.975)
      ordinal_counts <- table(fit_data[[response]], useNA = "ifany")
      residual_uniformity <- residual_dispersion <- residual_outliers <- NA_real_
      status <- if (!model_converged || !hessian_ok || !is.finite(gradient_max) || gradient_max > 1e-3 || singular || length(warnings_seen)) "UNSTABLE_ORDINAL_FIT" else "FIT_ORDINAL_GOODNESS_OF_FIT_REVIEW_REQUIRED"
    } else {
      coefficient_table <- summary(model)$coefficients
      optimizer_code <- model@optinfo$conv$opt
      model_converged <- is.null(model@optinfo$conv$lme4$messages) && length(optimizer_code) == 1L && is.finite(optimizer_code) && optimizer_code == 0
      gradient <- model@optinfo$derivs$gradient
      gradient_max <- if (length(gradient)) max(abs(gradient)) else NA_real_
      hessian <- model@optinfo$derivs$Hessian
      hessian_ok <- is.matrix(hessian) && all(is.finite(hessian)) &&
        tryCatch({ chol(hessian); TRUE }, error = function(e) FALSE)
      singular <- lme4::isSingular(model, tol = 1e-4)
      random_sd <- tryCatch(sqrt(as.numeric(lme4::VarCorr(model)$ParticipantID[1, 1])), error = function(e) NA_real_)
      statistic_column <- "t value"
      p_column <- "Pr(>|t|)"
      df_column <- "df"
      ci_multiplier <- NA_real_
      residual_uniformity <- residual_dispersion <- residual_outliers <- NA_real_
      diagnostic_error <- NULL
      simulation <- NULL
      tryCatch(
        withCallingHandlers({
          simulation <- DHARMa::simulateResiduals(model, n = 250, plot = FALSE, seed = 20261007)
          residual_uniformity <- DHARMa::testUniformity(simulation, plot = FALSE)$p.value
          residual_dispersion <- DHARMa::testDispersion(simulation, plot = FALSE)$p.value
          residual_outliers <- DHARMa::testOutliers(simulation, plot = FALSE)$p.value
        },
        warning = function(w) warnings_seen <<- c(warnings_seen, paste0("DHARMa: ", conditionMessage(w))),
        message = function(m) messages_seen <<- c(messages_seen, paste0("DHARMa: ", conditionMessage(m)))),
        error = function(e) diagnostic_error <<- conditionMessage(e)
      )
      diagnostic_flag <- !is.null(diagnostic_error) || is.null(simulation) || !hessian_ok || !is.finite(gradient_max) || gradient_max > 1e-3 ||
        any(!is.finite(c(residual_uniformity, residual_dispersion, residual_outliers))) ||
        any(c(residual_uniformity, residual_dispersion, residual_outliers) < 0.05, na.rm = TRUE)
      status <- if (singular || !model_converged || diagnostic_flag || length(warnings_seen)) "UNSTABLE_OR_DIAGNOSTIC_FLAG" else "FIT_DIAGNOSTICS_REVIEW_REQUIRED"
    }

    terms <- c(exposure_terms, grep("^Mode", rownames(coefficient_table), value = TRUE))
    for (term in terms) {
      if (!term %in% rownames(coefficient_table)) next
      estimate <- coefficient_table[term, "Estimate"]
      se <- coefficient_table[term, "Std. Error"]
      statistic <- coefficient_table[term, statistic_column]
      p_value <- coefficient_table[term, p_column]
      df_value <- if (is_ordinal) NA_real_ else coefficient_table[term, df_column]
      multiplier <- if (is_ordinal) ci_multiplier else stats::qt(0.975, df = df_value)
      row <- predictor_rows[1, , drop = FALSE]
      row$Predictor <- if (term %in% exposure_terms) names(H4_SPEC$exposure_centered)[match(term, H4_SPEC$exposure_centered)] else term
      row$Estimate <- estimate
      row$StdError <- se
      row$Statistic <- statistic
      row$df <- df_value
      row$p_value <- p_value
      row$CI_lower <- estimate - multiplier * se
      row$CI_upper <- estimate + multiplier * se
      row$Odds_Ratio <- if (is_ordinal) exp(estimate) else NA_real_
      row$Model_Status <- status
      result_rows[[length(result_rows) + 1L]] <- row
    }

    warning_text <- if (length(warnings_seen)) paste(warnings_seen, collapse = " | ") else "None"
    message_text <- if (length(messages_seen)) paste(messages_seen, collapse = " | ") else "None"
    diagnostic_blocks <- c(
      diagnostic_blocks,
      paste0("Outcome: ", outcome, " (", if (is_ordinal) "ordinal" else "continuous", ")"),
      paste0("  Formula: ", formula_text),
      paste0("  N rows / participants: ", n_obs, " / ", n_participants),
      paste0("  Missing outcome cells: ", sum(!complete)),
      paste0("  Fixed-effect VIF including Mode: ", paste(names(fixed_vif), sprintf("%.3f", fixed_vif), sep = "=", collapse = "; ")),
      paste0("  Converged: ", model_converged),
      paste0("  Maximum absolute gradient: ", ifelse(is.finite(gradient_max), format(gradient_max, digits = 5), "NA")),
      paste0("  Hessian positive definite: ", hessian_ok),
      paste0("  Random-intercept boundary/singularity: ", singular),
      paste0("  Random-intercept SD: ", ifelse(is.finite(random_sd), format(random_sd, digits = 5), "NA")),
      paste0("  DHARMa uniformity / dispersion / outlier p: ", paste(format(c(residual_uniformity, residual_dispersion, residual_outliers), digits = 4), collapse = " / ")),
      if (is_ordinal) paste0("  Ordinal response category counts: ", paste(names(ordinal_counts), ordinal_counts, sep = "=", collapse = "; ")) else character(0),
      if (is_ordinal) "  Ordinal residual GOF: not computed; ordinal::clmm is not listed as a DHARMa-supported model. Treat estimates as exploratory." else character(0),
      paste0("  Status: ", status),
      paste0("  Warnings: ", warning_text),
      paste0("  Messages: ", message_text),
      if (!is_ordinal && !is.null(diagnostic_error)) paste0("  Residual diagnostic error: ", diagnostic_error) else character(0),
      ""
    )
  }

  results <- do.call(rbind, result_rows)
  results$FDR_Eligible <- results$Model_Status == "FIT_DIAGNOSTICS_REVIEW_REQUIRED" &
    results$Predictor %in% names(H4_SPEC$exposure_centered) & is.finite(results$p_value)
  results$FDR_Exclusion_Reason <- ifelse(
    results$FDR_Eligible, "", ifelse(grepl("^FIT_ORDINAL", results$Model_Status), "Ordinal goodness-of-fit criteria incomplete", "Model failed declared fit/diagnostic criteria")
  )
  results$FDR_Exclusion_Reason[results$Predictor == "ModeWalk"] <- "Mode adjustment is outside the declared exposure family"
  results$p_value_FDR <- NA_real_
  exposure_rows <- results$Predictor %in% names(H4_SPEC$exposure_centered) &
    results$FDR_Eligible & is.finite(results$p_value)
  if (any(exposure_rows)) {
    results$p_value_FDR[exposure_rows] <- stats::p.adjust(results$p_value[exposure_rows], method = "BH", n = planned_tests)
  }
  results$Sig_FDR <- !is.na(results$p_value_FDR) & results$p_value_FDR < 0.05
  results$H4_Inference_Status <- ifelse(grepl("^FIT_", results$Model_Status), "EXPLORATORY_REVIEW_REQUIRED", "NOT_REPORTABLE_UNTIL_MODEL_ISSUE_RESOLVED")

  results_path <- file.path(out_dir, "H4_LMM_Results_Table.csv")
  diagnostics_path <- file.path(out_dir, "H4_LMM_Diagnostics.txt")
  write.csv(results, results_path, row.names = FALSE, na = "")
  writeLines(sub("[[:space:]]+$", "", c(diagnostic_blocks, "", paste0("FDR-eligible exposure coefficients: ", sum(exposure_rows), " of planned family size ", planned_tests), paste0("Results CSV: ", results_path))), diagnostics_path)
  cat("H4 model results: ", results_path, "\n", sep = "")
  cat("H4 model diagnostics: ", diagnostics_path, "\n", sep = "")
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

# ------------------------------------------------------------------------------
# 2. Load & Harmonize Data
# ------------------------------------------------------------------------------
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
    keep <- "Excluded"
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
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Declared formulation choice: use the corresponding unsuffixed UCM measure")
  if (grepl("^ucm_IR_", col)) return("Declared exclusion: UCM infrared channels are outside the core exposure set")
  if (grepl("^ucm_WIND_", col) && col != "ucm_WIND_TWS") return("Wind representative: ucm_WIND_TWS; no AWA, AWS or TWD co-entry")
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  if (col %in% c("ucm_AIR_T_bot", "ucm_AIR_T_mid", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_temp; tier channels not co-entered")
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  if (is_svf_exposure(col) && col != "SVF_Holmer") return("Sky openness represented by SVF_Holmer; scene percentages are separate secondary constructs, not equivalent exposures")
  if (col %in% c("ucm_HUMIDEX", "ucm_PET", "ucm_OPT")) return("Composite thermal-stress representative: unsuffixed ucm_UTCI; alternative indices not asserted identical")
  ""
}

classify_step2_consolidation <- function(col, role) {
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
# STEP 3: ANALYST-SELECTED DOMAIN REPRESENTATION (NOT A UNIVERSAL FILTER)
# ==============================================================================
cat("[4/6] Step 3: Recording code-defined domain representation choices...\n")

classify_step3_domain <- function(col, step2_stat) {
  if (step2_stat == "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT", "Preserved for separate frequency analyses; not substituted for the core dBA sound-level representative."))
  if (step2_stat == "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "Preserved for separate sound-type analyses; not substituted for the core dBA sound-level representative."))
  if (is_svf_exposure(col) && step2_stat == "PENDING SVF PROCESSING / MERGE") {
    return(c("Sky View / Urban Morphology", "PLANNED CANDIDATE - PROCESSING PENDING", "Retain in the planned candidate inventory. Reassess eligibility and joint model collinearity after completed SVF runs are merged; current fitted model does not yet contain this variable."))
  }
  if (step2_stat != "Retained") {
    return(c("N/A", "N/A", "N/A"))
  }

  # Determine domain
  if (grepl("temp|humidity|UTCI|PET|MRT|T_(mid|bot|top)|HUMIDEX|OPT|AH|RH|WIND|SUN|IR_|^ucm_fp$|Clearness_Index", col)) {
    dom <- "Thermal"
    if (col == "ucm_UTCI") {
      stat <- "DOMAIN REPRESENTATIVE CANDIDATE"
      rat <- "Outdoor thermal-stress summary integrating air temperature, radiation, humidity and wind (Brode et al., 2012; doi:10.1007/s00484-011-0454-1). Chosen for a reduced construct-level model; does not make its components statistically interchangeable or justify discarding them."
    } else if (col == "Clearness_Index") {
      stat <- "MACRO-CONTEXT CONSTRUCT"
      rat <- "Captures extraterrestrial-to-global solar radiation clearness (Gh/G0); retained for macro-meteorological context."
    } else {
      stat <- "SECONDARY CANDIDATE"
      rat <- "Alternative thermal/radiative/solar measurement retained for diagnostic or separately specified substitution analysis. Current centered correlations must be inspected; neither name nor correlation alone proves equivalence to UTCI. No outcome p-values used for selection (Dormann et al., 2013; doi:10.1111/j.1600-0587.2012.07348.x)."
    }
  } else if (col == "ucm_SND_dBA" || is_sound_semantic(col) || is_acoustic_frequency(col) || grepl("^sound_", col)) {
    dom <- "Acoustic"
    if (col == "ucm_SND_dBA") {
      stat <- "DOMAIN REPRESENTATIVE CANDIDATE"
      rat <- "A-weighted equivalent continuous sound level (LAeq): calibrated physical sound-pressure exposure used as the H4 screening acoustic representative."
    } else if (is_sound_semantic(col)) {
      stat <- "EXPLORATORY SOUNDSCAPE CONSTRUCT"
      rat <- "YAMNet multi-label frame prevalence / mean semantic score: acoustic source composition distinct from sound-pressure intensity; retained for secondary soundscape analyses."
    } else if (is_acoustic_frequency(col)) {
      stat <- "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT"
      rat <- "Native-sample-rate Welch spectral descriptor or relative band-energy measure; retained for secondary frequency-domain acoustic analysis and not substituted for calibrated LAeq."
    } else {
      stat <- "SUBSUMED DOMAIN VARIANT"
      rat <- "Legacy or non-primary acoustic variable; calibrated ucm_SND_dBA remains the H4 screening acoustic exposure."
    }
  } else if (grepl("pm", col)) {
    dom <- "Air Pollution"
    if (col == "atmo_pm2.5_avg") {
      stat <- "DOMAIN REPRESENTATIVE CANDIDATE"
      rat <- "Fine particulate mass concentration chosen for the reduced air-pollution construct. Mean of left/right researcher sensors is a study-specific route proxy, not validated personal exposure or proven removal of body-shielding bias. PM1/PM10 remain alternatives, not equivalent size fractions."
    } else {
      stat <- "SECONDARY CANDIDATE"
      rat <- "Alternative particulate size fraction; PM2.5 is the analyst-selected air-pollution representative for this H4 screening set."
    }
  } else if (grepl("lux|medi|kelvin", col)) {
    dom <- "Visual Light"
    if (col == "lys_lux_avg") {
      stat <- "DOMAIN REPRESENTATIVE CANDIDATE"
      rat <- "Photopic illuminance proxy: declared arithmetic average of LYS1 and LYS2 readings, participant-phase mean, then person-mean centering; no log transformation. The wearers' different sensor positions remain a measurement limitation."
    } else {
      stat <- "SECONDARY CANDIDATE"
      rat <- "Melanopic illuminance or colour temperature is a distinct light construct, not subsumed by photopic lux (CIE S 026/E:2018). Retained for a separately specified light hypothesis; do not label it redundant simply because lux was chosen."
    }
  } else if (is_svf_exposure(col)) {
    dom <- "Sky View / Urban Morphology"
    if (col == "SVF_Holmer") {
      stat <- "EXPLORATORY SVF CONSTRUCT"
      rat <- "Holmer annular sky-view factor from rectified upward fisheye imagery; retained as a secondary urban-morphology / sky-exposure variable and not added to the analyst-selected H4 screening set."
    } else {
      stat <- "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT"
      rat <- "ADE20K scene-composition percentage from the same rectified CamUp image (sky, vegetation, building or wall); retained for secondary SVF/urban-morphology analysis."
    }
  } else if (grepl("gvi|tree|grass|plant", col)) {
    dom <- "Greenery"
    if (col == "gvi_50m") {
      stat <- "DOMAIN REPRESENTATIVE CANDIDATE"
      rat <- "Eye-level Green View Index (GVI_50m): continuous 50m spatial moving-window preserving micro-spatial route variability."
    } else {
      stat <- "SECONDARY CANDIDATE"
      rat <- "Alternative spatial scale or vegetation component retained. At phase-level H4 aggregation the moving-window GVI is itself averaged; the model does not identify instantaneous micro-spatial effects. Avoid co-entering deterministic vegetation totals and all their components."
    }
  } else {
    dom <- "Other Environmental"
    stat <- "SECONDARY CANDIDATE"
    rat <- "General continuous environmental sensor stream."
  }
  return(c(dom, stat, rat))
}

step3_mat <- t(sapply(1:length(all_variables_pool), function(i) {
  classify_step3_domain(all_variables_pool[i], step2_mat[i, 2])
}))

# ==============================================================================
# STEP 4: EXACT MATCHED-DESIGN VIF SCREENING OF CANDIDATE PREDICTORS
# ==============================================================================
cat("[5/6] Step 4: Computing exact matched-design VIF diagnostics...\n")

screening_candidates <- names(H4_SPEC$exposure_centered)
h4_vif_phase <- h4_prepared_for_vif$data
audit_phase_key <- paste(h4_vif_phase$ParticipantID, h4_vif_phase$PhaseID, sep = "::")
df_phase_key <- paste(df$ParticipantID, df$PhaseID, sep = "::")
write.csv(
  h4_prepared_for_vif$coverage,
  file.path(OUT_DIR, "H4_Phase_Coverage.csv"),
  row.names = FALSE,
  na = ""
)
vif_selection <- h4_select_predictors(h4_vif_phase)
vifs_initial_candidates <- vif_selection$initial_vif
h4_retained_candidates <- vif_selection$retained
vifs_retained_candidates <- vif_selection$final_vif



get_exact_vif <- function(col, type = "retained") {
  if (type == "screening" && col %in% names(vifs_initial_candidates)) {
    return(sprintf("%.2f", vifs_initial_candidates[col]))
  }
  if (type == "retained" && col %in% names(vifs_retained_candidates)) {
    return(sprintf("%.2f", vifs_retained_candidates[col]))
  }
  return("-")
}

# Determine final filtration outcome and comprehensive rationale
step1_criterion <- "Role classification: only X_env candidates proceed; metadata, outcomes, QC, and covariates do not enter exposure selection"
step2_criterion <- "Exact replacement mapping; numeric/circular type; observed phase coverage and within-person variation. Auxiliary colour channels require measurement validation"
step3_criterion <- "Construct-prioritised reduced exploratory set, with alternatives retained separately; scientific measurement rationale does not mandate one predictor per domain"
step4_criterion <- paste0("Exposure-only matched-design VIF < ", H4_SPEC$vif_threshold, "; full fixed-effect diagnostics include Mode and PC_Movement; cutoff is not a universal standard")

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

  pre_vif <- get_exact_vif(col, "screening")
  retained_vif <- get_exact_vif(col, "retained")

  step1_decision <- if (step1_stat == "RETAINED FOR FILTRATION") "Retained" else "-"
  step2_decision <- if (step2_stat == "Retained") "Retained" else "-"
  # Alternatives retain their analytical role, not membership in the reduced model.
  step3_decision <- if (step3_stat == "DOMAIN REPRESENTATIVE CANDIDATE") "Retained" else "-"
  step4_decision <- if (col %in% h4_retained_candidates) "Retained" else "-"
  step4_multicollinearity <- if (col %in% screening_candidates) paste0("Exposure-only VIF=", pre_vif, "; threshold <", H4_SPEC$vif_threshold) else "-"
  step1_criterion_row <- paste0(step1_criterion, "; observed role: ", role)
  step2_criterion_row <- paste0(step2_criterion, "; observed rule: ", ifelse(grepl("^N/A", step2_rule), "-", step2_rule), "; status: ", ifelse(step2_stat == "N/A", "-", step2_stat))
  step3_criterion_row <- paste0(step3_criterion, "; observed domain: ", ifelse(dom == "N/A", "-", dom), "; status: ", ifelse(step3_stat == "N/A", "-", step3_stat))

  if (col %in% h4_retained_candidates) {
    final_outcome <- "VIF-RETAINED SCREENING CANDIDATE"
    final_rat <- paste0("Exploratory reduced-set candidate in ", dom, ". Exposure-only VIF = ", retained_vif, " < ", H4_SPEC$vif_threshold, "; outcome-specific full fixed-effect diagnostics must also be reviewed. Passing a chosen cutoff does not establish precise, causal or confirmatory effects.")
  } else if (col %in% setdiff(screening_candidates, h4_retained_candidates)) {
    final_outcome <- "REMOVED BY VIF SCREENING RULE"
    final_rat <- paste0("Domain candidate removed by the outcome-blind configured VIF >= ", H4_SPEC$vif_threshold, " rule (exposure-only matched-design VIF = ", pre_vif, "); retained in the audit.")
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
    Initial_VIF = ifelse(col %in% screening_candidates, pre_vif, "-"),
  Final_VIF = ifelse(col %in% h4_retained_candidates, retained_vif, "-"),
    Step4_Multicollinearity = step4_multicollinearity,
    Step4_Decision = step4_decision,
    Final_Filtration_Outcome = final_outcome,
    Scientific_Filtration_Rationale = final_rat,
    stringsAsFactors = FALSE
  )
}

final_filtration_df <- do.call(rbind, lapply(1:length(all_variables_pool), build_final_row))

# Sort: Screening candidates first, then exploratory/subsumed, then outcomes, then metadata
outcome_order <- c(
  "VIF-RETAINED SCREENING CANDIDATE",
  "REMOVED BY VIF SCREENING RULE",
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
    if (grepl("Physiological", role)) return("Physiological")
    if (grepl("Psychological", role)) return("Psychological")
    if (grepl("Movement", role)) return("Movement")
    if (grepl("QC|Provenance|Signal Quality", role)) return("Metadata")
    return("Metadata")
  }
  if (var == "ucm_SND_dBA" || is_sound_semantic(var) || is_acoustic_frequency(var)) return("Acoustic")
  if (grepl("pm", var, ignore.case = TRUE)) return("Air Pollution")
  if (grepl("lux|medi|kelvin", var, ignore.case = TRUE)) return("Visual Light")
  if (is_svf_exposure(var) || var %in% SVF_QC_COLUMNS) return("Sky View / Urban Morphology")
  if (grepl("gvi|tree|grass|plant", var, ignore.case = TRUE)) return("Greenery")
  if (grepl("temp|UTCI|PET|MRT|T_mid|T_bot|T_top|HUMIDEX|OPT|AH|RH|WIND|SUN|Clearness|IR_", var, ignore.case = TRUE)) return("Thermal")
  "Environmental"
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
  Stage = c(
    "All audited variables",
    "Environmental candidates after role classification",
    "Continuous environmental streams after preprocessing",
    "Analyst-selected H4 screening candidates",
    "Final H4 screening predictors after iterative VIF"
  ),
  Count = c(
    nrow(final_filtration_df),
    sum(final_filtration_df$Step1_Decision == "Retained"),
    sum(final_filtration_df$Step2_Decision == "Retained"),
    length(screening_candidates),
    length(h4_retained_candidates)
  ),
  Criterion = c(
    "Raw canonical columns plus explicit bilateral/route averages",
    "Only environmental exposure candidates proceed to exposure preprocessing",
    "Explicit averages, measurement types and within-person availability; no blanket solar/infrared exclusions",
    "UTCI + calibrated dBA + PM2.5 + Lux + GVI",
    paste0("Outcome-blind exposure VIF rule: < ", H4_SPEC$vif_threshold, "; full fixed-effect diagnostics include covariates")
  ),
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
  "Step 3 - Code-defined scientific-domain representation",
  "Only Step-2 retained environmental streams."
)

# STEP 4: only the five analyst-selected domain representative candidates enter VIF.
step4_df <- final_filtration_df[
  final_filtration_df$H4_Screening_Candidate == "Yes",
  ,
  drop = FALSE
]
step4_counts <- count_stage_categories(
  step4_df,
  "Audit_Domain",
  step4_df$Step4_Decision == "Retained",
    "Step 4 - Candidate-set VIF screening",
  paste0("Reduced UTCI/dBA/PM2.5/logLux/GVI set; exposure-only VIF < ", H4_SPEC$vif_threshold, ". Full-design checks include Mode and PC_Movement.")
)

step_category_counts_df <- rbind(
  step1_counts,
  step2_counts,
  step3_counts,
  step4_counts
)
# write.csv(step_category_counts_df, STEP_CATEGORY_CSV, row.names = FALSE, na = "")

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
  } else if (r$H4_Screening_Candidate == "Yes" && r$Step4_Decision != "Retained") {
    stop_stage[i] <- "Step 4"
    stop_reason[i] <- paste0(
      "Initial matched-design VIF = ", r$Initial_VIF,
      "; configured exposure-only rule requires final VIF < ", H4_SPEC$vif_threshold, "."
    )
      screening_path_status[i] <- "Removed from H4 screening by outcome-blind VIF"
  } else if (r$H4_Screening_Candidate == "Yes" && r$Step4_Decision == "Retained") {
    stop_stage[i] <- "H4 SCREENING"
    stop_reason[i] <- paste0(
      "Retained screening candidate; final VIF = ", r$Final_VIF, "."
    )
      screening_path_status[i] <- "Retained H4 screening candidate"
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
  paste(c(header, sep, rows), collapse = "\\n")
}

stage_totals_report <- data.frame(
  Stage = c("Step 1", "Step 2", "Step 3", "Step 4"),
  Entering = c(
    nrow(final_filtration_df),
    nrow(step2_df),
    nrow(step3_df),
    nrow(step4_df)
  ),
  Retained = c(
    sum(final_filtration_df$Step1_Decision == "Retained"),
    sum(step2_df$Step2_Decision == "Retained"),
    sum(step3_df$Step3_Decision == "Retained"),
    sum(step4_df$Step4_Decision == "Retained")
  ),
  Not_Advanced = c(
    sum(final_filtration_df$Step1_Decision != "Retained"),
    sum(step2_df$Step2_Decision != "Retained"),
    sum(step3_df$Step3_Decision != "Retained"),
    sum(step4_df$Step4_Decision != "Retained")
  ),
  stringsAsFactors = FALSE
)

vif_report_df <- data.frame(
  Domain = step4_df$Audit_Domain,
  Predictor = step4_df$Variable_Name,
  Initial_VIF = step4_df$Initial_VIF,
  Final_VIF = step4_df$Final_VIF,
  Decision = ifelse(
    step4_df$Step4_Decision == "Retained",
    "Retained",
    "Removed"
  ),
  stringsAsFactors = FALSE
)

report_lines <- c(
  "# H4 multivariable transparency report",
  "",
  "Generated directly from the current canonical 8-minute input and active H4 rules.",
  "This script defines and runs the shared H4 audit, VIF selection, outcome models, and diagnostics.",
  "The five domain representatives are analyst-selected; no dated pre-analysis plan supporting prespecification was located.",
  "Single-item comfort and pleasantness responses are ordinal and need outcome-appropriate modeling before inference.",
  "",
  "## Scope",
  paste0("- Participants: ", paste(PARTICIPANTS, collapse = ", ")),
  paste0("- H4 screening phases: ", paste(CORE_PHASES, collapse = ", ")),
  paste0("- Declared outcome family: ", length(H4_SPEC$all_outcomes), " outcomes from the shared fitter specification"),
  "- Continuous outcomes are pooled z-scores; predictors are person-mean centered without dividing by each participant's four-phase SD.",
  "- The systematic analysis cohort specified for this study is P4 and P8-P17.",
  "- UTCI QC: UCM processing retains finite values in the established broad plausibility range (-50 to 60 C), including negative and zero values; non-finite and out-of-range values are masked.",
  paste0("- Phase-level sensor coverage is transparently reported in ", basename(file.path(OUT_DIR, "H4_Phase_Coverage.csv")), "."),
  "- H4 coverage counts use 49 expected matched rows per sensor-derived participant-phase; questionnaire rows use one expected response per participant-phase.",
  paste0("- Input rows after participant restriction: ", nrow(df)),
  paste0("- Core-route 10-s rows: ", nrow(df_core)),
  paste0("- Raw input columns: ", length(raw_cols_all)),
  paste0("- Explicit constructed bilateral/route-average columns: ", length(derived_cols_all)),
  paste0("- Total audited columns: ", nrow(final_filtration_df)),
  "",
  "## Stage totals",
  fmt_md_table(stage_totals_report),
  "",
  "Not advanced means only that the variable does not continue along the H4 screening path. Outcomes, metadata, QC and secondary/exploratory constructs retain their declared roles.",
  "",
  "## Step 1 - role classification",
  "Every audited column receives one analytical role. Only Environmental Stressor Candidates (X_env) advance to Step 2.",
  fmt_md_table(
    step1_counts[, c(
      "Category",
      "Total_Entering_Category",
      "Retained_to_Next_Stage",
      "Not_Advanced_from_Stage"
    )]
  ),
  "",
  "## Step 2 - preprocessing and consolidation",
  "Exactly 12 raw fields map to six averages. Declared representations exclude UCM _S/_SR and IR; use TWS for wind, AIR_RH rather than AH, AIR_temp rather than temperature tiers, GVI50m for vegetation and unsuffixed UTCI for the composite thermal index. dBA represents sound level; frequency and type remain secondary blocks, not equivalent replacements. IO_flag is excluded. SVF represents sky openness and remains planned pending completed merging; it is not physically equivalent to GVI. These are explicit study choices, not universal literature mandates. Eligibility is recalculated from observed coverage at every run.",
  fmt_md_table(
    step2_counts[, c(
      "Category",
      "Total_Entering_Category",
      "Retained_to_Next_Stage",
      "Not_Advanced_from_Stage"
    )]
  ),
  "",
  "## Step 3 - scientific-domain representation",
  "Measurement rationale: UTCI is an outdoor thermal-stress summary (Brode et al., 2012, https://doi.org/10.1007/s00484-011-0454-1). Melanopic and photopic light are distinct constructs (CIE S 026/E:2018, https://cie.co.at/publications/cie-system-metrology-optical-radiation-iprgc-influenced-responses-light-0). Neither source mandates this study's sensor averaging or five-variable shortlist.",
  "Selection rationale: measurement/scientific understanding accompanies collinearity checks (Dormann et al., 2013, https://doi.org/10.1111/j.1600-0587.2012.07348.x). There is no universal one-predictor-per-domain rule. This reduced set is exploratory. The corrected H4_Screening_Literature_Guide.md separates source-supported principles from study choices and retracts unsupported body-shielding/GVI-exclusion claims.",
  "The independently generated temporary preselection audit contains all centered Pearson/Spearman pairs with usable N, sensor-set rank/VIF, candidate additions and cutoff sensitivity. The production analysis has no dependency on that throwaway script. Full fixed-effect VIF including Mode and movement is rechecked on each outcome's fitted rows by h4_run_model(). No outcome models are refitted when H4_PLOT_ONLY=1.",
  "Reduced construct-level exploratory model: UTCI/dBA/PM2.5/logLux/GVI. This is not automatic all-variable VIF selection; no dated prespecification was found. Distinct light/frequency/thermal measures remain alternatives, not assumed duplicates.",
  fmt_md_table(
    step3_counts[, c(
      "Category",
      "Total_Entering_Category",
      "Retained_to_Next_Stage",
      "Not_Advanced_from_Stage"
    )]
  ),
  "",
  "## Step 4 - H4 candidate VIF screen",
  "Only the five analyst-selected domain representative candidates enter VIF. Outcomes and p-values never enter this decision.",
  fmt_md_table(vif_report_df),
  "",
  paste0("VIF rule: exposure-only centered phase design; remove current highest exposure VIF if >= ", H4_SPEC$vif_threshold, ". Full fixed-effect diagnostics include Mode and PC_Movement. Cutoff is not universal (OBrien, 2007; doi:10.1007/s11135-006-9018-6)."),
  "",
  "## Final analytical roles",
  fmt_md_table(final_outcome_counts_df),
  "",
  "## VIF iteration trace",
  fmt_md_table(vif_selection$trace),
  "",
  "## Verification files",
  paste0("- Variable-level audit: ", basename(OUT_CSV)),
  paste0("- Step/category counts: ", basename(STEP_CATEGORY_CSV)),
  paste0("- Domain/status counts: ", basename(DOMAIN_STATUS_CSV)),
  paste0("- Variable stop reasons: ", basename(EXCLUSION_DETAIL_CSV)),
  paste0("- Final outcome counts: ", basename(FINAL_OUTCOME_COUNTS_CSV)),
  "- VIF trace: H4_VIF_Selection_Trace.csv",
  paste0("- All-variable audit table PDF: ", basename(AUDIT_PDF))
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
  render_h4_faceted_flow()
  cat("Selection-only run: refreshed audit and preferred faceted PDF; outcome models not fitted.\n")
  quit(save = "no", status = 0)
}

# ==============================================================================
# STEP 5: SENSOR QUALITY & PLAUSIBILITY AUDIT
# ==============================================================================
cat("[6/6] Auditing sensor plausibility and rendering H4 methodology figure...\n")

qc_specs <- list(
  list(var = "empatica_heart_rate", name = "Heart Rate", unit = "bpm", min = 40.0, max = 190.0),
  list(var = "empatica_skin_temperature", name = "Skin Temperature", unit = "°C", min = 20.0, max = 40.0),
  list(var = "eyetracker_pupil_diameter_avg", name = "Pupil Diameter", unit = "mm", min = 1.5, max = 8.5),
  list(var = "ucm_UTCI", name = "UTCI Thermal Index", unit = "°C", min = -10.0, max = 50.0),
  list(var = "ucm_SND_dBA", name = "Acoustic Sound Level", unit = "dBA", min = 30.0, max = 110.0),
  list(var = "atmo_pm2.5_avg", name = "PM2.5 Air Quality", unit = "µg/m³", min = 0.0, max = 150.0),
  list(var = "lys_lux_avg", name = "Photopic Illuminance", unit = "lux", min = 0.0, max = 120000.0),
  list(var = "gvi_50m", name = "Green View Index", unit = "%", min = 0.0, max = 100.0),
  list(var = "empatica_hrv_td_rmssd", name = "HRV RMSSD", unit = "ms", min = 10.0, max = 550.0),
  list(var = "empatica_eda_tonic", name = "EDA Tonic (SCL)", unit = "µS", min = 0.0, max = 50.0)
)

qc_results <- sapply(qc_specs, function(item) {
  vals <- df_core[[item$var]]
  v_clean <- vals[!is.na(vals)]
  if (length(v_clean) == 0) return(NA_real_)
  out_cnt <- sum(v_clean < item$min | v_clean > item$max)
  round((out_cnt / length(v_clean)) * 100, 2)
})
cat(sprintf(
  "Sensor range QC: maximum out-of-range proportion across audited streams = %.2f%%\n",
  max(qc_results, na.rm = TRUE)
))

# ==============================================================================
# STEP 6: H4 DOMAIN, STAGE, VIF, MODEL, AND ALL-VARIABLE AUDIT FIGURES
# ==============================================================================
clean_pred_labels <- c(
  ucm_UTCI = "UTCI",
  ucm_SND_dBA = "Sound (dBA)",
  atmo_pm2.5_avg = "PM2.5",
  lys_lux_avg = "Mean Lux",
  gvi_50m = "GVI 50 m"
)

# ---- A. Stage-count summary ---------------------------------------------------
stage_plot_df <- rbind(
  data.frame(
    Stage = stage_totals_report$Stage,
    Status = "Retained / advanced",
    Count = stage_totals_report$Retained,
    stringsAsFactors = FALSE
  ),
  data.frame(
    Stage = stage_totals_report$Stage,
    Status = "Not advanced from this stage",
    Count = stage_totals_report$Not_Advanced,
    stringsAsFactors = FALSE
  )
)
stage_plot_df$Stage <- factor(
  stage_plot_df$Stage,
  levels = rev(stage_totals_report$Stage)
)

stage_annotation_df <- stage_totals_report
stage_annotation_df$Stage <- factor(
  stage_annotation_df$Stage,
  levels = rev(stage_totals_report$Stage)
)

p_stage <- ggplot(stage_plot_df, aes(x = Stage, y = Count, fill = Status)) +
  geom_col(width = 0.68) +
  geom_text(
    aes(label = ifelse(Count > 0, Count, "")),
    position = position_stack(vjust = 0.5),
    size = 3.2
  ) +
  geom_text(
    data = stage_annotation_df,
    aes(x = Stage, y = Entering, label = paste0("Entering = ", Entering)),
    inherit.aes = FALSE,
    hjust = -0.08,
    size = 3.0
  ) +
  coord_flip() +
  expand_limits(y = max(stage_totals_report$Entering) * 1.20) +
  labs(
    title = "A. H4 screening-path accounting at every selection stage",
    subtitle = "Every stage reports entering, retained and not-advanced counts. Outcomes/QC/secondary constructs are role-separated, not declared invalid.",
    x = NULL,
    y = "Number of variables",
    fill = NULL
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 8.4, lineheight = 1.04),
    axis.text.y = element_text(size = 8),
    legend.position = "bottom",
    panel.grid.major.y = element_blank()
  )

# ---- B. Environmental-domain separation --------------------------------------
env_domain_df <- final_filtration_df[
  final_filtration_df$Step1_Role == "Environmental Stressor Candidates (X_env)",
  ,
  drop = FALSE
]

status_group <- function(x) {
  if (x == "VIF-RETAINED SCREENING CANDIDATE") return("H4 screening predictor")
  if (grepl("^REMOVED BY VIF", x)) return("Removed by VIF")
  if (grepl("^EXPLORATORY", x) || x == "MACRO-CONTEXT CONSTRUCT") return("Secondary / exploratory")
  if (x == "SUBSUMED WITHIN DOMAIN") return("Subsumed within domain")
  if (grepl("CONSOLIDATED", x)) return("Preprocessing exclusion / consolidation")
  "Other audited environmental stream"
}
env_domain_df$Status_Group <- vapply(env_domain_df$Final_Filtration_Outcome, status_group, character(1))

domain_counts <- aggregate(
  list(Count = rep(1L, nrow(env_domain_df))),
  by = list(Domain = env_domain_df$Audit_Domain, Status = env_domain_df$Status_Group),
  FUN = sum
)

p_domain <- ggplot(domain_counts, aes(x = Domain, y = Count, fill = Status)) +
  geom_col() +
  geom_text(
    aes(label = ifelse(Count > 0, Count, "")),
    position = position_stack(vjust = 0.5),
    size = 3
  ) +
  coord_flip() +
  labs(
    title = "B. Environmental variables separated by scientific domain",
    subtitle = paste0(
      "Analyst-selected domain representatives: ",
      paste(unname(clean_pred_labels[screening_candidates]), collapse = " | "),
      ". Sound composition/frequency and SVF remain secondary/exploratory."
    ),
    x = NULL,
    y = "Number of audited variables",
    fill = "Final analytical role"
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 8.5, lineheight = 1.05),
    legend.position = "bottom",
    panel.grid.major.y = element_blank()
  )

# ---- C. Exact analytical path ------------------------------------------------
flow_df <- data.frame(
  y = 6:1,
  stage = c(
    "Core-route input filtering",
    "Participant-phase aggregation",
    "Exposure transformations and person-mean centering",
    "Five-candidate VIF screen",
    "Outcome-specific mixed models",
    "Diagnostics and BH-FDR"
  ),
  detail = c(
    "11 participants; BikeU, BikeG, WalkU, WalkG; first 8 min; 10-s epochs",
    paste0(
      "Aggregate to participant-phase means; verify one unique questionnaire response; maximum design = ",
      length(PARTICIPANTS) * length(CORE_PHASES), " rows"
    ),
    "Phase mean lux is log10(mean + 1); subtract each participant's four-route mean from each exposure; report valid-row coverage without a missingness cutoff",
    paste0(
      "Analyst-selected domains: Thermal (UTCI), Acoustic (dBA), Air (PM2.5), Light (Lux), Greenery (GVI)\n",
      "VIF uses the exact transformed participant-phase predictor matrix"
    ),
    paste0(
      "Continuous: Outcome_GZ ~ Mode + ",
      paste(unname(H4_SPEC$exposure_centered[h4_retained_candidates]), collapse = " + "),
      " + (1 | ParticipantID)\nOrdinal comfort/pleasantness: cumulative-logit mixed model with the same fixed/random effects"
    ),
    "Continuous LMM residual tests, convergence/singularity/Hessian/warning checks, and BH-FDR over the declared exposure family; ordinal goodness-of-fit review remains separate"
  ),
  stringsAsFactors = FALSE
)

p_flow <- ggplot(flow_df, aes(x = 0.5, y = y)) +
  geom_segment(
    data = data.frame(y = seq(5.65, 1.65, by = -1)),
    aes(x = 0.5, xend = 0.5, y = y + 0.20, yend = y - 0.20),
    inherit.aes = FALSE,
    arrow = grid::arrow(length = grid::unit(0.11, "inches"), type = "closed"),
    linewidth = 0.55
  ) +
  geom_label(
    aes(label = paste0(stage, "\n", detail)),
    size = 3.0,
    lineheight = 1.04,
    linewidth = 0.32,
    label.padding = grid::unit(0.20, "lines"),
    fill = "white"
  ) +
  coord_cartesian(xlim = c(0.08, 0.92), ylim = c(0.5, 6.5), clip = "off") +
  labs(
    title = "C. H4 screening pathway",
    subtitle = "This outcome-blind screen checks exposure collinearity prior to model fitting; outcome coefficients, p-values, and effect sizes are generated subsequently."
  ) +
  theme_void(base_size = 10.5) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 8.8, margin = margin(b = 7))
  )

# ---- D. Initial and final VIF values ------------------------------------------
removed_trace <- vif_selection$trace$Removed[nzchar(vif_selection$trace$Removed)]
removal_statement <- if (length(removed_trace)) {
  paste0(
    "Iterative removal order: ",
    paste(unname(clean_pred_labels[removed_trace]), collapse = " → "),
    ". VIF is recalculated after each removal."
  )
} else {
  paste0("No exposure required removal; all exposure-only VIFs were < ", H4_SPEC$vif_threshold, ".")
}

vif_initial_df <- data.frame(
  Predictor = unname(clean_pred_labels[screening_candidates]),
  Stage = "Initial 5-candidate set",
  VIF = as.numeric(vifs_initial_candidates[screening_candidates]),
  stringsAsFactors = FALSE
)
vif_final_df <- data.frame(
  Predictor = unname(clean_pred_labels[h4_retained_candidates]),
  Stage = "Final retained set",
  VIF = as.numeric(vifs_retained_candidates[h4_retained_candidates]),
  stringsAsFactors = FALSE
)
vif_plot <- rbind(vif_initial_df, vif_final_df)
vif_plot$Predictor <- factor(
  vif_plot$Predictor,
  levels = rev(unname(clean_pred_labels[screening_candidates]))
)

p_vif <- ggplot(vif_plot, aes(x = Predictor, y = VIF, fill = Stage)) +
  geom_col(position = position_dodge(width = 0.72), width = 0.64) +
  geom_hline(yintercept = H4_SPEC$vif_threshold, linetype = "dashed", linewidth = 0.7) +
  geom_text(
    aes(label = sprintf("%.2f", VIF)),
    position = position_dodge(width = 0.72),
    hjust = -0.10,
    size = 3.0
  ) +
  coord_flip() +
  expand_limits(y = max(H4_SPEC$vif_threshold * 1.1, max(vif_plot$VIF, na.rm = TRUE) * 1.18)) +
  labs(
    title = "D. Exact matched-design VIF values",
    subtitle = paste0(
      "Exposure-only initial/final values. Configured VIF cutoff: ", H4_SPEC$vif_threshold, ". ",
      removal_statement
    ),
    x = NULL,
    y = "Variance inflation factor",
    fill = NULL
  ) +
  theme_minimal(base_size = 10) +
  theme(
    plot.title = element_text(face = "bold", size = 12),
    plot.subtitle = element_text(size = 8.5, lineheight = 1.05),
    legend.position = "bottom",
    panel.grid.major.y = element_blank()
  )

# ---- E. Candidate model specification ------------------------------------------
final_vif_text <- paste(
  paste0(unname(clean_pred_labels[names(vifs_retained_candidates)]), "=", sprintf("%.2f", as.numeric(vifs_retained_candidates))),
  collapse = "; "
)
removed_set <- setdiff(screening_candidates, h4_retained_candidates)
removed_text <- if (length(removed_set)) paste(unname(clean_pred_labels[removed_set]), collapse = ", ") else "None"

H4_FORMULA <- paste0(
  "Outcome_GZ ~ Mode + PC_Movement + ",
  paste(unname(H4_SPEC$exposure_centered[h4_retained_candidates]), collapse = " + "),
  " + (1 | ParticipantID)"
)
H4_ORDINAL_FORMULA <- sub("Outcome_GZ", "Outcome_ORD", H4_FORMULA)

model_text <- paste0(
  "SHARED H4 MODEL SPECIFICATION (THIS SCRIPT)\n\n",
  "Continuous outcome formula:\n  ", H4_FORMULA, "\n\n",
  "Ordinal comfort/pleasantness formula:\n  ", H4_ORDINAL_FORMULA, "\n\n",
  "Continuous outcomes: phase-level values pooled-z standardized; seven HRV measures are log-transformed first. Predictors are person-mean centered across the four declared routes, without within-person SD scaling. Lux uses the arithmetic sensor average and phase mean without a log transform. Questionnaire values require exactly one unique response per participant-phase. Sensor phase means use available valid rows; coverage is reported without an exclusion cutoff.\n\n",
  "Fixed effects:\n  Mode + PC_Movement + ",
  paste(unname(clean_pred_labels[h4_retained_candidates]), collapse = " + "),
  "\n\nRandom effect:\n  (1 | ParticipantID)",
  "\n\nEstimators:\n  Gaussian LMM by REML for continuous outcomes; cumulative-logit mixed model for the two single-item ordinal outcomes.",
  "\n\nOutcome-model status:\n  This script fits the declared outcomes. DHARMa residual checks apply to Gaussian LMMs; ordinal fits require separate goodness-of-fit review.",
  "\n\nSelection rule:\n  Exposure-only VIF cutoff ", H4_SPEC$vif_threshold, "; remove current highest exposure VIF at/above cutoff. Full-design diagnostics include Mode and PC_Movement. Cutoff is study-specific, not proof of separable causal effects.",
  "\n\nFinal VIFs:\n  ", final_vif_text,
  "\n\nRemoved by VIF:\n  ", removed_text
)

p_model <- ggplot() +
  annotate(
    "label", x = 0, y = 1, label = model_text,
    hjust = 0, vjust = 1, size = 3.15, lineheight = 1.04,
    linewidth = 0.32, label.padding = grid::unit(0.24, "lines")
  ) +
  xlim(0, 1) + ylim(0, 1) +
  labs(title = "E. Shared model forms (fitted by the authoritative script)") +
  theme_void(base_size = 10) +
  theme(plot.title = element_text(face = "bold", size = 12))

# ---- F. Secondary domains + current integration readiness ---------------------
integration_lines <- paste0(
  integration_df$Family, ": ", integration_df$Present_N, "/", integration_df$Expected_N,
  " present (", integration_df$Status, ")",
  collapse = "\\n"
)

secondary_text <- paste0(
  "SECONDARY / EXPLORATORY H4 CONSTRUCTS\n\n",
  "Acoustic source composition: eight category frame proportions (when merged); removed class-level outputs are not required\n",
  "Acoustic spectrum: dominant / centroid / roll-off + broad/octave relative energy\n",
  "Urban morphology: SVF_Holmer + sky / vegetation / building / wall proportions\n",
  "Potential interactions require a separate, documented rationale\n\n",
  "CURRENT CANONICAL INPUT READINESS\n",
  integration_lines,
  "\n\nThese constructs are audited separately and are not silently inserted into the analyst-selected five-domain screening set."
)

p_secondary <- ggplot() +
  annotate(
    "label", x = 0, y = 1, label = secondary_text,
    hjust = 0, vjust = 1, size = 3.0, lineheight = 1.03,
    linewidth = 0.32, label.padding = grid::unit(0.24, "lines")
  ) +
  xlim(0, 1) + ylim(0, 1) +
  labs(title = "F. Secondary domains and integration readiness") +
  theme_void(base_size = 10) +
  theme(plot.title = element_text(face = "bold", size = 12))

# ---- Main methodology figure --------------------------------------------------
png(FIGURE_PNG, width = 4200, height = 3300, res = 300)
grid::grid.newpage()
figure_grob <- gridExtra::arrangeGrob(
  p_stage, p_domain, p_flow, p_vif, p_model, p_secondary,
  layout_matrix = rbind(
    c(1, 2),
    c(3, 4),
    c(3, 5),
    c(3, 6)
  ),
  widths = c(1.20, 1.0),
  heights = c(0.90, 1.0, 1.0, 1.0),
  top = grid::textGrob(
    "H4 exploratory exposure screening: variable domains and candidate formula",
    gp = grid::gpar(fontsize = 17, fontface = "bold")
  ),
  bottom = grid::textGrob(
    "The five analyst-selected environmental domains receive an outcome-blind VIF screen. This script fits all declared outcomes; results require outcome-specific diagnostic review before interpretation.",
    gp = grid::gpar(fontsize = 9)
  )
)
grid::grid.draw(figure_grob)
dev.off()

# ---- Standalone domain + integration figure ----------------------------------
integration_plot_df <- integration_df
integration_plot_df$Family <- factor(integration_plot_df$Family, levels = rev(integration_plot_df$Family))
p_integration <- ggplot(integration_plot_df, aes(x = Family)) +
  geom_col(aes(y = Expected_N), width = 0.68) +
  geom_point(aes(y = Present_N), size = 3) +
  geom_text(aes(y = Expected_N, label = paste0(Present_N, "/", Expected_N)), hjust = -0.15, size = 3.2) +
  coord_flip() +
  expand_limits(y = max(integration_plot_df$Expected_N) * 1.22) +
  labs(
    title = "Sound/SVF integration readiness",
    subtitle = "Bars = expected canonical analysis columns; points = columns currently present in the merged 8-minute input.",
    x = NULL,
    y = "Columns"
  ) +
  theme_minimal(base_size = 10) +
  theme(panel.grid.major.y = element_blank())

ggsave(
  DOMAIN_PNG,
  gridExtra::arrangeGrob(p_domain, p_integration, ncol = 1, heights = c(1.5, 1.0)),
  width = 15,
  height = 12,
  dpi = 300
)

# ---- All-variable audit table -------------------------------------------------
audit_page_count <- render_audit_pdf(final_filtration_df, AUDIT_PDF, AUDIT_PNG)

cat(sprintf("SUCCESS: Rendered H4 methodology figure to:\n  %s\n", FIGURE_PNG))
cat(sprintf("SUCCESS: Rendered domain audit figure to:\n  %s\n", DOMAIN_PNG))
cat(sprintf("SUCCESS: Rendered all-variable audit table (%d pages):\n  %s\n  %s\n", audit_page_count, AUDIT_PNG, AUDIT_PDF))

cat("\n==============================================================================\n")
cat("SUMMARY OF RESULTS:\n")
cat(sprintf("  - Total variables audited in master CSV: %d\n", nrow(final_filtration_df)))
cat(sprintf("  - VIF-retained screening candidates selected    : %d (%s)\n", length(h4_retained_candidates), paste(h4_retained_candidates, collapse = ", ")))
removed_candidates_by_vif <- setdiff(screening_candidates, h4_retained_candidates)
cat(sprintf(
  "  - Analyst-selected candidate(s) removed by VIF: %s\n",
  if (length(removed_candidates_by_vif)) paste(removed_candidates_by_vif, collapse = ", ") else "none"
))
cat(sprintf("  - Full variable audit CSV              : %s\n", OUT_CSV))
cat(sprintf("  - Human-readable transparency report   : %s\n", TRANSPARENCY_MD))
cat(sprintf("  - Methodology figure                   : %s\n", FIGURE_PNG))
cat(sprintf("  - Domain audit figure                  : %s\n", DOMAIN_PNG))
cat(sprintf("  - All-variable audit table preview     : %s\n", AUDIT_PNG))
cat(sprintf("  - All-variable audit table PDF (%d pages): %s\n", audit_page_count, AUDIT_PDF))
writeLines(
  c(
    "Shared H4 model specification and fit (implemented only in scripts/H4_multivariate.R)",
    H4_FORMULA,
    H4_ORDINAL_FORMULA,
    "",
    "Continuous outcomes use pooled z-scores after seven HRV log transforms; ordinal items retain their verified unique participant-phase response. Predictors are person-mean centered across the four outdoor phases.",
    "Comfort and pleasantness use cumulative-logit mixed models on ordered response scales.",
    "This script runs the audit and fits the declared outcome models using the same prepared participant-phase data and VIF decision.",
    "The five screening candidates are analyst-selected; treat all results as exploratory."
  ),
  FORMULA_TXT
)
cat(sprintf("  - H4 multivariate formula              : %s\n", FORMULA_TXT))
cat(sprintf("  - Participant-phase coverage           : %s\n", file.path(OUT_DIR, "H4_Phase_Coverage.csv")))

if (requireNamespace("GGally", quietly = TRUE)) {
  plot_df <- h4_prepared_for_vif$data[, c("PhaseID", unname(H4_SPEC$exposure_centered))]
  plot_df$Environment <- ifelse(grepl("U$", plot_df$PhaseID), "Urban", "Green")
  
  p_parallel <- GGally::ggparcoord(
    plot_df, 
    columns = 2:6, 
    groupColumn = 7, 
    scale = "uniminmax", 
    showPoints = TRUE,
    alphaLines = 0.6,
    mapping = ggplot2::aes(size = 1.0)
  ) + 
    ggplot2::scale_color_manual(values = c("Urban" = "#ffbb00", "Green" = "#27ae60")) +
    ggplot2::scale_size_identity() +
    ggplot2::theme_minimal(base_size = 12) +
    ggplot2::labs(
      title = "H4 Predictor Collinearity (Parallel Coordinates)",
      subtitle = paste0("44 repeated participant-phase cells; centered predictors scaled for display only.\nGVI is retained at the exposure VIF cutoff ", H4_SPEC$vif_threshold, "; shared route patterns still limit attribution."),
      x = "Final 5 Environmental Domain Candidates",
      y = "Scaled Person-Mean Centered Value [0, 1]"
    ) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(face = "bold"),
      legend.position = "bottom",
      legend.title = ggplot2::element_blank()
    )
  
  parallel_path <- file.path(OUT_DIR, "H4_Predictor_Collinearity.png")
  ggplot2::ggsave(parallel_path, p_parallel, width = 9, height = 6, dpi = 300)
  cat(sprintf("  - Parallel coordinates plot            : %s\n", parallel_path))
}

cat("==============================================================================\n")

if (identical(Sys.getenv("H4_PLOT_ONLY"), "1")) {
  cat("H4_PLOT_ONLY=1 set. Exiting before running LMMs.\n")
  quit(save = "no", status = 0)
}

h4_run_model(
  input_path = RAW_DATA_PATH,
  prepared = h4_prepared_for_vif,
  selection = vif_selection
)


# ============================================================================== 
# PART 2: COMPANION DOMAIN JUSTIFICATION TABLE 
# ============================================================================== 

library(ggplot2)
library(gridExtra)

df <- read.csv("output/merged_all_11participants_8min.csv", stringsAsFactors = FALSE)

valid_participants <- c("P4", paste0("P", 8:17))
valid_phases <- c("BikeU", "WalkU", "BikeG", "WalkG")
df_core <- df[df$ParticipantID %in% valid_participants & df$PhaseID %in% valid_phases, ]

audit_phase_key <- paste(df_core$ParticipantID, df_core$PhaseID, sep = "::")

# Lys avg
df_core$lys_lux_avg <- rowMeans(df_core[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
# PM avg
df_core$atmo_pm2.5_avg <- rowMeans(df_core[, c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5")], na.rm = TRUE)
df_core$atmo_pm10_avg <- rowMeans(df_core[, c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10")], na.rm = TRUE)

skewness <- function(x) {
  x <- x[!is.na(x)]
  if(length(x) < 3) return(NA)
  m3 <- sum((x - mean(x))^3) / length(x)
  s3 <- sqrt(var(x))^3
  return(m3 / s3)
}

candidates <- list(
  list(Domain = "Thermal", Variable = "ucm_UTCI", Name = "UTCI (Bio-meteorological Index)", Selected = "Yes",
       Rationale = "Synthesizes air temp, radiation (MRT), humidity, and wind into a single validated physiological equivalent temperature. Superior to single-parameter measures."),
  list(Domain = "Thermal", Variable = "ucm_AirTemperature", Name = "Air Temperature (Ta)", Selected = "No",
       Rationale = "Subsumed. Ignores solar radiation and wind speed, which drive outdoor thermal comfort."),
  list(Domain = "Thermal", Variable = "ucm_RelativeHumidity", Name = "Relative Humidity (RH)", Selected = "No",
       Rationale = "Subsumed by UTCI integration."),
  
  list(Domain = "Acoustic", Variable = "ucm_SND_dBA", Name = "A-weighted Decibels (dBA)", Selected = "Yes",
       Rationale = "A-weighting curve maps exactly to human auditory perception thresholds. Broad-spectrum metric avoids overfitting to specific narrow frequencies."),
  list(Domain = "Acoustic", Variable = "yamnet_class_000_speech_mean_score", Name = "Speech Probability (YAMNet)", Selected = "No",
       Rationale = "Secondary micro-context feature. Does not capture total acoustic sound pressure level."),
  list(Domain = "Acoustic", Variable = "spectral_centroid_hz", Name = "Spectral Centroid (Hz)", Selected = "No",
       Rationale = "Describes pitch center but not overall loudness/stressor magnitude."),

  list(Domain = "Visual Light", Variable = "lys_lux_avg", Name = "Mean LYS Lux", Selected = "Yes",
       Rationale = "Declared arithmetic average of LYS1 and LYS2 lux readings. No log transform is applied."),
  list(Domain = "Visual Light", Variable = "atmo_lys_LYS1__lys_lux", Name = "Single-Sensor Lux (LYS1)", Selected = "No",
       Rationale = "Highly susceptible to body-shielding shadows depending on pedestrian orientation to sun."),

  list(Domain = "Air Pollution", Variable = "atmo_pm2.5_avg", Name = "Bilateral PM2.5 Avg", Selected = "Yes",
       Rationale = "Established EPA/WHO epidemiological standard for fine particulate health impact. Bilateral average neutralizes spatial bias."),
  list(Domain = "Air Pollution", Variable = "atmo_pm10_avg", Name = "Bilateral PM10 Avg", Selected = "No",
       Rationale = "Highly collinear with PM2.5 in this dataset; PM2.5 prioritized theoretically for deeper respiratory/vascular penetration."),
  list(Domain = "Air Pollution", Variable = "atmo_lys_atmotube_left__atmotube_pm2.5", Name = "Left-Sensor PM2.5", Selected = "No",
       Rationale = "Single-side measurement is vulnerable to exhaust plume directionality."),

  list(Domain = "Greenery", Variable = "gvi_50m", Name = "Green View Index (50m)", Selected = "Yes",
       Rationale = "Represents true human eye-level visible greenery morphology. (Ultimately removed at Step 4 due to high VIF collinearity)."),
  list(Domain = "Greenery", Variable = "Tree_%", Name = "Tree Cover % (Semantic)", Selected = "No",
       Rationale = "Subsumed by overall GVI. Ignores grass/shrub layers."),
  list(Domain = "Greenery", Variable = "Grass_%", Name = "Grass Cover % (Semantic)", Selected = "No",
       Rationale = "Subsumed by overall GVI.")
)

results <- data.frame()
for (c in candidates) {
  var <- c$Variable
  
  if (var %in% names(df_core)) {
    val <- as.numeric(df_core[[var]])
    val_clean <- val[!is.na(val) & is.finite(val)]
    
    n_valid <- length(val_clean)
    mean_v <- mean(val_clean)
    sd_v <- sd(val_clean)
    skew_v <- skewness(val_clean)
  } else {
    n_valid <- NA
    mean_v <- NA; sd_v <- NA; skew_v <- NA
  }
  
  row_df <- data.frame(
    Category = c$Domain,
    Variable = c$Name,
    Selected = c$Selected,
    `N(10s)` = n_valid,
    Mean = ifelse(!is.na(mean_v), sprintf("%.2f", mean_v), "NA"),
    SD = ifelse(!is.na(sd_v), sprintf("%.2f", sd_v), "NA"),
    Skewness = ifelse(!is.na(skew_v), sprintf("%.2f", skew_v), "NA"),
    Rationale = c$Rationale,
    stringsAsFactors = FALSE, check.names = FALSE
  )
  results <- rbind(results, row_df)
}

write.csv(results, "output/statistical_analysis/H4_multivariate/H4_Domain_Representative_Justification.csv", row.names = FALSE)

wrap_col <- function(col, w) {
  vapply(col, function(s) paste(strwrap(as.character(s), width = w), collapse = "\n"), character(1))
}

results_pdf <- results
results_pdf$Category <- wrap_col(results_pdf$Category, 12)
results_pdf$Variable <- wrap_col(results_pdf$Variable, 20)
results_pdf$Rationale <- wrap_col(results_pdf$Rationale, 45)

tt <- ttheme_minimal(
  core = list(
    fg_params = list(cex = 0.8, hjust = 0, x = 0.02),
    bg_params = list(fill = c("#f9f9f9", "#ffffff"))
  ),
  colhead = list(
    fg_params = list(cex = 0.9, fontface = "bold", hjust = 0, x = 0.02),
    bg_params = list(fill = "#e0e0e0")
  )
)

pdf_grob <- tableGrob(results_pdf, rows = NULL, theme = tt)
pdf_grob$widths <- unit(c(1.1, 2.0, 0.7, 0.6, 0.7, 0.7, 0.8, 4.5), "in")

title_grob <- grid::textGrob(
  "H4 Domain Representative Justification & Statistical Profiles", 
  gp = grid::gpar(fontsize = 16, fontface = "bold")
)

final_grob <- gridExtra::arrangeGrob(
  title_grob, 
  pdf_grob, 
  ncol = 1, 
  heights = unit(c(0.5, 8), c("in", "in"))
)

ggsave("output/statistical_analysis/H4_multivariate/H4_Domain_Representative_Justification.pdf", final_grob, width = 14, height = 8.5)

cat("Successfully generated H4_Domain_Representative_Justification.csv and PDF.\n")


# ============================================================================== 
# PART 3: FACETED VERTICAL FLOW VISUALIZATION 
# ============================================================================== 

render_h4_faceted_flow()
