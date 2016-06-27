## summarize bridging results

   ## libraries and data
   rm(list=ls())

   library(igraph)

   ## data and lists
      load("../compute-influence-metrics/sort_top300_bridge_dyadic_ind_mod_base_13.RData")

   ## frequency
      freq_top300_bridge_dyadic_ind_mod_base_13
      length(freq_top300_bridge_dyadic_ind_mod_base_13)
      length(sort_top300_bridge_dyadic_ind_mod_base_13)
      names.in.num <- as.numeric(
        names(sort_top300_bridge_dyadic_ind_mod_base_13)
      )

      length(names.in.num)
      length(which(names.in.num <= 298))
      length(which(names.in.num > 298))

   ## compute mean and variance of numebr of occurences
   mat_freq_top300_bridging_dyadic_ind_mod_base_13 <- as.matrix(freq_top300_bridge_dyadic_ind_mod_base_13)
   summary(as.numeric(mat_freq_top300_bridging_dyadic_ind_mod_base_13))
   sd(mat_freq_top300_bridging_dyadic_ind_mod_base_13)
   
   identical(names(freq_top300_bridge_dyadic_ind_mod_base_13), 
             rownames(mat_freq_top300_bridging_dyadic_ind_mod_base_13))
   
   rownames_of_freq_mat <- as.numeric(rownames(mat_freq_top300_bridging_dyadic_ind_mod_base_13)) 
   resp_rownames <- which(rownames_of_freq_mat <= 298)
   length(resp_rownames)
   nonresp_rownames <- which(rownames_of_freq_mat > 298)
   length(nonresp_rownames)


   summary(as.numeric(mat_freq_top300_bridging_dyadic_ind_mod_base_13[resp_rownames,]))
   sd(as.numeric(mat_freq_top300_bridging_dyadic_ind_mod_base_13[resp_rownames,]))

   summary(as.numeric(mat_freq_top300_bridging_dyadic_ind_mod_base_13[nonresp_rownames,]))
   sd(as.numeric(mat_freq_top300_bridging_dyadic_ind_mod_base_13[nonresp_rownames,]))

   ## save
      saveRDS(names.in.num, file="bridging_top300_ids.RDS")
      save.image(file="bridging_results.RData")
