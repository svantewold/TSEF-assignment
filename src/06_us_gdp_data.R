library(readxl)
library(data.table)

dt <- read_xlsx(
  "data/raw/real_gdp_US_2022Q4.xlsx"
) |>
  setDT()

dt <- dt[,
  ":="(
    date = strptime(dt$dates, format = "%d-%b-%Y") |> as.IDate(),
    log_gdp = log(gdpc1)
  )
] |>
  _[date < "2020-01-01", .(date, log_gdp, nber = NBER)]

fwrite(
  dt,
  "data/processed/us_gdp_series.csv"
)
