## create network with unobserved edges from wave 1

   rm(list=ls())

   ## libraries
   library(igraph)
   library(network)
   library(snow)
   library(Rmpi)

   ## data
   load("/home/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/w1_missing_tie_imputation_networks.RData")

   ## add na's to edges of non-participant nodes
   adj.mat.w1.net.fb.deg.greq.30 <- as.matrix.network(w1.net.deg.greq.30, "adjacency")
   dim(adj.mat.w1.net.fb.deg.greq.30)
   v.names <-   w1.net.deg.greq.30 %v% "vertex.names"

   mat.to.impute <- adj.mat.w1.net.fb.deg.greq.30
   row.names <- substr(rownames(mat.to.impute), 1, 4)
   col.names <- substr(rownames(mat.to.impute), 1, 4)

   for (i in 1:nrow(mat.to.impute)){
       for (j in 1:ncol(mat.to.impute)){
           if (row.names[i] != "1111" && row.names[i] != "2222"){
               if (col.names[j] != "1111" && col.names[j] != "2222"){
                   mat.to.impute[i,j] <- NA
               }
           }
       }
   }

   save.image(file="imputed_matrix.RData")

