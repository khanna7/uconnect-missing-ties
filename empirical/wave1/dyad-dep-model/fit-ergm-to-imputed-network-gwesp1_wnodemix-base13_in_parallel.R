## create network with unobserved edges from wave 1
   rm(list=ls())

################################
## parallelization frontmatter
## From: https://statnet.csde.washington.edu/trac/wiki/ergmParallel

   library(Rmpi)
   library(snow)
   library(methods)

   # create a cluster with 2 processes per node
   np <- mpi.universe.size()-1
   cluster <- makeMPIcluster(np)

   # Print the hostname for each cluster member
   sayhello <- function(){
    info <- Sys.info()[c("nodename", "machine")]
    paste("Hello from", info[1], "with CPU type", info[2])
}

  message('RMPI nodes: ', mpi.comm.size())
  names <- clusterCall(cluster, sayhello)
  print(unlist(names))

#################################

## Fitting procedure

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="gwesp-setup.RData")

   ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(imputed_network ~ nodecov('respdeg')+
                                                  gwesp(1, fixed=TRUE)+
                                                  nodemix("respondent",
                                                          base=c(1,3)),
                                                  verbose=TRUE,
                                control=control.ergm(MCMLE.maxit=50,
                                                     parallel=cluster
                                                     )
                                )
                                            
   ## save
   saveRDS(ergm.imputed_network, "fitted_ergm_imputed_network_gwesp1_wnodemix-base13_in_parallel.RDS")
