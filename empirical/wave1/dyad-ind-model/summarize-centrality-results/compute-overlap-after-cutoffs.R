rm(list=ls())

## libraries 
library(igraph)

## data
load("btwn_results.RData")
load("evcent_results.RData")
load("bridging_results.RData")
load("sort_top300_kp_dyadic_ind_mod_base_13_try1.RData")

## number of imputations
   nsim <- 100

## cutoffs for each metric (as proportion for number of imputations)
   btwn_cutoff <- 1*nsim
   evcent_cutoff <- 1*nsim
   bridging_cutoff <- 1*nsim
   kp_cutoff <- 0.37*nsim

## PCA frequency data
   btwn_results <- freq_top300_btwn_dyadic_ind_mod_base_13
   evcent_results <- freq_top300_evcent_dyadic_ind_mod_base_13
   bridging_results <- freq_top300_bridge_dyadic_ind_mod_base_13
   kp_results <- tab_kp_dyadic_ind_mod_base_13

## indentify nodes after cutoff
   btwn_after_cutoff <- as.numeric(names(which(btwn_results >= btwn_cutoff)))
   evcent_after_cutoff <- as.numeric(names(which(evcent_results >= evcent_cutoff)))
   bridging_after_cutoff <- as.numeric(names(which(bridging_results >= bridging_cutoff)))
   kp_after_cutoff <- as.numeric(names(which(kp_results >= kp_cutoff)))
   
   length(btwn_after_cutoff)
   length(evcent_after_cutoff)
   length(bridging_after_cutoff)
   length(kp_after_cutoff)

## overlap between these nodes
   btwn_evcent_cutoff <- length(intersect(btwn_after_cutoff, evcent_after_cutoff))
   btwn_bridging_cutoff <- length(intersect(btwn_after_cutoff, bridging_after_cutoff))
   btwn_kp_cutoff <- length(intersect(btwn_after_cutoff, kp_after_cutoff))
   
   evcent_bridging_cutoff <- length(intersect(evcent_after_cutoff, bridging_after_cutoff))
   evcent_kp_cutoff <- length(intersect(evcent_after_cutoff, kp_after_cutoff))
   
   bridging_kp_cutoff <- length(intersect(bridging_after_cutoff, kp_after_cutoff))

## save
   save.image("pcas_after_cutoffs.RData")
