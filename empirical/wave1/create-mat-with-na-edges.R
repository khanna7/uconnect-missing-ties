## create network with unobserved edges from wave 1
## Code for creating igraph with nonrespondents of degree >= 30 is in: `/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/ergm-imputation-ronet-w1.R`
## Code gor creating igraph with degree cutoffs 1, 2, 3, and 4 is in `csv_to_igraph_degree_subsets.R`

   rm(list=ls())

   ## libraries
   library(igraph)
   library(network)
   library(snow)
   #library(Rmpi)

   ## data
   #load("/home/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/w1_missing_tie_imputation_networks.RData")
   load("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/w1_missing_tie_imputation_networks.RData")

   ## order vertex names to avoid trouble later
   vnames <- w1.net.deg.greq.30%v%"vertex.names"
   resp.1 <- which(substr(vnames, 1, 4) == "1111")
   resp.2 <- which(substr(vnames, 1, 4) == "2222")
   vnames.nr <- vnames[-c(resp.1, resp.2)] 
   vnames.nr <- paste0("NR.", vnames.nr)
   vnames[-c(resp.1, resp.2)] <- vnames.nr
   nonresp <- which(substr(vnames, 1, 3) == "NR.")

   vnames.ordered <- c(resp.1, resp.2, nonresp)
  
    permute.vertexIDs(w1.net.deg.greq.30,
                      vids=vnames.ordered)

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

