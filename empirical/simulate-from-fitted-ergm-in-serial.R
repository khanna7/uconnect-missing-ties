## Simulate from fitted ergm object
   rm(list=ls())
   ## libraries
   library(ergm)

   ## data
   load("fitted_ergm_imputed_network.RData")

   ## Simulate from fitted ERGM
   sim <- simulate(ergm.imputed_network, constraints=~observed, nsim=1)
   sim #simualted object
   
   ## save
   save.image("sim_from_fitted_ergm_objects_in_serial.RData")
