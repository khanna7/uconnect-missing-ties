## Simulate from fitted ergm object
   rm(list=ls())

   ## libraries
   library(ergm)
   library(network)

   ## data
   load("fitted_ergm_imputed_network_dyadind_nodemix_base13.RData")

   ## simulate in parallel
   nsim.vec <- 1:101
   sim_results <- as.list(nsim.vec)
   set.seed(Sys.time())

   for (iter in 1:length(nsim.vec)){
       sim_results[[iter]] <- simulate(ergm.imputed_network,
                                       nsim=1,
                                       constraints=~observed,
                                       control=control.simulate.ergm(
                                           MCMC.burnin=1e6, 
                                           MCMC.interval=1e5
                                           )
       )
   }

   ## sim_results

   ## save
   save.image("sim_from_fitted_ergm_objects_in_serial_hundred_dyad_ind_base_13.RData")
