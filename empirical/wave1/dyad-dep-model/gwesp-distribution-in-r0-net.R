rm(list=ls())

library(igraph)
library(intergraph)
library(ergm)

load("//project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/w1_resp_igraph.RData")

w1.resp.net <- asNetwork(w1.resp.ig)

gwesp_dist <- summary(w1.resp.net ~ esp(0:100))

pdf(file="esp_dist_ro_net.pdf")
plot(gwesp_dist, ylab="ESP frequency", main="Respondents Only")
dev.off()
