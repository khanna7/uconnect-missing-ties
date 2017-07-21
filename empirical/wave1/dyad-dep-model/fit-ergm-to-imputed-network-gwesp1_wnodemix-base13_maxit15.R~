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
                                                  gwesp(1, fixed=TRUE)+
                                                  nodemix("respondent", base=3),
                                                  verbose=TRUE,
                                control=control.ergm(MCMLE.maxit=15)
                                )
                                            
   ## save
   save.image("fitted_ergm_imputed_network_gwesp1_wnodemix-base3_maxit15-try2.RData")
