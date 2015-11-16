## model steve's big network

   library(network)
   library(ergm)

   rm(list=ls())
   load("steve-example-network.RData")
   load("steve-imputed-matrix-ii.RData")

   mynet.mat <- as.matrix(mynet, "adjacency")
   mynet.mat[((nresp+1):n),((nresp+1):n)] <- imputed_matrix

   mynet.imputed <- as.network.matrix(mynet.mat, matrix.type="adjacency",
                                      directed=FALSE)
   summary(mynet.imputed ~ edges)

   respdeg <- sapply(1:n, function(x) sum(mynet.imputed[x,1:nresp])) 
   mynet.imputed <- set.vertex.attribute(mynet.imputed, 'respdeg', respdeg)  
   table(mynet.imputed%v%"respdeg"); length(mynet.imputed%v%"respdeg")

   t0 <- proc.time()
   mynet.imputed.ergm <- ergm(mynet.imputed ~ edges+nodecov('respdeg')
                              )
   proc.time() - t0

   sim <- simulate(mynet.imputed.ergm,
                   constraints=~observed, nsim=5)

   save.image("parallel-ergm-imputation-steve-ex.RData")
