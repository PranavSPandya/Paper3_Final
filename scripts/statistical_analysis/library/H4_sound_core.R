# Shared execution for the Eq1-only sound substitution entry scripts.
# No original H4 runner is sourced and no other equation is defined or executed.
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

h4s_model_data <- function(d, outcome, sound, mode, transforms, template) {
  # Preserve phase-average H4 eligibility on the full time-series Eq1 predictor set.
  eligibility <- c('ucm_UTCI',sound,'ucm_SUN_Gh','SVF','atmo_pm2.5_avg','lys_lux_avg','lys_kelvin_avg','gvi_50m')
  y <- paper3_apply_csv_transform(d[[outcome]],outcome,transforms)
  valid <- is.finite(y) & rowSums(!is.finite(as.matrix(d[eligibility])))==0L
  if (!any(valid)) stop('No eligible epochs')
  if(mode=='timeseries') {
    all_z <- lapply(d[eligibility],h4s_center,group=interaction(d$ParticipantID,d$PhaseID,drop=TRUE))
    names(all_z) <- paste0(eligibility,'_bout_z')
    a <- cbind(d[c('ParticipantID','PhaseID','Time10')],as.data.frame(all_z),Y=y)[valid,]
    epochs <- table(interaction(a$ParticipantID,a$PhaseID,drop=TRUE))
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
  structure <- 'AR1'
  if(!is.null(fit)) {
    rho <- unname(coef(fit$modelStruct$corStruct,unconstrained=FALSE))
    if(length(rho)==1L && is.finite(rho) && rho>.95) {
      alt <- attempt(nlme::corARMA(c(.5,.2),form=~Time10|ParticipantID/PhaseID,p=2,q=0),'ARMA20')
      if(!is.null(alt)){fit<-alt;structure<-'ARMA20'}
    }
  }
  if(is.null(fit)) {
    fit <- attempt(NULL,'independent_fallback',opts='nlminb')
    structure <- 'independent_fallback'
  }
  list(fit=fit,structure=if(is.null(fit))'not_fitted' else structure,notes=notes)
}

h4s_one <- function(job,d,mode,transforms,template) {
  started <- proc.time()[3]; note <- character(); outcome<-job$outcome; sound<-job$sound_variable
  status <- data.frame(job_id=job$job_id,equation_id=1L,sound_variable=sound,outcome=outcome,
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
    prep<-h4s_model_data(d,outcome,sound,mode,transforms,template);a<-prep$data;fml<-prep$formula
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
    eligible<-fitres$structure!='independent_fallback' & is.finite(co$Beta)&is.finite(co$SE)&co$SE>0&is.finite(co$df)&co$df>0
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

h4s_run <- function(mode,template,script_path) {
  root<-resolve_project_root();outcomes<-paper3_physiological_outcomes()
  transforms<-paper3_read_outcome_transforms_csv(outcomes,root)
  loaded<-h4s_load(root,outcomes);d<-loaded$data
  sounds<-c(grep('_score$|_proportion$',names(d),value=TRUE),grep('^freq_proportion_|^octave_proportion_',names(d),value=TRUE),
    'dominant_frequency_Hz','spectral_centroid_Hz','spectral_rolloff85_Hz')
  sounds<-unique(sounds);stopifnot(length(sounds)==30L,all(vapply(d[sounds],is.numeric,logical(1))))
  core<-file.path(dirname(script_path),'library','H4_core.R')
  h4_phase_design<<-h4s_helper('h4_phase_design',core)
  h4_vif_per_term<<-h4s_helper('h4_vif_per_term',core)
  outdir<-file.path(root,'output','statistical_analysis','results',paste0('H4_',mode,'_sound'))
  dir.create(outdir,recursive=TRUE,showWarnings=FALSE)
  jobs<-expand.grid(outcome=as.character(outcomes),sound_variable=sounds,stringsAsFactors=FALSE);jobs$job_id<-seq_len(nrow(jobs))
  hashes<-tools::md5sum(c(script_path,file.path(dirname(script_path),'library','H4_sound_core.R'),
    file.path(dirname(script_path),'library','Paper3_common.R'),core,loaded$path,paper3_normalization_csv_path(root)))
  args<-commandArgs(trailingOnly=TRUE)
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
  cat('Eq1 only:',mode,'|',length(sounds),'sound variables x',length(outcomes),'outcomes | pending',length(pending),'\n');flush.console()
  if(report_only && length(pending))stop('Reporting-only run requires a complete checkpoint')
  if(length(pending)) {
  cl<-parallel::makePSOCKcluster(workers,outfile=file.path(outdir,'workers.log'));on.exit(parallel::stopCluster(cl),add=TRUE)
  libs<-.libPaths();parallel::clusterCall(cl,function(paths).libPaths(paths),libs)
  exports<-c('h4s_one','h4s_model_data','h4s_formula','h4s_center','h4s_fit_time','h4_phase_design','h4_vif_per_term','paper3_apply_csv_transform','paper3_outcome_natural_log')
  parallel::clusterExport(cl,exports,envir=.GlobalEnv)
  parallel::clusterExport(cl,c('d','mode','transforms','template'),envir=environment())
  for(batch in split(pending,ceiling(seq_along(pending)/24))) {
    batch_jobs<-lapply(batch,function(i)jobs[i,,drop=FALSE])
    fitted<-parallel::parLapplyLB(cl,batch_jobs,function(job)h4s_one(job,d,mode,transforms,template))
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
  manifest$mode<-mode;manifest$planned_models<-nrow(jobs);manifest$completed_models<-nrow(status)
  manifest$run_complete<-nrow(status)==nrow(jobs);write.csv(manifest,file.path(outdir,'H4_sound_manifest.csv'),row.names=FALSE)
  writeLines(c(paste('Eq1-only exploratory sound substitutions:',mode),paste('Input:',loaded$path),
    'Each of 30 numeric acoustic measures separately replaces dBA in BOTH the main effect and UTCI interaction; dBA is absent from every fitted fixed-effect equation.',
    'No sound variables enter together. No other heat/PM equations or lag models are run.',
    'Original H4 outcome transformations, HRV-window mask, bilateral means, one-step SVF endpoint carry and sum-to-zero phase contrasts retained.',
    'Timeseries: whole-bout predictor centering/shared sample SD before outcome filtering; nested participant/phase intercepts; AR1 then existing ARMA20 rule at rho>.95; independent fallback p-values withheld.',
    'Phaseavg: matched-epoch eligibility on the complete time-series predictor set, transform Y before means, participant-centered phase means/shared sample SD; participant intercept.',
    'Participant CR2/Satterthwaite inference. Low df<4, boundary variance, residual correlation and VIF flags retained, never used for automatic variable removal.',
    'q_FDR: the only adjusted-p column. BH across all 780 planned tests (30 sounds x 26 outcomes) separately for each coefficient type: sound main, UTCI x sound, UTCI main, and each named adjustment coefficient. Not pooled with original H4 or the other analysis mode.',
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
