## find which (how many) respondents are selected between the control
## and imputed networks for each measure

rm(list=ls())
load("resp_pcas_after_cutoffs.RData")

   ## betweenness
   btwn_control_885nodes <- readRDS("../../control-net/control_885nodes_btwn_top300.RDS")

   resp_btwn_control_885nodes <- btwn_control_885nodes[which(btwn_control_885nodes <= 298)]
   
   resp_sel_in_control_imputed_btwn <- intersect(resp_btwn_control_885nodes, 
                                                 resp_btwn_after_cutoff)
   length(resp_sel_in_control_imputed_btwn)

   btwn_control_imputed <- intersect(btwn_control_885nodes, btwn_after_cutoff)
   length(btwn_control_imputed)
   
   ## eigenvector centrality
   evcent_control_885nodes <- readRDS("../../control-net/control_885nodes_evcent_top300.RDS")

   resp_evcent_control_885nodes <- evcent_control_885nodes[which(evcent_control_885nodes <= 298)]

   resp_sel_in_control_imputed_evcent <- intersect(resp_evcent_control_885nodes, 
                                              resp_evcent_after_cutoff)
   length(resp_sel_in_control_imputed_evcent)

   evcent_control_imputed <- intersect(evcent_control_885nodes, evcent_after_cutoff)
   length(evcent_control_imputed)

   ## bridging
   bridging_control_885nodes <- readRDS("../../control-net/control_885nodes_bridging_top300.RDS")

   resp_bridging_control_885nodes <- bridging_control_885nodes[which(bridging_control_885nodes <= 298)]

   resp_sel_in_control_imputed_bridging <- intersect(resp_bridging_control_885nodes, 
                                                resp_bridging_after_cutoff)
   length(resp_sel_in_control_imputed_bridging)

   bridging_control_imputed <- intersect(bridging_control_885nodes, bridging_after_cutoff)
   length(bridging_control_imputed)

   
   ## key player
   kp_control_885nodes <- readRDS("../../control-net/control_885nodes_kp_set300.RDS")

   resp_kp_control_885nodes <- kp_control_885nodes[which(kp_control_885nodes <= 298)]

   resp_sel_in_control_imputed_kp <- intersect(resp_kp_control_885nodes, 
                                           resp_kp_after_cutoff)
   length(resp_sel_in_control_imputed_kp)

   kp_control_imputed <- intersect(kp_control_885nodes, kp_after_cutoff)
   length(kp_control_imputed)

   ## overlaps in these pCA's on the control (i.e. control) and imputed networks
      ## btwn and all three
      length(intersect(btwn_control_imputed, evcent_control_imputed))
      length(intersect(btwn_control_imputed, kp_control_imputed))
      length(intersect(btwn_control_imputed, bridging_control_imputed))

      ## evcent and two
      length(intersect(evcent_control_imputed, bridging_control_imputed))
      length(intersect(evcent_control_imputed, kp_control_imputed))

      ## bridging and one
      length(intersect(bridging_control_imputed, kp_control_imputed))

   ## overlaps in these respondent pCA's on the control (i.e. control) and imputed networks
      ## btwn and all three
      length(intersect(resp_sel_in_control_imputed_btwn, resp_sel_in_control_imputed_evcent))
      length(intersect(resp_sel_in_control_imputed_btwn, resp_sel_in_control_imputed_kp))
      length(intersect(resp_sel_in_control_imputed_btwn, resp_sel_in_control_imputed_bridging))

      ## evcent and two
      length(intersect(resp_sel_in_control_imputed_evcent, resp_sel_in_control_imputed_bridging))
      length(intersect(resp_sel_in_control_imputed_evcent, resp_sel_in_control_imputed_kp))

      ## bridging and one
      length(intersect(resp_sel_in_control_imputed_bridging, resp_sel_in_control_imputed_kp))

      ## save object
      save.image("node-stability-witin-measure-btwn-control-and-imputations.RData")
