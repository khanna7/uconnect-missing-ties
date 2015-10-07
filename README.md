# Modeling of Missing Ties

## Overview and Scope of Problem
  In the Wave 1 Facebook network, there are 182 998 nodes and 327 741 edges. We have complete edge information on 302 of    these nodes, for the remaining 182 998 - 302=182 696 nodes we only know about their edges with one of the study participants. 
  
There are various subsets of the Facebook Wave 1 network that we can use. 
 * Degree >= 2: 43 975 nodes, 188 718 edges. 301 study participants. 
 * Degree >= 3: 21 044 nodes, 142 856 edges. 301 study participants.
 * Degree >= 4: 13 075 nodes, 118 949 edges. 301 study participants
 * Messaging Network: 9 710 nodes, 12 493 edges. 298 study participants. 

That is, in the smallest meaningful subset, we have approximately 9710C2 - 298C2 ~ 47m unobserved edges! (Using the `network` package, we have a method to denote missing edges in networks, given at the bottom of this file.)

Obviously, adding 47m unobserved edges in the smallest meaningful network isn't efficient. Can we use properties of the nodes to discover which ones are likely to be neighbors?

   * Age: median 24.0, mean 25.3, NA's 4 444
   * Sex: fenales 3 973, males 5 696, missing 41
   * City: Chicago 4 834, missing 1 245

## A model for the complete case, respondent (or participant)-only network (R0).
   We created a dyadic-independent model for the R0 network. Code is [here](https://github.com/khanna7/UConect_MissingTies/blob/master/explore_nodefactor_on_R0net.R). 
   



 
 ```r
 # script to add "missing edges" in the messaging network
 
   library(igraph)
   library(intergraph)
   library(network)
   
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
 
 ```
