rm(list=ls())

#install.packages('statnet.common')
#install.packages('ergm')
library(ergm) 
library(network)

imputed_matrix_w1 <- readRDS(file = "wave1.imputed.mat.rds")
imputed_network_w1 <- as.network.matrix(imputed_matrix_w1, "adjacency", directed = FALSE)

imputed_matrix_w2 <- readRDS(file = "wave2.imputed.mat.rds")
imputed_network_w2 <- as.network.matrix(imputed_matrix_w2, "adjacency", directed = FALSE)

n1 <- network.size(imputed_network_w1)
n2 <- network.size(imputed_network_w2)

#Process and fit ergm from wave 1

resp <- union(
  which(substr(imputed_network_w1 %v% "vertex.names",1,4) == "1111"),
  which(substr(imputed_network_w1 %v% "vertex.names",1,4) == "2222")
)

set.vertex.attribute(imputed_network_w1, "respondent", 0)
set.vertex.attribute(imputed_network_w1, "respondent", 1, v=resp)
nresp <- length(resp)

respdeg <- sapply(1:n1, function(x) sum(imputed_network_w1[x,1:nresp]))
imputed_network_w1 %v%"respdeg" <- respdeg


 ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network_w1 <- ergm(imputed_network_w1 ~ edges +
                                                  nodecov('respdeg')+
                                                  nodemix('respondent',
                                                          base=c(1,3)),
                                                  verbose=TRUE
                                )

   summary(ergm.imputed_network_w1)

   #Process and fit ergm from wave 2
   
   resp <- union(
     which(substr(imputed_network_w2 %v% "vertex.names",1,4) == "1111"),
     which(substr(imputed_network_w2 %v% "vertex.names",1,4) == "2222")
   )
   
   set.vertex.attribute(imputed_network_w2, "respondent", 0)
   set.vertex.attribute(imputed_network_w2, "respondent", 1, v=resp)
   nresp <- length(resp)
   
   respdeg <- sapply(1:n2, function(x) sum(imputed_network_w2[x,1:nresp]))
   imputed_network_w2 %v%"respdeg" <- respdeg
   
   #n <- network.size(wave1.wave2.all.net)
   
   ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network_w2 <- ergm(imputed_network_w2 ~ edges +
                                     nodecov('respdeg')+
                                     nodemix('respondent',
                                             base=c(1,3)),
                                   verbose=TRUE
   )
   
   summary(ergm.imputed_network_w2)
   
   ##
   ergm.imputed_network_w2_wonodemix <- ergm(imputed_network_w2 ~ edges +
                                     nodecov('respdeg'),
                                   verbose=TRUE
   )
   
   summary(ergm.imputed_network_w2_wonodemix)
   

   ## save
   #save.image("fitted_ergm_w1w2.RData")

