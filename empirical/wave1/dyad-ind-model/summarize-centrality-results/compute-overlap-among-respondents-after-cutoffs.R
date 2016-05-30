rm(list=ls())

## data
load("pcas_after_cutoffs.RData")

nresp <- 298

## indentify respondents nodes after cutoff
   resp_btwn_after_cutoff <- btwn_after_cutoff[which(btwn_after_cutoff <= nresp)]
   resp_evcent_after_cutoff <- evcent_after_cutoff[which(evcent_after_cutoff <= nresp)]
   resp_bridging_after_cutoff <- bridging_after_cutoff[bridging_after_cutoff <= nresp]
   resp_kp_after_cutoff <- kp_after_cutoff[kp_after_cutoff <= nresp]
   
   length(resp_btwn_after_cutoff)
   length(resp_evcent_after_cutoff)
   length(resp_bridging_after_cutoff)
   length(resp_kp_after_cutoff)

## overlap between these nodes
   resp_btwn_evcent_cutoff <- length(intersect(resp_btwn_after_cutoff, resp_evcent_after_cutoff))
   resp_btwn_bridging_cutoff <- length(intersect(resp_btwn_after_cutoff, resp_bridging_after_cutoff))
   resp_btwn_kp_cutoff <- length(intersect(resp_btwn_after_cutoff, resp_kp_after_cutoff))
   
   resp_evcent_bridging_cutoff <- length(intersect(resp_evcent_after_cutoff, 
                                                   resp_bridging_after_cutoff))
   resp_evcent_kp_cutoff <- length(intersect(resp_evcent_after_cutoff, 
                                             resp_kp_after_cutoff))
   
   resp_bridging_kp_cutoff <- length(intersect(resp_bridging_after_cutoff, 
                                               resp_kp_after_cutoff))

## save
   save.image("resp_pcas_after_cutoffs.RData")
