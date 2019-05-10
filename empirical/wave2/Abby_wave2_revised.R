rm(list=ls())

library(igraph)
library(network)
library(intergraph)

#Read in FB data
wave1.fb.edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
wave1.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")
wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_edges.csv")
wave2.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_nodes.csv")
wave2.fb.ig <- graph_from_data_frame(wave2.fb.edges[,c(1:2)], directed=FALSE, vertices=wave2.fb.nodes[,1])

#Find problem nodes
problemlist <- read.csv("Y:/Network Science Paper - Egonet Issue/fb-resp-w2-problem.csv")
problemids <- problemlist$su_id[problemlist$problem==1]

#Remove nodes with problem data
problemmatch_w1 <- which(wave1.fb.nodes$id %in% problemids)
problemmatch_w2 <- which(wave2.fb.nodes$id %in% problemids)

wave1.fb.ig_post <- delete_vertices(wave1.fb.ig, problemmatch_w1)
wave2.fb.ig_post <- delete_vertices(wave2.fb.ig, problemmatch_w2)

#Count friendships 
wave1edges <- ecount(wave1.fb.ig_post)
wave2edges <- ecount(wave2.fb.ig_post)

#count respondents and nonrespondents
wave1_resp <- union(which(substr(V(wave1.fb.ig_post)$name, 1, 4) == "1111"),
                    which(substr(V(wave1.fb.ig_post)$name, 1, 4) == "2222")
)

wave2_resp <- union(which(substr(V(wave2.fb.ig_post)$name, 1, 4) == "1111"),
                    which(substr(V(wave2.fb.ig_post)$name, 1, 4) == "2222")
)

wave1nonresp <- vcount(wave1.fb.ig_post) - length(wave1_resp)
wave2nonresp <- vcount(wave2.fb.ig_post) - length(wave2_resp)

#w1_non_common_nodes <- which(V(wave1.fb.ig_post)$name %in% not_w1_in_w2_id)
#w2_non_common_nodes <- which(V(wave2.fb.ig_post)$name %in% not_w2_in_w1_id)

#Read in just respondents to find common nodes
wave2nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])

wave1nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])

##Find common nodes
w1_in_w2_id <- which(!wave1nodes$id %in% wave2nodes$id)
w2_in_w1_id <- which(!wave2nodes$id %in% wave1nodes$id)

wave1.fb.ig.common <- delete_vertices(wave1.fb.ig_post, w1_in_w2_id)
wave2.fb.ig.common <- delete_vertices(wave2.fb.ig_post, w2_in_w1_id)

vcount(wave1.fb.ig.common)
vcount(wave2.fb.ig.common)

ecount(wave1.fb.ig.common)
ecount(wave2.fb.ig.common)

#count respondents, before boundary condition 
wave1_resp <- c(which(substr(V(wave1.fb.ig.common)$name, 1, 4) == "1111"),
                       which(substr(V(wave1.fb.ig.common)$name, 1, 4) == "2222")
)

wave2_resp <- c(which(substr(V(wave2.fb.ig.common)$name, 1, 4) == "1111"),
                    which(substr(V(wave2.fb.ig.common)$name, 1, 4) == "2222")
)

wave1_resp_ids <- V(wave1.fb.ig.common)$name[wave1_resp]
wave2_resp_ids <- V(wave2.fb.ig.common)$name[wave2_resp]

#count resp edges, before boundary condition 

edge_w1 <- as_edgelist(wave1.fb.ig.common)
length(which(edge_w1[,1] %in% wave1_resp_ids | edge_w1[,2] %in% wave1_resp_ids))
edge_w2 <- as_edgelist(wave2.fb.ig.common)
length(which(edge_w2[,1] %in% wave2_resp_ids | edge_w2[,2] %in% wave2_resp_ids))


#Boundary conditions for % inclusion (10% default), sensitivity analysis will move 
wave1.all.10 <- which(degree(wave1.fb.ig.common) >= length(wave1_resp)*.1)
wave1.fb.ig.10 <- induced_subgraph(wave1.fb.ig.common, v= wave1.all.10)

wave1.fb.ig.10.test <- induced_subgraph(wave1.fb.ig.common, v =wave1.all.10)
wave1.all.5 <- which(degree(wave1.fb.ig.common) >= length(wave1_resp)*.05)
wave1.fb.ig.5 <- induced_subgraph(wave1.fb.ig.common, v=wave1.all.5)

wave1.all.1 <- which(degree(wave1.fb.ig.common) >= length(wave1_resp)*.01)
wave1.fb.ig.1 <- induced_subgraph(wave1.fb.ig.common, v=wave1.all.1)

wave1.all.15 <- which(degree(wave1.fb.ig.common) >= length(wave1_resp)*.15)
wave1.fb.ig.15 <- induced_subgraph(wave1.fb.ig.common, v=wave1.all.15)

wave1.all.20 <- which(degree(wave1.fb.ig.common) >= length(wave1_resp)*.2)
wave1.fb.ig.20 <- induced_subgraph(wave1.fb.ig.common, v=wave1.all.20)

wave2.all.10 <- which(degree(wave2.fb.ig.common) >= length(wave2_resp)*.1)
wave2.fb.ig.10 <- induced_subgraph(wave2.fb.ig.common, v=wave2.all.10)

wave2.all.5 <- which(degree(wave2.fb.ig.common) >= length(wave2_resp)*.05)
wave2.fb.ig.5 <- induced_subgraph(wave2.fb.ig.common, v=wave2.all.5)

wave2.all.1 <- which(degree(wave2.fb.ig.common) >= length(wave2_resp)*.01)
wave2.fb.ig.1 <- induced_subgraph(wave2.fb.ig.common, v=wave2.all.1)

wave2.all.15 <- which(degree(wave2.fb.ig.common) >= length(wave2_resp)*.15)
wave2.fb.ig.15 <- induced_subgraph(wave2.fb.ig.common, v=wave2.all.15)

wave2.all.20 <- which(degree(wave2.fb.ig.common) >= length(wave2_resp)*.2)
wave2.fb.ig.20 <- induced_subgraph(wave2.fb.ig.common, v=wave2.all.20)

wave1_resps <- length(wave1_resp)
wave2_resps <- length(wave2_resp)

#Sensitivity 
wave1.10.nonresp <- vcount(wave1.fb.ig.10) - wave1_resps
wave1.5.nonresp <- vcount(wave1.fb.ig.5) - wave1_resps
wave1.1.nonresp <- vcount(wave1.fb.ig.1) - wave1_resps
wave1.15.nonresp <- vcount(wave1.fb.ig.15) - wave1_resps
wave1.20.nonresp <- vcount(wave1.fb.ig.20) - wave1_resps
  
wave2.10.nonresp <- vcount(wave2.fb.ig.10) - wave2_resps
wave2.5.nonresp <- vcount(wave2.fb.ig.5) - wave2_resps
wave2.1.nonresp <- vcount(wave2.fb.ig.1) - wave2_resps
wave2.15.nonresp <- vcount(wave2.fb.ig.15) - wave2_resps
wave2.20.nonresp <- vcount(wave2.fb.ig.20) - wave2_resps
  

## num nodes
   vcount(wave1.fb.ig.10)
   vcount(wave2.fb.ig.10)

## num edges
   ecount(wave1.fb.ig.10)
   ecount(wave2.fb.ig.10)

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


  #find respondent and nonrespondent edges after boundary applied
   
   edges1 <- as_edgelist(wave1.fb.ig.10)
   #number of respondent respondent edges
   rr_edges1 <- length(which((substr(edges1[,1], 1,4) == "1111" | substr(edges1[,1], 1,4) == "2222") & (substr(edges1[,2], 1,4) == "1111" | substr(edges1[,2], 1,4) == "2222")))
   rnr_edges1 <- length(edges1[,1]) - rr_edges1
   total_edges1 <- ecount(wave1.fb.ig.10)
   
   edges2 <- as_edgelist(wave2.fb.ig.10)
   #number of respondent respondent edges
   rr_edges2 <- length(which((substr(edges2[,1], 1,4) == "1111" | substr(edges2[,1], 1,4) == "2222") & (substr(edges2[,2], 1,4) == "1111" | substr(edges2[,2], 1,4) == "2222")))
   rnr_edges2 <- length(edges2[,1]) - rr_edges2
   total_edges2 <- ecount(wave2.fb.ig.10)
   
   #find average number of friendships by type
   avg_rr_edges1 <- rr_edges1/length(wave1_resp) 
   avg_rnr_edges1 <- rnr_edges1/length(wave1_resp)
   r_degree_total1 <- ecount(wave1.fb.ig.10)/length(wave1_resp)
   nr_degree1 <- rnr_edges1/(vcount(wave1.fb.ig.10) - length(wave1_resp))
   
   avg_rr_edges2 <- rr_edges2/length(wave2_resp) 
   avg_rnr_edges2 <- rnr_edges2/length(wave2_resp)
   r_degree_total2 <- ecount(wave2.fb.ig.10)/length(wave2_resp)
   nr_degree2 <- rnr_edges1/(vcount(wave2.fb.ig.10) - length(wave2_resp))
   
   
  

  wave1.fb.net.common <- asNetwork(wave1.fb.ig.10)
  wave2.fb.net.common <- asNetwork(wave2.fb.ig.10)

## order vertex names to avoid trouble later, wave 1
   vnames1 <- wave1.fb.net.common %v% "vertex.names"
   resp.1 <- which(substr(vnames1, 1, 4) == "1111")
   resp.2 <- which(substr(vnames1, 1, 4) == "2222")
   vnames1.nr <- vnames1[-c(resp.1, resp.2)]
   vnames1.nr <- paste0("NR.", vnames1.nr)
   vnames1[-c(resp.1, resp.2)] <- vnames1.nr
   nonresp <- which(substr(vnames1, 1, 3) == "NR.")

   vnames.ordered.1 <- c(resp.1, resp.2, nonresp)

   permute.vertexIDs(wave1.fb.net.common,
                      vids=vnames.ordered.1)
    
## order vertex names to avoid trouble later, wave 2
    vnames2 <- wave2.fb.net.common %v% "vertex.names"
    resp.1 <- which(substr(vnames2, 1, 4) == "1111")
    resp.2 <- which(substr(vnames2, 1, 4) == "2222")
    vnames2.nr <- vnames2[-c(resp.1, resp.2)]
    vnames2.nr <- paste0("NR.", vnames2.nr)
    vnames2[-c(resp.1, resp.2)] <- vnames2.nr
    nonresp <- which(substr(vnames2, 1, 3) == "NR.")
    
    vnames.ordered.2 <- c(resp.1, resp.2, nonresp)
    
    permute.vertexIDs(wave2.fb.net.common,
                      vids=vnames.ordered.2)
 
saveRDS(wave1.fb.net.common, file = "wave1.fb.net.common.rds")
saveRDS(wave2.fb.net.common, file = "wave2.fb.net.common.rds")

save.image(file = "all_graphs.RData") 
