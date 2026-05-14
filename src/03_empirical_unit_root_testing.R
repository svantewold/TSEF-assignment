library(data.table)
library(ggplot2)

cpi_dt <- fread(
    "data/processed/cpi_series.csv"
)

cpi_dt |>
    ggplot(aes(x = year, y = log_cpi)) +
    geom_line()
