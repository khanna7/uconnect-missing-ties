## fit ergm to network with missing edges denoted
rm(list=ls())

## libraries
library(network)
library(ergm)
library(sna)

## data
imputed_network <- readRDS("w2.fb.net.10pc.wna.RDS")

## add respdeg attribute
n <- network.size(imputed_network)

resp <- union(
  which(substr(imputed_network %v% "vertex.names",1,4) == "1111"),
  which(substr(imputed_network %v% "vertex.names",1,4) == "2222")
)

network::set.vertex.attribute(imputed_network, "respondent", 0)
network::set.vertex.attribute(imputed_network, "respondent", 1, v=resp)
nresp <- length(resp)

respdeg <- sapply(1:n, function(x) sum(imputed_network[x,1:nresp]))
imputed_network%v%"respdeg" <- respdeg

## Fit ergm with edges + nodecov('respdeg')
ergm.imputed_network <- ergm(imputed_network ~ edges +
                               nodecov('respdeg')+
                               nodemix('respondent', base=c(1,3)),
                             verbose=TRUE
)

save.image("fitted_ergm.RData")
