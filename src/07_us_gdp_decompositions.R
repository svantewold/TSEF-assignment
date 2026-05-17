library(data.table, warn.conflicts = FALSE)
library(Matrix, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
import::from("src/lib/functions.R", hp_filter, bn_decomposition)

dt <- fread("data/processed/us_gdp_series.csv")

dt[,
  ":="(
    bn_permanent = bn_decomposition(log_gdp)$trend,
    bn_transitory = bn_decomposition(log_gdp)$cycle,
    hp_permanent = hp_filter(log_gdp, 1600)$trend,
    hp_transitory = hp_filter(log_gdp, 1600)$cycle
  )
]

melt(
  dt,
  id.vars = "date",
  measure.vars = c("bn_transitory", "hp_transitory")
) |>
  ggplot(aes(x = date, color = variable)) +
  geom_line(aes(y = value), lwd = 1) +
  labs(x = NULL, y = NULL) +
  theme_light() +
  theme(
    axis.text = element_text(color = "black"),
    panel.grid.minor = element_blank(),
    panel.grid = element_line(color = "grey85")
  )
