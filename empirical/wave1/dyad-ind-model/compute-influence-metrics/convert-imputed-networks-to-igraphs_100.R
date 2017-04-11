## convert imputed networks to igraphs

rm(list=ls())
library(intergraph)

net_list <- readRDS("../sim-from-ergm/imputed_100_nets_w_nodemix.RDS")

igraph_list <- lapply(net_list, asIgraph)

saveRDS(igraph_list, "hundred_imputed_igraphs.RDS")
