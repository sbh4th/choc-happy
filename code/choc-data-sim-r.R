#  program:  choc-data-sim.R
#  task:     simulate chocolate data
#  input:    none
#  output:   choc-data-raw-r.csv
#  project:  graduate student chocolate intervention study
#  author:   sam harper \ 2020-03-01

## 0
# load packages and set the seed

library(simstudy)
library(tidyverse)

set.seed(8231)

## 1
# define variable for dataset

# generate 500 individuals, 3 periods of observation
gen.indiv <- defData(varname = "u0", dist = "normal", formula = 0, variance = 1, 
    id = "id")
gen.indiv <- defData(gen.indiv, varname = "nperiods", dist = "nonrandom", 
    formula = 3)

dtIndiv <- genData(500, gen.indiv)

# 50 percent randomly assigned to treatment
dtIndiv <- trtAssign(dtIndiv, n = 2)

## 2
# expand dataset to 3 periods per individual
gen.time <- defDataAdd(varname = "e0", dist = "normal", formula = 0, variance = 5)
gen.time <- defDataAdd(gen.time, varname = "nPeriods", dist = "nonrandom", 
    formula = 3)

dtTime <- genCluster(dtIndiv, "id", numIndsVar = "nperiods", level1ID = "idTime")
dtTime <- addColumns(gen.time, dtTime)

# create index for period number for each individual
dtTime <- dtTime %>% group_by(id) %>% mutate(period = row_number()-1)

# dummy variables for each period
dtTime$p2 <- ifelse(dtTime$period==1, 1, 0)
dtTime$p3 <- ifelse(dtTime$period==2, 1, 0)

# outcome variable, varies by time
addef <- defDataAdd(varname = "y", dist = "normal", 
                    formula = "10 + (p2 * 5) + (trtGrp * p2 * 2) + (p3 * 10)  + (trtGrp * p3 * 5) + u0 + e0", variance = 50)

# add outcome to dataset
dtTime <- addColumns(addef, dtTime)

# variable for treated
dtTime$treated <- dtTime$trtGrp

# export to CSV file

myvars <- subset(dtTime, select=c("id", "treated", "period", "y"))

write_csv(myvars, "../data-source/choc-data-raw-r.csv", na = "NA", 
          append = FALSE, col_names = TRUE, quote_escape = "double")

