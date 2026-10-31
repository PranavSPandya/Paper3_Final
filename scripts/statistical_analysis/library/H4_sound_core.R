# Shared execution for the Eq1-only sound substitution entry scripts.
# No original H4 runner is sourced and no other equation is defined or executed.

# Eq1 substitutes ucm_SND_dBA for one acoustic column at a time; indexed list lives in the entry
# scripts (canonical: scripts/statistical_analysis/H4_timeseries_sound.R).

h4s_read_sound_substitutes_from_entry <- function(timeseries_entry_path) {
  exprs <- parse(timeseries_entry_path)
  hit <- Filter(function(e) is.call(e) && identical(e[[1]], as.name('<-')) &&
    identical(as.character(e[[2]]), 'h4s_sound_substitutes'), exprs)
  stopifnot(length(hit) == 1L)
  eval(hit[[1]][[3]], envir = .GlobalEnv)
}

h4s_helper <- function(name, path) {
  expressions <- parse(path)
  hit <- Filter(function(z) is.call(z) && identical(z[[1]], as.name('<-')) &&
    is.symbol(z[[2]]) && identical(as.character(z[[2]]), name), expressions)
  stopifnot(length(hit) == 1L)
  eval(hit[[1]][[3]], envir = .GlobalEnv)
}

h4s_load <- function(root, outcomes) {
  path <- paper3_merged_8min_path(root)
  d <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  d <- d[d$ParticipantID %in% PAPER3_PARTICIPANTS & d$PhaseID %in% PAPER3_CORE_PHASES, , drop = FALSE]
  d$Datetime <- as.POSIXct(d$Datetime, tz = 'UTC')
  stopifnot(!anyNA(d$Datetime), !anyDuplicated(d[c('ParticipantID','PhaseID','Datetime')]))
  d <- d[order(d$ParticipantID, d$PhaseID, d$Datetime), ]
  bilateral <- list(atmo.pm = c('atmo_lys_atmotube_left__atmotube_pm2.5','atmo_lys_atmotube_right__atmotube_pm2.5'),
    lux = c('atmo_lys_LYS1__lys_lux','atmo_lys_LYS2__lys_lux'),
    kelvin = c('atmo_lys_LYS1__lys_kelvin','atmo_lys_LYS2__lys_kelvin'))
  for (j in seq_along(bilateral)) {
    target <- c('atmo_pm2.5_avg','lys_lux_avg','lys_kelvin_avg')[j]
    stopifnot(all(bilateral[[j]] %in% names(d)))
    d[[target]] <- rowMeans(d[bilateral[[j]]], na.rm = TRUE)
    d[[target]][!is.finite(d[[target]])] <- NA_real_
  }
  available <- tolower(as.character(d$empatica_hrv_fd_5min_available)) %in% c('true','1')
  for (v in attr(outcomes, 'empatica_hrv_fd_window')) d[[v]][!available] <- NA_real_
  d$SVF_endpoint_carried <- FALSE
  for (ix in split(seq_len(nrow(d)), interaction(d$ParticipantID,d$PhaseID,drop=TRUE))) {
    if (length(ix) < 2L) next
    last <- tail(ix,1); previous <- tail(ix,2)[1]
    if (!is.finite(d$SVF[last]) && is.finite(d$SVF[previous]) &&
        as.numeric(difftime(d$Datetime[last],d$Datetime[previous],units='secs')) == 10) {
      d$SVF[last] <- d$SVF[previous]; d$SVF_endpoint_carried[last] <- TRUE
    }
  }
  group <- interaction(d$ParticipantID,d$PhaseID,drop=TRUE)
  span <- tapply(as.numeric(d$Datetime), group, function(x) diff(range(x)))
  stopifnot(length(unique(d$ParticipantID))==11L,length(span)==44L,all(span<=480))
  d$Time10 <- as.integer(round((as.numeric(d$Datetime)-ave(as.numeric(d$Datetime),group,FUN=min))/10))
  list(data=d, path=path)
}

h4s_center <- function(x, group) {
  x[!is.finite(x)] <- NA_real_
  deviation <- x - ave(x, group, FUN=function(v) mean(v,na.rm=TRUE))
  shared_sd <- sd(deviation[is.finite(deviation)])
  if (is.finite(shared_sd) && shared_sd>0) deviation/shared_sd else deviation
}

h4s_formula <- function(sound, mode, template) {
  f <- template[[2L]]
  placeholder <- if(mode=='timeseries') 'SOUND_bout_z' else 'SOUND_phase_z'
  replacement <- paste0(sound,if(mode=='timeseries') '_bout_z' else '_phase_z')
  as.formula(gsub(placeholder,replacement,paste(deparse(f),collapse=' '),fixed=TRUE),env=.GlobalEnv)
}

h4s_aggregate_epoch_sec <- function(epoch, eligibility, epoch_sec) {
  stopifnot(epoch_sec >= 10L, epoch_sec %% 10L == 0L)
  if (epoch_sec == 10L) return(epoch)
  step <- as.integer(epoch_sec / 10L)
  epoch$Time_bin <- epoch$Time10 %/% step
  keys <- c('ParticipantID', 'PhaseID', 'Time_bin')
  cols <- c(eligibility, 'Y')
  out <- stats::aggregate(epoch[cols], epoch[keys], mean, na.rm = TRUE)
  out <- out[order(out$ParticipantID, out$PhaseID, out$Time_bin), , drop = FALSE]
  bout <- interaction(out$ParticipantID, out$PhaseID, drop = TRUE)
  out$Time10 <- as.integer(out$Time_bin - ave(out$Time_bin, bout, FUN = min))
  out$Time_bin <- NULL
  out
}

h4s_model_data <- function(d, outcome, sound, mode, transforms, template, epoch_sec = 10L, wind_max_aws = NA_real_) {
  # Preserve phase-average H4 eligibility on the full time-series Eq1 predictor set.
  eligibility <- c('ucm_UTCI',sound,'ucm_SUN_Gh','SVF','atmo_pm2.5_avg','lys_lux_avg','lys_kelvin_avg','gvi_50m')
  y <- paper3_apply_csv_transform(d[[outcome]],outcome,transforms)
  valid <- is.finite(y) & rowSums(!is.finite(as.matrix(d[eligibility])))==0L
  valid <- valid & h4s_wind_keep_mask(d, wind_max_aws)
  if (!any(valid)) stop('No eligible epochs')
  if(mode=='timeseries') {
    epoch_sec <- as.integer(epoch_sec)
    if (epoch_sec < 10L || epoch_sec %% 10L != 0L) stop('epoch_sec must be a positive multiple of 10')
    bout_grp <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
    if (epoch_sec == 10L) {
      all_z <- lapply(d[eligibility], h4s_center, group = bout_grp)
      names(all_z) <- paste0(eligibility, '_bout_z')
      a <- cbind(d[c('ParticipantID', 'PhaseID', 'Time10')], as.data.frame(all_z), Y = y)[valid, ]
      epochs <- table(interaction(a$ParticipantID, a$PhaseID, drop = TRUE))
    } else {
      epoch <- cbind(
        d[valid, c('ParticipantID', 'PhaseID', 'Time10'), drop = FALSE],
        d[valid, eligibility, drop = FALSE],
        Y = y[valid]
      )
      epoch <- h4s_aggregate_epoch_sec(epoch, eligibility, epoch_sec)
      grp <- interaction(epoch$ParticipantID, epoch$PhaseID, drop = TRUE)
      all_z <- lapply(eligibility, function(v) h4s_center(epoch[[v]], grp))
      names(all_z) <- paste0(eligibility, '_bout_z')
      a <- cbind(epoch[c('ParticipantID', 'PhaseID', 'Time10')], as.data.frame(all_z), Y = epoch$Y)
      epochs <- table(grp)
    }
  } else {
    epoch <- cbind(d[valid,c('ParticipantID','PhaseID',eligibility)],Y=y[valid])
    a <- aggregate(epoch[c(eligibility,'Y')],epoch[c('ParticipantID','PhaseID')],mean)
    counts <- aggregate(epoch$Y,epoch[c('ParticipantID','PhaseID')],length)
    names(counts)[3] <- 'epochs'
    a <- merge(a,counts,by=c('ParticipantID','PhaseID'))
    for(v in eligibility) a[[paste0(v,'_phase_z')]] <- h4s_center(a[[v]],a$ParticipantID)
    epochs <- a$epochs
  }
  a$ParticipantID <- factor(a$ParticipantID)
  a$PhaseID <- factor(a$PhaseID,levels=c('WalkG','WalkU','BikeG','BikeU'))
  a[,c('PhaseSumWalkG','PhaseSumWalkU','PhaseSumBikeG')] <- h4_phase_design(a$PhaseID)
  a <- a[order(a$ParticipantID,a$PhaseID,if(mode=='timeseries')a$Time10 else seq_len(nrow(a))),]
  list(data=a,formula=h4s_formula(sound,mode,template),epochs=epochs,n_epochs=sum(valid))
}

h4s_fit_time <- function(fml, data) {
  notes <- character()
  attempt <- function(correlation, label, opts=c('nlminb','optim')) {
    for(opt in opts) {
      fit <- tryCatch(withCallingHandlers(nlme::lme(fixed=fml,data=data,
        random=~1|ParticipantID/PhaseID,correlation=correlation,method='REML',na.action=na.fail,
        control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE,opt=opt)),
        warning=function(w){notes<<-c(notes,paste(label,opt,conditionMessage(w)));invokeRestart('muffleWarning')}),
        error=function(e){notes<<-c(notes,paste(label,opt,conditionMessage(e)));NULL})
      if(!is.null(fit))return(fit)
    }
    NULL
  }
  fit <- attempt(nlme::corAR1(.2,form=~Time10|ParticipantID/PhaseID),'AR1')
  list(fit=fit,structure=if(is.null(fit))'not_fitted' else 'AR1',notes=notes)
}

h4s_one <- function(job,d,mode,transforms,template,epoch_sec=10L,wind_max_aws=NA_real_) {
  started <- proc.time()[3]; note <- character(); outcome<-job$outcome; sound<-job$sound_variable
  status <- data.frame(job_id=job$job_id,equation_id=1L,sound_variable=sound,outcome=outcome,
    epoch_sec=as.integer(epoch_sec),wind_max_aws_m_s=wind_max_aws,
    success=FALSE,converged=FALSE,inference_eligible=FALSE,n=0L,n_epochs=0L,n_participants=0L,
    full_rank=FALSE,max_vif=NA_real_,vif_flag=NA,residual_structure='not_fitted',
    boundary_variance=NA,ar1_rho=NA_real_,lag1_normalized=NA_real_,min_cr2_df=NA_real_,seconds=NA_real_,note='')
  suffix<-if(mode=='timeseries')'_bout_z' else '_phase_z'
  formula<-h4s_formula(sound,mode,template)
  term_names<-c('(Intercept)',attr(terms(formula),'term.labels'))
  co<-data.frame(equation_id=1L,sound_variable=sound,outcome=outcome,term=term_names,
    Beta=NA_real_,SE=NA_real_,df=NA_real_,ci_low=NA_real_,ci_high=NA_real_,p=NA_real_,
    inference_eligible=FALSE,low_df_flag=FALSE)
  co$term_type<-ifelse(co$term=='(Intercept)','intercept',ifelse(grepl(':',co$term,fixed=TRUE),'thermal_x_sound',
    ifelse(co$term==paste0(sound,suffix),'sound',ifelse(co$term==paste0('ucm_UTCI',suffix),'thermal','adjustment'))))
  tryCatch(withCallingHandlers({
    prep<-h4s_model_data(d,outcome,sound,mode,transforms,template,epoch_sec,wind_max_aws);a<-prep$data;fml<-prep$formula
    status$n<-nrow(a);status$n_epochs<-prep$n_epochs;status$n_participants<-nlevels(a$ParticipantID)
    design<-model.matrix(fml,a);status$full_rank<-qr(design)$rank==ncol(design)
    if(!status$full_rank || nrow(a)<=ncol(design))stop('Rank deficient or no residual degrees of freedom; no predictors dropped')
    vv<-h4_vif_per_term(design[,colnames(design)!='(Intercept)',drop=FALSE])
    status$max_vif<-max(vv);status$vif_flag<-status$max_vif>=if(mode=='timeseries')5 else 10
    if(mode=='timeseries') fitres<-h4s_fit_time(fml,a) else {
      fit<-withCallingHandlers(nlme::lme(fixed=fml,data=a,random=~1|ParticipantID,
        method='REML',na.action=na.fail,control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE)),
        warning=function(w){note<<-c(note,conditionMessage(w));invokeRestart('muffleWarning')})
      fitres<-list(fit=fit,structure='phase_random_intercept',notes=character())
    }
    note<-c(note,fitres$notes);fit<-fitres$fit;status$residual_structure<-fitres$structure
    if(is.null(fit))stop('All permitted fitting attempts failed')
    status$converged<-TRUE
    robust<-clubSandwich::coef_test(fit,vcov='CR2',cluster=a$ParticipantID,test='Satterthwaite')
    ix<-match(co$term,rownames(robust));stopifnot(!anyNA(ix))
    co$Beta<-robust$beta[ix];co$SE<-robust$SE[ix];co$df<-robust$df_Satt[ix]
    eligible<-is.finite(co$Beta)&is.finite(co$SE)&co$SE>0&is.finite(co$df)&co$df>0
    co$inference_eligible<-eligible;co$low_df_flag<-is.finite(co$df)&co$df<4
    co$p[eligible]<-2*pt(-abs(co$Beta[eligible]/co$SE[eligible]),co$df[eligible])
    co$ci_low[eligible]<-co$Beta[eligible]-qt(.975,co$df[eligible])*co$SE[eligible]
    co$ci_high[eligible]<-co$Beta[eligible]+qt(.975,co$df[eligible])*co$SE[eligible]
    status$success<-all(is.finite(co$Beta));status$inference_eligible<-all(eligible)
    status$min_cr2_df<-min(co$df[co$term!='(Intercept)'],na.rm=TRUE)
    variances<-nlme::VarCorr(fit)[,'Variance'];rv<-suppressWarnings(as.numeric(variances))
    status$boundary_variance<-any(rv[is.finite(rv)]<1e-6*sigma(fit)^2)
    if(mode=='timeseries') {
      rho<-unname(coef(fit$modelStruct$corStruct,unconstrained=FALSE))
      if(length(rho)==1)status$ar1_rho<-rho
      rr<-residuals(fit,level=2,type='normalized');gg<-interaction(a$ParticipantID,a$PhaseID,drop=TRUE)
      adj<-which(gg[-length(gg)]==gg[-1] & diff(a$Time10)==1)
      if(length(adj)>2)status$lag1_normalized<-cor(rr[adj],rr[adj+1])
    }
  },warning=function(w){note<<-c(note,conditionMessage(w));invokeRestart('muffleWarning')}),
    error=function(e){note<<-c(note,conditionMessage(e))})
  status$seconds<-unname(proc.time()[3]-started);status$note<-paste(unique(note),collapse='; ')
  list(status=status,coefficients=co)
}

h4s_fdr <- function(co,n_outcomes,n_sounds) {
  co$q_FDR <- NA_real_
  tested<-co$term!='(Intercept)';valid<-tested&co$inference_eligible&is.finite(co$p)
  # One consistent rule: BH across 30 sounds x 26 outcomes per coefficient type.
  # Sound-column names differ between fits, so group their roles explicitly.
  family <- ifelse(co$term_type %in% c('sound','thermal_x_sound'),co$term_type,co$term)
  for(key in unique(family)) {
    ix <- which(family==key & valid)
    if(length(ix))co$q_FDR[ix] <- p.adjust(co$p[ix],'BH',n=n_outcomes*n_sounds)
  }
  co$FDR_significant <- !is.na(co$q_FDR) & co$q_FDR < .05
  co
}

h4s_wind_keep_mask <- function(d, wind_max_aws) {
  if (is.na(wind_max_aws)) return(rep(TRUE, nrow(d)))
  if (!'ucm_WIND_AWS' %in% names(d)) stop('ucm_WIND_AWS missing; cannot apply wind screening')
  is.finite(d$ucm_WIND_AWS) & d$ucm_WIND_AWS <= wind_max_aws
}

h4s_write_wind_screening_report <- function(d, outdir, wind_max_aws, epoch_sec) {
  if (is.na(wind_max_aws)) return(invisible(NULL))
  keep <- h4s_wind_keep_mask(d, wind_max_aws)
  bout <- interaction(d$ParticipantID, d$PhaseID, drop = TRUE)
  rows <- data.frame(
    ParticipantID = d$ParticipantID,
    PhaseID = d$PhaseID,
    bout = bout,
    ucm_WIND_AWS = d$ucm_WIND_AWS,
    wind_proportion = if ('wind_proportion' %in% names(d)) d$wind_proportion else NA_real_,
    freq_proportion_20_to_200Hz = if ('freq_proportion_20_to_200Hz' %in% names(d)) d$freq_proportion_20_to_200Hz else NA_real_,
    kept = keep,
    stringsAsFactors = FALSE
  )
  by_phase <- do.call(rbind, lapply(split(seq_len(nrow(d)), d$PhaseID), function(ix) {
    data.frame(
      PhaseID = d$PhaseID[ix[1L]],
      n_10s = length(ix),
      n_kept = sum(keep[ix]),
      pct_kept = 100 * mean(keep[ix]),
      stringsAsFactors = FALSE
    )
  }))
  by_bout <- do.call(rbind, lapply(split(seq_len(nrow(d)), bout), function(ix) {
    data.frame(
      ParticipantID = d$ParticipantID[ix[1L]],
      PhaseID = d$PhaseID[ix[1L]],
      n_10s = length(ix),
      n_kept = sum(keep[ix]),
      stringsAsFactors = FALSE
    )
  }))
  summary <- data.frame(
    wind_max_aws_m_s = wind_max_aws,
    epoch_sec = epoch_sec,
    n_10s_windows = nrow(rows),
    n_10s_kept = sum(keep),
    pct_10s_kept = 100 * mean(keep),
    n_participants = length(unique(d$ParticipantID[keep])),
    n_bouts_any_kept = sum(by_bout$n_kept > 0L),
    n_bouts_total = nrow(by_bout),
    note = paste(
      'Screening only: exclude 10 s windows with ucm_WIND_AWS above threshold.',
      'Not a microphone dBA correction; compare coefficients to unscreened sound runs.',
      'Screening only (not dBA correction). Method notes: Paper3_Github/Experiment papers/Wind Correction for sound - *.md'
    ),
    stringsAsFactors = FALSE
  )
  utils::write.csv(summary, file.path(outdir, 'H4_sound_wind_screening_summary.csv'), row.names = FALSE)
  utils::write.csv(by_phase, file.path(outdir, 'H4_sound_wind_screening_by_phase.csv'), row.names = FALSE)
  invisible(summary)
}

h4s_outdir <- function(root, mode, epoch_sec = 10L, wind_max_aws = NA_real_) {
  stopifnot(mode %in% c('timeseries', 'phaseavg'))
  epoch_sec <- as.integer(epoch_sec)
  results_root <- file.path(root, 'output', 'statistical_analysis', 'results')
  if (mode == 'phaseavg') {
    base <- file.path(results_root, 'H4_phaseavg_sound')
  } else {
    base <- file.path(results_root, 'H4_timeseries_sound')
    if (epoch_sec != 10L) base <- file.path(base, paste0('epoch_', epoch_sec, 's'))
  }
  if (!is.na(wind_max_aws)) {
    base <- file.path(base, sprintf('wind_aws_le_%gms', wind_max_aws))
  }
  base
}

h4s_run <- function(mode, template, script_path, sound_substitutes, epoch_sec = 10L, wind_max_aws = NA_real_) {
  args<-commandArgs(trailingOnly=TRUE)
  arg_epoch <- grep('^--epoch-sec=', args, value = TRUE)
  if (length(arg_epoch)) epoch_sec <- as.integer(sub('^--epoch-sec=', '', arg_epoch[1L]))
  arg_wind <- grep('^--wind-max-aws=', args, value = TRUE)
  if (length(arg_wind)) wind_max_aws <- as.numeric(sub('^--wind-max-aws=', '', arg_wind[1L]))
  if ('--wind-sensitivity' %in% args && is.na(wind_max_aws)) wind_max_aws <- 5
  epoch_sec <- as.integer(epoch_sec)
  root<-resolve_project_root();outcomes<-paper3_physiological_outcomes()
  transforms<-paper3_read_outcome_transforms_csv(outcomes,root)
  loaded<-h4s_load(root,outcomes);d<-loaded$data
  exp_stratum <- h4s_parse_exposure_stratum(args)
  if (exp_stratum != 'none') {
    n_before <- nrow(d)
    d <- h4s_filter_epochs_utci_stratum(d, exp_stratum)
    cat('Eq1 exposure stratum=', exp_stratum, '| rows ', n_before, '->', nrow(d), '\n')
    flush.console()
  }
  stopifnot(is.list(sound_substitutes), length(sound_substitutes) >= 1L)
  sounds <- character(length(sound_substitutes))
  for (i in seq_along(sound_substitutes)) {
    sounds[i] <- sound_substitutes[[i]]
  }
  stopifnot(all(sounds %in% names(d)), all(vapply(d[sounds], is.numeric, logical(1))))
  core<-file.path(dirname(script_path),'library','H4_core.R')
  h4_phase_design<<-h4s_helper('h4_phase_design',core)
  h4_vif_per_term<<-h4s_helper('h4_vif_per_term',core)
  outdir <- h4s_outdir(root, mode, epoch_sec, wind_max_aws)
  forbidden <- c('H4_timeseries', 'H4_phaseavg')
  if (basename(outdir) %in% forbidden) stop('Refusing to write primary H4 results folder: ', outdir)
  dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
  h4s_write_wind_screening_report(d, outdir, wind_max_aws, epoch_sec)
  jobs<-expand.grid(outcome=as.character(outcomes),sound_variable=sounds,stringsAsFactors=FALSE);jobs$job_id<-seq_len(nrow(jobs))
  epoch_meta <- tempfile(fileext = '.txt')
  writeLines(c(paste('epoch_sec=', epoch_sec, sep = ''), paste('wind_max_aws=', wind_max_aws, sep = '')), epoch_meta)
  on.exit(unlink(epoch_meta), add = TRUE)
  hashes<-tools::md5sum(c(script_path,file.path(dirname(script_path),'library','H4_sound_core.R'),
    file.path(dirname(script_path),'library','Paper3_common.R'),core,loaded$path,paper3_normalization_csv_path(root),epoch_meta))
  report_only <- '--report-only' %in% args
  checkpoint<-file.path(outdir,'checkpoint.rds');results<-list();fitting_archive<-NULL
  if(file.exists(checkpoint)) {
    previous<-readRDS(checkpoint)
    fitting_archive <- previous$fitting_core_archive
    if(!identical(previous$hashes,hashes)) {
      old_arg <- grep('^--previous-core=',args,value=TRUE)
      if(!report_only || length(old_arg)!=1L)stop('Checkpoint changed; use a verified reporting-only migration or preserve/review before refitting')
      old_path <- sub('^--previous-core=','',old_arg[1])
      core_path <- file.path(dirname(script_path),'library','H4_sound_core.R')
      different <- which(unname(previous$hashes)!=unname(hashes))
      stopifnot(length(different)==1L,names(hashes)[different]==core_path,
        unname(tools::md5sum(old_path))==unname(previous$hashes[different]))
      fitting_names <- c('h4s_helper','h4s_load','h4s_center','h4s_formula','h4s_model_data','h4s_fit_time','h4s_one')
      definitions <- function(path) {
        z<-parse(path)
        z<-Filter(function(e)is.call(e)&&identical(e[[1]],as.name('<-'))&&is.symbol(e[[2]])&&as.character(e[[2]])%in%fitting_names,z)
        stopifnot(length(z)==length(fitting_names))
        vapply(z,function(e)paste(deparse(e),collapse='\n'),character(1))
      }
      stopifnot(identical(definitions(old_path),definitions(core_path)))
      fitting_archive<-old_path
      previous$hashes<-hashes;previous$fitting_core_archive<-fitting_archive
      saveRDS(previous,checkpoint)
      cat('Verified reporting-only migration: every fitting/preparation function and all other input/dependency hashes unchanged.\n')
    }
    results<-previous$results
  }
  done<-if(length(results))vapply(results,function(x)x$status$job_id,integer(1))else integer()
  pending<-setdiff(jobs$job_id,done)
  w<-grep('^--workers=',args,value=TRUE);workers<-if(length(w))as.integer(sub('^--workers=','',w[1]))else 4L
  maxjobs<-grep('^--max-jobs=',args,value=TRUE);if(length(maxjobs))pending<-head(pending,as.integer(sub('^--max-jobs=','',maxjobs[1])))
  cat('Eq1 only:',mode,if(mode=='timeseries')paste0(' epoch=',epoch_sec,'s') else '',
      if(!is.na(wind_max_aws))paste0(' wind<=',wind_max_aws,'m/s') else '','|',length(sounds),
      'sound variables x',length(outcomes),'outcomes | pending',length(pending),'| out:',outdir,'\n');flush.console()
  if(report_only && length(pending))stop('Reporting-only run requires a complete checkpoint')
  if(length(pending)) {
  cl<-parallel::makePSOCKcluster(workers,outfile=file.path(outdir,'workers.log'));on.exit(parallel::stopCluster(cl),add=TRUE)
  libs<-.libPaths();parallel::clusterCall(cl,function(paths).libPaths(paths),libs)
  exports<-c('h4s_one','h4s_model_data','h4s_formula','h4s_center','h4s_fit_time','h4s_aggregate_epoch_sec','h4s_wind_keep_mask','h4_phase_design','h4_vif_per_term','paper3_apply_csv_transform','paper3_outcome_natural_log')
  parallel::clusterExport(cl,exports,envir=.GlobalEnv)
  parallel::clusterExport(cl,c('d','mode','transforms','template','epoch_sec','wind_max_aws'),envir=environment())
  for(batch in split(pending,ceiling(seq_along(pending)/24))) {
    batch_jobs<-lapply(batch,function(i)jobs[i,,drop=FALSE])
    fitted<-parallel::parLapplyLB(cl,batch_jobs,function(job)h4s_one(job,d,mode,transforms,template,epoch_sec,wind_max_aws))
    results<-c(results,fitted);saveRDS(list(hashes=hashes,results=results,fitting_core_archive=fitting_archive),checkpoint)
    status<-do.call(rbind,lapply(results,'[[','status'))
    cat(format(Sys.time(),'%H:%M:%S'),mode,nrow(status),'/',nrow(jobs),'finished;',sum(status$success),'fits with CR2; last batch',round(sum(vapply(fitted,function(x)x$status$seconds,numeric(1))),1),'CPU seconds\n');flush.console()
    write.csv(status,file.path(outdir,'H4_sound_model_status.csv'),row.names=FALSE)
  }
  }
  status<-do.call(rbind,lapply(results,'[[','status'));co<-do.call(rbind,lapply(results,'[[','coefficients'))
  co<-h4s_fdr(co,length(outcomes),length(sounds))
  write.csv(co,file.path(outdir,'H4_sound_coefficients.csv'),row.names=FALSE,na='')
  write.csv(status,file.path(outdir,'H4_sound_model_status.csv'),row.names=FALSE,na='')
  targets<-co[co$term_type%in%c('sound','thermal_x_sound'),]
  write.csv(targets,file.path(outdir,'H4_sound_exposure_tests.csv'),row.names=FALSE,na='')
  formulas<-data.frame(equation_id=1L,sound_variable=sounds,formula=vapply(sounds,function(s)paste(deparse(h4s_formula(s,mode,template)),collapse=' '),character(1)))
  write.csv(formulas,file.path(outdir,'H4_sound_Eq1_formulas.csv'),row.names=FALSE)
  manifest<-data.frame(path=names(hashes),md5=unname(hashes))
  if(!is.null(fitting_archive))manifest<-rbind(manifest,data.frame(path=fitting_archive,md5=unname(tools::md5sum(fitting_archive))))
  manifest$mode<-mode;manifest$epoch_sec<-epoch_sec;manifest$wind_max_aws_m_s<-wind_max_aws
  manifest$planned_models<-nrow(jobs);manifest$completed_models<-nrow(status)
  manifest$run_complete<-nrow(status)==nrow(jobs);write.csv(manifest,file.path(outdir,'H4_sound_manifest.csv'),row.names=FALSE)
  writeLines(c(paste('Eq1-only exploratory sound substitutions:',mode),paste('Input:',loaded$path),
    paste('Each of', length(sounds), 'numeric acoustic measures separately replaces dBA in BOTH the main effect and UTCI interaction; dBA is absent from every fitted fixed-effect equation.'),
    'No sound variables enter together. No other heat/PM equations or lag models are run.',
    'Original H4 outcome transformations, HRV-window mask, bilateral means, one-step SVF endpoint carry and sum-to-zero phase contrasts retained.',
    paste('Timeseries epoch width (seconds):', epoch_sec, '(10 s uses original bout centering; wider bins mean-aggregate 10 s rows then center). Nested participant/phase intercepts; AR1 on the time-bin index within each bout; no fallback, fits where AR1 fails are reported as not fitted.'),
    'Does not write to H4_timeseries/ or H4_phaseavg/ (primary seven-equation H4 only).',
    if (is.na(wind_max_aws)) 'Wind screening: none (all eligible 10 s windows by ucm_WIND_AWS).' else paste(
      'Wind screening: keep 10 s windows with ucm_WIND_AWS <=', wind_max_aws,
      'm/s only; see H4_sound_wind_screening_summary.csv. Not a dBA correction.'
    ),
    'Phaseavg: matched-epoch eligibility on the complete time-series predictor set, transform Y before means, participant-centered phase means/shared sample SD; participant intercept.',
    'Participant CR2/Satterthwaite inference. Low df<4, boundary variance, residual correlation and VIF flags retained, never used for automatic variable removal.',
    paste('q_FDR: the only adjusted-p column. BH across all', nrow(jobs), 'planned tests (', length(sounds), 'sounds x', length(outcomes), 'outcomes) separately for each coefficient type: sound main, UTCI x sound, UTCI main, and each named adjustment coefficient. Not pooled with original H4 or the other analysis mode.', sep = ''),
    'FDR_significant: TRUE exactly when q_FDR < 0.05; FALSE otherwise. A blank q_FDR means untested/unavailable, not evidence of no association; inspect inference_eligible.',
    'Column guide: outcome = physiological dependent measure; term = individual coefficient tested; sound_variable = the acoustic replacement used in that fitted model. Beta = adjusted coefficient in transformed outcome units per scaled predictor unit; SE = robust standard error; df = Satterthwaite degrees of freedom; p = unadjusted p-value; ci_low/ci_high = unadjusted 95% limits. *_phase_z means participant-centered phase means divided by a shared SD; *_bout_z means whole-bout-centered epochs divided by a shared SD. PhaseSum terms adjust for experimental phase; Intercept is the reference predicted outcome.',
    'H4 amplification is tested by term_type=thermal_x_sound (a colon in term). A significant UTCI main effect describes the thermal slope at centered sound=0; it does not establish a sound effect or sound amplification.',
    'All planned failures remain explicit; missing tests count in multiplicity denominators. CIs are unadjusted 95% intervals.',
    'YAMNet mapping limitations and positive/negative labels remain as audited; these are source classification/spectral descriptors, not calibrated dBA replacements.',
    paste('Completed models:',nrow(status),'of',nrow(jobs)),paste('Fits with CR2:',sum(status$success)),paste('Output:',outdir)),file.path(outdir,'README.txt'))
  stopifnot(identical(unname(tools::md5sum(names(hashes))),unname(hashes)),all(status$equation_id==1L))
  cat('FINISHED:',outdir,'\n')
  invisible(list(status=status,coefficients=co))
}

# Supplementary categorical bands. Does not replace Eq1 (continuous z-scored dBA x UTCI).
# --band-contrasts: UTCI-stratum-restricted only (b26_32, gt32); no whole-route pooling.
h4s_band_cutpoints <- function() {
  list(utci = c(26, 32), sound_dba = c(55, 65, 75))
}

h4s_cut_sound_band <- function(x) {
  cp <- h4s_band_cutpoints()$sound_dba
  cut(x, breaks = c(-Inf, cp, Inf), right = FALSE,
      labels = c('lt55', 'b55_65', 'b65_75', 'gt75'))
}

h4s_cut_utci_band <- function(x) {
  cp <- h4s_band_cutpoints()$utci
  cut(x, breaks = c(-Inf, cp, Inf), right = FALSE,
      labels = c('lt26', 'b26_32', 'gt32'))
}

h4s_attach_band_columns <- function(d) {
  d$sound_band <- h4s_cut_sound_band(d$ucm_SND_dBA)
  d$utci_band <- h4s_cut_utci_band(d$ucm_UTCI)
  d
}

h4s_filter_epochs_utci_stratum <- function(d, utci_stratum) {
  utci_stratum <- match.arg(utci_stratum, c('b26_32', 'gt32'))
  d <- h4s_attach_band_columns(d)
  d[d$utci_band == utci_stratum, , drop = FALSE]
}

h4s_parse_exposure_stratum <- function(args) {
  one <- grep('^--exposure-stratum=', args, value = TRUE)
  if (!length(one)) return('none')
  val <- sub('^--exposure-stratum=', '', one[1L])
  if (!val %in% c('none', 'b26_32', 'gt32')) {
    stop('--exposure-stratum must be none, b26_32, or gt32', call. = FALSE)
  }
  val
}

h4s_band_contrast_ids <- function() {
  c('sound_65_75_minus_55_65', 'sound_gt75_minus_55_65')
}

h4s_band_model_data <- function(d, outcome, mode, transforms, epoch_sec, utci_stratum) {
  stopifnot(!missing(utci_stratum), utci_stratum %in% c('b26_32', 'gt32'))
  d <- h4s_filter_epochs_utci_stratum(d, utci_stratum)
  if (!nrow(d)) stop('No rows in UTCI stratum ', utci_stratum)
  covars <- if (mode == 'timeseries') {
    c('ucm_SUN_Gh', 'SVF', 'atmo_pm2.5_avg', 'lys_lux_avg', 'lys_kelvin_avg', 'gvi_50m')
  } else {
    c('SVF', 'atmo_pm2.5_avg', 'lys_lux_avg', 'lys_kelvin_avg')
  }
  eligibility <- c('ucm_UTCI', 'ucm_SND_dBA', covars)
  y <- paper3_apply_csv_transform(d[[outcome]], outcome, transforms)
  valid <- is.finite(y) & rowSums(!is.finite(as.matrix(d[eligibility]))) == 0L
  if (!any(valid)) stop('No eligible epochs')
  if (mode == 'timeseries') {
    epoch_sec <- as.integer(epoch_sec)
    if (epoch_sec == 10L) {
      epoch <- cbind(d[valid, c('ParticipantID', 'PhaseID', 'Time10'), drop = FALSE],
                     d[valid, eligibility, drop = FALSE], Y = y[valid])
    } else {
      epoch <- cbind(d[valid, c('ParticipantID', 'PhaseID', 'Time10'), drop = FALSE],
                     d[valid, eligibility, drop = FALSE], Y = y[valid])
      epoch <- h4s_aggregate_epoch_sec(epoch, eligibility, epoch_sec)
    }
    grp <- interaction(epoch$ParticipantID, epoch$PhaseID, drop = TRUE)
    a <- epoch
    for (v in covars) a[[paste0(v, '_bout_z')]] <- h4s_center(epoch[[v]], grp)
    z_suffix <- '_bout_z'
  } else {
    epoch <- cbind(d[valid, c('ParticipantID', 'PhaseID', eligibility), drop = FALSE], Y = y[valid])
    n_epochs_eligible <- nrow(epoch)
    a <- aggregate(epoch[c(eligibility, 'Y')], epoch[c('ParticipantID', 'PhaseID')], mean)
    grp <- a$ParticipantID
    for (v in covars) a[[paste0(v, '_phase_z')]] <- h4s_center(a[[v]], grp)
    z_suffix <- '_phase_z'
  }
  if (mode == 'timeseries') n_epochs_eligible <- sum(valid)
  a$sound_band <- h4s_cut_sound_band(a$ucm_SND_dBA)
  a$ParticipantID <- factor(a$ParticipantID)
  a$PhaseID <- factor(a$PhaseID, levels = c('WalkG', 'WalkU', 'BikeG', 'BikeU'))
  a[, c('PhaseSumWalkG', 'PhaseSumWalkU', 'PhaseSumBikeG')] <- h4_phase_design(a$PhaseID)
  covar_z <- paste0(covars, z_suffix)
  rhs <- paste(c('sound_band', covar_z, 'PhaseSumWalkG', 'PhaseSumWalkU', 'PhaseSumBikeG'), collapse = ' + ')
  fml <- as.formula(paste('Y ~', rhs), env = .GlobalEnv)
  a <- a[order(a$ParticipantID, a$PhaseID, if (mode == 'timeseries') a$Time10 else seq_len(nrow(a))), ]
  if (mode == 'timeseries') {
    a$Time10 <- ave(a$Time10, a$ParticipantID, a$PhaseID, FUN = function(x) seq_along(x) - 1L)
  }
  list(data = a, formula = fml, n_epochs = n_epochs_eligible)
}

h4s_band_sound_L <- function(beta_names) {
  z <- setNames(numeric(length(beta_names)), beta_names)
  pick <- function(level) {
    nm <- paste0('sound_band', level)
    if (!nm %in% names(z)) stop('Coefficient absent: ', nm)
    v <- z
    v[nm] <- 1
    v
  }
  list(
    sound_65_75_minus_55_65 = pick('b65_75'),
    sound_gt75_minus_55_65 = pick('gt75')
  )
}

h4s_band_one <- function(d, outcome, mode, transforms, epoch_sec, utci_stratum) {
  utci_stratum <- match.arg(utci_stratum, c('b26_32', 'gt32'))
  prep <- tryCatch(h4s_band_model_data(d, outcome, mode, transforms, epoch_sec, utci_stratum = utci_stratum),
                   error = function(e) NULL)
  contrast_ids <- c('sound_65_75_minus_55_65', 'sound_gt75_minus_55_65')
  empty_row <- function(note, n_ep = NA_integer_, n_pp = NA_integer_, n_p = NA_integer_) {
    data.frame(utci_stratum = utci_stratum, outcome = outcome, epoch_sec = as.integer(epoch_sec),
               contrast_id = contrast_ids,
               comparison = c('65-75 dBA', '>75 dBA'), reference = c('55-65 dBA', '55-65 dBA'),
               Beta = NA_real_, SE = NA_real_, df = NA_real_, p = NA_real_, p_value = NA_real_,
               ci_low = NA_real_, ci_high = NA_real_,
               n_epochs = n_ep, n_participant_phases = n_pp, n_participants = n_p,
               interaction_in_model = FALSE, residual_structure = 'not_fitted', inference_eligible = FALSE,
               note = note, stringsAsFactors = FALSE)
  }
  if (is.null(prep)) return(empty_row('No eligible rows in UTCI stratum after outcome/covariate filter'))
  a <- prep$data
  n_participants <- length(unique(as.character(a$ParticipantID)))
  n_participant_phases <- length(unique(paste(a$ParticipantID, a$PhaseID, sep = '::')))
  n_epochs <- prep$n_epochs
  cat(sprintf('[band-contrast] stratum=%s outcome=%s n_participants=%d n_participant_phases=%d n_epochs=%d\n',
              utci_stratum, outcome, n_participants, n_participant_phases, n_epochs))
  flush.console()
  if (n_participants < 3L) return(empty_row('Skipped: n_participants < 3 in UTCI stratum', n_epochs, n_participant_phases, n_participants))
  n_sound <- table(a$sound_band)
  base_note <- paste0('utci_stratum=', utci_stratum, '; n_sound ',
                      paste(names(n_sound), as.integer(n_sound), sep = '=', collapse = ','))
  need_s <- c('b55_65', 'b65_75', 'gt75')
  if (any(!need_s %in% names(n_sound)) || any(n_sound[need_s] == 0L)) {
    return(empty_row(paste(base_note, 'A sound band has zero rows in this UTCI stratum'), n_epochs, n_participant_phases, n_participants))
  }
  a$sound_band <- droplevels(a$sound_band)
  if (!('b55_65' %in% levels(a$sound_band))) {
    return(empty_row(paste(base_note, 'Reference band 55-65 dBA absent in stratum'), n_epochs, n_participant_phases, n_participants))
  }
  a$sound_band <- relevel(a$sound_band, ref = 'b55_65')
  fitres <- tryCatch({
    if (mode == 'timeseries') h4s_fit_time(prep$formula, a) else {
      notes <- character()
      fit <- tryCatch(withCallingHandlers(nlme::lme(fixed = prep$formula, data = a, random = ~1 | ParticipantID,
        method = 'REML', na.action = na.fail, control = nlme::lmeControl(maxIter = 100, msMaxIter = 150, returnObject = FALSE)),
        warning = function(w) { notes <<- c(notes, conditionMessage(w)); invokeRestart('muffleWarning') }),
        error = function(e) { notes <<- c(notes, conditionMessage(e)); NULL })
      list(fit = fit, structure = if (is.null(fit)) 'not_fitted' else 'phase_random_intercept', notes = notes)
    }
  }, error = function(e) list(fit = NULL, structure = 'not_fitted', notes = conditionMessage(e)))
  if (is.null(fitres$fit)) return(empty_row(paste(base_note, paste(fitres$notes, collapse = '; ')), n_epochs, n_participant_phases, n_participants))
  fit <- fitres$fit
  beta <- nlme::fixef(fit)
  Lset <- tryCatch(h4s_band_sound_L(names(beta)), error = function(e) e)
  if (inherits(Lset, 'error')) return(empty_row(conditionMessage(Lset), n_epochs, n_participant_phases, n_participants))
  V <- tryCatch(clubSandwich::vcovCR(fit, cluster = a$ParticipantID, type = 'CR2'), error = function(e) e)
  if (inherits(V, 'error')) return(empty_row(conditionMessage(V), n_epochs, n_participant_phases, n_participants))
  ct <- tryCatch(clubSandwich::coef_test(fit, vcov = V, cluster = a$ParticipantID, test = 'Satterthwaite'), error = function(e) NULL)
  rows <- lapply(names(Lset), function(id) {
    L <- matrix(Lset[[id]], nrow = 1, dimnames = list(id, names(beta)))
    est <- as.numeric(L %*% beta)
    se <- sqrt(as.numeric(L %*% V %*% t(L)))
    use <- names(beta)[abs(Lset[[id]]) > 1e-12]
    df <- if (is.null(ct)) NA_real_ else suppressWarnings(min(ct$df_Satt[match(use, rownames(ct))], na.rm = TRUE))
    if (!is.finite(df)) df <- NA_real_
    numbers_ok <- is.finite(est) && is.finite(se) && se > 0 && is.finite(df) && df > 0
    eligible <- numbers_ok
    p <- if (numbers_ok) 2 * pt(-abs(est / se), df) else NA_real_
    data.frame(utci_stratum = utci_stratum, outcome = outcome, epoch_sec = as.integer(epoch_sec), contrast_id = id,
               comparison = c(sound_65_75_minus_55_65 = '65-75 dBA', sound_gt75_minus_55_65 = '>75 dBA')[id],
               reference = '55-65 dBA', Beta = est, SE = se, df = df, p = p, p_value = p,
               ci_low = if (numbers_ok) est - qt(.975, df) * se else NA_real_,
               ci_high = if (numbers_ok) est + qt(.975, df) * se else NA_real_,
               n_epochs = n_epochs, n_participant_phases = n_participant_phases, n_participants = n_participants,
               interaction_in_model = FALSE, residual_structure = fitres$structure, inference_eligible = eligible,
               note = paste(c(base_note, 'UTCI-stratum-restricted epochs only; sound_band additive model',
                              substr(paste(unique(fitres$notes), collapse = ' | '), 1L, 200L)), collapse = '; '),
               stringsAsFactors = FALSE)
  })
  do.call(rbind, rows)
}

h4s_band_contrasts <- function(mode, script_path) {
  args <- commandArgs(trailingOnly = TRUE)
  root <- resolve_project_root()
  outcomes <- paper3_physiological_outcomes()
  transforms <- paper3_read_outcome_transforms_csv(outcomes, root)
  loaded <- h4s_load(root, outcomes)
  core <- file.path(dirname(script_path), 'library', 'H4_core.R')
  h4_phase_design <<- h4s_helper('h4_phase_design', core)
  epochs <- if (mode == 'timeseries') {
    one <- grep('^--epoch-sec=', args, value = TRUE)
    if (length(one)) as.integer(sub('^--epoch-sec=', '', one[1L])) else c(30L, 60L, 300L)
  } else 10L
  if (mode == 'timeseries' && any(epochs == 10L)) stop('Band-contrast timeseries uses 30/60/300 s, matching the default sound script (10 s root is left unchanged).')
  outdir <- file.path(root, 'output', 'statistical_analysis', 'results', if (mode == 'timeseries') 'H4_timeseries_sound' else 'H4_phaseavg_sound')
  dir.create(outdir, recursive = TRUE, showWarnings = FALSE)
  pieces <- list()
  strata <- c('b26_32', 'gt32')
  for (sec in epochs) {
    cat('Band contrasts', mode, if (mode == 'timeseries') paste0('epoch=', sec, 's') else 'phaseavg',
        '| UTCI strata b26_32 + gt32 only |', length(outcomes), 'outcomes\n')
    flush.console()
    for (utci_stratum in strata) {
      for (outcome in as.character(outcomes)) {
        pieces[[length(pieces) + 1L]] <- tryCatch(
          h4s_band_one(loaded$data, outcome, mode, transforms, sec, utci_stratum),
          error = function(e) data.frame(utci_stratum = utci_stratum, outcome = outcome, epoch_sec = as.integer(sec),
            contrast_id = NA_character_, comparison = NA_character_, reference = NA_character_,
            Beta = NA_real_, SE = NA_real_, df = NA_real_, p = NA_real_, ci_low = NA_real_, ci_high = NA_real_,
            n_epochs = NA_integer_, n_participant_phases = NA_integer_, n_participants = NA_integer_, n = NA_integer_,
            interaction_in_model = FALSE, residual_structure = 'not_fitted', inference_eligible = FALSE,
            note = conditionMessage(e), stringsAsFactors = FALSE))
      }
    }
  }
  co <- do.call(rbind, pieces)
  co$q_FDR <- NA_real_
  co$analysis <- 'supplementary_categorical_bands_utci_stratum_restricted'
  co$primary_model_replaced <- FALSE
  for (key in unique(paste(co$utci_stratum, co$contrast_id, co$epoch_sec, sep = '|'))) {
    ix <- which(paste(co$utci_stratum, co$contrast_id, co$epoch_sec, sep = '|') == key & co$inference_eligible & is.finite(co$p_value))
    n_plan <- sum(paste(co$utci_stratum, co$contrast_id, co$epoch_sec, sep = '|') == key)
    if (length(ix)) co$q_FDR[ix] <- p.adjust(co$p_value[ix], 'BH', n = n_plan)
  }
  path <- file.path(outdir, 'H4_sound_band_contrasts.csv')
  write.csv(co, path, row.names = FALSE, na = '')
  cat('WROTE', path, 'rows', nrow(co), 'eligible', sum(co$inference_eligible, na.rm = TRUE), '\n')
  for (st in strata) {
    sub <- co[co$utci_stratum == st & co$contrast_id == 'sound_gt75_minus_55_65' & !is.na(co$n_participants), ]
    if (nrow(sub)) {
      cat('  stratum', st, 'sound_gt75 n_participants min/median/max:',
          min(sub$n_participants), stats::median(sub$n_participants), max(sub$n_participants), '\n')
    }
  }
  invisible(co)
}
