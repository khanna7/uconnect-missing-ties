## find which (how many) respondents are selected between the control
## and imputed networks for each measure

rm(list=ls())

## libraries
   library(igraph)

   ## betweenness
   btwn_control_885nodes <- readRDS("control_885nodes_btwn_top300.RDS")
   btwn_imputed_885nodes <- readRDS("top300_btwn_dyad_ind.RDS")

   resp_btwn_control_885nodes <- btwn_control_885nodes[which(btwn_control_885nodes <= 298)]
   resp_btwn_imputed_885nodes <- btwn_imputed_885nodes[which(btwn_imputed_885nodes <= 298)]
   length(intersect(resp_btwn_control_885nodes, resp_btwn_imputed_885nodes))

   ## eigenvector centrality
   evcent_control_885nodes <- readRDS("control_885nodes_evcent_top300.RDS")
   evcent_imputed_885nodes <- readRDS("top300_evcent_dyad_ind.RDS")

   resp_evcent_control_885nodes <- evcent_control_885nodes[which(evcent_control_885nodes <= 298)]
   resp_evcent_imputed_885nodes <- evcent_imputed_885nodes[which(evcent_imputed_885nodes <= 298)]
   length(intersect(resp_evcent_control_885nodes, resp_evcent_imputed_885nodes))

   ## bridging
   bridging_control_885nodes <- readRDS("control_885nodes_bridging_top300.RDS")
   bridging_imputed_885nodes <- readRDS("top300.bridging_dyad_ind.RDS")

   resp_bridging_control_885nodes <- bridging_control_885nodes[which(bridging_control_885nodes <= 298)]
   resp_bridging_imputed_885nodes <- bridging_imputed_885nodes[which(bridging_imputed_885nodes <= 298)]
   length(intersect(resp_bridging_control_885nodes, resp_bridging_imputed_885nodes))

   ## key player
   kp_control_885nodes <- readRDS("control_885nodes_kp_set300.RDS")
   kp_imputed_885nodes <- readRDS("set300_kp_dyad_ind.RDS")

   resp_kp_control_885nodes <- kp_control_885nodes[which(kp_control_885nodes <= 298)]
   resp_kp_imputed_885nodes <- kp_imputed_885nodes[which(kp_imputed_885nodes <= 298)]
   length(intersect(resp_kp_control_885nodes, resp_kp_imputed_885nodes))
