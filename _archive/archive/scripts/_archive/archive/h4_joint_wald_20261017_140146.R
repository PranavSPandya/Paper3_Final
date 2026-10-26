# Additional H4 joint exposure-block Wald tests (CR2 + HTZ Wald, small-cluster).
# Does not replace coefficient-level H4_coefficients.csv or re-fit policy for all-16.
# Run: Rscript scripts/h4_joint_wald.R

suppressMessages({ library(nlme); library(clubSandwich) })
root_dir <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final"
setwd(root_dir)
out_dir <- file.path(root_dir, "output/statistical_analysis/H4_multivariate/H4_models")
workers <- max(1L, min(6L, parallel::detectCores() - 1L))

exprs <- parse(file.path(root_dir, "scripts/h4_step5_equations.R"))
is_dispatch <- vapply(exprs, function(e) is.call(e) && identical(e[[1]], as.name("if")) &&
  any(grepl("H4_STEP5_EQ1", deparse(e)[1:3], fixed = TRUE)), logical(1))
stopifnot(sum(is_dispatch) == 1L)
for (e in exprs[!is_dispatch]) eval(e, globalenv())
catalog <- h4_equation_catalog()
required_all <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))

h4_wald_block_terms <- function(eq) {
  hv <- thermal[[eq$heat_form]]
  out <- list(thermal_main = hv)
  if (eq$block %in% c("heat_x_sound", "both_products"))
    out$thermal_x_sound <- paste0(hv, ":SND_dBA")
  if (eq$block %in% c("heat_x_activity", "both_products"))
    out$thermal_x_activity <- paste0(hv, ":Activity_Bike")
  out
}

fit_for_wald <- function(prep, eq) {
  design <- make_design(prep$z, thermal[[eq$heat_form]], prep$mode, eq$test)
  if (!diagnose(design)$rank) stop("design rank deficient")
  original <- colnames(design)
  safe <- make.names(original, unique = TRUE)
  colnames(design) <- safe
  fd <- cbind(prep$d0, Y = prep$yv, as.data.frame(design))
  fd <- fd[order(fd$ParticipantID, fd$PhaseID, fd$Time10), , drop = FALSE]
  formula <- reformulate(safe, response = "Y")
  fit <- do_fit_with_fallback(formula, fd)$fit
  list(fit = fit, fd = fd, original = original, safe = safe)
}

wald_blocks_one_outcome <- function(y) {
  prep <- h4_prep_outcome(y, required_all)
  rows <- list()
  if (!prep$ok) {
    for (i in seq_len(nrow(catalog))) for (bn in names(h4_wald_block_terms(catalog[i, ]))) {
      eq <- catalog[i, ]
      rows[[length(rows) + 1L]] <- data.frame(
        outcome = y, equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block,
        wald_block = bn, n_terms = NA_integer_, stat = NA_real_, df_num = NA_real_, df_denom = NA_real_,
        p_value = NA_real_, success = FALSE, note = prep$note, stringsAsFactors = FALSE)
    }
    return(do.call(rbind, rows))
  }
  for (i in seq_len(nrow(catalog))) {
    eq <- catalog[i, , drop = FALSE]
    blocks <- h4_wald_block_terms(eq)
    fit_info <- tryCatch(fit_for_wald(prep, eq), error = function(e) e)
    if (inherits(fit_info, "error")) {
      for (bn in names(blocks)) {
        rows[[length(rows) + 1L]] <- data.frame(
          outcome = y, equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block,
          wald_block = bn, n_terms = length(blocks[[bn]]), stat = NA_real_, df_num = NA_real_, df_denom = NA_real_,
          p_value = NA_real_, success = FALSE, note = conditionMessage(fit_info), stringsAsFactors = FALSE)
      }
      next
    }
    name_map <- stats::setNames(fit_info$safe, fit_info$original)
    for (bn in names(blocks)) {
      terms <- blocks[[bn]]
      coefs <- name_map[terms]
      if (any(is.na(coefs))) {
        rows[[length(rows) + 1L]] <- data.frame(
          outcome = y, equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block,
          wald_block = bn, n_terms = length(terms), stat = NA_real_, df_num = NA_real_, df_denom = NA_real_,
          p_value = NA_real_, success = FALSE, note = "term not in fitted model", stringsAsFactors = FALSE)
        next
      }
      beta <- nlme::fixef(fit_info$fit)
      cons <- clubSandwich::constrain_zero(constraints = unname(coefs), coefs = beta)
      wt <- tryCatch(
        clubSandwich::Wald_test(fit_info$fit, vcov = "CR2", cluster = fit_info$fd$ParticipantID,
          constraints = cons, test = "HTZ"),
        error = function(e) e)
      if (inherits(wt, "error")) {
        rows[[length(rows) + 1L]] <- data.frame(
          outcome = y, equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block,
          wald_block = bn, n_terms = length(terms), stat = NA_real_, df_num = NA_real_, df_denom = NA_real_,
          p_value = NA_real_, success = FALSE, note = conditionMessage(wt), stringsAsFactors = FALSE)
      } else {
        htz <- wt[wt$test == "HTZ", , drop = FALSE]
        if (!nrow(htz)) htz <- wt[1, , drop = FALSE]
        rows[[length(rows) + 1L]] <- data.frame(
          outcome = y, equation_id = eq$equation_id, heat_form = eq$heat_form, block = eq$block,
          wald_block = bn, n_terms = length(terms), stat = htz$Fstat[1], df_num = htz$df_num[1],
          df_denom = htz$df_denom[1], p_value = htz$p_val[1], success = TRUE,
          note = paste(terms, collapse = "; "), stringsAsFactors = FALSE)
      }
    }
  }
  do.call(rbind, rows)
}

message("Joint Wald tests: ", length(outcomes), " outcomes x ", nrow(catalog), " equations (", workers, " workers)")
cl <- parallel::makeCluster(workers)
on.exit(try(parallel::stopCluster(cl), silent = TRUE), add = TRUE)
parallel::clusterEvalQ(cl, { library(nlme); library(clubSandwich); NULL })
parallel::clusterExport(cl, c("catalog", "required_all", "outcomes", "nonthermal", "thermal", "raw", "centered",
  "H4_SPEC", "make_design", "do_fit", "do_fit_with_fallback", "h4_empirical_ar1_rho", "h4_lme_ar1", "diagnose",
  "h4_prep_outcome", "h4_wald_block_terms", "fit_for_wald", "wald_blocks_one_outcome"), envir = globalenv())
pieces <- parallel::parLapply(cl, outcomes, wald_blocks_one_outcome)
wald <- do.call(rbind, pieces)
rownames(wald) <- NULL
wald$fdr_family <- paste0("joint_", tolower(wald$heat_form), "_", wald$wald_block)
wald$q_value <- NA_real_
for (fam in unique(wald$fdr_family)) {
  ix <- which(wald$fdr_family == fam)
  ok <- ix[is.finite(wald$p_value[ix])]
  if (length(ok)) wald$q_value[ok] <- p.adjust(wald$p_value[ok], method = "BH", n = length(ix))
}
write.csv(wald, file.path(out_dir, "H4_joint_wald_tests.csv"), row.names = FALSE, na = "")

h4_joint_wald_write_derived <- function(wald, out_dir) {
  coef_path <- file.path(out_dir, "H4_coefficients.csv")
  coef_note <- "joint block test; see H4_coefficients.csv for term-level estimates"
  if (file.exists(coef_path)) {
    coef_read <- tryCatch(
      read.csv(coef_path, check.names = FALSE, stringsAsFactors = FALSE),
      error = function(e) {
        message("Note: could not read H4_coefficients.csv (", conditionMessage(e), "); writing joint outputs without merge.")
        NULL
      })
    if (!is.null(coef_read)) coef_note <- paste0(coef_note, " (", nrow(coef_read), " coefficient rows on disk)")
  } else {
    message("Note: H4_coefficients.csv not found; writing joint outputs without merge.")
  }
  merged <- wald
  merged$coefficient_note <- coef_note
  write.csv(merged, file.path(out_dir, "H4_joint_wald_with_coefficients.csv"), row.names = FALSE, na = "")

  lines <- c(
    "# H4 joint Wald block tests (additional analysis)",
    "",
    "Tests whether **groups of exposure terms** are jointly zero (CR2 HTZ Wald).",
    "Does not replace term-by-term coefficients in `H4_coefficients.csv`.",
    paste("Generated:", Sys.time()),
    paste("Rows:", nrow(wald), "| successes:", sum(wald$success)),
    "",
    "## FDR families",
    "Separate Benjamini-Hochberg on p-values within each `fdr_family` = joint_<heat_form>_<wald_block>,",
    "with denominator = all declared tests in that family (including failures).",
    "",
    "## Notable q < 0.05",
    paste(capture.output(print(wald[is.finite(wald$q_value) & wald$q_value < 0.05,
      c("outcome", "equation_id", "heat_form", "wald_block", "p_value", "q_value")], row.names = FALSE)), collapse = "\n")
  )
  writeLines(lines, file.path(out_dir, "H4_joint_wald_summary.md"))
  invisible(list(merged = merged, n_q05 = sum(is.finite(wald$q_value) & wald$q_value < 0.05)))
}

h4_joint_wald_write_derived(wald, out_dir)
message(sprintf("Wrote H4_joint_wald_tests.csv (%d rows, %d successes)", nrow(wald), sum(wald$success)))
