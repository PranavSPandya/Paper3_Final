# H4 updated-approach window sensitivity: skip-start and 1-/2-min averages.
# Same papers as H4_sound_literature_test.R (Grapas, Cureau 2022, Rodrigues).
# Vote tests barely change; physiology means, Rodrigues max/sd, and Grapas delay use the windowed series.
options(stringsAsFactors = FALSE)
entry <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
if (!length(entry) || !file.exists(entry[1])) stop("Run with Rscript.")
entry <- normalizePath(entry[1], winslash = "/", mustWork = TRUE)
library_dir <- file.path(dirname(entry), "library")
code_paths <- c(entry, file.path(library_dir, c("Paper3_common.R", "H4_sound_literature_helpers.R")))
code_fingerprints <- tools::md5sum(code_paths)
for (path in code_paths[-1]) source(path, local = FALSE)
if (!requireNamespace("nlme", quietly = TRUE)) stop("Required package missing: nlme")
if (!requireNamespace("nnet", quietly = TRUE)) stop("Required package missing: nnet")
suppressPackageStartupMessages(library(nlme))
suppressPackageStartupMessages(library(nnet))
root <- resolve_project_root()
input <- paper3_merged_8min_path(root)
input_fingerprint <- tools::md5sum(input)
epochs0 <- H4_IO$read_epochs(root)

h4_elapsed <- function(epochs) {
  do.call(rbind, lapply(H4_UTIL$bouts(epochs), function(rows) {
    b <- epochs[rows, , drop = FALSE]
    b <- b[order(b$Datetime), ]
    b$elapsed_s <- as.numeric(difftime(b$Datetime, b$Datetime[1], units = "secs"))
    b
  }))
}

h4_skip <- function(epochs, skip_s) {
  e <- h4_elapsed(epochs)
  e[is.finite(e$elapsed_s) & e$elapsed_s >= skip_s, , drop = FALSE]
}

h4_bin <- function(epochs, bin_s) {
  e <- h4_elapsed(epochs)
  e$bin <- floor(e$elapsed_s / bin_s)
  keys <- interaction(e$ParticipantID, e$PhaseID, e$bin, drop = TRUE, lex.order = TRUE)
  num_cols <- names(e)[vapply(e, is.numeric, logical(1))]
  num_cols <- setdiff(num_cols, c("elapsed_s", "bin"))
  out <- lapply(split(seq_len(nrow(e)), keys), function(rows) {
    b <- e[rows, , drop = FALSE]
    row <- b[1, , drop = FALSE]
    for (nm in num_cols) {
      x <- as.numeric(b[[nm]])
      row[[nm]] <- if (nm == "ucm_SND_dBA") H4_UTIL$energy_mean_db(x) else H4_UTIL$finite_mean(x)
    }
    row$Datetime <- min(b$Datetime)
    row$elapsed_s <- min(b$elapsed_s)
    row
  })
  d <- do.call(rbind, out)
  d[order(d$ParticipantID, d$PhaseID, d$Datetime), ]
}

run_four <- function(epochs) {
  blocks <- Filter(Negate(is.null), list(
    H4_CUREAU2022$run(epochs, "walk"),
    H4_GRAPAS$run(epochs, "walk"),
    H4_RODRIGUES$run(epochs, "walk")))
  if (!length(blocks)) return(NULL)
  all_cols <- unique(unlist(lapply(blocks, names)))
  blocks <- lapply(blocks, function(d) {
    for (col in setdiff(all_cols, names(d))) d[[col]] <- NA
    d[, all_cols, drop = FALSE]
  })
  do.call(rbind, blocks)
}

count_paper <- function(d, paper) {
  x <- d[d$paper == paper, , drop = FALSE]
  met <- if (paper == "Rodrigues 2026")
    is.finite(x$p) & x$p < 0.05 & abs(x$estimate) > 0.1
  else is.finite(x$p) & x$p < 0.05
  data.frame(
    paper = paper,
    n_tests = nrow(x),
    n_estimable = sum(is.finite(x$p)),
    n_met = sum(met %in% TRUE),
    n_walk_met = sum(met %in% TRUE & grepl("walk", x$test, ignore.case = TRUE)),
    n_walk = sum(grepl("walk", x$test, ignore.case = TRUE)),
    n_bike_met = sum(met %in% TRUE & grepl("bike", x$test, ignore.case = TRUE)),
    n_bike = sum(grepl("bike", x$test, ignore.case = TRUE)),
    stringsAsFactors = FALSE)
}

windows <- list(
  list(id = "full_8min", label = "Full 8 min (current)", skip_s = 0, bin_s = 10L,
       grapas = list(epoch_seconds = 10L, min_overlap = 10L, max_lag = 18L)),
  list(id = "skip_first_3min", label = "Skip first 3 min (last 5 min)", skip_s = 180, bin_s = 10L,
       grapas = list(epoch_seconds = 10L, min_overlap = 10L, max_lag = 18L)),
  list(id = "skip_first_5min", label = "Skip first 5 min (last 3 min)", skip_s = 300, bin_s = 10L,
       grapas = list(epoch_seconds = 10L, min_overlap = 8L, max_lag = 10L)),
  list(id = "avg_1min", label = "1-min averages of the 8 min", skip_s = 0, bin_s = 60L,
       grapas = list(epoch_seconds = 60L, min_overlap = 4L, max_lag = 3L)),
  list(id = "avg_2min", label = "2-min averages of the 8 min", skip_s = 0, bin_s = 120L,
       grapas = list(epoch_seconds = 120L, min_overlap = 3L, max_lag = 2L)))

grapas_default <- list(epoch_seconds = H4_GRAPAS$epoch_seconds, min_overlap = H4_GRAPAS$min_overlap, max_lag = H4_GRAPAS$max_lag)
papers <- c("Grapas 2026", "Cureau 2022", "Rodrigues 2026")
all_rows <- list()
summ <- list()

for (w in windows) {
  H4_GRAPAS$epoch_seconds <- w$grapas$epoch_seconds
  H4_GRAPAS$min_overlap <- w$grapas$min_overlap
  H4_GRAPAS$max_lag <- w$grapas$max_lag
  e <- h4_skip(epochs0, w$skip_s)
  if (w$bin_s != 10L) e <- h4_bin(e, w$bin_s)
  cat <- tryCatch(run_four(e), error = function(err) {
    message(w$id, ": ", conditionMessage(err))
    NULL
  })
  H4_GRAPAS$epoch_seconds <- grapas_default$epoch_seconds
  H4_GRAPAS$min_overlap <- grapas_default$min_overlap
  H4_GRAPAS$max_lag <- grapas_default$max_lag
  if (is.null(cat) || !nrow(cat)) next
  cat$window_id <- w$id
  cat$window_label <- w$label
  all_rows[[length(all_rows) + 1L]] <- cat
  for (pap in papers) {
    row <- count_paper(cat, pap)
    row$window_id <- w$id
    row$window_label <- w$label
    summ[[length(summ) + 1L]] <- row
  }
}

if (!length(all_rows)) stop("No window results.")
catalog <- do.call(rbind, all_rows)
summary_tbl <- do.call(rbind, summ)

if (!identical(unname(tools::md5sum(code_paths)), unname(code_fingerprints))) stop("Code changed during run.")
if (!identical(unname(tools::md5sum(input)), unname(input_fingerprint))) stop("Input changed during run.")

notes <- c(
  "# H4 updated-approach window sensitivity",
  paste("Run UTC:", format(Sys.time(), tz = "UTC", usetz = TRUE)),
  paste("Input MD5:", unname(input_fingerprint)),
  "",
  "## Windows",
  "- full_8min: current 10 s series, minutes 0-8.",
  "- skip_first_3min: drop the first 180 s (start-up); remaining ~5 min. Common field-physiology acclimatization cut.",
  "- skip_first_5min: drop the first 300 s; remaining ~3 min. Same idea, shorter steady window.",
  "- avg_1min / avg_2min: energy-mean dBA and arithmetic means inside 60 s / 120 s bins of the full 8 min. Grapas lag step matches the bin.",
  "- These windows cannot recover Grapas's published 14-16 min delay.",
  "- Questionnaire votes are one per bout, so Cureau Fisher/comfort/multinom stay almost unchanged.",
  "",
  "## Papers",
  "- Grapas, Cureau 2022, Rodrigues only. Walking bouts only.")
staging <- tempfile("H4_win_")
dir.create(staging)
write.csv(catalog, file.path(staging, "H4_sound_literature_tests_windows.csv"), row.names = FALSE, na = "")
write.csv(summary_tbl, file.path(staging, "SUMMARY_windows_paper_rule.csv"), row.names = FALSE, na = "")
writeLines(notes, file.path(staging, "METHODS_NOTES.md"))
output <- file.path(root, "output", "statistical_analysis", "results", "H4_sound_literature_test_windows")
dir.create(output, recursive = TRUE, showWarnings = FALSE)
invisible(file.copy(list.files(staging, full.names = TRUE), output, overwrite = TRUE))
cat("Saved", nrow(catalog), "rows to", output, "\n")
print(summary_tbl)
