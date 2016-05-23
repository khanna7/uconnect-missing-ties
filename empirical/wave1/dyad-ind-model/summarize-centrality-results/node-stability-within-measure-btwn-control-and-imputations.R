## find which (how many) respondents are selected between the control
## and imputed networks for each measure

rm(list=ls())

   ## betweenness
   btwn_control_885nodes <- readRDS("../../control-net/control_885nodes_btwn_top300.RDS")
   btwn_imputed_885nodes <- readRDS("btwn_top300_ids.RDS")

   resp_btwn_control_885nodes <- btwn_control_885nodes[which(btwn_control_885nodes <= 298)]
   resp_btwn_imputed_885nodes <- btwn_imputed_885nodes[which(btwn_imputed_885nodes <= 298)]
   resp_sel_in_raw_imputed_btwn <- intersect(resp_btwn_control_885nodes, resp_btwn_imputed_885nodes)
   length(resp_sel_in_raw_imputed_btwn)

   btwn_control_imputed <- intersect(btwn_control_885nodes, btwn_imputed_885nodes)

   ## eigenvector centrality
   evcent_control_885nodes <- readRDS("../../control-net/control_885nodes_evcent_top300.RDS")
   evcent_imputed_885nodes <- readRDS("evcent_top300_ids.RDS")

   resp_evcent_control_885nodes <- evcent_control_885nodes[which(evcent_control_885nodes <= 298)]
   resp_evcent_imputed_885nodes <- evcent_imputed_885nodes[which(evcent_imputed_885nodes <= 298)]
   resp_sel_in_raw_imputed_evcent <- intersect(resp_evcent_control_885nodes, resp_evcent_imputed_885nodes)
   length(resp_sel_in_raw_imputed_evcent)

   evcent_control_imputed <- intersect(evcent_control_885nodes, evcent_imputed_885nodes)
   ## bridging
   bridging_control_885nodes <- readRDS("../../control-net/control_885nodes_bridging_top300.RDS")
   bridging_imputed_885nodes <- readRDS("bridging_top300_ids.RDS")

   resp_bridging_control_885nodes <- bridging_control_885nodes[which(bridging_control_885nodes <= 298)]
   resp_bridging_imputed_885nodes <- bridging_imputed_885nodes[which(bridging_imputed_885nodes <= 298)]
   resp_sel_in_raw_imputed_bridging <- intersect(resp_bridging_control_885nodes, resp_bridging_imputed_885nodes)
   length(resp_sel_in_raw_imputed_bridging)

   bridging_control_imputed <- intersect(bridging_control_885nodes, bridging_imputed_885nodes)
   
   ## key player
   kp_control_885nodes <- readRDS("../../control-net/control_885nodes_kp_set300.RDS")
   kp_imputed_885nodes <- readRDS("set300_kp_dyad_ind.RDS")

   resp_kp_control_885nodes <- kp_control_885nodes[which(kp_control_885nodes <= 298)]
   resp_kp_imputed_885nodes <- kp_imputed_885nodes[which(kp_imputed_885nodes <= 298)]
   resp_sel_in_raw_imputed_kp <- intersect(resp_kp_control_885nodes, resp_kp_imputed_885nodes)
   length(resp_sel_in_raw_imputed_kp)

   kp_control_imputed <- intersect(kp_control_885nodes, kp_imputed_885nodes)

   ## overlaps in these pCA's on the control (i.e. raw) and imputed networks
      ## btwn and all three
      length(intersect(btwn_control_imputed, evcent_control_imputed))
      length(intersect(btwn_control_imputed, kp_control_imputed))
      length(intersect(btwn_control_imputed, bridging_control_imputed))

      ## evcent and two
      length(intersect(evcent_control_imputed, bridging_control_imputed))
      length(intersect(evcent_control_imputed, kp_control_imputed))

      ## bridging and one
      length(intersect(bridging_control_imputed, kp_control_imputed))


   ## overlaps in these respondent pCA's on the control (i.e. raw) and imputed networks
      ## btwn and all three
      length(intersect(resp_sel_in_raw_imputed_btwn, resp_sel_in_raw_imputed_evcent))
      length(intersect(resp_sel_in_raw_imputed_btwn, resp_sel_in_raw_imputed_kp))
      length(intersect(resp_sel_in_raw_imputed_btwn, resp_sel_in_raw_imputed_bridging))

      ## evcent and two
      length(intersect(resp_sel_in_raw_imputed_evcent, resp_sel_in_raw_imputed_bridging))
      length(intersect(resp_sel_in_raw_imputed_evcent, resp_sel_in_raw_imputed_kp))

      ## bridging and one
      length(intersect(resp_sel_in_raw_imputed_bridging, resp_sel_in_raw_imputed_kp))
