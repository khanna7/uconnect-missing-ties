  ## create Facebook networks that have unobserved edges which are marked as such

  rm(list=ls()) 
   
   ## data and libraries
   load("../descriptives/w1_igraph_subsets.RData")
   library(igraph)
   library(intergraph)
   library(network)

   ## Network properties
   w1.ig #full network
   length(which(substr(V(w1.ig)$name, 1, 4) == "2222"))+
       length(which(substr(V(w1.ig)$name, 1, 4) == "1111"))

   w1.ig.deg.greq.2 #degree >= 2
   length(which(substr(V(w1.ig.deg.greq.2)$name, 1, 4) == "2222"))+
       length(which(substr(V(w1.ig.deg.greq.2)$name, 1, 4) == "1111"))

   w1.ig.deg.greq.3 #degree >= 3
   length(which(substr(V(w1.ig.deg.greq.3)$name, 1, 4) == "2222"))+
       length(which(substr(V(w1.ig.deg.greq.3)$name, 1, 4) == "1111"))

   w1.ig.deg.greq.4 #degree >= 4
   length(which(substr(V(w1.ig.deg.greq.4)$name, 1, 4) == "2222"))+
       length(which(substr(V(w1.ig.deg.greq.4)$name, 1, 4) == "1111"))

   w1.messnet #messnet
   length(which(substr(V(w1.messnet)$name, 1, 4) == "2222"))+
       length(which(substr(V(w1.messnet)$name, 1, 4) == "1111"))

   ## messaging network
   w1.messnet.net <- asNetwork(w1.messnet)
   w1.messnet.net
   network.edgecount(w1.messnet.net)*2/network.size(w1.messnet.net)
   w1.messnet.el <- as.edgelist(w1.messnet.net, directed=FALSE)
   dim(w1.messnet.el)
   
   w1.messnet.na.edges <- w1.messnet.net
   messnet.vertex.names <- w1.messnet.net%v%"vertex.names"
   
   for (i in 1:length(messnet.vertex.names)){
     cat("Entering step ", i, "of ", length(messnet.vertex.names), "\n")
     
     if (substr(messnet.vertex.names[[i]], 1, 4) == "1111" || 
         substr(messnet.vertex.names[[i]], 1, 4) == "2222"){
       cat("This is a uConnect study participant", "\n")
       i = i+1
     } else {
       cat("This is not a uConnect study participant", "\n")
     for (j in 1:i){
        if(w1.messnet.net[i, j] != 1){
          cat("Adding edge", "\n")
        w1.messnet.na.edges[i,j, add.edges=TRUE] <- NA   
       }
      }
       
    }
     cat("Completing step ", i, "of ", length(messnet.vertex.names), "\n\n")  
   }
   
   save(w1.messnet.na.edges, file="w1_messnet_na_edges.RData")

   
   
#    ergm(w1.messnet.net ~ edges, constraints = ~observed)
#    g<-network.initialize(5)
#    g[,] #No edges present....
#    network.naedgecount(g)==0 #Edges not present are not "missing"!
#    #Now, add some missing edges
#    g[1,,add.edges=TRUE]<-NA #Establish that 1's ties are unknown
#    g[,] #Observe the missing elements
#    is.na(g) #Observe in network form
#    network.naedgecount(g)==4 #These elements do count!
#    network.edgecount(is.na(g)) #Same as above
#    
#    dim(w1.messnet.el)
#    w1.messnet.adj.m <- as.matrix.network.adjacency(w1.messnet.net)
#    dim(w1.messnet.adj.m)
#    w1.messnet.adj.na <- rep(NA, nrow=9710, ncol=9710)
#    w1.messnet.el.na[which(w1.messnet.adj.m == 1)] <- 1
#    which(w1.messnet.el.na == 1)
#    w1.messnet.net.na <- as.network(w1.messnet.adj.na, directed=FALSE, 
#                                    matrix.type="adjacency")
#    w1.messnet.net[100,, add.edges=TRUE] <- NA
   
   ## Designate edges belonging to non-study participants (except Facebook friends)
   ## as missing
 
