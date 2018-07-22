
##############################
## networks of sPCAs
##############################
rm(list=ls())

## libraries
library(igraph)
load("pcas_after_cutoffs.RData")
load("../../../wave1/control-net/centrality_for_control_net_w_885nodes.RData")

## btwn
btwn_nonresp_after_cutoff <- btwn_after_cutoff[btwn_after_cutoff > 298]
summary(degree(w1.ig.deg.greq.30, v=btwn_nonresp_after_cutoff))

## evcent
evcent_nonresp_after_cutoff <- evcent_after_cutoff[evcent_after_cutoff > 298]
summary(degree(w1.ig.deg.greq.30, v=evcent_nonresp_after_cutoff))

##bridging
bridging_nonresp_after_cutoff <- bridging_after_cutoff[bridging_after_cutoff > 298]
summary(degree(w1.ig.deg.greq.30, v=bridging_nonresp_after_cutoff))

##kp
kp_nonresp_after_cutoff <- kp_after_cutoff[kp_after_cutoff > 298]
summary(degree(w1.ig.deg.greq.30, v=kp_nonresp_after_cutoff))

## Find intersection between sPCAs selected by evcent and kp
spca.evcent.kp.int <- intersect(evcent_after_cutoff, kp_after_cutoff)
spca.evcent.kp.union <- union(evcent_after_cutoff, kp_after_cutoff)

length(spca.evcent.kp.int)
length(spca.evcent.kp.union)

length(spca.evcent.kp.int[spca.evcent.kp.int > 298])
length(spca.evcent.kp.union[spca.evcent.kp.int > 298])
