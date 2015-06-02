## Analysis of Respondent-Only Network
### Aditya Khanna
### Put final product in html file for steve

library(ergm)
library(network)
library(ggplot2)

rm(list=ls())
load("R0_net_wattributes_identified.RData")

R0.net

 Network attributes:
  vertices = 302 
  directed = FALSE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 3273 
    missing edges= 0 
    non-missing edges= 3273 

 Vertex attribute names: 
    vertex.names 

 Edge attribute names not shown 

## Degree Distribution
R0.deg <- degreedist(R0.net)
pdf(file="r0_deg_dist.pdf")
plot(R0.deg, type="l", xlab="Degree", ylab="Frequency")
dev.off()

## See [here](https://github.com/khanna7/UConect_MissingTies/blob/master/r0_deg_dist.pdf)

