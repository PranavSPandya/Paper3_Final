args <- commandArgs(TRUE)
root <- 'C:/Users/sanga/Desktop/Pranav Paper3_Final'
out <- if(length(args)) args[1] else file.path(root,'output/statistical_analysis/results/Jo_et_al_30sec')
p <- file.path(root,'output/merged_all_11participants_8min.csv')
d <- read.csv(p,check.names=FALSE)
d <- d[d$PhaseID %in% c('WalkG','WalkU','BikeG','BikeU'),]
d$time <- as.POSIXct(d$Datetime,format='%Y-%m-%d %H:%M:%S',tz='UTC')
stopifnot(!anyNA(d$time),!anyDuplicated(d[c('ParticipantID','PhaseID','Datetime')]))
d <- d[order(d$ParticipantID,d$PhaseID,d$time),]
d$elapsed <- as.numeric(d$time-ave(as.numeric(d$time),d$ParticipantID,d$PhaseID,FUN=min),units='secs')
d <- d[d$elapsed>=0 & d$elapsed<30,]
d$hr <- as.numeric(d$empatica_heart_rate)
counts <- aggregate(hr~ParticipantID+PhaseID,d,function(x) sum(is.finite(x)),na.action=na.pass)
names(counts)[3] <- 'valid_epochs'
means <- aggregate(hr~ParticipantID+PhaseID,d,mean,na.rm=TRUE)
res <- list(); pairs <- list()
for (mode in c('Walk','Bike')) {
 g <- means[means$PhaseID==paste0(mode,'G'),c('ParticipantID','hr')]
 u <- means[means$PhaseID==paste0(mode,'U'),c('ParticipantID','hr')]
 a <- merge(g,u,by='ParticipantID',suffixes=c('_green','_urban'))
 test <- t.test(a$hr_green,a$hr_urban,paired=TRUE,alternative='less')
 a$mode <- mode; pairs[[mode]] <- a
 res[[mode]] <- data.frame(mode=mode,outcome='heart_rate',n_pairs=nrow(a),green_mean=mean(a$hr_green),urban_mean=mean(a$hr_urban),difference=mean(a$hr_green-a$hr_urban),p_one_sided=test$p.value)
}
r <- do.call(rbind,res);r$q_FDR <- p.adjust(r$p_one_sided,'BH');r$FDR_significant <- r$q_FDR<.05
dir.create(out,recursive=TRUE,showWarnings=FALSE)
write.csv(r,file.path(out,'Jo_30sec_results.csv'),row.names=FALSE)
write.csv(do.call(rbind,pairs),file.path(out,'Jo_30sec_pairs.csv'),row.names=FALSE)
write.csv(counts,file.path(out,'Jo_30sec_valid_counts.csv'),row.names=FALSE)
writeLines(c('First 30 seconds of each phase; paired green vs urban, one-sided HR green < urban; BH across two modes.', 'Field environment comparison does not isolate sound. HRV unavailable: merged frequency-domain measures use five-minute windows, not 60 seconds.', 'First 30 seconds chosen consistently as an assumption; participant-phase means use available 10-second heart-rate values.'),file.path(out,'Jo_30sec_methods.txt'))
print(r)
