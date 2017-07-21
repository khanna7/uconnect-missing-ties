## simulate from gwesp model

   rm(list=ls())

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="fitted_ergm_imputed_network_gwesp1_maxit30.RData")

   sim <- simulate(ergm.imputed_network, constraints=~observed, nsim=1,
                   control=control.simulate.ergm(
                       MCMC.burnin=1e7, #went up to 5e8 for testing on both 
                       MCMC.interval=1e6
                   )
                   )

   sim #simualted object

   ## save
   save.image(file="sim_from_gwesp_maxit30.RData")
