message("Running project entry point...\n")
source("src/01_empirical_plot_series.R")
source("src/02_empirical_transform_series.R")
source("src/03_empirical_unit_root_testing.R")

if (!file.exists("data/simulated/simulated_series_estimation.csv")) {
    suppressWarnings(
        source("src/04_simulated_random_walk_estimation.R")
    )
} else {
    message("- Simulated data is already present, skipping simulation.")
}

source("src/05_simulated_random_walk_analysis.R")
source("src/06_us_gdp_data.R")
suppressWarnings(
    source("src/07_us_gdp_decompositions.R")
)

invisible(
    gert::git_commit_all(
        "Project entry point: ran and commited output files."
    )
)
message("- Commited output files via git.\n")

message("Project entry point ran successfully!")
