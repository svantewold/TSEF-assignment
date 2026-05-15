library(data.table)
library(ggplot2)

dt <- fread(
  "data/processed/nelson_plosser_data.csv"
)[,
  .(
    year = Year,
    log_cpi = log(CPI)
  )
]

fwrite(
  dt,
  "data/processed/cpi_series.csv"
)

dt |>
  ggplot(aes(x = year, y = log_cpi)) +
  geom_line(color = "steelblue", lwd = 1) +
  labs(x = NULL, y = NULL) +
  scale_y_continuous(n.breaks = 7) +
  scale_x_continuous(n.breaks = 10) +
  coord_cartesian(
    ylim = c(3.15, 4.85),
    xlim = c(1857, 1973),
    expand = FALSE
  ) +
  theme_light() +
  theme(
    axis.text = element_text(color = "black"),
    panel.grid.minor = element_blank(),
    panel.grid = element_line(color = "grey85")
  )
ggsave("output/log_cpi_series.pdf", dpi = 300, width = 6, height = 4)
