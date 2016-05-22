## compute eigenvector centrality scores on dyadic independent igraphs

   ## libraries and data
   rm(list=ls())
   library(igraph)
   library(influenceR)
   
   #load("dyadic-ind-mod-base-13-igraphs.RData")
   igraph_list <- readRDS("ten_imputed_igraphs.RDS")

   ## compute betweenness centrality
   btwn_dyadic_ind_mod_base_13 <- lapply(igraph_list,
                                           function(x)
                                               influenceR::betweenness(x))

   ordered_btwn_dyadic_ind_mod_base_13 <- lapply(btwn_dyadic_ind_mod_base_13,
                                                   function (x)
                                                       order(x, decreasing=TRUE)
                                                   )

   top300_btwn_dyadic_ind_mod_base_13 <- lapply(ordered_btwn_dyadic_ind_mod_base_13,
                                                  function (x)
                                                      x[1:300]
                                                  )

   freq_top300_btwn_dyadic_ind_mod_base_13 <- table(unlist(top300_btwn_dyadic_ind_mod_base_13))
   sort_top300_btwn_dyadic_ind_mod_base_13 <- sort(freq_top300_btwn_dyadic_ind_mod_base_13,
                                                     decreasing=TRUE)
   length(sort_top300_btwn_dyadic_ind_mod_base_13)

   names.in.num <- as.numeric(names(sort_top300_btwn_dyadic_ind_mod_base_13))
   length(which(names.in.num > 298))

   ## save 
   save.image(file="sort_top300_btwn_dyadic_ind_mod_base_13.RData")
   saveRDS(sort_top300_btwn_dyadic_ind_mod_base_13, file="top300_btwn_dyad_ind.RDS")
