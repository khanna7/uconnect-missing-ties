rm(list=ls())

library(intergraph)
library(network)
library(igraph)

load("/project/khanna7/Projects/UConnect/UConnect_FB/w1_w2_com_respondents_from_igraph/prep-awareness-use-and-fb-networks/pu-vs-ba-correct.RData")
load("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/descriptives/w2_igraph_subsets.RData")

w1_imp_net_list <- readRDS("../wave1/dyad-ind-model/sim-from-ergm/imputed_10_nets_w_nodemix.RDS")
w1_imputed_net <- w1_imp_net_list[[1]]

w1.com.resp.w.w2.data.ig
w1.com.resp.w.w2.data.net

w2.com.resp.ig
w2.com.resp.net

w2.full.net <- asNetwork(w2.ig)

saveRDS(w1.com.resp.r0, "w1_com_resp_r0.RDS")
saveRDS(w2.com.resp.ig, "w2_com_resp_r0.RDS")

## add nonrespondent set from wave 1 analysis
w1_nr_idx <- which(w1_imputed_net %v% "respondent" == 0)
w1_nr_names <- (w1_imputed_net %v% "vertex.names")[w1_nr_idx]

## compile list of names for wave 2 analysis, including resp and nonresp
w2_list_names <- c(w2.com.resp.net %v% "vertex.names", w1_nr_names)
head(w2_list_names)
vids <- which(V(w2.ig)$name %in% w2_list_names)

## extract facebook network with w2 resp + nonresp
w2_ig_r_nr <- igraph::induced_subgraph(w2.ig, vids=vids)
w2_net_r_nr <- asNetwork(w2_ig_r_nr)

## sort vertex names in w2_net_r_nr
vnames <- w2_net_r_nr %v% "vertex.names"

resp.1 <- which(substr(vnames, 1, 4) == "1111")
resp.2 <- which(substr(vnames, 1, 4) == "2222")
vid.nr <- (1:network.size(w2_net_r_nr))[-c(resp.1, resp.2)]

vnames.ordered <- c(resp.1, resp.2, vid.nr)
permute.vertexIDs(w2_net_r_nr, vids=vnames.ordered)
w2_net_r_nr %v% "vertex.names"

## denote missing edges as NA
w2_net_r_nr_obs <- as.matrix.network(w2.com.resp.net, "adjacency")

nresp <- length(c(resp.1, resp.2))
n <- length(vnames)

w2_r_nr_adj_mat <- matrix(0, nrow=n, ncol=n)
w2_r_nr_adj_mat[1:nresp, 1:nresp] <- w2_net_r_nr_obs
w2_r_nr_adj_mat[266:526, 266:526] <- NA

w2_r_nr_miss_edg <- as.network.matrix(w2_r_nr_adj_mat, directed=FALSE)
w2_r_nr_miss_edg 

## extract portion of ipmuted net with nodes of interest
vid <- which((w1_imputed_net %v% "vertex.names") %in% vnames) 
w1_imputed_net_w2.com <- get.inducedSubgraph(w1_imputed_net, v=vid)

bbb <- which((vnames) %in% 
         (w1_imputed_net_w2.com %v% "vertex.names"))

  aaa <- get.inducedSubgraph(w2_r_nr_miss_edg, v=bbb)
  saveRDS(aaa, file="w2_com_nod_net_w_miss_edg")
#aaa <- readRDS("w2_com_nod_net_w_miss_edg")

#zero.mat <- matrix(0, nrow=555, ncol=555)
#m.subset <- matrix(266:820, 266:820)
#ccc <- aaa
#ccc[266:820, 266:820] <- 0

#ccc_net <- as.network.matrix(ccc, directed=FALSE)

## fit stergm
library(tergm)
net_list <- list(w1_imputed_net_w2.com, aaa)

#net_list <- list(w1_imputed_net_w2.com, ccc_net)

miss_edg_stergm <- stergm(net_list, 
                          formation=~edges,
                          dissolution=~edges,
                          estimate="CMLE"
                          )

#save.image(file="big_stergm.RData")
save.image(file="big_stergm_260nodes.RData")