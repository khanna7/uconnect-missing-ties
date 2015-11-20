## Simulate from fitted ergm object
   rm(list=ls())

   ## libraries
   library(ergm)
   library(snow)
   library(Rmpi)
   library(methods)

   ## data
   load("fitted_ergm_imputed_network.RData")

   ## function to be used in parLapply
   simulate_in_parallel <-
       function(imputed.ergm.object){
           library(network)
           library(ergm)
           load("fitted_ergm_imputed_network.RData")
           is.network(mynet.imputed)
           sim <- simulate(imputed.ergm.object, constraints=~observed, nsim=1)
           return(sim)
       }

    ## set up mpi


    ## simulate in parallel


    ## stop mpi

   ## Simulate from fitted ERGM
   sim <- simulate(ergm.imputed_network, constraints=~observed, nsim=1)

   ## save
   save.image("sim_from_fitted_ergm_objects.RData")
