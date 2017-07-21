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
   ergm.imputed_network <- ergm(imputed_network ~
                                nodecov("respdeg")+
                                    gwesp(2, fixed=TRUE),
                                verbose=TRUE,
                                control=control.ergm(MCMLE.maxit=1,
                                                     parallel=np,
                                                     init=c(-0.01209570,
                                                         -0.01393157)
                                                     )
                                )
                                            
   ## save
   saveRDS(ergm.imputed_network, file="fitted_ergm_imputed_network_gwesp2-wo-edges-w-nodecov-respdegin_parallel_wo_mpi_bigmem.RDS")

   save.image(file="fitted_ergm_imputed_network_gwesp2-wo-edges-w-nodecov-respdegin_parallel_wo_mpi_bigmem.RData")

