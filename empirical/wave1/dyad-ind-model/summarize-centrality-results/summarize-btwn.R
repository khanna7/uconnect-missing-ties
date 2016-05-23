## summarize betweenness and evcent

   rm(list=ls())
   
   ##  betweenness
   load("../compute-influence-metrics/sort_top300_btwn_dyadic_ind_mod_base_13.RData")

   ## frequency
   freq_top300_btwn_dyadic_ind_mod_base_13

   ## names
   length(names.in.num)
   resp <- which(names.in.num <= 298) #num respondents
   length(resp)

   ## compute mean and variance of numebr of occurences
   mat_freq_top300_btwn_dyadic_ind_mod_base_13 <- as.matrix(freq_top300_btwn_dyadic_ind_mod_base_13)
   summary(as.numeric(mat_freq_top300_btwn_dyadic_ind_mod_base_13))
   sd(mat_freq_top300_btwn_dyadic_ind_mod_base_13)

   identical(names(freq_top300_btwn_dyadic_ind_mod_base_13), 
             rownames(mat_freq_top300_btwn_dyadic_ind_mod_base_13))
   
   rownames_of_freq_mat <- as.numeric(rownames(mat_freq_top300_btwn_dyadic_ind_mod_base_13)) 
   resp_rownames <- which(rownames_of_freq_mat <= 298)
   
   summary(as.numeric(mat_freq_top300_btwn_dyadic_ind_mod_base_13[resp_rownames,]))
   sd(as.numeric(mat_freq_top300_btwn_dyadic_ind_mod_base_13[resp_rownames,]))
   
   ## save
   saveRDS(names.in.num, file="btwn_top300_ids.RDS")
   