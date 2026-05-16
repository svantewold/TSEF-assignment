library(zoo)
library(car)
library(kableExtra)

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
    "dickey.f.teststat" = "$\\phi_3$"
)

latex_table <- kbl(
    test_output,
    "latex",
    digits = 4,
    col.names = c(
        "Restrictions",
        "F-statistic",
        "Critical value 95\\%",
        "Critical value 99\\%",
        "Dickey-Fuller Test Statistic"
    ),
    escape = FALSE,
    booktabs = TRUE,
    caption = "Test statistic and critical values for\\\\ unit root hypothesis test",
    align = c("ccccc")
)

write(latex_table, "output/tables/unit_root_test.tex")
