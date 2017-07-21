## degree distribution of subnetwork of 298 respondents only

rm(list=ls())

library(intergraph)
library(igraph)

load(file="data_to_plot_nets.RData")

library(igraph)
obs_graph <- asIgraph(r0_net)
is.directed(obs_graph)

respondent_only_graph <- induced_subgraph(obs_graph, v=1:298)
is.directed(respondent_only_graph)

summary(degree(respondent_only_graph))
table(degree(respondent_only_graph))
hist(degree(respondent_only_graph))

save.image(file="resp-only-graph-stats.RData")
