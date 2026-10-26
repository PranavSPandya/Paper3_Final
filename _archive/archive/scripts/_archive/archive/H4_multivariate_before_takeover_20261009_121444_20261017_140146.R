# H4 variable audit and participant-held-out LASSO candidate screening.
# Model fitting: scripts/h4_step5_equations.R. Steps 1-3 are measurement audits.
if (identical(Sys.getenv("H4_STEP6_PRIMARY"), "1")) stop("The post-hoc UTCI reporting mode is retired; inspect the current Step 5 report.")
suppressPackageStartupMessages({
    library(ggplot2)
    library(gridExtra)
})
resolve_project_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  candidates <- c(if(length(arg)) file.path(dirname(sub("^--file=", "", arg[1])), ".."), getwd(), file.path(getwd(), ".."))
  for(root in unique(candidates)) {
    root <- normalizePath(root, winslash = "/", mustWork = FALSE)
    if(file.exists(file.path(root, "output/merged_all_11participants_8min.csv"))) return(root)
  }
  stop("Cannot find output/merged_all_11participants_8min.csv; run from the repository or scripts folder.")
}
required_packages <- c("ggplot2", "gridExtra")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
grDevices::pdf(file = NULL)
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- file.path(PROJECT_ROOT, "output/merged_all_11participants_8min.csv")
OUT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/H4_multivariate")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
h4_step5_fitted_equations <- function(audit = read.csv(OUT_CSV, check.names = FALSE)) {
    audit <- h4_sensor_union(audit)
    v <- audit$Variable_Name[audit$Step4_Union_Decision == "Retained"]
    stopifnot(length(v) > 0L, !anyDuplicated(v), !any(grepl("^(empatica|eyetracker|questionnaire)_", v)))
    c(paste("Equation 1 (no products): within-person-selected non-thermal covariates + pre-specified PM1 + air temperature + humidity + mean radiant temperature + activity."),
        "Interaction equation: equation 1 plus air temperature, humidity, and mean radiant temperature each times sound and each times activity.",
        "Coefficients are per full-sample within-person SD of the centered predictor. Activity is Bike +0.5 / Walk -0.5 and is not a LASSO product.",
        "Current results: output/statistical_analysis/H4_multivariate/H4_models. H4_Step5_Equations_Checks.txt is historical.")
}
OUT_CSV <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
AUDIT_PNG <- file.path(OUT_DIR, "H4_All_Variables_Audit.png")
AUDIT_PDF <- file.path(OUT_DIR, "H4_All_Variables_Audit.pdf")
STAGE_SUMMARY_CSV <- file.path(OUT_DIR, "H4_Audit_Stage_Summary.csv")
INTEGRATION_CSV <- file.path(OUT_DIR, "H4_Integration_Readiness.csv")
STEP_CATEGORY_CSV <- file.path(OUT_DIR, "H4_Step_Category_Counts.csv")
FINAL_OUTCOME_COUNTS_CSV <- file.path(OUT_DIR, "H4_Final_Outcome_Counts.csv")
TRANSPARENCY_MD <- file.path(OUT_DIR, "H4_Transparency_Report.md")
FORMULA_TXT <- file.path(OUT_DIR, "H4_Multivariate_Formula.txt")
h4_lasso_domains <- list(Acoustic = "ucm_SND_dBA", Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_TWS"), Index = c("ucm_HUMIDEX",
    "ucm_PET", "ucm_UTCI", "ucm_OPT"), Radiation = c("ucm_MRT", "ucm_SUN_Gh", "Clearness_Index", "Clearness_Index_G0", "SVF_Holmer"),
    Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"), Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
    Greenery = "gvi_50m", Unverified = "ucm_fp")
h4_sensor_union <- function(audit) {
    selected <- audit$Step4_Empatica_Decision == "Retained" | audit$Step4_Eyetracker_Decision == "Retained"
    stopifnot(!anyNA(selected))
    audit$Step4_Union_Decision <- ifelse(selected, "Retained", "Not selected")
    audit$Step4_Decision <- audit$Step4_Union_Decision
    audit$Step4_Status <- "Union of separate Empatica and eye-tracker selections; not pooled-response LASSO or final model"
    stopifnot(setequal(audit$Variable_Name[selected], union(audit$Variable_Name[audit$Step4_Empatica_Decision == "Retained"],
        audit$Variable_Name[audit$Step4_Eyetracker_Decision == "Retained"])))
    audit
}
render_h4_faceted_flow <- function(step5 = NULL) {
  library(grid)
  PDF_PATH <- file.path(OUT_DIR, "H4_Faceted_Vertical_Flow_final.pdf")
  AUDIT_PATH <- file.path(OUT_DIR, "H4_Multivariate_Filtration_Results.csv")
  audit_all <- h4_sensor_union(read.csv(AUDIT_PATH, stringsAsFactors = FALSE))
  audit <- audit_all
  stopifnot(!anyDuplicated(audit$Variable_Name))
  stopifnot(all(c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg") %in% audit$Variable_Name))
  sensor <- audit$Platform_Source
  sensor[grepl("^atmo_lys_atmotube_(left|right)__", audit$Variable_Name)] <- "Atmo raw"
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
  titles <- c(
    paste0("STEP 1\nInventory (", nrow(audit), ")"),
    paste0("STEP 2\nRepresentatives (", nrow(step2), ")\nRules + coverage"),
    paste0("STEP 3\nDomain Grouping (", nrow(stages[[3]]), ")"),
    "STEP 4\nWithin-person\ndomain-wise LASSO\nMinimum CV MSE"
  )
  max_rows <- vapply(stages, function(d) as.integer(max(c(1L, d$Row + 1L))), integer(1))
  band_height <- 66 + max_rows * 23
  band_height[2] <- max(band_height[2], 66 + 14 * 23)
  band_height[3] <- 520
  band_height[4] <- 520
  step5_height <- 640
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
  text_at(.12 / page_width, 1 - 55 / page_height, "Step 4: domain-wise LASSO. Participant-mean centering, then training-fold z-scores of those centered predictors. Union of two screens. Not one ranking across domains.", 18)
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
  top <- step5_height - 18
  grid.text("STEP 5\nWithin-person\nterm grid", x = .12 / page_width, y = top / page_height,
    just = c("left", "top"), gp = gpar(fontsize = 16, fontface = "bold"))
  x0 <- 2.82 / page_width
  eq_path <- file.path(OUT_DIR, "H4_models", "H4_equations.csv")
  lines <- if (file.exists(eq_path)) {
    eq <- read.csv(eq_path, stringsAsFactors = FALSE, check.names = FALSE)
    keep <- if ("fitted" %in% names(eq)) eq$fitted %in% c(TRUE, "TRUE", "true", "1") else rep(FALSE, nrow(eq))
    fitted_eq <- eq[keep, , drop = FALSE]
    if (!nrow(fitted_eq)) {
      "No equation is marked fitted in H4_equations.csv."
    } else {
      unlist(lapply(seq_len(nrow(fitted_eq)), function(i) {
        label <- if (fitted_eq$block[i] == "no_products") "Equation 1, no products" else "Interaction equation, thermal x sound and thermal x activity"
        c(paste0(label, " (id ", fitted_eq$equation_id[i], ", ", fitted_eq$heat_form[i], "):"), strwrap(fitted_eq$terms[i], width = 110))
      }), use.names = FALSE)
    }
  } else {
    "Fitted term lists are written to H4_models/H4_equations.csv."
  }
  y <- top - 22
  for (label in lines) {
    y <- y - 28
    text_at(x0, y / page_height, label, 14)
  }
  dev.off()
  cat("Verified stage counts:", paste(vapply(stages, nrow, integer(1)), collapse = " -> "), ". Fixed horizontal positions; zero connectors.\n")
  cat("Saved figure (1 page):", PDF_PATH, "\n")
}
render_audit_pdf <- function(audit_df, output_path, preview_path = NULL) {
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
    is_environment <- audit_df$Step1_Role == "Environmental Stressor Candidates (X_env)"
    is_physio <- grepl("Physiological Sensor Outcomes", audit_df$Step1_Role)
    is_psych <- grepl("Psychological Survey Outcomes", audit_df$Step1_Role)
    is_outcome <- is_physio | is_psych
    is_metadata_qc <- grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit_df$Step1_Role) | audit_df$Final_Filtration_Outcome ==
        "QC METRIC"
    is_movement <- grepl("Movement", audit_df$Step1_Role)
    role <- ifelse(is_environment, "Environmental Candidate (X)", ifelse(is_physio, "Outcome Y - Physiological", ifelse(is_psych,
        "Outcome Y - Psychological", ifelse(is_movement, "Movement Covariate (Z)", ifelse(is_metadata_qc, "Metadata / QC - Not Candidate",
            "Outside Declared H4 Set")))))
    step2 <- ifelse(is_environment & audit_df$Step2_Status != "-", ifelse(audit_df$Step2_Decision == "Retained", "Eligible",
        "Not advanced"), ifelse(is_outcome, "Analyzed as outcome Y", ifelse(is_movement, "Exertion covariate proxy", ifelse(is_metadata_qc,
        "-", "-"))))
    candidate <- audit_df$H4_Screening_Candidate == "Yes"
    step3 <- ifelse(candidate, paste(audit_df$Measurement_Code, audit_df$Measurement_Type), "-")
    final_role <- ifelse(candidate, "Candidate; model specification pending", ifelse(is_physio, "Physiological outcome",
        ifelse(is_psych, "Psychological outcome", ifelse(is_movement, "Movement covariate", audit_df$Final_Filtration_Outcome))))
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
    table_df <- data.frame(`Sr. No.` = integer(nrow(audit_df)), `Data Source (Sensor)` = clean_source, Variable = audit_df$Variable_Name,
        `Step 1: Role` = role, `Step 2: Preprocessing` = step2, `Step 3: Measurement provenance` = step3, `Final role` = final_role,
        check.names = FALSE, stringsAsFactors = FALSE)
    role_priority <- ifelse(grepl("Outcome", table_df$`Step 1: Role`), "01", ifelse(grepl("Primary Predictor", table_df$`Final role`),
        "02", ifelse(grepl("Environmental Candidate", table_df$`Step 1: Role`), "03", ifelse(grepl("Covariate", table_df$`Step 1: Role`),
            "04", "05"))))
    order_key <- paste0(role_priority, "_", table_df[[2]], "_", table_df$Variable)
    table_df <- table_df[order(order_key), , drop = FALSE]
    table_df$`Sr. No.` <- seq_len(nrow(table_df))
    page_rows <- split(seq_len(nrow(table_df)), ceiling(seq_len(nrow(table_df))/15L))
    page_count <- length(page_rows)
    wrap_widths <- c(6L, 20L, 42L, 28L, 34L, 34L, 38L)
    column_widths <- c(0.5, 1.8, 3.4, 2.4, 2.8, 2.8, 3.2)
    wrap_variable <- function(value, width) paste(strwrap(value, width = width), collapse = "\n")
    grDevices::cairo_pdf(output_path, width = 17, height = 11, onefile = TRUE, family = "sans")
    on.exit(grDevices::dev.off(), add = TRUE)
    subtitle_text <- paste("Step 1: Complete column inventory and analytical roles.", "Step 2: Existing sensor consolidation and exposure-representation rules, unchanged.",
        "Step 3: Measurement provenance and shared-design diagnostics; all Step-2 eligible fields remain candidates.", "No VIF elimination stage. Current fitted equation and diagnostics are in H4_Step5_Equations_Checks.txt.",
        sep = "\n")
    for (page in seq_along(page_rows)) {
        rows <- page_rows[[page]]
        page_df <- table_df[rows, , drop = FALSE]
        for (column in seq_len(ncol(page_df))) {
            page_df[[column]] <- vapply(page_df[[column]], function(value) {
                if (column == 3L) {
                  wrap_variable(as.character(value), wrap_widths[column])
                }
                else {
                  paste(strwrap(as.character(value), width = wrap_widths[column]), collapse = "\n")
                }
            }, character(1))
        }
        table_grob <- gridExtra::tableGrob(page_df, rows = NULL, theme = gridExtra::ttheme_minimal(base_size = 9, padding = grid::unit(c(3,
            4.5), "mm"), core = list(fg_params = list(hjust = 0, x = 0.02, fontsize = 9), bg_params = list(fill = c("#ffffff",
            "#f8f9fa")[((seq_len(nrow(page_df)) - 1)%%2) + 1])), colhead = list(fg_params = list(fontface = "bold", hjust = 0,
            x = 0.02, fontsize = 9.5), bg_params = list(fill = "#dce6f1"))))
        table_grob$widths <- grid::unit(column_widths, "in")
        if (page == 1L && !is.null(preview_path)) {
            preview <- gridExtra::arrangeGrob(grid::textGrob("H4 Variable Audit Table", gp = grid::gpar(fontface = "bold",
                fontsize = 16)), table_grob, ncol = 1, heights = grid::unit(c(0.6, 9.8), "in"))
            ggplot2::ggsave(preview_path, preview, width = 17, height = 11, dpi = 220, limitsize = FALSE)
        }
        grid::grid.newpage()
        grid::grid.text("H4 Comprehensive Variable Audit", x = 0.5, y = 0.965, gp = grid::gpar(fontface = "bold", fontsize = 15))
        grid::grid.text(subtitle_text, x = 0.5, y = 0.89, just = c("centre", "top"), gp = grid::gpar(fontsize = 8.5, col = "#333333",
            lineheight = 1.1))
        grid::pushViewport(grid::viewport(x = 0.5, y = 0.77, just = c("centre", "top"), width = sum(table_grob$widths), height = sum(table_grob$heights)))
        grid::grid.draw(table_grob)
        grid::popViewport()
        grid::grid.text(sprintf("Page %d of %d  |  Full machine-readable audit: H4_Multivariate_Filtration_Results.csv",
            page, page_count), x = 0.5, y = 0.03, gp = grid::gpar(fontsize = 8, col = "gray40"))
    }
    invisible(page_count)
}
if (identical(Sys.getenv("H4_AUDIT_PDF_ONLY"), "1")) {
    if (!file.exists(OUT_CSV))
        stop("Existing H4 audit CSV not found: ", OUT_CSV, call. = FALSE)
    audit_page_count <- render_audit_pdf(utils::read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), AUDIT_PDF)
    cat(sprintf("Rendered audit table PDF only (%d pages): %s\n", audit_page_count, AUDIT_PDF))
    quit(save = "no", status = 0)
}
H4_SPEC <- list(participants = c("P4", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17"), phases = c("BikeU",
    "BikeG", "WalkU", "WalkG"), outcomes = list(Psychological = c("questionnaire_current_comfort_1_7", "questionnaire_pleasantness_1_5",
    "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"), Physiological_Autonomic = c("empatica_heart_rate",
    "empatica_eda_tonic", "empatica_eda_phasic", "empatica_skin_temperature", "empatica_hrv_td_sdnn", "empatica_hrv_td_rmssd",
    "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu",
    "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"), Physiological_Ocular = c("eyetracker_pupil_diameter_avg", "eyetracker_pupil_change_rate",
    "eyetracker_blink_duration_s", "eyetracker_fixation_duration_s", "eyetracker_fixation_rate", "eyetracker_saccade_duration_s",
    "eyetracker_saccade_amplitude", "eyetracker_saccade_peak_velocity", "eyetracker_gaze_velocity", "eyetracker_gaze_dispersion",
    "eyetracker_distance_from_center", "eyetracker_gaze_centrality", "eyetracker_eyelid_aperture_avg")), hrv_log = c("empatica_hrv_td_sdnn",
    "empatica_hrv_td_rmssd", "empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio", "empatica_hrv_fd_vlf",
    "empatica_hrv_fd_total_power"), hrv_fd = c("empatica_hrv_fd_lf", "empatica_hrv_fd_hf", "empatica_hrv_fd_lf_hf_ratio",
    "empatica_hrv_fd_lfnu", "empatica_hrv_fd_hfnu", "empatica_hrv_fd_vlf", "empatica_hrv_fd_total_power"), questionnaire = c("questionnaire_current_comfort_1_7",
    "questionnaire_pleasantness_1_5", "questionnaire_stai6_mean_1_5", "questionnaire_prs11_total_mean_1_5"), ordinal = c("questionnaire_current_comfort_1_7",
    "questionnaire_pleasantness_1_5"), vif_threshold = 5, expected_epochs = 49L)
H4_SPEC$all_outcomes <- unlist(H4_SPEC$outcomes, use.names = FALSE)
H4_SPEC$exposure_centered <- c(ucm_UTCI = "PC_UTCI", ucm_SND_dBA = "PC_dBA", atmo_pm2.5_avg = "PC_PM25", lys_lux_avg = "PC_Lux",
    gvi_50m = "PC_GVI")
H4_SPEC$bilateral_sources <- list(atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"))
h4_mean <- function(x) {
  if (!is.numeric(x) && !is.logical(x) && !is.factor(x)) return(NA_real_)
  x <- as.numeric(x)
  if(any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
}
h4_single_questionnaire_response <- function(x, outcome, participant_phase) {
    x <- x[is.finite(x)]
    if (!length(x))
        return(NA_real_)
    values <- unique(x)
    if (length(values) != 1L) {
        stop("Inconsistent duplicated questionnaire values for ", outcome, " in ", participant_phase, ": ", paste(values,
            collapse = ", "), call. = FALSE)
    }
    as.numeric(values[1])
}
h4_person_mean_center <- function(x, id) {
  ave(as.numeric(x), id, FUN = function(v) {
    if(any(is.finite(v))) v - mean(v[is.finite(v)]) else rep(NA_real_,length(v))
  })
}

h4_prepare_data <- function(raw) {
    required <- unique(c("ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources),
        names(H4_SPEC$exposure_centered)[c(1, 2, 5)], H4_SPEC$all_outcomes, "empatica_vector_magnitude"))
    missing <- setdiff(required, names(raw))
    if (length(missing))
        stop("Required H4 input columns missing: ", paste(missing, collapse = ", "))
    raw <- raw[raw$ParticipantID %in% H4_SPEC$participants & raw$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
    for (v in H4_SPEC$all_outcomes) {
        raw[[v]] <- as.numeric(raw[[v]])
        raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    }
    for (v in H4_SPEC$hrv_log) raw[[v]][!is.na(raw[[v]]) & raw[[v]] <= 0] <- NA_real_
    ranges <- list(questionnaire_current_comfort_1_7 = 1:7, questionnaire_pleasantness_1_5 = 1:5)
    for (v in H4_SPEC$ordinal) if (any(!is.na(raw[[v]]) & !raw[[v]] %in% ranges[[v]]))
        stop("Ordinal values outside declared scale: ", v)
    for (v in names(H4_SPEC$bilateral_sources)) raw[[v]] <- rowMeans(raw[, H4_SPEC$bilateral_sources[[v]], drop = FALSE],
        na.rm = TRUE)
    for (v in c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg")) raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    raw$ucm_SND_dBA[!is.na(raw$ucm_SND_dBA) & raw$ucm_SND_dBA < 0] <- NA_real_
    available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
    for (v in H4_SPEC$hrv_fd) raw[[v]][!available] <- NA_real_
    grid <- expand.grid(ParticipantID = H4_SPEC$participants, PhaseID = H4_SPEC$phases, stringsAsFactors = FALSE)
    grid <- grid[order(match(grid$ParticipantID, H4_SPEC$participants), match(grid$PhaseID, H4_SPEC$phases)), ]
    grid$ParticipantPhase <- paste(grid$ParticipantID, grid$PhaseID, sep = "::")
    keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
    if (length(setdiff(grid$ParticipantPhase, keys)))
        stop("Required participant-phase cells absent: ", paste(setdiff(grid$ParticipantPhase, keys), collapse = ", "))
    if (anyDuplicated(raw[, c("ParticipantID", "PhaseID", "Datetime")]))
        stop("Duplicate 10-second timestamps in input.")
    groups <- split(seq_len(nrow(raw)), factor(keys, levels = grid$ParticipantPhase))
    variables <- unique(c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m", "empatica_vector_magnitude",
        H4_SPEC$all_outcomes))
    coverage <- lapply(variables, function(v) {
        questionnaire <- v %in% H4_SPEC$questionnaire
        n <- vapply(groups, function(ix) if (questionnaire)
            length(unique(raw[[v]][ix][is.finite(raw[[v]][ix])]))
        else sum(is.finite(raw[[v]][ix])), integer(1))
        grid[[v]] <<- vapply(groups, function(ix) if (questionnaire)
            h4_single_questionnaire_response(raw[[v]][ix], v, paste(raw$ParticipantID[ix[1]], raw$PhaseID[ix[1]], sep = "::"))
        else h4_mean(raw[[v]][ix]), numeric(1))
        expected <- if (questionnaire)
            1L
        else H4_SPEC$expected_epochs
        data.frame(ParticipantID = grid$ParticipantID, PhaseID = grid$PhaseID, Measure_Type = if (questionnaire)
            "Questionnaire response"
        else if (v %in% H4_SPEC$all_outcomes)
            "Outcome"
        else "Exposure", Measure = v, N_valid = n, N_expected = expected, Coverage_pct = round(100 * n/expected, 1), Coverage_pass = if (questionnaire)
            n == 1L
        else n > 0L, stringsAsFactors = FALSE)
    })
    coverage <- do.call(rbind, coverage)
    if (any(coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass))
        stop("An exposure has no valid phase observations.")
    if (any(lengths(groups) != H4_SPEC$expected_epochs))
        warning("Matched-window row counts differ from declared denominator ", H4_SPEC$expected_epochs, ": ", paste(names(groups)[lengths(groups) !=
            H4_SPEC$expected_epochs], collapse = ", "), call. = FALSE)
    for (v in c("atmo_pm2.5_avg", "ucm_SND_dBA", "lys_lux_avg")) if (any(grid[[v]] < 0, na.rm = TRUE))
        stop("Negative phase-mean values require review: ", v)
    if (any(grid$gvi_50m < 0 | grid$gvi_50m > 100, na.rm = TRUE))
        stop("GVI outside 0-100%.")
    list(data = grid, coverage = coverage)
}
PARTICIPANTS <- H4_SPEC$participants
CORE_PHASES <- H4_SPEC$phases
SOUND_QC_COLUMNS <- c("window_duration_s", "is_complete_10s_window", "phase_start_offset_s", "yamnet_frame_count", "yamnet_threshold",
    "original_sample_rate_hz", "frequency_analysis_min_hz", "frequency_analysis_max_hz", "frequency_analysis_full_20khz_coverage")
SOUND_CATEGORY_PROP_COLUMNS <- c("wind_prop", "rural_natural_prop", "vehicle_prop", "urban_manmade_neutral_prop", "urban_manmade_positive_prop", "urban_manmade_negative_prop", "mechanisms_prop", "unidentify_prop")
is_sound_semantic <- function(x) {
    x %in% SOUND_CATEGORY_PROP_COLUMNS | grepl("^(sound_(prop|score)_|yamnet_class_[0-9]{3}_.+_(mean_score|prop)$)", x)
}

is_acoustic_frequency <- function(x) {
    grepl("^(dominant_frequency_hz|spectral_centroid_hz|spectral_rolloff85_hz|freq_prop_|octave_prop_)", x)
}
SVF_EXPOSURE_COLUMNS <- c("Sky_%", "SVF_Holmer", "Tree_%", "Plant_%", "Grass_%", "Combined_Vegetation_%", "Building_%", "Wall_%")
SVF_QC_COLUMNS <- c("Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
    "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
    "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched", "Manual_Mask_Path",
    "Manual_Sky_IoU", "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF_Holmer", "SVF_Abs_Error_vs_Manual")
is_svf_exposure <- function(x) {
    x %in% SVF_EXPOSURE_COLUMNS
}
EXPECTED_SOUND_FREQUENCY_COLUMNS <- c("dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_prop_20_125",
    "freq_prop_125_1000", "freq_prop_1000_4000", "freq_prop_4000_8000", "freq_prop_8000_20000", "octave_prop_31_5_hz", "octave_prop_63_0_hz",
    "octave_prop_125_0_hz", "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz", "octave_prop_2000_0_hz",
    "octave_prop_4000_0_hz", "octave_prop_8000_0_hz")
EXPECTED_SVF_ANALYSIS_COLUMNS <- SVF_EXPOSURE_COLUMNS
if (identical(Sys.getenv("H4_FACET_REFRESH"), "1")) {
    render_h4_faceted_flow(NULL)
    quit(save = "no", status = 0)
}
if (identical(Sys.getenv("H4_LASSO_ONLY"), "1") || identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
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
    render_h4_faceted_flow(NULL)
    cat("Step 5 equations are h4_step5_fitted_equations(); the old 15-combination grid is not rewritten.\n")
    quit(save = "no", status = 0)
  }
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
yamnet_class_columns <- grep("^yamnet_class_[0-9]{3}_.+_(mean_score|prop)$", raw_cols_all, value = TRUE)
yamnet_class_names <- unique(sub("_(mean_score|prop)$", "", yamnet_class_columns))
yamnet_class_ids <- unique(sub("^yamnet_class_([0-9]{3})_.*$", "\\1", yamnet_class_names))
if (length(yamnet_class_names) > 0L && (length(yamnet_class_names) != 521L || !setequal(yamnet_class_ids, sprintf("%03d",
    0:520)))) {
    warning("YAMNet class fields are incomplete (found ", length(yamnet_class_names), " of 521). The physical H4 model does not use YAMNet; the audit will report those fields as unavailable.",
        call. = FALSE)
}
df$ParticipantID <- as.character(df$ParticipantID)
df$PhaseID <- as.character(df$PhaseID)
df <- df[df$ParticipantID %in% PARTICIPANTS, ]
df$ParticipantID <- factor(df$ParticipantID, levels = PARTICIPANTS)
df$atmo_pm1_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1")], na.rm = TRUE)
df$atmo_pm2.5_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5")], na.rm = TRUE)
df$atmo_pm10_avg <- rowMeans(df[, c("atmo_lys_atmotube_left__atmotube_pm10", "atmo_lys_atmotube_right__atmotube_pm10")], na.rm = TRUE)
df$lys_lux_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux")], na.rm = TRUE)
df$lys_medi_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_medi", "atmo_lys_LYS2__lys_medi")], na.rm = TRUE)
df$lys_kelvin_avg <- rowMeans(df[, c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin")], na.rm = TRUE)
df_core <- df[df$PhaseID %in% CORE_PHASES, ]
cat(sprintf("Loaded %d observations across %d participants (%d core outdoor epochs).\n", nrow(df), length(unique(df$ParticipantID)),
    nrow(df_core)))
cat("[2/6] Step 1: Auditing full schema and partitioning analytical roles...\n")
classify_col_role <- function(c) {
  info <- function(role, source, unit, action, decision = "Excluded") c(source, role, unit, action, decision)
  source <- if(grepl("^ucm_", c)) "UCM Backpack" else if(grepl("^atmo_lys_", c)) "Atmo / LYS" else
    if(grepl("^eyetracker_", c)) "Pupil Labs" else if(grepl("^gvi_", c)) "GVI" else "Study Design"
  if(grepl("^empatica_hrv_fd_5min_", c)) return(info("Physiological Signal Quality & HRV Windowing (Empatica QC)",
    "Empatica EmbracePlus", "QC / ms\u00b2", "Excluded from exposure funnel; physiological QC and window integrity metric"))
  metadata <- c("ParticipantID","PhaseID","Datetime","Date","ucm_Date","atmo_lys_Date","eyetracker_Date",
    "ucm_GPS_lat","ucm_GPS_lon","ucm_GPS_alt","ucm_GPS_HDOP","ucm_GPS_hdg","ucm_MAG_hdg",
    "ucm_GPS_speed_valid_sample_count","pct_complete","gvi_match_dist_m")
  if(c %in% metadata) return(info("Study Metadata & Spatiotemporal Tracking", source, "Metadata",
    "Excluded from exposure funnel; spatial/temporal tracking only"))
  if(c %in% SOUND_QC_COLUMNS) return(info("Acoustic Processing QC & Provenance", "YAMNet / Spectral Processing",
    if(grepl("_hz$|sample_rate",c)) "Hz" else if(grepl("duration|offset",c)) "s" else if(grepl("prop",c)) "proportion" else "QC",
    "Excluded from exposure funnel; processing provenance / completeness / spectral-coverage QC"))
  if(c %in% SVF_QC_COLUMNS) return(info("SVF Processing QC & Provenance", "CamUp / DeepLabV3+ Xception65",
    if(grepl("Radius|Center|Width|Height",c)) "px" else if(grepl("IoU|Dice|Accuracy",c)) "validation metric" else "QC",
    "Excluded from exposure funnel; SVF calibration, segmentation, provenance, or manual-validation QC"))
  if(grepl("^questionnaire_clothing_|^questionnaire_background_",c) || c %in% c("questionnaire_participant_id",
    "questionnaire_response_index_within_participant","questionnaire_height_m","questionnaire_weight_kg","questionnaire_bmi_kg_m2","questionnaire_bmi_category_who"))
    return(info("Participant Demographics & Clothing Metadata","Questionnaire","Demographic","Excluded from exposure funnel; baseline cohort characterization"))
  if(grepl("__lux_cat$",c)) return(info("Derived Light Category (not an independent continuous exposure)", "LYS", "Category",
    "Derived illuminance category; continuous lux is available; no averaged replacement exists."))
  if(grepl("__lys_movement$",c) || c %in% c("ucm_GPS_speed_kmh","empatica__met","empatica_acc_x","empatica_acc_y","empatica_acc_z","empatica_vector_magnitude"))
    return(info("Movement & Exertion Covariates (Z)", if(grepl("^ucm_",c)) "UCM Backpack" else if(grepl("^atmo_lys_",c)) "LYS" else "Empatica EmbracePlus",
      if(c=="ucm_GPS_speed_kmh") "km/h" else if(c=="empatica__met") "MET" else if(grepl("__lys_movement$",c)) "Device movement output" else "g",
      "Movement covariate; the current Step 5 adjusts for Mode. PC_Movement is a design diagnostic. No LYS movement average is declared."))
  if(c %in% H4_SPEC$all_outcomes && !grepl("^questionnaire_",c)) return(info("Physiological Sensor Outcomes (Y_physio)",
    if(grepl("^empatica_",c)) "Empatica EmbracePlus" else "Pupil Labs Neon",
    if(grepl("heart_rate",c)) "bpm" else if(grepl("skin_temperature",c)) "\u00b0C" else if(grepl("pupil",c)) "mm" else if(grepl("eda",c)) "\u00b5S" else if(grepl("rmssd",c)) "ms" else "Physio unit",
    "Excluded from exposure funnel; objective dependent outcome (Y)", "Retained"))
  if(c %in% H4_SPEC$all_outcomes) return(info("Psychological Survey Outcomes (Y_psych)","Post-Phase Surveys (STAI, PRS)",
    "Survey score","Excluded from exposure funnel; subjective psychological outcome (Y)"))
  if(grepl("^(empatica|eyetracker|questionnaire)_",c)) return(info("Sensor or Questionnaire Field Outside Declared H4 Outcome Set",
    if(grepl("^empatica_",c)) "Empatica EmbracePlus" else if(grepl("^eyetracker_",c)) "Pupil Labs Neon" else "Questionnaire",
    "Not modeled in declared H4 outcome family","Excluded from H4 model; not in the shared 30-outcome specification","EXCLUDED UNDECLARED H4 OUTCOME"))
  source <- if(grepl("^ucm_",c)) "UCM Backpack" else if(grepl("^atmo_lys_",c)) "Atmotube / LYS" else
    if(grepl("^gvi_|^tree_|^grass_|^plant_",c)) "Eye-Level Panoramic Imagery" else if(is_sound_semantic(c)) "YAMNet Audio Classification" else
    if(is_acoustic_frequency(c)) "Native-WAV Spectral Analysis" else if(is_svf_exposure(c)) "CamUp / DeepLabV3+ Xception65" else "Solar Models"
  unit <- if(grepl("temp|UTCI|PET|MRT|T_bot|T_top|T_mid|HUMIDEX",c)) "\u00b0C" else if(grepl("SND|dBA",c)) "dBA" else
    if(grepl("pm",c)) "\u00b5g/m\u00b3" else if(grepl("lux",c)) "lux" else if(grepl("medi",c)) "medi" else if(grepl("kelvin",c)) "K" else
    if(grepl("gvi|tree|grass|plant|RH",c)) "%" else if(grepl("WIND",c)) "m/s" else if(grepl("_hz$",c)) "Hz" else
    if(is_sound_semantic(c)||grepl("^freq_prop_|^octave_prop_",c)) "proportion / score" else if(c=="SVF_Holmer") "0-1" else if(grepl("_%$",c)) "%" else "Physical unit"
  info("Environmental Stressor Candidates (X_env)",source,unit,"Retained for Step 2 technical sensor consolidation","RETAINED FOR FILTRATION")
}
derived_cols_all <- c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg")
all_variables_pool <- unique(c(raw_cols_all, derived_cols_all))
step1_mat <- t(sapply(all_variables_pool, function(col) {
  if (col %in% derived_cols_all) {
    plat <- if (grepl("^atmo_", col)) "Atmotube" else "LYS Study Average"
    unit <- if (grepl("pm", col)) "µg/m³" else if (grepl("lux", col)) "lux" else if (grepl("medi", col)) "medi" else "K"
    c(plat, "Environmental Stressor Candidates (X_env)", unit, "Retained for Step 2 technical sensor consolidation", "RETAINED FOR FILTRATION")
  } else {
    classify_col_role(col)
  }
}))
cat("[3/6] Step 2: Checking explicit replacements, measurement type and within-person availability...\n")
average_sources <- list(atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = H4_SPEC$bilateral_sources$atmo_pm2.5_avg, atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10",
        "atmo_lys_atmotube_right__atmotube_pm10"), lys_lux_avg = H4_SPEC$bilateral_sources$lys_lux_avg, lys_medi_avg = c("atmo_lys_LYS1__lys_medi",
        "atmo_lys_LYS2__lys_medi"), lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
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
h4_measurement_sources <- data.frame(Variable_Name = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh", "atmo_pm1_avg",
    "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
    "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m", "ucm_WIND_TWS", "ucm_fp"), Measurement_Code = c(rep("M",
    4), rep("A", 4), rep("D", 9), "P", "U"), Measurement_Type = c(rep("Instrument-reported measurement", 4), rep("Averaged instrument measurement",
    4), rep("Derived metric", 9), "Processed wind; upstream formula unverified", "Definition unverified"), Inputs_or_Definition = c("Air-temperature sensor output",
    "Relative-humidity sensor output", "A-weighted sound-pressure level; calibrated acoustic measurement", "Measured global horizontal solar irradiance",
    "Arithmetic average of left/right Atmotube PM1 outputs", "Arithmetic average of left/right Atmotube PM2.5 outputs", "Arithmetic average of left/right Atmotube PM10 outputs",
    "Arithmetic average of LYS1/LYS2 photopic illuminance; spectral calibration upstream", "Melanopic equivalent daylight illuminance derived from spectral channels, then LYS1/LYS2 average",
    "Correlated colour temperature derived from spectral/chromaticity channels, then LYS1/LYS2 average", "Calculated mean radiant temperature from radiative sensor inputs; deployed UCM algorithm not reproduced here",
    "Human heat-balance index using air temperature, radiation/MRT, humidity, wind and person/clothing/metabolic assumptions; deployed assumptions need UCM documentation",
    "Thermal index using air temperature, radiation/MRT, humidity and wind with reference physiological/clothing assumptions; deployed wind correction needs UCM documentation",
    "Humidity index combining air temperature and vapour pressure derived from humidity", "Measured SUN_Gh / calculated G0; exact code in scripts/compute_clearness_index.py",
    "1367 * (1 + 0.033*cos(2*pi*day_of_year/365)) * sin(solar_altitude); calculated extraterrestrial irradiance, not another clearness index",
    "Image-derived vegetation fraction with spatial matching; see canonical GVI source mapping", "Exported true-wind-speed channel; exact movement/direction correction unavailable in this repository",
    "Exported UCM fp field; acronym and formula not verified against a current source manual"), Evidence = c(rep("CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427",
    4), rep("Existing bilateral average_sources mapping", 4), rep("LYS manufacturer help; Stevenson et al. doi:10.1177/14771535251338582; existing average mapping",
    2), rep("CityFeel 2017 section 2.3; exact deployed calculation external", 4), rep("scripts/compute_clearness_index.py",
    2), "scripts/merge_11participant_statistical_inputs.py GVI_SOURCE_ALIASES", "Export name and available pipeline only; exact upstream formula pending",
    "Current source manual not found; no inferred expansion asserted"), stringsAsFactors = FALSE)
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
cat("Step 3: Tracing measurement sources and within-person dependencies; no predictor elimination...\n")
screening_candidates <- all_variables_pool[step2_mat[, 2] == "Retained"]
write.csv(h4_prepared_for_vif$coverage, file.path(OUT_DIR, "H4_Phase_Coverage.csv"), row.names = FALSE, na = "")
design_audit <- h4_audit_step3(df_core, screening_candidates)
h4_retained_candidates <- screening_candidates
stopifnot(setequal(screening_candidates, setdiff(h4_measurement_sources$Variable_Name, "ucm_fp")))
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
  step3_decision <- if (step3_stat == "DATA-ELIGIBLE SCREENING CANDIDATE") "Retained" else "-"
  step1_criterion_row <- paste0(step1_criterion, "; observed role: ", role)
  step2_criterion_row <- paste0(step2_criterion, "; observed rule: ", ifelse(grepl("^N/A", step2_rule), "-", step2_rule), "; status: ", ifelse(step2_stat == "N/A", "-", step2_stat))
  step3_criterion_row <- paste0(step3_criterion, "; observed domain: ", ifelse(dom == "N/A", "-", dom), "; status: ", ifelse(step3_stat == "N/A", "-", step3_stat))
  if (col %in% h4_retained_candidates) {
    final_outcome <- "CANDIDATE AFTER MEASUREMENT AUDIT"
    final_rat <- paste0("Available candidate in ", dom, ". Measurement dependencies are documented; no automatic VIF or correlation elimination. Model membership remains undecided; outcome models have not been refitted.")
  } else if (step3_stat %in% c("EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT",
    "EXPLORATORY SVF CONSTRUCT", "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT", "MACRO-CONTEXT CONSTRUCT")) {
    final_outcome <- step3_stat
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
    final_rat <- "Objective physiological outcome; Step 4 uses 10-second summaries with declared HRV logs. Step 5 handles its outcome transformations separately."
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
outcome_order <- c("CANDIDATE AFTER MEASUREMENT AUDIT", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT",
    "EXPLORATORY SVF CONSTRUCT", "EXPLORATORY SVF SCENE-COMPOSITION CONSTRUCT", "MACRO-CONTEXT CONSTRUCT", "SUBSUMED WITHIN DOMAIN",
    "CONSOLIDATED RAW STREAM (EXCLUDED)", "PHYSIOLOGICAL OUTCOME (Y)", "PSYCHOLOGICAL OUTCOME (Y)", "MOVEMENT COVARIATE (Z)",
    "STUDY METADATA", "DEMOGRAPHIC METADATA", "QC METRIC")
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
final_filtration_df$Audit_Domain <- mapply(infer_audit_domain, final_filtration_df$Variable_Name, final_filtration_df$Step1_Role,
    final_filtration_df$Scientific_Domain, USE.NAMES = FALSE)
integration_families <- list(`Sound category frame proportions` = SOUND_CATEGORY_PROP_COLUMNS, `Acoustic frequency descriptors` = EXPECTED_SOUND_FREQUENCY_COLUMNS,
    `SVF / urban morphology` = EXPECTED_SVF_ANALYSIS_COLUMNS)
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
stage_summary_df <- data.frame(Stage = c("Step 1: Complete inventory", "Step 2: Eligible representations", "Step 3: Measurement audit"),
    Count = c(nrow(final_filtration_df), length(screening_candidates), length(h4_retained_candidates)), Criterion = c("Every input column plus declared averages",
        "Existing consolidation and representation rules unchanged", "Provenance, dependencies and within-person diagnostics; no elimination"),
    stringsAsFactors = FALSE)
write.csv(stage_summary_df, STAGE_SUMMARY_CSV, row.names = FALSE, na = "")
count_stage_categories <- function(df, category_col, retained_mask, stage_name, scope_note) {
  cats <- as.character(df[[category_col]])
  cats[is.na(cats) | cats == "" | cats == "-"] <- "Not applicable / unclassified"
  groups <- split(seq_len(nrow(df)), cats)
  do.call(rbind, lapply(names(groups), function(category) {
    ix <- groups[[category]]
    n <- sum(retained_mask[ix], na.rm = TRUE)
    data.frame(Stage = stage_name, Category = category, Total_Entering_Category = length(ix),
      Retained_to_Next_Stage = n, Not_Advanced_from_Stage = length(ix) - n, Scope = scope_note,
      stringsAsFactors = FALSE)
  }))
}
step1_counts <- count_stage_categories(final_filtration_df, "Step1_Role", final_filtration_df$Step1_Decision == "Retained",
    "Step 1 - Analytical role classification", "All audited variables. Only environmental exposure candidates advance to Step 2.")
step2_df <- final_filtration_df[final_filtration_df$Step1_Decision == "Retained", , drop = FALSE]
step2_counts <- count_stage_categories(step2_df, "Step2_Rule", step2_df$Step2_Decision == "Retained", "Step 2 - Sensor preprocessing / consolidation",
    "Only environmental candidates from Step 1.")
step3_df <- final_filtration_df[final_filtration_df$Step2_Decision == "Retained", , drop = FALSE]
step3_counts <- count_stage_categories(step3_df, "Audit_Domain", step3_df$Step3_Decision == "Retained", "Step 3 - Within-person design diagnostics",
    "Only Step-2 retained environmental streams.")
step_category_counts_df <- rbind(step1_counts, step2_counts, step3_counts)
write.csv(step_category_counts_df, STEP_CATEGORY_CSV, row.names = FALSE, na = "")
final_outcome_counts_df <- aggregate(list(Count = rep(1L, nrow(final_filtration_df))), by = list(Final_Outcome = final_filtration_df$Final_Filtration_Outcome),
    FUN = sum)
final_outcome_counts_df <- final_outcome_counts_df[order(-final_outcome_counts_df$Count, final_outcome_counts_df$Final_Outcome),
    , drop = FALSE]
write.csv(final_outcome_counts_df, FINAL_OUTCOME_COUNTS_CSV, row.names = FALSE, na = "")
fmt_md_table <- function(df) {
  if(!nrow(df)) return("(none)")
  row <- function(x) paste0("| ", paste(gsub("\\|", "/", as.character(x)), collapse = " | "), " |")
  paste(c(row(names(df)), row(rep("---", ncol(df))), apply(df, 1, row)), collapse = "\n")
}
stage_totals_report <- data.frame(Stage = c("Step 1", "Step 2", "Step 3"), Entering = c(nrow(final_filtration_df), nrow(step2_df),
    nrow(step3_df)), Retained = c(sum(final_filtration_df$Step1_Decision == "Retained"), sum(step2_df$Step2_Decision == "Retained"),
    nrow(step3_df)), Not_Advanced = c(sum(final_filtration_df$Step1_Decision != "Retained"), sum(step2_df$Step2_Decision !=
    "Retained"), 0L))
report_lines <- c("# H4 measurement audit", "Steps 1-2 retain the complete inventory and declared exposure representations. Step 3 groups candidates without outcome-based deletion.",
    "Step 4 uses separate Empatica and ocular domain-wise LASSOs; the combined candidate set is their union. Pooled-response fits are diagnostic.",
    "Participant-held-out tuning with training-only standardisation. No forced winner; zero or multiple selections are allowed.",
    "Participant is the independent cluster. Current fits are equation 1 and the thermal-by-sound and thermal-by-activity equation in H4_models. H4_Step5_Equations_Checks.txt is historical.",
    "## Stage totals", fmt_md_table(stage_totals_report), "## Measurement definitions and dependencies", fmt_md_table(h4_measurement_sources),
    "Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.",
    "fp and exact wind correction remain unverified; SVF remains planned pending processing/merge.", "## Current Step 5 specification",
    "Generated from the saved Step 4 union; inspect H4_Step5_Equations_Checks.txt for the actual fitted run and diagnostics.",
    "## Within-person design diagnostics", fmt_md_table(design_audit$omissions), fmt_md_table(design_audit$pairs), "Domain-wise selection does not adjust exposures across domains. Same-data selection and fitting do not provide confirmatory inference.",
    "Sources: https://doi.org/10.1016/j.egypro.2017.07.427 ; https://glmnet.stanford.edu/articles/glmnet.html ; https://doi.org/10.2202/1557-4679.1353")
writeLines(report_lines, TRANSPARENCY_MD, useBytes = TRUE)
cat("\nH4 screening-path counts and domain counts\n")
print(stage_totals_report, row.names = FALSE)
print(step3_counts, row.names = FALSE)
h4_step4_lasso <- function(raw, audit, outcomes = unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")],
    use.names = FALSE)) {
    if (!requireNamespace("glmnet", quietly = TRUE))
        stop("Step 4 requires the installed glmnet package.")
    stopifnot(length(outcomes) > 1L, !anyDuplicated(outcomes), all(outcomes %in% names(raw)))
    y <- as.matrix(raw[, outcomes, drop = FALSE])
    storage.mode(y) <- "double"
    y[!is.finite(y)] <- NA_real_
    available <- tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
    y[!available, intersect(colnames(y), H4_SPEC$hrv_fd)] <- NA_real_
    for (v in intersect(colnames(y), H4_SPEC$hrv_log)) {
        y[y[, v] <= 0 & !is.na(y[, v]), v] <- NA_real_
        y[, v] <- log(y[, v])
    }
    domains <- lapply(h4_lasso_domains, setdiff, y = c("Clearness_Index_G0", "ucm_fp"))
    eligible <- audit$Variable_Name[audit$Step3_Decision == "Retained"]
    audit$Step4_Domain <- NA_character_
    audit$Step4_Decision <- "Not entered"
    audit$Step4_Status <- "Not a Step-3 environmental candidate"
    audit$Step4_Rows <- audit$Step4_Participants <- NA_integer_
    audit$Step4_Lambda_Ratio <- audit$Step4_CV_MSE <- audit$Step4_CV_SE <- audit$Step4_Coefficient_Norm <- NA_real_
    audit$Step4_Response_Count <- NA_integer_
    audit$Step4_Response_Missing_Rows <- NA_integer_
    audit$Step4_MinError_Coefficient_Norm <- audit$Step4_MinError_Ratio <- NA_real_
    audit$Step4_MinError_Decision <- "Not entered"
    audit$Step4_OneSE_Decision <- "Not entered"
    audit$Step4_OneSE_Ratio <- NA_real_
    audit$Step4_Status[audit$Variable_Name %in% outcomes] <- "Response Y; never entered in predictor X"
    audit$Step4_Status[audit$Variable_Name == "Clearness_Index_G0"] <- "Calculation denominator; not an exposure in Step 4"
    audit$Step4_Status[audit$Variable_Name == "ucm_fp"] <- "Definition unverified; not entered in Step 4"
    ratios <- exp(seq(log(1), log(0.001), length.out = 60L))
    notes <- c("", "## Step 4: exploratory domain-wise multi-response LASSO", paste("glmnet version:", packageVersion("glmnet")),
        sprintf("Input is matched 10-second windows; %d response columns; declared HRV log transforms and availability flags respected when applicable.",
            length(outcomes)), "Leave one participant out. Exposures are participant-mean centered, not global z-scored. After centering, each environmental column is z-scored with the unweighted training-row mean and SD; a non-finite or zero SD drops that column. glmnet standardize=FALSE because those z-scores are already applied. Held-out rows are centered on the held-out participant and then scaled with the training mean and SD. Mode is training-fold standardized and unpenalised. Outcomes are training-fold standardized. Each participant has equal training weight and equal validation weight.",
        "Tune a 60-point relative lambda path (1 to 0.001) by minimum held-out participant MSE. One-SE is sensitivity only. Zero/multiple selections allowed; no forced winner.",
        "Domains are declared measurement groups, not learned groups. Each domain is fitted separately, so retained variables are not mutually adjusted across domains.",
        "Complete cases across the specified response family are required per domain. Samples can differ across families/domains; no imputation.",
        "Exploratory predictive screening only. No mixed-model inference, causal interpretation, unbiased external performance estimate, or post-selection p-values.",
        paste("Response columns:", paste(outcomes, collapse = ", ")), paste("Missing/non-finite response rows after existing HRV QC:",
            paste(colnames(y), colSums(is.na(y)), sep = "=", collapse = "; ")))
    for (domain in names(domains)) {
        variables <- intersect(domains[[domain]], intersect(eligible, names(raw)))
        if (!length(variables))
            next
        index <- match(variables, audit$Variable_Name)
        audit$Step4_Domain[index] <- domain
        x <- cbind(ModeBike = as.numeric(grepl("^Bike", raw$PhaseID)), as.matrix(raw[, variables, drop = FALSE]))
        storage.mode(x) <- "double"
        x[!is.finite(x)] <- NA_real_
        complete <- complete.cases(x, y)
        ids <- as.character(raw$ParticipantID[complete])
        x <- x[complete, , drop = FALSE]
        yy <- y[complete, , drop = FALSE]
        participants <- sort(unique(ids))
        audit$Step4_Rows[index] <- nrow(x)
        audit$Step4_Participants[index] <- length(participants)
        audit$Step4_Response_Count[index] <- ncol(yy)
        audit$Step4_Response_Missing_Rows[index] <- sum(!complete.cases(y))
        notes <- c(notes, sprintf("%s: %d/%d complete windows; %d participants; %d responses.", domain, nrow(x), nrow(raw),
            length(participants), length(outcomes)))
        notes <- c(notes, paste("Included participants:", paste(participants, collapse = ", ")), paste("Participants with no complete windows:",
            paste(setdiff(unique(as.character(raw$ParticipantID)), participants), collapse = ", ")))
        result <- tryCatch({
            if (length(participants) < 3L)
                stop("Fewer than three participants with complete X/Y; no valid grouped validation.")
            fit_path <- function(train, test = NULL) {
                # Participant-mean centering, then unweighted training-fold z-score. glmnet standardize=FALSE.
                xx <- x[train, , drop = FALSE]
                yt <- yy[train, , drop = FALSE]
                id_tr <- ids[train]
                for (j in seq.int(2L, ncol(xx))) {
                  mu <- tapply(xx[, j], id_tr, function(v) mean(v[is.finite(v)]))
                  xx[, j] <- xx[, j] - as.numeric(mu[id_tr])
                }
                sy <- apply(yt, 2L, sd)
                if (any(!is.finite(sy) | sy <= 0))
                  stop("A response has zero/non-finite training variance.")
                my <- colMeans(yt)
                yt <- scale(yt, my, sy)
                mode_mean <- mean(xx[, 1L])
                mode_sd <- stats::sd(xx[, 1L])
                if (!is.finite(mode_sd) || mode_sd <= 0)
                  stop("Training fold lacks both mobility modes.")
                xx[, 1L] <- (xx[, 1L] - mode_mean)/mode_sd
                train_mu <- colMeans(xx)
                train_sd <- apply(xx, 2L, stats::sd)
                train_mu[1L] <- 0
                train_sd[1L] <- 1
                keep <- is.finite(train_sd) & train_sd > 1e-08
                keep[1L] <- TRUE
                if (sum(keep) < 2L)
                  stop("No varying environmental predictor in a training fold.")
                xx <- xx[, keep, drop = FALSE]
                train_mu <- train_mu[keep]
                train_sd <- train_sd[keep]
                if (ncol(xx) > 1L) {
                  xx[, -1L] <- sweep(xx[, -1L, drop = FALSE], 2L, train_mu[-1L], "-")
                  xx[, -1L] <- sweep(xx[, -1L, drop = FALSE], 2L, train_sd[-1L], "/")
                }
                stopifnot(nrow(xx) == nrow(yt), identical(colnames(yt), outcomes))
                weights <- 1/as.numeric(table(ids[train])[ids[train]])
                penalty <- c(0, rep(1, ncol(xx) - 1L))
                pilot <- glmnet::glmnet(xx, yt, family = "mgaussian", alpha = 1, weights = weights, penalty.factor = penalty,
                  standardize = FALSE, standardize.response = FALSE)
                if (!is.null(pilot$jerr) && pilot$jerr != 0L)
                  stop(paste("glmnet pilot returned code", pilot$jerr))
                lambdas <- pilot$lambda[1L] * ratios
                fit <- glmnet::glmnet(xx, yt, family = "mgaussian", alpha = 1, weights = weights, penalty.factor = penalty,
                  standardize = FALSE, standardize.response = FALSE, lambda = lambdas)
                if (!is.null(fit$jerr) && fit$jerr != 0L)
                  stop(paste("glmnet returned code", fit$jerr))
                if (is.null(test))
                  return(list(fit = fit, lambda = lambdas, columns = colnames(xx)))
                xt <- x[test, , drop = FALSE]
                id_te <- ids[test]
                for (j in seq.int(2L, ncol(xt))) {
                  mu <- tapply(xt[, j], id_te, function(v) mean(v[is.finite(v)]))
                  xt[, j] <- xt[, j] - as.numeric(mu[id_te])
                }
                xt[, 1L] <- (x[test, 1L] - mode_mean)/mode_sd
                xt <- xt[, keep, drop = FALSE]
                if (ncol(xt) > 1L) {
                  xt[, -1L] <- sweep(xt[, -1L, drop = FALSE], 2L, train_mu[-1L], "-")
                  xt[, -1L] <- sweep(xt[, -1L, drop = FALSE], 2L, train_sd[-1L], "/")
                }
                pred <- predict(fit, newx = xt, s = lambdas)
                truth <- scale(yy[test, , drop = FALSE], my, sy)
                vapply(seq_along(lambdas), function(j) mean((pred[, , j] - truth)^2), numeric(1))
            }
            loss <- vapply(participants, function(id) {
                train <- which(ids != id)
                test <- which(ids == id)
                stopifnot(!length(intersect(ids[train], ids[test])))
                fit_path(train, test)
            }, numeric(length(ratios)))
            mse <- rowMeans(loss)
            se <- apply(loss, 1L, sd)/sqrt(length(participants))
            stopifnot(all(is.finite(mse)), all(is.finite(se)))
            best <- which.min(mse)
            one_se <- which(mse <= mse[best] + se[best])[1L]
            chosen <- best
            final <- fit_path(seq_along(ids))
            coefficients <- coef(final$fit, s = final$lambda[chosen])
            norm <- sqrt(Reduce(`+`, lapply(coefficients, function(b) as.numeric(b[-1L, 1L])^2)))
            names(norm) <- final$columns
            one_coef <- coef(final$fit, s = final$lambda[one_se])
            one_norm <- sqrt(Reduce(`+`, lapply(one_coef, function(b) as.numeric(b[-1L, 1L])^2)))
            names(one_norm) <- final$columns
            min_norm <- norm
            notes <- c(notes, sprintf("%s: minimum-error ratio %.6g (MSE %.6g; SE %.6g); one-SE ratio %.6g (MSE %.6g; SE %.6g). SE is a fold-based tuning heuristic, not an inferential CI.",
                domain, ratios[best], mse[best], se[best], ratios[one_se], mse[one_se], se[one_se]), paste(capture.output(print(data.frame(Lambda_Ratio = ratios,
                CV_MSE = mse, CV_SE = se), row.names = FALSE)), collapse = "\n"))
            list(norm = norm, ratio = ratios[chosen], mse = mse[chosen], se = se[chosen], min_norm = min_norm, min_ratio = ratios[best],
                one_norm = one_norm, one_ratio = ratios[one_se])
        }, error = function(e) {
            message("Step 4 ", domain, " not estimable: ", conditionMessage(e))
            notes <<- c(notes, paste(domain, "NOT ESTIMABLE:", conditionMessage(e)))
            NULL
        })
        if (is.null(result)) {
            audit$Step4_Status[index] <- "Not estimable; no predictor selected"
            next
        }
        norms <- result$norm[variables]
        norms[is.na(norms)] <- 0
        selected <- norms > 1e-08
        audit$Step4_Decision[index] <- ifelse(selected, "Retained", "Not selected")
        audit$Step4_Status[index] <- ifelse(selected, "Exploratory nonzero coefficient at minimum CV error", "Zero coefficient at minimum CV error")
        audit$Step4_Coefficient_Norm[index] <- norms
        audit$Step4_Lambda_Ratio[index] <- result$ratio
        audit$Step4_CV_MSE[index] <- result$mse
        audit$Step4_CV_SE[index] <- result$se
        min_norms <- result$min_norm[variables]
        min_norms[is.na(min_norms)] <- 0
        audit$Step4_MinError_Coefficient_Norm[index] <- min_norms
        audit$Step4_MinError_Ratio[index] <- result$min_ratio
        audit$Step4_MinError_Decision[index] <- ifelse(min_norms > 1e-08, "Nonzero (minimum error)", "Zero (minimum error)")
        audit$Step4_OneSE_Decision[index] <- ifelse(result$one_norm[variables] > 1e-08, "Retained", "Not selected")
        audit$Step4_OneSE_Ratio[index] <- result$one_ratio
        notes <- c(notes, paste(domain, "selected:", if (any(selected)) paste(variables[selected], collapse = ", ") else "NONE"))
        cat(tail(notes, 1L), "\n")
    }
    stopifnot(!any(audit$Variable_Name[audit$Step4_Decision == "Retained"] %in% outcomes))
    list(audit = audit, notes = notes)
}
step4_families <- list(Empatica = H4_SPEC$outcomes$Physiological_Autonomic, Eyetracker = H4_SPEC$outcomes$Physiological_Ocular,
    Combined = unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE))
stopifnot(identical(unname(lengths(step4_families)), c(13L, 13L, 26L)), all(grepl("^empatica_", step4_families$Empatica)),
    all(grepl("^eyetracker_", step4_families$Eyetracker)), !length(intersect(step4_families$Empatica, step4_families$Eyetracker)))
step4_family_results <- lapply(step4_families, function(outcomes) h4_step4_lasso(df_core, final_filtration_df, outcomes))
final_filtration_df <- final_filtration_df[, !grepl("^Step4_", names(final_filtration_df)), drop = FALSE]
for (family in names(step4_family_results)) {
    result <- step4_family_results[[family]]
    fields <- grep("^Step4_", names(result$audit), value = TRUE)
    for (field in fields) final_filtration_df[[sub("^Step4_", paste0("Step4_", family, "_"), field)]] <- result$audit[[field]]
    note_lines <- result$notes[!is.na(result$notes)]
    cat(paste0("\nRESPONSE FAMILY: ", family, "\n"), grep("minimum-error ratio", note_lines, value = TRUE), sep = "\n")
    cat(paste(c(paste0("\n## Response family: ", family), result$notes), collapse = "\n"), file = TRANSPARENCY_MD, append = TRUE)
}
final_filtration_df$Step4_Domain <- step4_family_results$Empatica$audit$Step4_Domain
final_filtration_df <- h4_sensor_union(final_filtration_df)
tryCatch(write.csv(final_filtration_df, OUT_CSV, row.names = FALSE, na = ""), error = function(e) write.csv(final_filtration_df,
    sub(".csv$", "_latest.csv", OUT_CSV), row.names = FALSE, na = ""))
cat(sprintf("SUCCESS: Exported H4 multivariate audit CSV with %d variables to:\n  %s\n", nrow(final_filtration_df), OUT_CSV))
within_audit <- file.path(OUT_DIR, "H4_Step4_within_person_audit.csv")
unstd_audit <- file.path(OUT_DIR, "H4_Step4_within_person_unstandardized_PRESERVED.csv")
preserved_audit <- file.path(OUT_DIR, "H4_Step4_global_z_audit_PRESERVED.csv")
if (!file.exists(unstd_audit) && file.exists(within_audit)) file.copy(within_audit, unstd_audit, overwrite = FALSE)
write.csv(final_filtration_df, within_audit, row.names = FALSE, na = "")
writeLines(c(
  "H4 Step 4 domain-wise LASSO scaling rule.",
  "Exposures stay participant-mean centered. They are not returned to global raw z-scores.",
  "Inside each training fold, after centering, each environmental predictor is z-scored with the unweighted mean and SD of those centered training rows. A column with non-finite or zero SD is dropped from that fold.",
  "glmnet is called with standardize=FALSE because those z-scores are already applied. standardize=TRUE is not also applied, so the penalty is not scaled a second time.",
  "Held-out rows are centered with the held-out participant's own mean, then divided using the training-fold mean and SD. The final refit uses the same rule on all complete-case rows.",
  "Mode is training-fold standardized and unpenalised. Outcomes are training-fold standardized. Participants, including P4, stay in the sample. The selector is the minimum participant-held-out MSE on the two separate screens (Empatica and eye-tracker). The union is domain-wise, not a best-overall ranking.",
  "The LMM uses a different SD: the full-sample SD of the participant-mean-centered predictor, documented with the fitted equations. That full-sample SD is not the LASSO training-fold SD."
), file.path(OUT_DIR, "H4_Step4_scaling_rule.txt"))
writeLines(c(
  "H4 Step 4 exposure centering (domain-wise multi-response LASSO).",
  "Exposures are participant-mean centered, then z-scored inside the training fold as written in H4_Step4_scaling_rule.txt. They are not global z-scores of the raw values.",
  "Training rows: subtract each training participant's mean of that exposure, computed only on that participant's training rows in the domain's complete-case sample.",
  "Held-out rows: the held-out participant has no training rows, so subtract that participant's mean computed only on their held-out rows. Training person means are not copied onto a different person, and held-out rows do not enter any training person mean.",
  "Final refit on all complete-case rows: subtract each participant's mean computed on those complete-case rows. This matches the estimation centering (Enders & Tofighi): value minus that person's mean.",
  "Mode (bike vs walk) stays an unpenalised covariate and is standardized with the training-fold mean and SD. Outcomes are standardized with the training-fold mean and SD so the multi-response loss is not dominated by outcome units.",
  "Lambda path, penalty factors, domains, participants (including P4), and the minimum participant-held-out MSE rule are unchanged. PM1 remains eligible inside the pollution domain."
), file.path(OUT_DIR, "H4_Step4_within_person_centering_rule.txt"))
new_union <- sort(unique(final_filtration_df$Variable_Name[final_filtration_df$Step4_Union_Decision == "Retained"]))
cmp <- c(
  "Comparison of domain-wise within-person LASSO unions. Both use participant-mean centering. The preserved file does not z-score the centered predictors. The new audit z-scores them inside each training fold (see H4_Step4_scaling_rule.txt).",
  paste("Unstandardized within-person audit:", unstd_audit),
  paste("Standardized-within-person audit:", within_audit),
  "Label: domain-wise selection. This is not a list of the best overall predictors."
)
if (file.exists(unstd_audit)) {
  old <- read.csv(unstd_audit, check.names = FALSE)
  old_union <- sort(unique(old$Variable_Name[old$Step4_Empatica_Decision == "Retained" | old$Step4_Eyetracker_Decision == "Retained"]))
  cmp <- c(cmp,
    paste("Unstandardized within-person union:", paste(old_union, collapse = ", ")),
    paste("Standardized-within-person union:", paste(new_union, collapse = ", ")),
    paste("Dropped after training-fold z-scoring:", if (length(setdiff(old_union, new_union))) paste(setdiff(old_union, new_union), collapse = ", ") else "(none)"),
    paste("Added after training-fold z-scoring:", if (length(setdiff(new_union, old_union))) paste(setdiff(new_union, old_union), collapse = ", ") else "(none)"))
}
if (file.exists(preserved_audit)) {
  gz <- read.csv(preserved_audit, check.names = FALSE)
  gz_union <- sort(unique(gz$Variable_Name[gz$Step4_Empatica_Decision == "Retained" | gz$Step4_Eyetracker_Decision == "Retained"]))
  cmp <- c(cmp, paste("Historical global-z union (not overwritten):", paste(gz_union, collapse = ", ")))
}
writeLines(cmp, file.path(OUT_DIR, "H4_Step4_scale_comparison.txt"))
if (identical(Sys.getenv("H4_SELECTION_ONLY"), "1")) {
    selected_step2 <- final_filtration_df$Variable_Name[final_filtration_df$Step2_Decision == "Retained"]
    stopifnot(!any(grepl("^ucm_IR_|^ucm_.*_(SR|S)$|^ucm_AH$|^ucm_AIR_T_(bot|mid|top)$|IO_flag", selected_step2)), identical(grep("^ucm_WIND_",
        selected_step2, value = TRUE), "ucm_WIND_TWS"), identical(grep("^gvi_|^(plant|grass|tree)_phase_mean$", selected_step2,
        value = TRUE), "gvi_50m"), !any(is_acoustic_frequency(selected_step2)), all(c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_UTCI",
        "ucm_SND_dBA") %in% selected_step2))
    writeLines(c("Step 3: measurement categories; no analyst-selected model combinations.", "Step 4: union of separate Empatica and eye-tracker category-wise LASSO selections; retain an exposure selected by either family at minimum participant-held-out MSE. Pooled-response fits are diagnostics, not the union rule.",
        "Exploratory post-hoc screening; no outcome-inference model refitted. Family/domain samples can differ. Selected category lists are not a validated combined model.",
        paste("Empatica selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Empatica_Decision ==
            "Retained"], collapse = ", ")), paste("Eye-tracker selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Eyetracker_Decision ==
            "Retained"], collapse = ", ")), paste("Combined union selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Union_Decision ==
            "Retained"], collapse = ", ")), paste("Combined selected:", paste(final_filtration_df$Variable_Name[final_filtration_df$Step4_Combined_Decision ==
            "Retained"], collapse = ", ")), paste("Candidates:", paste(h4_retained_candidates, collapse = ", ")), "Current fits: equation 1 and the interaction equation in H4_models. Execution: scripts/h4_step5_equations.R."),
        FORMULA_TXT)
    render_audit_pdf(final_filtration_df, AUDIT_PDF, AUDIT_PNG)
    render_h4_faceted_flow(NULL)
    cat("Step-4 exploratory LASSO and audit render completed; inferential outcome models not fitted.\n")
    quit(save = "no", status = 0)
}
