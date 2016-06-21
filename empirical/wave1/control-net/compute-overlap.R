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
     length(which(as.numeric(kp_885nodes_set300_0tol) > 298))
     saveRDS(as.numeric(kp_885nodes_set300_0tol),
             file="control_885nodes_kp_set300.RDS")


     ## bridging
     ordered.bridging_885nodes <- order(bridging_885nodes, decreasing=TRUE)
     top300.bridging_885nodes <- ordered.bridging_885nodes[1:300]
     length(which(as.numeric(top300.bridging_885nodes) > 298))
     saveRDS(top300.bridging_885nodes, file="control_885nodes_bridging_top300.RDS")

   ## COMPUTE OVERLAPS
   ## make sure names are of 'numeric' class
   btwn_885nodes <- as.numeric(readRDS("control_885nodes_btwn_top300.RDS"))
   evcent_885nodes <- as.numeric(readRDS("control_885nodes_evcent_top300.RDS"))
   bridging_885nodes <- as.numeric(readRDS("control_885nodes_bridging_top300.RDS"))
   kp_885nodes_set300 <- as.numeric(readRDS("control_885nodes_kp_set300.RDS"))

   ## identify respondents among PCA's
   resp_btwn_885nodes <- btwn_885nodes[btwn_885nodes <= 298]
   resp_evcent_885nodes <- evcent_885nodes[evcent_885nodes <= 298]
   resp_bridging_885nodes <- bridging_885nodes[bridging_885nodes <= 298]
   resp_kp_885nodes <- kp_885nodes_set300[kp_885nodes_set300 <= 298]
   
   ## compute overlaps
      ## PCA sets
      btwn_evcent <- length(intersect(btwn_885nodes, evcent_885nodes))
      btwn_bridging <- length(intersect(btwn_885nodes, bridging_885nodes))
      btwn_kp <- length(intersect(btwn_885nodes, kp_885nodes_set300))

      evcent_bridging <- length(intersect(evcent_885nodes, bridging_885nodes))
      evcent_kp <-  length(intersect(evcent_885nodes, kp_885nodes_set300))

      bridging_kp <- length(intersect(bridging_885nodes, kp_885nodes_set300))
   
      ## respondents in the PCA sets
      resp_btwn_evcent <- length(intersect(resp_btwn_885nodes,
                                            resp_evcent_885nodes))
      resp_btwn_bridging <- length(intersect(resp_btwn_885nodes,
                                             resp_bridging_885nodes))
      resp_btwn_kp <- length(intersect(resp_btwn_885nodes, resp_kp_885nodes))
   
      resp_evcent_bridging <- length(intersect(resp_evcent_885nodes,
                                               resp_bridging_885nodes))
      resp_evcent_kp <- length(intersect(resp_evcent_885nodes,
                                         resp_kp_885nodes))
   
      resp_bridging_kp <- length(intersect(resp_bridging_885nodes,
                                           resp_kp_885nodes))

   ## save object
      save.image(file="control-net-ovelap.RData")
