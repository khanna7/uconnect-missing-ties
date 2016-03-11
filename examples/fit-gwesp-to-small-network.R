## mcmc diagnostics for gwesp model with small network

   rm(list=ls())
   library(network)
   library(ergm)

   ## data
   load("steve-simple-example-50v.RData")

   ## fit gwesp model
   ergm.imputed_network <- ergm(mynet ~ edges+nodecov('respdeg')+gwesp(alpha=1, fixed=TRUE),
                                        verbose = TRUE)

   pdf(file="mcmc-diag-50v-w-gwesp.pdf")
   mcmc.diagnostics(ergm.imputed_network)
   dev.off()
