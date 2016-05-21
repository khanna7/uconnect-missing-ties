## compute eigenvector centrality scores on dyadic independent igraphs
   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)
   library(parallel)
   load("dyadic-ind-mod-base-13-igraphs.RData")

   ## check parallelization
   mc.cores = getOption("mc.cores", 2L)
   mc.cores

   ## compute betweenness centrality
   bridge_dyadic_ind_mod_base_13 <- mclapply(
       sim_results_igraph_indmod_base13[[1]],
       function(x)
           bridging(x),
       mc.cores=((47*15)-1)
   )
   ## nets <- sim_results_igraph_indmod_base13[[1]]

   ## bridg_scores <- bridging(nets)

   ## save 
   save(bridg_scores, file="sort_top300_bridge_dyadic_ind_mod_base_13_50igraphs_250cores.RData")
