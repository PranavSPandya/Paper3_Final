args <- commandArgs(TRUE)
library(nlme)
d <- read.csv(args[1], check.names = FALSE)
out <- args[2]
dir.create(out, recursive = TRUE, showWarnings = FALSE)
ids <- c("P4","P8","P9","P10","P11","P12","P13","P14","P15","P16","P17")
d <- d[d$ParticipantID %in% ids & d$PhaseID %in% c("BikeG","BikeU"), ]
names_map <- c(person="ParticipantID", route="PhaseID", wind="ucm_WIND_AWS", speed="ucm_GPS_speed_kmh",
  lon="ucm_GPS_lon", lat="ucm_GPS_lat", dba="ucm_SND_dBA", centroid="spectral_centroid_Hz",
  low_share="freq_proportion_20_to_200Hz", time="Datetime")
d <- setNames(d[, names_map], names(names_map))
d$time <- as.numeric(as.POSIXct(d$time, tz="UTC"))
stopifnot(!anyDuplicated(d[c("person","route","time")]))
d <- d[complete.cases(d[c("person","route","wind","speed","lon","lat","time")]), ]
d$elapsed <- ave(d$time, d$person, d$route, FUN=function(x)x-min(x))
# Local equirectangular projection for a fixed 100 m grid shared by participants.
d$x <- (d$lon - median(d$lon)) * 111320 * cos(median(d$lat)*pi/180)
d$y <- (d$lat - median(d$lat)) * 110540
d$low_share <- d$low_share * 100
make_grid <- function(a) paste(floor(a$x/100),floor(a$y/100),sep=":")
coarsen <- function(a, seconds) {
 a$step <- floor(a$elapsed/seconds + 1e-7)
 if(seconds==10) return(a)
 do.call(rbind,lapply(split(a,list(a$person,a$step),drop=TRUE),function(b) {
   first <- b[1,]
   for(c in c("wind","speed","x","y","centroid","low_share")) first[[c]] <- mean(b[[c]],na.rm=TRUE)
   first$dba <- 10*log10(mean(10^(b$dba/10),na.rm=TRUE))
   first
 }))
}
fit <- function(a) {
 a <- a[order(a$person,a$step), ]
 lme(value ~ wind + speed + factor(cell), random=~1|person,
    correlation=corCAR1(value=.2, form=~step|person), data=a, method="REML",
    control=lmeControl(opt="nlminb", msMaxIter=150))
}
results <- list()
loo_rows <- list()
slopes <- list()
for (route in c("BikeG","BikeU")) for (seconds in c(10,30)) {
 a <- coarsen(d[d$route==route,], seconds)
 a$cell <- make_grid(a)
 for (outcome in c("dba","centroid","low_share")) {
  a$value <- a[[outcome]]
  b <- a[is.finite(a$value),]
  # Restrict location inference to grid cells visited by at least two participants.
  b <- b[b$cell %in% names(which(tapply(b$person,b$cell,function(x)length(unique(x)))>=2)),]
  cat(route,seconds,outcome,nrow(b),"\n"); flush.console()
  m <- fit(b)
  people <- sort(unique(b$person))
  est <- fixef(m)[["wind"]]
  loo <- vapply(people,function(id) fixef(fit(b[b$person!=id,]))[["wind"]],numeric(1))
  n <- length(loo)
  se <- sqrt((n-1)/n*sum((loo-mean(loo))^2))
  margin <- qt(.975,n-1)*se
  p <- 2*pt(-abs(est/se),n-1)
  speed_cor <- cor(b$wind,b$speed)
  aux <- lm(wind ~ speed + factor(cell) + factor(person),data=b)
  results[[length(results)+1]] <- data.frame(route, seconds, outcome, rows=nrow(b), participants=n,
    cells=length(unique(b$cell)), beta=est, lower=est-margin, upper=est+margin, p,
    loo_min=min(loo), loo_max=max(loo), wind_speed_r=speed_cor,
    wind_vif_with_controls=1/(1-summary(aux)$r.squared))
  loo_rows[[length(loo_rows)+1]] <- data.frame(route, seconds, outcome, omitted=people, beta=loo)
  if(seconds==10) for(id in people) {
    one <- b[b$person==id,]
    formula <- if(length(unique(one$cell))>1) value ~ wind + speed + factor(cell) else value ~ wind + speed
    individual <- lm(formula,one)
    slopes[[length(slopes)+1]] <- data.frame(route,outcome,person=id,rows=nrow(one),
      beta=unname(coef(individual)["wind"]))
  }
 }
}
r <- do.call(rbind,results)
r$q_10s <- NA_real_
r$q_10s[r$seconds==10] <- p.adjust(r$p[r$seconds==10],"BH")
write.csv(r,file.path(out,"wind_route_models.csv"),row.names=FALSE)
write.csv(do.call(rbind,loo_rows),file.path(out,"wind_leave_one_participant_out.csv"),row.names=FALSE)
write.csv(do.call(rbind,slopes),file.path(out,"wind_participant_slopes.csv"),row.names=FALSE)
print(r,digits=4,row.names=FALSE)

