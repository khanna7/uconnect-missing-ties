## compute eigenvector centrality scores on dyadic independent igraphs

   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)

   igraph_list <- readRDS("ten_imputed_igraphs.RDS")

   ## compute betweenness centrality
   kp_dyadic_ind_mod_base_13 <- lapply(igraph_list,
                                           function(x)
                                               keyplayer(x, k=300,
                                                         tol=0,
                                                         maxsec=24*3600))
   ## save 
   save.image(file="sort_top300_kp_dyadic_ind_mod_base_13.RData")
