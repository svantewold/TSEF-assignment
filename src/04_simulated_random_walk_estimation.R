# Generate simulations --------

sim_rwalk <- function(T) {
  white_noise <- rnorm(T)
  random_walk_series <- cumsum(white_noise)

  return(random_walk_series)
}

simulations <- replicate(
  100000,
  sim_rwalk(81)
)
