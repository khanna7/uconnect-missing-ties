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
   * Sex: females 3 973, males 5 696, missing 41
   * City: Chicago 4 834, missing 1 245

Non-participant metrics are [here](https://github.com/khanna7/UConect_MissingTies/blob/master/non-participant-metrics.md).

## A model for the complete case, respondent (or participant)-only network (R0).
   We created a dyadic-independent model for the R0 network. Code is [here](https://github.com/khanna7/UConect_MissingTies/blob/master/explore_nodefactor_on_R0net.R). To diagnose degeneracy, I compared the number of triangles in R0.net with a sample simulation from the model; R0.net contains 17 594 triangles, and a sample simulation contained 15 911 triangles. Similarly, the empirical R0.net contained 141K 2-stars, 2.7m 3-stars, and 4.4m 4-stars. The simulated network contained 151K 2-stars, 3.1m 3-stars, and 5.6m 4-stars. 
   
```r
## empirical network
> summary(R0.net ~ gwesp)
 esp#1  esp#2  esp#3  esp#4  esp#5  esp#6  esp#7  esp#8  esp#9 esp#10 esp#11 
   136    108    120    129    106    120    133    117    116    103    119 
esp#12 esp#13 esp#14 esp#15 esp#16 esp#17 esp#18 esp#19 esp#20 esp#21 esp#22 
    91     99     69    103     90     90     79     85     75     67     63 
esp#23 esp#24 esp#25 esp#26 esp#27 esp#28 esp#29 esp#30 
    68     73     60     62     53     44     53     44 
## simulated network
> summary(sim.ex ~ gwesp)
 esp#1  esp#2  esp#3  esp#4  esp#5  esp#6  esp#7  esp#8  esp#9 esp#10 esp#11 
   154    184    169    132    149    141    126    137    114    108    103 
esp#12 esp#13 esp#14 esp#15 esp#16 esp#17 esp#18 esp#19 esp#20 esp#21 esp#22 
    78     89     83     91     85     71     92     61     67     69     65 
esp#23 esp#24 esp#25 esp#26 esp#27 esp#28 esp#29 esp#30 
    54     63     64     51     50     48     43     44 
```
 
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
