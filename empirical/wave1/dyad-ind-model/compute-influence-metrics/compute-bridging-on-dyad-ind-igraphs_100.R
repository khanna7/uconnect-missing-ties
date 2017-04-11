## compute eigenvector centrality scores on dyadic independent igraphs

   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)

   igraph_list <- readRDS("hundred_imputed_igraphs.RDS")

   ## compute betweenness centrality
   bridge_dyadic_ind_mod_base_13 <- lapply(igraph_list,
                                           function(x)
                                               bridging(x))

   ordered_bridge_dyadic_ind_mod_base_13 <-
       lapply(bridge_dyadic_ind_mod_base_13,
              function (x)
                  order(x, decreasing=TRUE)
              )

   top300_bridge_dyadic_ind_mod_base_13 <-
       lapply(ordered_bridge_dyadic_ind_mod_base_13,
                                                  function (x)
                                                      x[1:300]
                                                  )

   freq_top300_bridge_dyadic_ind_mod_base_13 <-
       table(unlist(top300_bridge_dyadic_ind_mod_base_13))

   sort_top300_bridge_dyadic_ind_mod_base_13 <-
       sort(freq_top300_bridge_dyadic_ind_mod_base_13,
            decreasing=TRUE)

   length(sort_top300_bridge_dyadic_ind_mod_base_13)

   length(which(names(sort_top300_bridge_dyadic_ind_mod_base_13) > 298))

   ## save 
   save.image(file="sort_top300_bridge_dyadic_ind_mod_base_13_100graphs.RData")
