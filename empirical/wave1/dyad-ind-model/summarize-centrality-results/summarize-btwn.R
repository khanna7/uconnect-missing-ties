## summarize betweenness and evcent

   rm(list=ls())
   
   ##  betweenness
   load("../compute-influence-metrics/sort_top300_btwn_dyadic_ind_mod_base_13.RData")

   ## frequency
   freq_top300_btwn_dyadic_ind_mod_base_13
   
   ## names
   length(names.in.num)
   resp <- which(names.in.num > 298) #num respondents
   length(resp)
