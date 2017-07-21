## create network with unobserved edges from wave 1
   rm(list=ls())

   ## libraries
   library(Rmpi)
   library(snow)
   library(methods)
   ######################################################################
   ### second try
   #####################################################################

   ## parallel parameters
   np <- 49
   np
   cluster <- makeMPIcluster(np)

   ## parallel test
   # Print the hostname for each cluster member

   sayhello <- function(){
       info <- Sys.info()[c("nodename", "machine")]
       paste("Hello from", info[1], "with CPU type", info[2])
   }

  message('RMPI nodes: ', mpi.comm.size())
  names <- clusterCall(cluster, sayhello)
  print(unlist(names))

  ######################################

  ## Fit model
   library(network)
   library(ergm)
   library(sna)

  ## data
   load(file="fitted_ergm_imputed_network_gwesp1_wnodemix-base13_maxit15-try2.RData")

  ## previous coefficients
  prev.fit <- coef(ergm.imputed_network)

  ## Continue ergm fit with edges + nodecov('respdeg')
  ergm.imputed_network <- ergm(imputed_network ~ edges +
                                   nodecov('respdeg')+
                                       gwesp(1, fixed=TRUE)+
                                           nodemix("respondent",
                                                   base=c(1,3)),
                               verbose=TRUE,
                               control=control.ergm(MCMLE.maxit=40,
                                    parallel=cluster,
                                    init=prev.fit)
                                )
                                            
   ## save
   save.image("fitted_ergm_imputed_network_gwesp1_base13_maxit15and15_parallel_multnodes.RData")
   #####################################################################


