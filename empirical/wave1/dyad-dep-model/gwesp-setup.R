## create network with unobserved edges from wave 1
   rm(list=ls())

   ## libraries
   library(network)
   library(ergm)
   library(sna)

   ## data
   load(file="imputed_network.RData")

   ## Add 'respdeg' attribute
      ##deg.imputed_network <- degree(imputed_network)
      ##imputed_network%v%"respdeg" <- deg.imputed_network

   n <- network.size(imputed_network)
   resp <- union(
                 which(substr(imputed_network %v% "vertex.names",1,4) == "1111"),
                 which(substr(imputed_network %v% "vertex.names",1,4) == "2222")
                 )

   set.vertex.attribute(imputed_network, "respondent", 0)
   set.vertex.attribute(imputed_network, "respondent", 1, v=resp)
   nresp <- length(resp)

   respdeg <- sapply(1:n, function(x) sum(imputed_network[x,1:nresp]))
   imputed_network%v%"respdeg" <- respdeg

   ## save
   save.image("gwesp-setup.RData")
