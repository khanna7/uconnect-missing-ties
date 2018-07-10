
library(igraph)

wave2nodes <- read.csv("../Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])

 
wave1nodes <- read.csv("../Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])


respondentsmatch <- wave1nodes[wave1nodes$fb_full_name %in% wave2nodes$fb_full_name,]
respondentsmatch
length(respondentsmatch)
length(wave1nodes$fb_full_names)

wave1.fb.edges<- read.csv("../Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
  wave1.fb.nodes <- read.csv("../Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv") 
 wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges<- read.csv("../Wave_2/Facebook/fb_graph_edges.csv")
  wave2.fb.nodes <- read.csv("../Wave_2/Facebook/fb_graph_nodes.csv") 
 wave2.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave1.all.10 <- which(degree(wave1.fb.ig) >= length(wave1nodes$id)*.1)
wave1.fb.ig.10 <- induced_subgraph(wave1.fb.ig, v=wave1.all.10)

wave2.all.10 <- which(degree(wave2.fb.ig) >= length(wave2nodes$id)*.1)
wave2.fb.ig.10 <- induced_subgraph(wave2.fb.ig, v=wave2.all.10)

wave1.all.10
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


wave1.wave2.all.ig <- union(c(wave1.ig,wave2.ig,wave1.fb.ig.10, wave2.fb.ig.10), byname="auto")

 ## order vertex names to avoid trouble later
   vnames <- wave1.wave2.all.ig %v%"vertex.names"
   resp.1 <- which(substr(vnames, 1, 4) == "1111")
   resp.2 <- which(substr(vnames, 1, 4) == "2222")
   vnames.nr <- vnames[-c(resp.1, resp.2)] 
   vnames.nr <- paste0("NR.", vnames.nr)
   vnames[-c(resp.1, resp.2)] <- vnames.nr
   nonresp <- which(substr(vnames, 1, 3) == "NR.")

   vnames.ordered <- c(resp.1, resp.2, nonresp)
  
   permute.vertexIDs(w1.net.deg.greq.30,
                      vids=vnames.ordered)

   ## add na's to edges of non-participant nodes
   adj.mat.w1.net.fb.deg.greq.30 <- as.matrix.network(w1.net.deg.greq.30, "adjacency")
   dim(adj.mat.w1.net.fb.deg.greq.30)
   v.names <-   w1.net.deg.greq.30 %v% "vertex.names"

   mat.to.impute <- adj.mat.w1.net.fb.deg.greq.30
   row.names <- substr(rownames(mat.to.impute), 1, 4)
   col.names <- substr(rownames(mat.to.impute), 1, 4)

   for (i in 1:nrow(mat.to.impute)){
       for (j in 1:ncol(mat.to.impute)){
           if (row.names[i] != "1111" && row.names[i] != "2222"){
               if (col.names[j] != "1111" && col.names[j] != "2222"){
                   mat.to.impute[i,j] <- NA
               }
           }
       }
   }

   #save.image(file="imputed_matrix.RData")
