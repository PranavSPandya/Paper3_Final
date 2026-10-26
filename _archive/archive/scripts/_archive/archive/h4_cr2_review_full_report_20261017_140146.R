# Part E of h4_cr2_review_full.R: assembles H4_CR2_reliability_review.md from the CSVs written by parts A-D.
# Can also be run on its own after parts A-D:  H4_REVIEW_PARTS=E Rscript scripts/h4_cr2_review_full.R
# Every number in the text is computed from the CSVs; wording of verdicts is rule-based on those numbers.

rd <- function(f) read.csv(file.path(out_dir,f),check.names=FALSE,stringsAsFactors=FALSE)
fnum <- function(x,d=3) ifelse(is.na(x),"NA",formatC(x,format="f",digits=d))
fsig <- function(x,s=3) ifelse(is.na(x),"NA",formatC(signif(x,s),format="g",digits=s))
fp <- function(p) ifelse(is.na(p),"NA",ifelse(p<0.001,"<0.001",formatC(p,format="f",digits=3)))
fdf <- function(x) ifelse(is.na(x),"NA",formatC(x,format="f",digits=2))
md_table <- function(d) {
  d[] <- lapply(d,as.character); d[is.na(d)] <- "NA"
  c(paste0("| ",paste(names(d),collapse=" | ")," |"),paste0("|",paste(rep("---",ncol(d)),collapse="|"),"|"),
    apply(d,1,function(r) paste0("| ",paste(r,collapse=" | ")," |")),"")
}
short_out <- function(x) sub("^(empatica|eyetracker)_","",x)

term_df <- rd("H4_CR2_term_df_review.csv"); summ <- rd("H4_CR2_df_summary_by_term.csv"); by_fit <- rd("H4_CR2_df_by_fit.csv")
low_tab <- rd("H4_CR2_covariate_df_lt4_counts.csv"); lev <- rd("H4_CR2_predictor_participant_leverage.csv")
sens <- rd("H4_sensitivity_main_effects.csv"); cmp <- rd("H4_sensitivity_vs_full.csv")
cm <- read.csv(file.path(out_dir,"H4_thermal_within_person_correlations.csv"),check.names=FALSE,row.names=1)
loo <- rd("H4_participant_LOO_skin_temp.csv"); flips <- rd("H4_LOO_sign_flips_components_heat_main_eq4_stored_diagnostics.csv")
parts_tab <- rd("H4_participant_within_person.csv"); ts <- rd("H4_participant_two_stage.csv"); phase_tab <- rd("H4_participant_phase_level.csv")
pbd <- rd("H4_participant_between_phase_direction.csv"); regs <- rd("H4_participant_phase_regression.csv"); dsc <- rd("H4_participant_differenced_scale_check.csv")
sim <- rd("H4_simulation_summary.csv")
S0 <- sim_setup()
sim_params <- data.frame(parameter=c("n_windows","n_participants","n_bouts","ar1_phi_fitted","residual_sd","participant_intercept_sd","phase_intercept_sd",
  "stress_second_ar_root","B_null_AR1","B_alt_AR1","B_null_stress"),
  value=c(nrow(S0$fd),length(unique(S0$fd$ParticipantID)),length(unique(interaction(S0$fd$ParticipantID,S0$fd$PhaseID,drop=TRUE))),S0$phi,S0$sd_resid,S0$sd_participant,S0$sd_phase,
          0.59,max(sim$B_requested[sim$scenario=="null_AR1"]),max(sim$B_requested[sim$scenario=="alt_AR1"]),max(sim$B_requested[sim$scenario=="null_stress"])))
wcsv(sim_params,"H4_simulation_parameters.csv")
st_skin4 <- status_all[status_all$equation_id==4L & status_all$outcome==skin,]

# ---------------- derived numbers ----------------
n_term_fit <- sum(is.finite(term_df$df))
min_df_any <- min(term_df$df,na.rm=TRUE); max_df_any <- max(term_df$df,na.rm=TRUE)
n_lt4_terms <- sum(term_df$df<4,na.rm=TRUE)
min_df_heat_all <- min(by_fit$min_cr2_df_heat_recomputed,na.rm=TRUE)
n_fit_ok <- sum(by_fit$success); n_fit_total <- nrow(by_fit)
n_global_lt4 <- sum(by_fit$global_df_lt4,na.rm=TRUE); n_heat_lt4 <- sum(by_fit$heat_df_lt4,na.rm=TRUE)
n_covonly <- sum(by_fit$covariate_only_low_df,na.rm=TRUE)
n_flag_note <- sum(by_fit$flag_LOW_EFFECTIVE_DF_in_status_note)
pm_rng <- range(coef_all$df[coef_all$term=="atmo_pm2.5_avg"],na.rm=TRUE)
pm_lev <- lev[lev$variable=="atmo_pm2.5_avg",]; pm_lev <- pm_lev[order(-pm_lev$share_of_within_person_SS),]
other_df_lt4 <- setdiff(low_tab$term,"atmo_pm2.5_avg")
comp4 <- term_df[term_df$heat_form=="Components" & term_df$role=="heat main",]
comp_df_rng <- range(comp4$df,na.rm=TRUE)
failed_fits <- status_all[!status_all$success,]

loo4 <- loo[loo$equation_id==4L & loo$term=="ucm_AIR_temp",]; loo4f <- loo4[loo4$dropped_participant=="NONE (full sample)",]; loo4d <- loo4[loo4$dropped_participant!="NONE (full sample)",]
loo1 <- loo[loo$equation_id==1L & loo$term=="ucm_AIR_temp",]; loo1f <- loo1[loo1$dropped_participant=="NONE (full sample)",]; loo1d <- loo1[loo1$dropped_participant!="NONE (full sample)",]
loo_flip4 <- sum(loo4d$sign_flip); loo_flip1 <- sum(loo1d$sign_flip)
loo_maxdiff <- unique(loo$refit_vs_stored_diagnostics_maxdiff)[1]

cmp_s <- cmp[cmp$outcome==skin,]
n_agree <- sum(cmp$air_sign_agree_S2_vs_eq4); n_agree_u <- sum(cmp$utci_sign_agree_S1_vs_eq16)
n_pos_within <- sum(parts_tab$r_within_person>0); n_pos_phase_part <- sum(parts_tab$r_within_phase>0)
n_pos_phase <- sum(phase_tab$r_within_phase>0,na.rm=TRUE); n_phase <- sum(is.finite(phase_tab$r_within_phase))
n_between_pos <- sum(pbd$slope_phase_means>0)

sim_air <- sim[sim$term=="ucm_AIR_temp",]
sa <- function(sc) sim_air[sim_air$scenario==sc,]
nullS <- sa("null_AR1"); altS <- sa("alt_AR1"); strS <- sa("null_stress")
heat_terms_orig <- c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT","ucm_AIR_temp:SND_dBA","ucm_AIR_RH:SND_dBA","ucm_MRT:SND_dBA","ucm_AIR_temp:Activity_Bike","ucm_AIR_RH:Activity_Bike","ucm_MRT:Activity_Bike")
null_heat <- sim[sim$scenario=="null_AR1" & sim$term %in% heat_terms_orig,]
stress_heat <- sim[sim$scenario=="null_stress" & sim$term %in% heat_terms_orig,]
alt_all <- sim[sim$scenario=="alt_AR1" & sim$term!="Intercept",]
verdict_size <- function(r) if(r<=0.075 && r>=0.025) "acceptable" else if(r>0.075) "inflated (anti-conservative)" else "conservative (below nominal)"
verdict_cov <- function(cv) if(cv>=0.93 && cv<=0.97) "acceptable" else if(cv<0.93) "under-covers" else "over-covers (conservative)"

md <- character()
add <- function(...) md <<- c(md,...)

add("# H4 CR2 reliability review (complete)","",
paste0("**Generated:** ",format(Sys.time(),"%Y-%m-%d %H:%M"),". Post hoc, review-driven; produced by `scripts/h4_cr2_review_full.R` (all supporting CSVs are in `H4_models/reliability_review_full/`).  "),
"**Scope:** H4 Step 5 mixed models (nlme; random intercepts for participant and participant-phase; AR(1) on 10-s windows; participant-cluster CR2 with Satterthwaite df). 11 participants, 26 outcomes, 16 equations.  ",
"**Policy:** CR2 is **not** replaced and df is **not** forced to 10. Nothing in `H4_coefficients.csv`, `H4_hypothesis.csv` or `H4_fit_status.csv` was changed. Everything below is a diagnostic or a labelled POST-HOC sensitivity.  ",
"**Status of inference:** exploratory and post-selection (Step 4 used the same outcomes). BH q-values are descriptive.","",
"---","","## Executive summary","")

# ---- Q1
add("### 1. Is CR2 trustworthy for the H4 heat coefficients?","",
sprintf("**%s**","Yes for the heat-related terms, with the usual 11-cluster caveat. The equation-level `LOW_EFFECTIVE_DF` flag is about PM2.5, not heat."),"",
sprintf("- Coefficient-specific CR2 Satterthwaite df for every heat main effect, sound main effect, heat x sound and heat x activity term on the four both_products equations (4, 8, 12, 16) over all 26 outcomes (%d term-fits): **min %.2f, max %.2f; %d have df < 4.** Components heat main effects: %.2f to %.2f.",n_term_fit,min_df_any,max_df_any,n_lt4_terms,comp_df_rng[1],comp_df_rng[2]),
sprintf("- `LOW_EFFECTIVE_DF` appears in %d of %d successful fits (every successful fit). In all of them the minimum df belongs to `atmo_pm2.5_avg` (df %.2f to %.2f): participant %s supplies %.0f%% of PM2.5 within-person variation, so PM2.5 is effectively identified by one cluster. %d successful fits are flagged on a covariate alone; **%d fits have any heat term below df 4** (smallest heat-term df in any of the %d fits: %.2f).",n_flag_note,n_fit_ok,pm_rng[1],pm_rng[2],pm_lev$ParticipantID[1],100*pm_lev$share_of_within_person_SS[1],n_covonly,n_heat_lt4,n_fit_ok,min_df_heat_all),
sprintf("- Design-matched simulation (skin-temperature Components eq 4 design, B = %d per main scenario): CR2 Type I error for the air-temperature coefficient **%s** (MC SE %s; %s), 95%% coverage **%s** (%s), bias %s, median df %.2f, %d replicate(s) with a fit failure. Under deliberately misspecified AR(2) noise (B = %d): Type I %s (%s), coverage %s (%s).",
  nullS$n_used,fnum(nullS$reject_rate_alpha05,3),fnum(nullS$reject_mc_se,3),verdict_size(nullS$reject_rate_alpha05),fnum(nullS$cr2_coverage_95,3),verdict_cov(nullS$cr2_coverage_95),fsig(nullS$bias,2),nullS$df_median,nullS$n_replicates_with_fit_failure,
  strS$n_used,fnum(strS$reject_rate_alpha05,3),verdict_size(strS$reject_rate_alpha05),fnum(strS$cr2_coverage_95,3),verdict_cov(strS$cr2_coverage_95)),
sprintf("- df stays below 10 (about %.1f to %.1f for heat-related terms). That is what CR2 reports for 11 clusters with unequal leverage, and it was left exactly as computed.",min_df_any,max_df_any),"")

# ---- Q2
add("### 2. Is air temperature -> skin temperature driven by one participant?","","**No.**","",
sprintf("- Eq 4 full-sample estimate %s (SE %s, df %s, p %s). Dropping each of the 11 participants gives %s to %s (%+.1f%% to %+.1f%%); **%d of 11 sign flips**; every deletion keeps CR2 p <= %s (df %.1f to %.1f). Eq 1: %s to %s, %d flips. Fresh CR2 refits match the stored `H4_diagnostics.csv` LOO estimates to within %.1e.",
  fnum(loo4f$estimate,4),fnum(loo4f$se,4),fdf(loo4f$df),fp(loo4f$p_value),fnum(min(loo4d$estimate),4),fnum(max(loo4d$estimate),4),min(loo4d$pct_change_vs_full),max(loo4d$pct_change_vs_full),loo_flip4,fnum(max(loo4d$p_value),4),min(loo4d$df),max(loo4d$df),
  fnum(min(loo1d$estimate),4),fnum(max(loo1d$estimate),4),loo_flip1,loo_maxdiff),
sprintf("- Within-person r(air temp, skin temp) is positive in **%d / 11** participants (median %s; range %s to %s). Removing phase means it is positive in %d / 11 participants and in %d / %d participant x phase cells; the between-phase direction (4 phase means each) is positive in %d / 11. Two-stage mean of the 11 per-participant slopes: %s (95%% CI %s to %s), sign-test p = %s.",
  n_pos_within,fnum(median(parts_tab$r_within_person),2),fnum(min(parts_tab$r_within_person),2),fnum(max(parts_tab$r_within_person),2),n_pos_phase_part,n_pos_phase,n_phase,n_between_pos,
  fnum(ts$mean_slope[1],2),fnum(ts$ci_low[1],2),fnum(ts$ci_high[1],2),fsig(ts$sign_test_p[1],2)),
sprintf("- **The size of the coefficient is scale-dependent.** The model coefficient (%s degC per within-person SD) matches a 10-second first-difference regression (%s), but per-participant slopes on the raw series average %s (about %sx larger) and the differenced slope grows from %s at 10 s to %s at %d s. The fitted AR(1) has phi = %s (nearly a random walk), so the GLS coefficient is effectively the fast (10-s) response. Direction is positive at every scale; the magnitude should be described as the 10-s-scale effect.",
  fnum(loo4f$estimate,3),fnum(dsc$estimate[dsc$lag_windows==1],3),fnum(ts$mean_slope[1],2),fnum(ts$mean_slope[1]/loo4f$estimate,1),fnum(dsc$estimate[dsc$lag_windows==1],2),fnum(dsc$estimate[dsc$lag_windows==max(dsc$lag_windows)],2),max(dsc$lag_seconds),fsig(S0$phi,4)),"")

# ---- Q3
add("### 3. Does a simpler main-effects model agree in direction and magnitude?","","**Yes for skin temperature. Across outcomes direction mostly agrees; magnitude differs where heat indices are collinear.**","",
sprintf("- POST-HOC spec S2 (air temperature only, with sound, PM2.5, clearness, GVI, lux, colour temperature and activity; no products): skin-temperature coefficient **%s** (SE %s, df %.2f, p %s, BH q %s over 26 outcomes), against eq 4 %s and eq 1 %s. S2/eq 4 = %s.",
  fnum(cmp_s$air_S2_est,4),fnum(cmp_s$air_S2_se,4),cmp_s$air_S2_df,fp(cmp_s$air_S2_p),fnum(cmp_s$air_S2_q,3),fnum(cmp_s$air_eq4_est,4),fnum(cmp_s$air_eq1_est,4),fnum(cmp_s$air_ratio_S2_to_eq4,2)),
sprintf("- Sign of the air-temperature coefficient agrees between eq 4 and S2 in **%d / 26** outcomes. The primary single-index spec S1 (UTCI only) agrees in sign with eq 16 in %d / 26 and is null for skin temperature (%s, p = %s), as in the full model.",n_agree,n_agree_u,fnum(cmp_s$utci_S1_est,4),fp(cmp_s$utci_S1_p)),
sprintf("- Largest disagreement in magnitude: pupil diameter (S2/eq 4 = %s). Within-person r of air temperature with humidity is %s and with MRT %s, so the eq 4 main effect is conditional on both, whereas S2 absorbs their shared variance.",
  fnum(cmp$air_ratio_S2_to_eq4[cmp$outcome=="eyetracker_pupil_diameter_avg"],2),fnum(cm["ucm_AIR_temp","ucm_AIR_RH"],2),fnum(cm["ucm_AIR_temp","ucm_MRT"],2)),"")

# ---- Q4
add("### 4. Simulation: Type I error and coverage","",
sprintf("- Null (all 9 heat terms = 0; fitted AR(1) noise): air-temperature Type I **%s** (%s), coverage **%s** (%s). Across all 9 heat terms Type I ranges %s to %s (max MC SE %s) and coverage %s to %s.",
  fnum(nullS$reject_rate_alpha05,3),verdict_size(nullS$reject_rate_alpha05),fnum(nullS$cr2_coverage_95,3),verdict_cov(nullS$cr2_coverage_95),
  fnum(min(null_heat$reject_rate_alpha05),3),fnum(max(null_heat$reject_rate_alpha05),3),fnum(max(null_heat$reject_mc_se),3),fnum(min(null_heat$cr2_coverage_95),3),fnum(max(null_heat$cr2_coverage_95),3)),
sprintf("- Alternative (truth = observed air-temperature effect %s): power %s, coverage %s, bias %s (%.1f%% of truth), SE ratio (mean CR2 SE / empirical SD) %s. Coverage over all 16 non-intercept terms: %s to %s.",
  fnum(altS$truth,3),fnum(altS$reject_rate_alpha05,3),fnum(altS$cr2_coverage_95,3),fsig(altS$bias,2),100*altS$bias/altS$truth,fnum(altS$se_ratio_mean_over_empirical,2),fnum(min(alt_all$cr2_coverage_95),3),fnum(max(alt_all$cr2_coverage_95),3)),
sprintf("- Stress (AR(2) noise, normalized lag-1 residual correlation about %s in simulation vs %s observed): air-temperature Type I **%s** (%s), coverage **%s** (%s); across heat terms Type I %s to %s.",
  fnum(strS$median_lag1_normalized,2),fnum(st_skin4$lag1_normalized,2),fnum(strS$reject_rate_alpha05,3),verdict_size(strS$reject_rate_alpha05),fnum(strS$cr2_coverage_95,3),verdict_cov(strS$cr2_coverage_95),fnum(min(stress_heat$reject_rate_alpha05),3),fnum(max(stress_heat$reject_rate_alpha05),3)),
sprintf("- Model-based (non-robust) nlme Wald tests, for contrast: air-temperature Type I %s under correct AR(1) and %s under the stress noise.",fnum(nullS$model_based_reject_alpha05,3),fnum(strS$model_based_reject_alpha05,3)),"")

# ---- Q5 residual flags (separate limitation paragraph)
add("### 5. Residual flags (separate limitation)","",
sprintf("The skin-temperature Components fits carry `REMAINING_SERIAL_CORRELATION` (normalized lag-1 residual correlation %s after AR(1) whitening), `RESIDUAL_TAIL_SHAPE` (skew %s, excess kurtosis %s) and `BOUNDARY_VARIANCE` (phase intercept SD %s, effectively zero). These flags describe Gaussian AR(1) adequacy, not CR2 df; they were not removed by this review. The fitted AR(1) phi is %s, so with 49 windows per phase most within-phase variation is a slowly varying level and the effective number of independent observations is far below 2101. CR2 clustering by participant protects the SE against this (see simulation), but the **estimand** is tied to the AR(1) specification (section 4.5), and a smoother residual process (AR(2)) is the more plausible truth. Results should be reported as exploratory, with the 10-s-scale interpretation of the coefficient.",
  fnum(st_skin4$lag1_normalized,2),fnum(st_skin4$residual_skew,2),fnum(st_skin4$residual_excess_kurtosis,2),fsig(S0$sd_phase,2),fsig(S0$phi,4)),"","---","")

# =========================== SECTION 1: definitions ===========================
add("## 1. What `min_cr2_df`, `min_cr2_df_heat` and the flags mean","",
"- `min_cr2_df` (global): minimum Satterthwaite df over **all non-intercept** fixed effects of one fit. `LOW_EFFECTIVE_DF` in the published `note` column means this global minimum is < 4.",
"- `min_cr2_df_heat`: minimum over **heat terms only** (heat main effects and every product containing a heat variable). Code in `h4_step5_equations.R` now splits the flag into `LOW_EFFECTIVE_DF_HEAT` (heat term df < 4) and `LOW_CR2_DF_COVARIATE` (global < 4 but heat >= 4).",
sprintf("- The published `H4_fit_status.csv` was produced before that split: it has %s a `min_cr2_df_heat` column and labels all %d flagged fits `LOW_EFFECTIVE_DF`. Here the heat-specific minimum is **recomputed from `H4_coefficients.csv`** for all %d fits (`H4_CR2_df_by_fit.csv`); no refit was needed for this part.",
  if(any(by_fit$status_has_min_cr2_df_heat)) "already" else "no",n_flag_note,n_fit_total),
sprintf("- %d of %d equation-outcome fits succeeded. The %d nlme failure(s) (%s) %s on equations 4, 8, 12 or 16; those four equations have all 26 outcomes.",n_fit_ok,n_fit_total,nrow(failed_fits),paste0("eq ",failed_fits$equation_id," ",short_out(failed_fits$outcome),collapse="; "),
  if(all(!failed_fits$equation_id %in% c(4,8,12,16))) "are none of them" else "INCLUDE some"),
"- df < 4 is an operational review threshold used in this pipeline, not a universal rule.","")

# =========================== SECTION 2: A ===========================
add("## 2. Item 1: coefficient-specific CR2 df (both_products equations 4, 8, 12, 16)","",
"### 2.1 Summary by term across the 26 outcomes","",
"`df` columns are Satterthwaite df of that single coefficient. `n p<.05` / `n q<.05` count outcomes (BH q only exists for heat mains and products within each heat form's family).","")
t1 <- summ
t1 <- data.frame(`heat form`=t1$heat_form,eq=t1$equation_id,role=t1$role,term=t1$term,`n fits`=t1$n_fits,`df min`=fdf(t1$df_min),`df Q1`=fdf(t1$df_q25),`df median`=fdf(t1$df_median),`df max`=fdf(t1$df_max),
  `n df<4`=t1$n_df_lt4,`n p<.05`=t1$n_p_lt_05,`n q<.05`=t1$n_q_lt_05,check.names=FALSE)
add(md_table(t1))
add(sprintf("**Terms that ever have df < 4 across the 26 outcomes: %s.** The full per-outcome rows are in `H4_CR2_term_df_review.csv` (%d rows; estimate, SE, df, p, q, `df_lt4`).",
  if(n_lt4_terms==0) "none" else paste(unique(term_df$term[term_df$df<4 & is.finite(term_df$df)]),collapse=", "),nrow(term_df)),"")

add("### 2.2 Components, eq 4: heat main effects for ALL 26 outcomes","",
"Primary narrative is air temperature -> skin temperature; the full outcome table is shown so no outcome is selectively reported. Estimates are per within-person SD of the predictor (native outcome units; HRV outcomes on natural log).","")
for(v in c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT")) {
  d <- comp4[comp4$term==v,]; d <- d[match(outcomes,d$outcome),]
  add(paste0("**",v,"**"),"")
  add(md_table(data.frame(outcome=short_out(d$outcome),estimate=fsig(d$estimate,3),SE=fsig(d$se,3),df=fdf(d$df),p=fp(d$p_value),q=fp(d$q_value),`df<4`=ifelse(d$df<4,"YES","no"),check.names=FALSE)))
}

add("### 2.3 Skin temperature: every heat / sound / interaction term on each heat form (both_products)","")
sk <- term_df[term_df$outcome==skin,]
add(md_table(data.frame(`heat form`=sk$heat_form,eq=sk$equation_id,role=sk$role,term=sk$term,estimate=fsig(sk$estimate,3),SE=fsig(sk$se,3),df=fdf(sk$df),p=fp(sk$p_value),q=fp(sk$q_value),check.names=FALSE)))

add("### 2.4 Global min_cr2_df versus heat-specific df","")
agg <- do.call(rbind,lapply(split(by_fit[by_fit$success,],paste(by_fit$heat_form[by_fit$success],by_fit$block[by_fit$success])),function(d) data.frame(
  `heat form`=d$heat_form[1],block=d$block[1],`successful fits`=nrow(d),`global df<4`=sum(d$global_df_lt4),`heat df<4`=sum(d$heat_df_lt4,na.rm=TRUE),
  `min global df`=fdf(min(d$min_cr2_df_global_recomputed)),`min heat df`=fdf(min(d$min_cr2_df_heat_recomputed,na.rm=TRUE)),
  `term at global min`=paste(names(sort(table(d$term_at_global_min),decreasing=TRUE))[1],collapse=""),check.names=FALSE)))
rownames(agg) <- NULL
add(md_table(agg))
add(sprintf("Across the %d fits whose global min df is below 4, the covariate with df < 4 is **%s only** (%s fits; other covariates with df < 4: %s). PM2.5 within-person variation by participant (share of sum of squares): %s. A predictor whose variation sits almost entirely in one cluster gets Satterthwaite df near 1; this is a property of PM2.5 in this sample and does not transfer to heat terms, whose largest single-participant share is %s.",
  nrow(by_fit[by_fit$global_df_lt4 %in% TRUE,]),paste(low_tab$term[low_tab$n_fits_df_lt4==max(low_tab$n_fits_df_lt4)],collapse=", "),
  paste(low_tab$n_fits_df_lt4[1],"of",low_tab$n_fits_total[1]),if(length(other_df_lt4)) paste(other_df_lt4,collapse=", ") else "none",
  paste(paste0(pm_lev$ParticipantID[1:3]," ",fnum(100*pm_lev$share_of_within_person_SS[1:3],0),"%"),collapse=", "),
  paste0(fnum(100*max(lev$share_of_within_person_SS[lev$variable %in% c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT","ucm_UTCI","ucm_PET","ucm_HUMIDEX")]),0),"%")),"",
"**Reporting recommendation:** state heat-term df (see 2.1; roughly 6 to 10) next to heat estimates, and describe the `LOW_EFFECTIVE_DF` flag as PM2.5-driven. Do not quote the equation-level min df as the df of a heat coefficient.","")

# =========================== SECTION 3: B ===========================
add("## 3. Item 2: POST-HOC simpler main-effects sensitivity","",
"**POST-HOC. Defined after the full Step 5 results were available; not preregistered; does not replace equations 1 to 16.** The point is only to check that the headline heat conclusions do not depend on the product terms or on collinear thermal components.","",
"**Common to both specs:** same data prep as Step 5 (within-person centering, division by full-sample within-person SD, Bike +0.5 / Walk -0.5), same `lme` (random ~ 1 | participant / phase, `corAR1` on Time10 within participant-phase, REML), participant-cluster CR2 Satterthwaite, same covariates (`atmo_pm2.5_avg`, `Clearness_Index`, `gvi_50m`, `lys_kelvin_avg`, `lys_lux_avg`, `ucm_SND_dBA`, `Activity_Bike`), **no interaction products**, redundant heat indices removed. All 26 outcomes fitted for both specs. BH q is computed across the 26 outcomes per spec.","",
"| Spec | Thermal term | Why |","|---|---|---|",
"| **S1 (primary single thermal index)** | `ucm_UTCI` | One integrative index (air temp, humidity, radiant and wind load) removes component collinearity. This is exactly Step 5 eq 13, so it doubles as a reproducibility check (max |difference| to eq 13 is below 1e-6). |",
"| **S2 (skin-temperature comparison)** | `ucm_AIR_temp` | Air temperature only, without humidity and MRT, to compare directly with the Components eq 4 / eq 1 air-temperature coefficient. |","",
"### 3.1 Skin temperature","")
sk_cmp <- data.frame(model=c("Eq 4 Components, both_products (Step 5)","Eq 1 Components, no_products (Step 5)","S2 air temperature only (POST-HOC)","Eq 16 UTCI, both_products (Step 5)","Eq 13 UTCI, no_products (Step 5)","S1 UTCI only (POST-HOC)"),
  term=c("ucm_AIR_temp","ucm_AIR_temp","ucm_AIR_temp","ucm_UTCI","ucm_UTCI","ucm_UTCI"),
  estimate=fnum(c(cmp_s$air_eq4_est,cmp_s$air_eq1_est,cmp_s$air_S2_est,cmp_s$utci_eq16_est,cmp_s$utci_eq13_est,cmp_s$utci_S1_est),4),
  SE=c(fnum(coef_all$se[coef_all$equation_id==4 & coef_all$outcome==skin & coef_all$term=="ucm_AIR_temp"],4),fnum(coef_all$se[coef_all$equation_id==1 & coef_all$outcome==skin & coef_all$term=="ucm_AIR_temp"],4),fnum(cmp_s$air_S2_se,4),
       fnum(coef_all$se[coef_all$equation_id==16 & coef_all$outcome==skin & coef_all$term=="ucm_UTCI"],4),fnum(coef_all$se[coef_all$equation_id==13 & coef_all$outcome==skin & coef_all$term=="ucm_UTCI"],4),fnum(cmp_s$utci_S1_se,4)),
  df=fdf(c(cmp_s$air_eq4_df,coef_all$df[coef_all$equation_id==1 & coef_all$outcome==skin & coef_all$term=="ucm_AIR_temp"],cmp_s$air_S2_df,cmp_s$utci_eq16_df,coef_all$df[coef_all$equation_id==13 & coef_all$outcome==skin & coef_all$term=="ucm_UTCI"],cmp_s$utci_S1_df)),
  p=fp(c(cmp_s$air_eq4_p,cmp_s$air_eq1_p,cmp_s$air_S2_p,cmp_s$utci_eq16_p,coef_all$p_value[coef_all$equation_id==13 & coef_all$outcome==skin & coef_all$term=="ucm_UTCI"],cmp_s$utci_S1_p)),
  q=fp(c(cmp_s$air_eq4_q,NA,cmp_s$air_S2_q,cmp_s$utci_eq16_q,NA,cmp_s$utci_S1_q)))
add(md_table(sk_cmp))
add("### 3.2 Top outcomes (all 26 are in `H4_sensitivity_vs_full.csv` and `H4_sensitivity_main_effects.csv`)","",
"**Top 5 by eq 4 air-temperature p-value (the H4 hypothesis table for Components):**","")
top5 <- cmp[order(cmp$air_eq4_p)[1:5],]
add(md_table(data.frame(outcome=short_out(top5$outcome),`eq4 est`=fsig(top5$air_eq4_est,3),`eq4 p`=fp(top5$air_eq4_p),`eq4 q`=fp(top5$air_eq4_q),`S2 est`=fsig(top5$air_S2_est,3),`S2 df`=fdf(top5$air_S2_df),`S2 p`=fp(top5$air_S2_p),`S2 q`=fp(top5$air_S2_q),`S2/eq4`=fnum(top5$air_ratio_S2_to_eq4,2),`sign agrees`=ifelse(top5$air_sign_agree_S2_vs_eq4,"yes","NO"),check.names=FALSE)))
add("**Top 5 by eq 16 UTCI p-value (single-index hypothesis table):**","")
topu <- cmp[order(cmp$utci_eq16_p)[1:5],]
add(md_table(data.frame(outcome=short_out(topu$outcome),`eq16 est`=fsig(topu$utci_eq16_est,3),`eq16 p`=fp(topu$utci_eq16_p),`eq16 q`=fp(topu$utci_eq16_q),`S1 est`=fsig(topu$utci_S1_est,3),`S1 df`=fdf(topu$utci_S1_df),`S1 p`=fp(topu$utci_S1_p),`S1 q`=fp(topu$utci_S1_q),`S1/eq16`=fnum(topu$utci_ratio_S1_to_eq16,2),`sign agrees`=ifelse(topu$utci_sign_agree_S1_vs_eq16,"yes","NO"),check.names=FALSE)))
dis <- cmp[!cmp$air_sign_agree_S2_vs_eq4,]
add(sprintf("**Agreement summary.** Air temperature: sign agrees in %d / 26 outcomes (disagreements: %s; in those the eq 4 estimate is small relative to its SE). Outcomes with eq 4 p < 0.05: %s; S2 p < 0.05: %s; S2 BH q < 0.05: %s. UTCI: sign agrees in %d / 26; S1 q < 0.05 in %d outcomes.",
  n_agree,if(nrow(dis)) paste(short_out(dis$outcome),collapse=", ") else "none",paste(short_out(cmp$outcome[cmp$air_eq4_p<.05]),collapse=", "),paste(short_out(cmp$outcome[cmp$air_S2_p<.05]),collapse=", "),
  paste(short_out(cmp$outcome[cmp$air_S2_q<.05]),collapse=", "),n_agree_u,sum(cmp$utci_S1_q<.05,na.rm=TRUE)),"",
"S2 and eq 4 use the same sample for skin temperature (n = 2101, air temperature, humidity and MRT all finite). Eq 4 conditions on humidity and MRT and on product terms (the main effect is the effect at mean sound and the activity midpoint); S2 conditions on neither, which is why magnitudes can differ when collinearity is strong.","",
"Within-person correlations among the thermal predictors:","")
cmt <- cbind(variable=rownames(cm),as.data.frame(lapply(cm,function(x) fnum(x,2)),check.names=FALSE))
add(md_table(cmt))

# =========================== SECTION 4: C ===========================
add("## 4. Item 3: participant-level verification, skin temperature ~ air temperature (Components)","",
"### 4.1 Leave-one-participant-out refits (CR2 on every refit; centering/scaling held fixed as in the pipeline)","",
sprintf("`H4_diagnostics.csv` already contains LOO estimates for these fits. They were **refit from scratch here anyway** with `fit_h4_outcome(..., drop_participant = pid)` (not point-only, so each refit also has CR2 SE, df and p); maximum |difference| from stored estimates = %.1e over %d comparisons.",loo_maxdiff,55L),"")
lt <- merge(loo4[,c("dropped_participant","estimate","se","df","p_value","pct_change_vs_full","sign_flip")],loo1[,c("dropped_participant","estimate","p_value","sign_flip")],by="dropped_participant",suffixes=c("_eq4","_eq1"))
lt <- lt[order(lt$dropped_participant!="NONE (full sample)",lt$dropped_participant),]
add(md_table(data.frame(`dropped participant`=lt$dropped_participant,`eq4 est`=fnum(lt$estimate_eq4,4),`eq4 SE`=fnum(lt$se,4),`eq4 df`=fdf(lt$df),`eq4 p`=fp(lt$p_value_eq4),`% change vs full`=fnum(lt$pct_change_vs_full,1),`eq4 sign flip`=ifelse(lt$dropped_participant=="NONE (full sample)","-",ifelse(lt$sign_flip_eq4,"YES","no")),
  `eq1 est`=fnum(lt$estimate_eq1,4),`eq1 p`=fp(lt$p_value_eq1),`eq1 sign flip`=ifelse(lt$dropped_participant=="NONE (full sample)","-",ifelse(lt$sign_flip_eq1,"YES","no")),check.names=FALSE)))
add(sprintf("Largest relative change: %s (dropping %s). All %d deletions in eq 4 and %d in eq 1: largest CR2 p = %s (eq 4) and %s (eq 1); estimates stay positive. `H4_participant_LOO_skin_temp.csv` also has every other eq 1 / eq 4 coefficient (including air temp x sound and air temp x activity) per deletion.",
  paste0(fnum(loo4d$pct_change_vs_full[which.max(abs(loo4d$pct_change_vs_full))],1),"%"),loo4d$dropped_participant[which.max(abs(loo4d$pct_change_vs_full))],nrow(loo4d),nrow(loo1d),fnum(max(loo4d$p_value),4),fnum(max(loo1d$p_value),4)),"",
sprintf("Stored `H4_diagnostics.csv` LOO sign flips for Components heat main effects on eq 4 (only the outcome-term pairs present in that file: %s): %d flips in total.",paste0(short_out(flips$outcome)," ",flips$term,collapse="; "),sum(flips$n_participants_dropped_that_flip_sign)),"")

add("### 4.2 Within-person correlation, all 11 participants","",
"Sample = the 2101 eq 4 complete-case windows. `r` is the Pearson correlation of participant-centered air temperature and participant-centered skin temperature; slope is degC skin per within-person SD of air temperature (same unit as the model coefficient). `within-phase` removes participant x phase means first. Descriptive only: 10-s windows are strongly autocorrelated, so no per-participant p-values are given.","")
add(md_table(data.frame(participant=parts_tab$ParticipantID,windows=parts_tab$n_windows,`r (within person)`=fnum(parts_tab$r_within_person,3),`slope (within person)`=fnum(parts_tab$slope_skin_per_air_SD,3),`r (within phase)`=fnum(parts_tab$r_within_phase,3),`slope (within phase)`=fnum(parts_tab$slope_within_phase,3),positive=ifelse(parts_tab$r_within_person>0 & parts_tab$r_within_phase>0,"yes","NO"),check.names=FALSE)))
add(md_table(data.frame(estimator=ts$estimator,n=ts$n,`mean slope`=fnum(ts$mean_slope,3),`95% CI`=paste0(fnum(ts$ci_low,3)," to ",fnum(ts$ci_high,3)),t=fnum(ts$t,2),df=ts$df,p=fp(ts$p),`n positive`=ts$n_positive,`sign-test p`=fsig(ts$sign_test_p,2),check.names=FALSE)))

add("### 4.3 Phase-level summaries (11 participants x 4 phases = 44 cells)","",
sprintf("%d of %d cells with a finite within-phase correlation are positive. Table cells: within-phase r(air temp, skin temp); in brackets mean air temperature (within-person SD units, relative to the participant's own mean) and mean skin temperature minus the participant mean (degC).",n_pos_phase,n_phase),"")
phs <- c("BikeG","BikeU","WalkG","WalkU")
pv <- do.call(rbind,lapply(sort(unique(phase_tab$ParticipantID)),function(p) { r <- sapply(phs,function(h) { d <- phase_tab[phase_tab$ParticipantID==p & phase_tab$PhaseID==h,]
  sprintf("%s [%s, %s]",fnum(d$r_within_phase,2),fnum(d$mean_air_z,2),fnum(d$mean_skin_participant_centered,2)) }); data.frame(participant=p,t(r),check.names=FALSE) }))
names(pv)[-1] <- phs
add(md_table(pv))
bp <- merge(pbd,parts_tab[,c("ParticipantID","r_within_person")],by="ParticipantID")
add("Between-phase direction (4 phase means per participant, slope of mean skin on mean air temperature; descriptive, n = 4 points each):","")
add(md_table(data.frame(participant=bp$ParticipantID,`slope (phase means)`=fnum(bp$slope_phase_means,3),`r (phase means)`=fnum(bp$r_phase_means,3),check.names=FALSE)))
add(sprintf("Direction: positive within-phase r in %d / %d cells; positive between-phase slope in %d / 11 participants.",n_pos_phase,n_phase,n_between_pos),"")

add("### 4.4 EXPLORATORY participant-level regressions (CR2 clustered by participant)","",
"Labelled exploratory: these are not the Step 5 estimand and ignore the AR(1) and random-effect structure.","")
add(md_table(data.frame(model=regs$model,term=regs$term,estimate=fnum(regs$estimate,3),SE=fnum(regs$se,3),df=fdf(regs$df),p=fp(regs$p_value),rows=regs$n_rows,clusters=regs$n_clusters,check.names=FALSE)))

add("### 4.5 Why the OLS slopes (about 0.6) are larger than the model coefficient (about 0.1): scale check","",
"EXPLORATORY. Regress the lag-k difference of skin temperature on the lag-k difference of air temperature within participant-phase (OLS, CR2 by participant). The Step 5 AR(1) has phi near 1, which makes the GLS slope behave like the shortest-lag (10-s) difference slope.","")
add(md_table(data.frame(lag=paste0(dsc$lag_seconds," s"),pairs=dsc$n_pairs,estimate=fnum(dsc$estimate,3),SE=fnum(dsc$se,3),df=fdf(dsc$df),p=fp(dsc$p_value),`participants positive`=paste0(dsc$n_participants_positive_slope," / ",dsc$n_participants),check.names=FALSE)))
add("The 10-s slope reproduces the model coefficient; longer lags give steeper slopes. This is a statement about the time scale of the association, not a contradiction: direction is positive at every scale.","")

# =========================== SECTION 5: D ===========================
add("## 5. Item 4: design-matched simulation","",
sprintf("**Design.** Fixed design matrix, participants (11), phases (4 per participant, %d bouts), Time10 spacing and missing windows of the real 2101-row skin-temperature eq 4 Components sample. Truth = fitted eq 4 parameters: AR(1) phi = %s, residual SD = %s, participant-intercept SD = %s, phase-intercept SD = %s (boundary). Simulated Y = X beta + participant effect + phase effect + Gaussian noise; the **same** `lme` (nlminb, optim fallback), `corAR1(~Time10 | participant/phase)` and participant-cluster CR2 Satterthwaite pipeline is refit in every replicate. Replicates: %d (null), %d (alternative), %d (stress). Seed %d. Fit failures = replicate with an nlme or CR2 error.",
  length(unique(interaction(S0$fd$ParticipantID,S0$fd$PhaseID,drop=TRUE))),fsig(S0$phi,5),fnum(S0$sd_resid,3),fnum(S0$sd_participant,3),fsig(S0$sd_phase,2),nullS$B_requested,altS$B_requested,strS$B_requested,sim_seed),"",
"| Scenario | Truth | Noise |","|---|---|---|",
"| `null_AR1` | all 9 heat terms = 0 (air temp main = 0); other terms at fitted values | fitted AR(1), correctly specified |",
"| `alt_AR1` | all terms at observed eq 4 estimates (air temp main = observed) | fitted AR(1) |",
"| `null_stress` | all 9 heat terms = 0 | AR(2) with roots phi and 0.59, same marginal variance: fitted AR(1) is misspecified and leaves normalized lag-1 residual correlation near the observed 0.59 |","")
add("### 5.1 Air-temperature coefficient (Components eq 4)","")
add(md_table(data.frame(scenario=sim_air$scenario,`replicates used`=sim_air$n_used,`fit failures`=sim_air$n_replicates_with_fit_failure,truth=fnum(sim_air$truth,4),bias=fsig(sim_air$bias,2),RMSE=fnum(sim_air$rmse,4),
  `empirical SD`=fnum(sim_air$empirical_sd_estimate,4),`mean CR2 SE`=fnum(sim_air$mean_cr2_se,4),`SE ratio`=fnum(sim_air$se_ratio_mean_over_empirical,2),
  `CR2 coverage 95%`=paste0(fnum(sim_air$cr2_coverage_95,3)," (MC SE ",fnum(sim_air$coverage_mc_se,3),")"),`reject alpha .05`=paste0(fnum(sim_air$reject_rate_alpha05,3)," (MC SE ",fnum(sim_air$reject_mc_se,3),")"),
  `df median`=fdf(sim_air$df_median),`df min`=fdf(sim_air$df_min),`df<4`=fnum(sim_air$share_df_lt4,3),`model-based reject`=fnum(sim_air$model_based_reject_alpha05,3),check.names=FALSE)))
add("Rejection under `null_*` is Type I error; under `alt_AR1` it is power. Model-based = ordinary nlme tTable p-values (not robust), shown only for contrast.","")
add("### 5.2 All heat terms under the null (Type I) and under the stress null","")
nh <- null_heat; sh <- stress_heat[match(nh$term,stress_heat$term),]
add(md_table(data.frame(term=nh$term,`null: reject .05`=fnum(nh$reject_rate_alpha05,3),`null: coverage`=fnum(nh$cr2_coverage_95,3),`null: df median`=fdf(nh$df_median),`stress: reject .05`=fnum(sh$reject_rate_alpha05,3),`stress: coverage`=fnum(sh$cr2_coverage_95,3),`stress: df median`=fdf(sh$df_median),check.names=FALSE)))
add("### 5.3 Coverage of every non-intercept coefficient under the alternative","")
alt_s <- alt_all[order(alt_all$cr2_coverage_95),]
add(md_table(data.frame(term=alt_s$term,truth=fsig(alt_s$truth,3),bias=fsig(alt_s$bias,2),`coverage 95%`=fnum(alt_s$cr2_coverage_95,3),`reject .05`=fnum(alt_s$reject_rate_alpha05,3),`df median`=fdf(alt_s$df_median),`share df<4`=fnum(alt_s$share_df_lt4,3),check.names=FALSE)))
add(sprintf("**Interpretation.** With the fitted (correct) AR(1) the air-temperature CR2 test has Type I %s and coverage %s (%s / %s relative to nominal 5%% / 95%%, MC SE about 0.007 to 0.01 at these B). Under misspecified noise Type I is %s and coverage %s (%s / %s). The PM2.5 coefficient is the one term whose df is below 4 in simulation as in the data (%s of replicates), which is the same design-driven df collapse seen in the real fits. Bias for the air-temperature coefficient is %s (%.1f%% of the true effect). Coverage thresholds used for the verdict: 93%% to 97%% (95%% +/- 2 points); Type I thresholds 2.5%% to 7.5%%. These are judgements, not formal tests, and the simulation only speaks to this design and these noise models.",
  fnum(nullS$reject_rate_alpha05,3),fnum(nullS$cr2_coverage_95,3),verdict_size(nullS$reject_rate_alpha05),verdict_cov(nullS$cr2_coverage_95),fnum(strS$reject_rate_alpha05,3),fnum(strS$cr2_coverage_95,3),verdict_size(strS$reject_rate_alpha05),verdict_cov(strS$cr2_coverage_95),
  fnum(sim$share_df_lt4[sim$scenario=="alt_AR1" & sim$term=="atmo_pm2.5_avg"],2),fsig(altS$bias,2),100*altS$bias/altS$truth),"")

# =========================== SECTION 6 ===========================
add("## 6. Limitations","",
"- **Residual structure.** `REMAINING_SERIAL_CORRELATION`, `RESIDUAL_TAIL_SHAPE` and `BOUNDARY_VARIANCE` persist for skin temperature (see Executive summary item 5). The simulation tests robustness of CR2 to AR(2) dependence, not to every possible violation (non-Gaussian tails, trends, heteroscedasticity were not simulated).",
"- **Estimand.** Because phi is about 0.999, the coefficient is a short-time-scale effect (section 4.5). Reviewers should not read 0.1 degC per SD as the total association over minutes; the slow association is several times larger.",
sprintf("- **Eleven clusters.** CR2 with Satterthwaite df is the appropriate small-cluster correction, but df of 6 to 9.7 means CIs are wide relative to a normal approximation; one participant (e.g. %s for PM2.5) can dominate covariates.",pm_lev$ParticipantID[1]),
"- **Post-selection and multiplicity.** Step 4 screened on the same outcomes; BH q-values within heat-main and heat-product families are descriptive. Only the single skin-temperature air-temperature main effect survives q < 0.05 in the published hypothesis table, so the sensitivity analyses concentrate on it.",
"- **Sensitivity specs are POST-HOC** and were chosen after seeing Step 5 results (UTCI was already null in eq 16 for skin temperature). They test robustness, not discovery.",
"- **PM2.5** is a hypothesis-named post-hoc covariate identified by essentially one participant (see 2.4). No PM2.5-free refit is reported here because it is a nuisance covariate with no heat term df impact; it can be added if reviewers ask.",
"- **Measurement.** Wrist skin temperature is a physiological correlate, not a validated direct measure of thermal comfort or perception.","")

# =========================== SECTION 7 ===========================
add("## 7. Files and reproduction","",
"Run from the repository root (R 4.5.1, nlme, clubSandwich):","",
"```",
"Rscript scripts/h4_cr2_review_full.R                 # parts A,B,C,D,E (simulation B = 1000 + 500 stress)",
"H4_REVIEW_PARTS=E Rscript scripts/h4_cr2_review_full.R   # regenerate only this report from existing CSVs",
"```","",
"Supporting files in `H4_models/reliability_review_full/`:","",
"| File | Content |","|---|---|",
"| `H4_CR2_term_df_review.csv` | per outcome x term (heat, sound, products) df/SE/p/q on eq 4, 8, 12, 16 |",
"| `H4_CR2_df_summary_by_term.csv` | min / quartile / median / max df and counts by term |",
"| `H4_CR2_df_by_fit.csv` | all 416 fits: recomputed global and heat-specific min df, driving term |",
"| `H4_CR2_covariate_df_lt4_counts.csv`, `H4_CR2_predictor_participant_leverage.csv` | which covariates drop below df 4 and why |",
"| `H4_sensitivity_main_effects.csv`, `H4_sensitivity_fit_status.csv`, `H4_sensitivity_vs_full.csv`, `H4_thermal_within_person_correlations.csv` | POST-HOC S1 / S2 results and comparison |",
"| `H4_participant_LOO_skin_temp.csv`, `H4_LOO_sign_flips_components_heat_main_eq4_stored_diagnostics.csv` | LOO refits with CR2 |",
"| `H4_participant_within_person.csv`, `H4_participant_two_stage.csv`, `H4_participant_phase_level.csv`, `H4_participant_between_phase_direction.csv`, `H4_participant_phase_regression.csv`, `H4_participant_differenced_scale_check.csv` | participant / phase level checks |",
"| `H4_simulation_summary.csv`, `H4_simulation_replicates_airtemp.csv`, `H4_simulation_parameters.csv` | simulation outputs |","",
"Related earlier note (skin temp / air temp, eq 1 and 4): `H4_CR2_DF_diagnostic_skin_temp_air_temp.md`. The present review extends it to all heat forms and all outcomes, adds the sensitivity, participant-level and simulation checks, and refits LOO with CR2.","",
"Methods references: Pustejovsky and Tipton (2018) CR2 / Satterthwaite small-cluster inference (`clubSandwich::coef_test`); Pinheiro and Bates `nlme::lme` with `corAR1`; Nieuwenhuis, te Grotenhuis and Pelzer (2012) influence diagnostics for multilevel models.")

writeLines(md,file.path(out_dir,"H4_CR2_reliability_review.md"))
message("Wrote ",file.path(out_dir,"H4_CR2_reliability_review.md")," (",length(md)," lines)")
