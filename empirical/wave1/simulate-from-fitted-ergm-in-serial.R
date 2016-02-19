## Simulate from fitted ergm object
   rm(list=ls())
   ## libraries
   library(network)
   library(ergm)

   ## data
   load("fitted_ergm_imputed_network.RData")
   #load("fitted_ergm_imputed_network-lower-missing-alters.RData")

   ## Simulate from fitted ERGM
   sim <- simulate(ergm.imputed_network, constraints=~observed, nsim=1,
                   control=control.simulate.ergm(
                       MCMC.burnin=5e8,
                       MCMC.interval=5e8
                   )
                   )
   sim #simualted object
   
   ## save
   save.image("sim_from_fitted_ergm_objects_in_serial.RData")
