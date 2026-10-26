# Post-hoc temporal sensitivity for H4 Components Equations 1 and 4.
# ChatGPT's Downloads/H4_time_sensitivity.R logic is integrated in h4_step5_equations.R
# (baseline vs phase+elapsed-time refits, separate H4_models/H4_time_sensitivity outputs).
#
# From repo root:
#   Rscript scripts/H4_time_sensitivity.R
# Or:
#   $env:H4_TIME_SENSITIVITY='1'; Rscript scripts/h4_step5_equations.R

options(stringsAsFactors = FALSE)
find_root <- function() {
  arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  script_dir <- if (length(arg)) dirname(sub("^--file=", "", arg[1])) else ""
  candidates <- c(if (nzchar(script_dir)) file.path(script_dir, ".."), getwd(), file.path(getwd(), ".."))
  for (p in unique(candidates)) {
    root <- normalizePath(p, winslash = "/", mustWork = FALSE)
    if (file.exists(file.path(root, "scripts/h4_step5_equations.R"))) return(root)
  }
  stop("Run from the Paper3_Final repository.")
}
root_dir <- find_root()
Sys.setenv(H4_TIME_SENSITIVITY = "1")
source(file.path(root_dir, "scripts/h4_step5_equations.R"), encoding = "UTF-8")
