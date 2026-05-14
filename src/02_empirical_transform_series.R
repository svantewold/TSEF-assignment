library(data.table)

dt <- fread(
  "data/processed/nelson_plosser_data.csv",
  select = c("Year", "CPI")
)

dt[,
  .(
    year = Year,
    log_cpi = log(CPI),
    cpi = CPI
  )
]

fwrite(
  dt,
  "data/processed/cpi_series.csv"
)
