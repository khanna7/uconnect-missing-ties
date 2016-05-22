## convert imputed networks to igraphs

rm(list=ls())
library(intergraph)

net_list <- readRDS("../sim-from-ergm/imputed_10_nets_w_nodemix.RDS")

igraph_list <- lapply(net_list, asIgraph)

saveRDS(igraph_list, "ten_imputed_igraphs.RDS")
