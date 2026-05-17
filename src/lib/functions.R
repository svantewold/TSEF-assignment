hp_filter <- function(series, lambda) {
  T <- length(series)
  I <- Diagonal(T)

  D <- bandSparse(
    T - 2,
    T,
    k = c(0, 1, 2),
    diagonals = list(
      rep(1, T - 2),
      rep(-2, T - 2),
      rep(1, T - 2)
    )
  )

  m <- I + lambda * crossprod(D)
  trend <- solve(m, series)
  cycle <- series - trend

  return(list(
    trend = trend,
    cycle = cycle,
    m = m
  ))
}

bn_decomposition <- function(series) {
  arma <- arima(diff(series), order = c(1, 0, 0))
  ar_coef <- arma$coef[1]
  intercept <- arma$coef[2]

  perm <- series[-1] +
    (diff(series) - intercept) *
      (ar_coef / (1 - ar_coef))
  trend <- c(NA, perm)

  cycle <- (series - trend)

  return(list(
    trend = trend,
    cycle = cycle
  ))
}
