# H4 CR2 reliability review (POST-HOC, diagnostic only).
#
# Does NOT replace or overwrite the published H4 inference tables. It reads the
# published all-16 H4_models bundle, re-uses the Step-5 model definitions from
# scripts/h4_step5_equations.R (loaded WITHOUT running its dispatcher), and writes
# only new files into output/statistical_analysis/H4_multivariate/H4_models/:
#
#   H4_CR2_coefficient_df.csv          item 1: coefficient-specific CR2 Satterthwaite df, all 16 equations
#   H4_CR2_df_driver_summary.csv       item 1: which term sets each equation's min_cr2_df
#   H4_sensitivity_main_effects.csv    item 2: POST-HOC heat main effects, no_products vs both_products,
#                                      plus PM2.5-free refits for flagged outcomes
#   H4_skin_air_LOO_CR2.csv            item 3: leave-one-participant-out refits WITH CR2 df (skin temp)
#   H4_skin_air_phase_checks.csv       item 3: leave-one-phase-out refits + per-bout slopes (skin temp)
#   H4_simulation_summary.csv          item 4: parametric simulation (B >= 200) on eq 4 Components skin temp
#   H4_simulation_draws.csv            item 4: per-replicate draws
#   H4_CR2_reliability_review.md       executive summary
#
# Usage:  Rscript scripts/h4_cr2_reliability_review.R
# Env:    H4_REVIEW_B=200 (simulation replicates per scenario, min 200 enforced for the published run)
#         H4_REVIEW_STAGE=all|1|2|3|4|md   (default all; later stages re-use saved CSVs)
#         H4_REVIEW_WORKERS=4

suppressMessages({ library(nlme); library(clubSandwich) })
root_dir <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final"
setwd(root_dir)
out_dir <- file.path(root_dir, "output/statistical_analysis/H4_multivariate/H4_models")
B <- as.integer(Sys.getenv("H4_REVIEW_B", "200"))
stage <- Sys.getenv("H4_REVIEW_STAGE", "all")
workers <- as.integer(Sys.getenv("H4_REVIEW_WORKERS", "4"))
run_stage <- function(s) stage %in% c("all", s)
OUTCOME <- "empatica_skin_temperature"
AIR <- "ucm_AIR_temp"

# ---- load Step-5 definitions without running the dispatcher ------------------------------
exprs <- parse(file.path(root_dir, "scripts/h4_step5_equations.R"))
is_dispatch <- vapply(exprs, function(e) is.call(e) && identical(e[[1]], as.name("if")) &&
  any(grepl("H4_STEP5_EQ1", deparse(e)[1:3], fixed = TRUE)), logical(1))
stopifnot(sum(is_dispatch) == 1L)
for (e in exprs[!is_dispatch]) eval(e, globalenv())
catalog <- h4_equation_catalog()

coefs <- read.csv(file.path(out_dir, "H4_coefficients.csv"), check.names = FALSE, stringsAsFactors = FALSE)
status <- read.csv(file.path(out_dir, "H4_fit_status.csv"), check.names = FALSE, stringsAsFactors = FALSE)
diag_csv <- read.csv(file.path(out_dir, "H4_diagnostics.csv"), check.names = FALSE, stringsAsFactors = FALSE)

term_class <- function(term, heat_form) {
  heat_vars <- thermal[[heat_form]]
  if (term == "Intercept") return("intercept")
  if (term %in% heat_vars) return("heat_main")
  if (h4_heat_hypothesis_term(term, heat_vars)) return("heat_product")
  if (term == "atmo_pm2.5_avg") return("pm25_covariate")
  if (term == "Activity_Bike") return("activity")
  "other_covariate"
}

# =========================================================================================
# ITEM 1: coefficient-specific CR2 Satterthwaite df, all 16 equations
# =========================================================================================
if (run_stage("1")) {
  message("ITEM 1: coefficient-specific df")
  cf <- coefs[coefs$term != "Intercept", c("equation_id", "heat_form", "block", "outcome", "term", "estimate", "se", "df", "p_value")]
  cf$term_class <- mapply(term_class, cf$term, cf$heat_form)
  cf$df_lt4 <- is.finite(cf$df) & cf$df < 4
  cf$df_lt2 <- is.finite(cf$df) & cf$df < 2
  write.csv(cf, file.path(out_dir, "H4_CR2_coefficient_df.csv"), row.names = FALSE)

  key <- paste(cf$equation_id, cf$outcome)
  drv <- do.call(rbind, lapply(split(cf, key), function(s) {
    s <- s[is.finite(s$df), , drop = FALSE]
    if (!nrow(s)) return(NULL)
    i <- which.min(s$df)
    h <- s[s$term_class %in% c("heat_main", "heat_product"), , drop = FALSE]
    hi <- if (nrow(h)) which.min(h$df) else NA_integer_
    data.frame(equation_id = s$equation_id[1], heat_form = s$heat_form[1], block = s$block[1], outcome = s$outcome[1],
      min_df_all = s$df[i], min_df_term = s$term[i], min_df_term_class = s$term_class[i],
      min_df_heat = if (nrow(h)) h$df[hi] else NA_real_, min_df_heat_term = if (nrow(h)) h$term[hi] else NA_character_,
      n_heat_terms = nrow(h), n_heat_df_lt4 = sum(h$df < 4), n_heat_df_lt2 = sum(h$df < 2),
      flag_equation_wide_low_df = s$df[i] < 4, flag_heat_low_df = nrow(h) > 0 && h$df[hi] < 4,
      stringsAsFactors = FALSE)
  }))
  rownames(drv) <- NULL
  drv <- drv[order(drv$equation_id, drv$outcome), ]
  write.csv(drv, file.path(out_dir, "H4_CR2_df_driver_summary.csv"), row.names = FALSE)
  message("  wrote coefficient_df (", nrow(cf), " rows) and driver summary (", nrow(drv), " rows)")
}

# ---- shared: prepare skin-temp data / design -----------------------------------------------
prep_skin <- function(heat_form = "Components", drop_pm25 = FALSE) {
  nt <- if (drop_pm25) setdiff(nonthermal, "atmo_pm2.5_avg") else nonthermal
  req <- unique(c(nt, thermal[[heat_form]]))
  h4_prep_outcome(OUTCOME, req)
}
row_of <- function(co, eq_id, term) {
  h <- co[co$equation_id == eq_id & co$term == term, , drop = FALSE]
  if (nrow(h) != 1L) return(data.frame(estimate = NA_real_, se = NA_real_, df = NA_real_, p_value = NA_real_))
  h[, c("estimate", "se", "df", "p_value")]
}

# =========================================================================================
# ITEM 2: POST-HOC main-effects sensitivity
# =========================================================================================
if (run_stage("2")) {
  message("ITEM 2: POST-HOC main-effects sensitivity")
  # (a) published fits: heat main effects without products (eq 1/5/9/13) vs with products (eq 4/8/12/16)
  pairs <- data.frame(heat_form = c("Components", "HUMIDEX", "PET", "UTCI"), eq_main = c(1L, 5L, 9L, 13L), eq_both = c(4L, 8L, 12L, 16L))
  rows <- list()
  for (i in seq_len(nrow(pairs))) for (y in unique(coefs$outcome)) for (v in thermal[[pairs$heat_form[i]]]) {
    a <- coefs[coefs$equation_id == pairs$eq_main[i] & coefs$outcome == y & coefs$term == v, ]
    b <- coefs[coefs$equation_id == pairs$eq_both[i] & coefs$outcome == y & coefs$term == v, ]
    if (nrow(a) != 1L || nrow(b) != 1L) next
    rows[[length(rows) + 1L]] <- data.frame(analysis = "POST-HOC published-fit comparison", outcome = y, heat_form = pairs$heat_form[i], term = v,
      spec_main_only = paste0("eq", pairs$eq_main[i], " no_products"), est_main_only = a$estimate, se_main_only = a$se, df_main_only = a$df, p_main_only = a$p_value,
      spec_with_products = paste0("eq", pairs$eq_both[i], " both_products"), est_with_products = b$estimate, se_with_products = b$se, df_with_products = b$df, p_with_products = b$p_value,
      same_sign = sign(a$estimate) == sign(b$estimate), p_lt05_main_only = a$p_value < .05, p_lt05_with_products = b$p_value < .05,
      significance_changes = (a$p_value < .05) != (b$p_value < .05), note = "", stringsAsFactors = FALSE)
  }
  sens_a <- do.call(rbind, rows)

  # (b) PM2.5-free refits (PM2.5 is the post-hoc covariate that sets min_cr2_df). Run for skin temp
  #     plus every outcome whose equation 4 min df is < 4 while all Components heat dfs are >= 4.
  drv <- read.csv(file.path(out_dir, "H4_CR2_df_driver_summary.csv"), stringsAsFactors = FALSE)
  flagged <- unique(c(OUTCOME, drv$outcome[drv$equation_id == 4L & drv$flag_equation_wide_low_df]))
  message("  PM2.5-free refits for ", length(flagged), " outcomes: ", paste(flagged, collapse = ", "))
  nonthermal_saved <- nonthermal
  nonthermal <- setdiff(nonthermal_saved, "atmo_pm2.5_avg")
  refit <- lapply(flagged, function(y) tryCatch(fit_h4_outcome(y, c(1L, 4L)), error = function(e) NULL))
  nonthermal <- nonthermal_saved
  rows <- list()
  for (k in seq_along(flagged)) {
    r <- refit[[k]]; y <- flagged[k]
    if (is.null(r) || !nrow(r$coef)) next
    for (v in component_set) {
      a0 <- coefs[coefs$equation_id == 1L & coefs$outcome == y & coefs$term == v, ]
      b0 <- coefs[coefs$equation_id == 4L & coefs$outcome == y & coefs$term == v, ]
      a1 <- r$coef[r$coef$equation_id == 1L & r$coef$term == v, ]
      b1 <- r$coef[r$coef$equation_id == 4L & r$coef$term == v, ]
      for (eqid in c(1L, 4L)) {
        o <- if (eqid == 1L) a0 else b0; n <- if (eqid == 1L) a1 else b1
        if (nrow(o) != 1L || nrow(n) != 1L) next
        rows[[length(rows) + 1L]] <- data.frame(analysis = "POST-HOC PM2.5-free refit", outcome = y, heat_form = "Components", term = v,
          spec_main_only = paste0("eq", eqid, " published (with PM2.5)"), est_main_only = o$estimate, se_main_only = o$se, df_main_only = o$df, p_main_only = o$p_value,
          spec_with_products = paste0("eq", eqid, " refit WITHOUT PM2.5"), est_with_products = n$estimate, se_with_products = n$se, df_with_products = n$df, p_with_products = n$p_value,
          same_sign = sign(o$estimate) == sign(n$estimate), p_lt05_main_only = o$p_value < .05, p_lt05_with_products = n$p_value < .05,
          significance_changes = (o$p_value < .05) != (n$p_value < .05),
          note = paste0("n_published=", status$n[status$equation_id == eqid & status$outcome == y], "; n_refit=", r$status$n[r$status$equation_id == eqid]),
          stringsAsFactors = FALSE)
      }
    }
  }
  sens <- rbind(sens_a, do.call(rbind, rows))
  sens$label <- "POST-HOC sensitivity; not part of the published inference family"
  write.csv(sens, file.path(out_dir, "H4_sensitivity_main_effects.csv"), row.names = FALSE)
  message("  wrote sensitivity rows: ", nrow(sens))
}

# =========================================================================================
# ITEM 3: LOO + participant / phase checks, skin temperature <- air temperature
# =========================================================================================
if (run_stage("3")) {
  message("ITEM 3: LOO with CR2, leave-one-phase-out, per-bout slopes")
  prep <- prep_skin()
  pids <- sort(unique(as.character(prep$d0$ParticipantID)))
  phs <- sort(unique(as.character(prep$d0$PhaseID)))
  full <- fit_h4_outcome(OUTCOME, c(1L, 4L))
  keep_terms <- c(component_set, "atmo_pm2.5_avg")
  pack <- function(res, label, kind, dropped) {
    if (is.null(res$coef) || !nrow(res$coef)) return(NULL)
    cc <- res$coef[res$coef$term %in% keep_terms, ]
    data.frame(kind = kind, dropped = dropped, equation_id = cc$equation_id, term = cc$term, estimate = cc$estimate, se = cc$se, df = cc$df,
      p_value = cc$p_value, n = res$status$n[match(cc$equation_id, res$status$equation_id)],
      n_participants = res$status$n_participants[match(cc$equation_id, res$status$equation_id)], stringsAsFactors = FALSE)
  }
  out <- list(pack(full, "full", "full_sample", "none"))
  for (pid in pids) out[[length(out) + 1L]] <- pack(fit_h4_outcome(OUTCOME, c(1L, 4L), drop_participant = pid), "loo", "leave_one_participant", pid)
  # leave-one-phase-out: filter prepared rows, keep the same design/centering
  fit_phase_drop <- function(ph) {
    p2 <- prep; keep <- as.character(prep$d0$PhaseID) != ph
    p2$d0 <- droplevels(prep$d0[keep, , drop = FALSE]); p2$z <- prep$z[keep, , drop = FALSE]; p2$yv <- prep$yv[keep]; p2$mode <- prep$mode[keep]
    eqs <- catalog[catalog$equation_id %in% c(1L, 4L), ]
    res <- lapply(seq_len(nrow(eqs)), function(i) h4_fit_equation(p2, eqs[i, ]))
    list(status = do.call(rbind, lapply(res, `[[`, "status")), coef = do.call(rbind, lapply(res, `[[`, "coef")))
  }
  for (ph in phs) out[[length(out) + 1L]] <- pack(fit_phase_drop(ph), "lopo", "leave_one_phase", ph)
  loo <- do.call(rbind, out)
  loo$full_estimate <- vapply(seq_len(nrow(loo)), function(i) {
    f <- loo[loo$kind == "full_sample" & loo$equation_id == loo$equation_id[i] & loo$term == loo$term[i], "estimate"]
    if (length(f) == 1L) f else NA_real_
  }, numeric(1))
  loo$sign_flip <- ifelse(loo$kind == "full_sample", NA, sign(loo$estimate) != sign(loo$full_estimate))
  loo$pct_change <- 100 * (loo$estimate - loo$full_estimate) / abs(loo$full_estimate)
  loo$p_lt05 <- loo$p_value < .05
  write.csv(loo, file.path(out_dir, "H4_skin_air_LOO_CR2.csv"), row.names = FALSE)

  # per participant x phase within-bout slope (raw ucm_AIR_temp deg C on skin temperature deg C)
  d <- prep$d0
  d$skin <- prep$yv; d$air_z <- prep$z[, AIR]
  d$air_raw <- raw[[AIR]][match(paste(d$ParticipantID, d$PhaseID, d$Datetime), paste(raw$ParticipantID, raw$PhaseID, raw$Datetime))]
  bout_rows <- lapply(split(d, interaction(d$ParticipantID, d$PhaseID, drop = TRUE)), function(s) {
    if (nrow(s) < 10 || sd(s$air_z) < 1e-9) return(NULL)
    fit <- lm(skin ~ air_z, data = s)
    data.frame(participant = as.character(s$ParticipantID[1]), phase = as.character(s$PhaseID[1]), mode = substr(as.character(s$PhaseID[1]), 1, 4),
      n = nrow(s), slope_per_air_SD = unname(coef(fit)[2]), r = cor(s$skin, s$air_z), stringsAsFactors = FALSE)
  })
  bouts <- do.call(rbind, bout_rows)
  # participant-level within-person correlation (participant-mean-centred, all phases)
  pc <- do.call(rbind, lapply(split(d, d$ParticipantID), function(s) data.frame(participant = as.character(s$ParticipantID[1]), phase = "ALL",
    mode = "ALL", n = nrow(s), slope_per_air_SD = unname(coef(lm(skin ~ air_z, data = s))[2]), r = cor(s$skin, s$air_z), stringsAsFactors = FALSE)))
  bout_all <- rbind(pc, bouts)
  rownames(bout_all) <- NULL
  write.csv(bout_all, file.path(out_dir, "H4_skin_air_phase_checks.csv"), row.names = FALSE)
  message("  wrote LOO/LOPO (", nrow(loo), " rows) and bout checks (", nrow(bout_all), " rows)")
}

# =========================================================================================
# ITEM 4: simulation, eq 4 Components skin-temperature structure (B >= 200 per scenario)
# =========================================================================================
sim_replicate <- function(i, ctx, scenario) {
  set.seed(ctx$seed + i * 1000L + scenario$offset)
  fd <- ctx$fd
  bout_id <- ctx$bout; pid <- ctx$pid
  u_p <- rnorm(ctx$n_p, 0, ctx$sd_p)[pid]
  u_b <- rnorm(ctx$n_b, 0, ctx$sd_b)[bout_id]
  eps <- numeric(nrow(fd))
  for (g in ctx$groups) {  # AR1 on 10-s index, correlation rho^|dt|
    idx <- g; tt <- fd$Time10[idx]
    e <- numeric(length(idx)); e[1] <- rnorm(1)
    for (k in seq_along(idx)[-1]) {
      a <- ctx$rho^abs(tt[k] - tt[k - 1L])
      e[k] <- a * e[k - 1L] + sqrt(max(1 - a^2, 0)) * rnorm(1)
    }
    eps[idx] <- ctx$sigma * e
  }
  fd$Y <- as.vector(ctx$X %*% scenario$beta) + u_p + u_b + eps
  res <- tryCatch({
    fit <- tryCatch(do_fit(ctx$formula, fd, "nlminb"), error = function(e) do_fit(ctx$formula, fd, "optim"))
    ct <- clubSandwich::coef_test(fit, vcov = "CR2", cluster = fd$ParticipantID, test = "Satterthwaite")
    data.frame(rep = i, scenario = scenario$name, term = names(nlme::fixef(fit)), estimate = ct$beta, se = ct$SE, df = ct$df_Satt,
      truth = scenario$beta[names(nlme::fixef(fit))], stringsAsFactors = FALSE)
  }, error = function(e) NULL)
  res
}

if (run_stage("4")) {
  stopifnot(B >= 200L)
  message("ITEM 4: simulation B=", B, " per scenario")
  prep <- prep_skin()
  des <- make_design(prep$z, thermal$Components, prep$mode, "Joint")
  orig <- colnames(des); safe <- make.names(orig, unique = TRUE); colnames(des) <- safe
  fd <- cbind(prep$d0, Y = prep$yv, as.data.frame(des))
  fd <- fd[order(fd$ParticipantID, fd$PhaseID, fd$Time10), ]
  rownames(fd) <- NULL
  formula <- reformulate(safe, response = "Y")
  fit <- do_fit(formula, fd, "nlminb")
  beta_hat <- nlme::fixef(fit)
  vc <- nlme::VarCorr(fit)
  sd_p <- as.numeric(vc[2, "StdDev"]); sd_b <- as.numeric(vc[4, "StdDev"])
  stopifnot(identical(rownames(vc)[2], "(Intercept)"), identical(rownames(vc)[4], "(Intercept)"))
  rho <- unname(coef(fit$modelStruct$corStruct, unconstrained = FALSE))
  sigma_hat <- fit$sigma
  bout <- as.integer(interaction(fd$ParticipantID, fd$PhaseID, drop = TRUE))
  groups <- split(seq_len(nrow(fd)), bout)
  ctx <- list(fd = fd, formula = formula, X = model.matrix(formula, data = fd), pid = as.integer(fd$ParticipantID), n_p = nlevels(fd$ParticipantID),
    bout = bout, n_b = max(bout), groups = groups, sd_p = sd_p, sd_b = sd_b, rho = rho, sigma = sigma_hat, seed = 20261009L)
  heat_safe <- safe[vapply(orig, h4_heat_hypothesis_term, logical(1), heat_vars = component_set)]
  beta_null <- beta_hat; beta_null[heat_safe] <- 0
  scenarios <- list(
    list(name = "A_truth_is_fitted_beta", beta = beta_hat, offset = 1L),
    list(name = "B_null_all_heat_terms_zero", beta = beta_null, offset = 2L))
  message("  parameters: sd_participant=", signif(sd_p, 4), " sd_phase=", signif(sd_b, 4), " rho=", signif(rho, 5), " sigma=", signif(sigma_hat, 4))
  cl <- parallel::makeCluster(workers)
  on.exit(try(parallel::stopCluster(cl), silent = TRUE), add = TRUE)
  parallel::clusterEvalQ(cl, { suppressMessages({ library(nlme); library(clubSandwich) }); NULL })
  parallel::clusterExport(cl, c("do_fit", "sim_replicate"), envir = globalenv())
  draws <- list()
  for (sc in scenarios) {
    t0 <- Sys.time()
    r <- parallel::parLapplyLB(cl, seq_len(B), sim_replicate, ctx = ctx, scenario = sc)
    ok <- !vapply(r, is.null, logical(1))
    message("  scenario ", sc$name, ": ", sum(ok), "/", B, " replicates fitted in ", round(as.numeric(difftime(Sys.time(), t0, units = "mins")), 1), " min")
    draws[[sc$name]] <- do.call(rbind, r[ok])
    draws[[sc$name]]$requested_B <- B
  }
  dr <- do.call(rbind, draws); rownames(dr) <- NULL
  dr$term_label <- orig[match(dr$term, safe)]
  dr$term_class <- mapply(function(t) if (is.na(t)) "intercept" else term_class(t, "Components"), dr$term_label)
  dr$term_class[dr$term == "(Intercept)"] <- "intercept"
  dr$tcrit <- qt(.975, dr$df)
  dr$covered <- abs(dr$estimate - dr$truth) <= dr$tcrit * dr$se
  dr$reject_truth <- !dr$covered
  dr$reject_zero <- abs(dr$estimate / dr$se) > dr$tcrit
  write.csv(dr[, c("scenario", "rep", "term", "term_label", "term_class", "truth", "estimate", "se", "df", "covered", "reject_truth", "reject_zero")],
    file.path(out_dir, "H4_simulation_draws.csv"), row.names = FALSE)
  summ <- do.call(rbind, lapply(split(dr, interaction(dr$scenario, dr$term, drop = TRUE)), function(s) {
    n <- nrow(s)
    data.frame(scenario = s$scenario[1], term = s$term[1], term_label = s$term_label[1], term_class = s$term_class[1], truth = s$truth[1],
      replicates_fitted = n, replicates_requested = B, mean_estimate = mean(s$estimate), bias = mean(s$estimate) - s$truth[1],
      empirical_sd_estimate = sd(s$estimate), mean_cr2_se = mean(s$se), se_ratio_mean_se_over_empirical_sd = mean(s$se) / sd(s$estimate),
      median_df = median(s$df), min_df = min(s$df), share_df_lt4 = mean(s$df < 4),
      coverage_95 = mean(s$covered), mc_se_coverage = sqrt(mean(s$covered) * (1 - mean(s$covered)) / n),
      size_alpha05_at_truth = mean(s$reject_truth), rejection_rate_vs_zero = mean(s$reject_zero), stringsAsFactors = FALSE)
  }))
  rownames(summ) <- NULL
  summ <- summ[summ$term != "(Intercept)", ]
  summ <- summ[order(summ$scenario, match(summ$term_class, c("heat_main", "heat_product", "pm25_covariate", "activity", "other_covariate")), summ$term), ]
  write.csv(summ, file.path(out_dir, "H4_simulation_summary.csv"), row.names = FALSE)
  message("  wrote simulation summary (", nrow(summ), " rows)")
}

# =========================================================================================
# Markdown summary
# =========================================================================================
if (run_stage("md")) {
  message("Writing H4_CR2_reliability_review.md")
  drv <- read.csv(file.path(out_dir, "H4_CR2_df_driver_summary.csv"), stringsAsFactors = FALSE)
  cf <- read.csv(file.path(out_dir, "H4_CR2_coefficient_df.csv"), stringsAsFactors = FALSE)
  heat_low <- sum(drv$flag_heat_low_df, na.rm = TRUE)
  eq_wide <- sum(drv$flag_equation_wide_low_df, na.rm = TRUE)
  skin <- cf[cf$outcome == OUTCOME & cf$equation_id == 4L & cf$term %in% c(component_set, "ucm_SND_dBA"), ]
  loo_path <- file.path(out_dir, "H4_skin_air_LOO_CR2.csv")
  loo_txt <- if (file.exists(loo_path)) {
    loo <- read.csv(loo_path, stringsAsFactors = FALSE)
    air <- loo[loo$term == AIR & loo$kind != "full_sample", ]
    sprintf("LOO air-temp sign flips (eq 1+4): %d / %d", sum(air$sign_flip, na.rm = TRUE), nrow(air))
  } else "LOO file not generated"
  sim_txt <- if (file.exists(file.path(out_dir, "H4_simulation_summary.csv"))) {
    sm <- read.csv(file.path(out_dir, "H4_simulation_summary.csv"), stringsAsFactors = FALSE)
    h <- sm[sm$term_label == AIR & grepl("null", sm$scenario, ignore.case = TRUE), ]
    if (nrow(h)) sprintf("Simulation null scenario air-temp Type I ~%.3f; coverage %.3f", h$rejection_rate_vs_zero, h$coverage_95)
    else "see H4_simulation_summary.csv"
  } else "Simulation not run"
  lines <- c(
    "# H4 CR2 reliability review (POST-HOC)",
    "",
    "Executive summary for reviewer checklist. **CR2 is retained**; Satterthwaite df are coefficient-specific.",
    "",
    paste0("- **Heat-term df:** ", heat_low, " outcome×equation cells with min heat df < 4 (of ", nrow(drv), "); ",
      eq_wide, " cells flagged by global min df (often PM2.5 covariate)."),
    paste0("- **Skin temp / air temp (eq 4):** ", paste(vapply(seq_len(nrow(skin)), function(i) {
      sprintf("%s df=%.2f p=%.4g", skin$term[i], skin$df[i], skin$p_value[i])
    }, character(1)), collapse = "; ")),
    paste0("- **Participant influence:** ", loo_txt, "."),
    paste0("- **Simulation (eq 4 structure):** ", sim_txt, "."),
    paste0("- **Sensitivity:** see `H4_sensitivity_main_effects.csv` (POST-HOC main effects vs product models)."),
    "",
    "Artifacts: `H4_CR2_coefficient_df.csv`, `H4_CR2_df_driver_summary.csv`, `H4_sensitivity_main_effects.csv`,",
    "`H4_skin_air_LOO_CR2.csv`, `H4_skin_air_phase_checks.csv`, `H4_simulation_summary.csv`, `H4_simulation_draws.csv`.",
    "Prior single-outcome note: `H4_CR2_DF_diagnostic_skin_temp_air_temp.md`.",
    "",
    paste0("Generated: ", Sys.time(), " via `scripts/h4_cr2_reliability_review.R`.")
  )
  writeLines(lines, file.path(out_dir, "H4_CR2_reliability_review.md"))
}
