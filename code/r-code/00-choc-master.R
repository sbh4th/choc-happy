#  program:  00-choc-data-master.R
#  task:     run all analyses
#  input:    choc-data-raw-r.csv
#  output:   none
#  project:  chocolate and happiness
#  author:   sam harper \ 2021-01-17

## Assumes the following file structure: 

 ## - r-scripts are located in a folder named "code/r-code".
 ## - Source data are in the "data-source" folder.
 ## - Derived datasets are in the "data-clean" folder.

## Requires the following packages: "here", "tidyverse", "kableExtra",
##   "stargazer", "ggplot2", "ggeffects"


# Create analytic dataset
source(here("code", "r-code", "01-choc-data-clean.R"))

# Run analysis
source(here("code", "r-code", "02-choc-data-analysis.R"))

# Generate figure
source(here("code", "r-code", "03-choc-data-figure.R"))


