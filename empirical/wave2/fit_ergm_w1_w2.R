

library(ergm) 


 ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(mat.to.impute ~ edges +
                                                  nodecov('respdeg')+
                                                  nodemix('respondent',
                                                          base=c(1,3)),
                                                  verbose=TRUE
                                )

   summary(ergm.imputed_network)

   ### wo nodemix
   ergm.imputed_network_wonodemix <- ergm(imputed_network ~ edges +
                                                  nodecov('respdeg'),
                                                  verbose=TRUE
                                )

   summary(ergm.imputed_network_wonodemix)



