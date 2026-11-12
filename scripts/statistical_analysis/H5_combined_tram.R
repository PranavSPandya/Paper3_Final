# H5 five-phase sensitivity: original seven equations, plus a Tram phase indicator.
# Core Walk/Bike sum coding is preserved; the new indicator contrasts Tram with
# the equal-weight mean of the four active phases. Original results stay untouched.
args<-grep('^--file=',commandArgs(FALSE),value=TRUE)
entry<-normalizePath(sub('^--file=','',args[1]),mustWork=TRUE)
script_dir<-dirname(entry)
source(file.path(script_dir,'library','Paper3_common.R'))
root<-resolve_project_root()
for(package in c('nlme','car','clubSandwich'))if(!requireNamespace(package,quietly=TRUE))stop('Missing ',package)
base_design<-paper3_phase_sum_design
run_grain<-function(grain){
  environment<-new.env(parent=.GlobalEnv)
  environment$PROJECT_ROOT<-root;environment$RAW_DATA_PATH<-paper3_merged_8min_path(root)
  environment$combined_study_spec<-paper3_combined_study_spec(root)
  environment$combined_study_spec$phases<-c(environment$combined_study_spec$phases,'Tram')
  environment$COMBINED_VARIANT<-paste0(grain,'_tram')
  # Evaluate only definitions from the original entry, avoiding its execution block.
  expressions<-parse(file.path(script_dir,paste0('H5_combined_',grain,'.R')))
  for(expression in expressions)if(is.call(expression)&&identical(expression[[1]],as.name('<-'))){
    name<-as.character(expression[[2]])
    if(grepl('^Eq[1-7]$',name)||grepl('^combined_',name)&&is.call(expression[[3]])&&identical(expression[[3]][[1]],as.name('function')))eval(expression,environment)
  }
  source(file.path(script_dir,'library','H5_combined_core.R'),local=environment)
  environment$COMBINED_PHASE_SUM_COLS<-c(environment$COMBINED_PHASE_SUM_COLS,'PhaseSumTram')
  environment$paper3_phase_sum_design<-function(phase){
    phase<-as.character(phase);if(any(!phase %in% c('WalkG','WalkU','BikeG','BikeU','Tram')))stop('Unknown phase')
    result<-matrix(0,length(phase),4,dimnames=list(NULL,c('PhaseSumWalkG','PhaseSumWalkU','PhaseSumBikeG','PhaseSumTram')))
    active<-phase!='Tram';result[active,1:3]<-base_design(phase[active]);result[!active,4]<-1;result
  }
  for(index in 1:7){
    equation<-environment[[paste0('Eq',index)]]
    fixed<-as.formula(equation[[2]])
    equation[[2]]<-update(fixed,.~.+PhaseSumTram)
    environment[[paste0('Eq',index)]]<-equation
  }
  # The timeseries function explicitly factors PhaseID; extend those levels locally.
  if(grain=='timeseries'){
    definition<-paste(deparse(environment$combined_fit_timeseries,width.cutoff=500),collapse='\n')
    definition<-gsub('c("WalkG", "WalkU", "BikeG", "BikeU")','c("WalkG", "WalkU", "BikeG", "BikeU", "Tram")',definition,fixed=TRUE)
    environment$combined_fit_timeseries<-eval(parse(text=definition),environment)
  }
  output<-environment$OUT_DIR;dir.create(output,recursive=TRUE,showWarnings=FALSE)
  environment$combined_write_vif<-function(table)write.csv(table,file.path(output,'design_diagnostics.csv'),row.names=FALSE,na='')
  environment$combined_write_tables<-function(tables){
    for(name in names(tables)){
      table<-tables[[name]]
      rename<-c(equation_id='model_id',term='predictor',contrast='comparison',se='std_error',ci_low='ci_lower',ci_high='ci_upper',q='q_value',n='n_observations')
      for(old in intersect(names(rename),names(table)))names(table)[names(table)==old]<-rename[[old]]
      table$script_name<-'H5_combined_tram.R';table$source_table<-paste0(name,'.csv');table$statistic_test<-'t-test (participant-cluster CR2/Satterthwaite)';table$test_statistic<-table$estimate/table$std_error;table$FDR_significant<-ifelse(is.finite(table$q_value),table$q_value<.05,NA)
      table$analysis_scope<-'BikeU BikeG WalkU WalkG Tram; additional five-phase sensitivity'
      write.csv(table,file.path(output,paste0(name,'.csv')),row.names=FALSE,na='')
    }
    notes<-c('Additional H5 five-phase sensitivity; original four-phase results not overwritten.',
      'All seven original equations and outcome transformations retained. Extra PhaseSumTram=1 for Tram, 0 for active phases.',
      'Original active-phase sum coding retained, zero for Tram. Tram coefficient is relative to equal-weight active-phase mean.',
      'Tram is passenger transport, not active mobility. Tram route GVI is an assigned outdoor-route measure, not measured passenger visual exposure.',
      'All available Tram rows in the existing 8min merged file are used; no fabricated extension to 8 minutes.',
      'CR2/Satterthwaite by participant; original per-equation/predictor BH across 26 outcomes.',
      paste('InputMD5:',tools::md5sum(environment$RAW_DATA_PATH)),paste('EntryMD5:',tools::md5sum(entry)),paste('CoreMD5:',tools::md5sum(file.path(script_dir,'library','H5_combined_core.R'))),paste('SourceGrainMD5:',tools::md5sum(file.path(script_dir,paste0('H5_combined_',grain,'.R')))),paste('RunUTC:',format(Sys.time(),tz='UTC',usetz=TRUE)))
    write.csv(data.frame(item=seq_along(notes),note=notes),file.path(output,'run_info.csv'),row.names=FALSE)
  }
  environment$combined_phase_term_labels<-function(term)ifelse(term=='PhaseSumTram','Phase: Tram vs mean of four active phases',sub('^PhaseSum(.*)$','Phase: \\1 vs mean of four active phases',term))
  message('Running H5 ',grain,' with Tram')
  if(grain=='phaseavg')environment$combined_fit_phaseavg() else environment$combined_fit_timeseries()
}
grains<-sub('^--grain=','',grep('^--grain=',commandArgs(TRUE),value=TRUE))
if(!length(grains))grains<-'phaseavg'
if(!all(grains %in% c('phaseavg','timeseries')))stop('Use --grain=phaseavg or --grain=timeseries')
for(grain in grains)run_grain(grain)
