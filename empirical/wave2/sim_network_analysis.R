

library(network)
library(intergraph)

load("sim_from_fitted_ergm_w1w2.RData")

length(sim_results_w1[[1]] %v% "vertex.names")
length(sim_results_w2[[1]] %v% "vertex.names")

resp_list <- which(sim_results_w1[[1]] %v% "respondent" == 1)
resp_list_w2 <- which(sim_results_w2[[1]] %v% "respondent" == 1)

edge_list_w1 <- lapply(1:100, function(x) as.edgelist(sim_results_w1[[x]]))
edge_list_w2 <- lapply(1:100, function(x) as.edgelist(sim_results_w2[[x]]))

#w1 792 nodes, 235 respondents, 557 nonrespondents, w2 1276 nodes, 318 respondents, 958 nonrespondents
resp_edges <- lapply(1:235, function(x) length(which(sim_results_w1[[1]][x,][1:235] ==1)))
sum(unlist(resp_edges))/2

resp_edges_w2 <- lapply(1:318, function(x) length(which(sim_results_w2[[1]][x,][1:318] ==1)))
sum(unlist(resp_edges_w2))/2

resp_nr_edges <- lapply(1:235, function(x) length(which(sim_results_w1[[1]][x,][235:792] == 1)))
sum(unlist(resp_nr_edges))

res_nr_edges_w2 <- lapply(1:318, function(x) length(which(sim_results_w2[[1]][x,][318:276] ==1)))
sum(unlist(res_nr_edges_w2))

#Analyze imputed edges over 100 runs   
nr_imputed_edges <- lapply(1:100, function(y) lapply(236:792, function(x) length(which(sim_results_w1[[y]][x,][236:792]==1))))
nr_imputed_edges <- lapply(1:length(nr_imputed_edges), function(x) sum(unlist(nr_imputed_edges[[x]]))/2)
nr_imputed_edges_avg <- mean(unlist(nr_imputed_edges))
nr_imputed_edges_sd <- sd(unlist(nr_imputed_edges))

nr_imputed_edges_w2 <- lapply(1:100, function(y) lapply(319:1276, function(x) length(which(sim_results_w2[[y]][x,][319:1276] == 1))))
nr_imputed_edges_w2 <- lapply(1:length(nr_imputed_edges_w2), function(x) sum(unlist(nr_imputed_edges_w2[[x]]))/2)
nr_imputed_edges_w2_avg <- mean(unlist(nr_imputed_edges_w2))
nr_imputed_edges_w2_sd <- sd(unlist(nr_imputed_edges_w2))

