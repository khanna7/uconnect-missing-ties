## Simulate from fitted ergm object
rm(list=ls())

## libraries
library(ergm)
library(network)

## data
load("fitted_ergm_w1w2.RData")

##testing code
sim <- simulate(ergm.imputed_network_w2 ,
                nsim=1, 
                constraints =~observed, control=control.simulate.ergm(
                  MCMC.burnin=1e6, 
                  MCMC.interval=1e5
                ) )


## simulate in parallel
nsim.vec <- 1:100
sim_results_w1 <- as.list(nsim.vec)
sim_results_w2 <- as.list(nsim.vec)
set.seed(Sys.time())
 
for (iter in 1:length(nsim.vec)){
  sim_results_w1[[iter]] <- simulate(ergm.imputed_network_w1,
                                  nsim=1,
                                  constraints=~observed,
                                  control=control.simulate.ergm(
                                    MCMC.burnin=1e7, 
                                    MCMC.interval=1e6
                                  )
  )
}

for (iter in 1:length(nsim.vec)){
  sim_results_w2[[iter]] <- simulate(ergm.imputed_network_w2,
                                     nsim=1,
                                     constraints=~observed,
                                     control=control.simulate.ergm(
                                       MCMC.burnin=1e7, 
                                       MCMC.interval=1e6
                                     )
  )
}





## sim_results

## save
#save.image("sim_from_fitted_ergm_w1w2.RData")