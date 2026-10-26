# Temporary skeleton test: add eq-4 (Components, both_products) fixed terms
# left-to-right in make_design column order; after each step, CR2 p-values on
# heat terms present so far with two BH schemes (family_n_fixed vs family_n_so_far).
# Not part of production H4 dispatch.

root <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final"
out_csv <- file.path(root, "output/statistical_analysis/H4_multivariate/H4_models/_temp_sequential_fdr.csv")
out_md <- file.path(root, "output/statistical_analysis/H4_multivariate/H4_models/_temp_sequential_fdr.md")

source_h4_step5_defs <- function() {
  path <- file.path(root, "scripts/h4_step5_equations.R")
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  anchor <- grep('^if\\(identical\\(Sys\\.getenv\\("H4_TIME_SENSITIVITY"\\)', lines)
  if (length(anchor) != 1L) stop("Could not locate h4_step5 dispatch block")
  exprs <- parse(text = paste(lines[seq_len(anchor - 1L)], collapse = "\n"))
  env <- new.env(parent = globalenv())
  eval(exprs, envir = env)
  env
}

stopifnot(requireNamespace("nlme", quietly = TRUE), requireNamespace("clubSandwich", quietly = TRUE))
h4 <- source_h4_step5_defs()
for (nm in c(
  "raw", "centered", "selected", "thermal", "nonthermal", "H4_SPEC", "outcomes",
  "make_design", "diagnose", "do_fit_with_fallback", "h4_equation_catalog",
  "h4_prep_outcome", "h4_heat_hypothesis_term"
)) assign(nm, get(nm, h4))

eq <- h4_equation_catalog()
eq4 <- eq[eq$equation_id == 4L, , drop = FALSE]
stopifnot(nrow(eq4) == 1L, eq4$heat_form == "Components", eq4$block == "both_products", eq4$test == "Joint")

# Term order = colnames(make_design(...)) left-to-right (production h4_fit_equation uses this matrix).
# Documented order for eq 4 Components Joint:
#   (1) all nonthermal covariates in `nonthermal` sort order,
#   (2) ucm_AIR_temp, ucm_AIR_RH, ucm_MRT,
#   (3) Activity_Bike,
#   (4) for each thermal var in that same order: var:ucm_SND_dBA then var:Activity_Bike.
prep_dummy <- h4_prep_outcome(outcomes[1L], unique(c(nonthermal, thermal$Components)))
if (!prep_dummy$ok) stop("dummy prep failed: ", prep_dummy$note)
full_design <- make_design(prep_dummy$z, thermal$Components, prep_dummy$mode, "Joint")
term_order <- colnames(full_design)
cat("Eq 4 term order (", length(term_order), " fixed terms):\n", paste(term_order, collapse = ", "), "\n", sep = "")

heat_mains <- thermal$Components
n_main_plan <- length(outcomes) * length(heat_mains)
n_prod_plan <- length(outcomes) * length(heat_mains) * 2L

target_outcomes <- if (nzchar(Sys.getenv("H4_SEQ_OUTCOMES"))) {
  strsplit(Sys.getenv("H4_SEQ_OUTCOMES"), ",", fixed = TRUE)[[1]]
} else {
  c("empatica_skin_temperature", "empatica_heart_rate", "eyetracker_pupil_diameter_avg")
}
target_outcomes <- intersect(target_outcomes, outcomes)
if (!length(target_outcomes)) stop("No valid outcomes in H4_SEQ_OUTCOMES / default list")

apply_bh <- function(p, n) {
  o <- rep(NA_real_, length(p))
  ok <- is.finite(p)
  if (any(ok)) o[ok] <- p.adjust(p[ok], method = "BH", n = n)
  o
}

fit_step <- function(prep, cols) {
  y <- prep$y
  d0 <- prep$d0
  yv <- prep$yv
  design <- if (length(cols)) {
    make_design(prep$z, thermal$Components, prep$mode, "Joint")[, cols, drop = FALSE]
  } else {
    matrix(numeric(0), nrow = nrow(prep$z), ncol = 0)
  }
  if (length(cols) && !diagnose(design)$rank) {
    return(list(ok = FALSE, note = "rank deficient at this prefix", coef = NULL))
  }
  safe <- if (ncol(design)) make.names(colnames(design), unique = TRUE) else character()
  if (ncol(design)) colnames(design) <- safe
  fd <- cbind(d0, Y = yv, as.data.frame(design))
  fd <- fd[order(fd$ParticipantID, fd$PhaseID, fd$Time10), ]
  formula <- if (length(safe)) reformulate(safe, response = "Y") else Y ~ 1
  stage <- "fit"
  tryCatch({
    fit_bundle <- do_fit_with_fallback(formula, fd)
    fit <- fit_bundle$fit
    robust <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = fd$ParticipantID, test = "Satterthwaite")
    original <- if (length(cols)) cols else character()
    coefficient <- data.frame(
      term = c("Intercept", original),
      estimate = robust$beta,
      se = robust$SE,
      df = robust$df_Satt,
      stringsAsFactors = FALSE
    )
    coefficient$t_stat <- coefficient$estimate / coefficient$se
    coefficient$p_value <- 2 * pt(-abs(coefficient$t_stat), coefficient$df)
    list(ok = TRUE, coef = coefficient, note = "")
  }, error = function(e) list(ok = FALSE, note = paste0(stage, ": ", conditionMessage(e)), coef = NULL))
}

summarize_heat <- function(coef_df, bh_mode) {
  if (is.null(coef_df) || !nrow(coef_df)) {
    return(data.frame(term = character(), p_value = numeric(), q_value = numeric(), heat_role = character()))
  }
  heat <- coef_df[coef_df$term != "Intercept", , drop = FALSE]
  heat <- heat[vapply(heat$term, h4_heat_hypothesis_term, logical(1L), heat_vars = heat_mains), , drop = FALSE]
  if (!nrow(heat)) return(heat)
  heat$heat_role <- ifelse(heat$term %in% heat_mains, "heat_main", "heat_product")
  mains <- heat$term %in% heat_mains
  prods <- !mains
  heat$q_value <- NA_real_
  if (bh_mode == "family_n_fixed") {
    if (any(mains)) heat$q_value[mains] <- apply_bh(heat$p_value[mains], n_main_plan)
    if (any(prods)) heat$q_value[prods] <- apply_bh(heat$p_value[prods], n_prod_plan)
  } else if (bh_mode == "family_n_so_far") {
    if (any(mains)) heat$q_value[mains] <- apply_bh(heat$p_value[mains], sum(mains))
    if (any(prods)) heat$q_value[prods] <- apply_bh(heat$p_value[prods], sum(prods))
  } else stop("unknown bh_mode")
  heat
}

rows <- list()
for (y in target_outcomes) {
  message("Outcome: ", y)
  required <- unique(c(nonthermal, thermal$Components))
  prep <- h4_prep_outcome(y, required)
  if (!prep$ok) {
    warning("Skipping ", y, ": ", prep$note)
    next
  }
  prefixes <- c(list(character()), lapply(seq_along(term_order), function(k) term_order[seq_len(k)]))
  for (k in seq_along(prefixes)) {
    cols <- prefixes[[k]]
    fit <- fit_step(prep, cols)
    for (bh_mode in c("family_n_fixed", "family_n_so_far")) {
      heat <- if (isTRUE(fit$ok)) summarize_heat(fit$coef, bh_mode) else NULL
      n_mains <- sum(heat$heat_role == "heat_main", na.rm = TRUE)
      n_q05_mains <- sum(heat$heat_role == "heat_main" & is.finite(heat$q_value) & heat$q_value < 0.05, na.rm = TRUE)
      if (is.null(heat) || !nrow(heat)) {
        rows[[length(rows) + 1L]] <- data.frame(
          outcome = y, step = k - 1L, n_fixed_terms = length(cols), terms_added = paste(cols, collapse = " | "),
          fit_ok = isTRUE(fit$ok), fit_note = fit$note, bh_scheme = bh_mode,
          heat_term = NA_character_, heat_role = NA_character_, p_value = NA_real_, q_value = NA_real_,
          n_heat_mains_in_model = n_mains, n_heat_mains_q_lt_0.05 = n_q05_mains,
          stringsAsFactors = FALSE
        )
      } else {
        for (i in seq_len(nrow(heat))) {
          rows[[length(rows) + 1L]] <- data.frame(
            outcome = y, step = k - 1L, n_fixed_terms = length(cols), terms_added = paste(cols, collapse = " | "),
            fit_ok = TRUE, fit_note = "", bh_scheme = bh_mode,
            heat_term = heat$term[i], heat_role = heat$heat_role[i],
            p_value = heat$p_value[i], q_value = heat$q_value[i],
            n_heat_mains_in_model = n_mains, n_heat_mains_q_lt_0.05 = n_q05_mains,
            stringsAsFactors = FALSE
          )
        }
      }
    }
    message("  step ", k - 1L, "/", length(term_order), " n_terms=", length(cols), " ok=", isTRUE(fit$ok))
  }
}

res <- do.call(rbind, rows)
rownames(res) <- NULL
dir.create(dirname(out_csv), recursive = TRUE, showWarnings = FALSE)
write.csv(res, out_csv, row.names = FALSE, na = "")

# Markdown summary
md <- c(
  "# Sequential FDR skeleton (eq 4 Components, both_products)",
  "",
  paste0("Outcomes: ", paste(target_outcomes, collapse = ", ")),
  paste0("Fixed-term order (", length(term_order), "): ", paste(term_order, collapse = ", ")),
  "",
  paste0("Production BH family sizes (Components): heat mains n=", n_main_plan, "; heat products n=", n_prod_plan, "."),
  "",
  "## Question: Does FDR shrink (q inflate / fewer q<0.05) as covariates are added left-to-right?",
  ""
)

interpret <- function(sub, label) {
  c(
    paste0("### ", label),
    ""
  )
}

for (y in target_outcomes) {
  sub <- res[res$outcome == y & res$bh_scheme == "family_n_fixed" & res$heat_role == "heat_main" & is.finite(res$q_value), ]
  steps <- sort(unique(sub$step))
  sig_by_step <- vapply(steps, function(s) {
    ss <- sub[sub$step == s, ]
    sum(is.finite(ss$q_value) & ss$q_value < 0.05)
  }, numeric(1))
  max_q_air <- vapply(steps, function(s) {
    hit <- sub[sub$step == s & sub$heat_term == "ucm_AIR_temp", "q_value"]
    if (length(hit)) hit[1] else NA_real_
  }, numeric(1))
  md <- c(
    md,
    paste0("## ", y, " (family_n_fixed, heat mains)"),
    paste0("- Steps with heat mains present: ", paste(steps, collapse = ", ")),
    paste0("- Count q<0.05 among heat mains by step: ", paste(sig_by_step, collapse = " -> ")),
    paste0("- ucm_AIR_temp q by step: ", paste(format(max_q_air, digits = 4), collapse = " -> ")),
    ""
  )
}

md <- c(
  md,
  "## Interpretation (automated read)",
  "",
  "Under **family_n_fixed**, BH denominator stays at the all-26-outcomes planned n (78 mains); adding covariates changes only the focal p-values, so q-values for heat mains can move up or down with estimate/SE shifts—not monotonic 'FDR reduction'.",
  "",
  "Under **family_n_so_far**, the BH family grows as heat mains enter the model; early steps use smaller n, which tends to **lower** q relative to the full family for the same raw p.",
  "",
  paste0("Full table: `", out_csv, "`"),
  ""
)

writeLines(md, out_md)
cat("Wrote ", out_csv, " (", nrow(res), " rows) and ", out_md, "\n", sep = "")
