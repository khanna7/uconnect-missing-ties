  ## summarize centrality results
  ## (betweenness, eigenvector centrality, keyplayer, bridging) for
  ## control network  (885 nodes, 29700 ties).

  rm(list=ls())

  ## libraries and data
  library(igraph)
  load("centrality_for_control_net_w_885nodes.RData")

  ## summarize results

     ## betweenness
     ordered.btwn_885nodes <- order(btwn_885nodes, decreasing=TRUE)
     top300.btwn_885nodes <- ordered.btwn_885nodes[1:300]
     length(which(top300.btwn_885nodes > 298))

     ## eigenvector centrality
     ordered.evcent_885nodes <- order(evcent_885nodes$vector, decreasing=TRUE)
     top300.evcent_885nodes <- ordered.evcent_885nodes[1:300]
     length(which(top300.evcent_885nodes > 298))

     ## keyplayer
     print(kp_885nodes_set300, full=T)
     length(which(kp_885nodes_set300 > 298))

     ## bridging
     ordered.bridging_885nodes <- order(bridging_885nodes, decreasing=TRUE)
     top300.bridging_885nodes <- ordered.bridging_885nodes[1:300]
     length(which(top300.bridging_885nodes > 298))

 ## compute overlap between entries

    ## betweenness with other three
       length(intersect(top300.btwn_885nodes, top300.evcent_885nodes))
       length(intersect(top300.btwn_885nodes, kp_885nodes_set300))
       length(intersect(top300.btwn_885nodes, top300.bridging_885nodes))

    ## evcent with other two
       length(intersect(top300.evcent_885nodes, kp_885nodes_set300))
       length(intersect(top300.evcent_885nodes, top300.bridging_885nodes))

    ## keyplayer with bridging
       length(intersect(kp_885nodes_set300, top300.bridging_885nodes))
