## simulated 100 networks from a number of models with 'nodemix'
## summarize their statistics, with special attention to RR quadrant.

   rm(list=ls())
   library(network)

   igraph_list <- readRDS("../compute-influence-metrics/hundred_imputed_igraphs.RDS")
   nedges <- unlist(lapply(igraph_list, ecount))
   summary(nedges)
   summary(nedges) - 29700
   
  
