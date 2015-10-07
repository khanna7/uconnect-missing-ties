# Modeling of Missing Ties

## Overview and Scope of Problem
  In the Wave 1 Facebook network, there are 182 998 nodes and 327 741 edges. We have complete edge information on 302 of    these nodes, for the remaining 182 998 - 302=182 696 nodes we only know about their edges with one of the study participants. 
  
There are various subsets of the Facebook Wave 1 network that we can use. 
 * Degree >= 2: 43 975 nodes, 188 718 edges. 301 study participants. 
 * Degree >= 3: 21 044 nodes, 142 856 edges. 301 study participants.
 * Degree >= 4: 13 075 nodes, 118 949 edges. 301 study participants
 * Messaging Network: 9 710 nodes, 12 493 edges. 298 study participants. 

That is, in the smallest meaningful subset, we have approximately 9710C2 - 298C2 ~ 47m unobserved edges!

Using the network package, we have a method to denote missing edges in a 'network':
 
 ```r
 
 # method
 
 ```
