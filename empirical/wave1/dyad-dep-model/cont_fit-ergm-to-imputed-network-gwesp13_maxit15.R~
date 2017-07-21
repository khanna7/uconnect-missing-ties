## create network with unobserved edges from wave 1
   rm(list=ls())

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ######################################################################
   ### first try
   #####################################################################
   ## data
   ## load(file="fitted_ergm_imputed_network_gwesp1_maxit30.RData")

   ## ## previous coefficients
   ## prev.fit <- coef(ergm.imputed_network)

   ## ## Continue ergm fit with edges + nodecov('respdeg')
   ## ergm.imputed_network <- ergm(imputed_network ~ edges +
   ##                                                nodecov('respdeg')+
   ##                                                gwesp(1, fixed=TRUE),
   ##                                                verbose=TRUE,
   ##                              control=control.ergm(MCMLE.maxit=10,
   ##                                                   init=prev.fit)
   ##                              )
                                            
   ## ## save
   ## save.image("fitted_ergm_imputed_network_gwesp1_maxit30_cont.RData")
   #####################################################################

   ######################################################################
   ### second try
   #####################################################################
   ## data
   load(file="fitted_ergm_imputed_network_gwesp1_maxit30_cont.RData")

   ## previous coefficients
   prev.fit <- coef(ergm.imputed_network)

   ## Continue ergm fit with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(imputed_network ~ edges +
                                                  nodecov('respdeg')+
                                                  gwesp(1, fixed=TRUE),
                                                  verbose=TRUE,
                                control=control.ergm(MCMLE.maxit=40,
                                                     init=prev.fit)
                                )
                                            
   ## save
   save.image("fitted_ergm_imputed_network_gwesp1_maxit30_cont2.RData")
   #####################################################################


