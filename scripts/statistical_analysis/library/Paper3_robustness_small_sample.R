# Additional small-cohort diagnostics; never substitutes for the source-paper test.
robustness_jackknife_h4 <- function(checks) {
  data<-checks[checks$hypothesis=='H4' & checks$method=='source_method_participant_deletion',]
  key<-paste(data$model_id,data$outcome,data$predictor,sep=' | ')
  base<-data[data$omitted_participant=='' & is.finite(data$estimate) & !grepl('Spearman|correlation',data$statistic_test,ignore.case=TRUE),]
  output<-list()
  for(index in seq_len(nrow(base))) {
    current<-base[index,];rows<-data[key==paste(current$model_id,current$outcome,current$predictor,sep=' | ') & data$omitted_participant!='',]
    current$method<-'participant_jackknife_t_approximation';current$note<-'Delete-one-participant jackknife bias-corrected coefficient and SE; approximate t with n_contributing_participants - 1 df, not an exact small-sample test; includes cohort-dependent preprocessing/model selection. Compare to original source-method row.'
    current$estimate<-current$std_error<-current$ci_lower<-current$ci_upper<-current$p_value<-current$q_value<-NA_real_
    current$FDR_significant<-NA;count<-as.integer(base$n_participants[index]);current$df<-count-1L
    rows<-rows[is.finite(rows$n_participants) & rows$n_participants==count-1L,,drop=FALSE]
    if(count>=4L && nrow(rows)==count && length(unique(rows$omitted_participant))==count && all(is.finite(rows$estimate))) {
      pseudovalues<-count*base$estimate[index]-(count-1L)*rows$estimate
      estimate<-mean(pseudovalues);standard_error<-sd(pseudovalues)/sqrt(count)
      current$estimate<-estimate;current$std_error<-standard_error
      current$ci_lower<-estimate-qt(.975,count-1L)*standard_error;current$ci_upper<-estimate+qt(.975,count-1L)*standard_error
      current$p_value<-if(standard_error>0)2*pt(-abs(estimate/standard_error),count-1L) else NA_real_
      current$status<-if(is.finite(current$p_value))'FIT_APPROXIMATE' else 'UNDEFINED_VARIANCE'
    } else current$status<-'INCOMPLETE_DELETION_FITS'
    output[[index]]<-current
  }
  output<-robustness_bind(output)
  robustness_adjust(output,paste(output$model_id,output$method))
}

robustness_jin_cluster <- function(root,cohort) {
  source(file.path(root,'scripts/statistical_analysis/library/H4_sound_literature_helpers.R'),local=FALSE)
  epochs<-read.csv(paper3_merged_8min_path(root),check.names=FALSE)
  epochs<-epochs[epochs$ParticipantID %in% cohort & epochs$PhaseID %in% PAPER3_CORE_PHASES,]
  epochs$Datetime<-as.POSIXct(epochs$Datetime,tz='UTC');epochs<-epochs[order(epochs$ParticipantID,epochs$PhaseID,epochs$Datetime),]
  sounds<-c(list(primary=H4_SOUND$primary),H4_SOUND$alternatives(names(epochs)))
  rows<-list();index<-0L
  for(sound in sounds) {
    cells<-H4_JIN$cell_frame(epochs,sound)
    for(outcome_label in names(H4_JIN$outcomes)) {
      outcome<-H4_JIN$outcomes[[outcome_label]]
      for(specification in c('additive','interaction')) {
        data<-cells[is.finite(cells[[outcome]]) & !is.na(cells$laeq_level) & !is.na(cells$utci_category),]
        data<-droplevels(data);data$ParticipantID<-factor(data$ParticipantID)
        data$response<-data[[outcome]]
        fixed<-if(specification=='additive')response~ParticipantID+laeq_level+utci_category else response~ParticipantID+laeq_level*utci_category
        fit<-lm(fixed,data=data);design<-model.matrix(fit)
        design_rank<-qr(design)$rank;labels<-attr(terms(fit),'term.labels');assignment<-attr(design,'assign')
        covariance<-if(design_rank==ncol(design))tryCatch(clubSandwich::vcovCR(fit,cluster=data$ParticipantID,type='CR2'),error=function(e)e) else simpleError('Rank-deficient factorial design; sparse occupied exposure cells')
        for(term in intersect(labels,c('laeq_level','utci_category','laeq_level:utci_category'))) {
          index<-index+1L
          columns<-which(assignment==match(term,labels));constraint<-diag(ncol(design))[columns,,drop=FALSE]
          test<-if(inherits(covariance,'error'))covariance else tryCatch(clubSandwich::Wald_test(fit,constraints=constraint,vcov=covariance,test='HTZ'),error=function(e)e)
          rows[[index]]<-data.frame(hypothesis='H4',analysis='Jin_participant_blocked_sensitivity',
            model_id=paste('Jin',specification,sound$column,term,sep=' | '),outcome=outcome_label,predictor=term,
            method='participant_FE_CR2_HTZ',omitted_participant='',estimate=NA_real_,test_statistic=if(inherits(test,'error'))NA_real_ else test$Fstat,
            df=if(inherits(test,'error'))NA_real_ else test$df_denom,p_value=if(inherits(test,'error'))NA_real_ else test$p_val,
            n_participants=nlevels(data$ParticipantID),n_observations=nrow(data),
            design_rank=design_rank,n_fixed_parameters=ncol(design),status=if(inherits(test,'error'))'NOT_ESTIMABLE' else 'FIT',
            note=paste('Jin exposure bins preserved; added participant fixed intercepts and CR2/HTZ small-sample clustered inference. This is a sensitivity specification, not the original paper method.',if(inherits(test,'error'))conditionMessage(test) else ''))
        }
      }
    }
  }
  result<-robustness_bind(rows)
  result<-robustness_adjust(result,result$model_id,2L)
  invalid<-!is.finite(result$p_value) | !is.finite(result$df) | result$df<=0
  result$status[invalid & result$status=='FIT']<-'INFERENCE_UNDEFINED_SMALL_SAMPLE'
  result$p_value[invalid]<-NA_real_;result$q_value[invalid]<-NA_real_;result$FDR_significant[invalid]<-NA
  result<-robustness_adjust(result,result$model_id,2L)
  result$low_df_flag<-is.finite(result$df)&result$df<4
  result
}

# Same four-phase random-intercept models after each participant deletion.
# Reconstructing the phase means from the paired audit values avoids a second data-preparation implementation.
robustness_h1_h3_models <- function(participant_values,cohort,full_only=FALSE) {
  selected<-participant_values[participant_values$Hypothesis %in% c('H1','H3'),]
  specifications<-do.call(rbind,paper3_h1_h3_planned_contrast_tables())
  rows<-list();index<-0L
  keys<-unique(selected[c('Outcome','Outcome_Type','Scale')])
  for(item in seq_len(nrow(keys))) {
    information<-keys[item,]
    values<-selected[selected$Outcome==information$Outcome & selected$Scale==information$Scale,]
    reference<-data.frame(ParticipantID=values$ParticipantID,PhaseID=values$Reference_PhaseID,model_y=values$ReferenceValue)
    comparison<-data.frame(ParticipantID=values$ParticipantID,PhaseID=values$Comparison_PhaseID,model_y=values$ComparisonValue)
    cells<-unique(rbind(reference,comparison))
    stopifnot(!anyDuplicated(cells[c('ParticipantID','PhaseID')]))
    cells<-cells[is.finite(cells$model_y),]
    for(removed in if(full_only)'' else cohort) {
      sample<-cells[cells$ParticipantID!=removed,];sample$ParticipantID<-droplevels(factor(sample$ParticipantID,levels=cohort));sample$PhaseID<-factor(sample$PhaseID,levels=PAPER3_CORE_PHASES)
      fit<-if(nrow(sample)<24L || nlevels(sample$ParticipantID)<8L || length(unique(sample$PhaseID))!=4L || !is.finite(sd(sample$model_y)) || sd(sample$model_y)<=0)simpleError('Not enough data under original model eligibility') else tryCatch(nlme::lme(model_y~PhaseID,random=~1|ParticipantID,data=sample,method='REML',na.action=na.omit,control=nlme::lmeControl(opt='optim',maxIter=300,msMaxIter=300,returnObject=FALSE)),error=function(e)e)
      if(inherits(fit,'error'))result<-fit else {
        result<-tryCatch({
          marginal<-emmeans::emmeans(fit,~PhaseID);levels<-marginal@levels$PhaseID
          weights<-lapply(seq_len(nrow(specifications)),function(number){weight<-setNames(rep(0,length(levels)),levels);weight[specifications$Comparison_PhaseID[number]]<-1;weight[specifications$Reference_PhaseID[number]]<--1;unname(weight)})
          contrasts<-emmeans::contrast(marginal,method=setNames(weights,paste0('contrast',seq_along(weights))))
          if(full_only) {
            covariance<-clubSandwich::vcovCR(fit,cluster=sample$ParticipantID,type='CR2')
            robust<-clubSandwich::linear_contrast(fit,contrasts=contrasts@linfct,vcov=covariance,test='Satterthwaite',p_values=TRUE)
            data.frame(estimate=robust$Est,SE=robust$SE,lower.CL=robust$CI_L,upper.CL=robust$CI_U,df=robust$df,p.value=robust$p_val)
          } else as.data.frame(summary(contrasts,infer=c(TRUE,TRUE),adjust='none'))
        },error=function(e)e)
      }
      for(number in seq_len(nrow(specifications))) {
        specification<-specifications[number,];index<-index+1L
        failed<-inherits(result,'error')
        rows[[index]]<-data.frame(hypothesis=specification$Hypothesis,analysis='original_phase_contrast',model_id=information$Scale,
          outcome=information$Outcome,predictor='PhaseID',comparison=paste(specification$Comparison_PhaseID,'-',specification$Reference_PhaseID),
          method=if(full_only)'CR2_Satterthwaite_phase_contrast' else 'original_nlme_participant_deletion',omitted_participant=removed,
          estimate=if(failed)NA_real_ else result$estimate[number],std_error=if(failed)NA_real_ else result$SE[number],
          ci_lower=if(failed)NA_real_ else result$lower.CL[number],ci_upper=if(failed)NA_real_ else result$upper.CL[number],
          df=if(failed)NA_real_ else result$df[number],p_value=if(failed)NA_real_ else result$p.value[number],
          n_participants=nlevels(sample$ParticipantID),n_observations=nrow(sample),
          status=if(failed)'NOT_ESTIMABLE' else 'FIT',
          note=if(failed)conditionMessage(result) else paste0('Same four-phase REML random-intercept equation and contrast; ',if(full_only)'CR2/Satterthwaite participant-cluster covariance; ' else '', 'outcome_type=',information$Outcome_Type),
          outcome_type=information$Outcome_Type)
      }
    }
  }
  result<-robustness_bind(rows)
  robustness_adjust(result,paste(result$hypothesis,result$model_id,result$comparison,result$method,result$omitted_participant,result$outcome_type))
}

robustness_h4_additional <- function(root,cohort) {
  source(file.path(root,'scripts/statistical_analysis/library/H4_sound_literature_helpers.R'),local=FALSE)
  epochs<-read.csv(paper3_merged_8min_path(root),check.names=FALSE)
  epochs<-epochs[epochs$ParticipantID %in% cohort & epochs$PhaseID %in% PAPER3_CORE_PHASES,]
  epochs$Datetime<-as.POSIXct(epochs$Datetime,tz='UTC');epochs<-epochs[order(epochs$ParticipantID,epochs$PhaseID,epochs$Datetime),]
  rows<-lapply(c('',cohort),function(removed){
    data<-epochs[epochs$ParticipantID!=removed,]
    result<-h4_additional_outdoor_tests(data)$results;result$omitted_participant<-removed
    result
  })
  result<-robustness_bind(rows)
  names(result)[match(c('term','p','se','ci_low','ci_high'),names(result))]<-c('predictor','p_value','std_error','ci_lower','ci_upper')
  result$hypothesis<-'H4';result$analysis<-'additional_outdoor_methods';result$method<-'source_method_participant_deletion'
  result$model_id<-paste(result$paper,result$test,result$sound_variable,sep=' | ')
  result$status<-ifelse(is.finite(result$p_value),'FIT','NOT_ESTIMABLE')
  result$note<-'Current additional H4 outdoor helper, four core phases only; original method/adaptation label retained. Whole-participant deletion; no tram pooling.'
  result$q_value<-NA_real_;family<-paste(result$model_id,result$omitted_participant)
  for(key in unique(family)){index<-which(family==key & is.finite(result$p_value));result$q_value[index]<-p.adjust(result$p_value[index],'BH')}
  result$FDR_significant<-ifelse(is.finite(result$q_value),result$q_value<.05,NA)
  result
}
