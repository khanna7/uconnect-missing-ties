## compute overlap among PCA's on control network

   rm(list=ls())
   library(igraph)

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
      length(intersect(btwn_885nodes, evcent_885nodes))
      length(intersect(btwn_885nodes, bridging_885nodes))
      length(intersect(btwn_885nodes, kp_885nodes_set300))

      length(intersect(evcent_885nodes, bridging_885nodes))
      length(intersect(evcent_885nodes, kp_885nodes_set300))

      length(intersect(bridging_885nodes, kp_885nodes_set300))
   
      ## respondents in the PCA sets
      length(intersect(resp_btwn_885nodes, resp_evcent_885nodes))
      length(intersect(resp_btwn_885nodes, resp_bridging_885nodes))
      length(intersect(resp_btwn_885nodes, resp_kp_885nodes))
   
      length(intersect(resp_evcent_885nodes, resp_bridging_885nodes))
      length(intersect(resp_evcent_885nodes, resp_kp_885nodes))
   
      length(intersect(resp_bridging_885nodes, resp_kp_885nodes))
