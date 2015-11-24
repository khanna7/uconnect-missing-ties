## Simulate from fitted ergm object
   rm(list=ls())

   ## libraries
   library(ergm)
   library(network)
   library(snow)
   library(Rmpi)
   library(methods)

   ## data
   load("fitted_ergm_imputed_network.RData")

    ## set up mpi
    is.network(imputed_network)
    np <- mpi.universe.size()-1
    cluster <- makeCluster(np, type="MPI")

    ## simulate in parallel
    nsim.vec <- 1:10

    sim_results <- parLapply(cluster, nsim.vec, function(x){
        library(ergm)
        library(network)
        load("fitted_ergm_imputed_network.RData")
        mynet.imputed <- as.network(imputed_network)
        simulate(imputed_network ~ edges+nodecov('respdeg'), constraints=~observed, nsim=1)
    }
                             )

    ## stop mpislurm-17434670.out
    stopCluster(cluster)
    mpi.exit()

    ## save
    save.image("sim_from_fitted_ergm_objects_in_parallel_ten.RData")
