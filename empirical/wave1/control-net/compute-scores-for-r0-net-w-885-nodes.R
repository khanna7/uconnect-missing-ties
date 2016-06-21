## compute scores for 885 nodes to serve as "control" case

   rm(list=ls())
   library(intergraph)
   library(igraph)
   library(influenceR)

   ## oiginal network in igraph format
   w1.net.deg.greq.30 <- readRDS("r0-net-for-885-nodes.RDS")

   ## convert to igraph format
   w1.ig.deg.greq.30 <- asIgraph(w1.net.deg.greq.30)

   ## compute scores
   btwn_885nodes <- influenceR::betweenness(w1.ig.deg.greq.30)
   evcent_885nodes <- evcent(w1.ig.deg.greq.30)
   bridging_885nodes <- bridging(w1.ig.deg.greq.30)

   ptm <- proc.time()
   kp_885nodes_set300 <- keyplayer(w1.ig.deg.greq.30, k=300)
   proc.time() - ptm

   ptm <- proc.time()
   kp_885nodes_set300_0tol <- keyplayer(w1.ig.deg.greq.30, k=300,
                                        tol=0,
                                        maxsec=24*3600)
   proc.time() - ptm

   ## save
   save.image(file="centrality_for_control_net_w_885nodes.RData")


   
