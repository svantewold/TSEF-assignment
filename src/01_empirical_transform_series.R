library(readxl)
library(ggplot2)
library(data.table)

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
  facet_wrap(~variable, scales = "free_y") +
  labs(x = NULL, y = NULL) +
  theme_light()
