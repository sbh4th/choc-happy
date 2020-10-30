#  program:  02-choc-data-analysis.R
#  task:     regression results
#  input:    choc-data-raw-r.csv
#  output:   t2c t2i
#  project:  chocolate and happiness
#  author:   sam harper \ 2020-10-27

# 0
# load libraries
library(here)
library(stargazer)
library(ggplot2)


# 1
# Regression analysis

# treatment effect, adjusted for period
t2c <- lm(y ~ treated + period, data=d)

# treatment effect interacted with period
t2i <- lm(y ~ treated * period, data=d)

# 2
# Write regression results into a single table

# write to table
stargazer(t2c, t2i,  ci=TRUE, star.cutoffs = NA, notes="", digits=2,
          column.labels = c("Adjusted model", "Interaction Model"),
          covariate.labels = c("Treated: Yes", "Time: Intervention",
          "Time: Post", "Treated x Intervention", "Treated x Post"),
          dep.var.caption = "", dep.var.labels.include = FALSE,
          model.numbers = FALSE, header=FALSE, omit.stat="all",
          omit.table.layout = "sn", type='latex',
          title = "Effect of chocolate on happiness")

# end
