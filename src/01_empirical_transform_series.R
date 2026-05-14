library(readxl)
library(ggplot2)
library(data.table)

dt <- read_xlsx("data/Nelson_Plosser_data.xlsx") |>
  setDT()

series <- names(dt)[-1]
