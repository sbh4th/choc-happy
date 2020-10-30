#  program:  03-choc-data-figure.R
#  task:     plot regression results
#  input:    choc-data-raw-r.csv
#  output:   f1
#  project:  chocolate and happiness
#  author:   sam harper \ 2020-10-27

# 0
# load libraries
library(here)
library(ggplot2)


# 1
# Regression analysis

# treatment effect, adjusted for period
t2c <- lm(y ~ treated + period, data=d)

# treatment effect interacted with period
t2i <- lm(y ~ treated * period, data=d)

# 3
# Regression figure
f1 <- plot(ggpredict(t2i, terms = c("period", "treated")), connect.lines = TRUE)
f1 + labs(x="Time period", y="Predicted happiness index", title="Effect of chocolate on happiness", colour="Treatment\ngroup")

# end
