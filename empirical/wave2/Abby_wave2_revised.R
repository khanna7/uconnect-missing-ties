
library(igraph)
library(ergm)
library(sna)
library(network)

wave2nodes <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_nodes.csv")
wave2edges <- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_resp_edges_only_edges.csv")
wave2.ig <- graph_from_data_frame(wave2edges[,c(1:2)], directed=FALSE, vertices=wave2nodes[,1])


wave1nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_nodes.csv")
wave1edges <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_resp_edges_only_edges.csv")
wave1.ig <- graph_from_data_frame(wave1edges[,c(1:2)], directed=FALSE, vertices=wave1nodes[,1])


respondentsmatch <- wave1nodes[wave1nodes$fb_full_name %in% wave2nodes$fb_full_name,]
respondentsmatch
length(respondentsmatch)
length(wave1nodes$fb_full_names)

wave1.fb.edges<- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_edges.csv")
  wave1.fb.nodes <- read.csv("../../../Facebook-from-Aditya/Facebook_Identified_4.15.2015_Wave1/fb_graph_nodes.csv")
 wave1.fb.ig <- graph_from_data_frame(wave1.fb.edges[,c(1:2)], directed=FALSE, vertices=wave1.fb.nodes[,1])

wave2.fb.edges<- read.csv("../../../Facebook-from-Aditya/Wave_2/Facebook/fb_graph_edges.csv")
  wave2.fb.nodes <- read.csv("../../../Wave_2/Facebook/fb_graph_nodes.csv")
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
   vnames <- wave1.wave2.all.ig %v% "vertex.names"
   resp.1 <- which(substr(vnames, 1, 4) == "1111")
   resp.2 <- which(substr(vnames, 1, 4) == "2222")
   vnames.nr <- vnames[-c(resp.1, resp.2)]
   vnames.nr <- paste0("NR.", vnames.nr)
   vnames[-c(resp.1, resp.2)] <- vnames.nr
   nonresp <- which(substr(vnames, 1, 3) == "NR.")

   vnames.ordered <- c(resp.1, resp.2, nonresp)

    permute.vertexIDs(wave1.wave2.all.ig,
                      vids=vnames.ordered)

   ## add na's to edges of non-participant nodes
   adj.mat.wave1.wave2.all.ig <- as.matrix.network(wave1.wave2.all.ig, "adjacency")
   dim(adj.mat.wave1.wave2.all.ig)
   v.names <- wave1.wave2.all.ig %v% "vertex.names"

   mat.to.impute <- adj.mat.wave1.wave2.all.ig
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

#create network with unobserved edges from wave1, wave 2

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

   ## Fit ergm with edges + nodecov('respdeg')
   ergm.imputed_network <- ergm(mat.to.impute ~ edges +
                                                  nodecov('respdeg')+
                                                  nodemix('respondent',
                                                          base=c(1,3)),
                                                  verbose=TRUE
                                )

   summary(ergm.imputed_network)

   ### wo nodemix
   ergm.imputed_network_wonodemix <- ergm(imputed_network ~ edges +
                                                  nodecov('respdeg'),
                                                  verbose=TRUE
                                )

   summary(ergm.imputed_network_wonodemix)


