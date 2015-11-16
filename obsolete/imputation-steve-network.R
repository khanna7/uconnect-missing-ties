# Demonstration of imputation of alter-alter ties using degree with
#      with respondents as one predictor of the missing ties

rm(list=ls())
##########################
# params to set
nresp <- 300
nalters <- 700
mdeg <- 22
#mdeg <- 35

##########################
# Process
library(ergm)
n <- nresp + nalters

###########################
# Create init net

mynet <- network.initialize(n, directed=F)
greg <- runif(n) # just to get extra variation in underlying observed degree
mynet <- set.vertex.attribute(mynet, 'greg', greg)
myfit <- ergm(mynet~edges+nodecov('greg'),
              target.stats=c(mdeg*n/2,1.1*mdeg*n/2)) # The 1.1 means that those with higher 'gregariousness'
                                                     # will form more ties.
mynet <- simulate(myfit)

#########################
save.image(file="steve-example-network.RData")
