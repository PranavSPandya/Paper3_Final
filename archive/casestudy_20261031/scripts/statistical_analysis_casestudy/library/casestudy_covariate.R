# Person-level case-study factor. One pass uses fitness, the other activeness.
# Set PAPER3_CASESTUDY_COVARIATE to "fitness" or "activeness" before Rscript.
# Labels do not vary within ParticipantID. Both levels stay in the sample.

PAPER3_CASESTUDY_COVARIATE <- Sys.getenv("PAPER3_CASESTUDY_COVARIATE", unset = "")
if (!nzchar(PAPER3_CASESTUDY_COVARIATE)) PAPER3_CASESTUDY_COVARIATE <- "fitness"
if (!PAPER3_CASESTUDY_COVARIATE %in% c("fitness", "activeness")) {
  stop("PAPER3_CASESTUDY_COVARIATE must be fitness or activeness.", call. = FALSE)
}

paper3_casestudy_results_root <- function(project_root = NULL) {
  if (is.null(project_root) || !nzchar(project_root)) {
    project_root <- get0("PROJECT_ROOT", envir = .GlobalEnv, ifnotfound = NULL)
  }
  if (is.null(project_root) || !nzchar(project_root)) project_root <- resolve_project_root()
  file.path(project_root, "output", "statistical_analysis", "results_casestudy", PAPER3_CASESTUDY_COVARIATE)
}

paper3_casestudy_figures_root <- function(project_root = NULL) {
  if (is.null(project_root) || !nzchar(project_root)) {
    project_root <- get0("PROJECT_ROOT", envir = .GlobalEnv, ifnotfound = NULL)
  }
  if (is.null(project_root) || !nzchar(project_root)) project_root <- resolve_project_root()
  file.path(project_root, "output", "statistical_analysis", "figures_casestudy", PAPER3_CASESTUDY_COVARIATE)
}

paper3_casestudy_labels <- function() {
  path <- file.path(
    resolve_project_root(), "output", "statistical_analysis",
    "Participant Casestudy", "Participant_fitness_activeness.csv"
  )
  if (!file.exists(path)) stop("Missing case-study labels: ", path, call. = FALSE)
  lab <- utils::read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
  need <- c("ParticipantID", "fitness", "activeness")
  if (!all(need %in% names(lab))) stop("Case-study CSV must have ParticipantID, fitness, activeness.", call. = FALSE)
  lab
}

paper3_casestudy_levels <- function(covariate = PAPER3_CASESTUDY_COVARIATE) {
  if (identical(covariate, "fitness")) c("Not Fit", "Fit") else c("Inactive", "Active")
}

paper3_casestudy_contrast_name <- function(covariate = PAPER3_CASESTUDY_COVARIATE) {
  if (identical(covariate, "fitness")) "Fit_vs_NotFit" else "Active_vs_Inactive"
}

paper3_casestudy_attach <- function(df) {
  if (is.null(df) || !nrow(df) || !"ParticipantID" %in% names(df)) return(df)
  cov <- PAPER3_CASESTUDY_COVARIATE
  lab <- paper3_casestudy_labels()
  mapped <- lab[[cov]][match(as.character(df$ParticipantID), as.character(lab$ParticipantID))]
  if (anyNA(mapped)) {
    missing <- unique(as.character(df$ParticipantID)[is.na(mapped)])
    stop("Case-study label missing for: ", paste(missing, collapse = ", "), call. = FALSE)
  }
  lv <- paper3_casestudy_levels(cov)
  if (!all(mapped %in% lv)) stop("Unexpected ", cov, " label.", call. = FALSE)
  f <- factor(mapped, levels = lv)
  stats::contrasts(f) <- stats::contr.treatment(lv)
  colnames(stats::contrasts(f)) <- paper3_casestudy_contrast_name(cov)
  df[[cov]] <- f
  df
}

# Person-mean of a within-person z outcome is ~0, so a person-constant factor is not estimable.
paper3_casestudy_between_person <- function(df, response) {
  if (!response %in% names(df) || !"ParticipantID" %in% names(df)) return(FALSE)
  m <- tapply(df[[response]], df$ParticipantID, function(x) {
    x <- x[is.finite(x)]
    if (!length(x)) NA_real_ else mean(x)
  })
  m <- m[is.finite(m)]
  length(unique(m)) >= 2 && is.finite(stats::sd(m)) && stats::sd(m) > 1e-6
}

paper3_casestudy_add_term <- function(fml) {
  cov <- PAPER3_CASESTUDY_COVARIATE
  if (cov %in% all.vars(fml)) return(fml)
  txt <- paste(deparse(fml), collapse = " ")
  stats::as.formula(paste(txt, "+", cov), env = environment(fml))
}

paper3_casestudy_prepare_frame <- function(df, response = NULL) {
  df <- paper3_casestudy_attach(df)
  cov <- PAPER3_CASESTUDY_COVARIATE
  usable <- is.null(response) || paper3_casestudy_between_person(df, response)
  if (usable) usable <- nlevels(droplevels(df[[cov]])) >= 2
  list(data = df, add = isTRUE(usable), covariate = cov)
}
