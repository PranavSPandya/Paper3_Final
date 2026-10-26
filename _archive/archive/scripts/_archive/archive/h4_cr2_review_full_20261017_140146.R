# H4 CR2 reliability review, FULL (post hoc, review-driven). Does NOT replace CR2 inference and does NOT force df.
# (Named *_full because another review script, scripts/h4_cr2_reliability_review.R, was being written concurrently by a
#  separate agent; all outputs of THIS script go to H4_models/reliability_review_full/ so nothing is overwritten.)
#
# Parts (select with env H4_REVIEW_PARTS, default "A,B,C,D,E"):
#   A  coefficient-specific CR2 df for heat/sound/interaction terms (reads H4_coefficients.csv, no refits)
#   B  POST-HOC simpler main-effects sensitivity (refits; UTCI-only and air-temperature-only specs)
#   C  participant-level verification for skin temperature ~ air temperature (LOO refits, per-participant,
#      per-phase, exploratory phase-mean regression)
#   D  design-matched simulation (size, coverage, bias, failures of CR2 for the Components eq 4 skin-temp model)
#   E  writes H4_CR2_reliability_review.md from the CSVs written by A-D
# Env: H4_REVIEW_WORKERS (default 12), H4_SIM_B (default 1000), H4_SIM_B_STRESS (default 500), H4_SIM_SEED.
#
# Usage (repo root):  Rscript scripts/h4_cr2_review_full.R

suppressMessages({library(nlme);library(clubSandwich);library(parallel)})
parts <- strsplit(Sys.getenv("H4_REVIEW_PARTS","A,B,C,D,E"),",")[[1]]
n_workers <- as.integer(Sys.getenv("H4_REVIEW_WORKERS","12"))
sim_B <- as.integer(Sys.getenv("H4_SIM_B","1000"))
sim_B_stress <- as.integer(Sys.getenv("H4_SIM_B_STRESS","500"))
sim_seed <- as.integer(Sys.getenv("H4_SIM_SEED","20261009"))

# ---- Load the frozen Step-5 pipeline definitions (everything except the final env-var dispatcher) ----
.src_path <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final/scripts/h4_step5_equations.R"
.src <- parse(.src_path)
stopifnot(is.call(.src[[length(.src)]]), identical(.src[[length(.src)]][[1]], as.name("if")))
for(.i in seq_len(length(.src)-1L)) eval(.src[[.i]], globalenv())
rm(.i)
in_dir <- h4_model_dir
out_dir <- file.path(h4_model_dir,"reliability_review_full")
cache_dir <- file.path(out_dir,"_review_cache")
dir.create(cache_dir,recursive=TRUE,showWarnings=FALSE)
path <- function(f) file.path(out_dir,f)
wcsv <- function(d,f) write.csv(d,path(f),row.names=FALSE,na="")
coef_all <- read.csv(file.path(in_dir,"H4_coefficients.csv"),check.names=FALSE,stringsAsFactors=FALSE)
status_all <- read.csv(file.path(in_dir,"H4_fit_status.csv"),check.names=FALSE,stringsAsFactors=FALSE)
heat_eq <- c(Components=4L,HUMIDEX=8L,PET=12L,UTCI=16L)
skin <- "empatica_skin_temperature"

classify_term <- function(term,vars) {
  ifelse(term %in% vars,"heat main",
  ifelse(term=="ucm_SND_dBA","sound main",
  ifelse(grepl(":SND_dBA$",term),"heat x sound",
  ifelse(grepl(":Activity_Bike$",term),"heat x activity",
  ifelse(term=="Intercept","intercept","covariate")))))
}

# ---- cluster helper ----
pipeline_objs <- c("raw","centered","selected","thermal","nonthermal","H4_SPEC","component_set","component_role","make_design",
  "do_fit","diagnose","h4_equation_catalog","h4_spell_term","h4_heat_hypothesis_term","h4_status_row","h4_prep_outcome",
  "h4_fit_equation","fit_h4_outcome","fit_h4_outcome_empty_coef")
.cl <- NULL
get_cluster <- function(extra=character()) {
  if(is.null(.cl)) {
    .cl <<- parallel::makeCluster(n_workers)
    parallel::clusterEvalQ(.cl,{suppressMessages({library(nlme);library(clubSandwich)});NULL})
  }
  parallel::clusterExport(.cl,c(pipeline_objs,extra),envir=globalenv())
  .cl
}
on_exit_cluster <- function() if(!is.null(.cl)) try(parallel::stopCluster(.cl),silent=TRUE)

# =====================================================================================================
# PART A: coefficient-specific CR2 df
# =====================================================================================================
run_part_A <- function() {
  message("PART A: coefficient-specific CR2 df")
  rows <- list(); summ <- list()
  for(m in names(heat_eq)) {
    vars <- thermal[[m]]; eq <- heat_eq[[m]]
    keep <- c(vars,"ucm_SND_dBA",paste0(vars,":SND_dBA"),paste0(vars,":Activity_Bike"))
    st <- status_all[status_all$equation_id==eq,]
    for(tm in keep) {
      sub <- coef_all[coef_all$equation_id==eq & coef_all$term==tm,]
      role <- classify_term(tm,vars)
      for(y in outcomes) {
        s <- st[st$outcome==y,]; h <- sub[sub$outcome==y,]
        rows[[length(rows)+1L]] <- data.frame(heat_form=m,equation_id=eq,block="both_products",role=role,term=tm,outcome=y,
          fit_success=s$success,estimate=if(nrow(h)) h$estimate else NA_real_,se=if(nrow(h)) h$se else NA_real_,
          df=if(nrow(h)) h$df else NA_real_,p_value=if(nrow(h)) h$p_value else NA_real_,
          q_value=if(nrow(h)) h$q_value else NA_real_,df_lt4=if(nrow(h)) h$df<4 else NA,stringsAsFactors=FALSE)
      }
    }
  }
  term_df <- do.call(rbind,rows)
  wcsv(term_df,"H4_CR2_term_df_review.csv")
  key <- unique(term_df[,c("heat_form","equation_id","role","term")])
  for(i in seq_len(nrow(key))) {
    d <- term_df[term_df$heat_form==key$heat_form[i] & term_df$term==key$term[i],]
    ok <- d[is.finite(d$df),]
    summ[[i]] <- data.frame(key[i,],n_fits=nrow(ok),n_failed_fit=sum(!d$fit_success),
      df_min=min(ok$df),df_q25=unname(quantile(ok$df,.25)),df_median=median(ok$df),df_max=max(ok$df),
      n_df_lt4=sum(ok$df<4),outcomes_df_lt4=paste(ok$outcome[ok$df<4],collapse=";"),
      n_p_lt_05=sum(ok$p_value<.05),n_q_lt_05=sum(ok$q_value<.05,na.rm=TRUE),stringsAsFactors=FALSE)
  }
  summ <- do.call(rbind,summ)
  wcsv(summ,"H4_CR2_df_summary_by_term.csv")

  # per-fit: global min vs heat-specific min recomputed from coefficients (all 16 equations x 26 outcomes)
  fit_rows <- list()
  for(i in seq_len(nrow(status_all))) {
    s <- status_all[i,]
    cf <- coef_all[coef_all$equation_id==s$equation_id & coef_all$outcome==s$outcome & coef_all$term!="Intercept",]
    vars <- thermal[[s$heat_form]]
    is_heat <- vapply(cf$term,h4_heat_hypothesis_term,logical(1),heat_vars=vars)
    mn <- function(d) if(nrow(d)&&any(is.finite(d$df))) min(d$df,na.rm=TRUE) else NA_real_
    who <- function(d) if(nrow(d)&&any(is.finite(d$df))) d$term[which.min(d$df)] else NA_character_
    sd_ <- cf[cf$term=="ucm_SND_dBA",]
    fit_rows[[i]] <- data.frame(equation_id=s$equation_id,heat_form=s$heat_form,block=s$block,outcome=s$outcome,success=s$success,
      min_cr2_df_global_recomputed=mn(cf),term_at_global_min=who(cf),min_cr2_df_heat_recomputed=mn(cf[is_heat,]),term_at_heat_min=who(cf[is_heat,]),
      df_sound_main=if(nrow(sd_)) sd_$df else NA_real_,
      min_cr2_df_in_status_csv=s$min_cr2_df,status_has_min_cr2_df_heat="min_cr2_df_heat" %in% names(s),
      flag_LOW_EFFECTIVE_DF_in_status_note=grepl("LOW_EFFECTIVE_DF",s$note,fixed=TRUE),stringsAsFactors=FALSE)
  }
  by_fit <- do.call(rbind,fit_rows)
  by_fit$heat_df_lt4 <- by_fit$min_cr2_df_heat_recomputed<4
  by_fit$global_df_lt4 <- by_fit$min_cr2_df_global_recomputed<4
  by_fit$covariate_only_low_df <- by_fit$global_df_lt4 & !(by_fit$heat_df_lt4 %in% TRUE)
  wcsv(by_fit,"H4_CR2_df_by_fit.csv")
  # df<4 across all terms/fits (including covariates)
  allc <- coef_all[coef_all$term!="Intercept" & is.finite(coef_all$df),]
  low <- allc[allc$df<4,]
  low_tab <- if(nrow(low)) aggregate(df~term,low,function(v) length(v)) else data.frame(term=character(),df=numeric())
  names(low_tab)[names(low_tab)=="df"] <- "n_fits_df_lt4"
  low_tab$n_fits_total <- vapply(low_tab$term,function(t) sum(allc$term==t),numeric(1))
  wcsv(low_tab,"H4_CR2_covariate_df_lt4_counts.csv")
  # why: share of each predictor's within-person sum of squares contributed by each participant (leverage proxy for CR2 df)
  lev <- do.call(rbind,lapply(c(nonthermal,component_set,"ucm_UTCI","ucm_PET","ucm_HUMIDEX"),function(v) {
    x <- centered[,v]; ok <- is.finite(x); ss <- tapply(x[ok]^2,as.character(raw$ParticipantID[ok]),sum)
    data.frame(variable=v,ParticipantID=names(ss),share_of_within_person_SS=as.numeric(ss/sum(ss)),stringsAsFactors=FALSE)
  }))
  wcsv(lev,"H4_CR2_predictor_participant_leverage.csv")
  invisible(list(term_df=term_df,summ=summ,by_fit=by_fit,low_tab=low_tab))
}

# =====================================================================================================
# PART B: POST-HOC simpler main-effects sensitivity
# =====================================================================================================
sens_specs <- data.frame(spec=c("S1_UTCI_only","S2_air_temperature_only"),heat_form=c("SENS_UTCI","SENS_AIR"),
  var=c("ucm_UTCI","ucm_AIR_temp"),equation_id=c(101L,102L),stringsAsFactors=FALSE)
sens_catalog <- function(i) {
  vars <- sens_specs$var[i]
  data.frame(equation_id=sens_specs$equation_id[i],heat_form=sens_specs$heat_form[i],block="no_products",test="Base",
    terms=paste(vapply(c(nonthermal,vars,"Activity_Bike"),h4_spell_term,character(1)),collapse=" + "),
    heat_role="post-hoc sensitivity",fitted=FALSE,stringsAsFactors=FALSE)
}
sens_fit <- function(y,i) {
  eq <- sens_catalog(i)
  # h4_fit_equation looks up thermal[[heat_form]] in the global env; add the sensitivity form temporarily (worker-local)
  thermal_saved <- thermal
  thermal <<- c(thermal_saved,setNames(list(sens_specs$var[i]),sens_specs$heat_form[i]))
  on.exit(thermal <<- thermal_saved,add=TRUE)
  prep <- h4_prep_outcome(y,unique(c(nonthermal,sens_specs$var[i])))
  if(!prep$ok) return(list(status=h4_status_row(y,eq,FALSE,prep$note,prep$d0,"native",n=prep$n),coef=NULL))
  h4_fit_equation(prep,eq)
}
run_part_B <- function() {
  message("PART B: post-hoc main-effects sensitivity")
  cl <- get_cluster(c("sens_specs","sens_catalog","sens_fit"))
  jobs <- expand.grid(i=seq_len(nrow(sens_specs)),y=outcomes,stringsAsFactors=FALSE)
  job_list <- lapply(seq_len(nrow(jobs)),function(k) list(i=jobs$i[k],y=jobs$y[k]))
  res <- parallel::parLapplyLB(cl,job_list,function(j) sens_fit(j$y,j$i))
  coefs <- list(); stats <- list()
  for(k in seq_along(res)) {
    spec <- sens_specs$spec[job_list[[k]]$i]
    st <- res[[k]]$status; st$spec <- spec; stats[[k]] <- st
    if(!is.null(res[[k]]$coef)) { cf <- res[[k]]$coef; cf$spec <- spec; coefs[[length(coefs)+1L]] <- cf }
  }
  coef_s <- do.call(rbind,coefs); stat_s <- do.call(rbind,stats)
  coef_s$role <- NA_character_
  for(i in seq_len(nrow(sens_specs))) {
    ix <- coef_s$spec==sens_specs$spec[i]
    coef_s$role[ix] <- classify_term(coef_s$term[ix],sens_specs$var[i])
  }
  coef_s$q_value <- NA_real_
  coef_s$fdr_family <- "not in family"
  for(i in seq_len(nrow(sens_specs))) {
    ix <- coef_s$spec==sens_specs$spec[i] & coef_s$term==sens_specs$var[i]
    coef_s$q_value[ix] <- p.adjust(coef_s$p_value[ix],method="BH")
    coef_s$fdr_family[ix] <- paste0(sens_specs$spec[i],"_thermal_main_26_outcomes")
  }
  coef_s$posthoc_label <- "POST-HOC sensitivity (not preregistered, not a replacement for Step 5 eq 1-16)"
  keep <- c("spec","equation_id","outcome","term","role","estimate","se","df","ci_low","ci_high","t_stat","p_value","q_value","fdr_family","posthoc_label")
  coef_s <- coef_s[order(match(coef_s$spec,sens_specs$spec),match(coef_s$outcome,outcomes)),keep]
  wcsv(coef_s,"H4_sensitivity_main_effects.csv")
  stat_keep <- c("spec","outcome","success","n","n_participants","converged","lag1_normalized","ar1_rho","boundary_variance","min_cr2_df","min_cr2_df_heat","note")
  wcsv(stat_s[,stat_keep],"H4_sensitivity_fit_status.csv")

  # comparison against the full Step-5 models
  cmp <- list()
  for(y in outcomes) {
    g <- function(eq,term) { h <- coef_all[coef_all$equation_id==eq & coef_all$outcome==y & coef_all$term==term,]; if(nrow(h)==1L) h else NULL }
    s2 <- coef_s[coef_s$spec=="S2_air_temperature_only" & coef_s$outcome==y & coef_s$term=="ucm_AIR_temp",]
    s1 <- coef_s[coef_s$spec=="S1_UTCI_only" & coef_s$outcome==y & coef_s$term=="ucm_UTCI",]
    a4 <- g(4L,"ucm_AIR_temp"); a1 <- g(1L,"ucm_AIR_temp"); u16 <- g(16L,"ucm_UTCI"); u13 <- g(13L,"ucm_UTCI")
    v <- function(h,f) if(is.null(h)||!nrow(h)) NA_real_ else h[[f]]
    cmp[[length(cmp)+1L]] <- data.frame(outcome=y,
      air_eq4_est=v(a4,"estimate"),air_eq4_df=v(a4,"df"),air_eq4_p=v(a4,"p_value"),air_eq4_q=v(a4,"q_value"),
      air_eq1_est=v(a1,"estimate"),air_eq1_p=v(a1,"p_value"),
      air_S2_est=v(s2,"estimate"),air_S2_se=v(s2,"se"),air_S2_df=v(s2,"df"),air_S2_p=v(s2,"p_value"),air_S2_q=v(s2,"q_value"),
      utci_eq16_est=v(u16,"estimate"),utci_eq16_df=v(u16,"df"),utci_eq16_p=v(u16,"p_value"),utci_eq16_q=v(u16,"q_value"),
      utci_eq13_est=v(u13,"estimate"),
      utci_S1_est=v(s1,"estimate"),utci_S1_se=v(s1,"se"),utci_S1_df=v(s1,"df"),utci_S1_p=v(s1,"p_value"),utci_S1_q=v(s1,"q_value"),
      stringsAsFactors=FALSE)
  }
  cmp <- do.call(rbind,cmp)
  cmp$air_sign_agree_S2_vs_eq4 <- sign(cmp$air_S2_est)==sign(cmp$air_eq4_est)
  cmp$air_ratio_S2_to_eq4 <- cmp$air_S2_est/cmp$air_eq4_est
  cmp$utci_sign_agree_S1_vs_eq16 <- sign(cmp$utci_S1_est)==sign(cmp$utci_eq16_est)
  cmp$utci_ratio_S1_to_eq16 <- cmp$utci_S1_est/cmp$utci_eq16_est
  wcsv(cmp,"H4_sensitivity_vs_full.csv")
  # reproducibility check: S1 must equal pipeline eq 13 (same design)
  chk <- max(abs(cmp$utci_S1_est-cmp$utci_eq13_est),na.rm=TRUE)
  message("PART B reproducibility check |S1 - eq13| max diff = ",signif(chk,3))
  stopifnot(chk<1e-6)
  # within-person correlations among thermal predictors (context for collinearity)
  zc <- centered[,c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT","ucm_UTCI","ucm_PET","ucm_HUMIDEX")]
  cm <- round(cor(zc,use="pairwise.complete.obs"),3)
  write.csv(cm,path("H4_thermal_within_person_correlations.csv"))
  invisible(list(coef=coef_s,status=stat_s,cmp=cmp))
}

# =====================================================================================================
# PART C: participant-level verification (skin temperature ~ air temperature)
# =====================================================================================================
run_part_C <- function() {
  message("PART C: participant-level verification")
  cl <- get_cluster()
  pids <- sort(unique(as.character(raw$ParticipantID)))
  # C1: LOO refits eq 1 and eq 4 with CR2 (not point-only) -- independent of H4_diagnostics.csv
  loo_jobs <- c(list(NULL),as.list(pids))
  loo_res <- parallel::parLapplyLB(cl,loo_jobs,function(pid) fit_h4_outcome("empatica_skin_temperature",c(1L,4L),drop_participant=pid,point_only=FALSE))
  loo_rows <- list()
  full <- loo_res[[1]]$coef
  for(j in seq_along(loo_jobs)) {
    cf <- loo_res[[j]]$coef; pid <- if(is.null(loo_jobs[[j]])) "NONE (full sample)" else loo_jobs[[j]]
    st <- loo_res[[j]]$status
    cf <- cf[cf$term!="Intercept",]
    cf$dropped_participant <- pid
    cf$n <- st$n[match(cf$equation_id,st$equation_id)]
    cf$n_participants <- st$n_participants[match(cf$equation_id,st$equation_id)]
    loo_rows[[j]] <- cf
  }
  loo <- do.call(rbind,loo_rows)
  fe <- full[,c("equation_id","term","estimate")]; names(fe)[3] <- "full_estimate"
  loo <- merge(loo,fe,by=c("equation_id","term"),all.x=TRUE)
  loo$pct_change_vs_full <- 100*(loo$estimate-loo$full_estimate)/abs(loo$full_estimate)
  loo$sign_flip <- sign(loo$estimate)!=sign(loo$full_estimate)
  loo$p_lt_05 <- loo$p_value<.05
  loo <- loo[order(loo$equation_id,match(loo$term,unique(full$term)),loo$dropped_participant),]
  # reconcile with stored diagnostics
  dg <- read.csv(file.path(in_dir,"H4_diagnostics.csv"),check.names=FALSE,stringsAsFactors=FALSE)
  dg <- dg[dg$row_type=="leave_one_participant" & dg$outcome==skin,]
  mm <- merge(loo[loo$dropped_participant!="NONE (full sample)",],dg[,c("equation_id","term","dropped_participant","loo_estimate")],
              by=c("equation_id","term","dropped_participant"))
  loo_vs_diag_maxdiff <- max(abs(mm$estimate-mm$loo_estimate),na.rm=TRUE)
  message("PART C: refit vs stored H4_diagnostics LOO max |diff| = ",signif(loo_vs_diag_maxdiff,3)," over ",nrow(mm)," comparisons")
  loo$refit_vs_stored_diagnostics_maxdiff <- loo_vs_diag_maxdiff
  wcsv(loo,"H4_participant_LOO_skin_temp.csv")

  # summary of stored diagnostics across ALL outcomes: sign flips for Components heat main effects eq4
  dga <- read.csv(file.path(in_dir,"H4_diagnostics.csv"),check.names=FALSE,stringsAsFactors=FALSE)
  dga <- dga[dga$row_type=="leave_one_participant" & dga$equation_id==4L & dga$term %in% component_set,]
  flip_summ <- aggregate(sign_flip~outcome+term,dga,function(v) sum(v %in% TRUE))
  names(flip_summ)[3] <- "n_participants_dropped_that_flip_sign"
  wcsv(flip_summ,"H4_LOO_sign_flips_components_heat_main_eq4_stored_diagnostics.csv")

  # C2/C3: within-person and phase-level descriptives on the eq-4 skin-temperature analysis sample
  prep <- h4_prep_outcome(skin,unique(c(nonthermal,thermal$Components)))
  dd <- data.frame(ParticipantID=as.character(prep$d0$ParticipantID),PhaseID=as.character(prep$d0$PhaseID),Time10=prep$d0$Time10,
    air_z=prep$z[,"ucm_AIR_temp"],skin=prep$yv,mode=prep$mode,stringsAsFactors=FALSE)
  dd$bout <- paste(dd$ParticipantID,dd$PhaseID,sep="|")
  dd$skin_c <- dd$skin-ave(dd$skin,dd$ParticipantID)
  dd$air_c <- dd$air_z-ave(dd$air_z,dd$ParticipantID)
  dd$skin_w <- dd$skin-ave(dd$skin,dd$bout)
  dd$air_w <- dd$air_z-ave(dd$air_z,dd$bout)
  slope <- function(x,y) if(length(x)>2 && sd(x)>0) unname(coef(lm(y~x))[2]) else NA_real_
  corr <- function(x,y) if(length(x)>2 && sd(x)>0 && sd(y)>0) cor(x,y) else NA_real_
  parts_tab <- do.call(rbind,lapply(pids,function(p) {
    d <- dd[dd$ParticipantID==p,]
    data.frame(ParticipantID=p,n_windows=nrow(d),n_phases=length(unique(d$PhaseID)),
      r_within_person=corr(d$air_c,d$skin_c),slope_skin_per_air_SD=slope(d$air_c,d$skin_c),
      r_within_phase=corr(d$air_w,d$skin_w),slope_within_phase=slope(d$air_w,d$skin_w),
      mean_skin=mean(d$skin),sd_air_z=sd(d$air_z),sd_skin=sd(d$skin),stringsAsFactors=FALSE)
  }))
  parts_tab$positive_within_person <- parts_tab$r_within_person>0
  parts_tab$positive_within_phase <- parts_tab$r_within_phase>0
  wcsv(parts_tab,"H4_participant_within_person.csv")
  two_stage <- function(v) { v <- v[is.finite(v)]; n <- length(v); m <- mean(v); se <- sd(v)/sqrt(n); tcrit <- qt(.975,n-1)
    data.frame(n=n,mean_slope=m,se=se,ci_low=m-tcrit*se,ci_high=m+tcrit*se,t=m/se,df=n-1,p=2*pt(-abs(m/se),n-1),
               n_positive=sum(v>0),sign_test_p=binom.test(sum(v>0),n,.5)$p.value) }
  ts <- rbind(cbind(estimator="two-stage mean of per-participant slopes (pooled within person)",two_stage(parts_tab$slope_skin_per_air_SD)),
              cbind(estimator="two-stage mean of per-participant within-phase slopes",two_stage(parts_tab$slope_within_phase)))
  wcsv(ts,"H4_participant_two_stage.csv")

  phase_tab <- do.call(rbind,lapply(split(dd,dd$bout),function(d) data.frame(ParticipantID=d$ParticipantID[1],PhaseID=d$PhaseID[1],
    n_windows=nrow(d),mean_air_z=mean(d$air_z),mean_skin=mean(d$skin),mean_skin_participant_centered=mean(d$skin_c),
    sd_air_z_in_phase=sd(d$air_z),r_within_phase=corr(d$air_w,d$skin_w),slope_within_phase=slope(d$air_w,d$skin_w),stringsAsFactors=FALSE)))
  rownames(phase_tab) <- NULL
  phase_tab$positive_within_phase <- phase_tab$r_within_phase>0
  phase_tab <- phase_tab[order(phase_tab$ParticipantID,phase_tab$PhaseID),]
  wcsv(phase_tab,"H4_participant_phase_level.csv")
  # direction of between-phase relation per participant (4 phase means; descriptive, n=4)
  pb <- do.call(rbind,lapply(split(phase_tab,phase_tab$ParticipantID),function(d) data.frame(ParticipantID=d$ParticipantID[1],
    slope_phase_means=slope(d$mean_air_z,d$mean_skin),r_phase_means=corr(d$mean_air_z,d$mean_skin),stringsAsFactors=FALSE)))
  wcsv(pb,"H4_participant_between_phase_direction.csv")

  # C4: exploratory regressions (CR2 by participant)
  phase_tab$ParticipantID <- factor(phase_tab$ParticipantID)
  phase_tab$mode <- as.numeric(grepl("^Bike",phase_tab$PhaseID))-.5
  reg_rows <- list()
  add_reg <- function(label,m,term,cluster) {
    ct <- clubSandwich::coef_test(m,vcov="CR2",cluster=cluster,test="Satterthwaite")
    i <- which(rownames(ct)==term)
    reg_rows[[length(reg_rows)+1L]] <<- data.frame(model=label,term=term,estimate=ct$beta[i],se=ct$SE[i],df=ct$df_Satt[i],p_value=ct$p_Satt[i],
      n_rows=length(residuals(m)),n_clusters=length(unique(cluster)),stringsAsFactors=FALSE)
  }
  m1 <- lm(mean_skin~mean_air_z+ParticipantID,phase_tab)
  add_reg("EXPLORATORY phase means (44 rows): skin ~ air + participant FE",m1,"mean_air_z",phase_tab$ParticipantID)
  m2 <- lm(mean_skin~mean_air_z+mode+ParticipantID,phase_tab)
  add_reg("EXPLORATORY phase means (44 rows): skin ~ air + activity + participant FE",m2,"mean_air_z",phase_tab$ParticipantID)
  dd$ParticipantID_f <- factor(dd$ParticipantID); dd$bout_f <- factor(dd$bout)
  m3 <- lm(skin~air_z+bout_f,dd)
  add_reg("EXPLORATORY within-phase windows (2101 rows): skin ~ air + participant-phase FE",m3,"air_z",dd$ParticipantID_f)
  m4 <- lm(skin~air_z+mode+ParticipantID_f,dd)
  add_reg("EXPLORATORY pooled windows OLS: skin ~ air + activity + participant FE",m4,"air_z",dd$ParticipantID_f)
  regs <- do.call(rbind,reg_rows)
  wcsv(regs,"H4_participant_phase_regression.csv")
  # C5 (exploratory): differenced regressions at several time scales. The Step-5 AR(1) has phi ~ 0.999, so the GLS slope is
  # effectively a high-frequency (first-difference-like) estimate; slow co-trends within a phase carry a different slope.
  dd <- dd[order(dd$bout,dd$Time10),]
  diff_rows <- list()
  for(k in c(1L,6L,12L,24L)) {
    pairs <- do.call(rbind,lapply(split(dd,dd$bout),function(d) {
      idx <- match(d$Time10+k,d$Time10); ok <- !is.na(idx)
      if(!any(ok)) return(NULL)
      data.frame(ParticipantID=d$ParticipantID[ok],dy=d$skin[idx[ok]]-d$skin[ok],dx=d$air_z[idx[ok]]-d$air_z[ok],stringsAsFactors=FALSE)
    }))
    m <- lm(dy~dx,pairs)
    ct <- clubSandwich::coef_test(m,vcov="CR2",cluster=pairs$ParticipantID,test="Satterthwaite")
    per_p <- vapply(split(pairs,pairs$ParticipantID),function(d) unname(coef(lm(dy~dx,d))[2]),numeric(1))
    diff_rows[[length(diff_rows)+1L]] <- data.frame(lag_windows=k,lag_seconds=10*k,n_pairs=nrow(pairs),estimate=ct$beta[2],se=ct$SE[2],df=ct$df_Satt[2],
      p_value=ct$p_Satt[2],n_participants_positive_slope=sum(per_p>0),n_participants=length(per_p),stringsAsFactors=FALSE)
  }
  wcsv(do.call(rbind,diff_rows),"H4_participant_differenced_scale_check.csv")
  invisible(list(loo=loo,parts=parts_tab,phase=phase_tab,regs=regs,ts=ts))
}

# =====================================================================================================
# PART D: design-matched simulation
# =====================================================================================================
# Replicates the Step-5 eq 4 Components skin-temperature design exactly (same X, bouts, Time10 gaps, 2101 complete cases).
sim_setup <- function() {
  prep <- h4_prep_outcome(skin,unique(c(nonthermal,thermal$Components)))
  design <- make_design(prep$z,thermal$Components,prep$mode,"Joint")
  original <- colnames(design); safe <- make.names(original,unique=TRUE); colnames(design) <- safe
  fd <- cbind(prep$d0,Y=prep$yv,as.data.frame(design))
  fd <- fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
  formula <- reformulate(safe,response="Y")
  fit <- tryCatch(do_fit(formula,fd,"nlminb"),error=function(e) do_fit(formula,fd,"optim"))
  vc <- nlme::VarCorr(fit)
  sds <- suppressWarnings(as.numeric(vc[,"StdDev"])); sds <- sds[is.finite(sds)]
  phi <- unname(coef(fit$modelStruct$corStruct,unconstrained=FALSE))
  beta <- nlme::fixef(fit)
  names(beta) <- c("Intercept",safe)   # safe (make.names) names: match lme/clubSandwich row names
  name_map <- setNames(c("Intercept",safe),c("Intercept",original))   # original -> safe
  heat_terms <- safe[vapply(original,h4_heat_hypothesis_term,logical(1),heat_vars=component_set)]
  list(fd=fd,formula=formula,safe=safe,original=original,beta=beta,name_map=name_map,sd_participant=sds[1],sd_phase=sds[2],sd_resid=sds[3],phi=phi,
       heat_terms=heat_terms)
}
sim_precompute <- function(S) {
  fd <- S$fd
  fd$bout <- interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
  S$bout_idx <- split(seq_len(nrow(fd)),fd$bout)
  S$bout_time <- lapply(S$bout_idx,function(ix) fd$Time10[ix])
  S$part_of_row <- as.integer(factor(fd$ParticipantID))
  S$bout_of_row <- as.integer(fd$bout)
  S$X <- cbind(Intercept=1,as.matrix(fd[,S$safe,drop=FALSE]))
  S
}
# autocorrelation of an AR(2) with real roots a,b: rho(h) proportional to a^(h+1)/(1-a^2) - b^(h+1)/(1-b^2)
ar2_rho <- function(D,a,b) { g <- function(h) a^(h+1)/(1-a^2)-b^(h+1)/(1-b^2); g(D)/g(0) }
chol_of <- function(times,comp) {
  D <- abs(outer(times,times,"-"))
  Sig <- Reduce(`+`,lapply(comp,function(c) if(identical(c$type,"ar2")) c$var*ar2_rho(D,c$a,c$b) else c$var*c$phi^D))
  tryCatch(chol(Sig),error=function(e) chol(Sig+diag(1e-8*mean(diag(Sig)),nrow(Sig))))
}
sim_scenarios <- function(S) {
  # Stress noise: AR(2) with roots (fitted phi, 0.59). Whitening an AR(2) by its dominant AR(1) factor leaves an AR(1)
  # innovation process with coefficient = the second root, so root 0.59 reproduces the observed post-AR(1) normalized lag-1
  # residual correlation (0.59 for skin temperature) that the Step-5 note flags as REMAINING_SERIAL_CORRELATION.
  second_root <- 0.59
  list(
    null_AR1=list(label="NULL: all 9 heat terms = 0; noise = fitted AR(1)",beta=replace(S$beta,S$heat_terms,0),
      noise=list(list(var=S$sd_resid^2,phi=S$phi)),B=sim_B),
    alt_AR1=list(label="ALTERNATIVE: coefficients = observed eq 4 estimates (air temp main = observed); noise = fitted AR(1)",beta=S$beta,
      noise=list(list(var=S$sd_resid^2,phi=S$phi)),B=sim_B),
    null_stress=list(label="STRESS NULL: heat terms = 0; noise = AR(2) with roots 0.999 and 0.59 (same marginal variance), so the fitted AR(1) is misspecified and leaves normalized lag-1 residual correlation ~0.59 as in the real data",
      beta=replace(S$beta,S$heat_terms,0),
      noise=list(list(var=S$sd_resid^2,type="ar2",a=S$phi,b=second_root)),B=sim_B_stress))
}
sim_one <- function(S,scn,L_list) {
  n <- nrow(S$fd)
  up <- rnorm(length(unique(S$part_of_row)),0,S$sd_participant)
  vb <- rnorm(length(S$bout_idx),0,S$sd_phase)
  e <- numeric(n)
  for(b in seq_along(S$bout_idx)) { ix <- S$bout_idx[[b]]; e[ix] <- as.numeric(crossprod(L_list[[b]],rnorm(length(ix)))) }
  Y <- as.numeric(S$X %*% scn$beta[colnames(S$X)]) + up[S$part_of_row] + vb[S$bout_of_row] + e
  fd <- S$fd; fd$Y <- Y
  fit <- tryCatch(suppressWarnings(do_fit(S$formula,fd,"nlminb")),
                  error=function(e1) tryCatch(suppressWarnings(do_fit(S$formula,fd,"optim")),error=function(e2) NULL))
  fail <- function(why) data.frame(term=S$original,estimate=NA_real_,se=NA_real_,df=NA_real_,p=NA_real_,truth=unname(scn$beta[S$safe]),
    naive_p=NA_real_,naive_se=NA_real_,fit_ok=FALSE,note=why,lag1_norm=NA_real_,phi_hat=NA_real_,stringsAsFactors=FALSE)
  if(is.null(fit)) return(fail("nlme failed"))
  ct <- tryCatch(suppressWarnings(clubSandwich::coef_test(fit,vcov="CR2",cluster=fd$ParticipantID,test="Satterthwaite")),error=function(e) NULL)
  if(is.null(ct)) return(fail("CR2 failed"))
  tt <- summary(fit)$tTable
  rn <- tryCatch(residuals(fit,level=2,type="normalized"),error=function(e) NULL)
  lag1 <- NA_real_
  if(!is.null(rn)) { grp <- as.integer(factor(interaction(fd$ParticipantID,fd$PhaseID)))
    adj <- which(grp[-1]==grp[-length(grp)] & abs(diff(fd$Time10)-1)<1e-6); if(length(adj)>2) lag1 <- cor(rn[adj],rn[adj+1]) }
  phi_hat <- tryCatch(unname(coef(fit$modelStruct$corStruct,unconstrained=FALSE)),error=function(e) NA_real_)
  i <- match(S$safe,rownames(ct)); j <- match(S$safe,rownames(tt))
  data.frame(term=S$original,estimate=ct$beta[i],se=ct$SE[i],df=ct$df_Satt[i],p=ct$p_Satt[i],truth=unname(scn$beta[S$safe]),
    naive_p=tt[j,"p-value"],naive_se=tt[j,"Std.Error"],fit_ok=TRUE,note="",lag1_norm=lag1,phi_hat=phi_hat,stringsAsFactors=FALSE)
}
sim_chunk <- function(S,scn,L_list,reps) {
  do.call(rbind,lapply(reps,function(r) { d <- sim_one(S,scn,L_list); d$rep <- r; d }))
}
run_part_D <- function() {
  message("PART D: design-matched simulation; B=",sim_B," (stress B=",sim_B_stress,")")
  S <- sim_precompute(sim_setup())
  ref <- coef_all[coef_all$equation_id==4L & coef_all$outcome==skin,]
  chk <- max(abs(S$beta[S$name_map[ref$term]]-ref$estimate))
  stopifnot(chk<1e-6)
  message("PART D: sim fit reproduces stored eq4 skin-temp estimates (max diff ",signif(chk,3),"); phi=",signif(S$phi,5),
          ", sd_resid=",signif(S$sd_resid,4),", sd_participant=",signif(S$sd_participant,4),", sd_phase=",signif(S$sd_phase,3))
  scns <- sim_scenarios(S)
  cl <- get_cluster(c("sim_one","sim_chunk","chol_of","classify_term","skin","sim_B","sim_B_stress"))
  parallel::clusterSetRNGStream(cl,sim_seed)
  all_reps <- list()
  for(nm in names(scns)) {
    scn <- scns[[nm]]
    L_list <- lapply(seq_along(S$bout_idx),function(b) chol_of(S$bout_time[[b]],scn$noise))
    reps <- seq_len(scn$B)
    chunks <- split(reps,rep_len(seq_len(n_workers*3L),length(reps)))
    t0 <- Sys.time()
    res <- parallel::parLapplyLB(cl,chunks,function(r,S,scn,L_list) sim_chunk(S,scn,L_list,r),S=S,scn=scn,L_list=L_list)
    d <- do.call(rbind,res); d$scenario <- nm
    message("  ",nm,": ",length(reps)," reps in ",round(as.numeric(difftime(Sys.time(),t0,units="mins")),1)," min; replicates with a failure=",sum(!tapply(d$fit_ok,d$rep,all)))
    saveRDS(d,file.path(cache_dir,paste0("sim_",nm,".rds")))
    all_reps[[nm]] <- d
  }
  d <- do.call(rbind,all_reps)
  attr(d,"S_summary") <- list(phi=S$phi,sd_resid=S$sd_resid,sd_participant=S$sd_participant,sd_phase=S$sd_phase)
  summarize_sim(d,scns,S)
}
summarize_sim <- function(d,scns,S) {
  rows <- list()
  for(nm in names(scns)) {
    ds <- d[d$scenario==nm,]
    B <- length(unique(ds$rep)); fails <- sum(!tapply(ds$fit_ok,ds$rep,all))
    for(tm in S$original) {
      x <- ds[ds$term==tm & ds$fit_ok,]
      truth <- unname(scns[[nm]]$beta[S$name_map[[tm]]])
      tcrit <- qt(.975,x$df)
      lo <- x$estimate-tcrit*x$se; hi <- x$estimate+tcrit*x$se
      cover <- mean(lo<=truth & truth<=hi)
      rej <- mean(x$p<.05)
      ncl <- nrow(x)
      naive_rej <- mean(x$naive_p<.05)
      lo2 <- x$estimate-1.96*x$naive_se; hi2 <- x$estimate+1.96*x$naive_se
      naive_cover <- mean(lo2<=truth & truth<=hi2)
      rows[[length(rows)+1L]] <- data.frame(scenario=nm,scenario_label=scns[[nm]]$label,term=tm,role=classify_term(tm,component_set),
        B_requested=B,n_replicates_with_fit_failure=fails,n_used=ncl,truth=truth,
        mean_estimate=mean(x$estimate),bias=mean(x$estimate)-truth,rmse=sqrt(mean((x$estimate-truth)^2)),
        empirical_sd_estimate=sd(x$estimate),mean_cr2_se=mean(x$se),median_cr2_se=median(x$se),se_ratio_mean_over_empirical=mean(x$se)/sd(x$estimate),
        cr2_coverage_95=cover,coverage_mc_se=sqrt(cover*(1-cover)/ncl),
        reject_rate_alpha05=rej,reject_mc_se=sqrt(rej*(1-rej)/ncl),
        df_median=median(x$df),df_min=min(x$df),df_p05=unname(quantile(x$df,.05)),share_df_lt4=mean(x$df<4),
        model_based_reject_alpha05=naive_rej,model_based_coverage_normal95=naive_cover,
        median_lag1_normalized=median(ds$lag1_norm[ds$term==tm & ds$fit_ok],na.rm=TRUE),
        median_phi_hat=median(ds$phi_hat[ds$term==tm & ds$fit_ok],na.rm=TRUE),stringsAsFactors=FALSE)
    }
  }
  summ <- do.call(rbind,rows)
  wcsv(summ,"H4_simulation_summary.csv")
  air <- d[d$term=="ucm_AIR_temp",c("scenario","rep","estimate","se","df","p","truth","naive_p","fit_ok","lag1_norm","phi_hat")]
  wcsv(air,"H4_simulation_replicates_airtemp.csv")
  invisible(summ)
}

# ---- driver ----
res <- list()
if("A" %in% parts) res$A <- run_part_A()
if("B" %in% parts) res$B <- run_part_B()
if("C" %in% parts) res$C <- run_part_C()
if("D" %in% parts) res$D <- run_part_D()
on_exit_cluster()
if("E" %in% parts) {
  e_path <- file.path(dirname(.src_path),"h4_cr2_review_full_report.R")
  stopifnot(file.exists(e_path))
  source(e_path,local=FALSE)
}
message("h4_cr2_review_full.R finished parts: ",paste(parts,collapse=","))
