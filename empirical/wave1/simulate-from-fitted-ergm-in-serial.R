## Simulate from fitted ergm object
   rm(list=ls())
   ## libraries
   library(network)
   library(ergm)

   ## data
   load("fitted_ergm_imputed_network.RData")
   #load("fitted_ergm_imputed_network-lower-missing-alters.RData")

   ## Simulate from fitted ERGM
   sim_list <- as.list(1:100)
   
   for (i in 1:length(sim_list)){
   sim_list[[i]] <- simulate(ergm.imputed_network, constraints=~observed, nsim=1,
                   control=control.simulate.ergm(
                       MCMC.burnin=1e6, #went up to 5e8 for testing on both 
                       MCMC.interval=1e5
                   )
                   )
   }
   #sim #simualted object
   
   ## save
   saveRDS(sim_list, "sim_from_fitted_ind_ergm_objects_in_serial_nonodemix.RDS")
   save.image("sim_from_fitted_ergm_objects_in_serial.RData")
 
