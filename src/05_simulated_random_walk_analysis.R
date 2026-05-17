library(data.table, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)

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
  ggplot(aes(x = estimate, fill = model)) +
  geom_histogram(show.legend = FALSE) +
  facet_wrap(~model, ncol = 1)

histogram_t_stats <- dt |>
  ggplot(aes(x = t_stat, fill = model)) +
  geom_histogram(show.legend = FALSE, bins = 3) +
  facet_wrap(~model, ncol = 1)

histogram_t_stats
