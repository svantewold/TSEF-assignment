library(zoo)
library(car)
library(knitr)

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

test_output <- data.frame(
    "df" = 2,
    "f.value" = test$F[2],
    "critical.val.95" = 6.49,
    "critical.val.99" = 8.73,
    "dickey.f.teststat" = "φ_3"
)

latex_table <- kable(
    test_output,
    "latex",
    digits = 4,
    col.names = c(
        "Restrictions",
        "F-statistic",
        "Critical value for 95% confidence interval",
        "Critical value for 99% confidence interval",
        "Dickey-Fuller Test Statistic"
    )
)

write(latex_table, "output/tables/unit_root_test.tex")
