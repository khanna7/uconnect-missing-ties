## compute EDA characteristics between Waves 1 and 2.

rm(list=ls())
library(igraph)

## all respondent node graphs (not restricted only to common nodes)

  ## wave 1
  w1.fb.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_edges.csv")
  w1.fb.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_nodes.csv")
  w1.fb.ig <- graph_from_data_frame(w1.fb.edges.dat[,c(1:2)], directed=FALSE, vertices=w1.fb.nodes.dat[,1])

  ## wave 2
  w2.fb.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_edges.csv")
  w2.fb.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_nodes.csv")
  w2.fb.ig <- graph_from_data_frame(w2.fb.edges.dat[,c(1:2)], directed=FALSE, vertices=w2.fb.nodes.dat[,1])

## select nodes that have friendships with at least 10% of the respondents
   ## wave 1
   w1.10pc.id <- which(degree(w1.fb.ig) >= 30)
   w1.fb.ig.10pc <- induced_subgraph(w1.fb.ig, v=w1.10pc.id)

   ## wave 2
   w2.10pc.id <- which(degree(w2.fb.ig) >= 40)
   w2.fb.ig.10pc <- induced_subgraph(w2.fb.ig, v=w2.10pc.id)

## comparison
## num nodes 
   vcount(w1.fb.ig.10pc)
   vcount(w2.fb.ig.10pc)

## num edges
   ecount(w1.fb.ig.10pc)
   ecount(w2.fb.ig.10pc)

## degree
   deg_w1.fb.ig.10pc <- degree(w1.fb.ig.10pc)
   hist(deg_w1.fb.ig.10pc)

   deg_w2.fb.ig.10pc <- degree(w2.fb.ig.10pc)
   hist(deg_w2.fb.ig.10pc)

   par(mfrow=c(1,2))
   hist(deg_w1.fb.ig.10pc, breaks=seq(0, 800, 50), xlab="Wave 1")
   hist(deg_w2.fb.ig.10pc, breaks=seq(0, 800, 50), xlab="Wave 2")

## How many respondents in each?
   ## wave 1
   w1_resp_10pc <- union(which(substr(V(w1.fb.ig.10pc)$name, 1, 4) == "1111"),
                         which(substr(V(w1.fb.ig.10pc)$name, 1, 4) == "2222")
                         )
   length(w1_resp_10pc)

   w1_resp <- union(which(substr(V(w1.fb.ig)$name, 1, 4) == "1111"),
                          which(substr(V(w1.fb.ig)$name, 1, 4) == "2222")
                    )
   length(w1_resp)

   ## wave 2
   w2_resp_10pc <- union(which(substr(V(w2.fb.ig.10pc)$name, 1, 4) == "1111"),
                         which(substr(V(w2.fb.ig.10pc)$name, 1, 4) == "2222")
                         )
   length(w2_resp_10pc)

   w2_resp <- union(which(substr(V(w2.fb.ig)$name, 1, 4) == "1111"),
                    which(substr(V(w2.fb.ig)$name, 1, 4) == "2222")
                    )
   length(w2_resp)

## ergm-related measures
library(intergraph)
library(network)
library(ergm)
    
    w1.fb.net.10pc <- asNetwork(w1.fb.ig.10pc)
    w2.fb.net.10pc <- asNetwork(w2.fb.ig.10pc)

    ## gwesp
       w1_gwesp_sum <- summary(w1.fb.net.10pc ~ gwesp)
       w2_gwesp_sum <- summary(w2.fb.net.10pc ~ gwesp)     
       
       par(mfrow=c(2,1))
       barplot(w1_gwesp_sum, ylim=c(0, 1200))
       barplot(w2_gwesp_sum, ylim=c(0, 1200))

   ## gwesp
      summary(w1.fb.net.10pc ~ triangle)
      summary(w2.fb.net.10pc ~ triangle)     

## How many edges are R-R? How many are R-NR?
   ## wave 1
   w1_vnames <- w1.fb.net.10pc %v% "vertex.names"
   w1_rds_seeds <- which(substr(w1_vnames, 1, 4) == "1111")
   w1_rds_recruits <- which(substr(w1_vnames, 1, 4) == "2222")

   w1_10pc_el <- as.edgelist(w1.fb.net.10pc)
   w1_resp_resp_ties_id1 <- union(which(w1_10pc_el[,1] %in% w1_rds_seeds),
                                  which(w1_10pc_el[,1] %in% w1_rds_recruits))
   w1_resp_resp_ties_id2 <- union(which(w1_10pc_el[,2] %in% w1_rds_seeds),
                                  which(w1_10pc_el[,2] %in% w1_rds_recruits))
   w1_resp_resp_ties <- intersect(w1_resp_resp_ties_id1,
                                  w1_resp_resp_ties_id2)

   w1_resp_resp_el <- w1_10pc_el[w1_resp_resp_ties,]
   dim(w1_resp_resp_el)
   nrow(w1_10pc_el) - nrow(w1_resp_resp_el)
  
   ## wave 2
   w2_vnames <- w2.fb.net.10pc %v% "vertex.names"
   w2_rds_seeds <- which(substr(w2_vnames, 1, 4) == "1111")
   w2_rds_recruits <- which(substr(w2_vnames, 1, 4) == "2222")

   w2_10pc_el <- as.edgelist(w2.fb.net.10pc)
   w2_resp_resp_ties_id1 <- union(which(w2_10pc_el[,1] %in% w2_rds_seeds),
                                  which(w2_10pc_el[,1] %in% w2_rds_recruits))
   w2_resp_resp_ties_id2 <- union(which(w2_10pc_el[,2] %in% w2_rds_seeds),
                                  which(w2_10pc_el[,2] %in% w2_rds_recruits))
   w2_resp_resp_ties <- intersect(w2_resp_resp_ties_id1,
                                  w2_resp_resp_ties_id2)

   w2_resp_resp_el <- w2_10pc_el[w2_resp_resp_ties,]
   dim(w2_resp_resp_el)
   nrow(w2_10pc_el) - nrow(w2_resp_resp_el)

save.image(file="fb_net_comparison.RData")
