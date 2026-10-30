# Paper 3 H6.1–H6.3: focused exploratory analyses
# Run from any directory: Rscript <project>/scripts/statistical_analysis/H6_exploratory.R
# Optional explicit folder: Rscript scripts/H6_exploratory.R --h5-dir="D:/.../H5_results"
# Requires base R only. NEVER overwrites H5 outputs.
# Uses the matched input and the existing H4/H5 LYS1/LYS2 mean definition.

options(stringsAsFactors = FALSE)
phases <- c('BikeU','WalkU','BikeG','WalkG')
arg <- commandArgs(trailingOnly = TRUE)
root_arg <- sub('^--root=', '', grep('^--root=', arg, value = TRUE))
h5_arg <- sub('^--h5-dir=', '', grep('^--h5-dir=', arg, value = TRUE))
find_root <- function() {
  if (length(root_arg)) return(normalizePath(root_arg[1], mustWork = TRUE))
  script_arg <- grep('^--file=', commandArgs(), value = TRUE)
  pos <- if (length(script_arg)) dirname(normalizePath(sub('^--file=', '', script_arg[1]), mustWork = TRUE)) else normalizePath(getwd(), mustWork = TRUE)
  for (i in 1:5) {
    if (file.exists(file.path(pos, 'output', 'merged_all_11participants_8min.csv'))) return(pos)
    nextpos <- dirname(pos)
    if (nextpos == pos) break
    pos <- nextpos
  }
  stop('Cannot locate Paper3_Final/output/merged_all_11participants_8min.csv. Use --root=...')
}
root <- find_root()
source(file.path(root, 'scripts', 'statistical_analysis', 'library', 'Paper3_common.R'), local = FALSE)
participants <- paper3_exploratory_group_participant_ids('activeness', 'inactive', project_root = root)
input <- file.path(root, 'output', 'merged_all_11participants_8min.csv')
# Detect the existing H5 output location rather than inventing it.
if (length(h5_arg)) {
  out <- normalizePath(h5_arg[1], mustWork = TRUE)
} else {
  out <- file.path(root, 'output', 'statistical_analysis', 'results', 'H6_exploratory_grouped_by_activeness_inactive')
  dir.create(out, recursive=TRUE, showWarnings=FALSE)
}
if (!dir.exists(out)) stop('H5 output directory does not exist: ', out)
cat('Input:', input, '\nH5 output directory:', out, '\n')

# Read only required columns from the wide matched CSV.
needed <- c('ParticipantID','PhaseID','Datetime',
  'questionnaire_prs11_total_mean_1_5','questionnaire_pleasantness_1_5',
  'eyetracker_fixation_rate','eyetracker_fixation_duration_s',
  'eyetracker_pupil_diameter_avg','empatica_eda_tonic', 'empatica_eda_phasic',
  'empatica_skin_temperature','atmo_lys_LYS1__lys_lux','atmo_lys_LYS2__lys_lux','ucm_MRT','ucm_UTCI',
  'ucm_SND_dBA','vehicle_proportion','rural_natural_proportion')
header <- names(read.csv(input, nrows = 0, check.names = FALSE))
missing <- setdiff(needed, header)
if (length(missing)) stop('Absent required input columns: ', paste(missing, collapse = ', '))
cls <- ifelse(header %in% needed, 'character', 'NULL')
raw <- read.csv(input, check.names = FALSE, colClasses = cls, na.strings = c('','NA','NaN','null'))
for (nm in intersect(needed[-(1:3)], names(raw))) raw[[nm]] <- suppressWarnings(as.numeric(raw[[nm]]))
# Match H4/H5: mean of available LYS1/LYS2 readings; both missing stays NA.
raw$lys_lux_avg <- rowMeans(raw[, c('atmo_lys_LYS1__lys_lux','atmo_lys_LYS2__lys_lux')], na.rm = TRUE)
raw$lys_lux_avg[!is.finite(raw$lys_lux_avg)] <- NA_real_
check <- c('ParticipantID','PhaseID','Datetime')
if (!all(check %in% names(raw))) stop('Missing essential key columns: ', paste(setdiff(check,names(raw)), collapse=', '))
d <- raw[raw$ParticipantID %in% participants & raw$PhaseID %in% phases, , drop=FALSE]
d$Datetime <- as.POSIXct(d$Datetime, tz = 'UTC', tryFormats = c('%Y-%m-%d %H:%M:%OS','%Y-%m-%dT%H:%M:%OS','%Y-%m-%d %H:%M:%OS%z','%Y-%m-%dT%H:%M:%OS%z'))
if (nrow(d) == 0L || anyNA(d$Datetime)) stop('Empty core routes or unparseable Datetime; verify time format.')
d <- d[order(d$ParticipantID,d$PhaseID,d$Datetime), , drop=FALSE]
if (anyDuplicated(d[,c('ParticipantID','PhaseID','Datetime')])) stop('Duplicate participant/phase/time keys.')
if (length(unique(d$ParticipantID)) != 11L) warning('The matched core input does not contain all 11 participants.')
key <- interaction(d$ParticipantID, d$PhaseID, drop=TRUE)
groups <- split(d, key, drop=TRUE)
if (any(vapply(groups,function(x) as.numeric(max(x$Datetime)-min(x$Datetime),units='secs') > 480.01,logical(1)))) stop('Data exceed first matched 8 minutes.')

num_cols <- setdiff(names(d), c('ParticipantID','PhaseID','Datetime'))
get_value <- function(v, name) if (name %in% names(v)) v[[name]] else rep(NA_real_, nrow(v))
finite_mean <- function(x) if (any(is.finite(x))) mean(x[is.finite(x)]) else NA_real_
questionnaire <- c('questionnaire_prs11_total_mean_1_5','questionnaire_pleasantness_1_5')
phase_fields <- c(questionnaire,'eyetracker_fixation_rate','eyetracker_fixation_duration_s','empatica_eda_tonic')
phase_rows <- lapply(groups, function(x) {
  outrow <- data.frame(ParticipantID=x$ParticipantID[1],PhaseID=x$PhaseID[1],n_epochs=nrow(x))
  for (v in phase_fields) {
    a <- get_value(x,v)
    if (v %in% questionnaire) {
      u <- unique(a[is.finite(a)])
      if (length(u) > 1L && diff(range(u)) > 1e-6) stop('Questionnaire varies within a participant-phase: ', v, ' ',x$ParticipantID[1],' ',x$PhaseID[1])
      outrow[[v]] <- if(length(u)) u[1] else NA_real_
    } else outrow[[v]] <- finite_mean(a)
  }
  outrow
})
phase_df <- do.call(rbind,phase_rows)
write.csv(phase_df,file.path(out,'H6_phase_means_grouped_by_activeness_inactive.csv'),row.names=FALSE)

# Exact, participant-based sign-flip inference (the unit is a participant, not an epoch).
signflip <- function(values,min_n=6L) {
  v <- values[is.finite(values)]; n <- length(v)
  blank <- data.frame(N=n,estimate=NA_real_,ci_low=NA_real_,ci_high=NA_real_,p=NA_real_,sd_paired=NA_real_,fraction_positive=NA_real_)
  if (n < min_n || sd(v) < 1e-12) return(blank)
  p <- 0
  for (k in 0:(2^n-1L)) {
    signs <- 2*as.integer(intToBits(k))[seq_len(n)] - 1
    p <- p + (abs(mean(v*signs)) >= abs(mean(v)) - 1e-12)
  }
  q <- qt(.975,n-1L)*sd(v)/sqrt(n)
  data.frame(N=n,estimate=mean(v),ci_low=mean(v)-q,ci_high=mean(v)+q,p=p/(2^n),sd_paired=sd(v),fraction_positive=mean(v>0))
}
add_fdr <- function(z,col='p',dest='q') {
  if (nrow(z)) {z[[dest]] <- NA_real_; ok <- is.finite(z[[col]]);z[[dest]][ok] <- p.adjust(z[[col]][ok],method='BH')}
  z
}

# ---- H6.1 Restoration–visual-search/autonomic dissociation ----------------
h61_measures <- c('questionnaire_prs11_total_mean_1_5','eyetracker_fixation_rate',
                  'eyetracker_fixation_duration_s','empatica_eda_tonic')
paired_differences <- list(); contrasts <- list(); correlations <- list()
for (mode in c('Bike','Walk')) {
  U <- phase_df[phase_df$PhaseID == paste0(mode,'U'),]
  G <- phase_df[phase_df$PhaseID == paste0(mode,'G'),]
  p <- merge(U,G,by='ParticipantID',suffixes=c('_U','_G'))
  deltas <- data.frame(ParticipantID=p$ParticipantID,Mode=mode)
  for (v in h61_measures) {
    deltas[[paste0('delta_',v)]] <- p[[paste0(v,'_G')]] - p[[paste0(v,'_U')]]
    val <- signflip(deltas[[paste0('delta_',v)]])
    val$Mode <- mode;val$Outcome <- v
    contrasts[[length(contrasts)+1L]] <- val
  }
  paired_differences[[length(paired_differences)+1L]] <- deltas
  for (v in setdiff(h61_measures,h61_measures[1])) {
    a <- deltas[[paste0('delta_',h61_measures[1])]]
    b <- deltas[[paste0('delta_',v)]]
    ok <- is.finite(a)&is.finite(b);n <- sum(ok)
    rho <- pval <- NA_real_
    if(n >= 7L && sd(a[ok]) > 0 && sd(b[ok]) > 0) {
      z <- suppressWarnings(cor.test(a[ok],b[ok],method='spearman',exact=FALSE))
      rho <- unname(z$estimate);pval <- z$p.value
    }
    correlations[[length(correlations)+1L]] <- data.frame(Mode=mode,Psych='delta_PRS',Outcome=paste0('delta_',v),N=n,rho=rho,p=pval)
  }
}
h61 <- add_fdr(do.call(rbind,contrasts))
h61_cor <- add_fdr(do.call(rbind,correlations))
write.csv(do.call(rbind,paired_differences),file.path(out,'H6_1_participant_deltas_grouped_by_activeness_inactive.csv'),row.names=FALSE)
write.csv(h61,file.path(out,'H6_1_green_urban_contrasts_grouped_by_activeness_inactive.csv'),row.names=FALSE)
write.csv(h61_cor,file.path(out,'H6_1_restoration_concordance_grouped_by_activeness_inactive.csv'),row.names=FALSE)

# ---- H6.2 Lag profiles of differenced signals: not causal estimates -------
# A response at t is linked to change in exposure ending at t - lag.
# Only exact 10-second predecessors within each participant/phase are matched.
pairs <- list(c('lys_lux_avg','eyetracker_pupil_diameter_avg'),
              c('ucm_MRT','empatica_skin_temperature'),
              c('ucm_SND_dBA','empatica_eda_phasic'))
lags <- c(0L,10L,30L,60L)
lag_subject <- list(); lag_results <- list()
for (pair in pairs) {
  exposure <- pair[1]; outcome <- pair[2]
  if (!all(pair %in% names(d))) {
    warning('H6.2 skipped missing pair: ',paste(pair,collapse=' / '));next
  }
  for (lag in lags) {
    obs <- list()
    for (x in groups) {
      sec <- as.numeric(difftime(x$Datetime,x$Datetime[1],units='secs'))
      step <- as.integer(round(sec/10))
      if (any(abs(sec-10*step)>1.2) || anyDuplicated(step)) stop('Unexpected time-grid mismatch: ',x$ParticipantID[1],'/ ',x$PhaseID[1])
      ids_y_prev <- match(step-1L,step)
      ids_x <- match(step-as.integer(lag/10),step)
      ids_x_prev <- match(step-as.integer(lag/10)-1L,step)
      Y <- x[[outcome]]; X <- x[[exposure]]
      dy <- Y - Y[ids_y_prev]
      dx <- X[ids_x] - X[ids_x_prev]
      ok <- is.finite(dy)&is.finite(dx)
      if (sum(ok)) obs[[length(obs)+1L]] <- data.frame(ParticipantID=x$ParticipantID[1],dy=dy[ok],dx=dx[ok])
    }
    if (!length(obs)) next
    allobs <- do.call(rbind,obs)
    zs <- numeric();rows <- list()
    for (id in unique(allobs$ParticipantID)) {
      sub <- allobs[allobs$ParticipantID==id,]
      rv <- if(nrow(sub)>=20L && sd(sub$dx)>1e-10 && sd(sub$dy)>1e-10) cor(sub$dx,sub$dy) else NA_real_
      rows[[length(rows)+1L]] <- data.frame(Exposure=exposure,Outcome=outcome,Lag_s=lag,ParticipantID=id,N_10s_changes=nrow(sub),r=rv)
    }
    b <- do.call(rbind,rows);lag_subject[[length(lag_subject)+1L]] <- b
    z <- atanh(pmax(-.999,pmin(.999,b$r[is.finite(b$r)])))
    t <- signflip(z)
    lag_results[[length(lag_results)+1L]] <- data.frame(Exposure=exposure,Outcome=outcome,Lag_s=lag,
      N_Participants=t$N,mean_r=if(is.finite(t$estimate)) tanh(t$estimate) else NA_real_,
      ci_low=if(is.finite(t$ci_low)) tanh(t$ci_low) else NA_real_,
      ci_high=if(is.finite(t$ci_high)) tanh(t$ci_high) else NA_real_,p=t$p,
      N_Changes=sum(b$N_10s_changes[is.finite(b$r)]))
  }
}
h62 <- if(length(lag_results)) add_fdr(do.call(rbind,lag_results)) else data.frame()
h62_subject <- if(length(lag_subject)) do.call(rbind,lag_subject) else data.frame()
write.csv(h62,file.path(out,'H6_2_lag_profiles_grouped_by_activeness_inactive.csv'),row.names=FALSE)
write.csv(h62_subject,file.path(out,'H6_2_participant_correlations_grouped_by_activeness_inactive.csv'),row.names=FALSE)

# ---- H6.3 Acoustic composition conditional on loudness/heat/light --------
# Separate within-bout regressions PER PARTICIPANT; test slopes across people.
# This avoids treating 10-second windows as independent participants.
source_terms <- c('vehicle_proportion','rural_natural_proportion')
source_outcomes <- c('empatica_eda_tonic','eyetracker_fixation_rate')
source_subject <- list(); source_results <- list()
for (source in source_terms) for (outcome in source_outcomes) {
  predictors <- c(source,'ucm_SND_dBA','ucm_UTCI','lys_lux_avg')
  if (!all(c(predictors,outcome) %in% names(d))) {
    warning('H6.3 skipped missing term/outcome: ', source, '/', outcome);next
  }
  tmp_results <- list()
  for (id in participants) {
    a <- d[d$ParticipantID==id,c('ParticipantID','PhaseID',predictors,outcome),drop=FALSE]
    a <- a[complete.cases(a),,drop=FALSE]
    if(nrow(a)<60L || length(unique(a$PhaseID)) < 2L) next
    rename <- c('source','dba','utci','lux','y')
    names(a)[match(c(predictors,outcome),names(a))] <- rename
    for (nm in rename) {
      a[[nm]] <- a[[nm]] - ave(a[[nm]],a$PhaseID,FUN=mean)
      s <- sd(a[[nm]])
      if (is.finite(s) && s > 1e-10) a[[nm]] <- a[[nm]] / s else a[[nm]] <- NA_real_
    }
    a <- a[complete.cases(a),,drop=FALSE]
    if(nrow(a)<60L) next
    f <- lm(y ~ source + dba + utci + lux,data=a)
    if (f$rank != 5L) next
    aux <- lm(source ~ dba + utci + lux,data=a)
    vif <- 1/(1-summary(aux)$r.squared)
    if (!is.finite(vif) || vif >= 5) next
    b <- unname(coef(f)['source'])
    if (!is.finite(b)) next
    tmp_results[[length(tmp_results)+1L]] <- data.frame(Source=source,Outcome=outcome,ParticipantID=id,
      N_10s=nrow(a),Beta_SD=b,source_VIF=vif)
  }
  b <- if(length(tmp_results)) do.call(rbind,tmp_results) else data.frame()
  if(nrow(b)) source_subject[[length(source_subject)+1L]] <- b
  t <- signflip(if(nrow(b)) b$Beta_SD else numeric())
  source_results[[length(source_results)+1L]] <- data.frame(Source=source,Outcome=outcome,N_Participants=t$N,
    mean_beta_SD=t$estimate,ci_low=t$ci_low,ci_high=t$ci_high,p=t$p,
    N_10s=if(nrow(b)) sum(b$N_10s) else 0L)
}
h63 <- add_fdr(do.call(rbind,source_results))
h63_subject <- if(length(source_subject)) do.call(rbind,source_subject) else data.frame()
write.csv(h63,file.path(out,'H6_3_sound_source_adjusted_grouped_by_activeness_inactive.csv'),row.names=FALSE)
write.csv(h63_subject,file.path(out,'H6_3_participant_slopes_grouped_by_activeness_inactive.csv'),row.names=FALSE)

# Metadata and limitations; only these H6_ files are written.
summary_file <- file.path(out,'H6_README_grouped_by_activeness_inactive.txt')
writeLines(c(
 'H6 EXPLORATORY ANALYSIS (not preregistered; no causal claims)',
 paste('Generated:',as.character(Sys.time())),paste('Input:',normalizePath(input)),
 paste('Input MD5:',unname(tools::md5sum(input))),
 'Lighting: lys_lux_avg = mean of available atmo_lys_LYS1__lys_lux and atmo_lys_LYS2__lys_lux, matching H4/H5; both missing stays NA.',
 'Sound sources: vehicle_proportion and rural_natural_proportion from the input CSV.',
 paste('Participants:',paste(sort(unique(d$ParticipantID)),collapse=', ')),
 paste('Core route rows:',nrow(d)),paste('Participant-phase cells:',nrow(phase_df)),
 paste('Missing required input columns:',if(length(missing)) paste(missing,collapse=', ') else 'none'),
 'H6.1: Green minus Urban participant-paired differences, separate for Bike/Walk; exact sign-flip p-values; BH across eight contrasts; BH separately across six delta-PRS associations.',
 'H6.2: per-person correlation of exact 10s first differences of exposure and outcome, at lags 0/10/30/60s; Fisher-z participant synthesis; BH across planned lag contrasts. Not physiological response time or causality.',
 'H6.3: person-specific within-bout standardized slopes for each sound source adjusted for dBA/UTCI/lux; VIF<5; participant sign-flip p and BH across four tests.',
 'N<=11: exploratory inference; participant is the independent unit. No automatic claims of significance or discovery.',
 'Pupil reflects lighting; EDA reflects autonomic arousal and motion/thermal factors; fixation indexes visual search, NOT validated stress.',
 'Source proportions from YAMNet may contain classification/overlap artifacts. Validate audio mapping before interpreting H6.3.',
 'CI uses participant t-interval; signflip assumes approximate symmetry under the null. Correlation signs and changes do not establish causality.',
 'The H5 output directory was identified only as a destination; no H5 analysis was reproduced or validated by this script.'
),summary_file)
cat('H6 finished. Results written to:',out,'\n')
print(h61[,c('Mode','Outcome','N','estimate','p','q')])
print(h62[,intersect(c('Exposure','Outcome','Lag_s','N_Participants','mean_r','p','q'),names(h62)),drop=FALSE])
print(h63[,c('Source','Outcome','N_Participants','mean_beta_SD','p','q')])
