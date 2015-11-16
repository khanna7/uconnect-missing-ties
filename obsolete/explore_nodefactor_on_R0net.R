    ## libraries
   library(sna)
   library(ergm)

   ## data
   load("R0_net_deidentified.RData")

   ## obtain degree classes and compute mean degrees
   deg.R0.net <- degree(R0.net, cmode="indegree")
   summary(deg.R0.net)
   hist(deg.R0.net)

   length.of.class <- 7
   deg.R0.net.sort <- sort(deg.R0.net, decreasing=FALSE, index=TRUE)

   n <- network.size(R0.net)
   num.classes <- floor(n/length.of.class)
   remainder <- n - length.of.class*num.classes
   deg.R0.net.deg.class <- rep(1:num.classes, each=length.of.class)
   deg.R0.net.deg.class <- c(deg.R0.net.deg.class, rep(num.classes, remainder))
   deg.R0.net.deg.class[deg.R0.net.sort$ix] <- deg.R0.net.deg.class
   
   table(deg.R0.net.deg.class)
   R0.net %v% "deg.class.mean.deg" <- deg.R0.net.deg.class

 ## fit edges-only model
   edges.mod <- ergm(R0.net ~ edges)
   summary(edges.mod)
   edges.mod.gof.deg <- gof(edges.mod ~ degree, control=control.gof.formula(nsim=10), verbose=T)
   plot(edges.mod.gof.deg)
 
  ## fit edges+nodefactor model (steve's version)
   edges.nodef.mod <- ergm(R0.net ~ edges+nodefactor("deg.class.mean.deg", base=10))
   summary(edges.nodef.mod)
   edges.nodef.mod.gof.deg <- gof(edges.nodef.mod ~ degree, 
                                  control=control.gof.formula(nsim=30), verbose=T)
   plot(edges.nodef.mod.gof.deg)
   sim.ex <- simulate(edges.nodef.mod, nsim=1)
   sim.100 <- simulate(edges.nodef.mod, nsim=100)

   obj <- gof(edges.nodef.mod ~ espartners, 
              control=control.gof.formula(nsim=50), verbose=T)
   plot(obj)

   mod1 <- ergm(R0.net ~ edges+nodefactor("deg.class.mean.deg", base=10)+
                gwdsp(2, fixed=FALSE))

   ## compare number of triangles with model and R0.net
   c(summary(R0.net ~ edges), summary(sim.ex~edges))
   c(summary(R0.net ~ triangle), summary(sim.ex~triangle))
   c(summary(R0.net ~ kstar(2)), summary(sim.ex ~ kstar(2)))
   c(summary(R0.net ~ kstar(3)), summary(sim.ex ~ kstar(3)))
   c(summary(R0.net ~ kstar(4)), summary(sim.ex ~ kstar(4)))

  ## 
   load("../descriptives/w1_igraph_subsets.RData")
   library(igraph)
   library(intergraph)
   library(network)
   w1.messnet.net <- asNetwork(w1.messnet)
   w1.messnet.net
   network.edgecount(w1.messnet.net)*2/network.size(w1.messnet.net)
   w1.messnet.el <- as.edgelist(w1.messnet.net, directed=FALSE)
   dim(w1.messnet.el)

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
   w1.messnet.na.edges <- w1.messnet.net
   messnet.vertex.names <- w1.messnet.net%v%"vertex.names"
   for (i in 1:length(messnet.vertex.names)){
     if (substr(messnet.vertex.names[[i]], 1, 4) == "1111" || 
         substr(messnet.vertex.names[[i]], 1, 4) == "2222"){
       i = i+1
     } else {
       unobs.edges <- which(w1.messnet.net[i,] != 1)
       w1.messnet.na.edges[i,unobs.edges, add.edges=TRUE] <- NA    
     }
   }
   
