## compute eigenvector centrality scores on dyadic independent igraphs

   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)
   load("dyadic-ind-mod-base-13-igraphs.RData")

   ## compute betweenness centrality
   kp_dyadic_ind_mod_base_13 <- lapply(sim_results_igraph_indmod_base13,
                                           function(x)
                                               keyplayer(x, k=300))
   ## save 
   save.image(file="sort_top300_kp_dyadic_ind_mod_base_13.RData")
