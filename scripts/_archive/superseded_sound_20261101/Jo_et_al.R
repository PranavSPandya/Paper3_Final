# Jo et al. (2019), doi:10.3390/ijerph16152649: paired physiological comparison.
# Field-data adaptation: Green vs Urban within Walk and Bike, not isolated sound playback.
# Run: Rscript Jo_et_al.R --root="C:/path/to/Paper3_Final" --out="C:/path/to/results/Jo_et_al"
# Only comparable measured endpoints: native HR, ln(HF), ln(LF/HF).
# Directional hypotheses follow the paper; these are retrospective sensitivity tests.
# The paper used 60-s playback; retain full 8-min phases and valid 5-min HRV windows here.
# No UTCI restriction, regression covariates, or mixed model. Inputs are read-only.

args <- commandArgs(TRUE)
option <- function(key, default) {
  z <- args[startsWith(args, paste0('--', key, '='))]
  if (length(z)) sub(paste0('^--',key,'='), '', z[1]) else default
}
root <- option('root', Sys.getenv('PAPER3_ROOT', 'C:/Users/sanga/Desktop/Pranav Paper3_Final'))
out <- option('out', file.path(root,'output/statistical_analysis/results/Jo_et_al'))
input <- file.path(root,'output/merged_all_11participants_8min.csv')
stopifnot(file.exists(input))
hash_before <- unname(tools::md5sum(input))
raw <- read.csv(input,check.names=FALSE,stringsAsFactors=FALSE)
participants <- paste0('P',c(4,8,9,10,11,12,13,14,15,16,17))
phases <- c('WalkG','WalkU','BikeG','BikeU')
spec <- data.frame(outcome=c('empatica_heart_rate','empatica_hrv_fd_hf','empatica_hrv_fd_lf_hf_ratio'),
  label=c('Heart rate','ln(HF)','ln(LF/HF)'),
  transformation=c('Native','Natural log','Natural log'),
  alternative=c('less','greater','less'),stringsAsFactors=FALSE)
required <- c('ParticipantID','PhaseID','Datetime','empatica_hrv_fd_5min_available',spec$outcome)
stopifnot(all(required %in% names(raw)))
d <- raw[raw$ParticipantID %in% participants & raw$PhaseID %in% phases,required]
stopifnot(!anyDuplicated(d[c('ParticipantID','PhaseID','Datetime')]))
stopifnot(setequal(unique(d$ParticipantID),participants))
coverage <- as.data.frame(table(d$ParticipantID,d$PhaseID))
names(coverage) <- c('ParticipantID','PhaseID','n_epochs')
stopifnot(nrow(coverage)==44L,all(coverage$n_epochs==48L))
available <- tolower(as.character(d$empatica_hrv_fd_5min_available)) %in% c('1','true')
cells <- list(); k <- 0L
for (j in seq_len(nrow(spec))) {
  v <- suppressWarnings(as.numeric(d[[spec$outcome[j]]]))
  v[!is.finite(v)] <- NA_real_
  if (spec$transformation[j]=='Natural log') {
    v[!available | is.na(v) | v<=0] <- NA_real_
    v <- log(v)
  }
  for (pid in participants) for (phase in phases) {
    ix <- d$ParticipantID==pid & d$PhaseID==phase
    z <- v[ix]; n <- sum(is.finite(z)); k <- k+1L
    cells[[k]] <- data.frame(ParticipantID=pid,PhaseID=phase,outcome=spec$outcome[j],
      label=spec$label[j],transformation=spec$transformation[j],valid_epochs=n,
      phase_mean=if(n) mean(z,na.rm=TRUE) else NA_real_)
  }
}
cells <- do.call(rbind,cells)
results <- list(); pairs <- list(); k <- 0L
for(mode in c('Walk','Bike')) for(j in seq_len(nrow(spec))) {
  z <- cells[cells$outcome==spec$outcome[j],]
  g <- z[z$PhaseID==paste0(mode,'G'),c('ParticipantID','phase_mean','valid_epochs')]
  u <- z[z$PhaseID==paste0(mode,'U'),c('ParticipantID','phase_mean','valid_epochs')]
  a <- merge(g,u,by='ParticipantID',suffixes=c('_green','_urban'))
  a <- a[is.finite(a$phase_mean_green)&is.finite(a$phase_mean_urban),]
  stopifnot(nrow(a)>=3)
  delta <- a$phase_mean_green-a$phase_mean_urban
  stopifnot(sd(delta)>0)
  one <- t.test(a$phase_mean_green,a$phase_mean_urban,paired=TRUE,alternative=spec$alternative[j])
  two <- t.test(a$phase_mean_green,a$phase_mean_urban,paired=TRUE,alternative='two.sided')
  k <- k+1L
  results[[k]] <- data.frame(mode=mode,outcome=spec$outcome[j],label=spec$label[j],
    alternative=spec$alternative[j],n_pairs=nrow(a),green_mean=mean(a$phase_mean_green),
    urban_mean=mean(a$phase_mean_urban),green_minus_urban=mean(delta),
    ci95_two_sided_lower=two$conf.int[1],ci95_two_sided_upper=two$conf.int[2],
    t=unname(one$statistic),df=unname(one$parameter),p_Jo_one_sided=one$p.value,
    significant_Jo_p_lt05=one$p.value<.05,p_two_sided=two$p.value,
    paired_dz=mean(delta)/sd(delta),difference_shapiro_p=shapiro.test(delta)$p.value)
  a$mode <- mode; a$outcome <- spec$outcome[j]; a$difference <- delta
  pairs[[k]] <- a
}
r <- do.call(rbind,results)
# Added transparency: one common BH family for ALL six directional comparisons.
# This column is additional to Jo's method, not a claim that Jo used FDR.
r$q_FDR <- p.adjust(r$p_Jo_one_sided,'BH',n=6)
r$FDR_significant <- r$q_FDR<.05
stopifnot(identical(hash_before,unname(tools::md5sum(input))))
dir.create(out,recursive=TRUE,showWarnings=FALSE)
write.csv(r,file.path(out,'Jo_paired_results.csv'),row.names=FALSE)
write.csv(cells,file.path(out,'Jo_participant_phase_means.csv'),row.names=FALSE)
write.csv(do.call(rbind,pairs),file.path(out,'Jo_paired_participant_values.csv'),row.names=FALSE)
write.csv(coverage,file.path(out,'Jo_phase_coverage.csv'),row.names=FALSE)
pdf(file.path(out,'Jo_paired_plots.pdf'),width=10,height=7)
par(mfrow=c(2,3),mar=c(4,4,3,1))
for(i in seq_len(nrow(r))) {
  a <- pairs[[i]]; y <- cbind(a$phase_mean_urban,a$phase_mean_green)
  matplot(1:2,t(y),type='b',lty=1,pch=16,col=adjustcolor('steelblue',alpha.f=.5),
    xaxt='n',xlab='',ylab=r$label[i],main=paste(r$mode[i],r$label[i]))
  axis(1,1:2,c('Urban','Green'))
  lines(1:2,colMeans(y),lwd=3,col='black',type='b',pch=18)
}
invisible(dev.off())
writeLines(c('# Jo et al. paired-test adaptation',
  'Reference: https://doi.org/10.3390/ijerph16152649',
  'Question: Within each travel mode, does physiology differ between Green and Urban?',
  'Paired t-tests: HR Green < Urban; ln(HF) Green > Urban; ln(LF/HF) Green < Urban.',
  'Jo-style decision: one-sided p < 0.05. q_FDR is an ADDED correction across six tests.',
  'Analysis unit: one participant-phase average; epochs are not independent participants.',
  'Log HRV before averaging; exclude invalid frequency-domain windows and nonpositive values.',
  'Adaptations: full 8-min field phases, two modes, wearable-derived HRV and 11 participants;',
  'Jo used 60-s controlled headphone playback, ECG-derived HRV and 29 female participants.',
  'Oxyhemoglobin and respiratory frequency are not replicated: matching measures unavailable here.',
  'No matched pre-stimulus baseline comparison is attempted.',
  'No UTCI restriction and no sound-proportion predictor. Green/Urban are environment labels.',
  'These comparisons cannot isolate sound from other environmental differences and overlap H1.',
  'Directions were taken from the literature after this dataset was examined: retrospective sensitivity.',
  paste('Input:',normalizePath(input,winslash='/')),paste('Input MD5:',hash_before),
  paste('Jo p<.05:',sum(r$significant_Jo_p_lt05),'of 6; added FDR q<.05:',sum(r$FDR_significant),'of 6')),
  file.path(out,'Jo_methods_and_interpretation.md'))
writeLines(capture.output(sessionInfo()),file.path(out,'Jo_sessionInfo.txt'))
print(r[,c('mode','label','n_pairs','green_minus_urban','p_Jo_one_sided','q_FDR')],row.names=FALSE)
cat('Saved:',normalizePath(out,winslash='/'),'\n')
