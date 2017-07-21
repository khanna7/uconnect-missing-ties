## create network with unobserved edges from wave 1
   rm(list=ls())

################################
## parallelization frontmatter
## From: https://statnet.csde.washington.edu/trac/wiki/ergmParallel

   library(parallel)

   # create a cluster with 2 processes per node
   np <- detectCores()
   np
#################################

## Fitting procedure

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="gwesp-setup.RData")

   ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(imputed_network ~ edges+
                                    nodecov('respdeg')+
                                        gwesp(1, fixed=TRUE),
                                verbose=TRUE,
                                control=control.ergm(MCMLE.maxit=50,
                                                     parallel=np
                                                     )
                                )
                                            
   ## save
   saveRDS(ergm.imputed_network, "fitted_ergm_imputed_network_gwesp1_wnodemix-base13_in_parallel_wo_mpi.RDS")
