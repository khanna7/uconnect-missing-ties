## compare keyplaers with default and 0 tolerance

   rm(list=ls())
   load("centrality_for_control_net_w_885nodes.RData")

   ## default tolerance set
   kp_def_tol <- as.numeric(kp_885nodes_set300)

   ## zero tolerance set
   kp_0_tol <- as.numeric(kp_885nodes_set300_0tol)

   ## intersection
   length(intersect(kp_def_tol, kp_0_tol)) #108/300 same nodes were selected

   ## def-tol in 0-tol
   length(which(kp_def_tol %in% kp_0_tol))

   ## 0-tol in def-tol
   length(which( kp_0_tol %in% kp_def_tol))
