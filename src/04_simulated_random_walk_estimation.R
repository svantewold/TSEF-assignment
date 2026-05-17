library(data.table)

# Random walk simulation function
sim_rwalk <- function(T) {
  white_noise <- rnorm(T)
  random_walk_series <- cumsum(white_noise)

  return(random_walk_series)
}

# Estimate and std. error extraction function
regs <- function(series) {
  x <- series
  time_trend <- 1:length(series)

  mod1 <- lm(x ~ 0 + lag(x, k = -1)) |> summary()
  m1 <- mod1$coefficients[1:2]

  mod2 <- lm(x ~ lag(x, k = -1)) |> summary()
  m2 <- mod2$coefficients[2, 1:2]

  mod3 <- lm(x ~ lag(x, k = -1) + time_trend) |> summary()
  m3 <- mod3$coefficients[2, 1:2]

  estimates <- data.table(
    "model" = c(1, 2, 3),
    "estimate" = c(m1[1], m2[1], m3[1]),
    "std_error" = c(m1[2], m2[2], m3[2])
  )

  return(estimates)
}

set.seed(123) # setting seed for replication purposes

sim <- list()
for (i in 1:100000) {
  sim[[i]] <- sim_rwalk(81)
}

estimates <- list()
for (i in 1:length(sim)) {
  estimates[[i]] <- regs(sim[[i]])
}

dt <- rbindlist(estimates)

fwrite(dt, "data/processed/simulated_series_estimation.csv")
