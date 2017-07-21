## degree distribution of subnetwork of 298 respondents only

rm(list=ls())

library(intergraph)
library(igraph)
library(influenceR)

load(file="data_to_plot_nets.RData")

library(igraph)
obs_graph <- asIgraph(r0_net)
is.directed(obs_graph)

respondent_only_graph <- induced_subgraph(obs_graph, v=1:298)
is.directed(respondent_only_graph)

deg_resp_only <- degree(respondent_only_graph)
summary(deg_resp_only)
table(deg_resp_only)
hist(deg_resp_only)

r0_evcent <- eigen_centrality(respondent_only_graph)
r0_kp <- keyplayer(respondent_only_graph, k=50, tol=0)

r0_evcent_vec <- r0_evcent$vector
evcent_ord_id <- sort.int(r0_evcent_vec, index.return=TRUE)$ix
evcent_top50_id <- tail(evcent_ord_id, 50) #above is sorted in ascending order

summary(deg_resp_only[evcent_top50_id])
summary(deg_resp_only[r0_kp])

save.image(file="resp-only-graph-stats.RData")
