  ## create Facebook networks that have unobserved edges which are marked as such

  rm(list=ls()) 
   
   ## data and libraries
   load("../descriptives/w1_igraph_subsets.RData")
   library(igraph)
   library(intergraph)
   library(network)
   
   library(dplyr)
## nodal attributes (all Facebook data)
   resp.node.data <- read.csv("../fb_graph_nodes.csv",
                               header=TRUE)
   dim(resp.node.data)
   colnames(resp.node.data)

## nodal attributes (messnet data)
   rows.in.messnet <- which(resp.node.data$id %in% V(w1.messnet)$name)
   messnet.node.attrs <- resp.node.data[rows.in.messnet,]
   dim(messnet.node.attrs)   

## explore attributes of interest
   summary(messnet.node.attrs$fb_age) #age
   #summary(messnet.node.attrs$agecal) #agecalc
   summary(messnet.node.attrs$fb_sex) #sex
   summary(messnet.node.attrs$fb_city) #fb_city
   summary(messnet.node.attrs$higrade3) #higrade3

   age_sex_city <- select(messnet.node.attrs,
                          fb_age, fb_sex, fb_city)
   any(is.na(age_sex_city[4,]))
  

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
 
