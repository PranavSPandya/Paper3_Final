# H4: measurement audit, candidate equations, full-design collinearity checks and mixed models.
# Steps 1-3: measurement audit. Step 4: candidate equations and VIF/rank. Step 5: mixed models and inference.
if (identical(Sys.getenv("H4_STEP6_PRIMARY"), "1")) stop("The post-hoc UTCI reporting mode is retired; inspect the current Step 5 report.")

# ---- Setup: packages, paths and run guards ----
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
required_packages <- c("ggplot2", "gridExtra", "car")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) stop("Required R packages missing: ", paste(missing_packages, collapse = ", "), call. = FALSE)
grDevices::pdf(file = NULL)
PROJECT_ROOT <- resolve_project_root()
RAW_DATA_PATH <- file.path(PROJECT_ROOT, "output/merged_all_11participants_8min.csv")
# All H4 writes stay under this results folder; diagnostics remain in its _work subfolder.
RESULT_DIR <- file.path(PROJECT_ROOT, "output/statistical_analysis/results/H4_results")
OUT_DIR <- file.path(RESULT_DIR, "_work")
dir.create(OUT_DIR, recursive = TRUE, showWarnings = FALSE)
# Fail closed until temporal sensitivity is migrated to this consolidated fitter.
if (identical(Sys.getenv("H4_TIME_SENSITIVITY"), "1")) {
    stop("Temporal sensitivity is not migrated to the consolidated fitter. No models run: do not use the archived wrapper, which targets a removed script.", call. = FALSE)
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
H4_DOMAINS <- list(Acoustic = "ucm_SND_dBA", Thermal = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"), Index = c("ucm_HUMIDEX",
    "ucm_PET", "ucm_UTCI", "ucm_OPT"), Radiation = c("ucm_MRT", "ucm_SUN_Gh", "SVF_Holmer"),
    Pollution = c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg"), Light = c("lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg"),
    Greenery = "gvi_50m")
# ---- Step 4: retain candidates, specify alternatives, check complete equation designs ----
H4_HEAT_TERMS <- c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS", "ucm_HUMIDEX", "ucm_PET", "ucm_UTCI")
H4_STEP4_THERMAL_CATEGORIES <- c("Thermal", "Index")
h4_step4_candidates <- function(raw, audit) {
  eligible <- audit$Variable_Name[audit$Step3_Decision == "Retained"]
  audit <- audit[, !startsWith(names(audit), "Step4_PC1") & !names(audit) %in%
    c("Step4_Representative", "Step4_Representative_Rule", "Step4_Bootstrap_SelectionFreq"), drop = FALSE]
  audit$Step4_Domain <- NA_character_
  audit$Step4_Category_Role <- NA_character_
  audit$Step4_Decision <- "not eligible"
  audit$Step4_Restriction <- ""
  for (dom in names(H4_DOMAINS)) {
    vars <- intersect(H4_DOMAINS[[dom]], eligible)
    if (!all(vars %in% names(raw))) stop("Missing eligible Step 4 measurements: ", paste(setdiff(vars, names(raw)), collapse = ", "))
    i <- match(vars, audit$Variable_Name)
    audit$Step4_Domain[i] <- dom
    audit$Step4_Category_Role[i] <- if (dom %in% H4_STEP4_THERMAL_CATEGORIES) "thermal equation candidate" else "covariate candidate"
    audit$Step4_Decision[i] <- "retained candidate; no automatic deletion"
    audit$Step4_Restriction[i] <- if (dom == "Index") "One heat representation per equation" else
      if (dom == "Pollution") "One PM representation per candidate equation; all three jointly collinear" else "Full-equation VIF/rank review required"
  }
  stopifnot(setequal(eligible, audit$Variable_Name[!is.na(audit$Step4_Domain)]))
  audit
}
# ---- Report rendering ----
h4_step4_equation_lines <- function(audit_df, raw_df = NULL) {
  if (is.null(raw_df)) raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
  # Rebuild the Atmotube PM averages (not in the raw CSV) so any selected representative is present.
  for (v in c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg")) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  prep <- h4_step4_exposure_prep(audit_df, raw_df)
  catalog <- prep$catalog
  # Recompute the proposed designs; never attach historical fitted-model VIFs to new equations.
  outcomes <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
  checks <- do.call(rbind, lapply(outcomes, function(y)
    h4_run_gvif_diagnostic(prep, design_outcome = y, write = FALSE)$by_equation))
  gvif_hr <- do.call(rbind, lapply(split(checks, checks$equation_id), function(d)
    data.frame(equation_id = d$equation_id[1], max_vif_equivalent = max(d$max_vif_equivalent),
      min_rows = min(d$n_design_rows), max_rows = max(d$n_design_rows))))
  cat(sprintf("Step 4: %d outcome-equation designs; full rank %d/%d; VIF >= %s: %d; rows %d-%d.\n",
    nrow(checks), sum(checks$full_rank), nrow(checks), H4_SPEC$vif_threshold, sum(checks$max_vif_equivalent >= H4_SPEC$vif_threshold),
    min(checks$n_design_rows), max(checks$n_design_rows)))
  print(gvif_hr[, c("equation_id", "max_vif_equivalent", "min_rows", "max_rows")], row.names = FALSE)
  lines <- vapply(seq_len(nrow(catalog)), function(i) {
    eq <- catalog[i, ]; vars <- prep$thermal[[eq$heat_form]]
    heat <- paste(sub("^ucm_", "", vars), collapse = " + ")
    pm <- c(atmo_pm1_avg = "PM1", `atmo_pm2.5_avg` = "PM2.5", atmo_pm10_avg = "PM10")[[attr(vars, "pm")]]
    sprintf("Eq%d: %s + %s + (%s) x sound + MRT x sound + common terms", eq$equation_id, heat, pm, heat)
  }, character(1))
  list(lines = lines, max_vif = gvif_hr$max_vif_equivalent[match(catalog$equation_id, gvif_hr$equation_id)], checks = checks)

}

render_h4_faceted_flow <- function(audit_all = NULL) {
  PDF_PATH <- file.path(RESULT_DIR, "H4_Selection_Flow.pdf")
  library(grid)
  # Font sizes (pt) and borders; px = 1/72 in on this page. Border lwd 0.75 (R lwd 1 = 1/96 in, so 0.75 ~ 1 px at 72 dpi page units; 1 px at 96 dpi = 0.75 pt).
  FS <- list(title = 32, sub = 15, step = 20, head = 17, body = 15, small = 13, eqh = 18, eq = 16, foot = 9)
  LH <- function(fs) ceiling(fs * 1.2)   # tight line height (px) for a font size
  BORDER <- gpar(col = "#6f777c", fill = NA, lwd = 0.75)
  if (is.null(audit_all)) audit_all <- read.csv(OUT_CSV, stringsAsFactors = FALSE)
  raw <- read.csv(RAW_DATA_PATH, check.names = FALSE)
  for (v in names(average_sources)) raw[[v]] <- rowMeans(raw[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  audit_all <- h4_step4_candidates(raw, audit_all)
  audit <- audit_all
  stopifnot(!anyDuplicated(audit$Variable_Name))
  stopifnot(all(c("atmo_pm1_avg", "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg") %in% audit$Variable_Name))
  # Sensor label rules, applied in order: "name" matches the variable name, otherwise the current sensor text (case-insensitive).
  vn <- audit$Variable_Name
  sensor <- audit$Platform_Source
  atmo_raw <- grepl("^atmo_lys_atmotube_(left|right)__", vn)
  sensor_rules <- rbind(c("name", "^atmo_lys_atmotube_(left|right)__", "Atmo raw"), c("name", "^atmo_pm", "Atmo average"),
    c("name", "^lys_", "LYS average"), c("src", "UCM Backpack", "UCM"), c("atmotube", "Atmotube", "Atmo average"),
    c("src", "(^|[^A-Za-z])LYS([^A-Za-z]|$)", "LYS average"), c("name", "^atmo_lys_LYS1__", "LYS1 raw"), c("name", "^atmo_lys_LYS2__", "LYS2 raw"),
    c("src", "Eye-Level Panoramic Imagery|GVI", "GVI imagery"), c("src", "CamUp|DeepLab", "SVF imagery"), c("src", "Native-WAV|YAMNet", "Sound"),
    c("src", "Solar", "Solar"), c("name", "^empatica_", "Empatica"), c("name", "^eyetracker_", "Eye-tracker"), c("name", "^questionnaire_", "Questionnaire"))
  for (r in seq_len(nrow(sensor_rules))) {
    hit <- if (sensor_rules[r, 1] == "name") grepl(sensor_rules[r, 2], vn) else grepl(sensor_rules[r, 2], sensor, ignore.case = TRUE)
    sensor[hit & !(sensor_rules[r, 1] == "atmotube" & atmo_raw)] <- sensor_rules[r, 3]
  }
  sensor[grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit$Step1_Role)] <- "Metadata / QC"
  label_rules <- rbind(c("^atmo_lys_atmotube_(left|right)__atmotube_", "\\1 "), c("^atmo_lys_LYS([12])__lys_", "LYS\\1 "),
    c("^dominant_frequency_hz$", "dominant frequency (Hz)"), c("^spectral_centroid_hz$", "spectral centroid (Hz)"),
    c("^spectral_rolloff85_hz$", "spectral rolloff 85% (Hz)"), c("^freq_prop_([0-9]+)_([0-9]+)$", "band proportion \\1-\\2 Hz"),
    c("^octave_prop_([0-9]+)_([0-9]+)_hz$", "octave proportion \\1.\\2 Hz"), c("([0-9]+)\\.0 Hz$", "\\1 Hz"),
    c("(?i)^log_lys_", "log "), c("(?i)^ucm_", ""), c("(?i)^atmo_", ""), c("(?i)^lys_", ""), c("(?i)^gvi_", "GVI "),
    c("(?i)^tree_", "Tree "), c("(?i)^grass_", "Grass "), c("(?i)^plant_", "Plant "),
    c("^lys_atmotube_(left|right)__atmotube_", "\\1 "), c("^lys_LYS([12])__lys_", "LYS\\1 "),
    c("^(empatica|eyetracker|questionnaire)_", ""), c("(?i)_avg$", " avg"))
  column_label <- audit$Variable_Name
  for (r in seq_len(nrow(label_rules))) column_label <- sub(label_rules[r, 1], label_rules[r, 2], column_label, perl = TRUE)
  audit$Sensor <- sensor
  audit$Column <- trimws(gsub("_", " ", column_label))
  audit$Column <- sub("^background ", "", audit$Column)
  audit$Column[audit$Variable_Name == "SVF_Holmer"] <- "SVF"
  audit$Column <- sub("^hrv fd 5min ", "HRV 5min ", audit$Column)
  audit$Column <- sub("response index within participant", "response index", audit$Column)
  audit$Column <- sub(" seconds$", " (s)", audit$Column)
  audit$Column[match(c("ucm_Date", "atmo_lys_Date", "eyetracker_Date"), audit$Variable_Name, nomatch = 0L)] <- c("Date (UCM)", "Date (Atmo/LYS)", "Date (eye)")[c("ucm_Date", "atmo_lys_Date", "eyetracker_Date") %in% audit$Variable_Name]
  audit <- audit[order(audit$Sensor, audit$Column), ]
  step2 <- audit[audit$Step2_Status == "Retained", ]
  expected_raw_sources <- c(paste0("atmo_lys_atmotube_", rep(c("left", "right"), 3), "__atmotube_pm", rep(c("1", "2.5", "10"), each = 2)), paste0("atmo_lys_LYS", rep(1:2, each = 3), "__lys_", rep(c("lux", "medi", "kelvin"), 2)),
    paste0("atmo_lys_LYS", rep(1:2, each = 7), "__lys_", rep(c("b'", "g'", "r'", "rgbb", "rgbg", "rgbir", "rgbr"), 2)))
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
  grDevices::pdf(file = NULL, pointsize = FS$body, family = "Helvetica")
  label_width <- strwidth(longest_label, units = "inches")
  dev.off()
  all_titles <- c("Inventory (000)", "Representatives (000)", "Domain Grouping (000)", "Equations + design VIF", "(12 exploratory candidates)")
  title_w <- max(strwidth(unlist(strsplit(all_titles, "\n")), units = "inches", cex = FS$step / FS$body, font = 2)) * 1.3 + .25
  widths <- vapply(sensor_order, function(s) ncolumns[s] * (max(c(.8, label_width[audit$Sensor == s])) * 1.04 + .18), numeric(1))
  page_width <- title_w + sum(widths) + .1
  lefts <- (title_w + cumsum(c(0, head(widths, -1)))) / page_width
  sensor_width <- widths / page_width
  sensor_id <- match(audit$Sensor, sensor_order)
  audit$X <- lefts[sensor_id] + .06 / page_width +
    audit$Subcolumn * sensor_width[sensor_id] / ncolumns[sensor_id]
  stages <- list(audit, audit[audit$Step2_Status == "Retained", ], audit[audit$Step3_Decision == "Retained", ])
  stopifnot(all(candidate_names %in% step2$Variable_Name), setequal(stages[[3]]$Variable_Name, step2$Variable_Name))
  stopifnot(all(vapply(stages, function(d) all(d$X == audit$X[match(d$Variable_Name, audit$Variable_Name)]), logical(1))))
  titles <- c(paste0("STEP 1\nInventory (", nrow(audit), ")"), paste0("STEP 2\nRepresentatives (", nrow(step2), ")\nRules + coverage"),
    paste0("STEP 3\nDomain Grouping (", nrow(stages[[3]]), ")"))
  max_rows <- vapply(stages, function(d) as.integer(max(c(1L, d$Row + 1L))), integer(1))
  max_rows[-1] <- vapply(stages[-1], function(d) as.integer(max(c(1L, table(interaction(d$Sensor, d$Subcolumn, drop = TRUE))))), integer(1))
  row_px <- c(LH(FS$small), LH(FS$body), LH(FS$body))
  title_px <- vapply(titles, function(t) length(strsplit(t, "\n")[[1]]) * LH(FS$step), numeric(1))
  dn <- names(H4_DOMAINS)
  display_domains <- H4_DOMAINS[append(setdiff(dn, "Acoustic"), "Acoustic", after = match("Index", setdiff(dn, "Acoustic")))]
  n3 <- max(lengths(lapply(display_domains, intersect, candidate_names))) + 1L
  content_px <- c(max_rows[1] * row_px[1], max_rows[2] * row_px[2], LH(FS$head) + n3 * LH(FS$body))
  band_height <- pmax(title_px, content_px) + 20
  step5 <- h4_step4_equation_lines(audit_all, raw)
  n_eq <- length(step5$lines)
  step5_height <- max(3 * LH(FS$step), n_eq * LH(FS$eq)) + 4 * LH(FS$small) + 14
  head_px <- 8 + LH(FS$title) + LH(FS$sub) + 2 * LH(FS$head) + 6
  page_height <- head_px + sum(band_height) + step5_height + 6
  band_top <- page_height - head_px - c(0, head(cumsum(band_height), -1))
  text_at <- function(x, y, label, size = 18, bold = FALSE, color = "#222222")
    grid.text(label, x = x, y = y, just = c("left", "top"), gp = gpar(fontsize = size, fontface = if (bold) "bold" else "plain", col = color))
  grDevices::cairo_pdf(PDF_PATH, width = page_width, height = page_height / 72, onefile = TRUE)
  grid.newpage()
  bx <- function(top_px, h_px) grid.rect(x = unit(.003, "npc"), y = unit(top_px / page_height, "npc"), width = unit(.994, "npc"),
    height = unit(h_px / page_height, "npc"), just = c("left", "top"), gp = BORDER)
  text_at(.06 / page_width, 1 - 8 / page_height, "H4 environmental-variable selection", FS$title, TRUE)
  text_at(.06 / page_width, 1 - (8 + LH(FS$title)) / page_height, "Step 4: specify exploratory candidate equations and check full-design VIF/rank; no PCA/LASSO or automatic variable deletion.", FS$sub)
  pending_svf <- sum(audit$Step2_Status == "PENDING SVF PROCESSING / MERGE")
  for (s in seq_along(sensor_order)) {
    heading <- sub(" (raw|average|imagery)$", "\n\\1", sensor_order[s])
    text_at(lefts[s] + .06 / page_width, 1 - (8 + LH(FS$title) + LH(FS$sub) + 4) / page_height, heading, FS$head, TRUE)
  }
  for (k in seq_along(stages)) {
    d <- stages[[k]]
    if (k >= 2L && nrow(d) > 0L) d$Row <- ave(seq_len(nrow(d)), interaction(d$Sensor, d$Subcolumn), FUN = function(x) seq_along(x) - 1L)
    bx(band_top[k], band_height[k])
    grid.text(titles[k], x = .06 / page_width, y = (band_top[k] - 6) / page_height,
      just = c("left", "top"), gp = gpar(fontsize = FS$step, fontface = "bold", col = "#222222", lineheight = 1.2))
    if (k == 2L && pending_svf > 0L) text_at(lefts[match("SVF imagery", sensor_order)] + .12 / page_width, band_top[k] / page_height,
      "SVF", FS$body)
    if (k == 3L) {
      category_width <- (page_width - title_w) / length(display_domains)
      for (g in seq_along(display_domains)) {
        domain <- names(display_domains)[g]
        category_x <- (title_w + (g - 1L) * category_width) / page_width
        variables <- intersect(display_domains[[g]], candidate_names)
        labels <- audit$Column[match(variables, audit$Variable_Name)]
        y_b <- band_top[k] - 6
        heading <- domain
        text_at(category_x, y_b / page_height, heading, FS$head, TRUE)
        for (j in seq_along(labels)) text_at(category_x, (y_b - LH(FS$head) - LH(FS$body) * (j - 1L)) / page_height, labels[j], FS$body)
        if (domain == "Radiation" && pending_svf > 0L) text_at(category_x,
          (y_b - LH(FS$head) - LH(FS$body) * length(labels)) / page_height, "SVF", FS$body)
      }
    } else for (j in seq_len(nrow(d))) {
      label <- d$Column[j]
      if (k >= 2L && d$Variable_Name[j] %in% H4_SPEC$hrv_log) label <- paste0("log(", label, ")")
      if (k == 3L) label <- paste0(label, " [", d$Measurement_Code[j], "]")
      text_at(d$X[j], (band_top[k] - 6 - d$Row[j] * row_px[k]) / page_height, label, if (k == 1L) FS$small else FS$body)
    }
  }
  x0 <- title_w / page_width
  draw_step_block <- function(title, lines, band_h, y_top) {
    bx(y_top, band_h)
    grid.text(title, x = .06 / page_width, y = (y_top - 6) / page_height,
      just = c("left", "top"), gp = gpar(fontsize = FS$step, fontface = "bold", lineheight = 1.2))
    y <- y_top - 6
    vif_lab <- sprintf("max VIF = %.2f", step5$max_vif)
    width_npc <- function(t, fs) max(vapply(t, function(x) convertWidth(grobWidth(textGrob(x, gp = gpar(fontsize = fs))), "npc", TRUE), 0))
    avail <- .985 - width_npc(vif_lab, FS$eq) - 40 / 72 / page_width - x0
    fs5 <- FS$eq
    while (fs5 > 8 && width_npc(lines, fs5) > avail) fs5 <- fs5 - 0.5
    for (j in seq_along(lines)) {
      text_at(x0, y / page_height, lines[j], fs5)
      grid.text(vif_lab[j], x = .985, y = y / page_height, just = c("right", "top"), gp = gpar(fontsize = FS$eq, col = "#222222"))
      y <- y - LH(FS$eq)
    }
    text_at(x0, y / page_height, "Common main terms: sound + MRT + SUN_Gh + SVF + lux + kelvin + GVI + exertion + Phase (sum-to-zero). All interactions retain their main effects.", FS$small, color = "#444444")
    y <- y - LH(FS$small)
    text_at(x0, y / page_height, sprintf("Rank: %d/%d designs full rank; %d-%d complete rows. Exposures: bout-centered, scaled by pooled SD; participant is the independent cluster.",
      sum(step5$checks$full_rank), nrow(step5$checks), min(step5$checks$n_design_rows), max(step5$checks$n_design_rows)), FS$small, color = "#444444")
    y <- y - LH(FS$small)
    text_at(x0, y / page_height, "VIF: maximum across 26 outcome-specific designs, including interactions and grouped PhaseID; >=5 is a review flag, not automatic deletion. Candidate equations are NOT fitted results.", FS$small, color = "#444444")
    text_at(x0, (y - LH(FS$small)) / page_height, "STEP 5: fit the specified equations, assess covariance/residuals and multiple testing. Previous coefficients belong to the previous four-equation specification.", FS$small, color = "#444444")
  }
  draw_step_block(paste0("STEP 4\nEquations + design VIF\n(", n_eq, " exploratory candidates)"), step5$lines, step5_height, step5_height + 3)
  dev.off()
  # Refresh only the figure hash and label its scope; fitted tables still identify their original run.
  manifest_path <- file.path(OUT_DIR, "H4_models", "H4_run_complete.csv")
  if (file.exists(manifest_path)) {
    manifest <- read.csv(manifest_path, stringsAsFactors = FALSE)
    figure_row <- basename(manifest$file) == basename(PDF_PATH)
    if (any(figure_row)) {
      manifest$file[figure_row] <- normalizePath(PDF_PATH, winslash = "/", mustWork = TRUE)
      manifest$md5[figure_row] <- unname(tools::md5sum(PDF_PATH))
      if (!"artifact_scope" %in% names(manifest)) manifest$artifact_scope <- "fitted run; consult original code_md5"
      manifest$artifact_scope[figure_row] <- "current Step 4 candidate designs only; not evidence of a new model fit"
      write.csv(manifest, manifest_path, row.names = FALSE)
    }
  }
  cat("Verified stage counts:", paste(vapply(stages, nrow, integer(1)), collapse = " -> "), ". Fixed horizontal positions; zero connectors.\n")
  cat("Saved figure (1 page):", PDF_PATH, "\n")
}
render_audit_pdf <- function(audit_df, output_path, preview_path = NULL) {
    collapse_group <- function(df, mask, new_name) {
        if (sum(mask) <= 1) return(df)
        df$Variable_Name[which(mask)[1]] <- sprintf("%s (%d variables)", new_name, sum(mask))
        df[!(mask & seq_len(nrow(df)) != which(mask)[1]), ]
    }
    audit_df <- collapse_group(audit_df, grepl("yamnet_class", audit_df$Variable_Name), "YAMNet Audio Classes")
    audit_df <- collapse_group(audit_df, grepl("^octave_prop", audit_df$Variable_Name), "Octave Frequency Bands")
    is_environment <- audit_df$Step1_Role == "Environmental Stressor Candidates (X_env)"
    is_physio <- grepl("Physiological Sensor Outcomes", audit_df$Step1_Role)
    is_psych <- grepl("Psychological Survey Outcomes", audit_df$Step1_Role)
    is_outcome <- is_physio | is_psych
    is_metadata_qc <- grepl("Metadata|Demographics|QC|Provenance|Signal Quality", audit_df$Step1_Role) | audit_df$Final_Filtration_Outcome == "QC METRIC"
    is_movement <- grepl("Movement", audit_df$Step1_Role)
    role <- ifelse(is_environment, "Environmental Candidate (X)", ifelse(is_physio, "Outcome Y - Physiological", ifelse(is_psych,
        "Outcome Y - Psychological", ifelse(is_movement, "Movement Covariate (Z)", ifelse(is_metadata_qc, "Metadata / QC - Not Candidate",
            "Outside Declared H4 Set")))))
    step2 <- ifelse(is_environment & audit_df$Step2_Status != "-", ifelse(audit_df$Step2_Decision == "Retained", "Eligible", "Not advanced"),
        ifelse(is_outcome, "Analyzed as outcome Y", ifelse(is_movement, "Exertion covariate proxy", "-")))
    candidate <- audit_df$H4_Screening_Candidate == "Yes"
    step3 <- ifelse(candidate, paste(audit_df$Measurement_Code, audit_df$Measurement_Type), "-")
    final_role <- ifelse(candidate, "Candidate; model specification pending", ifelse(is_physio, "Physiological outcome",
        ifelse(is_psych, "Psychological outcome", ifelse(is_movement, "Movement covariate", audit_df$Final_Filtration_Outcome))))
    clean_source <- audit_df$Platform_Source
    for (r in list(c("YAMNet", "YAMNet Audio"), c("Atmo", "Atmotube"), c("UCM Backpack", "UCM Backpack"), c("Empatica", "Empatica"),
        c("LYS", "LYS Button"), c("Pupil", "Eye-Tracker"), c("Questionnaire|Surveys", "Questionnaire"),
        c("Imagery|GVI|DeepLabV3", "Street View / GIS"), c("WAV Spectral", "Acoustic Spectral")))
        clean_source <- sub(paste0("^.*(", r[1], ").*$"), r[2], clean_source)
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
    wrap_widths <- c(6L, 20L, 42L, 28L, 34L, 34L, 38L)
    column_widths <- c(0.5, 1.8, 3.4, 2.4, 2.8, 2.8, 3.2)
    grDevices::cairo_pdf(output_path, width = 17, height = 11, onefile = TRUE, family = "sans")
    on.exit(grDevices::dev.off(), add = TRUE)
    subtitle_text <- paste("Step 1: Complete column inventory and analytical roles.", "Step 2: Existing sensor consolidation and exposure-representation rules, unchanged.",
        "Step 3: Measurement provenance and shared-design diagnostics; all Step-2 eligible fields remain candidates.", "No VIF elimination stage. Current fitted equation and diagnostics are in H4_Step5_Equations_Checks.txt.",
        sep = "\n")
    for (page in seq_along(page_rows)) {
        rows <- page_rows[[page]]
        page_df <- table_df[rows, , drop = FALSE]
        for (column in seq_len(ncol(page_df))) {
            page_df[[column]] <- vapply(as.character(page_df[[column]]), function(value)
                paste(strwrap(value, width = wrap_widths[column]), collapse = "\n"), character(1))
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
            page, length(page_rows)), x = 0.5, y = 0.03, gp = grid::gpar(fontsize = 8, col = "gray40"))
    }
    invisible(length(page_rows))
}
# ---- Analysis specification and input validation ----
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
# Outcome transformations follow scripts/Normalization_H1toH4.ipynb (and _physio.csv): HRV = ln(x) for x > 0 (rows <= 0
# dropped), never ln(1 + x); other outcomes native (Laborde, Mosley & Thayer 2017; Task Force 1996).
H4_SPEC$outcome_transform <- setNames(ifelse(H4_SPEC$all_outcomes %in% H4_SPEC$hrv_log, "natural log", "native"), H4_SPEC$all_outcomes)
H4_SPEC$exposure_centered <- c(ucm_UTCI = "PC_UTCI", ucm_SND_dBA = "PC_dBA", atmo_pm2.5_avg = "PC_PM25", lys_lux_avg = "PC_Lux",
    gvi_50m = "PC_GVI")
H4_SPEC$bilateral_sources <- list(atmo_pm2.5_avg = c("atmo_lys_atmotube_left__atmotube_pm2.5", "atmo_lys_atmotube_right__atmotube_pm2.5"),
    lys_lux_avg = c("atmo_lys_LYS1__lys_lux", "atmo_lys_LYS2__lys_lux"))
average_sources <- list(atmo_pm1_avg = c("atmo_lys_atmotube_left__atmotube_pm1", "atmo_lys_atmotube_right__atmotube_pm1"),
    atmo_pm2.5_avg = H4_SPEC$bilateral_sources$atmo_pm2.5_avg, atmo_pm10_avg = c("atmo_lys_atmotube_left__atmotube_pm10",
        "atmo_lys_atmotube_right__atmotube_pm10"), lys_lux_avg = H4_SPEC$bilateral_sources$lys_lux_avg, lys_medi_avg = c("atmo_lys_LYS1__lys_medi",
        "atmo_lys_LYS2__lys_medi"), lys_kelvin_avg = c("atmo_lys_LYS1__lys_kelvin", "atmo_lys_LYS2__lys_kelvin"))
h4_mean <- function(x) {
  if (!is.numeric(x) && !is.logical(x) && !is.factor(x)) return(NA_real_)
  x <- as.numeric(x)
  if (any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
}
h4_single_questionnaire_response <- function(x, outcome, participant_phase) {
  values <- unique(x[is.finite(x)])
  if (length(values) > 1L) stop("Inconsistent duplicated questionnaire values for ", outcome, " in ", participant_phase, ": ",
    paste(values, collapse = ", "), call. = FALSE)
  if (length(values)) as.numeric(values[1]) else NA_real_
}
h4_person_mean_center <- function(x, id) ave(as.numeric(x), id, FUN = function(v) if (any(is.finite(v))) v - mean(v[is.finite(v)]) else rep(NA_real_, length(v)))
h4_prepare_data <- function(raw) {
    required <- unique(c("ParticipantID", "PhaseID", "Datetime", "empatica_hrv_fd_5min_available", unlist(H4_SPEC$bilateral_sources),
        names(H4_SPEC$exposure_centered)[c(1, 2, 5)], H4_SPEC$all_outcomes, "empatica_vector_magnitude"))
    missing <- setdiff(required, names(raw))
    if (length(missing)) stop("Required H4 input columns missing: ", paste(missing, collapse = ", "))
    raw <- raw[raw$ParticipantID %in% H4_SPEC$participants & raw$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
    for (v in H4_SPEC$all_outcomes) {
        raw[[v]] <- as.numeric(raw[[v]])
        raw[[v]][!is.finite(raw[[v]])] <- NA_real_
    }
    for (v in H4_SPEC$hrv_log) raw[[v]][!is.na(raw[[v]]) & raw[[v]] <= 0] <- NA_real_
    ranges <- list(questionnaire_current_comfort_1_7 = 1:7, questionnaire_pleasantness_1_5 = 1:5)
    for (v in H4_SPEC$ordinal) if (any(!is.na(raw[[v]]) & !raw[[v]] %in% ranges[[v]])) stop("Ordinal values outside declared scale: ", v)
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
    if (length(setdiff(grid$ParticipantPhase, keys))) stop("Required participant-phase cells absent: ", paste(setdiff(grid$ParticipantPhase, keys), collapse = ", "))
    if (anyDuplicated(raw[, c("ParticipantID", "PhaseID", "Datetime")])) stop("Duplicate 10-second timestamps in input.")
    groups <- split(seq_len(nrow(raw)), factor(keys, levels = grid$ParticipantPhase))
    variables <- unique(c("ucm_UTCI", "ucm_SND_dBA", "atmo_pm2.5_avg", "lys_lux_avg", "gvi_50m", "empatica_vector_magnitude",
        H4_SPEC$all_outcomes))
    coverage <- lapply(variables, function(v) {
        questionnaire <- v %in% H4_SPEC$questionnaire
        n <- vapply(groups, function(ix) if (questionnaire) length(unique(raw[[v]][ix][is.finite(raw[[v]][ix])])) else sum(is.finite(raw[[v]][ix])), integer(1))
        grid[[v]] <<- vapply(groups, function(ix) if (questionnaire) h4_single_questionnaire_response(raw[[v]][ix], v,
            paste(raw$ParticipantID[ix[1]], raw$PhaseID[ix[1]], sep = "::")) else h4_mean(raw[[v]][ix]), numeric(1))
        expected <- if (questionnaire) 1L else H4_SPEC$expected_epochs
        data.frame(ParticipantID = grid$ParticipantID, PhaseID = grid$PhaseID,
            Measure_Type = if (questionnaire) "Questionnaire response" else if (v %in% H4_SPEC$all_outcomes) "Outcome" else "Exposure",
            Measure = v, N_valid = n, N_expected = expected, Coverage_pct = round(100 * n/expected, 1),
            Coverage_pass = if (questionnaire) n == 1L else n > 0L, stringsAsFactors = FALSE)
    })
    coverage <- do.call(rbind, coverage)
    if (any(coverage$Measure_Type == "Exposure" & !coverage$Coverage_pass)) stop("An exposure has no valid phase observations.")
    if (any(lengths(groups) != H4_SPEC$expected_epochs))
        warning("Matched-window row counts differ from declared denominator ", H4_SPEC$expected_epochs, ": ", paste(names(groups)[lengths(groups) !=
            H4_SPEC$expected_epochs], collapse = ", "), call. = FALSE)
    for (v in c("atmo_pm2.5_avg", "ucm_SND_dBA", "lys_lux_avg")) if (any(grid[[v]] < 0, na.rm = TRUE)) stop("Negative phase-mean values require review: ", v)
    if (any(grid$gvi_50m < 0 | grid$gvi_50m > 100, na.rm = TRUE)) stop("GVI outside 0-100%.")
    list(data = grid, coverage = coverage)
}
PARTICIPANTS <- H4_SPEC$participants
CORE_PHASES <- H4_SPEC$phases
SOUND_QC_COLUMNS <- c("segment", "end_time_s", "window_duration_s", "is_complete_10s_window", "phase_start_offset_s", "yamnet_frame_count", "yamnet_threshold",
    "original_sample_rate_hz", "frequency_analysis_min_hz", "frequency_analysis_max_hz", "frequency_analysis_full_20khz_coverage")
SOUND_CATEGORY_PROP_COLUMNS <- c("wind_prop", "rural_natural_prop", "vehicle_prop", "urban_manmade_neutral_prop", "urban_manmade_positive_prop", "urban_manmade_negative_prop", "mechanisms_prop", "unidentify_prop")
is_sound_semantic <- function(x) x %in% c("category", SOUND_CATEGORY_PROP_COLUMNS, sub("_prop$", "_score", setdiff(SOUND_CATEGORY_PROP_COLUMNS, "unidentify_prop"))) | grepl("^(sound_(prop|score)_|yamnet_class_[0-9]{3}_.+_(mean_score|prop)$)", x)
is_acoustic_frequency <- function(x) grepl("^(dominant_frequency_hz|spectral_centroid_hz|spectral_rolloff85_hz|freq_prop_|octave_prop_)", x)
SVF_EXPOSURE_COLUMNS <- c("Sky_%", "SVF_Holmer", "Tree_%", "Plant_%", "Grass_%", "Combined_Vegetation_%", "Building_%", "Wall_%")
SVF_QC_COLUMNS <- c("Filename", "Timestamp", "Camera", "Calibration", "Calibration_Table", "Run_Config_Signature", "Calibration_QC",
    "Calibration_Ref_Radius_px", "Raw_Lens_Radius_px", "Rectified_Lens_Radius_px", "Square_Hemisphere_Crop", "SVF_Method",
    "SVF_Rings", "Pitch_Roll_Correction", "Model", "Image_Path", "Segmented_Image_Path", "telemetry_matched", "Manual_Mask_Path",
    "Manual_Sky_IoU", "Manual_Sky_Dice", "Manual_Pixel_Accuracy", "Manual_SVF_Holmer", "SVF_Abs_Error_vs_Manual")
is_svf_exposure <- function(x) x %in% SVF_EXPOSURE_COLUMNS
EXPECTED_SOUND_FREQUENCY_COLUMNS <- c("dominant_frequency_hz", "spectral_centroid_hz", "spectral_rolloff85_hz", "freq_prop_20_125",
    "freq_prop_125_1000", "freq_prop_1000_4000", "freq_prop_4000_8000", "freq_prop_8000_20000", "octave_prop_31_5_hz", "octave_prop_63_0_hz",
    "octave_prop_125_0_hz", "octave_prop_250_0_hz", "octave_prop_500_0_hz", "octave_prop_1000_0_hz", "octave_prop_2000_0_hz",
    "octave_prop_4000_0_hz", "octave_prop_8000_0_hz")
H4_PHASE_SUM_COLS <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")

# ---- Equation labels, phase contrasts and design diagnostics ----
h4_spell_term <- function(term) {
  pretty <- c(ucm_SND_dBA = "sound", SND_dBA = "sound", gvi_50m = "GVI", Clearness_Index = "clearness (excluded in Step 2 as derived)",
    lys_lux_avg = "lux", lys_kelvin_avg = "colour temperature", ucm_SUN_Gh = "global solar radiation", ucm_WIND_AWS = "apparent wind",
    empatica_vector_magnitude = "exertion (vector magnitude)", ucm_AIR_temp = "air temperature", ucm_AIR_RH = "humidity",
    ucm_MRT = "mean radiant temperature", ucm_HUMIDEX = "HUMIDEX", ucm_PET = "PET", ucm_UTCI = "UTCI",
    setNames(paste("Phase:", c("WalkG", "WalkU", "BikeG", "BikeU"), "vs mean of phases"), paste0("PhaseSum", c("WalkG", "WalkU", "BikeG", "BikeU"))))
  parts <- strsplit(term, ":", fixed = TRUE)[[1]]
  parts <- ifelse(parts %in% names(pretty), pretty[parts], parts)
  if (length(parts) > 1L) paste0("(", parts[1], " x ", parts[2], ")") else parts
}
h4_format_grouped_terms <- function(terms, thermal_vars, block) {
  # Display groups: sound | other covariates | thermal | phase.
  terms <- unique(terms)
  is_sound <- terms == "ucm_SND_dBA" | (block %in% c("heat_x_sound", "both_products") & grepl(":SND_dBA", terms, fixed = TRUE))
  is_phase <- startsWith(terms, "Phase")
  nonthermal_order <- c("ucm_SUN_Gh", "gvi_50m", "lys_kelvin_avg", "lys_lux_avg")
  other <- terms[!is_sound & !is_phase & !terms %in% thermal_vars]
  groups <- list(c(intersect("ucm_SND_dBA", terms[is_sound]), sort(setdiff(terms[is_sound], "ucm_SND_dBA"))),
    c(intersect(nonthermal_order, other), sort(setdiff(other, nonthermal_order))), intersect(thermal_vars, terms),
    c(intersect(H4_PHASE_SUM_COLS, terms[is_phase]), sort(setdiff(terms[is_phase], H4_PHASE_SUM_COLS))))
  paste(vapply(Filter(length, groups), function(ts) paste(vapply(ts, h4_spell_term, character(1)), collapse = " + "), character(1)), collapse = "  |  ")
}

h4_vif_per_term <- function(X) {
  # Fox & Monette (1992) car::vif on the design only (not an outcome fit). Each three-column PhaseID span is one term;
  # the score GVIF^(1/df) is the square of car's GVIF^(1/(2*df)).
  X <- as.matrix(X)
  if (!ncol(X)) return(setNames(numeric(), character()))
  nms <- colnames(X)
  groups <- nms
  groups[startsWith(nms, "PhaseSum")] <- "PhaseID"
  ix <- grepl(":PhaseSum", nms, fixed = TRUE)
  groups[ix] <- paste0(sub(":PhaseSum.*$", "", nms[ix]), ":PhaseID")
  terms <- unique(groups)
  dfs <- vapply(terms, function(g) sum(groups == g), integer(1))
  if (any(dfs[grepl("PhaseID$", terms)] != 3L)) stop("Incomplete PhaseID contrast block")
  gvif <- rep(Inf, length(terms))
  if (all(is.finite(X)) && nrow(X) > ncol(X) + 1L && qr(cbind(1, X))$rank == ncol(X) + 1L) {
    if (length(terms) == 1L) gvif[] <- 1 else {
      # The residual scale cancels in car's coefficient correlation; a deterministic dummy response supplies the lm interface.
      d <- data.frame(.h4_response = sin(seq_len(nrow(X))) + cos(seq_len(nrow(X)) * sqrt(2)))
      for (i in seq_along(terms)) {
        block <- X[, groups == terms[i], drop = FALSE]
        d[[paste0("T", i)]] <- if (ncol(block) == 1L) block[, 1L] else I(block)
      }
      result <- car::vif(stats::lm(.h4_response ~ ., data = d))
      keys <- paste0("T", seq_along(terms))
      gvif <- if (is.matrix(result)) result[keys, "GVIF"] else result[keys]
    }
  }
  score <- setNames(as.numeric(gvif)^(1 / dfs), terms)
  attr(score, "gvif_table") <- data.frame(term = terms, GVIF = as.numeric(gvif), Df = dfs,
    GVIF_root = as.numeric(gvif)^(1 / (2 * dfs)), VIF_equivalent = as.numeric(score))
  score
}

h4_phase_design <- function(phase) {
  phase <- factor(as.character(phase), levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
  if (anyNA(phase)) stop("Unknown or missing H4 PhaseID")
  design <- stats::model.matrix(~ phase, contrasts.arg = list(phase = stats::contr.sum(4L)))[, -1L, drop = FALSE]
  colnames(design) <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
  design
}
h4_phase_contrast_weights <- function() {
  # Equal weighting of the two modes/environments, not observed row frequencies.
  w <- rbind(Urban_minus_Green = c(-.5, .5, -.5, .5), Urban_minus_Green_Walk = c(-1, 1, 0, 0), Urban_minus_Green_Bike = c(0, 0, -1, 1),
             Bike_minus_Walk = c(-.5, -.5, .5, .5), Mode_by_Environment = c(1, -1, -1, 1))
  w %*% h4_phase_design(c("WalkG", "WalkU", "BikeG", "BikeU"))
}

h4_phase_contrasts <- function(fit, cluster) {
  beta <- nlme::fixef(fit)
  weights <- h4_phase_contrast_weights()
  V <- clubSandwich::vcovCR(fit, cluster = cluster, type = "CR2")
  do.call(rbind, lapply(seq_len(nrow(weights)), function(i) {
    L <- matrix(0, 1L, length(beta), dimnames = list(NULL, names(beta)))
    stopifnot(all(colnames(weights) %in% names(beta)))
    L[1L, colnames(weights)] <- weights[i, ]
    test <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
    estimate <- as.numeric(L %*% beta)
    se <- sqrt(as.numeric(L %*% V %*% t(L)))
    df <- as.numeric(test$df_denom)
    if (!is.finite(df) || df <= 0 || !is.finite(se)) stop("Invalid phase-contrast CR2 inference")
    data.frame(contrast = rownames(weights)[i], estimate = estimate, se = se, df = df, low_df_flag = df < 4,
               ci_low = estimate - stats::qt(.975, df) * se, ci_high = estimate + stats::qt(.975, df) * se, p_value = as.numeric(test$p_val), stringsAsFactors = FALSE)
  }))
}

# ---- Step 4: exposure preparation and candidate-equation catalog ----
h4_step4_exposure_prep <- function(audit_df, raw_df) {
  for (v in setdiff(c("lys_lux_avg", "lys_kelvin_avg", "lys_medi_avg"), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  raw_df <- raw_df[raw_df$ParticipantID %in% H4_SPEC$participants & raw_df$PhaseID %in% H4_SPEC$phases, , drop = FALSE]
  if (!"empatica_hrv_fd_5min_available" %in% names(raw_df)) stop("Missing HRV availability flag")
  available <- tolower(as.character(raw_df$empatica_hrv_fd_5min_available)) %in% c("true", "1")
  for (v in H4_SPEC$hrv_fd) raw_df[[v]][!available] <- NA_real_
  audit_df <- h4_step4_candidates(raw_df, audit_df)
  exertion_col <- "empatica_vector_magnitude"
  if (!exertion_col %in% names(raw_df)) stop("Missing exertion covariate: ", exertion_col)
  reps <- audit_df$Variable_Name[audit_df$Step4_Category_Role %in% "covariate candidate"]
  nonthermal <- unique(c(reps, exertion_col))
  agreed_not_retained <- character()
  rep_tab <- audit_df[!is.na(audit_df$Step4_Domain), c("Step4_Domain", "Variable_Name", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")]
  base_heat <- list(`AIR_temp + AIR_RH + WIND_AWS` = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_WIND_AWS"), HUMIDEX = "ucm_HUMIDEX", PET = "ucm_PET", UTCI = "ucm_UTCI")
  pm <- intersect(H4_DOMAINS$Pollution, reps)
  if (length(pm) != 3L || !all(c("ucm_MRT", "ucm_SND_dBA") %in% reps)) stop("Step 4 requires three PM alternatives, MRT and sound")
  thermal <- list()
  for (h in names(base_heat)) for (p in pm) {
    vars <- base_heat[[h]]
    attr(vars, "pm") <- p
    thermal[[paste(h, p, sep = " / ")]] <- vars
  }
  selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))
  # Within-bout centering (Enders & Tofighi 2007; Curran & Bauer 2011): each exposure minus its bout (participant x
  # phase) mean, divided by the SD of that deviation. PhaseID sum-to-zero effects carry the condition means.
  bout_id <- paste(raw_df$ParticipantID, raw_df$PhaseID, sep = "::")
  centered <- raw_x <- as.matrix(raw_df[, selected, drop = FALSE])
  storage.mode(centered) <- storage.mode(raw_x) <- "double"
  for (j in seq_len(ncol(raw_x))) {
    finite <- is.finite(raw_x[, j])
    centered[, j] <- raw_x[, j] - unname(tapply(raw_x[finite, j], bout_id[finite], mean)[bout_id])
    sdx <- sd(centered[finite, j])
    if (is.finite(sdx) && sdx > 0) centered[, j] <- centered[, j] / sdx
  }
  make_design <- function(z, vars, phase, test = "Noise") {
    if (nrow(z) != length(phase)) stop("PhaseID/design row mismatch")
    covars <- setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm")))
    x <- cbind(z[, unique(c(covars, vars)), drop = FALSE], h4_phase_design(phase))
    stopifnot(sum(H4_DOMAINS$Pollution %in% colnames(x)) == 1L, !anyDuplicated(colnames(x)))
    if (test != "Noise") return(x)
    interaction_vars <- unique(c(vars, "ucm_MRT"))
    sound <- z[, interaction_vars, drop = FALSE] * z[, "ucm_SND_dBA"]
    colnames(sound) <- paste0(interaction_vars, ":SND_dBA")
    cbind(x, sound)
  }
  catalog <- h4_equation_catalog(nonthermal, thermal)
  list(raw_df = raw_df, nonthermal = nonthermal, thermal = thermal, selected = selected,
       centered = centered, make_design = make_design, catalog = catalog, agreed_common = exertion_col,
       agreed_not_retained = agreed_not_retained, rep_tab = rep_tab)
}

h4_equation_catalog <- function(nonthermal, thermal) {
  out <- do.call(rbind, lapply(seq_along(thermal), function(id) {
    vars <- thermal[[id]]
    data.frame(equation_id = id, heat_form = names(thermal)[id], block = "heat_x_sound", test = "Noise",
      terms = paste(vapply(c(setdiff(nonthermal, setdiff(H4_DOMAINS$Pollution, attr(vars, "pm"))), vars, H4_PHASE_SUM_COLS, paste0(unique(c(vars, "ucm_MRT")), ":SND_dBA")), h4_spell_term, character(1)), collapse = " + "),
      heat_role = if (length(vars) > 1L) "Air temperature + RH + apparent wind" else paste(names(thermal)[id], "only"), fitted = FALSE, stringsAsFactors = FALSE)
  }))
  stopifnot(nrow(out) == 12L, !anyDuplicated(out$terms))
  out$analysis_role <- "exploratory candidate; no prespecified primary"
  out$pm_representation <- vapply(thermal, function(v) attr(v, "pm"), character(1))
  out
}

h4_run_gvif_diagnostic <- function(prep, design_outcome = "empatica_heart_rate", vif_threshold = H4_SPEC$vif_threshold, write = TRUE) {
  list2env(prep[c("raw_df", "centered", "selected", "catalog", "make_design", "thermal")], environment())
  if (!design_outcome %in% names(raw_df)) stop("GVIF design outcome not in data: ", design_outcome)
  vals <- as.matrix(raw_df[, c(selected, design_outcome), drop = FALSE])
  storage.mode(vals) <- "double"
  ok <- apply(vals, 1L, function(v) all(is.finite(v)))
  if (design_outcome %in% H4_SPEC$hrv_log) ok <- ok & raw_df[[design_outcome]] > 0
  z <- centered[ok, , drop = FALSE]
  phase_vec <- raw_df$PhaseID[ok]
  n_rows <- nrow(z)
  term_rows <- eq_rows <- list()
  for (i in seq_len(nrow(catalog))) {
    eq <- catalog[i, ]
    design <- make_design(z, thermal[[eq$heat_form]], phase_vec, test = eq$test)
    vv <- h4_vif_per_term(design)
    gt <- attr(vv, "gvif_table")
    phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
    mx <- max(vv, na.rm = TRUE)
    id_cols <- data.frame(equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block, test = eq$test,
      design_outcome = design_outcome, n_design_rows = n_rows, stringsAsFactors = FALSE)
    term_rows[[i]] <- data.frame(id_cols, grouped_term = gt$term, GVIF = gt$GVIF, Df = gt$Df, GVIF_root = gt$GVIF_root,
      VIF_equivalent = gt$VIF_equivalent, flag_vif_gt_threshold = gt$Df == 1L & (gt$VIF_equivalent >= vif_threshold | !is.finite(gt$VIF_equivalent)),
      stringsAsFactors = FALSE, row.names = NULL)
    eq_rows[[i]] <- data.frame(id_cols, max_vif_equivalent = mx, worst_grouped_term = names(vv)[which.max(vv)],
      phase_GVIF = phase_gt$GVIF, phase_Df = phase_gt$Df, phase_GVIF_root = phase_gt$GVIF_root,
      phase_vif_equivalent = phase_gt$VIF_equivalent, rank = qr(cbind(1, design))$rank, expected_rank = ncol(design) + 1L,
      full_rank = qr(cbind(1, design))$rank == ncol(design) + 1L, stringsAsFactors = FALSE, row.names = NULL)
  }
  term_df <- do.call(rbind, term_rows)
  by_equation <- do.call(rbind, eq_rows)
  md_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.md")
  md <- c("# H4 design-only GVIF / VIF diagnostic", "", sprintf("Reference complete-case outcome: **%s** (n = %d). Other outcomes use different row sets; see `H4_design_redundancy_by_outcome.csv`.", design_outcome, n_rows),
    "", "## PhaseID vs single continuous predictors", "", "PhaseID enters as **three** sum-to-zero contrasts (`PhaseSumWalkG`, `PhaseSumWalkU`, `PhaseSumBikeG`; BikeU implicit).",
    "In `car::vif`, that span is one **Df = 3** term with a generalized VIF (GVIF).",
    paste0("- **GVIF^(1/(2*Df))** is what `car::vif` prints for multi-df terms (Fox & Monette 1992; [car::vif](https://rdrr.io/cran/car/man/vif.html))."),
    "- **VIF_equivalent = GVIF^(1/Df)** is the square of that root; we compare **VIF_equivalent** to ", vif_threshold, " for the PhaseID block.",
    "- Continuous **Df = 1** columns use ordinary VIF (= VIF_equivalent). Values above the threshold are **flagged only**; no predictor is dropped.",
    "", "## Equation summaries (heart rate complete cases)", "", "| Eq | Heat form | Block | n | Max VIF-equiv | Worst term | Phase GVIF | Phase VIF-equiv |",
    "|----|-----------|-------|---|---------------|------------|------------|-----------------|",
    with(by_equation, sprintf("| %d | %s | %s | %d | %.3f | %s | %.3f | %.3f |", equation_id, heat_form, block, n_design_rows,
      max_vif_equivalent, worst_grouped_term, phase_GVIF, phase_vif_equivalent)), "", sprintf("Generated UTC: %s", format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")))
  csv_path <- file.path(OUT_DIR, "H4_models", "H4_gvif_diagnostic.csv")
  if (write) {
    dir.create(file.path(OUT_DIR, "H4_models"), recursive = TRUE, showWarnings = FALSE)
    utils::write.csv(term_df, csv_path, row.names = FALSE, na = "")
    writeLines(md, md_path)
  }
  list(terms = term_df, by_equation = by_equation, paths = c(csv = csv_path, md = md_path))
}

# ---- Step 5: model fitting, covariance checks and inference ----
h4_archive <- function(paths, archive_dir) {
  paths <- paths[file.exists(paths)]
  if (!length(paths)) return(invisible())
  dir.create(archive_dir, recursive = TRUE, showWarnings = FALSE)
  moved <- file.rename(paths, file.path(archive_dir, basename(paths)))
  if (!all(moved)) stop("Could not archive: ", paste(paths[!moved], collapse = ", "))
  cat(sprintf("Archived %d previous output(s) to %s\n", length(paths), archive_dir))
}
run_h4_step5 <- function(audit_df = NULL, raw_df = NULL) {
  suppressPackageStartupMessages({
    library(nlme)
    library(clubSandwich)
    library(parallel)
  })
  if (is.null(audit_df)) {
    if (!file.exists(OUT_CSV)) stop("Audit results CSV not found: ", OUT_CSV)
    audit_df <- read.csv(OUT_CSV, check.names = FALSE)
  }
  if (is.null(raw_df)) {
    raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    # Rebuild the averaged sensor columns (Atmotube PM, LYS) that are not stored in the raw CSV.
    for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
  }
  h4_model_dir <- file.path(OUT_DIR, "H4_models")
  dir.create(h4_model_dir, recursive = TRUE, showWarnings = FALSE)
  # Archive pre-existing items (except earlier _archive_* folders) so the folder only holds this run's outputs.
  old_items <- grep("^_archive_", list.files(h4_model_dir, all.files = TRUE, no.. = TRUE), value = TRUE, invert = TRUE)
  h4_archive(file.path(h4_model_dir, old_items), file.path(h4_model_dir, paste0("_archive_", format(Sys.time(), "%Y%m%d_%H%M%S"))))
  spec_rds <- tempfile(fileext = ".rds")
  saveRDS(H4_SPEC, spec_rds, version = 2L, compress = FALSE)
  # spec_md5 hashes the declared analysis specification, so it changes only when the spec changes.
  fingerprints <- unname(tools::md5sum(c(file.path(PROJECT_ROOT, "scripts/H4_multivariate.R"), RAW_DATA_PATH, OUT_CSV, spec_rds)))
  names(fingerprints) <- c("code_md5", "input_md5", "audit_md5", "spec_md5")
  unlink(spec_rds)
  prep <- h4_step4_exposure_prep(audit_df, raw_df)
  list2env(prep[c("raw_df", "nonthermal", "thermal", "selected", "centered", "make_design", "catalog", "agreed_common")], environment())
  stopifnot(nrow(catalog) == 12L)

  outcomes <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic", "Physiological_Ocular")], use.names = FALSE)
  hrv_log <- H4_SPEC$hrv_log

  gvif_diag <- h4_run_gvif_diagnostic(prep)
  cat("[Step 5] GVIF diagnostic (design outcome empatica_heart_rate):", gvif_diag$paths["csv"], "\n")
  nested <- ~ 1 | ParticipantID / PhaseID
  ar1 <- function() nlme::corAR1(value = 0.2, form = ~ Time10 | ParticipantID / PhaseID)
  # REML fit trying each optimizer in turn; log(opt, kind, message) records warnings and errors.
  fit_lme <- function(fml, fd, random, correlation, log, opts = c("nlminb", "optim")) {
    for (opt in opts) {
      fit <- tryCatch(withCallingHandlers(
        nlme::lme(fml, data = fd, random = random, correlation = correlation, method = "REML", na.action = na.fail,
          control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE, opt = opt)),
        warning = function(w) log(opt, "warning", conditionMessage(w))),
        error = function(e) { log(opt, "error", conditionMessage(e)); NULL })
      if (!is.null(fit)) return(fit)
    }
    NULL
  }
  # Both AR1 optimizers before the sensitivity-only independent fallback.
  do_fit_with_fallback <- function(fml, fd) {
    messages <- character()
    logger <- function(label) function(opt, kind, msg) messages <<- c(messages, sprintf("%s %s: %s", if (is.null(label)) opt else label, kind, msg))
    fit <- fit_lme(fml, fd, nested, ar1(), logger(NULL))
    structure <- "AR1"
    if (is.null(fit)) {
      fit <- fit_lme(fml, fd, nested, NULL, logger("uncorrelated"), opts = "nlminb")
      structure <- "independent_fallback"
      if (!is.null(fit)) messages <- c(messages, "Fallback: AR(1) failed; fitted independent residual covariance (sensitivity-only fit)")
    }
    list(fit = fit, note = paste(messages, collapse = "; "), residual_structure = if (is.null(fit)) "not_fitted" else structure)
  }

  fit_equation_ids <- catalog$equation_id
  # Outcome-specific redundancy audit before fitting; a rank-deficient design blocks fitting (no predictor removal).
  preflight <- list()
  for (check_y in outcomes) {
    check_vals <- as.matrix(raw_df[, c(selected, check_y), drop = FALSE])
    storage.mode(check_vals) <- "double"
    valid <- apply(check_vals, 1L, function(v) all(is.finite(v)))
    if (check_y %in% hrv_log) valid <- valid & raw_df[[check_y]] > 0
    check_z <- centered[valid, , drop = FALSE]
    check_phase <- raw_df$PhaseID[valid]
    for (check_eid in fit_equation_ids) {
      check_eq <- catalog[catalog$equation_id == check_eid, ]
      check_x <- make_design(check_z, thermal[[check_eq$heat_form]], check_phase, test = check_eq$test)
      vv <- h4_vif_per_term(check_x)
      gt <- attr(vv, "gvif_table")
      phase_gt <- gt[gt$term == "PhaseID", , drop = FALSE]
      if (!nrow(phase_gt)) phase_gt <- data.frame(GVIF = NA_real_, Df = 3L, GVIF_root = NA_real_, VIF_equivalent = NA_real_)
      exposure_terms <- intersect(colnames(check_x), selected)
      cells <- interaction(raw_df$ParticipantID[valid], check_phase, drop = TRUE)
      within_share <- vapply(exposure_terms, function(v) {
        x <- check_x[, v]
        total <- sum((x - mean(x))^2)
        if (total <= 0) return(NA_real_)
        sum((x - ave(x, cells, FUN = mean))^2) / total
      }, numeric(1))
      rr <- qr(cbind(Intercept = 1, check_x))$rank
      sigmas <- apply(check_x, 2L, stats::sd)
      singular <- svd(sweep(sweep(check_x, 2L, colMeans(check_x), "-"), 2L, ifelse(is.finite(sigmas) & sigmas > 0, sigmas, 1), "/"), nu = 0L, nv = 0L)$d
      mx <- max(vv)
      preflight[[length(preflight) + 1L]] <- data.frame(equation_id = check_eid, heat_form = check_eq$heat_form, block = check_eq$block,
        outcome = check_y, n = nrow(check_x), rank = rr, expected_rank = ncol(check_x) + 1L, full_rank = rr == ncol(check_x) + 1L,
        max_vif = mx, worst_term = names(vv)[which.max(vv)], diagnostic = "Design-only GVIF^(1/Df); ordinary VIF for Df=1",
        phase_df = phase_gt$Df, phase_gvif = phase_gt$GVIF, phase_gvif_root = phase_gt$GVIF_root, phase_vif_equivalent = phase_gt$VIF_equivalent,
        term_vif_equivalents = paste(names(vv), signif(vv, 6), sep = "=", collapse = ";"),
        within_participant_phase_variation_share = paste(names(within_share), signif(within_share, 6), sep = "=", collapse = ";"),
        high_vif_terms = paste(names(vv)[!is.finite(vv) | vv >= H4_SPEC$vif_threshold], collapse = ";"),
        condition_index = if (!length(singular) || min(singular) <= 1e-10) Inf else max(singular) / min(singular),
        passes_check = rr == ncol(check_x) + 1L, vif_flag = is.finite(mx) && mx >= H4_SPEC$vif_threshold, stringsAsFactors = FALSE)
    }
  }
  preflight_df <- do.call(rbind, preflight)
  preflight_csv <- file.path(h4_model_dir, "H4_design_redundancy_by_outcome.csv")
  utils::write.csv(preflight_df, preflight_csv, row.names = FALSE, na = "")
  if (any(!preflight_df$passes_check)) stop(sprintf("Step 5 rank-deficiency blocked fitting for %d outcome-equation designs. Review %s; GVIF/VIF flags alone do not remove predictors.",
    sum(!preflight_df$passes_check), preflight_csv), call. = FALSE)
  fit_one_outcome <- function(job) {
    y <- job$outcome
    fit_equation_ids <- job$equation_id
    vals <- as.matrix(raw_df[, c(selected, y), drop = FALSE])
    storage.mode(vals) <- "double"
    ok <- apply(vals, 1, function(v) all(is.finite(v)))
    d <- raw_df[ok, c("ParticipantID", "PhaseID", "Datetime"), drop = FALSE]
    d$ParticipantID <- factor(d$ParticipantID)
    d$PhaseID <- factor(d$PhaseID, levels = c("WalkG", "WalkU", "BikeG", "BikeU"))
    stamp <- as.numeric(as.POSIXct(d$Datetime, tz = "UTC"))
    bout <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
    d$Time10 <- as.integer(round((stamp - ave(stamp, bout, FUN = min)) / 10))
    if (any(!is.finite(stamp)) || anyDuplicated(d[, c("ParticipantID", "PhaseID", "Time10")]))
      stop("Invalid/duplicate timestamps for outcome: ", y)
    z <- centered[ok, , drop = FALSE]
    yv <- vals[ok, y]
    transformation <- "native"
    if (y %in% hrv_log) {
      keep <- is.finite(yv) & yv > 0
      d <- d[keep, , drop = FALSE]
      z <- z[keep, , drop = FALSE]
      yv <- log(yv[keep])
      transformation <- H4_SPEC$outcome_transform[[y]]
    }
    coef_rows <- contrast_rows <- status_rows <- sens_rows <- list()
    status_row <- function(success, converged, structure, note, residual_sd = NA_real_, ar1_rho = NA_real_,
                           lag1_normalized = NA_real_, n_adjacent = 0L, residual_skew = NA_real_, residual_excess_kurtosis = NA_real_,
                           boundary_variance = NA, high_ar1_flag = NA, min_cr2_df = NA_real_, min_cr2_df_heat = NA_real_)
      data.frame(equation_id = eq_id, heat_form = m, block = blk, outcome = y,
        success = success, n = nrow(fd), n_participants = nlevels(fd$ParticipantID),
        transformation = transformation, converged = converged, residual_structure = structure, residual_sd = residual_sd,
        ar1_rho = ar1_rho, lag1_normalized = lag1_normalized, n_adjacent = n_adjacent,
        residual_skew = residual_skew, residual_excess_kurtosis = residual_excess_kurtosis,
        boundary_variance = boundary_variance, high_ar1_flag = high_ar1_flag, min_cr2_df = min_cr2_df, min_cr2_df_heat = min_cr2_df_heat,
        participant_ids = paste(sort(unique(as.character(fd$ParticipantID))), collapse = ";"),
        n_available_outcome = sum(is.finite(raw_df[[y]])), n_removed = nrow(raw_df) - nrow(fd),
        note = note, stringsAsFactors = FALSE)
    coef_frame <- function(term, est, se, df, p = 2 * pt(-abs(est / se), df), note = "")
      data.frame(equation_id = eq_id, heat_form = m, block = blk, outcome = y, term = term, estimate = est, se = se, df = df,
        residual_structure = attempt$residual_structure, ci_low = est - qt(0.975, df) * se, ci_high = est + qt(0.975, df) * se,
        t_stat = est / se, p_value = p, q_value = NA_real_, low_df_flag = is.finite(df) & df < 4, term_note = note, stringsAsFactors = FALSE)
    for (eq_id in fit_equation_ids) {
      eq_row <- catalog[catalog$equation_id == eq_id, ]
      m <- eq_row$heat_form
      blk <- eq_row$block
      design <- make_design(z, thermal[[m]], d$PhaseID, test = eq_row$test)
      original_terms <- colnames(design)
      safe_terms <- make.names(original_terms, unique = TRUE)
      colnames(design) <- safe_terms
      fd <- cbind(d, Y = yv, as.data.frame(design))
      fd <- fd[order(fd$ParticipantID, fd$PhaseID, fd$Time10), ]
      fml <- reformulate(safe_terms, response = "Y")
      attempt <- do_fit_with_fallback(fml, fd)
      fit <- attempt$fit
      if (is.null(fit)) {
        status_rows[[length(status_rows) + 1]] <- status_row(FALSE, FALSE, "not_fitted",
          paste("AR1 and independent-residual fits failed:", attempt$note))
        next
      }
      cr2_messages <- character()
      robust <- tryCatch(withCallingHandlers({
        result <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = fd$ParticipantID, test = "Satterthwaite")
        if (!isTRUE(all.equal(as.numeric(result$beta), as.numeric(nlme::fixef(fit)), tolerance = 1e-8)))
          stop("CR2 coefficient order does not match fixed effects")
        result
      }, warning = function(w) cr2_messages <<- c(cr2_messages, conditionMessage(w))),
        error = function(e) { cr2_messages <<- c(cr2_messages, conditionMessage(e)); NULL })
      if (is.null(robust)) {
        status_rows[[length(status_rows) + 1]] <- status_row(FALSE, TRUE, attempt$residual_structure,
          paste("CR2 estimation failed:", attempt$note, paste(cr2_messages, collapse = "; ")))
        next
      }
      rn <- tryCatch(residuals(fit, level = 2, type = "normalized"), error = function(e) NULL)
      grp <- interaction(fd$ParticipantID, fd$PhaseID, drop = TRUE)
      adj <- which(as.character(grp[-1]) == as.character(grp[-length(grp)]) & abs(diff(fd$Time10) - 1) < 1e-6)
      lag1 <- if (!is.null(rn) && length(adj) > 2) stats::cor(rn[adj], rn[adj + 1L]) else NA_real_
      rho <- tryCatch(unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE)), error = function(e) NA_real_)
      if (length(rho) != 1L) rho <- NA_real_
      rc <- if (!is.null(rn)) rn - mean(rn) else NULL
      rms <- if (!is.null(rc)) sqrt(mean(rc^2)) else NA_real_
      skew <- if (!is.null(rc) && rms > 0) mean((rc / rms)^3) else NA_real_
      kurt <- if (!is.null(rc) && rms > 0) mean((rc / rms)^4) - 3 else NA_real_
      variance_text <- nlme::VarCorr(fit)[, "Variance"]
      random_var <- as.numeric(variance_text[grepl("^[0-9.+eE-]+$", variance_text)])
      boundary <- any(random_var[is.finite(random_var)] < 1e-6 * sigma(fit)^2)
      high_ar1 <- is.finite(rho) & rho > 0.95
      # low_df_flag: CR2/Satterthwaite df < 4 make t tests unreliable (Tipton 2015; Pustejovsky & Tipton 2018); flagged, never dropped.
      c_df <- coef_frame(c("Intercept", original_terms), robust$beta, robust$SE, robust$df_Satt)
      # Under contr.sum(4) the fourth phase deviation is exactly PhaseSumBikeU = -(WalkG + WalkU + BikeG).
      phase_cols <- c("PhaseSumWalkG", "PhaseSumWalkU", "PhaseSumBikeG")
      if (all(phase_cols %in% original_terms)) {
        bikeu <- tryCatch({
          V <- clubSandwich::vcovCR(fit, cluster = fd$ParticipantID, type = "CR2")
          L <- matrix(0, 1L, length(nlme::fixef(fit)), dimnames = list(NULL, names(nlme::fixef(fit))))
          L[1L, phase_cols] <- -1
          wt <- clubSandwich::Wald_test(fit, constraints = L, vcov = V, test = "HTZ")
          list(as.numeric(L %*% nlme::fixef(fit)), sqrt(as.numeric(L %*% V %*% t(L))), as.numeric(wt$df_denom), as.numeric(wt$p_val), NULL)
        }, error = function(e) list(NA_real_, NA_real_, NA_real_, NA_real_, paste("BikeU contrast failed:", conditionMessage(e))))
        pos <- match("PhaseSumBikeG", c_df$term)
        c_df <- rbind(c_df[seq_len(pos), ], coef_frame("PhaseSumBikeU", bikeu[[1]], bikeu[[2]], bikeu[[3]], bikeu[[4]],
          paste(c("Derived contrast (BikeU = -(WalkG + WalkU + BikeG)); reported only, excluded from all FDR families", bikeu[[5]]), collapse = "; ")),
          c_df[-seq_len(pos), ])
        rownames(c_df) <- NULL
      }
      c_df$term_category <- "Nonthermal_Covariate"
      c_df$term_category[c_df$term == "Intercept"] <- "Intercept"
      c_df$term_category[startsWith(c_df$term, "Phase")] <- "Phase_Condition"
      c_df$term_category[c_df$term %in% thermal[[m]]] <- "Heat_Main_Effect"
      c_df$term_category[grepl(":SND_dBA", c_df$term)] <- "Thermal_x_Sound"
      c_df$term_category[grepl(":PhaseSum", c_df$term, fixed = TRUE)] <- "Thermal_x_Phase"
      # Candidate terms are specified before outcome fits; no significance-based or PCA selection.
      c_df$selection_status <- ifelse(c_df$term == "Intercept", "intercept",
        ifelse(c_df$term_category == "Nonthermal_Covariate" & !(c_df$term %in% agreed_common),
               "retained_candidate", "specified_term"))
      coef_non_int <- c_df[c_df$term != "Intercept", ]
      min_df <- if (nrow(coef_non_int) > 0) min(coef_non_int$df, na.rm = TRUE) else NA_real_
      heat_only <- coef_non_int[coef_non_int$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound", "Thermal_x_Phase"), ]
      min_df_heat <- if (nrow(heat_only) > 0) min(heat_only$df, na.rm = TRUE) else NA_real_
      status_rows[[length(status_rows) + 1]] <- status_row(TRUE, TRUE, attempt$residual_structure,
        paste(if (identical(attempt$residual_structure, "AR1")) "AR1 fit completed" else "INDEPENDENT-RESIDUAL FALLBACK (not equivalent to AR1)",
              attempt$note, paste(cr2_messages, collapse = "; "), sep = "; "),
        residual_sd = sigma(fit), ar1_rho = rho, lag1_normalized = lag1, n_adjacent = length(adj),
        residual_skew = skew, residual_excess_kurtosis = kurt, boundary_variance = boundary, high_ar1_flag = high_ar1,
        min_cr2_df = min_df, min_cr2_df_heat = min_df_heat)
      coef_rows[[length(coef_rows) + 1]] <- c_df
      contrast_messages <- character()
      phase_tests <- tryCatch(withCallingHandlers(h4_phase_contrasts(fit, fd$ParticipantID),
        warning = function(w) contrast_messages <<- c(contrast_messages, conditionMessage(w))),
        error = function(e) { contrast_messages <<- c(contrast_messages, conditionMessage(e)); NULL })
      if (is.null(phase_tests)) phase_tests <- data.frame(contrast = rownames(h4_phase_contrast_weights()), estimate = NA_real_,
        se = NA_real_, df = NA_real_, low_df_flag = NA, ci_low = NA_real_, ci_high = NA_real_, p_value = NA_real_)
      contrast_rows[[length(contrast_rows) + 1L]] <- cbind(phase_tests, outcome = y, residual_structure = attempt$residual_structure,
        equation_id = eq_id, note = paste(contrast_messages, collapse = "; "), stringsAsFactors = FALSE)
      # Both covariance checks use the same fitting and coefficient-comparison code.
      target_idx <- which(c_df$term_category %in% c("Heat_Main_Effect", "Thermal_x_Sound"))
      sensitivity_specs <- list()
      if (isTRUE(boundary)) sensitivity_specs$boundary <- list(
        flag = "boundary_variance", name = "random_intercept_participant_only_AR1",
        random = ~ 1 | ParticipantID, correlation = ar1())
      # Every AR1 fit gets an independent-residual comparison, including rho <= 0.95.
      if (isTRUE(high_ar1) || identical(attempt$residual_structure, "AR1")) sensitivity_specs$independent <- list(
        flag = if (isTRUE(high_ar1)) "high_ar1" else "routine_independent_refit",
        name = "independent_residuals_nested_random_CR2",
        random = nested, correlation = NULL)
      if (length(target_idx)) for (specification in sensitivity_specs) {
        sensitivity_messages <- character()
        alt_fit <- fit_lme(fml, fd, specification$random, specification$correlation, function(opt, kind, msg)
          sensitivity_messages <<- c(sensitivity_messages, if (kind == "error") paste0(opt, ": ", msg) else msg))
        alt_robust <- if (!is.null(alt_fit)) {
          tryCatch(clubSandwich::coef_test(alt_fit, vcov = "CR2", cluster = fd$ParticipantID, test = "Satterthwaite"),
                   error = function(e) { sensitivity_messages <<- c(sensitivity_messages, paste("CR2:", conditionMessage(e))); NULL })
        } else NULL
        for (i_t in target_idx) {
          t_name <- c_df$term[i_t]
          p_est <- c_df$estimate[i_t]
          alt_idx <- integer(0)
          k <- match(t_name, original_terms)
          if (!is.null(alt_robust) && !is.na(k)) {
            rn_match <- which(rownames(alt_robust) == safe_terms[k])
            if (length(rn_match) == 1L) alt_idx <- rn_match else if (k + 1L <= nrow(alt_robust)) alt_idx <- k + 1L
          }
          a_est <- a_se <- a_df <- a_cil <- a_cih <- a_pval <- NA_real_
          status_txt <- if (is.null(alt_fit)) paste("fit_failed:", paste(sensitivity_messages, collapse = "; ")) else "cr2_failed"
          if (length(alt_idx) == 1L) {
            a_est <- as.numeric(alt_robust$beta[alt_idx])
            a_se <- as.numeric(alt_robust$SE[alt_idx])
            a_df <- as.numeric(alt_robust$df_Satt[alt_idx])
            a_cil <- a_est - qt(0.975, a_df) * a_se
            a_cih <- a_est + qt(0.975, a_df) * a_se
            a_pval <- as.numeric(alt_robust[["p_Satt"]][alt_idx])
            status_txt <- "success"
          }
          sens_rows[[length(sens_rows) + 1L]] <- data.frame(
            equation_id = eq_id, heat_form = m, block = blk, outcome = y,
            diagnostic_flag = specification$flag,
            sensitivity_specification = specification$name,
            term = t_name, term_category = c_df$term_category[i_t],
            primary_estimate = p_est, primary_se = c_df$se[i_t], primary_df = c_df$df[i_t],
            primary_ci_low = c_df$ci_low[i_t], primary_ci_high = c_df$ci_high[i_t], primary_p_value = c_df$p_value[i_t],
            alt_estimate = a_est, alt_se = a_se, alt_df = a_df,
            alt_ci_low = a_cil, alt_ci_high = a_cih, alt_p_value = a_pval,
            estimate_diff = a_est - p_est, estimate_rel_diff_pct = if (is.finite(a_est) && abs(p_est) > 1e-12) 100 * (a_est - p_est) / abs(p_est) else NA_real_,
            ci_overlap = if (is.finite(a_est)) (c_df$ci_low[i_t] <= a_cih) && (a_cil <= c_df$ci_high[i_t]) else NA,
            sensitivity_status = status_txt, stringsAsFactors = FALSE)
        }
      }
    }
    list(
      coef = if (length(coef_rows)) do.call(rbind, coef_rows) else NULL,
      status = if (length(status_rows)) do.call(rbind, status_rows) else NULL,
      contrasts = if (length(contrast_rows)) do.call(rbind, contrast_rows) else NULL,
      sensitivity = if (length(sens_rows)) do.call(rbind, sens_rows) else NULL
    )
  }
  cat(sprintf("[Step 5] Fitting %d equations across %d outcomes in parallel...\n", length(fit_equation_ids), length(outcomes)))
  workers <- min(length(fit_equation_ids), max(1L, parallel::detectCores() - 2L))
  jobs <- unlist(lapply(outcomes, function(y) lapply(fit_equation_ids, function(eid) list(outcome = y, equation_id = eid))), recursive = FALSE)
  stopifnot(length(jobs) == length(outcomes) * length(fit_equation_ids))
  cat(sprintf("[Parallel] %d workers; %d individual outcome-equation jobs; one job per dispatch.\n", workers, length(jobs)))
  cl <- parallel::makeCluster(workers)
  on.exit(try(parallel::stopCluster(cl), silent = TRUE), add = TRUE)
  parallel::clusterEvalQ(cl, { library(nlme); library(clubSandwich); NULL })
  parallel::clusterExport(cl, c("raw_df", "centered", "selected", "nonthermal", "thermal",
                                "outcomes", "hrv_log", "catalog", "fit_equation_ids",
                                "make_design", "do_fit_with_fallback", "fit_lme", "nested", "ar1", "h4_spell_term", "agreed_common"), envir = environment())
  parallel::clusterExport(cl, c("h4_phase_design", "h4_vif_per_term", "H4_SPEC", "H4_DOMAINS",
                                "h4_phase_contrasts", "h4_phase_contrast_weights"), envir = .GlobalEnv)
  fit_results <- parallel::parLapplyLB(cl, jobs, fit_one_outcome, chunk.size = 1L)
  saveRDS(fit_results, file.path(h4_model_dir, "H4_fit_records.rds"))
  coef_all <- do.call(rbind, lapply(fit_results, `[[`, "coef"))
  status_all <- do.call(rbind, lapply(fit_results, `[[`, "status"))
  stopifnot(nrow(status_all) == length(outcomes) * length(fit_equation_ids),
            !anyDuplicated(status_all[, c("outcome", "equation_id")]))
  if (is.null(coef_all) || !nrow(coef_all)) stop("All fits failed; existing published outputs preserved")
  contrast_all <- do.call(rbind, lapply(fit_results, `[[`, "contrasts"))
  contrast_grid <- expand.grid(outcome = outcomes, equation_id = fit_equation_ids,
                              contrast = rownames(h4_phase_contrast_weights()), stringsAsFactors = FALSE)
  if (is.null(contrast_all)) stop("No phase-contrast records returned")
  stopifnot(!anyDuplicated(contrast_all[, c("outcome", "equation_id", "contrast")]))
  contrast_all <- merge(contrast_grid, contrast_all, by = c("outcome", "equation_id", "contrast"), all.x = TRUE)
  contrast_all$note[is.na(contrast_all$note)] <- "Model failed; contrast not estimable (see H4_fit_status.csv)"
  # Fallback fits are excluded from the contrast FDR family; m counts all planned contrasts (failed = non-rejection).
  ct_fallback <- contrast_all$residual_structure %in% "independent_fallback"
  contrast_all$fdr_note <- ifelse(ct_fallback, "excluded: independent-residual fallback", "")
  contrast_all$q_value <- NA_real_
  ct_ok <- !ct_fallback & is.finite(contrast_all$p_value)
  contrast_all$q_value[ct_ok] <- p.adjust(contrast_all$p_value[ct_ok], "BH", n = nrow(contrast_grid))
  sens_all <- do.call(rbind, lapply(fit_results, `[[`, "sensitivity"))
  if (is.null(sens_all)) stop("No covariance sensitivity records returned")
  # FDR (BH 1995): per term within each equation across outcomes (m = n_outcomes) for thermal, thermal x sound and estimated
  # phase terms; derived BikeU, covariates, intercept and fallback fits get no q (family fixed 2026-10-11, exploratory).
  primary_cats <- c("Heat_Main_Effect", "Thermal_x_Sound")
  is_ar1 <- coef_all$residual_structure == "AR1"
  m_term <- length(outcomes)
  coef_all$q_term <- NA_real_
  for (k in unique(paste(coef_all$equation_id, coef_all$term))) {
    idx <- which(paste(coef_all$equation_id, coef_all$term) == k & coef_all$term != "PhaseSumBikeU" & is_ar1 & is.finite(coef_all$p_value) &
                 coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase", "Phase_Condition"))
    stopifnot(length(idx) <= m_term)
    if (length(idx)) coef_all$q_term[idx] <- p.adjust(coef_all$p_value[idx], method = "BH", n = m_term)
  }
  coef_all$fdr_family <- ifelse(is.finite(coef_all$q_term) & coef_all$term_category %in% primary_cats, "thermal_per_term", "other")

  st <- split(status_all$success, factor(status_all$equation_id, levels = catalog$equation_id))
  catalog$attempted <- unname(lengths(st))
  catalog$succeeded <- unname(vapply(st, sum, integer(1)))
  catalog$failed <- catalog$attempted - catalog$succeeded
  catalog$fitted <- catalog$succeeded > 0L
  catalog[c("code_md5", "input_md5")] <- as.list(fingerprints[c("code_md5", "input_md5")])
  status_all[names(fingerprints)] <- as.list(fingerprints)
  sens_all[names(fingerprints)] <- as.list(fingerprints)
  # covariance_robust = FALSE if any alternative estimate lies outside the primary 95% CI, CIs do not overlap or the sign flips;
  # NA without a successful refit. alt_* report the independent-residual refit (else the boundary refit).
  coef_all$covariance_robust <- NA; coef_all$alt_estimate <- NA_real_; coef_all$alt_ci_low <- NA_real_
  coef_all$alt_ci_high <- NA_real_; coef_all$alt_structure <- NA_character_
  sens_ok <- sens_all[sens_all$sensitivity_status == "success" & is.finite(sens_all$alt_estimate), , drop = FALSE]
  if (nrow(sens_ok)) {
    sens_ok$fails <- with(sens_ok, alt_estimate < primary_ci_low | alt_estimate > primary_ci_high |
                            !(ci_overlap %in% TRUE) | sign(alt_estimate) != sign(primary_estimate))
    key_s <- paste(sens_ok$equation_id, sens_ok$outcome, sens_ok$term)
    key_c <- paste(coef_all$equation_id, coef_all$outcome, coef_all$term)
    has <- key_c %in% key_s
    coef_all$covariance_robust[has] <- !vapply(key_c[has], function(k) any(sens_ok$fails[key_s == k]), logical(1))
    pick <- sens_ok[order(sens_ok$sensitivity_specification != "independent_residuals_nested_random_CR2"), , drop = FALSE]
    j <- match(key_c, paste(pick$equation_id, pick$outcome, pick$term))
    coef_all$alt_estimate <- pick$alt_estimate[j]; coef_all$alt_ci_low <- pick$alt_ci_low[j]
    coef_all$alt_ci_high <- pick$alt_ci_high[j]; coef_all$alt_structure <- pick$sensitivity_specification[j]
  }
  fb_rows <- coef_all$residual_structure %in% "independent_fallback"
  coef_all$covariance_robust[fb_rows] <- NA; coef_all$alt_estimate[fb_rows] <- NA_real_
  coef_all$alt_ci_low[fb_rows] <- NA_real_; coef_all$alt_ci_high[fb_rows] <- NA_real_; coef_all$alt_structure[fb_rows] <- NA_character_
  # Simplified main table: one q (per-term BH across outcomes; thermal and phase rows only) and one term_type.
  is_thermal <- coef_all$term_category %in% c(primary_cats, "Thermal_x_Phase")
  coef_out <- data.frame(equation = coef_all$heat_form, outcome = coef_all$outcome,
    term = sub("^PhaseSum(.*)$", "Phase: \\1 vs mean of phases", coef_all$term),
    term_type = ifelse(coef_all$term == "Intercept", "intercept", ifelse(startsWith(coef_all$term, "PhaseSum"), "phase (study design)",
      ifelse(is_thermal, "thermal exposure", "covariate"))),
    Beta = coef_all$estimate, ci_low = coef_all$ci_low, ci_high = coef_all$ci_high, p = coef_all$p_value,
    q = coef_all$q_term, FDR_significant = !is.na(coef_all$q_term) & coef_all$q_term < 0.05,
    covariance_robust = coef_all$covariance_robust, residual_structure = coef_all$residual_structure, stringsAsFactors = FALSE)
  hypo_df <- coef_out[is_thermal, ]
  n_rows_fit <- status_all$n[status_all$success]
  n_text <- if (length(n_rows_fit)) sprintf("%d-%d rows per outcome-equation (median %d)", min(n_rows_fit), max(n_rows_fit), as.integer(stats::median(n_rows_fit))) else "no successful fits"
  postsel <- setdiff(nonthermal, agreed_common)
  rt <- prep$rep_tab
  rep_lines <- vapply(split(rt, rt$Step4_Domain), function(d)
    paste0("     * ", d$Step4_Domain[1], ": ", paste(d$Variable_Name, collapse = ", "), "; ", d$Step4_Restriction[1]), character(1))
  selection_report_lines <- c("   - Step 4 retains all eligible candidates. No PCA/LASSO selection or automatic VIF deletion.",
    "   - Twelve exploratory candidate equations cross four heat representations with three alternative PM measures; distinct radiation/light terms are retained and MRT x sound is included.",
    "   - Complete outcome-specific design rank and grouped GVIF are checked before fitting; VIF >= 5 is a review flag.", rep_lines)
  vif_max <- suppressWarnings(max(preflight_df$max_vif[is.finite(preflight_df$max_vif)]))
  vif_txt <- if (is.finite(vif_max)) sprintf("maximum grouped VIF-equivalent across %d outcome-equation designs = %.2f; %d design(s) at or above %s",
                                             nrow(preflight_df), vif_max, sum(preflight_df$vif_flag, na.rm = TRUE), H4_SPEC$vif_threshold) else "VIF not computed"
  n_boundary <- sum(status_all$boundary_variance %in% TRUE)
  n_high_ar1 <- sum(status_all$high_ar1_flag %in% TRUE)
  fb <- status_all[status_all$residual_structure %in% "independent_fallback", , drop = FALSE]
  hits <- coef_all[coef_all$term_category %in% primary_cats & is.finite(coef_all$q_term) & coef_all$q_term < 0.05, , drop = FALSE]
  hits_txt <- if (nrow(hits)) sprintf("   - %s | %s, %s: estimate %.4g [%.4g, %.4g], q = %.3g; alternative (%s) %.4g [%.4g, %.4g]; covariance_robust = %s%s",
    hits$heat_form, hits$outcome, hits$term, hits$estimate, hits$ci_low, hits$ci_high, hits$q_term, hits$alt_structure,
    hits$alt_estimate, hits$alt_ci_low, hits$alt_ci_high, ifelse(is.na(hits$covariance_robust), "NA (no refit)", as.character(hits$covariance_robust)),
    ifelse(hits$covariance_robust %in% FALSE, ". Covariance-sensitive: must not be presented as robust.", "")) else "   - none (no q < 0.05)"
  pr_rows <- coef_all$term_category %in% primary_cats & is_ar1
  ind_s <- sens_all[sens_all$sensitivity_specification == "independent_residuals_nested_random_CR2", , drop = FALSE]
  bnd_s <- sens_all[sens_all$sensitivity_specification == "random_intercept_participant_only_AR1", , drop = FALSE]
  n_ind_models <- nrow(unique(ind_s[, c("equation_id", "outcome")]))
  flag_tab <- table(sens_all$diagnostic_flag)
  flag_txt <- if (length(flag_tab)) paste(sprintf("%s = %d rows", names(flag_tab), as.integer(flag_tab)), collapse = "; ") else "none"
  cr <- coef_all$covariance_robust[pr_rows]
  n_bnd_ident <- sum(bnd_s$sensitivity_status == "success" & abs(bnd_s$alt_estimate - bnd_s$primary_estimate) < 1e-10 &
                     abs(bnd_s$alt_se - bnd_s$primary_se) < 1e-10, na.rm = TRUE)
  fb_lines <- if (nrow(fb)) vapply(seq_len(nrow(fb)), function(i) {
    ss <- bnd_s[bnd_s$equation_id == fb$equation_id[i] & bnd_s$outcome == fb$outcome[i], , drop = FALSE]
    conv <- nrow(ss) > 0 && all(ss$sensitivity_status == "success")
    sprintf("    - Eq %s (%s) on %s: normalized residual lag-1 autocorrelation = %.3f.%s", fb$equation_id[i], fb$heat_form[i], fb$outcome[i],
            fb$lag1_normalized[i], if (conv) " A participant-only AR(1) refit converged (H4_covariance_sensitivity.csv); this model nevertheless stays excluded by decision." else "")
  }, character(1)) else "    - none in this run"
  np_rng <- range(status_all$n_participants[status_all$success], na.rm = TRUE)
  low_np <- unique(status_all$outcome[status_all$success & status_all$n_participants < np_rng[2]])
  np_txt <- if (np_rng[1] == np_rng[2]) sprintf("%d participants in every model", np_rng[2]) else
    sprintf("%d-%d participants per model; fewer than %d in: %s", np_rng[1], np_rng[2], np_rng[2], paste(low_np, collapse = ", "))
  fb_txt <- if (nrow(fb)) paste(sprintf("Eq %s (%s) on %s", fb$equation_id, fb$heat_form, fb$outcome), collapse = "; ") else "none in this run"
  m_primary_txt <- sprintf("m = %d per term", as.integer(m_term))
  readme_lines <- c(
    "H4 Multivariate Models (Step 4 candidate equations)",
    "================================================================",
    "H4: Noise and traffic amplify thermal discomfort. These physiological/ocular models investigate heat x sound associations; they do not directly establish perceived thermal discomfort or a traffic effect.",
    sprintf("1. Sample: 10-second windows (%s; %s; %d outcomes) with nested random intercepts (1 | ParticipantID / PhaseID).", n_text, np_txt, length(unique(status_all$outcome))),
    "2. Autocorrelation: The primary working residual covariance is AR(1) within participant-phase. If both AR(1) optimizers fail, an independent-residual fallback may be estimated, marked as residual_structure = independent_fallback (H4_fit_status.csv and the main tables). Its estimates are sensitivity-only, with q and covariance_robust left empty; inspect normalized residual lag-1 correlation before interpreting.",
    "3. Methodological exposure centering justification:",
    "   - Step 5 LMMs use within-bout exposure deviations, scaled by the pooled SD of within-bout deviations. Thermal and Thermal x Sound coefficients describe associations within an activity/environment bout, not between-bout effects. PhaseID coefficients describe conditional mean outcome differences at zero within-bout deviations, but are NOT adjusted for differences in observed bout-average environmental exposure. The observed low VIFs reflect this dataset, not a mathematical guarantee.",
    "4. Small-cluster robust inference and diagnostic interpretation:",
    sprintf("   - Inference uses participant-cluster CR2 standard errors and Satterthwaite degrees of freedom; low_df_flag marks df < 4. With %d participants, these adjustments cannot guarantee validity under arbitrary random-effect or serial-correlation misspecification; sensitivity analysis and caution remain necessary.", length(H4_SPEC$participants)),
    "   - boundary_variance = TRUE means at least one estimated random-effect variance is near zero; this may reflect a weakly identified or redundant random component. It does not establish the reason or prove robustness. Refit with a defensible alternative random-effects structure to assess coefficient/SE stability before strong claims.",
    "   - high_ar1_flag = TRUE marks fitted rho > 0.95. This may reflect strong persistence or covariance-estimation instability. AR(1) and CR2 are not proof of model stability; compare the relevant coefficients and confidence intervals with reasonable alternative covariance models. For independent_fallback fits, report normalized residual autocorrelation explicitly.",
    "5. Collinearity & VIF diagnostics (criterion = 5; zero automated variable deletion):",
    "   - Grouped GVIF^(1/df) evaluated on each outcome-equation design with declared threshold 5 (H4_SPEC$vif_threshold = 5).",
    paste0("   - This run: ", vif_txt, " (H4_design_redundancy_by_outcome.csv, H4_gvif_diagnostic.csv). Zero automated term removal is applied."),
    sprintf("6. Fitted equations (%d equations, full fixed effects, %d/%d successful fits):", length(unique(coef_all$equation_id)), sum(status_all$success), nrow(status_all)),
    paste0("   - ", vapply(unique(coef_all$equation_id), function(eid) {
      eq_row <- catalog[catalog$equation_id == eid, ]
      sprintf("Equation %d (%s, %s): %s", eid, eq_row$heat_form, eq_row$block, eq_row$terms)
    }, character(1))),
    "7. Multiple testing (Benjamini & Hochberg 1995; AR(1) fits only; fallback fits get no q; denominators count planned tests, so failed or fallback fits are non-rejections). Each row has one q:",
    sprintf("   - Thermal and phase rows: q = BH per exposure (or phase) term across the %d outcomes within each equation (m = %d), matching the outline's 'BH across all outcomes within each hypothesis family'. This family was fixed on 2026-10-11 after earlier results had been seen, so all findings are exploratory. Thermal x sound interactions are secondary and descriptive (n = %d participants; interactions need more power than main effects).", length(outcomes), as.integer(m_term), length(H4_SPEC$participants)),
    "   - 'Phase: BikeU vs mean of phases' is derived as -(WalkG + WalkU + BikeG) and has no q.",
    "   - Wind (Equation 1) is apparent wind speed ucm_WIND_AWS (airflow at the body including own movement). It correlates with movement speed; exertion and PhaseID are adjusted in every model. True wind speed is excluded at Step 2 (gaps, not reconstructable).",
    "   - Phase contrasts (H4_phase_contrasts.csv): BH over all planned contrasts x outcomes x equations in that file (fallback fits excluded; see fdr_note).",
    "   - Covariate and intercept rows: no q (not tested).",
    "   - q < 0.05 thermal hits and covariance robustness (FALSE = alternative covariance estimate outside the primary 95% CI, non-overlapping CIs, or sign flip; covariance-sensitive findings must not be described as robust):",
    hits_txt,
    sprintf("Exertion covariate: %s (wrist accelerometer, g; concurrent 10-s value), forced in every equation, within-bout centred and scaled like the exposures; not part of any primary FDR family.", paste(agreed_common, collapse = ", ")),
    paste0("8. Covariates (term_type = covariate): the Step 4 retained candidates (", if (length(postsel)) paste(postsel, collapse = ", ") else "none", ") plus forced exertion (", paste(agreed_common, collapse = ", "), "). Covariates have no q."),
    selection_report_lines,
    "9. Phase contrasts: H4_phase_contrasts.csv contains contrasts of fitted phase outcome means at zero within-bout environmental deviations. These compare conditions but do not control for measured differences in the average thermal, acoustic, light, or greenery exposures between bouts; do not call them average-microclimate-adjusted contrasts.",
    "10. Covariance sensitivity analysis (H4_covariance_sensitivity.csv):",
    sprintf("    - Models with boundary variance (random-effect variance < 1e-6 * sigma^2; %d in this run) are refitted with a participant-only random intercept (~ 1 | ParticipantID), keeping within-bout AR(1).", n_boundary),
    sprintf("    - Every AR(1) model is refitted with independent residuals and CR2 standard errors: %d models in this run (rho > 0.95 in %d of them). diagnostic_flag counts: %s.", n_ind_models, n_high_ar1, flag_txt),
    sprintf("    - covariance_robust among the %d primary rows: TRUE = %d, FALSE = %d, NA = %d. FALSE rule: any alternative estimate lies outside the primary 95%% CI, OR the primary and alternative CIs do not overlap, OR the sign flips. Fallback rows have covariance_robust set to NA; alternative estimates are in H4_covariance_sensitivity.csv.", sum(pr_rows), sum(cr %in% TRUE), sum(cr %in% FALSE), sum(is.na(cr))),
    sprintf("    - Boundary-variance refits identical to the primary fit (estimate and SE): %d of %d term rows; these cannot change the verdict.", n_bnd_ident, nrow(bnd_s)),
    "    - Primary vs alternative estimates, standard errors, degrees of freedom and 95% CIs are reported side by side for thermal main effects and thermal x sound interactions.",
    paste0("    - Independent-residual fallback fits (residual_structure = independent_fallback; q and covariance_robust empty): ", fb_txt, "."),
    "11. Interpretation limits:",
    "    - Independent-residual fallback models: excluded from primary inference and from q; they do not affect the other AR(1) fits (each model is fitted separately).",
    fb_lines,
    "12. Main-table columns: see the plain-language column list in results/H4_results/H4_Report.md.",
    "13. Reproducibility: H4_session_info.txt records sessionInfo() and package versions; spec_md5 hashes the H4_SPEC specification object.",
    sprintf("Generated: %s UTC", format(Sys.time(), tz = "UTC", format = "%Y-%m-%d %H:%M:%S")),
    paste("Script MD5:", fingerprints["code_md5"]),
    paste("Data MD5:", fingerprints["input_md5"]),
    paste("Audit MD5:", fingerprints["audit_md5"]),
    paste("Spec MD5:", fingerprints["spec_md5"])
  )
  pkgs <- c("nlme", "clubSandwich", "car", "ggplot2", "gridExtra")
  session_lines <- c(capture.output(utils::sessionInfo()), "", paste0(pkgs, " ", vapply(pkgs, function(p)
    tryCatch(as.character(utils::packageVersion(p)), error = function(e) "not installed"), character(1))))
  bundle <- list(
    H4_equations.csv = catalog,
    H4_fit_status.csv = status_all,
    H4_coefficients.csv = coef_out,
    H4_hypothesis.csv = hypo_df,
    H4_phase_contrasts.csv = transform(setNames(contrast_all, sub("^estimate$", "Beta", sub("^q_value$", "q", names(contrast_all)))),
                                     FDR_significant = !is.na(q) & q < 0.05),
    H4_covariance_sensitivity.csv = sens_all,
    H4_hypothesis_readme.txt = readme_lines,
    H4_session_info.txt = session_lines
  )
  # Sequential publication; the completion manifest is invalidated first (readers must reject a missing manifest).
  manifest_path <- file.path(h4_model_dir, "H4_run_complete.csv")
  if (file.exists(manifest_path) && !file.remove(manifest_path)) stop("Cannot invalidate old completion manifest")
  for (nm in names(bundle)) {
    target_path <- file.path(h4_model_dir, nm)
    if (is.data.frame(bundle[[nm]])) write.csv(bundle[[nm]], target_path, row.names = FALSE, na = "") else writeLines(bundle[[nm]], target_path)
  }
  extra_files <- c("H4_fit_records.rds", "H4_gvif_diagnostic.csv", "H4_gvif_diagnostic.md",
                   "H4_design_redundancy_by_outcome.csv", "H4_covariance_sensitivity.csv", "H4_session_info.txt")
  man_files <- unique(c(names(bundle), extra_files[file.exists(file.path(h4_model_dir, extra_files))]))
  write.csv(data.frame(file = man_files, md5 = unname(tools::md5sum(file.path(h4_model_dir, man_files))), as.list(fingerprints),
    completed_utc = format(Sys.time(), tz = "UTC", format = "%Y-%m-%dT%H:%M:%SZ"), stringsAsFactors = FALSE), manifest_path, row.names = FALSE)
  cat(sprintf("[Step 5] Bundle published to %s. Total fitted models: %d, Succeeded: %d, Failed: %d\n",
              h4_model_dir, nrow(status_all), sum(status_all$success), sum(!status_all$success)))
  cat(sprintf("[Step 5] Thermal rows: %d, p < 0.05: %d, q < 0.05: %d (per-term BH; %s)\n",
              nrow(hypo_df), sum(hypo_df$p < 0.05, na.rm = TRUE), sum(hypo_df$q < 0.05, na.rm = TRUE), m_primary_txt))
  invisible(list(catalog = catalog, status = status_all, coef = coef_all, hypothesis = hypo_df))
}

# ---- Run: choose a partial run or the full pipeline ----
if (identical(Sys.getenv("H4_RENDER_FLOW_ONLY"), "1")) {
    render_h4_faceted_flow()
    quit(save = "no", status = 0)
}

# Audit-table PDF only: re-render H4_All_Variables_Audit.pdf from the saved Step 1-4 audit.
if (identical(Sys.getenv("H4_AUDIT_PDF_ONLY"), "1")) {
    if (!file.exists(OUT_CSV)) stop("Existing H4 audit CSV not found: ", OUT_CSV, call. = FALSE)
    render_audit_pdf(utils::read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), AUDIT_PDF)
    cat("Rendered audit table PDF only:", AUDIT_PDF, "\n")
    quit(save = "no", status = 0)
}

if (identical(Sys.getenv("H4_STEP4_ONLY"), "1")) {
  render_h4_faceted_flow()
  cat("Step 4 only: updated candidate-equation PDF and scoped figure hash; no model fits or coefficient writes.\n")
  quit(save = "no", status = 0)
}

# GVIF diagnostic only: recompute and write H4_models/H4_gvif_diagnostic.* from the saved audit.
if (identical(Sys.getenv("H4_GVIF_ONLY"), "1")) {
    if (file.exists(file.path(OUT_DIR, "H4_models", "H4_run_complete.csv")))
        stop("H4_models has a completion manifest; rerun Step 5 instead of rewriting GVIF files after hashing.")
    raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
    for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
    out <- h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    cat("Wrote GVIF diagnostic:", out$paths["csv"], "\n")
    quit(save = "no", status = 0)
}

# Figure refresh only: preserve model tables and update only the figure entry in the completion manifest.
if (identical(Sys.getenv("H4_FACET_REFRESH"), "1")) {
    if (!file.exists(file.path(OUT_DIR, "H4_models", "H4_run_complete.csv"))) {
        raw_df <- read.csv(RAW_DATA_PATH, check.names = FALSE)
        for (v in setdiff(names(average_sources), names(raw_df))) raw_df[[v]] <- rowMeans(raw_df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
        h4_run_gvif_diagnostic(h4_step4_exposure_prep(read.csv(OUT_CSV, stringsAsFactors = FALSE, check.names = FALSE), raw_df))
    }
    render_h4_faceted_flow()
    quit(save = "no", status = 0)
}

# Fast track: reuse the saved Step 4 audit and run Step 5 + figures only (no audit re-run).
if (identical(Sys.getenv("H4_STEP5_ONLY"), "1")) {
    if (!file.exists(OUT_CSV)) stop("H4_STEP5_ONLY=1 but no saved Step 4 audit at: ", OUT_CSV)
    cat("[Fast Track] Found existing validated Step 4 audit at:", OUT_CSV, "\n")
    run_h4_step5()
    render_h4_faceted_flow()
    cat("H4 multivariate Step 5 execution and faceted flow PDF update completed successfully.\n")
    quit(save = "no", status = 0)
}

# Full run: archive the top-level outputs this script regenerates (H4_models/ archives itself in Step 5).
h4_regenerated <- c(OUT_CSV, sub(".csv$", "_latest.csv", OUT_CSV), AUDIT_PNG, AUDIT_PDF, STAGE_SUMMARY_CSV, INTEGRATION_CSV,
                    STEP_CATEGORY_CSV, FINAL_OUTCOME_COUNTS_CSV, TRANSPARENCY_MD, FORMULA_TXT,
                    file.path(OUT_DIR, "H4_Phase_Coverage.csv"))
h4_archive(h4_regenerated, file.path(OUT_DIR, "_archive", paste0("run_", format(Sys.time(), "%Y%m%d_%H%M%S"))))
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
for (v in names(average_sources)) df[[v]] <- rowMeans(df[, average_sources[[v]], drop = FALSE], na.rm = TRUE)
df_core <- df[df$PhaseID %in% CORE_PHASES, ]
cat(sprintf("Loaded %d observations across %d participants (%d core outdoor epochs).\n", nrow(df), length(unique(df$ParticipantID)),
    nrow(df_core)))
# Exclusion sources ([key]; files under Paper3_Github/Experiment papers/): [Beiglary25] Beiglary et al. 2025 JMIR Aging e72338
# p.5; [Ishihara25] Ishihara et al. 2025 SLEEP zsaf358 p.1/p.7/p.10; [Sonneborn] Sonneborn & Voss, light field studies p.1;
# [ClearCI] clearness index kt = Gh/G0, p.3 eq.2; [Zhu24] Zhu et al. 2024 p.3/p.5; [Joubert26] Joubert et al. 2026 mixtures workflow;
# [Qiu17] Qiu et al. 2017 p.1 (SVF); [CityFeel17] UCM sensor table, doi:10.1016/j.egypro.2017.07.427.
cat("[2/6] Step 1: Auditing full schema and partitioning analytical roles...\n")
classify_col_role <- function(c) {
  info <- function(role, source, unit, action, decision = "Excluded") c(source, role, unit, action, decision)
  source <- if(grepl("^ucm_", c)) "UCM Backpack" else if(grepl("^atmo_lys_", c)) "Atmo / LYS" else
    if(grepl("^eyetracker_", c)) "Pupil Labs" else if(grepl("^gvi_", c)) "GVI" else "Study Design"
  # Step 1: QC/windowing fields describe signal quality, not the environment (Empatica_data_manual.pdf).
  if(grepl("^empatica_hrv_fd_5min_", c)) return(info("Physiological Signal Quality & HRV Windowing (Empatica QC)",
    "Empatica EmbracePlus", "QC / ms\u00b2", "Excluded from exposure funnel; physiological QC and window integrity metric"))
  metadata <- c("ParticipantID","PhaseID","Datetime","Date","ucm_Date","atmo_lys_Date","eyetracker_Date",
    "ucm_GPS_lat","ucm_GPS_lon","ucm_GPS_alt","ucm_GPS_HDOP","ucm_GPS_hdg","ucm_MAG_hdg",
    "ucm_GPS_speed_valid_sample_count","pct_complete","gvi_match_dist_m")
  # Step 1: identifiers, time and GPS are design/tracking fields; PhaseID enters Step 5 as a fixed effect.
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
  # Step 1: lux_cat is a deterministic binning of lys_lux (derived, information-losing).
  if(grepl("__lux_cat$",c)) return(info("Derived Light Category (not an independent continuous exposure)", "LYS", "Category",
    "Derived illuminance category; continuous lux is available; no averaged replacement exists."))
  # Step 1: movement/exertion are Z covariates (exertion forced in Step 5), not environmental exposures.
  if(grepl("__lys_movement$",c) || c %in% c("ucm_GPS_speed_kmh","empatica__met","empatica_acc_x","empatica_acc_y","empatica_acc_z","empatica_vector_magnitude"))
    return(info("Movement & Exertion Covariates (Z)", if(grepl("^ucm_",c)) "UCM Backpack" else if(grepl("^atmo_lys_",c)) "LYS" else "Empatica EmbracePlus",
      if(c=="ucm_GPS_speed_kmh") "km/h" else if(c=="empatica__met") "MET" else if(grepl("__lys_movement$",c)) "Device movement output" else "g",
      "Movement covariate; Step 5 adjusts for categorical PhaseID. Bike/Walk slope products derive from PhaseID, not measured exertion. PC_Movement is a design diagnostic. No LYS movement average is declared."))
  # Step 1: outcomes (Y) can never be exposures.
  if(c %in% H4_SPEC$all_outcomes && !grepl("^questionnaire_",c)) return(info("Physiological Sensor Outcomes (Y_physio)",
    if(grepl("^empatica_",c)) "Empatica EmbracePlus" else "Pupil Labs Neon",
    if(grepl("heart_rate",c)) "bpm" else if(grepl("skin_temperature",c)) "\u00b0C" else if(grepl("pupil",c)) "mm" else if(grepl("eda",c)) "\u00b5S" else if(grepl("rmssd",c)) "ms" else "Physio unit",
    "Excluded from exposure funnel; objective dependent outcome (Y)", "Retained"))
  if(c %in% H4_SPEC$all_outcomes) return(info("Psychological Survey Outcomes (Y_psych)","Post-Phase Surveys (STAI, PRS)",
    "Survey score","Excluded from exposure funnel; subjective psychological outcome (Y)"))
  # Step 1: other person-side fields are outside the pre-declared 30-outcome family (not exposures).
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
step1_mat <- t(sapply(all_variables_pool, function(col) if (col %in% derived_cols_all)
  c(if (grepl("^atmo_", col)) "Atmotube" else "LYS Study Average", "Environmental Stressor Candidates (X_env)",
    if (grepl("pm", col)) "µg/m³" else if (grepl("lux", col)) "lux" else if (grepl("medi", col)) "medi" else "K",
    "Retained for Step 2 technical sensor consolidation", "RETAINED FOR FILTRATION") else classify_col_role(col)))
cat("[3/6] Step 2: Checking explicit replacements, measurement type and within-person availability...\n")
stopifnot(length(unlist(average_sources)) == 12L, !anyDuplicated(unlist(average_sources)))
h4_prepared_for_vif <- h4_prepare_data(df)
audit_phase_groups <- split(seq_len(nrow(df_core)), paste(df_core$ParticipantID, df_core$PhaseID, sep = "::"))
audit_availability <- do.call(rbind, lapply(all_variables_pool, function(col) {
  values <- if (is.numeric(df_core[[col]])) vapply(audit_phase_groups, function(ix) h4_mean(df_core[[col]][ix]), numeric(1)) else rep(NA_real_, length(audit_phase_groups))
  ids <- sub("::.*", "", names(audit_phase_groups))
  centered <- h4_person_mean_center(values, ids)
  data.frame(Variable_Name = col, Available_Phase_Cells = sum(is.finite(values)),
    Available_Participants = length(unique(ids[is.finite(values)])),
    Within_Person_SD = if (sum(is.finite(centered)) > 1L) sd(centered, na.rm = TRUE) else NA_real_)
}))
h4_step2_representation <- function(col) {
  # Derived: kt = Gh/G0 is a deterministic ratio of ucm_SUN_Gh [ClearCI p.3 eq.2]; co-entry is redundant [Zhu24 p.3].
  if (col == "Clearness_Index") return("Derived from ucm_SUN_Gh (Gh/G0); retained source measurement ucm_SUN_Gh")
  # G0 is computed from date/time/location (solar geometry); it is the kt denominator, not an exposure [ClearCI p.3 eq.2].
  if (col == "Clearness_Index_G0") return("Calculated extraterrestrial irradiance G0 (date/time/location only), not a measured or personal exposure; denominator of Clearness_Index (kt = Gh/G0) [ClearCI p.3 eq.2]; measured solar exposure is ucm_SUN_Gh.")
  # Derived: melanopic EDI estimated from LYS RGB channels, not measured spectrally [Beiglary25 p.5; Ishihara25 p.1, p.7, p.10; Sonneborn p.1].
  if (col == "lys_medi_avg") return("Derived metric estimated from LYS RGB channels, not measured spectrally; retained light measures lys_lux_avg and lys_kelvin_avg")
  # WEAK (study choice, no source): solar geometry is a time/location proxy and an input of G0, not a personal exposure.
  if (col %in% c("ucm_SUN_alt", "ucm_SUN_az")) return("Declared Step 2 exclusion: solar altitude and solar azimuth are outside the selected exposure set")
  # Atmotube T/RH sensors are worn-device housekeeping channels; UCM T/RH are the reference instruments [CityFeel17].
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_humidity$", col)) return("Raw-source inventory only: UCM ucm_AIR_RH is the declared relative-humidity measure")
  if (grepl("^atmo_lys_atmotube_(left|right)__atmotube_temperature$", col)) return("Raw-source inventory only: UCM ucm_AIR_temp is the declared ambient-temperature measure")
  # WEAK: _SR/_S suffix meaning (alternative formulation) not documented locally; verify in UCM manual [CityFeel17].
  if (grepl("^ucm_.*_(SR|S)$", col)) return("Declared formulation choice: use the corresponding unsuffixed UCM measure")
  # Derived relation: IR radiometer channels are the inputs used to compute ucm_MRT [CityFeel17]; co-entry duplicates MRT.
  if (grepl("^ucm_IR_", col)) return("MRT input: UCM IR radiometer channels are the inputs used to compute ucm_MRT, so they are excluded as MRT inputs (derived relation) [CityFeel17]")
  # Wind representative = apparent wind speed AWS (airflow at the body incl. own movement; convective-cooling exposure; complete in core phases).
  if (col == "ucm_WIND_TWS") return("True wind speed has systematic gaps (P16 BikeU, P17 WalkG 0%; 10 more partial cells incl. P16 BikeG 2%) and cannot be reconstructed from AWS/AWA/GPS (undocumented device correction); wind representative: ucm_WIND_AWS")
  if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD")) return("Wind direction/angle (circular), derived; wind representative: ucm_WIND_AWS")
  # AH is a deterministic function of T and RH -> redundant with ucm_AIR_temp + ucm_AIR_RH [Zhu24 p.3].
  if (col == "ucm_AH") return("Humidity representative: ucm_AIR_RH; AH is an alternative formulation")
  # Height tiers of the same air-temperature measurement; highly collinear [Zhu24 p.3].
  if (col %in% c("ucm_AIR_T_bot", "ucm_AIR_T_mid", "ucm_AIR_T_top")) return("Air-temperature representative: ucm_AIR_temp; tier channels not co-entered")
  # gvi_50m is the original GVI scale value; other buffers, components (grass/plant/tree) and phase means are derived alternatives.
  if (grepl("^gvi_|^(plant|grass|tree)_phase_mean$", col) && col != "gvi_50m") return("Vegetation representative: gvi_50m; alternative scales/components not co-entered")
  # Scene % (sky/building/tree...) are segmentation components behind SVF [Qiu17 p.1]; SVF_Holmer is the standard index.
  if (is_svf_exposure(col) && col != "SVF_Holmer") return("Sky openness represented by SVF_Holmer; scene percentages are separate secondary constructs, not equivalent exposures")
  # Derived/redundant: ucm_OPT is operative temperature, a function of air temperature and MRT [CityFeel17].
  if (col == "ucm_OPT") return("Derived/redundant: ucm_OPT is operative temperature, derived from air temperature and MRT [CityFeel17]")
  ""
}

classify_step2_consolidation <- function(col, role) {
  # fp: definition undocumented; excluded until documented (not a scientific rejection).
  if (col == "ucm_fp") return(c("Measurement definition and units", "UNVERIFIED DEFINITION (EXCLUDED)",
    "The definition, units and intended interpretation of fp have not been verified against source documentation; retain in the inventory but exclude from Step 2 analytical eligibility."))
  if (role != "Environmental Stressor Candidates (X_env)") return(c("N/A - Non-Environmental Stream", "N/A",
    "Non-environmental variable (metadata, demographic, covariate, or outcome)."))
  replacement <- names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))]
  observed <- audit_availability[match(col, audit_availability$Variable_Name), ]
  representation <- h4_step2_representation(col)
  if (nzchar(representation)) return(c("Declared Step 2 exposure representation", "ALTERNATIVE REPRESENTATION (EXCLUDED)", representation))
  # Frequency/semantic sound outputs are separate constructs, not substitutes for calibrated LAeq (dBA).
  if (is_acoustic_frequency(col)) return(c("Separate frequency construct", "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Spectral descriptors remain available for separate frequency analyses; they are not equivalent to dBA and are not deleted from the input."))
  if (is_sound_semantic(col)) return(c("Separate sound-type construct", "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)", "Core sound-level representative is ucm_SND_dBA. Semantic sound-type outputs remain secondary; source type is not equivalent to pressure level."))
  # Bilateral raw channels are replaced by their deterministic average [Zhu24 p.3]; raw RGB/IR channels are uncalibrated
  # conversion inputs [Beiglary25 p.5; Ishihara25 p.10]; residue/labels and the indoor/outdoor flag are not continuous exposures.
  if (length(replacement)) return(c("Declared average source (exact mapping)", "CONSOLIDATED RAW CHANNEL (EXCLUDED)",
    paste0("Source of ", replacement, "; not co-entered with its own deterministic average. This is a study aggregation choice, not evidence that placement bias was eliminated. LYS1/LYS2 measure different wearer locations.")))
  if (grepl("^atmo_lys_LYS[12]__lys_(rgb|[rgb]')", col)) return(c("Auxiliary device colour channels", "AUXILIARY DEVICE CHANNEL (EXCLUDED)",
    "Exported RGB/IR or r'/g'/b' channel; no average or conversion to an independently calibrated H4 exposure is declared. Kept in the inventory, not falsely claimed to be represented by lux. Validate units/calibration and a spectral hypothesis before modeling."))
  if (col %in% c("sound_prop_unidentified", "sound_class_id", "sound_category_label")) return(c("Rule 2.5: Acoustic Residue & Discrete Classifiers",
    "RESIDUAL / DISCRETE CLASSIFIER (EXCLUDED)", "Unclassified residual prevalence and categorical labels excluded from the continuous-exposure screen; calibrated LAeq, YAMNet semantic outputs, and spectral descriptors remain separately auditable."))
  if (col == "ucm_IO_flag") return(c("Rule 2.6: Microclimate Setting Protocol Flag", "DISCRETE PROTOCOL FLAG (EXCLUDED)",
    "Discrete indoor/outdoor setting flag excluded; experimental phase protocol already stratifies outdoor travel routes."))
  if (!is.numeric(df_core[[col]])) return(c("Measurement type", "NON-NUMERIC LABEL (EXCLUDED)",
    "Not a continuous numeric exposure; no valid continuous-effect parameterization is declared. The original field remains in the input."))
  # Within-person effects need >= 2 phases per participant with variation.
  if (observed$Available_Phase_Cells < 2L || observed$Available_Participants < 2L || !is.finite(observed$Within_Person_SD) || observed$Within_Person_SD < 1e-12) {
    rat <- sprintf("Only %d of %d participant-phase cells across %d participants have finite phase means; a within-person effect cannot be estimated from one phase per participant or no centered variation. No imputation; rerun eligibility after broader valid coverage.", observed$Available_Phase_Cells, nrow(h4_prepared_for_vif$data), observed$Available_Participants)
    return(if (is_svf_exposure(col)) c("Within-person estimability / availability", "PENDING SVF PROCESSING / MERGE", paste0("SVF pending merge; not rejected. ", rat))
      else c("Within-person estimability / availability", "INSUFFICIENT WITHIN-PERSON COVERAGE (EXCLUDED)", rat))
  }
  c(if (col %in% c("ucm_WIND_AWA", "ucm_WIND_TWD", "ucm_SUN_az")) "Circular measurement: joint sine/cosine terms required" else "Available numeric measurement",
    "Retained", sprintf("Available in %d phase cells across %d participants after declared representation rules. Eligibility is not proof of measurement validity or automatic model inclusion.", observed$Available_Phase_Cells, observed$Available_Participants))
}
step2_mat <- t(mapply(classify_step2_consolidation, all_variables_pool, step1_mat[, 2], USE.NAMES = FALSE))
cat("[4/6] Step 3: Auditing every Step-2 eligible measurement; no domain shortlist...\n")
h4_audit_step3 <- function(raw, candidates) {
  candidates <- sort(candidates)
  keys <- paste(raw$ParticipantID, raw$PhaseID, sep = "::")
  cells <- sort(unique(keys))
  indices <- lapply(cells, function(key) which(keys == key))
  id <- sub("::.*", "", cells)
  blocks <- setNames(lapply(candidates, function(v) matrix(vapply(indices, function(ix) h4_mean(raw[[v]][ix]), numeric(1)), ncol = 1L)), candidates)
  z <- cbind(Mode_Walk = as.numeric(grepl("::Walk", cells)),
             PC_Movement = vapply(indices, function(ix) h4_mean(raw$empatica_vector_magnitude[ix]), numeric(1)))
  complete <- complete.cases(do.call(cbind, blocks), z)
  omissions <- data.frame(Cell = cells[!complete], Missing = vapply(which(!complete), function(i) paste(c(names(blocks)[!vapply(blocks,
    function(b) all(is.finite(b[i, ])), logical(1))], colnames(z)[!is.finite(z[i, ])]), collapse = ", "), character(1)))
  if (sum(complete) < 4L || length(unique(id[complete])) < 2L) stop("Insufficient common phase cells for screening.")
  center <- function(x) apply(x[complete, , drop = FALSE], 2L, h4_person_mean_center, id = id[complete])
  blocks <- lapply(blocks, center)
  z <- center(z)
  exposure <- do.call(cbind, blocks)
  colnames(exposure) <- unlist(lapply(names(blocks), function(v) if (ncol(blocks[[v]]) == 1L) v else paste0(v, "__", colnames(blocks[[v]]))))
  if (any(apply(cbind(exposure, z), 2, sd) < 1e-12)) stop("Constant column on the common screening sample; review eligibility.")
  pearson <- cor(exposure)
  spearman <- cor(exposure, method = "spearman")
  pair_index <- which(upper.tri(pearson), arr.ind = TRUE)
  pairs <- data.frame(Field1 = rownames(pearson)[pair_index[, 1]], Field2 = colnames(pearson)[pair_index[, 2]],
    Pearson_r = pearson[pair_index], Spearman_rho = spearman[pair_index], N_phase_cells = nrow(exposure))
  pairs <- pairs[order(-abs(pairs$Pearson_r)), ]
  stopifnot(setequal(names(blocks), candidates))
  list(pairs = pairs, omissions = omissions)
}
h4_measurement_sources <- data.frame(Variable_Name = c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_SND_dBA", "ucm_SUN_Gh", "atmo_pm1_avg",
    "atmo_pm2.5_avg", "atmo_pm10_avg", "lys_lux_avg", "lys_medi_avg", "lys_kelvin_avg", "ucm_MRT", "ucm_PET", "ucm_UTCI",
    "ucm_HUMIDEX", "Clearness_Index", "Clearness_Index_G0", "gvi_50m", "ucm_WIND_AWS", "ucm_fp"), Measurement_Code = c(rep("M",
    4), rep("A", 4), rep("D", 9), "M", "U"), Measurement_Type = c(rep("Instrument-reported measurement", 4), rep("Averaged instrument measurement",
    4), rep("Derived metric", 9), "Instrument-reported apparent wind speed (moving platform)", "Definition unverified"), Inputs_or_Definition = c("Air-temperature sensor output",
    "Relative-humidity sensor output", "A-weighted sound-pressure level; calibrated acoustic measurement", "Measured global horizontal solar irradiance",
    "Arithmetic average of left/right Atmotube PM1 outputs", "Arithmetic average of left/right Atmotube PM2.5 outputs", "Arithmetic average of left/right Atmotube PM10 outputs",
    "Arithmetic average of LYS1/LYS2 photopic illuminance; spectral calibration upstream", "Melanopic EDI estimated from LYS RGB channels, not measured spectrally; excluded at Step 2 [Beiglary25 p.5; Ishihara25 p.1, p.7, p.10]",
    "Correlated colour temperature derived from spectral/chromaticity channels, then LYS1/LYS2 average", "Calculated mean radiant temperature from radiative sensor inputs; deployed UCM algorithm not reproduced here",
    "Human heat-balance index using air temperature, radiation/MRT, humidity, wind and person/clothing/metabolic assumptions; deployed assumptions need UCM documentation",
    "Thermal index using air temperature, radiation/MRT, humidity and wind with reference physiological/clothing assumptions; deployed wind correction needs UCM documentation",
    "Humidity index combining air temperature and vapour pressure derived from humidity", "Measured SUN_Gh / calculated G0 (kt = Gh/G0); excluded at Step 2 as derived from ucm_SUN_Gh [ClearCI p.3 eq.2]; exact code in scripts/compute_clearness_index.py",
    "1367 * (1 + 0.033*cos(2*pi*day_of_year/365)) * sin(solar_altitude); calculated extraterrestrial irradiance (not an exposure); excluded at Step 2 [ClearCI p.3 eq.2]",
    "Image-derived vegetation fraction with spatial matching; see canonical GVI source mapping", "Apparent wind speed: airflow at the body including own movement, the convective-cooling-relevant exposure; complete in all core phases",
    "Exported UCM fp field; acronym and formula not verified against a current source manual"), Evidence = c(rep("CityFeel 2017 sensor table; doi:10.1016/j.egypro.2017.07.427",
    4), rep("Existing bilateral average_sources mapping", 4), "Beiglary25 p.5; Ishihara25 p.1, p.7, p.10 (see Step 1/2 reference block)",
    "LYS manufacturer help; Stevenson et al. doi:10.1177/14771535251338582; existing average mapping", rep("CityFeel 2017 section 2.3; exact deployed calculation external", 4), rep("scripts/compute_clearness_index.py",
    2), "scripts/merge_11participant_statistical_inputs.py GVI_SOURCE_ALIASES", "Export name and available pipeline only; exact upstream formula pending",
    "Current source manual not found; no inferred expansion asserted"), stringsAsFactors = FALSE)
h4_measurement_sources <- rbind(h4_measurement_sources, data.frame(Variable_Name = "SVF_Holmer", Measurement_Code = "D",
    Measurement_Type = "Image-derived sky-view factor", Inputs_or_Definition = "Holmer sky-view factor from calibrated upward-camera sky segmentation; key-anchored 10-second means",
    Evidence = "Canonical SVF processing and merge_11participant_statistical_inputs.py; Qiu et al. 2017", stringsAsFactors = FALSE))
classify_step3_domain <- function(col, step2_stat) {
  if (step2_stat == "SECONDARY FREQUENCY BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT", "Preserved for separate frequency analyses; not substituted for the core dBA sound-level representative."))
  if (step2_stat == "SECONDARY SOUND-TYPE BLOCK (NOT CORE SCREEN)") return(c("Acoustic", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "Preserved for separate sound-type analyses; not substituted for the core dBA sound-level representative."))
  if (is_svf_exposure(col) && step2_stat == "PENDING SVF PROCESSING / MERGE") return(c("Sky View / Urban Morphology", "PLANNED CANDIDATE - PROCESSING PENDING", "SVF pending merge; not in the current model."))
  if (step2_stat != "Retained") return(c("N/A", "N/A", "N/A"))
  dom <- if (is_svf_exposure(col)) "Sky View / Urban Morphology" else if (grepl("gvi|tree|grass|plant", col)) "Greenery" else if (grepl("pm", col)) "Air Pollution" else if (grepl("lux|medi|kelvin", col)) "Visual Light" else if (col == "ucm_SND_dBA" || is_acoustic_frequency(col) || is_sound_semantic(col)) "Acoustic" else "Thermal"
  return(c(dom, "DATA-ELIGIBLE SCREENING CANDIDATE", "All Step-2 eligible measurements advance. Step 3 reports within-person Pearson/Spearman correlations and full matrix rank on the same complete phase cells; no health outcomes or hand-picked domain representatives enter selection."))
}
step3_mat <- t(mapply(classify_step3_domain, all_variables_pool, step2_mat[, 2], USE.NAMES = FALSE))
cat("Step 3: Tracing measurement sources and within-person dependencies; no predictor elimination...\n")
screening_candidates <- all_variables_pool[step2_mat[, 2] == "Retained"]
write.csv(h4_prepared_for_vif$coverage, file.path(OUT_DIR, "H4_Phase_Coverage.csv"), row.names = FALSE, na = "")
design_audit <- h4_audit_step3(df_core, screening_candidates)
h4_retained_candidates <- screening_candidates
# Clearness_Index, Clearness_Index_G0 and lys_medi_avg stay in the provenance table but are excluded in Step 2 (derived: Gh/G0; calculated G0; RGB-estimated melanopic EDI).
stopifnot(setequal(screening_candidates, setdiff(h4_measurement_sources$Variable_Name, c("ucm_fp", "Clearness_Index", "Clearness_Index_G0", "lys_medi_avg"))))
step1_criterion <- "Role classification: only X_env candidates proceed; metadata, outcomes, QC, and covariates do not enter exposure selection"
step3_criterion <- "Measurement provenance and dependencies; within-person correlations and full-design rank are descriptive. All Step-2 candidates remain; no final exposure equation selected"
role_outcomes <- rbind(
  c("Derived Light Category (not an independent continuous exposure)", "DERIVED LIGHT CATEGORY", NA),
  c("Physiological Sensor Outcomes (Y_physio)", "PHYSIOLOGICAL OUTCOME (Y)", "Objective physiological outcome; Step 4 uses 10-second summaries with declared HRV logs. Step 5 handles its outcome transformations separately."),
  c("Psychological Survey Outcomes (Y_psych)", "PSYCHOLOGICAL OUTCOME (Y)", "Subjective psychological survey outcome (STAI / PRS) evaluated post-phase."),
  c("Movement & Exertion Covariates (Z)", "MOVEMENT COVARIATE (Z)", NA),
  c("Study Metadata & Spatiotemporal Tracking", "STUDY METADATA", "Spatiotemporal tracking, GPS positioning, or phase grouping metadata."),
  c("Participant Demographics & Clothing Metadata", "DEMOGRAPHIC METADATA", "Baseline participant demographic characteristics or clothing insulation metadata."),
  c("Acoustic Processing QC & Provenance", "QC METRIC", "YAMNet/spectral processing provenance, completeness, timing, or frequency-coverage QC; not an exposure predictor."),
  c("SVF Processing QC & Provenance", "QC METRIC", "SVF calibration, segmentation, run-integrity, telemetry, or manual-validation QC; not an exposure predictor."))
build_final_row <- function(i) {
  col <- all_variables_pool[i]; role <- step1_mat[i, 2]
  step2_stat <- step2_mat[i, 2]; dom <- step3_mat[i, 1]; step3_stat <- step3_mat[i, 2]
  dash <- function(x) ifelse(grepl("^N/A", x), "-", x)
  k <- match(role, role_outcomes[, 1])
  final <- if (col %in% h4_retained_candidates) c("CANDIDATE AFTER MEASUREMENT AUDIT", paste0("Available candidate in ", dom, ". Measurement dependencies are documented; no automatic VIF or correlation elimination. Model membership remains undecided; outcome models have not been refitted."))
    else if (step3_stat %in% c("EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT")) c(step3_stat, step3_mat[i, 3])
    else if (!step2_stat %in% c("N/A", "Retained")) c(if (step2_stat == "CONSOLIDATED RAW CHANNEL (EXCLUDED)") "CONSOLIDATED RAW STREAM (EXCLUDED)" else step2_stat, step2_mat[i, 3])
    else if (!is.na(k)) c(role_outcomes[k, 2], if (is.na(role_outcomes[k, 3])) step1_mat[i, 4] else role_outcomes[k, 3])
    else c("QC METRIC", "Signal quality, missingness verification, or HRV window integrity metric.")
  data.frame(Variable_Name = col, audit_availability[i, c("Available_Phase_Cells", "Available_Participants", "Within_Person_SD")],
    Declared_Average_Replacement = paste(names(average_sources)[vapply(average_sources, function(src) col %in% src, logical(1))], collapse = "; "),
    Platform_Source = step1_mat[i, 1], Native_Unit = step1_mat[i, 3], Scientific_Domain = dash(dom), Step1_Role = role,
    Step1_Criterion = paste0(step1_criterion, "; observed role: ", role),
    Step1_Decision = if (step1_mat[i, 5] == "RETAINED FOR FILTRATION") "Retained" else "-",
    Step2_Rule = dash(step2_mat[i, 1]), Step2_Status = dash(step2_stat), Step2_Decision = if (step2_stat == "Retained") "Retained" else "-",
    Step3_Status = dash(step3_stat),
    Step3_Criterion = paste0(step3_criterion, "; observed domain: ", dash(dom), "; status: ", dash(step3_stat)),
    Step3_Decision = if (step3_stat == "DATA-ELIGIBLE SCREENING CANDIDATE") "Retained" else "-",
    H4_Screening_Candidate = ifelse(col %in% screening_candidates, "Yes", "No"),
    Final_Filtration_Outcome = final[1], Scientific_Filtration_Rationale = final[2], stringsAsFactors = FALSE, row.names = NULL)
}
final_filtration_df <- do.call(rbind, lapply(1:length(all_variables_pool), build_final_row))
source_index <- match(final_filtration_df$Variable_Name, h4_measurement_sources$Variable_Name)
for (field in setdiff(names(h4_measurement_sources), "Variable_Name")) {
    final_filtration_df[[field]] <- h4_measurement_sources[[field]][source_index]
    final_filtration_df[[field]][is.na(final_filtration_df[[field]])] <- "-"
}
outcome_order <- c("CANDIDATE AFTER MEASUREMENT AUDIT", "EXPLORATORY SOUNDSCAPE CONSTRUCT", "EXPLORATORY ACOUSTIC-FREQUENCY CONSTRUCT",
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
    `SVF / urban morphology` = SVF_EXPOSURE_COLUMNS)
integration_df <- do.call(rbind, lapply(names(integration_families), function(fam) {
  expected <- integration_families[[fam]]
  present <- intersect(expected, raw_cols_all)
  missing <- setdiff(expected, raw_cols_all)
  coverage <- audit_availability[match(present, audit_availability$Variable_Name), ]
  minimum_cells <- if (nrow(coverage)) min(coverage$Available_Phase_Cells) else 0L
  data.frame(Family = fam, Expected_N = length(expected), Present_N = length(present), Missing_N = length(missing),
    Status = if (length(present) == 0) "ABSENT" else if (minimum_cells < 2L) if (fam == "SVF / urban morphology") "PLANNED_CANDIDATES_PENDING_PROCESSING_MERGE" else "SCHEMA_PRESENT_BUT_INSUFFICIENT_COVERAGE" else if (length(missing) == 0) "SCHEMA_COMPLETE_CHECK_COVERAGE" else "PARTIAL_SCHEMA_CHECK_COVERAGE",
    Minimum_Available_Phase_Cells = minimum_cells, Expected_Phase_Cells = nrow(h4_prepared_for_vif$data),
    Missing_Columns = if (length(missing)) paste(missing, collapse = "; ") else "", stringsAsFactors = FALSE)
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
    "Step 4 retains all 16 eligible candidates, specifies alternative heat/PM equations, and checks full-design VIF/rank; no automatic deletion.",
    "Participant is the independent cluster. Step 4 defines twelve exploratory heat/PM equations including MRT x sound; Step 5 fits them. Earlier model outputs are historical until a verified rerun succeeds.",
    "## Stage totals", fmt_md_table(stage_totals_report), "## Measurement definitions and dependencies", fmt_md_table(h4_measurement_sources),
    "Step 2 representatives and averages are study choices, not automatic literature rules. LYS1 and LYS2 represent different wearers.",
    "fp remains unverified; true wind speed (TWS) excluded (gaps, undocumented correction); SVF not yet included.",
    "## Within-person design diagnostics", fmt_md_table(design_audit$omissions), fmt_md_table(design_audit$pairs), "Same-data selection and fitting do not provide confirmatory inference.",
    "Sources: https://doi.org/10.1016/j.egypro.2017.07.427")
writeLines(report_lines, TRANSPARENCY_MD, useBytes = TRUE)
cat("\nH4 screening-path counts and domain counts\n")
print(stage_totals_report, row.names = FALSE)
print(step3_counts, row.names = FALSE)
# ---- Step 4: retain candidates and specify/check equations ----
final_filtration_df <- h4_step4_candidates(df_core, final_filtration_df)
tryCatch(write.csv(final_filtration_df, OUT_CSV, row.names = FALSE, na = ""), error = function(e) write.csv(final_filtration_df,
    sub(".csv$", "_latest.csv", OUT_CSV), row.names = FALSE, na = ""))
cat(sprintf("SUCCESS: Exported H4 multivariate audit CSV with %d variables to:\n  %s\n", nrow(final_filtration_df), OUT_CSV))
selected_step2 <- final_filtration_df$Variable_Name[final_filtration_df$Step2_Decision == "Retained"]
stopifnot(!any(grepl("^ucm_IR_|^ucm_.*_(SR|S)$|^ucm_AH$|^ucm_AIR_T_(bot|mid|top)$|IO_flag", selected_step2)),
          identical(grep("^ucm_WIND_", selected_step2, value = TRUE), "ucm_WIND_AWS"),
          identical(grep("^gvi_|^(plant|grass|tree)_phase_mean$", selected_step2, value = TRUE), "gvi_50m"),
          !any(is_acoustic_frequency(selected_step2)),
          all(c("ucm_AIR_temp", "ucm_AIR_RH", "ucm_UTCI", "ucm_SND_dBA") %in% selected_step2))

writeLines(c("Step 3: measurement categories.", "Step 4: retain 16 candidates; specify 12 exploratory heat/PM equations; check full-design rank and VIF including MRT x sound.",
    "Step 5: mixed-model fitting, covariance diagnostics and inference; new equations require a new verified fit."), FORMULA_TXT)

render_audit_pdf(final_filtration_df, AUDIT_PDF, AUDIT_PNG)

# ---- User-facing results: 5 files in output/statistical_analysis/results/H4_results (replaced each run) ----
h4_write_results <- function(audit_df) {
  res_dir <- RESULT_DIR
  md <- file.path(OUT_DIR, "H4_models"); rd <- function(f) read.csv(file.path(md, f), stringsAsFactors = FALSE, check.names = FALSE)
  dir.create(res_dir, recursive = TRUE, showWarnings = FALSE)
  co <- rd("H4_coefficients.csv"); st <- rd("H4_fit_status.csv")
  st$model_note <- trimws(paste(ifelse(st$residual_structure == "independent_fallback", "independent-residual fallback (no q);", ""),
    ifelse(st$boundary_variance %in% TRUE, "boundary random-effect variance;", ""), ifelse(st$high_ar1_flag %in% TRUE, "AR(1) rho > 0.95;", "")))
  k <- match(paste(co$equation, co$outcome), paste(st$heat_form, st$outcome))
  co$n <- st$n[k]; co$model_note <- st$model_note[k]
  fb <- co$residual_structure == "independent_fallback"
  co$q_note <- ifelse(fb, "excluded: fallback fit (independent residuals)", ifelse(!is.na(co$q), "",
    ifelse(co$term_type == "covariate", "not tested: covariate", ifelse(co$term_type == "intercept", "not tested: intercept",
    ifelse(grepl("BikeU", co$term), "derived: BikeU = -(WalkG + WalkU + BikeG)", "")))))
  is_th <- co$term_type == "thermal exposure"
  write.csv(co[is_th, ], file.path(res_dir, "H4_Heat_Noise_Exposures.csv"), row.names = FALSE, na = "")
  write.csv(co[!is_th, ], file.path(res_dir, "H4_Covariates_and_Phases.csv"), row.names = FALSE, na = "")
  # Step 5 role per variable, derived from the fitted terms
  th <- unique(co[co$term_type == "thermal exposure" & !grepl(":", co$term), c("term", "equation")])
  cov <- unique(co$term[co$term_type == "covariate"])
  role <- vapply(audit_df$Variable_Name, function(v) {
    if (v %in% th$term) return(paste0("heat term in Eq '", paste(th$equation[th$term == v], collapse = "', '"), "' (+ x sound)"))
    if (v == "ucm_SND_dBA") return("covariate in all equations + interaction partner (sound)")
    if (v %in% cov) return("covariate in all equations")
    "not used" }, character(1))
  keep <- c("Variable_Name", "Platform_Source", "Native_Unit", "Scientific_Domain", "Step1_Decision", "Step2_Rule", "Step2_Decision",
            "Step3_Decision", "Scientific_Filtration_Rationale", "Step4_Domain", "Step4_Category_Role", "Step4_Decision", "Step4_Restriction")
  write.csv(cbind(audit_df[, keep], Step5_Role = role), file.path(res_dir, "H4_Variable_Selection.csv"), row.names = FALSE, na = "")
  ex <- audit_df[audit_df$Step1_Decision == "Retained" & audit_df$Step2_Decision != "Retained", ]
  ex_tab <- aggregate(Variable_Name ~ Scientific_Filtration_Rationale, ex, function(x) paste(x, collapse = ", "))
  n_tab <- unique(st[, c("outcome", "n", "n_participants")][st$equation_id == 1, ])
  rep_md <- c("# H4 results report", "", "Files: H4_Heat_Noise_Exposures.csv (heat terms and heat x sound terms: the H4 results), H4_Covariates_and_Phases.csv (all other model terms), H4_Variable_Selection.csv (Steps 1-5 per variable), H4_Selection_Flow.pdf.",
    "Working files (models, diagnostics, MD5 manifest H4_models/H4_run_complete.csv) are under H4_results/_work; all H4 saves remain inside H4_results.", "",
    "## Columns of the two results tables (plain language)",
    "- equation: which heat measure the model uses (AIR_temp + AIR_RH + WIND_AWS, HUMIDEX, PET or UTCI). Each model includes sound, distinct radiation/light candidates, phase/exertion and one named PM representation.",
    "- outcome: the body or eye measure being explained (e.g. skin temperature, pupil diameter).",
    "- term: the model input. 'ucm_X' = that exposure; 'ucm_X:SND_dBA' = heat x noise (does noise change the heat effect?); 'Phase: X vs mean of phases' = how phase X differs from the average phase.",
    "- term_type: 'thermal exposure' = heat term or heat x noise term (what H4 tests); 'covariate' = other exposure held constant; 'phase (study design)' = route/mode condition; 'intercept' = baseline level.",
    "- Beta: estimated change in the outcome (in its own units) when the exposure rises by one typical within-bout variation (one pooled SD of within-bout deviations); for phase rows, the difference in outcome units.",
    "- ci_low / ci_high: 95% confidence interval for Beta; if it does not include 0 the effect is distinguishable from zero at p < 0.05.",
    sprintf("- p: probability of a result at least this large if there were no effect. q: p corrected for testing %d outcomes (Benjamini-Hochberg); q < 0.05 is our significance criterion.", length(unique(co$outcome))),
    "- FDR_significant: TRUE if q < 0.05; FALSE otherwise (including blank q).",
    "- q_note: why q is blank (fallback fit, not tested, or derived).",
    "- covariance_robust: TRUE if Beta stays similar when the error-correlation assumptions are changed; FALSE means the result depends on those assumptions and must not be called robust.",
    "- residual_structure: AR1 = standard model allowing correlation between consecutive 10-s windows; independent_fallback = simpler model used only when AR1 failed (not used for significance).",
    "- n: number of 10-second windows in the model. model_note: technical warnings for that model (fallback, near-zero random-effect variance, very high autocorrelation).", "",
    "## Equation design and rationale",
    "Twelve exploratory equations: four heat representations x three separate PM representations. Distinct radiation/light measurements, phase and exertion are retained; heat x sound and MRT x sound are included.",
    "Rationale: thermal indices (PET, UTCI, HUMIDEX) are computed from air temperature, humidity, wind and radiation/MRT and are strongly inter-correlated, so they are not co-entered.",
    "- Zhu et al. 2024 (H1 to H4/H4 - Zhu et al 2024 ...pdf, p.5): \"the high correlation among components may lead to multicollinearity\".",
    "- Weisskopf, Seals & Webster 2018, Environ Health Perspect 126:067003 (H1 to H4/H4 - Weisskopf Seals Webster 2018 ...xml): including highly correlated co-exposures in one model can amplify bias.",
    "- Biel et al. 2020 (H1 to H4/H4 - Biel et al 2020 ...pdf, p.9): related exposure metrics were analysed \"in separate models\".",
    "- Supervision meeting 2026-09-30, s6.4: \"do not put PET + UTCI + MRT + all of their component variables into one model without a deliberate non-redundant selection strategy\".",
    "No located source prescribes this exact candidate-equation set; it is a design choice motivated by the sources above.", "",
    "## Selection limitations requiring review",
    "Step 4 retains candidates without PCA/LASSO. Separate PM and heat representations avoid the flagged combinations; complete-design VIF/rank still require review.",
    "Low VIF does not establish a valid adjustment set, causal interpretation or adequate power. Per-equation FDR does not control a combined family over all twelve alternatives; findings are exploratory.", "",
    grep("^12\\. Main-table columns|Two-variable categories|equivalent to the ClustOfVar", readLines(file.path(md, "H4_hypothesis_readme.txt")), value = TRUE, invert = TRUE), "",
    readLines(file.path(md, "H4_gvif_diagnostic.md")), "",
    "## Sample size per outcome (common complete-exposure rows across candidate equations)", "| outcome | rows | participants |", "|---|---|---|",
    sprintf("| %s | %d | %d |", n_tab$outcome, n_tab$n, n_tab$n_participants), "",
    "## Step 2 exclusions (variables retained at Step 1 but not entering Step 3)", "| reason | variables |", "|---|---|",
    sprintf("| %s | %s |", gsub("\\|", "/", ex_tab$Scientific_Filtration_Rationale), ex_tab$Variable_Name), "",
    "## Session info", "```", readLines(file.path(md, "H4_session_info.txt")), "```")
  writeLines(rep_md, file.path(res_dir, "H4_Report.md"))
  f <- file.path(res_dir, c("H4_Covariates_and_Phases.csv", "H4_Heat_Noise_Exposures.csv", "H4_Report.md", "H4_Selection_Flow.pdf", "H4_Variable_Selection.csv"))
  stopifnot(all(file.exists(f)))
  man <- read.csv(file.path(md, "H4_run_complete.csv"), stringsAsFactors = FALSE)
  add <- man[rep(1L, 5L), ]; add$file <- normalizePath(f, winslash = "/", mustWork = TRUE); add$md5 <- unname(tools::md5sum(f))
  write.csv(rbind(man[!startsWith(man$file, "../") & !basename(man$file) %in% basename(f), ], add), file.path(md, "H4_run_complete.csv"), row.names = FALSE)
  cat("[Results] Wrote", length(f), "files to", res_dir, "\n")
}
run_h4_step5(final_filtration_df, df)
render_h4_faceted_flow()
h4_write_results(final_filtration_df)
cat("H4 multivariate full pipeline completed successfully.\n")
quit(save = "no", status = 0)
