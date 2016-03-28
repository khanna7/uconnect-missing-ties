## simulated 100 networks from a number of models with 'nodemix'
## summarize their statistics, with special attention to RR quadrant.

   rm(list=ls())
   library(network)

   ## nodemix model with base=c(1,3)
   load("sim_from_fitted_ergm_objects_in_serial_hundred_dyad_ind_base_13.RData")
   sim_results_base13 <- sim_results
   nalter <- length(which(sim_results_base13[[1]] %v% "respondent" == 0))
   n.edges.base13 <- sapply(sim_results_base13, network.edgecount)
   summary(n.edges.base13)
   n.alter.alter.ties.base13 <- sapply(sim_results_base13, function(x) 
                                                    mixingmatrix(x, "respondent")$matrix[1,1])
                                        #[1,1] cell has ties between respondent=0 (i.e. alters)
   alter.alter.mean.deg.base13 <- (n.alter.alter.ties.base13)*2/nalter
   summary(alter.alter.mean.deg.base13)

   ## nodemix model with base=c(-2)
   load("sim_from_fitted_ergm_objects_in_serial_hundred_dyad_ind_base_neg2.RData")
   sim_results_baseneg2 <- sim_results
   nalter <- length(which(sim_results_baseneg2[[1]] %v% "respondent" == 0))
   n.edges.baseneg2 <- lapply(sim_results_baseneg2, network.edgecount)
   summary(unlist(n.edges.baseneg2))
   n.alter.alter.ties.baseneg2 <- lapply(sim_results_baseneg2, function(x) 
                                                    mixingmatrix(x, "respondent")$matrix[1,1])
                                        #[1,1] cell has ties between respondent=0 (i.e. alters)
   summary(unlist(n.alter.alter.ties.baseneg2))
   alter.alter.mean.deg.baseneg2 <- (unlist(n.alter.alter.ties.baseneg2)*2)/nalter
   summary(alter.alter.mean.deg.baseneg2)

   ## both solutions work, and produce almost identical results.
   ## we'll use base=c(1,3) instead of base=(-2) because we are more comfortable with the former.


