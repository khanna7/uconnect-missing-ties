## compute overlap between sets of 300 according to different measures
rm(list=ls())
  
   ## data
   btwn_top300 <- as.numeric(readRDS("btwn_top300_ids.RDS"))
   evcent_top300 <- as.numeric(readRDS("evcent_top300_ids.RDS"))
   bridging_top300 <- as.numeric(readRDS("bridging_top300_ids.RDS"))
   kp_top300 <- as.numeric(readRDS("set300_kp_dyad_ind.RDS"))

   ## overlaps
   length(intersect(btwn_top300, evcent_top300))
   length(intersect(btwn_top300, bridging_top300))
   length(intersect(btwn_top300, kp_top300))

   length(intersect(evcent_top300, bridging_top300))
   length(intersect(evcent_top300, kp_top300))

   length(intersect(bridging_top300, kp_top300))

   ## overlaps in respondents
      ## identify respondents
      resp_btwn_top300 <- btwn_top300[btwn_top300 <= 298]
      resp_evcent_top300 <- evcent_top300[evcent_top300 <= 298]
      resp_bridging_top300 <- bridging_top300[bridging_top300 <= 298]
      resp_kp_top300 <- kp_top300[kp_top300 <= 298]

      ## compute overlaps
      length(intersect(resp_btwn_top300, resp_evcent_top300))
      length(intersect(resp_btwn_top300, resp_bridging_top300))
      length(intersect(resp_btwn_top300, resp_kp_top300))

      length(intersect(resp_evcent_top300, resp_bridging_top300))
      length(intersect(resp_evcent_top300, resp_kp_top300))

      length(intersect(resp_bridging_top300, resp_kp_top300))

   