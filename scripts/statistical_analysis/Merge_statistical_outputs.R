# Collect compact public results without refitting or recalculating p/q.
args<-commandArgs(TRUE)
option<-function(argument_name,default){option_values<-args[startsWith(args,paste0('--',argument_name,'='))];if(length(option_values))substring(option_values[1],nchar(argument_name)+4L)else default}
.entry<-sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value=TRUE))
if(length(.entry)&&file.exists(.entry[1])){
 source(file.path(dirname(normalizePath(.entry[1], winslash='/', mustWork=FALSE)), 'library', 'Paper3_common.R'), local=FALSE)
}else if(file.exists('library/Paper3_common.R')){
 source('library/Paper3_common.R', local=FALSE)
}else if(file.exists('scripts/statistical_analysis/library/Paper3_common.R')){
 source('scripts/statistical_analysis/library/Paper3_common.R', local=FALSE)
}else{
 stop('Run with Rscript on this file or setwd to scripts/statistical_analysis', call.=FALSE)}
root<-option('root', resolve_project_root())
input<-option('input',file.path(root,'output/statistical_analysis/results'))
out<-option('out',file.path(root,'output/merged'))
groups<-list(Analysis_combined_merged=c('Analysis_combined_phaseavg','Analysis_combined_timeseries'),
 H1_H3_H6_merged=c('H1_H3_phaseavg','H1_H3_timeseries','H6_stress_composite_phaseavg','H6_stress_composite_timeseries'),
 H4_sound_results='H4_sound_literature_test',H5_grid_results='H5_exploratory')
read<-function(source_path)read.csv(source_path,colClasses='character',check.names=FALSE,na.strings=c('','NA','NaN'),stringsAsFactors=FALSE)
nonblank<-function(input_values)!is.na(input_values)&nzchar(input_values)
outputs<-list();sources<-character();hashes<-character()
for(group_name in names(groups)){
 parts<-list()
 for(folder in groups[[group_name]]){
  source_directory<-file.path(input,folder);if(!dir.exists(source_directory))stop('Missing source directory: ',source_directory)
  for(source_path in sort(list.files(source_directory,'[.]csv$',full.names=TRUE))){
   source_table<-read(source_path);if(!'p_value'%in%names(source_table))next
   required<-c('script_name','source_table','q_value','FDR_significant')
   if(!all(required%in%names(source_table)))stop('Source needs current compact export finalizer: ',source_path)
   if(anyDuplicated(names(source_table)))stop('Duplicate source column: ',source_path)
   forbidden<-grep('equation|^p_value_adjusted|^significant_adjusted$|^term$|^statistic_type$',names(source_table),value=TRUE)
   if(length(forbidden))stop('Noncompact source columns: ',paste(forbidden,collapse=', '))
   q<-suppressWarnings(as.numeric(source_table$q_value));valid<-nonblank(source_table$q_value)
   if(any(valid&(!is.finite(q)|q<0|q>1)))stop('Invalid q in ',source_path)
   flag<-toupper(source_table$FDR_significant)
   if(any(valid & (is.na(flag)|flag!=ifelse(q<.05,'TRUE','FALSE')),na.rm=TRUE))stop('FDR flag mismatch: ',source_path)
   if(any(!nonblank(source_table$script_name)))stop('Missing script provenance: ',source_path)
   parts[[length(parts)+1L]]<-source_table;sources<-c(sources,source_path);hashes<-c(hashes,unname(tools::md5sum(source_path)))}
 }
 if(!length(parts))stop('No statistical tables for ',group_name)
 cols<-unique(unlist(lapply(parts,names)))
 parts<-lapply(parts,function(source_table){for(column_name in setdiff(cols,names(source_table)))source_table[[column_name]]<-NA_character_;source_table[cols]})
 merged_table<-do.call(rbind,parts);merged_table<-merged_table[vapply(merged_table,function(input_values)any(nonblank(input_values)),logical(1))]
 outputs[[group_name]]<-merged_table}
if(!identical(hashes,unname(tools::md5sum(sources))))stop('Source files changed during collection')
dir.create(out,recursive=TRUE,showWarnings=FALSE)
recognized<-paste0(names(groups),'.csv')
extra<-setdiff(list.files(out),recognized);if(length(extra))stop('Unexpected files in merge destination: ',paste(extra,collapse=', '))
for(group_name in names(outputs)){
 merged_table<-outputs[[group_name]];output_path<-file.path(out,paste0(group_name,'.csv'));tmp<-tempfile(tmpdir=out,fileext='.csv')
 write.csv(merged_table,tmp,row.names=FALSE,na='')
 input_values<-read(tmp);if(!identical(merged_table,input_values)){
  rownames(merged_table)<-NULL;rownames(input_values)<-NULL
  if(!identical(merged_table,input_values))stop('CSV readback mismatch: ',group_name)}
 if(!file.copy(tmp,output_path,overwrite=TRUE))stop('Cannot publish ',output_path)
 unlink(tmp);cat(basename(output_path),nrow(merged_table),'rows',ncol(merged_table),'columns\n')}
