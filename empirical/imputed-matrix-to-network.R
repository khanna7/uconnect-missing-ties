## create network with unobserved edges from wave 1

   rm(list=ls())

   ## libraries
   library(network)

   ## data
   load(file="imputed_matrix.RData")

   ## convert to network form
   imputed_matrix <- mat.to.impute
   imputed_network <- as.network.matrix(imputed_matrix, "adjacency", directed=FALSE)

   ## save object
   save.image("imputed_network.RData")

