
library(igraph)
library(network)
library(intergraph)

wave2nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])


wave1nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])


##Find common nodes
w1_in_w2_id <- which(wave1nodes$id %in% wave2nodes$id)
w2_in_w1_id <- which(wave2nodes$id %in% wave1nodes$id)

w1_com_resp_ig <- induced_subgraph(wave1.ig, vids=w1_in_w2_id)
w2_com_resp_ig <- induced_subgraph(wave2.ig, vids=w2_in_w1_id)
respondentsmatch <- wave1nodes[wave1nodes$fb_full_name %in% wave2nodes$fb_full_name,]
length(respondentsmatch)
length(wave1nodes$fb_full_names)

wave1.fb.edges<- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
  wave1.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")
 wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges<- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_edges.csv")
  wave2.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_nodes.csv")
 wave2.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave1.all.10 <- which(degree(wave1.fb.ig) >= length(wave1nodes$id)*.1)
wave1.fb.ig.10 <- induced_subgraph(wave1.fb.ig, v=wave1.all.10)

wave2.all.10 <- which(degree(wave2.fb.ig) >= length(wave2nodes$id)*.1)
wave2.fb.ig.10 <- induced_subgraph(wave2.fb.ig, v=wave2.all.10)

## num nodes
   vcount(wave1.fb.ig.10)
   vcount(wave2.fb.ig.10)

## num edges
   ecount(wave1.fb.ig.10)
   ecount(wave2.fb.ig.10)

## degree
   deg.wave1.fb.ig.10 <- degree(wave1.fb.ig.10)
   hist(deg.wave1.fb.ig.10)

   deg.wave2.fb.ig.10 <- degree(wave2.fb.ig.10)
hist(deg.wave2.fb.ig.10)

   par(mfrow=c(1,2))
 hist(deg.wave1.fb.ig.10, breaks=seq(0, 800, 50), xlab="Wave 1")
   hist(deg.wave2.fb.ig.10, breaks=seq(0, 800, 50), xlab="Wave 2")

## How many respondents in each?
   ## wave 1
   wave1_resp_10 <- union(which(substr(V(wave1.fb.ig.10)$name, 1, 4) == "1111"),
                         which(substr(V(wave1.fb.ig.10)$name, 1, 4) == "2222")
                         )
   length(wave1_resp_10)

   wave1_resp <- union(which(substr(V(wave1.fb.ig)$name, 1, 4) == "1111"),
                          which(substr(V(wave1.fb.ig)$name, 1, 4) == "2222")
                    )
   length(wave1_resp)

   ## wave 2
   wave2_resp_10 <- union(which(substr(V(wave2.fb.ig.10)$name, 1, 4) == "1111"),
                         which(substr(V(wave2.fb.ig.10)$name, 1, 4) == "2222")
                         )
   length(wave2_resp_10)

   wave2_resp <- union(which(substr(V(wave2.fb.ig)$name, 1, 4) == "1111"),
                    which(substr(V(wave2.fb.ig)$name, 1, 4) == "2222")
                    )
   length(wave2_resp)


wave1.wave2.all.ig <- igraph::union(wave1.ig,wave2.ig)
wave1.wave2.all.ig <- igraph::union(wave1.fb.ig.10,wave1.wave2.all.ig)
wave1.wave2.all.ig <- igraph::union(wave2.fb.ig.10, wave1.wave2.all.ig)

save(wave1.wave2.all.ig, file = "wave1.wave2.all.ig") 
wave1.wave2.all.net <- asNetwork(wave1.wave2.all.ig)

## order vertex names to avoid trouble later
   vnames <- wave1.wave2.all.net %v% "vertex.names"
   resp.1 <- which(substr(vnames, 1, 4) == "1111")
   resp.2 <- which(substr(vnames, 1, 4) == "2222")
   vnames.nr <- vnames[-c(resp.1, resp.2)]
   vnames.nr <- paste0("NR.", vnames.nr)
   vnames[-c(resp.1, resp.2)] <- vnames.nr
   nonresp <- which(substr(vnames, 1, 3) == "NR.")

   vnames.ordered <- c(resp.1, resp.2, nonresp)

    permute.vertexIDs(wave1.wave2.all.net,
                      vids=vnames.ordered)

 

#create network with unobserved edges from wave1, wave 2
mat.to.impute <- wave1.wave2.all.net
 n <- network.size(mat.to.impute)
   resp <- union(
                 which(substr(mat.to.impute %v% "vertex.names",1,4) == "1111"),
                 which(substr(mat.to.impute %v% "vertex.names",1,4) == "2222")
                 )

   set.vertex.attribute(mat.to.impute, "respondent", 0)
   set.vertex.attribute(mat.to.impute, "respondent", 1, v=resp)
   nresp <- length(resp)

   respdeg <- sapply(1:n, function(x) sum(mat.to.impute[x,1:nresp]))
   mat.to.impute %v%"respdeg" <- respdeg

saveRDS(wave1.wave2.all.net, file = "wave1.wave2.network.rds")



