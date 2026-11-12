# Model-matched phase-average checks. Called by H1_H5_robustness.R only.
# Resampling units are participants; none of these checks selects a primary result.
robustness_bind <- function(parts) {
  parts <- Filter(function(x) is.data.frame(x) && nrow(x)>0, parts)
  if (!length(parts)) return(data.frame())
  columns <- unique(unlist(lapply(parts,names)))
  do.call(rbind,lapply(parts,function(x){for(name in setdiff(columns,names(x)))x[[name]]<-NA;x[columns]}))
}
robustness_adjust <- function(table, family, size=NULL) {
  table$q_value <- NA_real_
  for(key in unique(family)) {
    rows <- which(family==key)
    table$q_value[rows] <- p.adjust(table$p_value[rows],'BH',n=if(is.null(size))length(rows) else size)
  }
  table$FDR_significant <- ifelse(is.finite(table$q_value),table$q_value<.05,NA)
  table
}
robustness_h2 <- function(phase_data,physiology,questionnaires,cohort,draws=1999L) {
  set.seed(20261107L);all_rows<-list();index<-0L
  for(questionnaire in questionnaires) for(outcome in physiology) {
    data<-phase_data[is.finite(phase_data[[outcome]]) & is.finite(phase_data[[questionnaire]]),c('ParticipantID','PhaseID',outcome,questionnaire)]
    names(data)[3:4]<-c('physiology','rating')
    data<-data[data$ParticipantID %in% names(which(table(data$ParticipantID)>=2L)),]
    ids<-unique(as.character(data$ParticipantID))
    if(nrow(data)<20L || length(ids)<8L)next
    data$ParticipantID<-droplevels(factor(data$ParticipantID))
    data$PhaseID<-droplevels(factor(data$PhaseID))
    fit<-lm(rating~physiology+ParticipantID,data=data)
    coefficient<-summary(fit)$coefficients['physiology',];degrees<-df.residual(fit)
    observed_r<-sign(coefficient[3])*sqrt(coefficient[3]^2/(coefficient[3]^2+degrees))
    groups<-split(seq_len(nrow(data)),data$ParticipantID)
    centered_x<-data$physiology-ave(data$physiology,data$ParticipantID,FUN=mean)
    centered_y<-data$rating-ave(data$rating,data$ParticipantID,FUN=mean)
    moments<-vapply(groups,function(rows)c(xy=sum(centered_x[rows]*centered_y[rows]),xx=sum(centered_x[rows]^2),yy=sum(centered_y[rows]^2)),numeric(3))
    moment_r<-function(value) if(value[2]>0 && value[3]>0)value[1]/sqrt(value[2]*value[3]) else NA_real_
    bootstrap<-replicate(draws,moment_r(rowSums(moments[,sample.int(length(groups),length(groups),replace=TRUE),drop=FALSE])))
    interval<-quantile(bootstrap,c(.025,.975),na.rm=TRUE,names=FALSE)
    permutation<-replicate(draws,{
      shuffled<-centered_y
      for(rows in groups)shuffled[rows]<-sample(centered_y[rows],length(rows),replace=FALSE)
      sum(centered_x*shuffled)/sqrt(sum(centered_x^2)*sum(shuffled^2))
    })
    permutation_p<-(1+sum(abs(permutation)>=abs(observed_r)-1e-12))/(draws+1)
    add<-function(method,removed,estimate,p,lower=NA_real_,upper=NA_real_,df=NA_real_,note='') {
      index<<-index+1L;all_rows[[index]]<<-data.frame(hypothesis='H2',analysis='repeated_measures_correlation',model_id='participant_intercepts',outcome=questionnaire,predictor=outcome,method=method,omitted_participant=removed,estimate=estimate,p_value=p,ci_lower=lower,ci_upper=upper,df=df,n_participants=length(ids)-as.integer(nzchar(removed)),n_observations=nrow(data)-if(nzchar(removed))sum(data$ParticipantID==removed) else 0L,status=if(is.finite(estimate))'FIT' else 'NOT_ESTIMABLE',note=note)
    }
    add('original_rmcorr','',observed_r,coefficient[4],df=degrees)
    add('participant_bootstrap_ci','',observed_r,NA_real_,interval[1],interval[2],note=paste(draws,'participant-resampling draws; interval for r; no bootstrap null p-value'))
    add('within_participant_permutation','',observed_r,permutation_p,note=paste(draws,'permutations; requires exchangeability of phase labels under the null; sensitivity, not randomization inference'))
    for(pid in ids) {
      value<-moment_r(rowSums(moments[,names(groups)!=pid,drop=FALSE]))
      add('leave_one_participant_out',pid,value,NA_real_)
    }
    adjusted<-tryCatch(lm(rating~physiology+ParticipantID+PhaseID,data=data),error=function(e)NULL)
    if(!is.null(adjusted)) {
      cf<-summary(adjusted)$coefficients
      if('physiology' %in% rownames(cf))add('phase_adjusted_slope','',cf['physiology',1],cf['physiology',4],df=df.residual(adjusted),note='Rating-points slope conditional on participant AND phase; changes estimand; not r')
    }
  }
  result<-robustness_bind(all_rows)
  result<-robustness_adjust(result,paste(result$analysis,result$method,result$omitted_participant),468L)
  # Actual restoration concordance: Spearman(delta PRS, delta physiology), six planned tests.
  concordance<-list();index<-0L
  for(mode in c('Bike','Walk'))for(outcome in c('eyetracker_fixation_rate','eyetracker_fixation_duration_s','empatica_eda_tonic')) {
    delta<-function(variable){a<-phase_data[phase_data$PhaseID==paste0(mode,'G'),c('ParticipantID',variable)];b<-phase_data[phase_data$PhaseID==paste0(mode,'U'),c('ParticipantID',variable)];names(a)[2]<-'green';names(b)[2]<-'urban';d<-merge(a,b,by='ParticipantID');setNames(d$green-d$urban,d$ParticipantID)}
    x<-delta('questionnaire_prs11_fascination_mean_1_5');y<-delta(outcome);ids<-intersect(names(x)[is.finite(x)],names(y)[is.finite(y)]);x<-x[ids];y<-y[ids]
    for(removed in c('',ids)) {
      keep<-ids!=removed;ct<-tryCatch(suppressWarnings(cor.test(x[keep],y[keep],method='spearman',exact=FALSE)),error=function(e)NULL)
      index<-index+1L;concordance[[index]]<-data.frame(hypothesis='H2',analysis='restoration_delta_spearman',model_id=mode,outcome=outcome,predictor='delta_PRS_fascination',method=if(nzchar(removed))'leave_one_participant_out' else 'original_spearman',omitted_participant=removed,estimate=if(is.null(ct))NA_real_ else unname(ct$estimate),p_value=if(is.null(ct))NA_real_ else ct$p.value,n_participants=sum(keep),status=if(is.null(ct))'NOT_ESTIMABLE' else 'FIT',note='Association of paired deltas; not a paired-difference test')
    }
    observed<-cor(x,y,method='spearman');permuted<-replicate(draws,cor(x,sample(y),method='spearman'));index<-index+1L
    concordance[[index]]<-data.frame(hypothesis='H2',analysis='restoration_delta_spearman',model_id=mode,outcome=outcome,predictor='delta_PRS_fascination',method='participant_delta_permutation',omitted_participant='',estimate=observed,p_value=(1+sum(abs(permuted)>=abs(observed)-1e-12))/(draws+1),n_participants=length(ids),status='FIT',note=paste(draws,'permutations of participant delta pairing'))
  }
  concordance<-robustness_bind(concordance);concordance<-robustness_adjust(concordance,paste(concordance$method,concordance$omitted_participant),6L)
  robustness_bind(list(result,concordance))
}
`%+%` <- function(a,b)paste0(a,b)

robustness_h5 <- function(root,cohort,physiology,use_kr=TRUE) {
  environment<-new.env(parent=.GlobalEnv)
  environment$PROJECT_ROOT<-root;environment$RAW_DATA_PATH<-paper3_merged_8min_path(root)
  environment$combined_study_spec<-paper3_combined_study_spec(root);environment$COMBINED_VARIANT<-'phaseavg'
  entry<-file.path(root,'scripts/statistical_analysis/H5_combined_phaseavg.R')
  expressions<-parse(entry)
  for(expression in expressions)if(is.call(expression) && identical(expression[[1]],as.name('<-')) && grepl('^Eq[1-7]$',as.character(expression[[2]])))eval(expression,environment)
  source(file.path(root,'scripts/statistical_analysis/library/H5_combined_core.R'),local=environment)
  raw<-environment$combined_read_input();output<-list();counter<-0L
  for(equation_id in 1:7)for(outcome in physiology) {
    equation<-environment[[paste0('Eq',equation_id)]];fixed<-as.formula(equation[[2]])
    exposures<-setdiff(environment$combined_fixed_terms(equation),environment$COMBINED_PHASE_SUM_COLS)
    data<-raw[,c('ParticipantID','PhaseID',exposures,outcome)]
    data$Y<-paper3_apply_csv_transform(data[[outcome]],outcome,environment$combined_study_spec$outcome_transforms_csv)
    data<-data[rowSums(!is.finite(as.matrix(data[,c(exposures,'Y')])) )==0,]
    cell<-aggregate(data[,c(exposures,'Y')],data[,c('ParticipantID','PhaseID')],mean)
    cell<-cell[order(cell$ParticipantID,cell$PhaseID),];cell$ParticipantID<-factor(cell$ParticipantID)
    for(variable in exposures){centered<-cell[[variable]]-ave(cell[[variable]],cell$ParticipantID,FUN=mean);scale<-sd(centered);cell[[paste0(variable,'_phase_z')]]<-if(is.finite(scale)&&scale>0)centered/scale else centered}
    cell[,environment$COMBINED_PHASE_SUM_COLS]<-paper3_phase_sum_design(cell$PhaseID)
    expected_terms<-attr(terms(fixed),'term.labels')
    for(removed in c('',cohort)) {
      sample<-droplevels(cell[as.character(cell$ParticipantID)!=removed,]);warnings<-character()
      design<-model.matrix(fixed,sample);full_rank<-qr(design)$rank==ncol(design)
      fit<-if(full_rank)tryCatch(withCallingHandlers(nlme::lme(fixed,data=sample,random=~1|ParticipantID,method='REML',na.action=na.fail,control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE)),warning=function(w){warnings<<-c(warnings,conditionMessage(w));invokeRestart('muffleWarning')}),error=function(e)e) else simpleError('Rank-deficient fixed design')
      add<-function(method,table,status,note=''){
        counter<<-counter+1L
        table$hypothesis<-'H5';table$analysis<-'original_adjusted_equation';table$model_id<-as.character(equation_id);table$outcome<-outcome;table$method<-method;table$omitted_participant<-removed;table$n_participants<-nlevels(sample$ParticipantID);table$n_observations<-nrow(sample);table$status<-status;table$design_rank<-qr(design)$rank;table$n_fixed_parameters<-ncol(design);table$note<-paste(note,paste(unique(warnings),collapse=' | '));output[[counter]]<<-table
      }
      empty<-data.frame(predictor=expected_terms,estimate=NA_real_,std_error=NA_real_,df=NA_real_,ci_lower=NA_real_,ci_upper=NA_real_,p_value=NA_real_)
      if(inherits(fit,'error')){add('CR2_Satterthwaite',empty,'FIT_FAILED',conditionMessage(fit));next}
      adjusted<-tryCatch(environment$combined_cr2(fit,sample$ParticipantID,planned=FALSE)$coefficients,error=function(e)e)
      if(inherits(adjusted,'error'))add('CR2_Satterthwaite',empty,'INFERENCE_FAILED',conditionMessage(adjusted)) else {
        adjusted<-adjusted[seq_along(nlme::fixef(fit)),,drop=FALSE];adjusted$predictor<-names(nlme::fixef(fit));adjusted<-adjusted[adjusted$predictor!='(Intercept)',];names(adjusted)[match(c('se','ci_low','ci_high'),names(adjusted))]<-c('std_error','ci_lower','ci_upper')
        add('CR2_Satterthwaite',adjusted,'FIT','Original outcome-specific complete-epoch sample; original full-cohort predictor centering/scaling frozen for deletions')
      }
      if(!nzchar(removed) && use_kr) {
        lmer_formula<-as.formula(paste(deparse(fixed,width.cutoff=500),'+ (1 | ParticipantID)'))
        small<-tryCatch(suppressWarnings(lmerTest::lmer(lmer_formula,data=sample,REML=TRUE)),error=function(e)e)
        if(inherits(small,'error'))add('Kenward_Roger',empty,'FIT_FAILED',conditionMessage(small)) else {
          cf<-tryCatch(coef(summary(small,ddf='Kenward-Roger')),error=function(e)e)
          if(inherits(cf,'error'))add('Kenward_Roger',empty,'INFERENCE_FAILED',conditionMessage(cf)) else {
            cf<-cf[rownames(cf)!='(Intercept)',,drop=FALSE];critical<-qt(.975,cf[,'df'])
            add('Kenward_Roger',data.frame(predictor=rownames(cf),estimate=cf[,1],std_error=cf[,2],df=cf[,'df'],ci_lower=cf[,1]-critical*cf[,2],ci_upper=cf[,1]+critical*cf[,2],p_value=cf[,'Pr(>|t|)']),if(lme4::isSingular(small))'SINGULAR_FIT' else 'FIT','Same fixed effects and random intercept; model-based KR sensitivity, distinct covariance assumption from CR2')
          }
        }
      }
    }
    if(match(outcome,physiology)%%5==0)message('H5 equation ',equation_id,': ',match(outcome,physiology),'/',length(physiology),' outcomes checked')
  }
  result<-robustness_bind(output);result<-robustness_adjust(result,paste(result$model_id,result$predictor,result$method,result$omitted_participant),26L)
  result$low_df_flag<-is.finite(result$df)&result$df<4
  result$predictor<-sub('_phase_z$','',result$predictor)
  result
}

robustness_h4 <- function(root,cohort, sound_limit=NULL, omitted=cohort) {
  source(file.path(root,'scripts/statistical_analysis/library/H4_sound_literature_helpers.R'),local=FALSE)
  epochs<-read.csv(paper3_merged_8min_path(root),check.names=FALSE)
  epochs<-epochs[epochs$ParticipantID %in% cohort & epochs$PhaseID %in% PAPER3_CORE_PHASES,]
  epochs$Datetime<-as.POSIXct(epochs$Datetime,tz='UTC');epochs<-epochs[order(epochs$ParticipantID,epochs$PhaseID,epochs$Datetime),]
  available<-tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true','1')
  for(column in attr(paper3_physiological_outcomes(),'empatica_hrv_fd_window'))epochs[[column]][!available]<-NA_real_
  epochs$hrv_window_available<-available[order(epochs$ParticipantID,epochs$PhaseID,epochs$Datetime)]
  # Already sorted before availability above: preserve the original script's availability fields.
  epochs$hrv_window_available<-tolower(as.character(epochs$empatica_hrv_fd_5min_available)) %in% c('true','1')
  epochs$hrv_seg_start<-H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_start)
  epochs$hrv_seg_end<-H4_UTIL$parse_utc(epochs$empatica_hrv_fd_5min_segment_end)
  # The expensive native-beat window calculation does not depend on sound variable or omitted person.
  suppressPackageStartupMessages({library(nlme);library(mgcv)})
  original_frequency<-H4_MOSHAMMER$lf_hf;frequency_cache<-new.env(parent=emptyenv())
  H4_MOSHAMMER$lf_hf<-function(peak_time,rri_ms,start,end){key<-paste(as.numeric(start),as.numeric(end));if(!exists(key,frequency_cache,inherits=FALSE))assign(key,original_frequency(peak_time,rri_ms,start,end),frequency_cache);get(key,frequency_cache,inherits=FALSE)}
  original_frame<-H4_MOSHAMMER$period_frame;frame_cache<-new.env(parent=emptyenv())
  H4_MOSHAMMER$period_frame<-function(selected,sound=H4_SOUND$primary){key<-sound$column;if(!exists(key,frame_cache,inherits=FALSE))assign(key,original_frame(epochs,sound),frame_cache);frame<-get(key,frame_cache,inherits=FALSE);frame[frame$ParticipantID %in% unique(selected$ParticipantID),]}
  assign('H4_MOSHAMMER',H4_MOSHAMMER,envir=.GlobalEnv)
  control<-nlme::lmeControl(opt='optim');sounds<-c(list(primary=H4_SOUND$primary),H4_SOUND$alternatives(names(epochs)))
  if(!is.null(sound_limit))sounds<-sounds[seq_len(sound_limit)]
  blocks<-list();counter<-0L
  run_block<-function(name,fun,selected,sound=NULL){
    tryCatch(if(is.null(sound))fun(selected,control)$results else if(name %in% c('Moshammer','Jin'))fun(selected,sound)$results else fun(selected,control,sound)$results,error=function(e)data.frame(paper=name,test='BLOCK_FAILURE',outcome='',term='',estimate=NA_real_,p=NA_real_,n_observations=nrow(selected),n_participants=length(unique(selected$ParticipantID)),model_details=conditionMessage(e)))
  }
  for(removed in c('',omitted)) {
    selected<-epochs[as.character(epochs$ParticipantID)!=removed,]
    for(sound_name in names(sounds)) {
      sound<-sounds[[sound_name]]
      for(name in c('Moshammer','Jin','Biel','BielRepeated','Rodrigues','Kraus')) {
        helper<-switch(name,Moshammer=H4_MOSHAMMER,Jin=H4_JIN,Biel=H4_BIEL,BielRepeated=H4_BIEL_REPEATED,Rodrigues=H4_RODRIGUES,Kraus=H4_KRAUS)
        table<-run_block(name,helper$run,selected,sound)
        counter<-counter+1L;table$sound_variable<-sound$column;table$omitted_participant<-removed;blocks[[counter]]<-table
      }
    }
    for(name in c('Korpilo','Pigliautile')) {
      table<-tryCatch(switch(name,Korpilo=H4_KORPILO$run(selected,control),Pigliautile=H4_PIGLIAUTILE$run(selected))$results,error=function(e)data.frame(paper=name,test='BLOCK_FAILURE',outcome='',term='',estimate=NA_real_,p=NA_real_,model_details=conditionMessage(e)))
      counter<-counter+1L;table$sound_variable<-'source_specific';table$omitted_participant<-removed;blocks[[counter]]<-table
    }
    message('H4 exact helper reruns complete: omitted ',if(nzchar(removed))removed else 'none')
  }
  result<-robustness_bind(blocks)
  names(result)[match(c('term','p','se','ci_low','ci_high','n_observations'),names(result))]<-c('predictor','p_value','std_error','ci_lower','ci_upper','n_observations')
  result$hypothesis<-'H4';result$analysis<-'original_literature_method';result$method<-'source_method_participant_deletion'
  result$model_id<-paste(result$paper,result$test,result$sound_variable,sep=' | ')
  result$status<-ifelse(is.finite(result$p_value),'FIT','NOT_ESTIMABLE')
  # Match original H4 finite-test correction rule within each source/test/descriptor/deletion.
  family<-paste(result$model_id,result$omitted_participant)
  result$q_value<-NA_real_
  for(key in unique(family)){rows<-which(family==key & is.finite(result$p_value));result$q_value[rows]<-p.adjust(result$p_value[rows],'BH')}
  result$FDR_significant<-ifelse(is.finite(result$q_value),result$q_value<.05,NA)
  result$note<-'Exact existing helper and data windows; cohort-derived bins/scales/model-selection re-estimated after deletion; post-hoc influence check, not independent replication. Primary source test may not correct repeated-participant dependence.'
  result
}
