library(data.table)

dt <- read_xlsx("data/raw/Nelson_Plosser_data.xlsx")

setDT(dt[, .(Year, CPI)])
dt
