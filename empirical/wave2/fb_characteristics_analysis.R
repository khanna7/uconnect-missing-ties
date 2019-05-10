#install.packages("igraph")
install.packages("network")
install.packages("intergraph")
library(igraph)
library(network)
library(intergraph)

wave2nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])


wave1nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])

problemlist <- read.csv("Y:/Network Science Paper - Egonet Issue/fb-resp-w2-problem.csv")
problemids <- problemlist$su_id[problemlist$problem==1]

wave1.fb.edges<- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
wave1.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")
wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges<- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_edges.csv")
wave2.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_nodes.csv")
wave2.fb.ig <- graph_from_data_frame(wave2.fb.edges[,c(1:2)], directed=FALSE, vertices=wave2.fb.nodes[,1])



wave1.fb.char <-  read.csv("X:/Facebook-from-Aditya/Wave_2/Facebook/fb_graph_nodes.csv")
wave2.fb.char <-  read.csv("X:/Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")

#load PCA's
load("w1w2PCAids.RData")

w1.resp <- union(which(substr(w1.top.300, 1, 4) == "1111"),
                 which(substr(w1.top.300, 1, 4) == "2222")
)
w1.non <- which(!seq(1,300) %in% w1.resp)

w2.resp <- union(which(substr(w2.top.300, 1, 4) == "1111"),
                 which(substr(w2.top.300, 1, 4) == "2222")
)
w2.non <- which(!seq(1,300) %in% w2.resp)


w1.pca.r <- which(wave1.fb.char$id %in% w1.top.300[w1.resp])
w1.pca.nr <- which(wave1.fb.char$id %in% w1.top.300[w1.non])
w2.pca.r <- which(wave2.fb.char$id %in% w2.top.300[w2.resp])
w2.pca.nr <- which(wave2.fb.char$id %in% w2.top.300[w2.non])


#pull out respondents, non respondents
length(which(wave1.fb.char$fb_city[w1.pca.r] == 'chicago'))
table(wave1.fb.char$fb_age[w1.pca.r])

#mean(as.numeric(wave1.fb.char$fb_age[w1.pca.r]))

length(which(wave1.fb.char$fb_city[w1.pca.nr] == 'chicago'))
table(wave1.fb.char$fb_age[w1.pca.nr])


length(which(wave2.fb.char$fb_city[w2.pca.r] == 'chicago'))
table(wave2.fb.char$fb_age[w2.pca.r])

length(which(wave2.fb.char$fb_city[w2.pca.nr] == 'chicago'))
table(wave2.fb.char$fb_age[w2.pca.nr])




wave1_resp_10 <- union(which(substr(V(wave1.fb.ig.10)$name, 1, 4) == "1111"),
                       which(substr(V(wave1.fb.ig.10)$name, 1, 4) == "2222")
)
vcount(wave1.fb.ig.10) - length(wave1_resp_10)
ecount(wave1.fb.ig.10)
