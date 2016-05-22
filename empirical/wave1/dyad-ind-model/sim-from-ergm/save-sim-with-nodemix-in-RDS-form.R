## save imputed networks in RDS form.
## also create a list of 10 for a small sample


   rm(list=ls())

   ## libraries
   library(sna)
   library(network)

   ## data
   load("sim_from_fitted_ergm_objects_in_serial_hundred_dyad_ind_base_13.RData")
   length(sim_results)
   sim_results[[1]]

   ## save 100
   sel_100_nets <- sample(sim_results, 100)
   saveRDS(sel_100_nets, "imputed_100_nets_w_nodemix.RDS")

   ## save 10
   sel_10_nets <- sample(sim_results, 10)
   saveRDS(sel_10_nets, "imputed_10_nets_w_nodemix.RDS")
