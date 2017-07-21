## simulate from gwesp model

   rm(list=ls())

   ## set up parallel
   library(parallel)
   np <- detectCores()

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="gwesp-setup.RData")
   ergm.imputed_network <- readRDS("fitted_ergm_imputed_network_gwesp1_wo-nodecov-respdeg-base1_in_parallel_wo_mpi.RDS")

   sim <- list(1:50)

   for (i in 1:length(sim)){
       sim[[i]] <- simulate(ergm.imputed_network, constraints=~observed, nsim=1,
                            control=control.simulate.ergm(
                                MCMC.burnin=1e7,
                                MCMC.interval=1e6,
                                parallel=np
                            )
                            )
   }

   #sim #simualted object

   ## save
   save.image(file="sim_from_gwesp_no_nodecov.RData")
