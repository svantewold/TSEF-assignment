library(zoo)
library(car)

cpi_series <- read.csv(
    "data/processed/cpi_series.csv"
) |>
    as.zoo()

cpi_series$first_diff <- diff(cpi_series$log_cpi)

cpi_series$lags <- lag(cpi_series$log_cpi, k = -1)

cpi_series$first_diff_lags <- lag(cpi_series$first_diff, k = -1)

time_trend <- 1:length(cpi_series$first_diff_lags)

model <- lm(
    formula = first_diff ~ lags + time_trend + first_diff_lags,
    data = cpi_series
)

test <- linearHypothesis(model, c("lags = 0", "time_trend = 0"))
