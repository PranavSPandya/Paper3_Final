suppressPackageStartupMessages(library(nlme))
args <- commandArgs(trailingOnly=TRUE)
cov <- Sys.getenv('PAPER3_CASESTUDY_COVARIATE', unset = 'fitness')
if (!cov %in% c('fitness', 'activeness')) stop('PAPER3_CASESTUDY_COVARIATE must be fitness or activeness.')
find_root <- function() {
  script_arg <- sub('^--file=', '', grep('^--file=', commandArgs(FALSE), value = TRUE))
  pos <- if (length(script_arg)) dirname(normalizePath(script_arg[1], winslash = '/', mustWork = FALSE)) else normalizePath(getwd(), winslash = '/', mustWork = TRUE)
  for (i in 1:6) {
    if (file.exists(file.path(pos, 'output', 'merged_all_11participants_8min.csv'))) return(pos)
    nxt <- dirname(pos)
    if (nxt == pos) break
    pos <- nxt
  }
  stop('Cannot locate Paper3 project root.')
}
root <- find_root()
input <- if(length(args)>=1) args[1] else file.path(root, 'output', 'statistical_analysis', 'results_casestudy', cov, 'H5_exploratory', 'H5_hotspot_day.csv')
out <- if(length(args)>=2) args[2] else file.path(root, 'output', 'statistical_analysis', 'results_casestudy', cov, 'H5_exploratory_svfclasses')
dir.create(out, recursive=TRUE, showWarnings=FALSE)
if (!file.exists(input)) stop('H5 hotspot-day file is not ready: ', input)
d <- read.csv(input, stringsAsFactors=FALSE, check.names=FALSE)
lab <- read.csv(file.path(root, 'output', 'statistical_analysis', 'Participant Casestudy', 'Participant_fitness_activeness.csv'), stringsAsFactors=FALSE, check.names=FALSE)
lv <- if (cov == 'fitness') c('Not Fit', 'Fit') else c('Inactive', 'Active')
cn <- if (cov == 'fitness') 'Fit_vs_NotFit' else 'Active_vs_Inactive'
d[[cov]] <- factor(lab[[cov]][match(d$ParticipantID, lab$ParticipantID)], levels = lv)
if (anyNA(d[[cov]])) stop('Case-study label missing for a hotspot-day participant.')
contrasts(d[[cov]]) <- contr.treatment(lv)
colnames(contrasts(d[[cov]])) <- cn
required <- c('ParticipantID','PhaseID','hotspot_id','route_bin','median_ucm_UTCI','median_SVF','median_TVF','median_BVF')
stopifnot(all(required %in% names(d)))
for (v in c('route_bin','median_ucm_UTCI','median_SVF','median_TVF','median_BVF')) d[[v]] <- as.numeric(d[[v]])
# Site composition is a cross-visit hotspot median, not a participant-specific view.
site <- aggregate(d[c('median_SVF','median_TVF','median_BVF')], list(hotspot_id=d$hotspot_id, PhaseID=d$PhaseID), function(x) if(all(!is.finite(x))) NA_real_ else median(x,na.rm=TRUE))
sv <- as.matrix(site[c('median_SVF','median_TVF','median_BVF')]); cls <- rep(NA_character_, nrow(site))
for (i in seq_len(nrow(site))) {
 x <- sv[i,]; if(any(!is.finite(x)) || any(x<0) || sum(x)<=0) next
 ord <- order(x,decreasing=TRUE); z <- x[ord]; lab <- c('S','T','B')[ord]
 cls[i] <- if(z[1]>=2*z[2]) lab[1] else if(z[2]>=2*z[3]) paste(sort(lab[1:2]),collapse='') else 'A'
}
site$class <- cls
names(site)[3:5] <- c('site_SVF','site_TVF','site_BVF')
d <- merge(d, site, by=c('hotspot_id','PhaseID'), all.x=TRUE, sort=FALSE)
write.csv(site, file.path(out,'H5_site_view_classes.csv'), row.names=FALSE, na='')
coverage <- do.call(rbind,lapply(split(d,interaction(d$PhaseID,d$class,drop=TRUE)),function(x) data.frame(phase=x$PhaseID[1],class=x$class[1],rows=nrow(x),participants=length(unique(x$ParticipantID)),hotspots=length(unique(x$hotspot_id)))))
write.csv(coverage,file.path(out,'H5_class_coverage.csv'),row.names=FALSE)
corr <- do.call(rbind,lapply(split(site,site$PhaseID),function(x) {m<-cor(x[c('site_SVF','site_TVF','site_BVF')],use='pairwise.complete.obs'); data.frame(phase=x$PhaseID[1], factor=rownames(m),m,row.names=NULL)}))
write.csv(corr,file.path(out,'H5_site_factor_correlations.csv'),row.names=FALSE,na='')
outcomes <- grep('^median_center_', names(d), value=TRUE)
res <- list(); comp <- list(); skipped <- list()
addskip <- function(ph,oc,mod,reason) {skipped[[length(skipped)+1L]] <<- data.frame(phase=ph,outcome=oc,model=mod,reason=as.character(reason))}
fit <- function(form, dat) lme(form, random=~1|ParticipantID, correlation=corAR1(form=~route_bin|ParticipantID),data=dat,method='ML',na.action=na.fail, control=lmeControl(maxIter=100,msMaxIter=100,returnObject=FALSE))
for (ph in unique(d$PhaseID)) for (oc in outcomes) for (kind in c('SVF','TVF','BVF','class')) {
 x <- d[d$PhaseID==ph,,drop=FALSE]; v <- if(kind=='class') 'class' else paste0('site_',kind)
 x <- x[is.finite(x[[oc]]) & is.finite(x$median_ucm_UTCI) & is.finite(x$route_bin) & !is.na(x[[v]]),,drop=FALSE]
 if(kind!='class') x <- x[is.finite(x[[v]]),,drop=FALSE]
 x <- x[order(x$ParticipantID,x$route_bin),,drop=FALSE]
 if(nrow(x)<30 || length(unique(x$ParticipantID))<6 || length(unique(x$hotspot_id))<5) {addskip(ph,oc,kind,'insufficient observations, participants or hotspots');next}
 if(any(duplicated(x[c('ParticipantID','route_bin')]))) {addskip(ph,oc,kind,'duplicate participant route position');next}
 x$y <- x[[oc]]; x$utci <- x$median_ucm_UTCI-mean(x$median_ucm_UTCI)
 if(kind=='class') {
  tab <- table(x$class, x$hotspot_id)>0; nsites <- rowSums(tab); eligible <- names(nsites)[nsites>=3]; x <- x[x$class %in% eligible,,drop=FALSE]; x$class <- droplevels(factor(x$class))
  if(nlevels(x$class)<2 || nrow(x)<30 || length(unique(x$ParticipantID))<6) {addskip(ph,oc,kind,'fewer than two classes with at least three hotspots');next}
  x$exposure <- x$class
 } else {
  x$exposure <- x[[v]]*10 # effect per 0.1 unit
  if(sd(x$exposure)<1e-8) {addskip(ph,oc,kind,'no factor variation');next}
 }
 base <- tryCatch(fit(as.formula(paste('y ~ utci +', cov)),x),error=function(e)e)
 full <- tryCatch(fit(as.formula(paste('y ~ utci +', cov, '+ exposure')),x),error=function(e)e)
 if(inherits(base,'error') || inherits(full,'error')) {addskip(ph,oc,kind,paste(if(inherits(base,'error')) conditionMessage(base) else '',if(inherits(full,'error')) conditionMessage(full) else ''));next}
 tt<-summary(full)$tTable; b<-summary(base)$tTable
 lrt<-tryCatch(anova(base,full),error=function(e)NULL)
 lrp<-if(!is.null(lrt)) as.numeric(lrt$`p-value`[2]) else NA_real_
 for(term in rownames(tt)) res[[length(res)+1L]] <- data.frame(phase=ph,outcome=sub('^median_center_','',oc),model=kind,term=term,estimate=tt[term,'Value'],se=tt[term,'Std.Error'],df=tt[term,'DF'],p=tt[term,'p-value'],ci_low=tt[term,'Value']-qt(.975,tt[term,'DF'])*tt[term,'Std.Error'],ci_high=tt[term,'Value']+qt(.975,tt[term,'DF'])*tt[term,'Std.Error'],n=nrow(x),participants=length(unique(x$ParticipantID)),hotspots=length(unique(x$hotspot_id)),class_reference=if(kind=='class') levels(x$class)[1] else NA_character_,ar1=as.numeric(coef(full$modelStruct$corStruct,unconstrained=FALSE)))
 comp[[length(comp)+1L]] <- data.frame(phase=ph,outcome=sub('^median_center_','',oc),model=kind,n=nrow(x),participants=length(unique(x$ParticipantID)),hotspots=length(unique(x$hotspot_id)),utci_before=b['utci','Value'],utci_after=tt['utci','Value'],aic_baseline=AIC(base),aic_view=AIC(full),lrt_p=lrp)
}
if(length(res)) {r<-do.call(rbind,res); r$fdr_q<-NA_real_; ix<-r$model!='class' & r$term=='exposure' & is.finite(r$p); r$fdr_q[ix]<-p.adjust(r$p[ix],method='BH'); r$fdr_significant<-!is.na(r$fdr_q)&r$fdr_q<.05; write.csv(r,file.path(out,'H5_view_model_coefficients.csv'),row.names=FALSE,na='')}
if(length(comp)) {cc<-do.call(rbind,comp); cc$class_omnibus_fdr_q<-NA_real_; ix<-cc$model=='class'&is.finite(cc$lrt_p); cc$class_omnibus_fdr_q[ix]<-p.adjust(cc$lrt_p[ix],method='BH'); write.csv(cc,file.path(out,'H5_view_model_comparisons.csv'),row.names=FALSE,na='')}
if(length(skipped)) write.csv(do.call(rbind,skipped),file.path(out,'H5_skipped_models.csv'),row.names=FALSE,na='')
writeLines(c('Exploratory H5 urban-form adaptation, using the previously generated H5 hotspot-day data.','Class labels use Gong et al. 2019 dominance ratios applied to upward camera view factors; this is an adaptation, not a validated thermal threshold.','Each site factor is the median across visits to the same hotspot; separate models for SVF, TVF and BVF avoid assuming independent compositional factors.','Per phase and outcome: participant-centered response ~ UTCI + one site view factor OR class; random participant intercept and AR1 correlation along route positions. No hotspot fixed effects: site form and fixed hotspot indicators are not separately identifiable when site form is constant within hotspot.','Class comparisons include only classes represented by >=3 hotspots; reference class alphabetically first, not a healthy or optimal baseline.','Coefficients for continuous view factors correspond to a 0.1 increase in factor (10 percentage points if factors are 0-1).','FDR for all continuous exposure tests across outcomes, phases and factors; separate FDR family for class omnibus likelihood-ratio tests. Class individual p values are unadjusted, descriptive only.','Model-based uncertainty does not fully account for spatial correlation between adjacent hotspots, systematic phase/route/time confounding, 11 participants, measurement error, or uncertainty in site estimates; significance is exploratory and not evidence of causality.','Input: H5_exploratory/H5_hotspot_day.csv, which is a cached prior H5 run; refresh original data preparation first if inputs have changed.','AIC comparisons have identical rows within each model pair, baseline is UTCI-only with the same AR1 and participant structure; not a comparison against the hotspot fixed-effect model.','Input MD5:',unname(tools::md5sum(input))),file.path(out,'README.txt'))
cat('Completed:',out,'\n'); cat('Fits:',length(comp),'skips:',length(skipped),'\n')
write('ST in class labels is the same sky-tree pairing labelled TS in Gong; alphabetical ordering is used in this output.',file=file.path(out,'README.txt'),append=TRUE)
write('Some phase-specific ranges are much smaller than 0.1 (notably green-route building view); corresponding 0.1-unit coefficients extrapolate beyond observed support. Compare effects over actual observed ranges instead.',file=file.path(out,'README.txt'),append=TRUE)
write('Pupil outcomes may reflect illumination and eye-tracker conditions; UTCI adjustment does not adjust for light or establish a stress response.',file=file.path(out,'README.txt'),append=TRUE)
