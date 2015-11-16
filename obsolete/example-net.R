## create example nets for r-parallel

library(network)
library(ergm)

mynet <- network.initialize(50, directed=FALSE)
mynet.ergm <- ergm(mynet~edges, target.stats=50)
mynet <- simulate(mynet.ergm, 1)
mynet

mynet1 <- network.initialize(5000, directed=FALSE)
mynet1.ergm <- ergm(mynet1~edges, target.stats=5000)
mynet1 <- simulate(mynet1.ergm, 1)
mynet1

save.image("mynet.RData")

