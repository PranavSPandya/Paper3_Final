# Fixed post-hoc Step-5 protocol; no outcome-guided equation construction or deletion.
#
# EVIDENCE MAP: local experiment papers supporting each design choice.
# Folder: C:/Users/pandya/Documents/Github/docker/Paper3_Github/Experiment papers/
# (markdown summaries in ../Experiment papers_md/; same filenames with .pdf)
#
# LMM with random intercepts for unbalanced repeated measures:
#   "Statistics - Cnaan Laird & Slasor 1997 - GLMM for Unbalanced Repeated Measures.pdf"
# Within-person centering of exposures (why every exposure is participant-mean centred):
#   "Statistics - Enders & Tofighi 2007 - Centering Predictor Variables.pdf"
#   "LMM_transform_evidence/WPZ - Wang et al 2019 - On Standardizing Within-Person Effects Potential Problems of Global Standardization.pdf"
# Green vs Urban physiological differences (H1 motivation; 10-s window outcome basis):
#   "Statistics - Hunter et al 2019 - Urban Nature Experiences Reduce Stress.pdf"
#   "Statistics - Gidlow et al 2016 - Walking Natural Urban Environments.pdf"
#   "The Influence of Urban Context on Emotions and Bodily Responses During Walking_similar.pdf"
# Co-exposure / multi-pollutant joint models with interaction terms (Base vs Noise vs Joint blocks):
#   "Short-term exposure to noise, fine particulate matter and nitrogen oxides on ambulatory blood pressure A repeated-measure study_similar.pdf"
#   "Methodology - Environmental exposure mixtures questions and methods to address them.pdf"
#   "Methodology - A review of common statistical methods for dealing with multiple pollutant mixtures and multiple exposures.pdf"
# Thermal exposure indices (PET / UTCI as single-index alternatives to temp+RH+MRT components):
#   "Air temp - PET thermal stress thresholds Matzarakis Mayer categories.pdf"
#   "Air temp - Defining thermal comfort range of UTCI PET and mPET.pdf"
# Temperature -> cardiovascular physiology (justifies heat terms for HR/HRV/skin temp outcomes):
#   "Air temp - Outdoor temperature heart rate and blood pressure in Chinese adults.pdf"
# Noise -> HRV physiology (justifies SND_dBA as a fixed covariate, not only an interaction):
#   "Sound - Effects of different noise types on heart rate variability in men.pdf"
# EDA measurement standards (why EDA outcomes stay on native scale with QC, no subtraction):
#   "Psychophysiology - May 1981 - Fowles - Publication Recommendations for Electrodermal Measurements.pdf"
# HRV artifact correction and window validity (why HRV rows drop when 5-min availability flag fails):
#   "Impact of Using Different Levels of Threshold-Based Artefact Correction on the Quantification of Heart Rate Variability in Three Independent Human Cohorts.pdf"
#   "Empatica - Reliability of Ultra-Short-Term Analysis as a Surrogate of Standard 5-Min Analysis of Heart Rate Variability.pdf"
#   "Empatica - Validity of the Empatica E4 wristband to estimate resting-state heart rate variability in a lab-based context.pdf"
# Wrist-worn EDA/HR in ambulatory urban stress studies (Empatica outcome family precedent):
#   "Empatica - Stress in the City Multimodal Biosensing of Urban Stress.pdf"
#   "Statistics - Torku et al 2023 - Older Pedestrians Urban Stress Empatica.pdf"
# Outdoor eye-tracking outcomes (why ocular outcomes are modelled in the same design):
#   "Eyetracker - Evans et al 2012 - Collecting and analyzing eye-tracking data in outdoor environments.pdf"
#   "Eyetracker - Tomasi et al 2016 - Mobile gaze tracking outdoor walking behavioral studies.pdf"
#   "Eyetracker - Rupi and Krizek 2019 - Visual eye gaze while cycling urban intersections.pdf"
#   "Eyetracker - Trefzger et al 2018 - Visual comparison gaze pedestrians cyclists.pdf"
#   "Eyetracker - Fleming et al 2024 - The nature gaze outdoor eye tracking wellbeing.pdf"
# Light exposure measurement ranges (why LYS kelvin/lux enter only via Step-4 screening):
#   "LYS ranges - FIELD STUDIES OF HUMAN LIGHT EXPOSURE DURING EVERYDAY ACTIVITIES - METHODOLOGICAL ASPECTS AND INITIAL RESULTS.pdf"
# Pupil as stress/discomfort outcome:
#   "LMM_transform_evidence/Pupil - Imburgio et al 2024 - Electrocortical Responses in Anticipation of Avoidable and Inevitable Threats A Multisite Study.pdf"
#   "LMM_transform_evidence/HR_EDA - Beggiato et al 2018 - Using Smartbands Pupillometry and Body Motion to Detect Discomfort in Automated Driving.pdf"
# NOT paper-backed (our declared statistical choices, method-standard references only):
#   exact 10-variable Step-4 union; the four thermal representations; VIF>=5 flag;
#   ridge prior (Eliot 2011, doi:10.2202/1557-4679.1353), REML-ridge equivalence (Shen 2013,
#   doi:10.1534/genetics.112.146720), CR2 small-cluster SE (Pustejovsky/Tipton 2016),
#   interaction hierarchy (Bien 2013, doi:10.1214/13-AOS1096). No collected paper ran this
#   exact equation set; these are standard methods, cited in the report, not precedents.
root <- "C:/Users/pandya/Documents/Github/docker/Paper3_Final"
data_path <- file.path(root,"output/merged_all_11participants_8min.csv")
audit_path <- file.path(root,"output/statistical_analysis/H4_multivariate/H4_Multivariate_Filtration_Results.csv")
report_path <- file.path(root,"output/statistical_analysis/H4_multivariate/H4_Step5_Equations_Checks.txt")
frozen <- file.path(root,c("scripts/H4_multivariate.R","output/statistical_analysis/H4_multivariate/H4_Faceted_Vertical_Flow_final.pdf","output/statistical_analysis/H4_multivariate/H4_Multivariate_Filtration_Results.csv"))
before <- tools::md5sum(frozen)
raw <- read.csv(data_path,check.names=FALSE)
audit <- read.csv(audit_path,check.names=FALSE)
ee <- parse(file.path(root,"scripts/H4_multivariate.R"))
targets <- vapply(ee,function(e) if(is.call(e)&&identical(e[[1]],as.name("<-"))) paste(deparse(e[[2]]),collapse="") else "",character(1))
stopifnot(sum(targets=="H4_SPEC")==1L)
eval(ee[[which(targets=="H4_SPEC")]])
outcomes <- unlist(H4_SPEC$outcomes[c("Physiological_Autonomic","Physiological_Ocular")],use.names=FALSE)
lasso_union <- sort(unique(audit$Variable_Name[audit$Step4_Empatica_Decision=="Retained"|audit$Step4_Eyetracker_Decision=="Retained"]))
exclusive_thermal <- c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT","ucm_HUMIDEX","ucm_PET","ucm_UTCI")
nonthermal <- setdiff(lasso_union, exclusive_thermal)
# The current outline names PM2.5. This is an explicitly documented post-hoc
# hypothesis-based inclusion, NOT a LASSO survivor or a preregistered decision.
if (!"atmo_pm2.5_avg" %in% nonthermal) nonthermal <- sort(c(nonthermal, "atmo_pm2.5_avg"))
component_set <- c("ucm_AIR_temp","ucm_AIR_RH","ucm_MRT")
thermal <- list(
  Components=component_set,
  HUMIDEX=intersect(c("ucm_HUMIDEX","ucm_MRT"), lasso_union),
  PET=intersect("ucm_PET", lasso_union),
  UTCI=intersect("ucm_UTCI", lasso_union))
component_role <- ifelse(component_set %in% lasso_union, "within-person selected", "hypothesis term, not in the within-person union")
selected <- unique(c(nonthermal, unlist(thermal, use.names = FALSE)))
raw$atmo_pm1_avg <- rowMeans(raw[,c("atmo_lys_atmotube_left__atmotube_pm1","atmo_lys_atmotube_right__atmotube_pm1")],na.rm=TRUE)
raw$atmo_pm2.5_avg <- rowMeans(raw[,c("atmo_lys_atmotube_left__atmotube_pm2.5","atmo_lys_atmotube_right__atmotube_pm2.5")],na.rm=TRUE)
raw$lys_lux_avg <- rowMeans(raw[,c("atmo_lys_LYS1__lys_lux","atmo_lys_LYS2__lys_lux")],na.rm=TRUE)
raw$lys_medi_avg <- rowMeans(raw[,c("atmo_lys_LYS1__lys_medi","atmo_lys_LYS2__lys_medi")],na.rm=TRUE)
raw$lys_kelvin_avg <- rowMeans(raw[,c("atmo_lys_LYS1__lys_kelvin","atmo_lys_LYS2__lys_kelvin")],na.rm=TRUE)
raw <- raw[raw$ParticipantID%in%H4_SPEC$participants & raw$PhaseID%in%H4_SPEC$phases,]
stopifnot(length(outcomes)==26L,all(c(selected,outcomes)%in%names(raw)), length(lasso_union)>0L)
centered <- as.matrix(raw[,selected,drop=FALSE])
storage.mode(centered) <- "double"
for(j in seq_len(ncol(centered))) {
  finite <- is.finite(centered[,j])
  reference <- tapply(centered[finite,j],raw$ParticipantID[finite],mean)
  centered[,j] <- centered[,j]-reference[as.character(raw$ParticipantID)]
  stopifnot(max(abs(tapply(centered[finite,j],raw$ParticipantID[finite],mean)))<1e-8)
  sdx <- stats::sd(centered[finite,j])
  if(!is.finite(sdx) || sdx<=0) stop("within-person SD is zero for ", colnames(centered)[j])
  centered[,j] <- centered[,j]/sdx
}

diagnose <- function(x) {
  if(nrow(x)<=ncol(x)+1L||any(!is.finite(x))) return(list(rank=FALSE,max=NA_real_,term="rank check only"))
  sdv<-apply(x,2,sd)
  if(any(!is.finite(sdv)|sdv<1e-12)) return(list(rank=FALSE,max=NA_real_,term="constant column"))
  z<-scale(x)
  list(rank=qr(cbind(1,z))$rank==ncol(z)+1L,max=NA_real_,term="VIF retired")
}
make_design <- function(z,vars,mode,test="Base") {
  x<-cbind(z[,c(nonthermal,vars),drop=FALSE],Activity_Bike=mode)
  for(v in vars) {
    if(test %in% c("Noise","Joint")) {
      x<-cbind(x,z[,v]*z[,"ucm_SND_dBA"])
      colnames(x)[ncol(x)]<-paste0(v,":SND_dBA")
    }
    if(test %in% c("Activity","Joint")) {
      x<-cbind(x,z[,v]*mode)
      colnames(x)[ncol(x)]<-paste0(v,":Activity_Bike")
    }
  }
  x
}
stopifnot(diagnose(cbind(a=c(-1,-1,1,1),b=c(-1,1,-1,1)))$rank,!diagnose(cbind(a=1:6,b=1:6))$rank)

run_checks <- function() {
  stop("Legacy VIF report is retired. Use H4_STEP5_EQ1=1 for the current non-VIF fits and diagnostics.")
  cat("INPUT:",data_path,"\nAUDIT:",audit_path,"\nFrozen Step4 candidates:",paste(selected,collapse=", "),"\n")
  cat("Design diagnostics only: NO outcome fits, estimates, p-values, or final model validation.\n")
  cat("Independent clusters: participants; ten-second windows repeated. Serial dependence not tested.\n")
  cat("FIXED PROTOCOL: all four representations x Base/Noise/Activity/Joint. No p-value, minimum-VIF winner, or highest-VIF removal rule.\n")
  cat("H4 tests: Noise block asks whether thermal associations vary with noise; Activity block asks whether they vary by mode; Joint contains both blocks. No three-way interaction.\n")
  cat("Activity: Bike=+0.5, Walk=-0.5 (same contrast as 1/0), NOT exertion. No movement adjustment assumed.\n")
  cat("Each outcome uses common complete cases across ALL TEN candidates and that outcome for all four specifications. No all-26-response completeness requirement.\n")
  cat("Exposures participant-mean centred on finite exposure-specific cohort observations BEFORE outcome filtering; interactions formed afterwards. No phase averaging.\n")
  cat("Shared nonthermal terms retained as benchmark exposures, NOT verified confounders. No literature claim for these exact equations.\n")
  cat("Construction provenance: components use selected thermal measures; HUMIDEX replaces temp/RH while MRT remains; PET/UTCI replace the thermal block. These representation choices are declared, not a universal selection algorithm.\n")
  cat("Measurement references: Brode et al. doi:10.1007/s00484-011-0454-1; Matzarakis et al. doi:10.1007/s004840050119. Support index definitions, NOT this exact candidate set.\n")
  cat("Hierarchy reference: Bien et al. doi:10.1214/13-AOS1096. Within/between reference: Curran/Bauer doi:10.1146/annurev.psych.093008.100356. Neither validates our entire LASSO-to-LMM pipeline.\n")
  cat("DECISION GATES: non-full-rank -> not estimable as coded; VIF>5 -> flag, not deletion; low VIF -> no collinearity flag, NOT final acceptance. No automatic primary model.\n")
  cat("INFERENCE GATE CLOSED: upstream selection reused outcomes; only 10-11 participant clusters. Post-selection inference and temporal/error structure unresolved. No ordinary fitted p-values as confirmatory.\n")
  for(m in names(thermal)) {
    cat("\n",m,": Y ~",paste(c(nonthermal,thermal[[m]],"Activity_Bike"),collapse=" + "),"+ (1 | ParticipantID)\n")
    cat("H4 adds:",paste(unlist(lapply(thermal[[m]],function(v)c(paste0(v,":SND_dBA"),paste0(v,":Activity_Bike")))),collapse=" + "),"\n")
  }
  results<-list()
  for(y in outcomes) {
    needed<-as.matrix(raw[,c(selected,y),drop=FALSE]);storage.mode(needed)<-"double"
    ok<-apply(needed,1,function(v)all(is.finite(v)))
    z<-needed[ok,selected,drop=FALSE];ids<-raw$ParticipantID[ok];phase<-raw$PhaseID[ok]
    mode<-as.numeric(grepl("^Bike",phase))-.5
    if(!nrow(z)) {cat("NO COMPLETE CASES:",y,"\n");next}
    z<-centered[ok,,drop=FALSE]
    for(m in names(thermal)) {
      base<-diagnose(make_design(z,thermal[[m]],mode))
      design<-make_design(z,thermal[[m]],mode,"Joint");expanded<-diagnose(design)
      noise<-diagnose(make_design(z,thermal[[m]],mode,"Noise"))
      activity<-diagnose(make_design(z,thermal[[m]],mode,"Activity"))
      old_design<-make_design(z,thermal[[m]],mode+.5,"Joint")
      # Effect coding changes interpretation, not the fitted-value space.
      stopifnot(qr(cbind(1,design,old_design))$rank==qr(cbind(1,design))$rank)
      loo<-lapply(unique(ids),function(id)diagnose(design[ids!=id,,drop=FALSE]))
      results[[length(results)+1L]]<-data.frame(Outcome=y,Specification=m,Windows=sum(ok),Participants=length(unique(ids)),Phase_cells=length(unique(paste(ids,phase))),Base_full_rank=base$rank,Base_max_VIF=base$max,Base_highest=base$term,H4_full_rank=expanded$rank,H4_max_VIF=expanded$max,H4_highest=expanded$term,LOO_rank_failures=sum(!vapply(loo,function(v)v$rank,logical(1))),LOO_max_VIF=max(vapply(loo,function(v)v$max,numeric(1))))
      i<-length(results)
      results[[i]]$Noise_max_VIF<-noise$max
      results[[i]]$Activity_max_VIF<-activity$max
      results[[i]]$Noise_full_rank<-noise$rank
      results[[i]]$Activity_full_rank<-activity$rank
      results[[i]]$Old_01_joint_VIF<-diagnose(old_design)$max
      results[[i]]$Joint_design_terms<-ncol(design)
      cat("Completed",y,m,"\n",file=stderr())
    }
  }
  # Nested blocks have identical samples and preserve all parent main effects.
  table<-do.call(rbind,results)
  stopifnot(nrow(table)==length(outcomes)*length(thermal))
  cat("\nALL OUTCOME-SPECIFIC CHECKS:\n");print(table,row.names=FALSE,digits=5)
  cat("\nSUMMARY: VIF 5 is a diagnostic flag, NOT automatic rejection.\n")
  for(m in names(thermal)) {
    t<-table[table$Specification==m,]
    cat(m,": outcomes",nrow(t),"; windows",paste(range(t$Windows),collapse="-"),"; participants",paste(range(t$Participants),collapse="-"),"; base VIF range",paste(round(range(t$Base_max_VIF),3),collapse="-"),"; H4 VIF range",paste(round(range(t$H4_max_VIF),3),collapse="-"),"; base VIF>5",sum(t$Base_max_VIF>5),"; H4 VIF>5",sum(t$H4_max_VIF>5),"; H4 rank failures",sum(!t$H4_full_rank),"; LOO rank failures",sum(t$LOO_rank_failures),"\n")
  }
  cat("\nNESTED TEST SUMMARY (all 26 outcomes; maximum-VIF ranges):\n")
  for(m in names(thermal)) {
    t<-table[table$Specification==m,]
    cat(m,"| Base",paste(round(range(t$Base_max_VIF),3),collapse="-"),"| Noise",paste(round(range(t$Noise_max_VIF),3),collapse="-"),"| Activity",paste(round(range(t$Activity_max_VIF),3),collapse="-"),"| Joint",paste(round(range(t$H4_max_VIF),3),collapse="-"),"| Old 0/1 Joint",paste(round(range(t$Old_01_joint_VIF),3),collapse="-"),"| LOO worst",max(t$LOO_max_VIF),"\n")
  }
  cat("\nOutcome distributions, model family, residuals, autocorrelation, convergence, coefficient stability and post-selection inference NOT evaluated.\n")
  stopifnot(identical(before,tools::md5sum(frozen)))
  cat("PASS: production H4 R, PDF and Step4 audit hashes unchanged.\n")
}
do_fit <- function(formula,fd,opt="nlminb",method="REML") nlme::lme(formula,data=fd,random=~1|ParticipantID/PhaseID,
    correlation=nlme::corAR1(value=.2,form=~Time10|ParticipantID/PhaseID),method=method,na.action=na.fail,
    control=nlme::lmeControl(maxIter=100,msMaxIter=150,returnObject=FALSE,opt=opt))
fit_models <- function(pilot=FALSE) {
  stopifnot(requireNamespace("nlme",quietly=TRUE),requireNamespace("clubSandwich",quietly=TRUE))
  cat("\nFITTED CONDITIONAL-ASSOCIATION MODELS\n")
  cat("All 26 outcomes are continuous sensor summaries, not questionnaire scores or raw event counts. HRV outcomes listed in existing H4_SPEC$hrv_log use the natural log of strictly positive values; non-positive rows are dropped. All other outcomes stay untransformed.\n")
  cat("Fixed effects: the declared Joint specification. Random intercepts: participant and participant-phase. Discrete AR1 errors within participant-phase on verified integer 10-second timestamps (gaps preserved), REML.\n")
  cat("Small-cluster uncertainty: participant-cluster CR2 with Satterthwaite degrees of freedom. Intervals are nominal post-selection descriptive intervals, NOT selection-adjusted or simultaneous. No significance claims or primary-model winner.\n")
  cat("PM1/GVI/clearness condition the target associations; no claim they form a sufficient causal adjustment set. Activity is mode, not exertion. Physiological response is not validated perceived thermal discomfort.\n")
  cat("References: nlme corAR1 documentation; clubSandwich https://jepusto.github.io/clubSandwich/; Pustejovsky/Tipton doi:10.1080/07350015.2016.1247004.\n")
  cat("Flags are operational diagnostics, not universal acceptance thresholds: abs(residual skew)>2, abs(excess kurtosis)>7, abs(normalized residual lag1 correlation)>.2, CR2 df<4, variance component <1e-6 residual variance. All failures/warnings reported.\n")
  cat("R:",as.character(getRversion()),"nlme:",as.character(packageVersion("nlme")),"clubSandwich:",as.character(packageVersion("clubSandwich")),"\n")
  ys<-if(pilot) outcomes[1] else outcomes
  ms<-if(pilot) names(thermal)[1] else names(thermal)
  if(nzchar(Sys.getenv("H4_STEP5_OUTCOME"))) ys<-intersect(outcomes,Sys.getenv("H4_STEP5_OUTCOME"))
  if(nzchar(Sys.getenv("H4_STEP5_SPEC"))) ms<-intersect(names(thermal),Sys.getenv("H4_STEP5_SPEC"))
  stopifnot(length(ys)>0L,length(ms)>0L)
  for(y in ys) {
    vals<-as.matrix(raw[,c(selected,y),drop=FALSE]);storage.mode(vals)<-"double"
    ok<-apply(vals,1,function(v)all(is.finite(v)))
    d<-raw[ok,c("ParticipantID","PhaseID","Datetime"),drop=FALSE]
    d$ParticipantID<-factor(d$ParticipantID);d$PhaseID<-factor(d$PhaseID)
    stamp<-as.numeric(as.POSIXct(d$Datetime,tz="UTC"))
    stopifnot(all(is.finite(stamp)),!anyDuplicated(d[,c("ParticipantID","PhaseID","Datetime")]))
    bout<-interaction(d$ParticipantID,d$PhaseID,drop=TRUE)
    d$Time10<-(stamp-ave(stamp,bout,FUN=min))/10
    stopifnot(all(abs(d$Time10-round(d$Time10))<1e-8))
    d$Time10<-as.integer(round(d$Time10))
    z<-vals[ok,selected,drop=FALSE]
    z<-centered[ok,,drop=FALSE]
    yv<-vals[ok,y];transformation<-"native"
    if(y%in%H4_SPEC$hrv_log) {
      if(any(yv<0,na.rm=TRUE)) {cat("OUTCOME EXCLUDED: negative value prevents natural log:",y,"\n");next}
      keep<-is.finite(yv)&yv>0
      d<-d[keep,,drop=FALSE];z<-z[keep,,drop=FALSE]
      yv<-log(yv[keep]);transformation<-"natural log"
    }
    cat("\nOUTCOME:",y,"|",transformation,"| n",nrow(d),"| participants",nlevels(d$ParticipantID),"| missing fraction",round(1-sum(ok)/nrow(raw),4),"| range",paste(range(yv),collapse=" to "),"\n")
    for(m in ms) {
      start<-proc.time()[3];warnings<-character();stage<-"design"
      block<-capture.output({
        cat("MODEL:",y,m,"\n")
        result<-tryCatch(withCallingHandlers({
          design<-make_design(z,thermal[[m]],as.numeric(grepl("^Bike",d$PhaseID))-.5,"Joint")
          original<-colnames(design);safe<-make.names(original,unique=TRUE);colnames(design)<-safe
          fd<-cbind(d,Y=yv,as.data.frame(design));fd<-fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
          formula<-reformulate(safe,response="Y")
          stage<-"nlme fit"
          fit<-tryCatch(do_fit(formula,fd,"nlminb"),error=function(e) {
            cat("OPTIMIZER RETRY: nlminb failed:",conditionMessage(e),"; optim retries identical model/data.\n")
            do_fit(formula,fd,"optim")
          })
          stage<-"CR2 uncertainty"
          robust<-clubSandwich::coef_test(fit,vcov="CR2",cluster=fd$ParticipantID,test="Satterthwaite")
          coefficient<-data.frame(Term=c("Intercept",original),Estimate=robust$beta,CR2_SE=robust$SE,DF=robust$df_Satt)
          coefficient$Low95<-coefficient$Estimate-qt(.975,coefficient$DF)*coefficient$CR2_SE
          coefficient$High95<-coefficient$Estimate+qt(.975,coefficient$DF)*coefficient$CR2_SE
          rn<-as.numeric(residuals(fit,type="normalized"));rr<-(rn-mean(rn))/sd(rn)
          skew<-mean(rr^3);kurt<-mean(rr^4)-3
          grp<-interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
          pairs<-which(as.character(grp[-1])==as.character(grp[-length(grp)]) & abs(diff(fd$Time10)-1)<1e-6)
          lag1<-if(length(pairs)>2) cor(rn[pairs],rn[pairs+1]) else NA_real_
          flags<-character()
          if(abs(skew)>2||abs(kurt)>7) flags<-c(flags,"RESIDUAL_TAIL_SHAPE_REVIEW")
          if(is.finite(lag1)&&abs(lag1)>.2) flags<-c(flags,"REMAINING_SERIAL_CORRELATION")
          if(any(coefficient$DF<4)) flags<-c(flags,"VERY_LOW_CLUSTER_DF")
          variance_table<-nlme::VarCorr(fit)
          variance<-as.numeric(variance_table[rownames(variance_table)%in%c("(Intercept)","Residual"),"Variance"])
          if(any(variance[is.finite(variance)]<1e-6*fit$sigma^2)) flags<-c(flags,"NEAR_BOUNDARY_VARIANCE")
          print(coefficient,row.names=FALSE,digits=5)
          cat("AR1 rho per10sec:",coef(fit$modelStruct$corStruct,unconstrained=FALSE),"| normalized residual lag1:",lag1,"| skew:",skew,"| excess kurtosis:",kurt,"\n")
          cat("Variance components:\n");print(nlme::VarCorr(fit))
          cat("DIAGNOSTIC STATUS:",if(length(flags)) paste(flags,collapse="; ") else "No listed diagnostic flag; NOT confirmatory validation","\n")
          TRUE
        },warning=function(w) {
          warnings<<-c(warnings,conditionMessage(w))
          message("MODEL WARNING ",y," ",m,": ",conditionMessage(w))
        }),error=function(e) {cat("FAILED at",stage,":",conditionMessage(e),"\n");FALSE})
        if(length(warnings)) cat("ALL WARNINGS:",paste(unique(warnings),collapse=" | "),"\n")
        cat("MODEL COMPLETE:",y,m,"| successful",result,"| seconds",round(proc.time()[3]-start,2),"\n")
      })
      cat(paste(block,collapse="\n"),"\n")
      if(!pilot) cat(paste(block,collapse="\n"),"\n",file=report_path,append=TRUE)
      message("Fit completed: ",y," / ",m)
    }
  }
  stopifnot(identical(before,tools::md5sum(frozen)))
  cat("FITTING FINISHED. Frozen production files unchanged.\n")
}
summarize_fits <- function() {
  all_lines<-readLines(report_path,warn=FALSE)
  if(any(grepl("JOINT MAIN-EFFECT CORRECTION: CURRENT STATUS",all_lines,fixed=TRUE)))
    stop("Historical interaction summary cannot replace the current joint-model correction. Existing report preserved.")
  lines<-all_lines
  starts<-grep("=== FIT RUN START:",lines,fixed=TRUE)
  stopifnot(length(starts)>0L)
  lines<-lines[max(starts):length(lines)]
  validation_start<-grep("^=== VALIDATION RUN:",lines)
  if(length(validation_start)) lines<-lines[seq_len(min(validation_start)-1L)]
  complete<-grep("^MODEL COMPLETE:",lines,value=TRUE)
  stopifnot(length(complete)==104L,!anyDuplicated(sub(" \\|.*","",complete)))
  report<-capture.output({
    cat("\n=== CURRENT FIT RUN: REPORTING SUMMARY ===\n")
    cat("Completed",length(complete),"declared models; successful",sum(grepl("successful TRUE",complete,fixed=TRUE)),"; failed",sum(grepl("successful FALSE",complete,fixed=TRUE)),". Failures remain documented, not silently replaced.\n")
    cat("Failed fits:\n");cat(grep("successful FALSE",complete,value=TRUE),sep="\n")
    cat("\nDiagnostic counts (overlapping flags; not counts of significant effects):\n")
    flags<-grep("^DIAGNOSTIC STATUS:",lines,value=TRUE)
    for(flag in c("VERY_LOW_CLUSTER_DF","NEAR_BOUNDARY_VARIANCE","RESIDUAL_TAIL_SHAPE_REVIEW","REMAINING_SERIAL_CORRELATION")) cat(flag,":",sum(grepl(flag,flags,fixed=TRUE)),"\n")
    tokens<-strsplit(trimws(grep("^\\s*(atmo_pm1_avg|ucm_[^ ]*:)",lines,value=TRUE)),"\\s+")
    for(label in c("PM1","H4 interactions")) {
      chosen<-Filter(function(t)length(t)>=5L && if(label=="PM1") t[1]=="atmo_pm1_avg" else grepl(":",t[1],fixed=TRUE),tokens)
      df<-vapply(chosen,function(t)as.numeric(t[4]),numeric(1))
      stopifnot(length(df)>0L,all(is.finite(df)))
      cat(label,"| coefficient rows",length(df),"| printed DF range",paste(range(df),collapse=" to "),"| DF<4",sum(df<4),"\n")
    }
    cat("\nOUTCOME-SPECIFIC COMMON SAMPLES (identical across four alternatives):\n")
    for(y in outcomes) {
      ok<-apply(as.matrix(raw[,c(selected,y),drop=FALSE]),1,function(v)all(is.finite(v)))
      cat(y,"| windows",sum(ok),"| participants",length(unique(raw$ParticipantID[ok])),"| missing fraction",round(mean(!ok),4),"\n")
    }
    p<-raw$atmo_pm1_avg;id<-raw$ParticipantID;ok<-is.finite(p)
    ss<-tapply((p[ok]-ave(p[ok],id[ok],FUN=mean))^2,id[ok],sum)
    cat("\nPM1 within-person variation share in all available core-phase rows (not each outcome sample):\n")
    print(sort(ss/sum(ss),decreasing=TRUE))
    cat("\nEXACT DECLARED FIXED-EFFECT EQUATIONS: all exposures participant-mean centred on each outcome's common sample; Bike=+0.5, Walk=-0.5.\n")
    for(m in names(thermal)) {
      terms<-c(nonthermal,thermal[[m]],"Activity_Bike",unlist(lapply(thermal[[m]],function(v)c(paste0(v,":SND_dBA"),paste0(v,":Activity_Bike")))))
      cat(m,": Y ~",paste(terms,collapse=" + "),"+ participant and participant-phase random intercepts; discrete AR1 within participant-phase\n")
    }
    cat("\nINTERPRETATION: thermal-by-noise and thermal-by-mode coefficients address H4 moderation. Main thermal coefficients refer to participant-mean noise and the midpoint of the Bike/Walk contrast. Other exposures are adjusted statistically, not physically held constant.\n")
    cat("REPORTING SCOPE: a complete post-hoc conditional-association comparison with estimates, nominal descriptive 95% intervals and explicit diagnostic limitations. No primary winner or confirmatory significance claim. No inference that a sensor measures perceived thermal discomfort directly.\n")
    cat("LIMITATIONS: upstream outcome-based LASSO selection is not adjusted by CR2; intervals are not simultaneous. Only 10-11 independent participant clusters; PM1 variation is dominated by P4 and PM1 uncertainty has very low effective df. Missingness is not proven ignorable. AR1 does not remove all residual dependence; heavy tails and boundary variances remain visible.\n")
    cat("UNFINISHED VALIDATION: coefficient-level participant influence, nonlinear conditional means and exposure-overlap/extrapolation have not been established. Convergence, full rank and VIF alone do not establish those properties. Do not label these fits a validated final confirmatory H4 analysis.\n")
    cat("FROZEN FILES: production H4 R, flow PDF and Step4 audit unchanged. H1-H3 were not run or edited.\n")
  })
  writeLines(c(report,"","=== FULL AUDIT TRAIL BELOW: EARLIER RUNS ARE SUPERSEDED ===",all_lines),report_path)
  cat(paste(report,collapse="\n"),"\nSAVED:",report_path,"\n")
  stopifnot(identical(before,tools::md5sum(frozen)))
}
validate_model <- function(job) {
  options(width=180)
  y<-job$Outcome;m<-job$Specification
  text<-capture.output({
    cat("\nVALIDATION MODEL:",y,m,"\n")
    result<-tryCatch(withCallingHandlers({
      vals<-as.matrix(raw[,c(selected,y),drop=FALSE]);storage.mode(vals)<-"double"
      ok<-apply(vals,1,function(v)all(is.finite(v)))
      fd<-raw[ok,c("ParticipantID","PhaseID","Datetime"),drop=FALSE]
      fd$ParticipantID<-factor(fd$ParticipantID);fd$PhaseID<-factor(fd$PhaseID)
      stamp<-as.numeric(as.POSIXct(fd$Datetime,tz="UTC"));bout<-interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
      fd$Time10<-(stamp-ave(stamp,bout,FUN=min))/10
      stopifnot(all(is.finite(stamp)),all(abs(fd$Time10-round(fd$Time10))<1e-8),!anyDuplicated(fd[,1:3]))
      z<-vals[ok,selected,drop=FALSE]
      z<-centered[ok,,drop=FALSE]
      fd$Y<-vals[ok,y]
      if(y%in%hrv_log) {stopifnot(all(fd$Y>=0));keep<-fd$Y>0;fd<-fd[keep,,drop=FALSE];z<-z[keep,,drop=FALSE];fd$Y<-log(fd$Y)}
      design<-make_design(z,thermal[[m]],as.numeric(grepl("^Bike",fd$PhaseID))-.5,"Joint")
      original<-colnames(design);safe<-make.names(original,unique=TRUE);colnames(design)<-safe
      fd<-cbind(fd,as.data.frame(design));fd<-fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
      formula<-reformulate(safe,response="Y")
      refit<-function(data,form=formula,method="REML") tryCatch(do_fit(form,data,"nlminb",method),error=function(e) {
        cat("OPTIMIZER RETRY:",conditionMessage(e),"\n");do_fit(form,data,"optim",method)
      })
      fit<-refit(fd);full<-nlme::fixef(fit)
      cat("Sample:",nrow(fd),"windows;",nlevels(fd$ParticipantID),"participants. Centering held fixed for deletion diagnostics; covariance parameters re-estimated.\n")
      deleted<-lapply(levels(fd$ParticipantID),function(id) tryCatch({
        sub<-droplevels(fd[fd$ParticipantID!=id,]);f<-refit(sub)
        b<-nlme::fixef(f);se<-sqrt(diag(vcov(f)))
        stopifnot(identical(names(b),names(full)),all(is.finite(b)),all(is.finite(se)),all(se>0))
        list(id=id,b=b,dfb=(full-b)/se)
      },error=function(e) {cat("DELETION FAILED:",id,conditionMessage(e),"\n");list(id=id,error=conditionMessage(e))}))
      good<-Filter(function(v)is.null(v$error),deleted)
      cat("PARTICIPANT DELETIONS:",length(good),"successful /",length(deleted),"planned\n")
      if(length(good)) {
        b<-do.call(rbind,lapply(good,function(v)v$b));dfb<-do.call(rbind,lapply(good,function(v)v$dfb))
        ids<-vapply(good,function(v)v$id,character(1));worst<-apply(abs(dfb),2,which.max)
        table<-data.frame(Term=c("Intercept",original),Full=as.numeric(full),Delete_min=apply(b,2,min),Delete_max=apply(b,2,max),Sign_flips=colSums(sign(b)!=matrix(sign(full),nrow(b),length(full),byrow=TRUE)),Max_abs_DFBETAS=apply(abs(dfb),2,max),Worst_participant=ids[worst])
        cat("DFBETAS uses deleted-model conventional SE, as in Nieuwenhuis et al.; influence diagnostic, not CR2 inference. Rule-of-thumb",2/sqrt(length(deleted)),"is a review flag, never automatic exclusion.\n")
        print(table,row.names=FALSE,digits=6)
      }
      cat("EXPOSURE SUPPORT: central80% range intersection/union, by mode and median-split centred noise. Zero means no overlap of central ranges, NOT no overlap anywhere.\n")
      for(v in thermal[[m]]) for(group in c("Mode","Noise")) {
        g<-if(group=="Mode") fd$Activity_Bike else as.numeric(fd$ucm_SND_dBA>median(fd$ucm_SND_dBA))
        ranges<-sapply(split(fd[[make.names(v)]],g),quantile,probs=c(.1,.9))
        overlap<-if(ncol(ranges)==2) max(0,min(ranges[2,])-max(ranges[1,]))/(max(ranges[2,])-min(ranges[1,])) else NA_real_
        cat(v,group,"range-overlap",overlap,"; group windows",paste(table(g),collapse="/"),"\n")
      }
      cat("CURVATURE SENSITIVITY: add squared terms for all exposure main effects, without deleting interactions; ML comparison on identical cases. Diagnostic only, no automatic equation change.\n")
      curve<-tryCatch({
        exposures<-c(nonthermal,thermal[[m]])
        for(v in exposures) fd[[paste0("Q_",make.names(v))]]<-(fd[[make.names(v)]]/sd(fd[[make.names(v)]]))^2
        qnames<-paste0("Q_",make.names(exposures));qform<-reformulate(c(safe,qnames),response="Y")
        linear<-refit(fd,method="ML");quadratic<-refit(fd,qform,"ML")
        cat("AIC quadratic minus linear:",AIC(quadratic)-AIC(linear),"(negative favours quadratic working likelihood; not a validated prediction score)\n")
        rb<-clubSandwich::coef_test(quadratic,vcov="CR2",cluster=fd$ParticipantID,test="Satterthwaite")
        take<-rownames(rb)%in%qnames
        print(data.frame(Term=rownames(rb)[take],Estimate=rb$beta[take],CR2_SE=rb$SE[take],DF=rb$df_Satt[take]),row.names=FALSE)
        TRUE
      },error=function(e) {cat("CURVATURE FAILED:",conditionMessage(e),"\n");FALSE})
      cat("VALIDATION RESULT: deletion failures",length(deleted)-length(good),"; curvature computed",curve,"; diagnostics do not repair post-selection inference or establish causal/measurement validity.\n")
      TRUE
    },warning=function(w) cat("VALIDATION WARNING:",conditionMessage(w),"\n")),error=function(e) {cat("VALIDATION FAILED:",conditionMessage(e),"\n");FALSE})
    cat("VALIDATION COMPLETE:",y,m,"| successful",result,"\n")
  })
  text
}
run_validation <- function() {
  options(width=180)
  jobs<-expand.grid(Outcome=outcomes,Specification=names(thermal),stringsAsFactors=FALSE)
  stamp<-paste(unname(tools::md5sum(c(data_path,audit_path,file.path(root,"scripts/H4_multivariate.R"),file.path(root,"scripts/h4_step5_equations.R")))),collapse="-")
  marker<-paste("=== VALIDATION RUN:",stamp,"===")
  old<-if(file.exists(report_path)) readLines(report_path,warn=FALSE) else character()
  if(!any(old==marker)) cat("\n",marker,"\nMethods: participant-deletion refits, Nieuwenhuis et al. 2012 https://journal.r-project.org/articles/RJ-2012-011/ ; CR2 https://jepusto.github.io/clubSandwich/reference/vcovCR.lme.html . No automatic variable/model selection.\n",sep="",file=report_path,append=TRUE)
  previous<-if(any(old==marker)) old[max(which(old==marker)):length(old)] else character()
  keys<-paste(jobs$Outcome,jobs$Specification)
  done<-trimws(sub(" \\|.*","",sub("^VALIDATION COMPLETE: ","",grep("^VALIDATION COMPLETE:",previous,value=TRUE))))
  jobs<-jobs[!keys%in%done,,drop=FALSE]
  if(nzchar(Sys.getenv("H4_STEP5_OUTCOME"))) jobs<-jobs[jobs$Outcome==Sys.getenv("H4_STEP5_OUTCOME"),,drop=FALSE]
  if(nzchar(Sys.getenv("H4_STEP5_SPEC"))) jobs<-jobs[jobs$Specification==Sys.getenv("H4_STEP5_SPEC"),,drop=FALSE]
  if(!nrow(jobs)) {cat("Validation already checkpointed for requested models.\n");return(invisible(NULL))}
  workers<-min(8L,nrow(jobs));cl<-parallel::makeCluster(workers);on.exit(parallel::stopCluster(cl))
  hrv_log<-H4_SPEC$hrv_log
  parallel::clusterExport(cl,c("raw","centered","selected","nonthermal","thermal","make_design","do_fit","validate_model","hrv_log"),envir=environment())
  for(start in seq(1L,nrow(jobs),by=workers)) {
    ix<-start:min(start+workers-1L,nrow(jobs))
    blocks<-parallel::parLapplyLB(cl,lapply(ix,function(i)as.list(jobs[i,])),validate_model)
    for(block in blocks) cat(paste(block,collapse="\n"),"\n",file=report_path,append=TRUE)
    cat("VALIDATION CHECKPOINT:",max(ix),"of",nrow(jobs),"requested models saved to",report_path,"\n")
  }
  stopifnot(identical(before,tools::md5sum(frozen)))
  cat("Validation run finished; frozen files unchanged.\n")
}
run_joint_main_effects <- function() {
  options(width=180)
  # Fixed reference: all finite observations of each exposure in the declared cohort,
  # before any outcome-specific complete-case filtering. Never use outcomes here.
  z <- centered
  tables <- list(); blocks <- character(); completed <- 0L
  for(y in outcomes) {
    block <- capture.output({
      cat("\nJOINT MAIN-EFFECT OUTCOME:",y,"\n")
      tryCatch(withCallingHandlers({
        ok <- is.finite(raw[[y]]) & apply(z,1,function(v)all(is.finite(v)))
        fd <- raw[ok,c("ParticipantID","PhaseID","Datetime"),drop=FALSE]
        fd$ParticipantID <- factor(fd$ParticipantID); fd$PhaseID <- factor(fd$PhaseID)
        stamp <- as.numeric(as.POSIXct(fd$Datetime,tz="UTC"))
        bout <- interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
        fd$Time10 <- (stamp-ave(stamp,bout,FUN=min))/10
        stopifnot(all(is.finite(stamp)),!anyDuplicated(fd[,1:3]),all(abs(fd$Time10-round(fd$Time10))<1e-8))
        fd$Time10 <- as.integer(round(fd$Time10))
        design <- cbind(z[ok,,drop=FALSE],Activity_Bike=as.numeric(grepl("^Bike",fd$PhaseID))-.5)
        check <- diagnose(design)
        cat("Windows:",nrow(fd),"Participants:",nlevels(fd$ParticipantID),"Full rank:",check$rank,"Max VIF:",check$max,"Highest:",check$term,"\n")
        stopifnot(check$rank)
        original <- colnames(design); safe <- make.names(original,unique=TRUE); colnames(design)<-safe
        fd <- cbind(fd,Y=raw[[y]][ok],as.data.frame(design))
        if(y%in%H4_SPEC$hrv_log) {stopifnot(all(fd$Y>=0));keep<-fd$Y>0;fd<-fd[keep,,drop=FALSE];design<-design[keep,,drop=FALSE];fd$Y<-log(fd$Y)}
        fd <- fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
        formula <- reformulate(safe,response="Y")
        fit <- tryCatch(do_fit(formula,fd),error=function(e) {
          cat("OPTIMIZER RETRY:",conditionMessage(e),"\n");do_fit(formula,fd,"optim")
        })
        robust <- clubSandwich::coef_test(fit,vcov="CR2",cluster=fd$ParticipantID,test="Satterthwaite")
        tab <- data.frame(Outcome=y,Term=c("Intercept",original),Estimate=robust$beta,CR2_SE=robust$SE,DF=robust$df_Satt)
        tab$Low95 <- tab$Estimate-qt(.975,tab$DF)*tab$CR2_SE
        tab$High95 <- tab$Estimate+qt(.975,tab$DF)*tab$CR2_SE
        print(tab,row.names=FALSE,digits=6)
        r <- as.numeric(residuals(fit,type="normalized")); rs <- as.numeric(scale(r))
        g <- interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
        adjacent <- which(g[-1]==g[-length(g)] & diff(fd$Time10)==1L)
        cat("Residual skew:",mean(rs^3),"Excess kurtosis:",mean(rs^4)-3,"Adjacent residual correlation:",cor(r[adjacent],r[adjacent+1L]),"\n")
        print(nlme::VarCorr(fit))
        cat("STATUS: diagnostic benchmark, not an accepted final model; overlapping thermal indices/components remain jointly conditioned on.\n")
        tables[[y]] <- tab; completed <- completed+1L
      },warning=function(w) cat("JOINT MODEL WARNING:",conditionMessage(w),"\n")),error=function(e) cat("JOINT MODEL FAILED:",conditionMessage(e),"\n"))
    })
    blocks <- c(blocks,block)
    cat(paste(block,collapse="\n"),"\n")
  }
  old <- readLines(report_path,warn=FALSE)
  marker <- "=== JOINT MAIN-EFFECT CORRECTION: CURRENT STATUS ==="
  previous <- match(marker,old)
  if(!is.na(previous)) old <- old[seq.int(match("=== PRESERVED SECONDARY INTERACTION AUDIT ===",old)+1L,length(old))]
  header <- c(marker,paste("Executed:",format(Sys.time())),
    "QUESTION MAP: outline2 H4 concerns environmental associations; signed ethics p4 concerns noise/activity amplification. These are different estimands, not interchangeable H4 tests.",
    "This run evaluates the missing joint-main-effects specification as a diagnostic benchmark, not a silently agreed new primary analysis or regularized model.",
    paste("Equation: Y ~",paste(c(selected,"Activity_Bike"),collapse=" + "),"+ participant and participant-phase random intercepts; discrete within-bout AR1."),
    "Exposure centring: finite exposure-specific cohort observations per participant, independent of outcome availability; native units. Outcomes retain existing HRV natural log declarations.",
    "Independent units: 10-11 participants, not the repeated windows. No variable deletion, no winner selection, no ordinary significance claims.",
    "All ten survivors are included to expose the joint design, NOT to endorse simultaneous adjustment for thermal indices and their components. High VIF and low df can prevent interpretable individual effects.",
    paste("Fits successful:",completed,"of",length(outcomes)),
    "Earlier interaction estimates use outcome-specific centring and remain secondary historical results; do not compare their coefficients as though using this new reference.",
    "Earlier UNFINISHED VALIDATION text is superseded: participant-deletion/support/curvature checks were executed for the old interaction models. Those checks do not validate this new joint model.",
    "Intervals are nominal descriptive post-selection intervals, not multiplicity- or selection-adjusted. No confirmatory p-values are released; no claim of measured perceived thermal discomfort.",
    "Methods: nlme https://stat.ethz.ch/R-manual/R-devel/library/nlme/html/lme.html ; CR2 https://jepusto.github.io/clubSandwich/reference/vcovCR.lme.html",
    "Workflow provenance: Kassis, Agarwal, He, Patel & Brueckner (2026), Scientific Agent Skills, https://doi.org/10.48550/arXiv.2609.00065 (not validation of this statistical model).")
  stopifnot(identical(before,tools::md5sum(frozen)))
  writeLines(c(header,sub("[[:space:]]+$","",blocks),"=== PRESERVED SECONDARY INTERACTION AUDIT ===",old),report_path)
  cat("SAVED:",report_path,"\n")
}
ridge_fit <- function(fd,opt="nlminb") {
  terms <- grep("^R[0-9]+$",names(fd),value=TRUE)
  nlme::lme(Y ~ Activity_Bike,data=fd,
    random=list(RidgeGroup=nlme::pdIdent(reformulate(terms,intercept=FALSE)),ParticipantID=~1,PhaseID=~1),
    correlation=nlme::corAR1(value=.2,form=~Time10|RidgeGroup/ParticipantID/PhaseID),
    method="REML",na.action=na.fail,
    control=nlme::lmeControl(maxIter=100,msMaxIter=200,returnObject=FALSE,opt=opt))
}
ridge_equations <- function(fit,fd) {
  # Independent check of nlme's BLUP using the penalized normal equations.
  # The global coefficient variance is a ridge prior, NOT a participant slope variance.
  terms <- grep("^R[0-9]+$",names(fd),value=TRUE); p <- length(terms)
  re <- fit$modelStruct$reStruct
  tau <- as.numeric(as.matrix(re$RidgeGroup)[1,1])*fit$sigma^2
  vp <- as.numeric(as.matrix(re$ParticipantID)[1,1])*fit$sigma^2
  vb <- as.numeric(as.matrix(re$PhaseID)[1,1])*fit$sigma^2
  rho <- as.numeric(coef(fit$modelStruct$corStruct,unconstrained=FALSE))
  precision <- matrix(0,p+2L,p+2L); rhs <- numeric(p+2L)
  for(id in levels(fd$ParticipantID)) {
    d <- fd[fd$ParticipantID==id,,drop=FALSE]
    same <- outer(as.character(d$PhaseID),as.character(d$PhaseID),"==")
    covariance <- vp + vb*same + fit$sigma^2*same*rho^abs(outer(d$Time10,d$Time10,"-"))
    design <- cbind(1,d$Activity_Bike,as.matrix(d[,terms,drop=FALSE]))
    ch <- chol(covariance)
    wx <- forwardsolve(t(ch),design); wy <- forwardsolve(t(ch),d$Y)
    precision <- precision+crossprod(wx); rhs <- rhs+as.numeric(crossprod(wx,wy))
  }
  stopifnot(is.finite(tau),tau>0)
  penalty <- diag(c(0,0,rep(1/tau,p)))
  post <- chol2inv(chol(precision+penalty)); b <- as.numeric(post%*%rhs)
  expected <- c(nlme::fixef(fit),as.numeric(nlme::ranef(fit,level=1)[1,terms]))
  stopifnot(length(b)==length(expected),max(abs(b-expected))<1e-5*(1+max(abs(expected))))
  ix <- seq.int(3L,p+2L)
  information <- precision[ix,ix,drop=FALSE]-precision[ix,1:2,drop=FALSE]%*%solve(precision[1:2,1:2],precision[1:2,ix,drop=FALSE])
  list(beta=b[ix],posterior_sd=sqrt(diag(post)[ix]),lambda=fit$sigma^2/tau,
    edf=p-sum(diag(post)[ix])/tau,rho=rho,
    raw_condition=kappa(information,exact=TRUE),ridge_condition=kappa(information+diag(1/tau,p),exact=TRUE),
    variances=c(Ridge=tau,Participant=vp,Bout=vb,Residual=fit$sigma^2))
}
ridge_selfcheck <- function() {
  set.seed(20261008)
  n <- 240L
  d <- data.frame(RidgeGroup=factor(rep("all",n)),ParticipantID=factor(rep(1:8,each=30)),
    PhaseID=factor(rep(rep(1:3,each=10),8)),Time10=rep(0:9,24),Activity_Bike=rep(c(-.5,.5),n/2),R01=rnorm(n))
  d$R02 <- d$R01; d$R03 <- rnorm(n); d$Y <- 2*d$R01+.2*d$R03+rnorm(n)
  f <- ridge_fit(d); v <- ridge_equations(f,d)
  stopifnot(all(is.finite(v$beta)),abs(v$beta[1]-v$beta[2])<1e-6,v$ridge_condition<v$raw_condition)
  # Swapping duplicated exposure columns must not privilege their order.
  d <- d[,c(setdiff(names(d),c("R01","R02","R03")),"R03","R02","R01")]
  b <- ridge_equations(ridge_fit(d),d)$beta
  stopifnot(max(abs(v$beta-b[c(3,2,1)]))<1e-5)
  cat("RIDGE SELFCHECK PASSED: duplicate columns retained equally; column-order invariance; BLUP equals penalized equations.\n")
}
ridge_outcome <- function(y,raw,ridge_z,ridge_scale,ridge_candidates,hrv_log) {
  options(width=220)
  block <- capture.output({
    cat("\nRIDGE10 OUTCOME:",y,"\n")
    success <- tryCatch(withCallingHandlers({
      ok <- is.finite(raw[[y]]) & apply(ridge_z,1,function(v)all(is.finite(v)))
      fd <- raw[ok,c("ParticipantID","PhaseID","Datetime"),drop=FALSE]
      fd$ParticipantID<-factor(fd$ParticipantID);fd$PhaseID<-factor(fd$PhaseID);fd$RidgeGroup<-factor("all")
      stamp <- as.numeric(as.POSIXct(fd$Datetime,tz="UTC"));bout <- interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
      fd$Time10 <- (stamp-ave(stamp,bout,FUN=min))/10
      stopifnot(all(is.finite(stamp)),all(abs(fd$Time10-round(fd$Time10))<1e-8),!anyDuplicated(fd[,1:3]))
      fd$Time10<-as.integer(round(fd$Time10));fd$Activity_Bike<-as.numeric(grepl("^Bike",fd$PhaseID))-.5
      values<-raw[[y]][ok];transform<-"native";keep<-rep(TRUE,length(values))
      if(y%in%hrv_log) {stopifnot(all(values>=0));keep<-values>0;values<-log(values[keep]);transform<-"natural log"}
      fd<-fd[keep,,drop=FALSE]
      sy<-sd(values);stopifnot(is.finite(sy),sy>0)
      fd$Y<-(values-mean(values))/sy
      e<-ridge_z[ok,,drop=FALSE][keep,,drop=FALSE];colnames(e)<-sprintf("R%02d",seq_along(ridge_candidates))
      fd<-cbind(fd,as.data.frame(e));fd<-fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
      refit<-function(data) tryCatch(ridge_fit(data),error=function(e) {
        cat("RIDGE OPTIMIZER RETRY:",conditionMessage(e),"\n");ridge_fit(data,"optim")
      })
      fit<-refit(fd);v<-ridge_equations(fit,fd)
      cat("Sample:",nrow(fd),"windows;",nlevels(fd$ParticipantID),"participants;",nlevels(interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)),"bouts; transformation:",transform,"\n")
      print(data.frame(Participant=levels(fd$ParticipantID),Available=as.numeric(table(fd$ParticipantID)),Total=as.numeric(table(factor(raw$ParticipantID,levels=levels(fd$ParticipantID))))),row.names=FALSE)
      cat("Absent participants:",paste(setdiff(unique(raw$ParticipantID),levels(fd$ParticipantID)),collapse=", "),"\n")
      cat("Lambda sigma2/tau2:",v$lambda,"; environmental effective df:",v$edf,"/",length(ridge_candidates),"; AR1:",v$rho,"\n")
      cat("Exposure information condition number before/after ridge:",v$raw_condition,v$ridge_condition,"\n")
      cat("Variance components:\n");print(v$variances)
      # Delete-one-participant stability is not held-out prediction or a confidence interval.
      deleted<-lapply(levels(fd$ParticipantID),function(id) tryCatch({
        sub<-droplevels(fd[fd$ParticipantID!=id,,drop=FALSE]);b<-ridge_equations(refit(sub),sub)$beta
        list(id=id,b=b)
      },error=function(e) {cat("RIDGE DELETION FAILED:",id,conditionMessage(e),"\n");list(id=id,error=conditionMessage(e))}))
      good<-Filter(function(x)is.null(x$error),deleted)
      tab<-data.frame(Variable=ridge_candidates,Standardized_Beta=v$beta,
        AnalysisScale_Beta=v$beta*sy/ridge_scale,Conditional_Posterior_SD=v$posterior_sd)
      if(length(good)) {
        db<-do.call(rbind,lapply(good,function(x)x$b))
        tab$Delete_Min<-apply(db,2,min);tab$Delete_Max<-apply(db,2,max)
        tab$Delete_Sign_Flips<-colSums(sign(db)!=matrix(sign(v$beta),nrow(db),length(ridge_candidates),byrow=TRUE))
      }
      stopifnot(nrow(tab)==length(ridge_candidates),setequal(tab$Variable,ridge_candidates),all(is.finite(tab$Standardized_Beta)))
      print(tab,row.names=FALSE,digits=6)
      cat("Deletion stability:",length(good),"/",length(deleted),"fits; reference scales held fixed, ridge penalty and covariance re-estimated.\n")
      rn<-as.numeric(residuals(fit,type="normalized"));rs<-as.numeric(scale(rn))
      g<-interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
      pairs<-which(g[-1]==g[-length(g)] & diff(fd$Time10)==1L)
      lag1<-if(length(pairs)>2L) cor(rn[pairs],rn[pairs+1L]) else NA_real_
      skew<-mean(rs^3);kurt<-mean(rs^4)-3
      flags<-character()
      if(abs(skew)>2||abs(kurt)>7) flags<-c(flags,"RESIDUAL_TAIL_REVIEW")
      if(is.finite(lag1)&&abs(lag1)>.2) flags<-c(flags,"REMAINING_SERIAL_CORRELATION")
      if(any(v$variances[c("Participant","Bout")]<1e-6*v$variances["Residual"])) flags<-c(flags,"NEAR_BOUNDARY_VARIANCE")
      if(v$variances["Ridge"]<1e-6*v$variances["Residual"]) flags<-c(flags,"EXPOSURE_BLOCK_SHRUNK_NEAR_ZERO")
      if(length(good)<length(deleted)) flags<-c(flags,"INCOMPLETE_DELETION_STABILITY")
      cat("Residual skew:",skew,"excess kurtosis:",kurt,"adjacent lag1:",lag1,"\n")
      cat("RIDGE DIAGNOSTIC FLAGS:",if(length(flags)) paste(flags,collapse="; ") else "No listed flag; not proof of model validity","\n")
      cat("All ",length(ridge_candidates)," Step-4 union exposures retained in equation; nonzero ridge coefficient is NOT evidence of an association.\n",sep="")
      TRUE
    },warning=function(w) cat("RIDGE WARNING:",conditionMessage(w),"\n")),error=function(e) {cat("RIDGE FAILED:",conditionMessage(e),"\n");FALSE})
    cat("RIDGE10 COMPLETE:",y,"successful",success,"\n")
  })
  sub("[[:space:]]+$","",block)
}
run_ridge10 <- function() {
  ridge_selfcheck()
  ridge_candidates<-selected
  stopifnot(length(ridge_candidates)==10L,!anyDuplicated(ridge_candidates),
    setequal(ridge_candidates,audit$Variable_Name[audit$Step4_Empatica_Decision=="Retained"|audit$Step4_Eyetracker_Decision=="Retained"]))
  stopifnot(all(ridge_candidates%in%names(raw)))
  ridge_z<-as.matrix(raw[,ridge_candidates,drop=FALSE]);storage.mode(ridge_z)<-"double"
  for(j in seq_along(ridge_candidates)) {
    ok<-is.finite(ridge_z[,j]);means<-tapply(ridge_z[ok,j],raw$ParticipantID[ok],mean)
    ridge_z[,j]<-ridge_z[,j]-means[as.character(raw$ParticipantID)]
    stopifnot(max(abs(tapply(ridge_z[ok,j],raw$ParticipantID[ok],mean)))<1e-8)
  }
  ridge_scale<-apply(ridge_z,2,function(v)sd(v[is.finite(v)]))
  stopifnot(all(is.finite(ridge_scale)),all(ridge_scale>0))
  ridge_z<-sweep(ridge_z,2,ridge_scale,"/")
  hrv_log<-H4_SPEC$hrv_log
  method<-c("JOINT REGULARIZED ENVIRONMENTAL ASSOCIATIONS: STEP-4 EMPATICA + EYE-TRACKER UNION (10 VARIABLES)",
    paste("Equation: Y = intercept + Mode +",paste(ridge_candidates,collapse=" + "),"+ participant intercept + participant-phase intercept + AR1 residual."),
    "Environmental coefficients have one shared zero-mean Gaussian prior: beta_j ~ N(0,tau2). This is an L2 ridge penalty, not participant-varying exposure slopes. Intercept and Mode are unpenalized.",
    "Penalty lambda=sigma2/tau2 and covariance parameters estimated jointly by REML using nlme::lme/pdIdent. No CV minimum-error/one-SE rule and no VIF-based deletion. A variance boundary can shrink the whole exposure block towards zero.",
    "Predictor set is exactly the union of Step4 variables marked Retained in either separate family LASSO: 9 Empatica selections and 6 eye-tracker selections, with 5 shared, yielding 10 unique variables. Seven other Step3 candidates were not selected by either family; Clearness_Index_G0 and ucm_fp were not entered in Step4.",
    "Full-cohort exposure-only participant means and pooled within-person SDs fixed across outcomes; no outcome-guided feature centring. Outcomes scaled for numerical stability; existing HRV natural log declaration retained. AnalysisScale_Beta reverses standardization, but remains on natural log outcome scale for declared HRV outcomes.",
    "26 continuous sensor summaries fitted separately, not one complete-26 response matrix; independent observational units are participants. Ordinal questionnaire responses are not included in these Gaussian sensor models.",
    "Rows require finite values for all 10 union predictors and the current outcome. No imputation or sensor data alteration. Sample restriction can bias estimates if missingness is informative; complete-case analysis is not asserted ignorable.",
    "Coefficient posterior SDs condition on estimated variance components and this Gaussian ridge model; not CR2, simultaneous, selection-adjusted, or uncertainty in the penalty. Deletion ranges are stability diagnostics, NOT confidence intervals. No p-values, significant-variable shortlist, or causal claims.",
    "Thermal components and indices are included as correlated prediction/association features; ridge does not make their independent physical effects identifiable. Do not interpret their coefficients as separable causal thermal effects.",
    "This joint main-effects specification addresses environmental-response associations, not the ethics noise/activity amplification hypothesis or directly measured thermal perception. Historical interactions remain secondary.",
    "Implementation check: nlme BLUPs independently reproduced from penalized normal equations for every full and deletion fit; duplicate-column and permutation tests required.",
    "Scientific basis: Eliot, Ferguson, Reilly & Foulkes (2011), Ridge regression for longitudinal biomarker data, doi:10.2202/1557-4679.1353 (mixed ridge precedent; not a claim of exact replication).",
    "REML ridge equivalence: Shen, Alam, Fikse & Ronnegard (2013), doi:10.1534/genetics.112.146720. Implementation: https://stat.ethz.ch/R-manual/R-devel/library/nlme/html/pdIdent.html ; Pinheiro & Bates (2000).",
    "Workflow provenance: Kassis, Agarwal, He, Patel & Brueckner (2026), doi:10.48550/arXiv.2609.00065; procedural review only, not statistical validation.",
    paste("R",getRversion(),"nlme",packageVersion("nlme")))
  inventory<-capture.output({
    eligible<-audit$Step3_Decision=="Retained"
    union_flag<-audit$Step4_Empatica_Decision=="Retained"|audit$Step4_Eyetracker_Decision=="Retained"
    reason<-ifelse(union_flag[eligible],"Included: selected by at least one Step-4 response family",
      ifelse(audit$Step4_Empatica_Decision[eligible]=="Not entered"|audit$Step4_Eyetracker_Decision[eligible]=="Not entered",
        "Not entered in either Step-4 LASSO", "Not selected by either Step-4 LASSO"))
    cat("VARIABLE ACCOUNTING (19 Step-3 candidates;17 entered in Step 4;10 in the Step-4 union):\n")
    print(data.frame(Variable=audit$Variable_Name[eligible],Step4_Union=ifelse(union_flag[eligible],"Included","Not included"),Reason=reason),row.names=FALSE)
    cat("Exposure coverage and fixed within-person SD:\n")
    print(data.frame(Variable=ridge_candidates,Finite=colSums(is.finite(ridge_z)),Missing=colSums(!is.finite(ridge_z)),Within_SD=ridge_scale),row.names=FALSE)
    concentration<-lapply(seq_along(ridge_candidates),function(j) {
      sums<-tapply(ridge_z[,j]^2,raw$ParticipantID,function(v)sum(v[is.finite(v)]))
      data.frame(Variable=ridge_candidates[j],Largest_Contributor=names(sums)[which.max(sums)],Variation_Share=max(sums)/sum(sums))
    })
    cat("Participant concentration of available within-person exposure variation (not outcome-specific):\n")
    print(do.call(rbind,concentration),row.names=FALSE)
  })
  if(identical(Sys.getenv("H4_STEP5_RIDGE_PILOT"),"1")) {
    cat(paste(c(method,inventory,ridge_outcome(outcomes[1L],raw,ridge_z,ridge_scale,ridge_candidates,hrv_log)),collapse="\n"),"\n")
    stopifnot(identical(before,tools::md5sum(frozen)));return(invisible(NULL))
  }
  stamp<-paste(unname(tools::md5sum(c(data_path,audit_path,file.path(root,"scripts/H4_multivariate.R"),file.path(root,"scripts/h4_step5_equations.R")))),collapse="-")
  marker<-paste("=== RIDGE10 RUN:",stamp,"===")
  old<-readLines(report_path,warn=FALSE);boundary<-"=== PRE-RIDGE HISTORICAL AUDIT ==="
  history<-old;blocks<-character()
  if(length(old)&&identical(old[1L],marker)) {
    end<-match(boundary,old);start<-grep("^RIDGE10 OUTCOME:",old)
    stopifnot(!is.na(end))
    if(length(start)) blocks<-old[min(start):(end-1L)]
    history<-old[seq.int(end+1L,length(old))]
  }
  done<-sub("^RIDGE10 COMPLETE: ([^ ]+).*","\\1",grep("^RIDGE10 COMPLETE:",blocks,value=TRUE))
  jobs<-setdiff(outcomes,done)
  header<-c(marker,method,inventory)
  save_checkpoint<-function() {
    stopifnot(identical(before,tools::md5sum(frozen)))
    # Transient staging file, removed by atomic replace; never an extra deliverable.
    stage<-tempfile(pattern=".ridge10_",tmpdir=dirname(report_path))
    on.exit(if(file.exists(stage)) unlink(stage),add=TRUE)
    writeLines(c(header,blocks,boundary,history),stage)
    status<-system2("python",c("-c",shQuote("import os,sys; os.replace(sys.argv[1],sys.argv[2])"),shQuote(stage),shQuote(report_path)))
    stopifnot(status==0L)
  }
  save_checkpoint()
  if(length(jobs)) {
    workers<-min(8L,length(jobs));cl<-parallel::makeCluster(workers);on.exit(parallel::stopCluster(cl))
    parallel::clusterExport(cl,c("raw","ridge_z","ridge_scale","ridge_candidates","hrv_log","ridge_fit","ridge_equations","ridge_outcome"),envir=environment())
    worker<-function(y) ridge_outcome(y,raw,ridge_z,ridge_scale,ridge_candidates,hrv_log)
    environment(worker)<-globalenv()
    for(start in seq.int(1L,length(jobs),by=workers)) {
      batch<-jobs[start:min(start+workers-1L,length(jobs))]
      result<-parallel::parLapplyLB(cl,batch,worker)
      blocks<-c(blocks,unlist(result,use.names=FALSE));save_checkpoint()
      cat("RIDGE10 CHECKPOINT:",length(grep("^RIDGE10 COMPLETE:",blocks)),"/26 outcomes saved; all 10 union coefficients per successful outcome.\n")
    }
  }
  complete<-grep("^RIDGE10 COMPLETE:",blocks,value=TRUE)
  stopifnot(length(complete)==26L,!anyDuplicated(sub(" successful.*","",complete)))
  header<-c(header,paste("FINAL EXECUTION: outcomes",length(complete),"successful",sum(grepl("successful TRUE",complete,fixed=TRUE)),"failed",sum(grepl("successful FALSE",complete,fixed=TRUE))),
    "Execution completion is not universal model acceptance. Residual warnings and deletion failures remain outcome-specific below.")
  save_checkpoint();cat("SAVED:",report_path,"\n")
}
h4_model_dir <- file.path(root,"output/statistical_analysis/H4_multivariate/H4_models")
h4_equation_catalog <- function() {
  blocks <- c("no_products","heat_x_sound","heat_x_activity","both_products")
  tests <- c("Base","Noise","Activity","Joint")
  rows <- list()
  id <- 0L
  for(m in names(thermal)) for(k in seq_along(blocks)) {
    id <- id + 1L
    vars <- thermal[[m]]
    raw_terms <- c(nonthermal, vars, "Activity_Bike")
    if(blocks[k] %in% c("heat_x_sound","both_products")) raw_terms <- c(raw_terms, paste0(vars, ":SND_dBA"))
    if(blocks[k] %in% c("heat_x_activity","both_products")) raw_terms <- c(raw_terms, paste0(vars, ":Activity_Bike"))
    role <- if(m=="Components") paste(paste0(component_set, "=", component_role), collapse="; ") else if(length(vars)) "within-person selected" else "heat index omitted because it is not in the within-person union"
    rows[[id]] <- data.frame(equation_id=id, heat_form=m, block=blocks[k], test=tests[k], terms=paste(vapply(raw_terms, h4_spell_term, character(1)), collapse=" + "), heat_role=role, fitted=FALSE, stringsAsFactors=FALSE)
  }
  out <- do.call(rbind, rows)
  stopifnot(nrow(out)==16L, out$equation_id[1]==1L, out$heat_form[1]=="Components", out$block[1]=="no_products", out$equation_id[4]==4L, out$block[4]=="both_products")
  out
}
h4_spell_term <- function(term) {
  pretty <- c(ucm_SND_dBA="sound",SND_dBA="sound",atmo_pm1_avg="PM1",atmo_pm2.5_avg="PM2.5",gvi_50m="GVI",Clearness_Index="clearness",lys_lux_avg="lux",lys_kelvin_avg="colour temperature",ucm_SUN_Gh="global solar radiation",ucm_WIND_TWS="wind",ucm_AIR_temp="air temperature",ucm_AIR_RH="humidity",ucm_MRT="mean radiant temperature",ucm_HUMIDEX="HUMIDEX",ucm_PET="PET",ucm_UTCI="UTCI",Activity_Bike="activity")
  spell_one <- function(x) if(x %in% names(pretty)) unname(pretty[[x]]) else x
  if(grepl(":",term,fixed=TRUE)) {
    parts <- strsplit(term,":",fixed=TRUE)[[1]]
    paste0("(",spell_one(parts[1])," x ",spell_one(parts[2]),")")
  } else spell_one(term)
}
h4_heat_hypothesis_term <- function(term, heat_vars) {
  if(term %in% heat_vars) return(TRUE)
  if(!grepl(":",term,fixed=TRUE)) return(FALSE)
  parts <- strsplit(term,":",fixed=TRUE)[[1]]
  any(parts %in% heat_vars)
}
h4_status_row <- function(y,eq_rows,success,note,d0,transformation,n = nrow(d0),sd = NA_real_,rho = NA_real_,lag1 = NA_real_,
                          skew = NA_real_,kurtosis = NA_real_,boundary = NA,min_df = NA_real_,min_df_heat = NA_real_,
                          converged = FALSE,n_adjacent = 0L) {
  data.frame(equation_id=eq_rows$equation_id,heat_form=eq_rows$heat_form,block=eq_rows$block,outcome=y,
    success=success,n=n,n_participants=length(unique(d0$ParticipantID)),transformation=transformation,
    converged=converged,residual_sd=sd,ar1_rho=rho,lag1_normalized=lag1,n_adjacent=n_adjacent,
    residual_skew=skew,residual_excess_kurtosis=kurtosis,boundary_variance=boundary,min_cr2_df=min_df,min_cr2_df_heat=min_df_heat,
    participant_ids=paste(sort(unique(as.character(d0$ParticipantID))),collapse=";"),
    n_available_outcome=sum(is.finite(raw[[y]])),n_removed=nrow(raw)-n,
    note=note,stringsAsFactors=FALSE)
}
h4_prep_outcome <- function(y,required,drop_participant = NULL) {
  vals <- as.matrix(raw[,c(required,y),drop=FALSE]); storage.mode(vals) <- "double"
  ok <- apply(vals,1,function(v) all(is.finite(v)))
  d0 <- raw[ok,c("ParticipantID","PhaseID","Datetime"),drop=FALSE]
  prep <- list(ok=TRUE,y=y,d0=d0,z=centered[ok,,drop=FALSE],yv=vals[ok,y])
  fail <- function(note,n = 0L) list(ok=FALSE,y=y,d0=d0,note=note,n=n)
  if(!is.null(drop_participant)) {
    keep <- as.character(prep$d0$ParticipantID) != as.character(drop_participant)
    prep$d0 <- prep$d0[keep,,drop=FALSE]; prep$z <- prep$z[keep,,drop=FALSE]; prep$yv <- prep$yv[keep]
  }
  if(!nrow(prep$d0)) return(fail("no complete cases"))
  if(y %in% H4_SPEC$hrv_log) {
    if(any(prep$yv<0,na.rm=TRUE)) return(fail("negative value prevents natural log",nrow(prep$d0)))
    keep <- is.finite(prep$yv) & prep$yv>0
    prep$d0 <- prep$d0[keep,,drop=FALSE]; prep$z <- prep$z[keep,,drop=FALSE]; prep$yv <- log(prep$yv[keep])
    if(!nrow(prep$d0)) return(fail("no strictly positive values for natural log"))
  }
  prep$d0$ParticipantID <- factor(prep$d0$ParticipantID); prep$d0$PhaseID <- factor(prep$d0$PhaseID)
  stamp <- as.numeric(as.POSIXct(prep$d0$Datetime,tz="UTC"))
  if(!all(is.finite(stamp)) || anyDuplicated(prep$d0[,c("ParticipantID","PhaseID","Datetime")])) return(fail("non-finite or duplicated timestamps",nrow(prep$d0)))
  bout <- interaction(prep$d0$ParticipantID,prep$d0$PhaseID,drop=TRUE)
  prep$d0$Time10 <- as.integer(round((stamp-ave(stamp,bout,FUN=min))/10))
  if(!all(abs((stamp-ave(stamp,bout,FUN=min))/10 - prep$d0$Time10)<1e-8)) return(fail("timestamps are not integer 10-second steps",nrow(prep$d0)))
  prep$mode <- as.numeric(grepl("^Bike",prep$d0$PhaseID))-.5
  prep
}
h4_fit_equation <- function(prep,eq,point_only = FALSE) {
  y <- prep$y; d0 <- prep$d0; z <- prep$z; yv <- prep$yv; mode <- prep$mode
  transformation <- if(y %in% H4_SPEC$hrv_log) "natural log" else "native"
  status_row <- function(success,note,n = nrow(d0),sd = NA_real_,rho = NA_real_,lag1 = NA_real_,
                         skew = NA_real_,kurtosis = NA_real_,boundary = NA,min_df = NA_real_,min_df_heat = NA_real_,
                         converged = FALSE,n_adjacent = 0L)
    h4_status_row(y,eq,success,note,d0,transformation,n,sd,rho,lag1,skew,kurtosis,boundary,min_df,min_df_heat,converged,n_adjacent)
  stage <- "design"; nlminb_msg <- ""; numerical_warnings <- character(); converged <- FALSE
  result <- tryCatch(withCallingHandlers({
    design <- make_design(z,thermal[[eq$heat_form]],mode,eq$test)
    original <- colnames(design)
    declared <- strsplit(eq$terms," + ",fixed=TRUE)[[1]]
    if(!setequal(vapply(original,h4_spell_term,character(1)),declared)) stop("term list does not match the declared equation")
    if(!diagnose(design)$rank) stop("fixed-effect design is not full rank; no term deleted")
    safe <- make.names(original,unique=TRUE); colnames(design) <- safe
    fd <- cbind(d0,Y=yv,as.data.frame(design))
    fd <- fd[order(fd$ParticipantID,fd$PhaseID,fd$Time10),]
    stage <- "nlme fit"
    formula <- reformulate(safe,response="Y")
    fit <- tryCatch(do_fit(formula,fd,"nlminb"),error=function(e) {
      nlminb_msg <<- conditionMessage(e)
      do_fit(formula,fd,"optim")
    })
    converged <- TRUE
    stage <- "CR2 uncertainty"
    robust <- if(isTRUE(point_only)) data.frame(beta=nlme::fixef(fit),SE=NA_real_,df_Satt=NA_real_) else
      clubSandwich::coef_test(fit,vcov="CR2",cluster=fd$ParticipantID,test="Satterthwaite")
    coefficient <- data.frame(equation_id=eq$equation_id,heat_form=eq$heat_form,block=eq$block,outcome=y,
      term=c("Intercept",original),estimate=robust$beta,se=robust$SE,df=robust$df_Satt,stringsAsFactors=FALSE)
    coefficient$ci_low <- coefficient$estimate - qt(.975,coefficient$df)*coefficient$se
    coefficient$ci_high <- coefficient$estimate + qt(.975,coefficient$df)*coefficient$se
    coefficient$t_stat <- coefficient$estimate/coefficient$se
    coefficient$p_value <- 2*pt(-abs(coefficient$t_stat),coefficient$df)
    coefficient$q_value <- NA_real_
    coefficient <- coefficient[,c("equation_id","heat_form","block","outcome","term","estimate","se","df","ci_low","ci_high","t_stat","p_value","q_value")]
    # Innermost conditional residuals, whitened by the fitted AR1 covariance.
    rn <- residuals(fit,level=2,type="normalized")
    grp <- interaction(fd$ParticipantID,fd$PhaseID,drop=TRUE)
    adj <- which(as.character(grp[-1])==as.character(grp[-length(grp)]) & abs(diff(fd$Time10)-1)<1e-6)
    lag1 <- if(length(adj)>2) stats::cor(rn[adj],rn[adj+1]) else NA_real_
    rho <- tryCatch(unname(coef(fit$modelStruct$corStruct,unconstrained=FALSE)),error=function(e) NA_real_)
    rc <- rn-mean(rn); rms <- sqrt(mean(rc^2))
    skew <- mean((rc/rms)^3); kurtosis <- mean((rc/rms)^4)-3
    variance_text <- nlme::VarCorr(fit)[,"Variance"]
    random_var <- as.numeric(variance_text[grepl("^[0-9.+eE-]+$",variance_text)])
    boundary <- any(random_var[is.finite(random_var)] < 1e-6*sigma(fit)^2)
    heat_vars <- thermal[[eq$heat_form]]
    coef_df <- coefficient[coefficient$term!="Intercept",]
    min_df <- if(point_only || !nrow(coef_df)) NA_real_ else min(coef_df$df,na.rm=TRUE)
    heat_df <- coef_df[vapply(coef_df$term,h4_heat_hypothesis_term,logical(1),heat_vars=heat_vars),,drop=FALSE]
    min_df_heat <- if(point_only || !nrow(heat_df)) NA_real_ else min(heat_df$df,na.rm=TRUE)
    flags <- c(if(is.finite(lag1)&&abs(lag1)>.2) "REMAINING_SERIAL_CORRELATION",
               if(abs(skew)>2||abs(kurtosis)>7) "RESIDUAL_TAIL_SHAPE",
               if(boundary) "BOUNDARY_VARIANCE",
               if(is.finite(min_df_heat)&&min_df_heat<4) "LOW_EFFECTIVE_DF_HEAT",
               if(is.finite(min_df)&&min_df<4&&( !is.finite(min_df_heat)||min_df_heat>=4)) "LOW_CR2_DF_COVARIATE",
               if(nzchar(nlminb_msg)) paste0("nlminb failed (",nlminb_msg,"); optim used"),
               if(length(numerical_warnings)) paste(unique(numerical_warnings),collapse="; "))
    list(ok=TRUE,coef=coefficient,status=status_row(TRUE,paste(flags,collapse="; "),sd=sigma(fit),rho=if(length(rho)==1L) rho else NA_real_,lag1=lag1,
      skew=skew,kurtosis=kurtosis,boundary=boundary,min_df=min_df,min_df_heat=min_df_heat,converged=converged,n_adjacent=length(adj)))
  },warning=function(w) { numerical_warnings <<- c(numerical_warnings,conditionMessage(w)) }),
  error=function(e) list(ok=FALSE,coef=NULL,status=status_row(FALSE,paste0("FAILED at ",stage,": ",conditionMessage(e),
    if(length(numerical_warnings)) paste0("; warnings: ",paste(unique(numerical_warnings),collapse="; "))),converged=converged)))
  message("Fit ",y," equation ",eq$equation_id," success=",isTRUE(result$ok))
  list(status=result$status,coef=if(isTRUE(result$ok)) result$coef else NULL)
}
fit_h4_outcome <- function(y, equation_ids = NULL, drop_participant = NULL, point_only = FALSE) {
  catalog <- h4_equation_catalog()
  if(is.null(equation_ids)) equation_ids <- 12L
  eqs <- catalog[catalog$equation_id %in% equation_ids,,drop=FALSE]
  stopifnot(nrow(eqs)>0L)
  # Paired equations share their actual required exposures, not unused indices.
  required <- unique(c(nonthermal,unlist(thermal[unique(eqs$heat_form)],use.names=FALSE)))
  prep <- h4_prep_outcome(y,required,drop_participant)
  if(!prep$ok) {
    tf <- if(y %in% H4_SPEC$hrv_log) "natural log" else "native"
    return(list(status=h4_status_row(y,eqs,FALSE,prep$note,prep$d0,tf,n=prep$n),coef=fit_h4_outcome_empty_coef()))
  }
  res <- lapply(seq_len(nrow(eqs)),function(i) h4_fit_equation(prep,eqs[i,],point_only))
  ok <- !vapply(res,function(r) is.null(r$coef),logical(1))
  list(status=do.call(rbind,lapply(res,`[[`,"status")),
       coef=if(any(ok)) do.call(rbind,lapply(res[ok],`[[`,"coef")) else fit_h4_outcome_empty_coef())
}
fit_h4_outcome_empty_coef <- function() {
  data.frame(equation_id=integer(),heat_form=character(),block=character(),outcome=character(),term=character(),estimate=numeric(),se=numeric(),df=numeric(),ci_low=numeric(),ci_high=numeric(),t_stat=numeric(),p_value=numeric(),q_value=numeric(),stringsAsFactors=FALSE)
}
h4_ci_excludes_0 <- function(lo,hi) is.finite(lo) & is.finite(hi) & (hi<0 | lo>0)
h4_pull_term <- function(coef,outcome,heat_form,term) {
  hit <- coef[coef$outcome==outcome & coef$heat_form==heat_form & coef$block=="both_products" & coef$term==term,,drop=FALSE]
  if(nrow(hit)!=1L) return(list(estimate=NA_real_,ci_low=NA_real_,ci_high=NA_real_,excludes=FALSE,p_value=NA_real_,q_value=NA_real_))
  list(estimate=hit$estimate,ci_low=hit$ci_low,ci_high=hit$ci_high,excludes=h4_ci_excludes_0(hit$ci_low,hit$ci_high),
    p_value=hit$p_value,q_value=hit$q_value)
}
write_h4_hypothesis_table <- function(status,coef) {
  pieces <- list(
    Components=c("air temperature"="ucm_AIR_temp","humidity"="ucm_AIR_RH","mean radiant temperature"="ucm_MRT"),
    HUMIDEX=c("HUMIDEX"="ucm_HUMIDEX","mean radiant temperature"="ucm_MRT"),
    PET=c(PET="ucm_PET"),
    UTCI=c(UTCI="ucm_UTCI")
  )
  joined <- c(Components="air temperature + humidity + mean radiant temperature",HUMIDEX="HUMIDEX",PET="PET",UTCI="UTCI")
  rows <- list()
  joint <- status[status$block=="both_products",,drop=FALSE]
  for(y in outcomes) for(m in names(pieces)) {
    st <- joint[joint$outcome==y & joint$heat_form==m,,drop=FALSE]
    stopifnot(nrow(st)==1L)
    for(component in names(pieces[[m]])) {
      var <- unname(pieces[[m]][[component]])
      heat_term <- if(m=="Components") unname(joined[[m]]) else component
      heat <- h4_pull_term(coef,y,m,var)
      sound <- h4_pull_term(coef,y,m,paste0(var,":SND_dBA"))
      activity <- h4_pull_term(coef,y,m,paste0(var,":Activity_Bike"))
      if(!isTRUE(st$success)) {
        heat$excludes <- FALSE; sound$excludes <- FALSE; activity$excludes <- FALSE
      }
      rows[[length(rows)+1L]] <- data.frame(
        outcome=y,transformation=st$transformation,heat_form=m,component=component,
        n=st$n,n_participants=st$n_participants,success=st$success,
        heat_term=heat_term,
        heat_estimate=heat$estimate,heat_ci_low=heat$ci_low,heat_ci_high=heat$ci_high,heat_ci_excludes_0=heat$excludes,
        heat_p_value=heat$p_value,heat_q_value=heat$q_value,
        sound_product_estimate=sound$estimate,sound_product_ci_low=sound$ci_low,sound_product_ci_high=sound$ci_high,sound_product_ci_excludes_0=sound$excludes,
        sound_product_p_value=sound$p_value,sound_product_q_value=sound$q_value,
        activity_product_estimate=activity$estimate,activity_product_ci_low=activity$ci_low,activity_product_ci_high=activity$ci_high,activity_product_ci_excludes_0=activity$excludes,
        activity_product_p_value=activity$p_value,activity_product_q_value=activity$q_value,
        stringsAsFactors=FALSE)
    }
  }
  do.call(rbind,rows)
}
fit_h4_all16 <- function() {
  stopifnot(requireNamespace("nlme",quietly=TRUE),requireNamespace("clubSandwich",quietly=TRUE))
  dir.create(h4_model_dir,recursive=TRUE,showWarnings=FALSE)
  catalog <- h4_equation_catalog()
  stopifnot(nrow(catalog)==16L,!any(grepl("vif",catalog$terms,ignore.case=TRUE)),!any(grepl("\\bBase\\b",catalog$terms)))
  dummy <- centered[seq_len(min(20L,nrow(centered))),,drop=FALSE]
  mode <- rep(c(-.5,.5),length.out=nrow(dummy))
  for(i in seq_len(nrow(catalog))) {
    design <- make_design(dummy,thermal[[catalog$heat_form[i]]],mode,catalog$test[i])
    declared <- strsplit(catalog$terms[i]," + ",fixed=TRUE)[[1]]
    stopifnot(setequal(vapply(colnames(design),h4_spell_term,character(1)),declared))
  }
  equations <- catalog[,c("equation_id","heat_form","block","terms")]
  write.csv(equations,file.path(h4_model_dir,"H4_equations.csv"),row.names=FALSE,na="")
  ckpt <- file.path(h4_model_dir,"_checkpoints")
  # checkpoints are only reused when code and data match; otherwise they are refitted
  run_key <- unname(tools::md5sum(c(file.path(root,"scripts/h4_step5_equations.R"),data_path)))
  dir.create(ckpt,recursive=TRUE,showWarnings=FALSE)
  stale <- list.files(ckpt,pattern="__eq",full.names=TRUE)
  if(length(stale)) unlink(stale)
  pending <- outcomes
  done <- character()
  for(y in outcomes) {
    p <- file.path(ckpt,paste0(y,".rds"))
    if(file.exists(p) && identical(tryCatch(readRDS(p)$key,error=function(e) NULL),run_key)) done <- c(done,y)
  }
  pending <- setdiff(outcomes,done)
  workers <- max(1L,min(6L,parallel::detectCores()-1L,length(pending)))
  message("H4 all-16 fits: ",length(done)," outcomes checkpointed; ",length(pending)," remaining on ",workers," workers (16 equations per outcome). Data: ",data_path)
  if(length(pending)) {
    cl <- parallel::makeCluster(workers)
    on.exit(try(parallel::stopCluster(cl),silent=TRUE),add=TRUE)
    parallel::clusterEvalQ(cl,{library(nlme);library(clubSandwich);NULL})
    parallel::clusterExport(cl,c("raw","centered","selected","thermal","nonthermal","H4_SPEC","component_set","component_role","make_design","do_fit","diagnose","h4_equation_catalog","h4_spell_term","h4_status_row","h4_prep_outcome","h4_fit_equation","fit_h4_outcome","fit_h4_outcome_empty_coef"),envir=globalenv())
    worker <- function(y) {
      res <- list(key=run_key,res=fit_h4_outcome(y,seq_len(16L)))
      saveRDS(res,file.path(ckpt,paste0(y,".rds")))
      y
    }
    environment(worker) <- globalenv()
    parallel::clusterExport(cl,c("ckpt","run_key"),envir=environment())
    for(start in seq.int(1L,length(pending),by=workers)) {
      batch <- pending[start:min(start+workers-1L,length(pending))]
      finished <- parallel::parLapplyLB(cl,batch,worker)
      message("Checkpointed outcomes: ",paste(unlist(finished),collapse=", "))
    }
  }
  pieces <- lapply(outcomes,function(y) readRDS(file.path(ckpt,paste0(y,".rds")))$res)
  status <- do.call(rbind,lapply(pieces,`[[`,"status"))
  coef <- do.call(rbind,lapply(pieces,`[[`,"coef"))
  if(!nrow(coef)) stop("all fits failed; first failure note: ",status$note[1])
  status <- status[order(status$equation_id,match(status$outcome,outcomes)),]
  if(nrow(coef)) coef <- coef[order(coef$equation_id,match(coef$outcome,outcomes),match(coef$term,c("Intercept",unique(coef$term)))),]
  rownames(status) <- NULL; rownames(coef) <- NULL
  # BH q-values on the joint (both_products) fits only: main effects and products are separate families per heat form
  joint <- coef$block=="both_products"
  coef$q_value <- NA_real_; coef$fdr_family <- "not in H4 heat family"
  for(m in names(thermal)) {
    mains <- joint & coef$heat_form==m & coef$term %in% thermal[[m]]
    prods <- joint & coef$heat_form==m & grepl(":",coef$term,fixed=TRUE)
    if(any(mains)) coef$q_value[mains] <- p.adjust(coef$p_value[mains],method="BH")
    if(any(prods)) coef$q_value[prods] <- p.adjust(coef$p_value[prods],method="BH")
    coef$fdr_family[mains] <- paste0("all16_",tolower(m),"_heat_main_effects")
    coef$fdr_family[prods] <- paste0("all16_",tolower(m),"_heat_products")
  }
  write.csv(status,file.path(h4_model_dir,"H4_fit_status.csv"),row.names=FALSE,na="")
  write.csv(coef,file.path(h4_model_dir,"H4_coefficients.csv"),row.names=FALSE,na="")
  hypothesis <- write_h4_hypothesis_table(status,coef)
  rownames(hypothesis) <- NULL
  write.csv(hypothesis,file.path(h4_model_dir,"H4_hypothesis.csv"),row.names=FALSE,na="")
  fail_n <- sum(!status$success)
  readme <- c(
    "Exploratory and post-selection. Benjamini-Hochberg q-values do not undo Step 4, which used the same outcomes. Not confirmatory inference.",
    if(fail_n) sprintf("All 16 equations attempted on all 26 outcomes (416 fits): %d succeeded, %d failed. Inspect H4_fit_status.csv (success=FALSE) for nlme failure notes.", sum(status$success), fail_n)
    else "All 16 equations fitted on all 26 outcomes (416 fits succeeded).",
    "H4_hypothesis.csv reads the joint (both_products) fit of each heat form; four families in fdr_family, mains and products never pooled.",
    "Coefficients are per within-person SD. PM2.5 is the hypothesis-named particulate term. H4_Step5_Equations_Checks.txt is historical."
  )
  writeLines(readme, file.path(h4_model_dir,"H4_hypothesis_readme.txt"))
  unlink(ckpt,recursive=TRUE)
  cat("ATTEMPTED",nrow(status),"SUCCEEDED",sum(status$success),"FAILED",sum(!status$success),"\n")
  if(any(!status$success)) {
    cat("FAILURES:\n")
    print(status[!status$success,c("equation_id","heat_form","block","outcome","note")],row.names=FALSE)
  }
  cat("HYPOTHESIS ROWS",nrow(hypothesis),"\n")
  for(m in c("Components","HUMIDEX","PET","UTCI")) {
    sub <- hypothesis[hypothesis$heat_form==m & hypothesis$success,]
    cat(m,"success_rows",nrow(sub),"heat_ci",sum(sub$heat_ci_excludes_0),"sound_ci",sum(sub$sound_product_ci_excludes_0),"activity_ci",sum(sub$activity_product_ci_excludes_0),"\n")
  }
  by_eq <- aggregate(success~equation_id,status,function(v) c(succeeded=sum(v),failed=sum(!v),attempted=length(v)))
  print(data.frame(equation_id=by_eq$equation_id,attempted=by_eq$success[,"attempted"],succeeded=by_eq$success[,"succeeded"],failed=by_eq$success[,"failed"]))
  invisible(list(status=status,coef=coef,hypothesis=hypothesis))
}
fit_h4_equation12 <- function() {
  stopifnot(requireNamespace("nlme",quietly=TRUE),requireNamespace("clubSandwich",quietly=TRUE))
  dir.create(h4_model_dir,recursive=TRUE,showWarnings=FALSE)
  catalog <- h4_equation_catalog()
  stopifnot(nrow(catalog)==16L,catalog$equation_id[12]==12L,catalog$heat_form[12]=="PET",catalog$block[12]=="both_products")
  stopifnot(!any(grepl("vif",catalog$terms,ignore.case=TRUE)))
  write.csv(catalog[,c("equation_id","heat_form","block","terms")],file.path(h4_model_dir,"H4_equations.csv"),row.names=FALSE,na="")
  workers <- max(1L,min(4L,parallel::detectCores()-1L,length(outcomes)))
  message("Equation 12 only (PET, both products): ",length(outcomes)," outcomes on ",workers," workers. Data: ",data_path)
  cl <- parallel::makeCluster(workers)
  on.exit(try(parallel::stopCluster(cl),silent=TRUE),add=TRUE)
  parallel::clusterEvalQ(cl,{library(nlme);library(clubSandwich);NULL})
  parallel::clusterExport(cl,c("raw","centered","selected","thermal","nonthermal","H4_SPEC","make_design","do_fit","diagnose","h4_equation_catalog","h4_spell_term","h4_status_row","h4_prep_outcome","h4_fit_equation","fit_h4_outcome","fit_h4_outcome_empty_coef"),envir=globalenv())
  pieces <- parallel::parLapplyLB(cl,outcomes,function(y) fit_h4_outcome(y,12L))
  status <- do.call(rbind,lapply(pieces,`[[`,"status"))
  coef <- do.call(rbind,lapply(pieces,function(p) if(nrow(p$coef)) p$coef else NULL))
  status <- status[order(match(status$outcome,outcomes)),]
  rownames(status) <- NULL
  if(is.null(coef)||!nrow(coef)) coef <- fit_h4_outcome_empty_coef() else {
    coef <- coef[order(match(coef$outcome,outcomes)),]
    rownames(coef) <- NULL
  }
  stopifnot(all(status$equation_id==12L),!nrow(coef)||all(coef$equation_id==12L))
  write.csv(status,file.path(h4_model_dir,"H4_fit_status.csv"),row.names=FALSE,na="")
  write.csv(coef,file.path(h4_model_dir,"H4_coefficients.csv"),row.names=FALSE,na="")
  rows <- list()
  for(y in outcomes) {
    st <- status[status$outcome==y,,drop=FALSE]
    stopifnot(nrow(st)==1L)
    heat <- h4_pull_term(coef,y,"PET","ucm_PET")
    sound <- h4_pull_term(coef,y,"PET","ucm_PET:SND_dBA")
    activity <- h4_pull_term(coef,y,"PET","ucm_PET:Activity_Bike")
    if(!isTRUE(st$success)) { heat$excludes <- FALSE; sound$excludes <- FALSE; activity$excludes <- FALSE }
    rows[[length(rows)+1L]] <- data.frame(
      equation_id=12L,outcome=y,transformation=st$transformation,heat_form="PET",block="both_products",component="PET",
      n=st$n,n_participants=st$n_participants,success=st$success,
      heat_term="PET",heat_estimate=heat$estimate,heat_ci_low=heat$ci_low,heat_ci_high=heat$ci_high,heat_ci_excludes_0=heat$excludes,
      sound_product_term="PET x sound",sound_product_estimate=sound$estimate,sound_product_ci_low=sound$ci_low,sound_product_ci_high=sound$ci_high,sound_product_ci_excludes_0=sound$excludes,
      activity_product_term="PET x activity",activity_product_estimate=activity$estimate,activity_product_ci_low=activity$ci_low,activity_product_ci_high=activity$ci_high,activity_product_ci_excludes_0=activity$excludes,
      stringsAsFactors=FALSE)
  }
  hypothesis <- do.call(rbind,rows)
  rownames(hypothesis) <- NULL
  write.csv(hypothesis,file.path(h4_model_dir,"H4_hypothesis.csv"),row.names=FALSE,na="")
  cat("EQUATION 12 ATTEMPTED",nrow(status),"SUCCEEDED",sum(status$success),"FAILED",sum(!status$success),"\n")
  if(any(!status$success)) print(status[!status$success,c("outcome","note")],row.names=FALSE)
  cat("HYPOTHESIS ROWS",nrow(hypothesis),"PET excludes 0",sum(hypothesis$heat_ci_excludes_0),"sound product",sum(hypothesis$sound_product_ci_excludes_0),"activity product",sum(hypothesis$activity_product_ci_excludes_0),"\n")
  show <- hypothesis[hypothesis$heat_ci_excludes_0|hypothesis$sound_product_ci_excludes_0|hypothesis$activity_product_ci_excludes_0,c("outcome","heat_estimate","heat_ci_low","heat_ci_high","heat_ci_excludes_0","sound_product_estimate","sound_product_ci_low","sound_product_ci_high","sound_product_ci_excludes_0","activity_product_estimate","activity_product_ci_low","activity_product_ci_high","activity_product_ci_excludes_0")]
  print(show,row.names=FALSE,digits=4)
  invisible(list(status=status,coef=coef,hypothesis=hypothesis))
}
# Publish only a complete bundle. Individual renames are not a multi-file atomic
# operation; the completion manifest is the last commit point readers verify.
h4_publish_bundle <- function(bundle, destination, checkpoint_dir, fingerprint) {
  stopifnot(length(fingerprint)==4L,!anyDuplicated(names(bundle)),
            all(grepl("^H4_[A-Za-z_]+\\.(csv|txt)$",names(bundle))))
  dir.create(destination,recursive=TRUE,showWarnings=FALSE)
  dir.create(checkpoint_dir,recursive=TRUE,showWarnings=FALSE)
  stage <- tempfile("publish_",tmpdir=checkpoint_dir)
  stopifnot(dir.create(stage))
  marker <- "H4_run_complete.csv"
  names_to_publish <- c(names(bundle),marker)
  published <- backed_up <- character(); committed <- FALSE
  on.exit({
    if(!committed) {
      for(nm in rev(published)) unlink(file.path(destination,nm))
      for(nm in rev(backed_up)) {
        if(!file.rename(file.path(stage,paste0("previous_",nm)),file.path(destination,nm)))
          warning("Rollback failed; retained backup: ",file.path(stage,paste0("previous_",nm)))
      }
    }
    if(committed) {
      # The generated staging directory must stay inside the checkpoint root.
      if(startsWith(normalizePath(stage,winslash="/"),paste0(normalizePath(checkpoint_dir,winslash="/"),"/")))
        unlink(stage,recursive=TRUE)
    }
  },add=TRUE)
  for(nm in names(bundle)) {
    path <- file.path(stage,nm)
    if(is.data.frame(bundle[[nm]])) write.csv(bundle[[nm]],path,row.names=FALSE,na="") else writeLines(bundle[[nm]],path)
  }
  manifest <- data.frame(file=names(bundle),md5=unname(tools::md5sum(file.path(stage,names(bundle)))),
    code_md5=fingerprint[1],input_md5=fingerprint[2],audit_md5=fingerprint[3],spec_md5=fingerprint[4],
    completed_utc=format(Sys.time(),tz="UTC",format="%Y-%m-%dT%H:%M:%SZ"),stringsAsFactors=FALSE)
  write.csv(manifest,file.path(stage,marker),row.names=FALSE)
  # Invalidate the old completion marker before replacing any visible file.
  if(file.exists(file.path(destination,marker))) {
    stopifnot(file.rename(file.path(destination,marker),file.path(stage,paste0("previous_",marker))))
    backed_up <- marker
  }
  for(nm in names_to_publish) {
    target <- file.path(destination,nm)
    if(file.exists(target)) {
      if(!file.rename(target,file.path(stage,paste0("previous_",nm)))) stop("Cannot back up output: ",target)
      backed_up <- c(backed_up,nm)
    }
    if(!file.rename(file.path(stage,nm),target)) stop("Cannot publish output: ",target)
    published <- c(published,nm)
  }
  committed <- TRUE
  invisible(manifest)
}
fit_h4_equation1 <- function() {
  stopifnot(requireNamespace("nlme",quietly=TRUE),requireNamespace("clubSandwich",quietly=TRUE))
  dir.create(h4_model_dir,recursive=TRUE,showWarnings=FALSE)
  catalog <- h4_equation_catalog()
  fingerprint <- unname(tools::md5sum(c(file.path(root,"scripts/h4_step5_equations.R"),data_path,audit_path,file.path(root,"scripts/H4_multivariate.R"))))
  checkpoint_dir <- file.path(h4_model_dir,"_checkpoints")
  dir.create(checkpoint_dir,recursive=TRUE,showWarnings=FALSE)
  workers <- max(1L,min(4L,parallel::detectCores()-1L,length(outcomes)))
  message("Equations 1 and 4 (components main effects, and components with both products): ",length(outcomes)," outcomes on ",workers," workers.")
  cl <- parallel::makeCluster(workers,outfile="")
  on.exit(try(parallel::stopCluster(cl),silent=TRUE),add=TRUE)
  parallel::clusterEvalQ(cl,{library(nlme);library(clubSandwich);NULL})
  parallel::clusterExport(cl,c("raw","centered","selected","thermal","nonthermal","H4_SPEC","make_design","diagnose","do_fit","h4_equation_catalog","h4_spell_term","h4_status_row","h4_prep_outcome","h4_fit_equation","fit_h4_outcome","fit_h4_outcome_empty_coef","component_set","component_role"),envir=globalenv())
  pieces <- vector("list",length(outcomes))
  fit_checkpoint <- file.path(checkpoint_dir,"equations_1_4_takeover.rds")
  if(file.exists(fit_checkpoint)) {
    saved <- tryCatch(readRDS(fit_checkpoint),error=function(e) { warning("Unreadable fit checkpoint; recomputing: ",conditionMessage(e)); NULL })
    if(!is.null(saved)&&identical(saved$fingerprint,fingerprint)) pieces <- saved$pieces
  }
  for(start in seq.int(1L,length(outcomes),by=workers)) {
    idx <- start:min(start+workers-1L,length(outcomes))
    pending <- idx[vapply(pieces[idx],is.null,logical(1))]
    if(length(pending)) pieces[pending] <- parallel::parLapplyLB(cl,outcomes[pending],function(y) fit_h4_outcome(y,c(1L,4L)))
    saveRDS(list(fingerprint=fingerprint,pieces=pieces),fit_checkpoint)
    message("Checkpointed full-fit outcomes: ",min(idx),"-",max(idx)," / ",length(outcomes))
  }
  status <- do.call(rbind,lapply(pieces,`[[`,"status"))
  coef <- do.call(rbind,lapply(pieces,function(p) if(nrow(p$coef)) p$coef else NULL))
  status <- status[order(match(status$outcome,outcomes)),]
  rownames(status) <- NULL
  if(is.null(coef)||!nrow(coef)) coef <- fit_h4_outcome_empty_coef() else {
    coef <- coef[order(match(coef$outcome,outcomes)),]
    rownames(coef) <- NULL
  }
  stopifnot(nrow(status)==2L*length(outcomes),!anyDuplicated(status[,c("equation_id","outcome")]),all(status$equation_id %in% c(1L,4L)))
  stopifnot(all(vapply(split(status,status$outcome),function(s) length(unique(s$n))==1L,logical(1))))
  status$code_md5 <- fingerprint[1]; status$input_md5 <- fingerprint[2]; status$audit_md5 <- fingerprint[3]
  status$spec_md5 <- fingerprint[4]
  for(i in seq_len(nrow(catalog))) {
    st <- status[status$equation_id==catalog$equation_id[i],,drop=FALSE]
    catalog$attempted[i] <- nrow(st); catalog$succeeded[i] <- sum(st$success)
    catalog$failed[i] <- sum(!st$success); catalog$fitted[i] <- any(st$success)
  }
  catalog$code_md5 <- fingerprint[1]; catalog$input_md5 <- fingerprint[2]
  coef$q_value <- NA_real_
  coef$fdr_family <- "not in H4 heat family"
  main_rows <- coef$equation_id==4L & coef$term %in% component_set
  prod_rows <- coef$equation_id==4L & grepl(":", coef$term, fixed=TRUE)
  if(any(main_rows)) coef$q_value[main_rows] <- p.adjust(coef$p_value[main_rows], method="BH",n=length(outcomes)*length(component_set))
  if(any(prod_rows)) coef$q_value[prod_rows] <- p.adjust(coef$p_value[prod_rows], method="BH",n=length(outcomes)*length(component_set)*2L)
  coef$fdr_family[main_rows] <- "equation4_heat_main_effects"
  coef$fdr_family[prod_rows] <- "equation4_heat_products"
  rows <- list()
  pull <- function(y, eq, term) {
    hit <- coef[coef$outcome==y & coef$equation_id==eq & coef$term==term,,drop=FALSE]
    if(nrow(hit)!=1L) hit <- coef[0,]
    hit
  }
  for(y in outcomes) {
    st4 <- status[status$outcome==y & status$equation_id==4L,,drop=FALSE]
    stopifnot(nrow(st4)==1L)
    terms4 <- c(component_set, unlist(lapply(component_set, function(v) c(paste0(v,":SND_dBA"), paste0(v,":Activity_Bike")))))
    for(v in terms4) {
      hit <- pull(y, 4L, v)
      fam <- if(grepl(":", v, fixed=TRUE)) "equation4_heat_products" else "equation4_heat_main_effects"
      rows[[length(rows)+1L]] <- data.frame(
        equation_id=4L, outcome=y, transformation=st4$transformation, heat_form="Components", block="both_products",
        term=v, term_label=h4_spell_term(v),
        n=st4$n,n_participants=st4$n_participants,success=st4$success,
        estimate=if(nrow(hit)==1L) hit$estimate else NA_real_,
        se=if(nrow(hit)==1L) hit$se else NA_real_,
        df=if(nrow(hit)==1L) hit$df else NA_real_,
        ci_low=if(nrow(hit)==1L) hit$ci_low else NA_real_,
        ci_high=if(nrow(hit)==1L) hit$ci_high else NA_real_,
        ci=if(nrow(hit)==1L) paste(signif(hit$ci_low, 4), signif(hit$ci_high, 4), sep=", ") else NA_character_,
        t_stat=if(nrow(hit)==1L) hit$t_stat else NA_real_,
        p_value=if(nrow(hit)==1L) hit$p_value else NA_real_,
        q_value=if(nrow(hit)==1L) hit$q_value else NA_real_,
        fdr_family=fam, stringsAsFactors=FALSE)
    }
  }
  hypothesis <- do.call(rbind, rows)
  rownames(hypothesis) <- NULL
  fit_rows <- status
  fit_rows$row_type <- "fit"
  # Check every successful model and every coefficient, independent of p-values.
  loo_pairs <- status[status$success,c("equation_id","outcome","participant_ids"),drop=FALSE]
  message("Leave-one-participant checks for all ",nrow(loo_pairs)," successful outcome-equations")
  loo_rows <- list()
  completed <- 0L
  deletion_checkpoint <- file.path(checkpoint_dir,"equations_1_4_deletion_takeover.rds")
  if(file.exists(deletion_checkpoint)) {
    saved <- tryCatch(readRDS(deletion_checkpoint),error=function(e) { warning("Unreadable deletion checkpoint; recomputing: ",conditionMessage(e)); NULL })
    if(!is.null(saved)&&identical(saved$fingerprint,fingerprint)) { loo_rows <- saved$rows; completed <- saved$completed }
  }
  for(i in seq_len(nrow(loo_pairs))) {
    if(i<=completed) next
    eq_id <- loo_pairs$equation_id[i]
    y <- loo_pairs$outcome[i]
    terms_i <- coef$term[coef$equation_id==eq_id & coef$outcome==y & coef$term!="Intercept"]
    full_est <- sapply(terms_i, function(term) {
      hit <- coef[coef$equation_id==eq_id & coef$outcome==y & coef$term==term, "estimate"]
      if(length(hit)==1L) hit else NA_real_
    })
    participants <- strsplit(loo_pairs$participant_ids[i],";",fixed=TRUE)[[1]]
    refits <- parallel::parLapplyLB(cl,participants,function(pid,y,eq_id) fit_h4_outcome(y,eq_id,drop_participant=pid,point_only=TRUE),y=y,eq_id=eq_id)
    for(j in seq_along(participants)) {
      pid <- participants[j]; refit <- refits[[j]]
      for(term in terms_i) {
        hit <- refit$coef[refit$coef$term==term, "estimate"]
        est <- if(length(hit)==1L) hit else NA_real_
        base <- unname(full_est[[term]])
        flip <- if(!is.finite(base) || !is.finite(est) || base==0 || est==0) NA else sign(base) != sign(est)
        loo_rows[[length(loo_rows)+1L]] <- data.frame(row_type="leave_one_participant", equation_id=eq_id, outcome=y, term=term, dropped_participant=pid, full_estimate=base, loo_estimate=est, sign_flip=flip,success=isTRUE(refit$status$success[1]),note=refit$status$note[1],stringsAsFactors=FALSE)
      }
    }
    message("LOO finished ", y, " equation ", eq_id)
    saveRDS(list(fingerprint=fingerprint,completed=i,rows=loo_rows),deletion_checkpoint)
  }
  loo_df <- if(length(loo_rows)) do.call(rbind, loo_rows) else NULL
  columns <- union(names(fit_rows),names(loo_df))
  for(nm in setdiff(columns,names(fit_rows))) fit_rows[[nm]] <- NA
  if(!is.null(loo_df)) for(nm in setdiff(columns,names(loo_df))) loo_df[[nm]] <- NA
  diagnostics <- if(is.null(loo_df)) fit_rows else rbind(fit_rows[,columns],loo_df[,columns])
  stopifnot(identical(unname(tools::md5sum(c(file.path(root,"scripts/h4_step5_equations.R"),data_path,audit_path,file.path(root,"scripts/H4_multivariate.R")))),fingerprint))
  readme <- c(
    "Exploratory and post-selection. Benjamini-Hochberg q-values do not undo Step 4, which used the same outcomes. These p-values and q-values are not confirmatory inference.",
    "Step 4 is a domain-wise LASSO on participant-mean-centered exposures, explicitly scaled using training-fold means/SDs, with glmnet standardize=FALSE. The retained set is the union of the Empatica screen and the eye-tracker screen, not a best-overall ranking. Step 4 was NOT rerun here.",
    "The linear mixed models use the same within-person centering. Each centered predictor is then divided by its full-sample within-person SD (the SD of the centered values on finite rows). Coefficients are per within-person SD. Activity stays Bike +0.5 / Walk -0.5 and is not divided by an SD.",
    "HRV magnitudes in H4_SPEC$hrv_log use the natural log of strictly positive values. Non-positive rows are dropped. There is no log1p.",
    "PM2.5 (atmo_pm2.5_avg) is included because documents/Paper3_outline_ml.md H4 explicitly names PM2.5. This correction is hypothesis-based, made post hoc, and is neither a LASSO survivor nor evidence of preregistration. PM1 is not forced into the model. Bilateral averaging follows the existing mapping.",
    "Equation 1 has the within-person-selected non-thermal covariates, hypothesis-named PM2.5, air temperature, humidity, mean radiant temperature, and activity, with no products. Equation 4 is equation 1 plus each thermal component times sound and each times activity. The other grid rows are not fitted. Attempted/succeeded/failed counts come from H4_fit_status.csv, never from intended execution.",
    "H4_hypothesis.csv uses equation 4 only. Two Benjamini-Hochberg families, stored in fdr_family and not pooled: equation4_heat_main_effects (three heat main effects) and equation4_heat_products (six products). q_value is NA outside those families in H4_coefficients.csv.",
    "H4_diagnostics.csv has one fit row per outcome-equation and deletion rows for every non-intercept coefficient of every successful fit, with each included participant omitted in turn. No p-value-based diagnostic selection. Failed full fits remain as fit rows; failed deletions remain as rows with missing estimates. Centering/scaling stays fixed. Only the actual predictors of the paired equations determine their common complete-case sample.",
    "No VIF computation, screening, elimination, or cutoff is used. The full-rank check only detects mathematical non-estimability; it deletes nothing. Residual lag1 uses nlme innermost level=2 normalized residuals after AR1 whitening, adjacent 10-second pairs within each phase only. Skew, excess kurtosis, near-zero variance, CR2 df and optimizer/warning messages are retained.",
    "Operational review flags (not universal validity thresholds): abs(normalized lag1)>.2, abs(skew)>2 or abs(excess kurtosis)>7, random variance<1e-6 residual variance, CR2 df<4. Gaussian fits on rates/durations/bounded outcomes require outcome-specific residual review; physiology is not a validated direct measure of perceived comfort. BH uses all 78 planned thermal-main and 156 planned interaction tests, including failed fits. q-values remain post-selection/descriptive.",
    "Methods: nlme residuals.lme https://stat.ethz.ch/R-manual/R-devel/library/nlme/html/residuals.lme.html ; participant-cluster CR2 https://jepusto.github.io/clubSandwich/reference/vcovCR.lme.html ; deletion diagnostics https://journal.r-project.org/articles/RJ-2012-011/ . Published libraries support reproducibility but do not independently validate this study's design or results.",
    "Review workflow: Kassis, T., Agarwal, V., He, Y., Patel, D., and Brueckner, A. M. (2026). Scientific Agent Skills: A Library of Procedural Knowledge for Research Agents. https://doi.org/10.48550/arXiv.2609.00065 (software/workflow reference, not statistical validation).",
    paste("Run fingerprints (code,input,audit,spec):",paste(fingerprint,collapse=", ")),
    paste("R:",getRversion(),"nlme:",packageVersion("nlme"),"clubSandwich:",packageVersion("clubSandwich")),
    "A completed run publishes all seven result/documentation files together with H4_run_complete.csv last. That manifest records their MD5 hashes and code/input/audit/spec fingerprints. Missing/mismatched manifest means the files are incomplete, legacy, or stale, not a verified current bundle. Checkpoints are resumable working data, not published scientific results.",
    "H4_Step5_Equations_Checks.txt is a HISTORICAL file and is not the current analysis. Current results are in this H4_models folder.",
    paste("Within-person LASSO union:", paste(lasso_union, collapse=", ")),
    paste("Model covariates:", paste(nonthermal, collapse=", ")),
    paste("Heat roles:", paste(paste0(component_set, "=", component_role), collapse="; "))
  )
  h4_publish_bundle(list(H4_equations.csv=catalog,H4_fit_status.csv=status,
    H4_coefficients.csv=coef,H4_hypothesis.csv=hypothesis,H4_diagnostics.csv=diagnostics,
    H4_hypothesis_readme.txt=readme,H4_hypothesis.txt=readme),h4_model_dir,checkpoint_dir,fingerprint)
  cat("EQUATIONS 1 AND 4 ATTEMPTED",nrow(status),"SUCCEEDED",sum(status$success),"FAILED",sum(!status$success),"\n")
  cat("HEAT TESTS",nrow(hypothesis),"P<0.05",sum(hypothesis$p_value<0.05,na.rm=TRUE),"Q<0.05",sum(hypothesis$q_value<0.05,na.rm=TRUE),"\n")
  show <- hypothesis[is.finite(hypothesis$q_value) & hypothesis$q_value<0.05, c("outcome","term","estimate","ci","p_value","q_value","fdr_family")]
  print(show, row.names=FALSE, digits=4)
  invisible(list(status=status,coef=coef,hypothesis=hypothesis))
}
if(identical(Sys.getenv("H4_STEP5_EQ1"),"1")) {
  fit_h4_equation1()
} else if(identical(Sys.getenv("H4_STEP5_EQ12"),"1")) {
  fit_h4_equation12()
} else if(identical(Sys.getenv("H4_STEP5_ALL16"),"1")) {
  fit_h4_all16()
} else if(identical(Sys.getenv("H4_STEP5_RIDGE"),"1")||identical(Sys.getenv("H4_STEP5_RIDGE_PILOT"),"1")) {
  run_ridge10()
} else if(identical(Sys.getenv("H4_STEP5_MAIN"),"1")) {
  run_joint_main_effects()
} else if(identical(Sys.getenv("H4_STEP5_VALIDATE"),"1")) {
  run_validation()
} else if(identical(Sys.getenv("H4_STEP5_SUMMARY"),"1")) {
  summarize_fits()
} else if(identical(Sys.getenv("H4_STEP5_FIT_PILOT"),"1")) {
  fit_models(TRUE)
} else if(identical(Sys.getenv("H4_STEP5_FIT"),"1")) {
  header<-capture.output({
    cat("\n=== FIT RUN START: ",format(Sys.time())," | DISCRETE AR1: SUPERSEDES EARLIER CONTINUOUS AR1 FITS ===\n",sep="")
    cat("Model: joint interactions; participant and participant-phase random intercepts; discrete AR1 within phase; REML; CR2 participant-cluster uncertainty, Satterthwaite df.\n")
    cat("All models retained, no significance selection. Native outcomes except existing H4_SPEC HRV natural log list. Intervals are nominal post-selection descriptive intervals, not simultaneous or confirmatory.\n")
    cat("Unit: 10-second repeated windows; independent clusters: participants. Activity is walking/cycling mode. Four alternatives condition on sound, PM1, GVI and clearness; no causal-adjustment or perceived-discomfort validity claim.\n")
    cat("Documentation: https://stat.ethz.ch/R-manual/R-devel/library/nlme/html/corAR1.html ; https://jepusto.github.io/clubSandwich/ .\n")
  })
  cat(paste(header,collapse="\n"),"\n",file=report_path,append=TRUE)
  fit_models()
  if(!nzchar(Sys.getenv("H4_STEP5_OUTCOME")) && !nzchar(Sys.getenv("H4_STEP5_SPEC"))) summarize_fits()
} else {
  if(file.exists(report_path) && any(grepl("=== FIT RUN START:",readLines(report_path,warn=FALSE),fixed=TRUE)))
    stop("Existing fitted report protected. Set H4_STEP5_FIT=1 to append a new fit run; diagnostic-only mode cannot overwrite fitted results.")
  report<-capture.output(run_checks())
  writeLines(report,report_path)
  cat(paste(report,collapse="\n"),"\nSAVED:",report_path,"\n")
}
