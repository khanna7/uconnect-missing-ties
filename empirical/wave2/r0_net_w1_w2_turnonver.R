## compute EDA characteristics between Waves 1 and 2.

rm(list=ls())
library(igraph)

## all respondent node graphs (estricted *only* to common nodes)

   ## wave 1
   w1.resp.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_resp_edges_only_edges.csv")
   w1.resp.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_resp_edges_only_nodes.csv")
   w1.resp.ig <- graph_from_data_frame(w1.resp.edges.dat[,c(1:2)], directed=FALSE, vertices=w1.resp.nodes.dat[,1])

   ## wave 2
   w2.resp.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_resp_edges_only_edges.csv")
   w2.resp.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_resp_edges_only_nodes.csv")
   w2.resp.ig <- graph_from_data_frame(w2.resp.edges.dat[,c(1:2)], directed=FALSE, vertices=w2.resp.nodes.dat[,1])

## combine edgelists
   w1_resp_el <- as_edgelist(w1.resp.ig)
   w2_resp_el <- as_edgelist(w2.resp.ig)
   el_rbind <- rbind(w1_resp_el, w2_resp_el)

## compare degree distributions
## degree
   deg_w1.resp <- degree(w1.resp.ig)
   hist(deg_w1.resp)

   deg_w2.resp <- degree(w2.resp.ig)
   hist(deg_w2.resp)

par(mfrow=c(1,2))
hist(deg_w1.resp, xlab="Degree", breaks=seq(0, 180, 20), main="Wave 1")
hist(deg_w2.resp, xlab="Degree", breaks=seq(0, 180, 20),  main="Wave 2")

## ergm-related measures
library(intergraph)
library(network)
library(ergm)

  w1.resp.net <- asNetwork(w1.resp.ig)
  w2.resp.net <- asNetwork(w2.resp.ig)

## gwesp
w1_resp_gwesp_sum <- summary(w1.resp.net ~ gwesp)
w2_resp_gwesp_sum <- summary(w2.resp.net ~ gwesp)     

par(mfrow=c(2,1))
barplot(w1_resp_gwesp_sum, ylim=c(0, 150))
barplot(w2_resp_gwesp_sum, ylim=c(0, 150))

## save file
save.image("r0_nets_comparison.RData")
