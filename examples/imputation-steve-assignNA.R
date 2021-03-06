## assign NA (crucial step that needs to be parallelized)

   rm(list=ls())

   library(network)
   library(snow)
   library(Rmpi)

   load("steve-example-network.RData")

   mynet.mat <- as.matrix(mynet, "adjacency")

    np <- mpi.universe.size() - 1
    cl <- makeCluster(np, type="MPI")
    imputed_matrix <- parApply(cl, mynet.mat[((nresp+1):n), ((nresp+1):n)], c(1:2), function(x) x <- NA)


   proc.time()
   dim(imputed_matrix)

   save(imputed_matrix, file="steve-imputed-matrix-ii.RData")

   imputed_matrix
   stopCluster(cl)
   mpi.exit()

