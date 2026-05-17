hp_filter <- function(data, lambda) {
  T <- length(data)
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
  trend <- solve(m, data)
  cycle <- data - trend

  return(list(
    trend = trend,
    cycle = cycle,
    m = m
  ))
}
