source("library/Paper3_common.R")
paper3_attach_statistical_common()
PROJECT_ROOT <- resolve_project_root()
source("library/Paper3_corridor_grid.R")
raw <- read.csv(paper3_merged_8min_path(PROJECT_ROOT), check.names = FALSE)
raw <- paper3_timeseries_attach_corridor_grid(raw, PROJECT_ROOT)
raw <- raw[raw$ParticipantID %in% PAPER3_PARTICIPANTS & raw$PhaseID %in% PAPER3_CORE_PHASES, ]
cat("rows", nrow(raw), "grid ok", sum(!is.na(raw$grid_f)), "\n")
y <- "empatica_heart_rate"
pred <- c("ucm_UTCI", "ucm_SND_dBA", "ucm_SUN_Gh", "SVF", "atmo_pm2.5_avg", "lys_lux_avg", "lys_kelvin_avg", "gvi_50m")
ok <- complete.cases(raw[, c(pred, y)]) & !is.na(raw$grid_f)
cat("heart_rate eq1 ok", sum(ok), "\n")
y2 <- "empatica_hrv_fd"
ok2 <- complete.cases(raw[, c(pred, y2)]) & !is.na(raw$grid_f) & tolower(as.character(raw$empatica_hrv_fd_5min_available)) %in% c("true", "1")
cat("hrv_fd ok", sum(ok2), "\n")
