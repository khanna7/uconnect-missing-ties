## Simulate from fitted ergm object
   rm(list=ls())

   ## libraries
   library(ergm)
   library(network)

   ## data
   load("fitted_ergm.RData")

   ## simulate in parallel
   nsim.vec <- 1:10
   sim_results <- as.list(nsim.vec)
   set.seed(Sys.time())

   for (iter in 1:length(nsim.vec)){
       sim_results[[iter]] <- simulate(ergm.imputed_network,
                                       nsim=1,
                                       constraints=~observed,
                                       control=control.simulate.ergm(
                                       #MCMC.burnin=1e6, 
                                       MCMC.burnin=1e7,     
                                       #MCMC.interval=1e5
                                       MCMC.interval=1e6
                                       )
       )
   }

   ## sim_results
   size <- lapply(sim_results, network.size)
   edgecount <- lapply(sim_results, network.edgecount)
   
   ((6636*2)/334)/333 #density of observed R-R quadrant
   (44402)/(334*734) #density of observed R-NR quadrant
   ((mean(unlist(edgecount))-51000*2)/734)/733 #density of simulated NR-NR quadrant
   
   ## save
   save.image("ten_simulated_networks.RData")
