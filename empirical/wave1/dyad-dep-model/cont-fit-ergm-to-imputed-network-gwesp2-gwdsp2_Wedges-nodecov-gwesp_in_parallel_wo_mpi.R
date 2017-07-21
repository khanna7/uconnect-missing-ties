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
                                edges+
                                    gwesp(2, fixed=TRUE)+
                                        gwdsp(2, fixed=TRUE)+
                                        nodecov("respdeg"),
                                verbose=TRUE,
                                eval.loglik=FALSE,
                                control=control.ergm(MCMLE.maxit=2,
                                                     parallel=np,
                                                     init=c(-4.91,
                                                            0.135,
                                                            -0.0128,
                                                            0.036)
                                                     )
                                )
                                            
   ## save
   save.image("cont-fitted_ergm_imputed_network_gwesp2-gwdsp2-w-edges-nodecov-respdegin_parallel_wo_mpi.RData")
