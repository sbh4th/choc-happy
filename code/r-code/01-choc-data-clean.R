#  program:  01-choc-data-clean.R
#  task:     prepare analytic dataset
#  input:    choc-data-raw-r.csv
#  output:   t1
#  project:  chocolate and happiness
#  author:   sam harper \ 2021-01-17

# 0
# load libraries
library(here)
library(tidyverse)
library(kableExtra)

# 1
# Read in the simulated data, create factors

# read in the raw data
d <- read_csv(here("data-source", "choc-data-raw-r.csv"))

# create factors for period and treatment
d$period <- factor(d$period, levels=c(0,1,2), labels=c("Pre", "Intervention", "Post"))
d$treated <- factor(d$treated, levels=c(0,1), labels=c("Control", "Treated"))

# 2
# Summarize outcomes by period and year, generate table 1

# summarize means and SDs for table 1
t1 <- d %>%
  group_by(period, treated) %>%
  summarise(
    meany = mean(y),
    sdy = sd(y)
  )

# column names for the table
colnames(t1)[1:4] <- c("Period", "Treatment", "Mean", "SD")

# print the table
kable(t1, format = 'latex', digits=2,
      caption = "Mean happiness by treatment and time", booktabs = T) %>%
  collapse_rows(columns = 1:2)

# end
