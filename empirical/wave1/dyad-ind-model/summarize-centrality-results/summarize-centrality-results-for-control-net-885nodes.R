## summarize centrality results
  ## (betweenness, eigenvector centrality, keyplayer, bridging) for
  ## control network  (885 nodes, 29700 ties).

  rm(list=ls())

  ## libraries and data
  library(igraph)
  load("../../control-net/centrality_for_control_net_w_885nodes.RData")

  ## summarize results

     ## betweenness
     ordered.btwn_885nodes <- order(btwn_885nodes, decreasing=TRUE)
     top300.btwn_885nodes <- ordered.btwn_885nodes[1:300]
     length(which(as.numeric(top300.btwn_885nodes) > 298))

     saveRDS(as.numeric(top300.btwn_885nodes),
             file="control_885nodes_btwn_top300.RDS")

     ## eigenvector centrality
     ordered.evcent_885nodes <- order(evcent_885nodes$vector, decreasing=TRUE)
     top300.evcent_885nodes <- ordered.evcent_885nodes[1:300]
     length(which(as.numeric(top300.evcent_885nodes) > 298))
     saveRDS(as.numeric(top300.evcent_885nodes),
             file="control_885nodes_evcent_top300.RDS")

     ## keyplayer
     print(kp_885nodes_set300_0tol, full=T)
     length(which(as.numeric(kp_885nodes_set300) > 298))
     saveRDS(as.numeric(kp_885nodes_set300),
             file="control_885nodes_kp_set300.RDS")


     ## bridging
     ordered.bridging_885nodes <- order(bridging_885nodes, decreasing=TRUE)
     top300.bridging_885nodes <- ordered.bridging_885nodes[1:300]
     length(which(as.numeric(top300.bridging_885nodes) > 298))
     saveRDS(top300.bridging_885nodes, file="control_885nodes_bridging_top300.RDS")

 ## compute overlap between entries

    ## betweenness with other three
       length(intersect(top300.btwn_885nodes, top300.evcent_885nodes))
       length(intersect(top300.btwn_885nodes, kp_885nodes_set300))
       length(intersect(top300.btwn_885nodes, top300.bridging_885nodes))

    ## evcent with other two
       length(intersect(top300.evcent_885nodes, top300.bridging_885nodes))
       length(intersect(top300.evcent_885nodes, kp_885nodes_set300))

    ##  bridging with keyplayer
        length(intersect(kp_885nodes_set300, top300.bridging_885nodes))
