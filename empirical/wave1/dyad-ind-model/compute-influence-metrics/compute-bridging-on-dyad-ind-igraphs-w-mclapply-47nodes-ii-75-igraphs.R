## compute eigenvector centrality scores on dyadic independent igraphs
   ## libraries and data
   rm(list=ls())
   library(influenceR)

   all.nets <- readRDS("dyadic-ind-imputed-igraphs-101.RDS")
   nets <- all.nets[26:50]

   ## compute betweenness centrality
   scores <- lapply(
       nets,
       bridging
   )
   ## 

   ## bridg_scores <- bridging(nets)

   ## save 
   saveRDS(scores, file="bridging_scores_ind_imp_igraphs_26to50.RDS")
