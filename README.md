# Time Series Econometrics Exercises

I have written this code as part of an assignment submission in the course Time Series Econometrics for Finance. This repository conducts analysis and calculations, and creates figures and tables for the hand-in. The repository can be run from the project entry point `00_run_all.R`.

## Unit-root testing

From `Nelson_Plosser_data.xlsx` I have focused on the CPI series and tested it for unit roots with the Augmented Dickey-Fuller test.

- `01_empirical_plot_series.R` exports a plot with all series in the data and exports all data to a `csv` file.
- `02_empirical_transform_series.R` log-transforms the CPI series, exports a plot of the transformed series, and exports a table with the series and dates.
- `03_empirical_unit_root_testing.R` performs the Augmented Dickey-Fuller test, taking to account that the series is trending and thus tests for joint significance of a unit root and a linear time trend. The script exports a `latex` table with the results.

## Estimations on simulated random walks

`04_simulated_random_walk_estimation.R` simulates $N=100000$ sequences of the pure random walk process
$$x_t = x_{t-1} + u_t$$
of size $T=81$ where $u_t \sim N(0,1)$ and $x_0=0$. It then estimates 3 different linear regression models to the sequences:
$$x_t = \rho x_{t-1} + u_t \tag{1}$$
$$x_t = c + \rho x_{t-1} + u_t \tag{2}$$
$$x_t = c + \delta t + \rho x_{t-1} + u_t \tag{3}$$
where $t$ is a linear and deterministic time trend. The estimates, $\hat \rho$, and the standard errors, $SE(\hat \rho)$, are extracted into a large data table which is then exported in order to avoid to have to redo the simulation for analysis.

`05_simulated_random_walk_analysis.R` computes t-statistics for the null hypothesis: $\rho=1$ for all series and models. It then calculates percentiles for the 3 different models and exports a `latex` table, presenting the percentiles per model. It also produces density plots of the t-statistics and estimates and exports those in a joint figure.

NB! The project entry point will look for the simulated data and avoid running the simulation if the data already exists.

## US real GDP decompositions

- `06_us_gdp_data.R` truncates the US real GDP series from `real_gdp_US_2022Q4.xlsx` to end at 2019:Q4, log-transforms the series and exports the table.
- `07_us_gdp_decompositions.R` applies a Beveridge-Nelson decomposition and a Hodrick-Prescott filter on the real GDP series. It then exports a plot of the transitory components from both decompositions.

The functions that perform the decompositions are defined in `src/lib/functions.R`.