library(data.table, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
library(latex2exp, warn.conflicts = FALSE)

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
ggsave("output/figures/log_cpi_series.pdf", dpi = 300, width = 5, height = 3)

pdf("output/figures/acf_log_cpi.pdf", width = 8, height = 5)
par(mfcol = c(1, 2), mar = c(3, 3, 3, 2))

dt[, diff(log_cpi)] |>
  acf(main = TeX("ACF of $\\Delta y_t$"))
dt[, diff(log_cpi)] |>
  pacf(main = TeX("PACF of $\\Delta y_t$"))

invisible(dev.off())
