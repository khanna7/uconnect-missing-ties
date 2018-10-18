
#install.packages("igraph")
#install.packages("network")
install.packages("intergraph")
library(igraph)
library(network)
library(intergraph)
library(influenceR)

wave2nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])


wave1nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])

problemlist <- read.csv("Y:/Network Science Paper - Egonet Issue/fb-resp-w2-problem.csv")
problemids <- problemlist$su_id[problemlist$problem==1]

##Find common nodes
w1_in_w2_id <- which(wave1nodes$id %in% wave2nodes$id)
w2_in_w1_id <- which(wave2nodes$id %in% wave1nodes$id)


#Remove nodes with problem data
problemmatch_w1 <- which(wave1.fb.nodes$id %in% problemids)
problemmatch_w2 <- which(wave2.fb.nodes$id %in% problemids)

wave1.fb.ig_post <- delete_vertices(wave1.fb.ig, problemmatch_w1)
wave2.fb.ig_post <- delete_vertices(wave2.fb.ig, problemmatch_w2)


##### EV persistence ######

w1.ev <- evcent(wave1.ig) 
w1.ev.df <- as.data.frame(w1.ev)
w1.ev.sorted <- w1.ev.df[order(w1.ev.df$vector, decreasing = TRUE),]

w1.top.100 <- head(row.names(w1.ev.sorted), 100)
w1.top.50 <- head(row.names(w1.ev.sorted), 50)

w2.ev <- evcent(wave2.ig)
w2.ev.df <- as.data.frame(w2.ev)
w2.ev.sorted <- w2.ev.df[order(w2.ev.df$vector, decreasing = TRUE),]

w2.top.100 <- head(row.names(w2.ev.sorted), 100)
w2.top.50 <- head(row.names(w2.ev.sorted), 50)

length(which(w1.top.100 %in% w2.top.100))
length(which(w1.top.50 %in% w2.top.50))

ev.100.common.ids <- w1.top.100[which(w1.top.100 %in% w2.top.100)]
ev.50.common.ids <- w1.top.50[which(w1.top.50 %in% w2.top.50)]



#Keyplayer persistence 
w1.kp <- replicate(100, keyplayer(wave1.ig, 100, prob = 0, tol = 0))
w1.kp.100 <- V(wave1.ig)[w1.kp]$name
w1.kp.common <- sort(table(w1.kp.100), decreasing = TRUE)[1:100]

w1.kp.2 <- keyplayer(wave1.ig, 50, prob = 0, tol = 0)
w1.kp.50 <- V(wave1.ig)[w1.kp.2]$name

w2.kp <- replicate(100, keyplayer(wave2.ig, 100, prob = 0, tol = 0))
w2.kp.100 <- V(wave2.ig)[w2.kp]$name
w2.kp.common <- sort(table(w2.kp.100), decreasing = TRUE)[1:100]

w2.kp.2 <- keyplayer(wave2.ig, 50, prob = 0, tol = 0)
w2.kp.50 <- V(wave2.ig)[w2.kp.2]$name 

#Measure persistence for top 100, top 50
kp.100.common <- length(which(rownames(w1.kp.common) %in% rownames(w2.kp.common)))
kp.100.common.ids <- w2.kp.100[which(rownames(w2.kp.common) %in% rownames(w1.kp.common))] 

kp.50.common <- length(which(w1.kp.50 %in% w2.kp.100))
kp.50.common.ids <- w2.kp.50[which(w2.kp.50 %in% w1.kp.50)]

#Persistence for replication
kp.100.common.rep <- length(which( rownames(w1.kp.common) %in% rownames(w2.kp.common)))

#### Keyplayer, EV overlap
length(which(w1.top.100 %in% rownames(w1.kp.common)))
length(which(w2.top.100 %in% rownames(w2.kp.common)))



#######

not_w1_in_w2_id <- wave1nodes$id[!wave1nodes$id %in% wave2nodes$id]
not_w2_in_w1_id <- wave2nodes$id[!wave2nodes$id %in% wave1nodes$id]

w1_com_resp_ig <- induced_subgraph(wave1.ig, vids=w1_in_w2_id)
w2_com_resp_ig <- induced_subgraph(wave2.ig, vids=w2_in_w1_id)

wave1.fb.edges<- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
wave1.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")
wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges<- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_edges.csv")
wave2.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_nodes.csv")
wave2.fb.ig <- graph_from_data_frame(wave2.fb.edges[,c(1:2)], directed=FALSE, vertices=wave2.fb.nodes[,1])


## ev persisted ids in kp persisted ids
length(which(ev.100.common.ids %in% kp.100.common.ids))


### Keyplayer analysis ####
hist(table(w1.kp.100))
hist(table(w2.kp.100))

overlap.mat.w1 <- matrix(ncol= 100, nrow= 100)
for (x in 1:100){
  for (y in 1:100){
    overlap.mat.w1[x,y] <- length(which(w1.kp[,x] %in% w1.kp[,y]))
  }
}

overlap.mat.w2 <- matrix(ncol= 100, nrow= 100)
for (x in 1:100){
  for (y in 1:100){
    overlap.mat.w2[x,y] <- length(which(w2.kp[,x] %in% w2.kp[,y]))
  }
}


#overlap_mat <- lapply(1:100, function(x) lapply(1:100, function(y) length(which(w1.kp[,x] %in% w1.kp[,y]))))

save(overlap.mat.w1, overlap.mat.w2, file = "Y:/Aditya-CFAR-pilot/keyplayer_frequency_matrices.RData")