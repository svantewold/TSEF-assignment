library(data.table, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
library(patchwork, warn.conflicts = FALSE)

dt <- fread(
  "data/simulated/simulated_series_estimation.csv"
)

dt[, t_stat := ((estimate - 1) / (std_error))]

quantiles <- data.table(
  "Model 1" = dt[
    model == 1,
    quantile(t_stat, probs = c(0.14, 0.86), na.rm = TRUE)
  ],
  "Model 2" = dt[
    model == 2,
    quantile(t_stat, probs = c(0.14, 0.86), na.rm = TRUE)
  ],
  "Model 3" = dt[
    model == 3,
    quantile(t_stat, probs = c(0.14, 0.86), na.rm = TRUE)
  ]
)

histogram_estimates <- dt |>
  ggplot(aes(x = estimate, color = model)) +
  geom_density(show.legend = FALSE, lwd = 2) +
  facet_wrap(~model, ncol = 1, scales = "free_y", strip.position = "right") +
  labs(x = "Estimated coefficient") +
  theme_light() +
  theme(
    axis.text = element_text(color = "black"),
    panel.grid = element_line(color = "grey85"),
    strip.background = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_text(margin = margin(14, 0, 0, 0)),
    strip.text.y.right = element_text(
      angle = 0,
      face = "bold",
      size = 11,
      color = "black"
    )
  )

histogram_t_stats <- dt |>
  ggplot(aes(x = t_stat, fill = model)) +
  geom_density(show.legend = FALSE) +
  facet_wrap(~model, ncol = 1, scales = "free", strip.position = "right") +
  labs(x = "T-statistic") +
  theme_light() +
  theme(
    axis.text = element_text(color = "black"),
    panel.grid = element_line(color = "grey85"),
    strip.background = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_text(margin = margin(14, 0, 0, 0)),
    strip.text.y.right = element_text(
      angle = 0,
      face = "bold",
      size = 11,
      color = "black"
    ),
  )

suppressWarnings(histogram_t_stats + histogram_estimates)
ggsave(
  "output/figures/simulated_estimation_densities.pdf",
  width = 8,
  height = 5,
  dpi = 300
)
