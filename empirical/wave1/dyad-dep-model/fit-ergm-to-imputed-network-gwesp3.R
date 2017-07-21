## create network with unobserved edges from wave 1
   rm(list=ls())

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="gwesp-setup.RData")

   ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(imputed_network ~ edges +
                                                  nodecov('respdeg')+
                                                  gwesp(3, fixed=TRUE),
                                                  verbose=TRUE)
                                            
   ## save
   save.image("fitted_ergm_imputed_network_gwesp3.RData")
