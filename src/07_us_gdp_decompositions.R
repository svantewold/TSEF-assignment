library(data.table)
library(Matrix)
import::from("src/lib/functions.R", hp_filter)

dt <- fread("data/processed/us_gdp_series.csv")

dt[,
  ":="(
    hp_transitory = hp_filter(log_gdp, 1600)$cycle,
    hp_permanent = hp_filter(log_gdp, 1600)$trend
  )
]
