library(readxl, warn.conflicts = FALSE)
library(ggplot2, warn.conflicts = FALSE)
library(data.table, warn.conflicts = FALSE)

dt <- read_xlsx("data/raw/Nelson_Plosser_data.xlsx") |>
  setDT()

series <- names(dt)[-1]

dt_plot <- dt |>
  melt(
    id.vars = "Year",
    measure.vars = series
  )

dt_plot |>
  ggplot(aes(x = Year, y = value, group = variable, color = variable)) +
  geom_line(show.legend = FALSE) +
  facet_wrap(~variable, scales = "free_y", nrow = 5) +
  labs(x = NULL, y = NULL) +
  theme_light()

ggsave(
  "output/nelson_plosser_data_series.pdf",
  dpi = 300,
  width = 10,
  height = 8
)

fwrite(
  dt,
  "data/processed/nelson_plosser_data.csv"
)
