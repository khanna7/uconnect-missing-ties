## compute eigenvector centrality scores on dyadic independent igraphs

   ## libraries and data
   rm(list=ls())
   library(igraph)

   igraph_list <- readRDS("ten_imputed_igraphs.RDS")

   ## compute eigenvector centrality
   evcent_dyadic_ind_mod_base_13 <- lapply(igraph_list,
                                           function(x)
                                               evcent(x)$vector)

   ordered_evcent_dyadic_ind_mod_base_13 <-
       lapply(evcent_dyadic_ind_mod_base_13,
              function (x)
                  order(x, decreasing=TRUE)
              )

   top300_evcent_dyadic_ind_mod_base_13 <-
       lapply(ordered_evcent_dyadic_ind_mod_base_13,
              function (x)
                  x[1:300]
              )

   freq_top300_evcent_dyadic_ind_mod_base_13 <-
       table(unlist(top300_evcent_dyadic_ind_mod_base_13))
   sort_top300_evcent_dyadic_ind_mod_base_13 <-
       sort(freq_top300_evcent_dyadic_ind_mod_base_13,
                                                     decreasing=TRUE)
   length(sort_top300_evcent_dyadic_ind_mod_base_13)

   names.in.num <- as.numeric(names(sort_top300_evcent_dyadic_ind_mod_base_13))
   length(which(names.in.num > 298))

   ## save 
   save.image(file="sort_top300_evcent_dyadic_ind_mod_base_13.RData")
   saveRDS(sort_top300_evcent_dyadic_ind_mod_base_13, file="top300_evcent_dyad_ind.RDS")   
