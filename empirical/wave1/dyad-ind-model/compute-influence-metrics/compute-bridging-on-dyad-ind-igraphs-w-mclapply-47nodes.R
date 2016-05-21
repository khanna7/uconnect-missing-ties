## compute eigenvector centrality scores on dyadic independent igraphs
   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)

   load("dyadic-ind-mod-base-13-igraphs.RData")

   nets <- sim_results_igraph_indmod_base13[1:25]

   ## compute betweenness centrality
   scores <- lapply(
       nets,
       bridging
   )
   ## 

   ## bridg_scores <- bridging(nets)

   ## save 
   save(scores, file="sort_top300_bridge_dyadic_ind_mod_base_13_25igraphs_47nodes_tryagain.RData")
