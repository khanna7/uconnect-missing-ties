## create network with unobserved edges from wave 1
   rm(list=ls())

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ######################################################################
   ### second try
   #####################################################################
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
                                                     init=prev.fit)
                                )
                                            
   ## save
   save.image("fitted_ergm_imputed_network_gwesp1_base13_maxit15and15_.RData")
   #####################################################################


