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
  geom_line(aes(y = value), lwd = .5) +
  labs(x = NULL, y = NULL, color = NULL) +
  scale_x_date(date_breaks = "15 years") +
  scale_color_discrete(
    labels = c("Beveridge-Nelson decomposition", "Hodrick-Prescott filter")
  ) +
  theme_light() +
  theme(
    axis.text = element_text(color = "black"),
    panel.grid.minor = element_blank(),
    panel.grid = element_line(color = "grey85"),
    legend.position = "top",
    legend.margin = margin(0, 0, -6, 0)
  )
ggsave(
  "output/figures/gdp_decompositions_transitory.pdf",
  dpi = 300,
  width = 5,
  height = 3
)
