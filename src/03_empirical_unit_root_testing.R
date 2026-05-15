library(data.table)
library(ggplot2)
library(car)
library(zoo)

cpi_dt <- fread(
    "data/processed/cpi_series.csv"
)[,
    ":="(
        log_cpi = as.zoo(log_cpi)
    )
]

cpi_dt |>
    ggplot(aes(x = year, y = log_cpi)) +
    geom_line()

time_trend <- 1:(length(cpi_dt$log_cpi) - 1)

model <- lm(formula = diff(log_cpi) ~ lag(log_cpi) + time_trend, data = cpi_dt)

test <- linearHypothesis(model, "lag(log_cpi) = time_trend")
test$F
