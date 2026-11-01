# Collect compact public results without refitting or recalculating p/q.
args<-commandArgs(TRUE)
option<-function(k,default){v<-args[startsWith(args,paste0('--',k,'='))];if(length(v))substring(v[1],nchar(k)+4L)else default}
.entry<-sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value=TRUE))
if(length(.entry)&&file.exists(.entry[1])){
 source(file.path(dirname(normalizePath(.entry[1], winslash='/', mustWork=FALSE)), 'library', 'Paper3_common.R'), local=FALSE)
}else if(file.exists('library/Paper3_common.R')){
 source('library/Paper3_common.R', local=FALSE)
}else if(file.exists('scripts/statistical_analysis/library/Paper3_common.R')){
 source('scripts/statistical_analysis/library/Paper3_common.R', local=FALSE)
}else{
 stop('Run with Rscript on this file or setwd to scripts/statistical_analysis', call.=FALSE)
}
root<-option('root', resolve_project_root())
input<-option('input',file.path(root,'output/statistical_analysis/results'))
out<-option('out',file.path(root,'output/merged'))
groups<-list(Analysis_combined_merged=c('Analysis_combined_phaseavg','Analysis_combined_timeseries'),
 H1_H3_H6_merged=c('H1_H3_phaseavg','H1_H3_timeseries','H6_stress_composite_phaseavg','H6_stress_composite_timeseries'),
 H4_sound_results='H4_sound_literature_tests',H5_grid_results='H5_exploratory')
read<-function(p)read.csv(p,colClasses='character',check.names=FALSE,na.strings=c('','NA','NaN'),stringsAsFactors=FALSE)
nonblank<-function(z)!is.na(z)&nzchar(z)
outputs<-list();sources<-character();hashes<-character()
for(g in names(groups)){
 parts<-list()
 for(folder in groups[[g]]){
  d<-file.path(input,folder);if(!dir.exists(d))stop('Missing source directory: ',d)
  for(p in sort(list.files(d,'[.]csv$',full.names=TRUE))){
   x<-read(p);if(!'p_value'%in%names(x))next
   required<-c('script_name','source_table','q_value','FDR_significant')
   if(!all(required%in%names(x)))stop('Source needs current compact export finalizer: ',p)
   if(anyDuplicated(names(x)))stop('Duplicate source column: ',p)
   forbidden<-grep('equation|^p_value_adjusted|^significant_adjusted$|^term$|^statistic_type$',names(x),value=TRUE)
   if(length(forbidden))stop('Noncompact source columns: ',paste(forbidden,collapse=', '))
   q<-suppressWarnings(as.numeric(x$q_value));valid<-nonblank(x$q_value)
   if(any(valid&(!is.finite(q)|q<0|q>1)))stop('Invalid q in ',p)
   flag<-toupper(x$FDR_significant)
   if(any(valid & (is.na(flag)|flag!=ifelse(q<.05,'TRUE','FALSE')),na.rm=TRUE))stop('FDR flag mismatch: ',p)
   if(any(!nonblank(x$script_name)))stop('Missing script provenance: ',p)
   parts[[length(parts)+1L]]<-x;sources<-c(sources,p);hashes<-c(hashes,unname(tools::md5sum(p)))
  }
 }
 if(!length(parts))stop('No statistical tables for ',g)
 cols<-unique(unlist(lapply(parts,names)))
 parts<-lapply(parts,function(x){for(k in setdiff(cols,names(x)))x[[k]]<-NA_character_;x[cols]})
 y<-do.call(rbind,parts);y<-y[vapply(y,function(z)any(nonblank(z)),logical(1))]
 outputs[[g]]<-y
}
if(!identical(hashes,unname(tools::md5sum(sources))))stop('Source files changed during collection')
dir.create(out,recursive=TRUE,showWarnings=FALSE)
recognized<-paste0(names(groups),'.csv')
extra<-setdiff(list.files(out),recognized);if(length(extra))stop('Unexpected files in merge destination: ',paste(extra,collapse=', '))
for(g in names(outputs)){
 y<-outputs[[g]];p<-file.path(out,paste0(g,'.csv'));tmp<-tempfile(tmpdir=out,fileext='.csv')
 write.csv(y,tmp,row.names=FALSE,na='')
 z<-read(tmp);if(!identical(y,z)){
  rownames(y)<-NULL;rownames(z)<-NULL
  if(!identical(y,z))stop('CSV readback mismatch: ',g)
 }
 if(!file.copy(tmp,p,overwrite=TRUE))stop('Cannot publish ',p)
 unlink(tmp);cat(basename(p),nrow(y),'rows',ncol(y),'columns\n')
}
