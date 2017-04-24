## Selection of different nonrespondent sets by degree: investigate sizes

   ## selection of different nonrespo sets by degree
   rm(list=ls())
   library(igraph)
   
   load("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/descriptives/w1_missing_tie_imputation_networks.RData")

   ## check degree-based subsets in memory
   w1.ig #full network
   w1.messnet #messaging network
   w1.ig.deg.greq.2 #deg >= 2
   w1.ig.deg.greq.3 #deg >= 3
   w1.ig.deg.greq.4 #deg >= 4
   w1.ig.deg.greq.30 #same as NR's connected to 10% of respondents
   
   ## new subsets: NR's connected to 5% of respondents, 20% of respondents
   w1.ig.deg.greq.1pc <- induced.subgraph(w1.ig, V(w1.ig)[degree >= 300*1/100])
   w1.ig.deg.greq.5pc <- induced.subgraph(w1.ig, V(w1.ig)[degree >= 300*5/100])
   w1.ig.deg.greq.10pc <- induced.subgraph(w1.ig, V(w1.ig)[degree >= 300*10/100])
   w1.ig.deg.greq.20pc <- induced.subgraph(w1.ig, V(w1.ig)[degree >= 300*20/100])

   ## save
   save.image(file="nr_deg_based_cutoffs.RData")