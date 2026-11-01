# Presentation-only schema. Never changes a model, hypothesis or adjustment family.
paper3_result_names <- function(x, filename) {
  old <- names(x); n <- nrow(x); file <- basename(filename)
  is_h2 <- grepl('H2|Concordance|pairwise_rmcorr',file)
  map <- c(Beta='estimate',SE='std_error',se='std_error',p='p_value',q='p_value_adjusted',
    q_FDR='p_value_adjusted',q_BH='p_value_adjusted',fdr_q='p_value_adjusted',p_value_FDR='p_value_adjusted',
    q_equation='p_value_adjusted_equation',SignFlip_p='p_value_signflip',SignFlip_q='p_value_adjusted_signflip',
    p_value_60s='p_value_60s',q_FDR_60s='p_value_adjusted_60s',Beta_60s='estimate_60s',SE_60s='std_error_60s',
    Beta_CI95_low='ci_lower',Beta_CI95_high='ci_upper',ci_low='ci_lower',ci_high='ci_upper',
    Beta_CI95_60s_low='ci_lower_60s',Beta_CI95_60s_high='ci_upper_60s',
    SMD_paired_Bonett='smd',SMD_CI95_low='smd_ci_lower',SMD_CI95_high='smd_ci_upper',
    t_ratio='statistic',t_stat='statistic',t_or_z='statistic',
    r_rmcorr='correlation',r_rm='correlation',Partial_r_Within='correlation',
    CI95_low=if(is_h2) 'correlation_ci_lower' else 'ci_lower',
    CI95_high=if(is_h2) 'correlation_ci_upper' else 'ci_upper',
    N_Participants='n_participants',N_participants='n_participants',participants='n_participants',
    N_Complete_Pairs='n_pairs',N_PhaseBouts='n_phase_bouts',N_epochs='n_epochs',N_epochs_60s='n_epochs_60s',
    Family_Size='adjustment_family_size',FDR_scope='adjustment_family',
    FDR_significant='significant_adjusted',fdr_significant='significant_adjusted',survives_FDR_q05='significant_adjusted',
    FDR_equation_significant='significant_adjusted_equation',FDR_significant_60s='significant_adjusted_60s',
    sig_p05='significant_unadjusted',significant_raw_p05='significant_unadjusted',
    reportable_sig_p05='reportable_significant_unadjusted',reportable_FDR_q05='reportable_significant_adjusted',
    significant_p='significant_unadjusted_outcomes',surviving_FDR='significant_adjusted_outcomes',
    n_p_lt_05='n_significant_unadjusted',n_q_lt_05='n_significant_adjusted',
    n_raw_p_lt_alpha='n_significant_unadjusted',n_fdr_significant='n_significant_adjusted',
    Model='model_id',model='model_id',Term='term',Outcome='outcome',PhaseID='phase_id',phase='phase_id',
    ParticipantID='participant_id',Contrast='contrast')
  if ('N' %in% old) map['N'] <- if(grepl('H6_1',file)) 'n_pairs' else 'n_participants'
  if ('n' %in% old) map['n'] <- 'n_observations'
  snake <- function(z) { z <- gsub('([a-z0-9])([A-Z])','\\1_\\2',z); z <- tolower(gsub('[^A-Za-z0-9_]+','_',z)); gsub('_+','_',z) }
  new <- vapply(old,function(z) if(z %in% names(map)) unname(map[z]) else snake(z),character(1))
  # Resolve union-table duplicate columns only when nonmissing entries agree.
  out <- data.frame(row.names=seq_len(n))
  for (target in unique(new)) {
    cols <- which(new==target); value <- x[[cols[1]]]
    if(length(cols)>1) for(j in cols[-1]) {
      other <- x[[j]]; a <- !is.na(value)&nzchar(value); b <- !is.na(other)&nzchar(other)
      if(any(a & b & value!=other)) stop('Conflicting aliases in ',file,': ',target)
      value[!a & b] <- other[!a & b]
    }
    out[[target]] <- value
  }
  add <- function(key,value) if(!key %in% names(out)) out[[key]] <<- rep(value,length.out=n)
  if('statistic' %in% names(out)) add('statistic_type',if(any(c('t_stat','t_ratio') %in% old)) 't' else 'unspecified_t_or_z')
  if('estimate' %in% names(out)) add('estimate_type',if(any(c('Beta','SE') %in% old)) 'regression_coefficient_or_contrast' else 'see_test_definition')
  # Literature union incorrectly stores F statistics in the estimate column.
  if(all(c('test','estimate') %in% names(out)) && grepl('9_FDR',file)) {
    ix <- grepl('ANOVA',out$test,ignore.case=TRUE)
    add('statistic',''); add('statistic_type','')
    out$statistic[ix] <- out$estimate[ix];out$statistic_type[ix] <- 'F';out$estimate[ix] <- ''
    out$estimate_type[ix] <- 'not_applicable_omnibus_test'
  }
  if(any(c('ci_lower','correlation_ci_lower','smd_ci_lower') %in% names(out))) add('confidence_level','0.95')
  if('correlation' %in% names(out)) add('correlation_type','repeated_measures_or_partial_within_participant')
  if('p_value_adjusted' %in% names(out)) {
    add('adjustment_method','BH')
    add('adjustment_family','source_defined_family_see_methods')
    add('adjustment_family_size','') # Do not guess planned family size from observed rows.
  }
  # Preserve non-estimability reasons outside boolean columns.
  for(k in grep('^(significant_|reportable_significant_)',names(out),value=TRUE)) {
    if(grepl('_outcomes$',k)) next
    z <- toupper(out[[k]]); bad <- !is.na(z)&nzchar(z)&!z %in% c('TRUE','FALSE','1','0')
    if(any(bad)) { add('inference_status',''); empty <- !nzchar(out$inference_status);out$inference_status[bad & empty] <- out[[k]][bad & empty] }
    out[[k]] <- ifelse(z %in% c('TRUE','1'),'TRUE',ifelse(z %in% c('FALSE','0'),'FALSE',''))
  }
  list(data=out,dictionary=data.frame(file=file,original_column=old,standard_column=new))
}

paper3_standardize_result_directory <- function(directory) {
  if(!dir.exists(directory)) return(invisible(NULL))
  files <- list.files(directory,'\\.csv$',full.names=TRUE,recursive=FALSE)
  maps <- list()
  for(path in files) {
    if(basename(path)=='OUTPUT_COLUMN_DICTIONARY.csv') next
    x <- read.csv(path,colClasses='character',check.names=FALSE,na.strings=c('', 'NA', 'NaN'))
    # Only statistical result tables: audit/cache/input schemas remain untouched.
    if(!any(names(x) %in% c('p','p_value','q','q_FDR','q_BH','p_value_FDR','fdr_q','SignFlip_p','p_value_60s','n_p_lt_05'))) next
    result <- paper3_result_names(x,path)
    if(!identical(x,result$data)) utils::write.csv(result$data,path,row.names=FALSE,na='')
    maps[[length(maps)+1L]] <- result$dictionary
  }
  if(length(maps)) utils::write.csv(do.call(rbind,maps),file.path(directory,'OUTPUT_COLUMN_DICTIONARY.csv'),row.names=FALSE)
  invisible(maps)
}
