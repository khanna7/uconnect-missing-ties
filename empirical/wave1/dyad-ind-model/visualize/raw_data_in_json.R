  ## PLOT RAW NETWORK
  rm(list=ls())

  ## library
  library(network)
  library(intergraph)
  library(sna)
  library(jsonlite)

  ## data
  r0_net <- readRDS("../../control-net/r0-net-for-885-nodes.RDS")

  set.vertex.attribute(r0_net, "respondent", 1, v=1:298)
  set.vertex.attribute(r0_net, "respondent", 2, v=299:network.size(r0_net))

  nodes_0_idx <- c(1:network.size(r0_net))-1
  nodes_0_idx <- as.data.frame(nodes_0_idx)
  colnames(nodes_0_idx) <- "name"

  el_m <- as.matrix(as.edgelist(r0_net))
  el_m <- apply(el_m, c(1,2), function(x) x-1)
  el_m <- as.data.frame(el_m)
  colnames(el_m) <- c("source", "target")

  ## to json
  x <- c("{ \"nodes\":", toJSON(nodes_0_idx),
         ", \"links\":", toJSON(el_m), "}")

  write(x, file="raw_net.json")
