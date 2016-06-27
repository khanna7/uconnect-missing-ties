## summarize KP on igraphs

   rm(list=ls())

   ## libraries and data
   load("../compute-influence-metrics/sort_top300_kp_dyadic_ind_mod_base_13.RData")

   ## summarize results
   vec_kp_dyadic_ind_mod_base_13 <- unlist(kp_dyadic_ind_mod_base_13)
   length(vec_kp_dyadic_ind_mod_base_13)

   tab_kp_dyadic_ind_mod_base_13 <- table(vec_kp_dyadic_ind_mod_base_13)
   length(tab_kp_dyadic_ind_mod_base_13)
   sort_tab_kp_dyadic_ind_mod_base_13 <- sort(tab_kp_dyadic_ind_mod_base_13, decreasing=TRUE)

   length(sort_tab_kp_dyadic_ind_mod_base_13)
   names.in.num <- as.numeric(names(sort_tab_kp_dyadic_ind_mod_base_13))
   length(which(names.in.num <= 298))
   length(names.in.num)

   ## compute mean and variance of numebr of occurences
   mat_tab_kp_dyadic_ind_mod_base_13 <- as.matrix(tab_kp_dyadic_ind_mod_base_13)
   summary(as.numeric(mat_tab_kp_dyadic_ind_mod_base_13))
   sd(mat_tab_kp_dyadic_ind_mod_base_13)
   
   identical(names(tab_kp_dyadic_ind_mod_base_13), 
             rownames(mat_tab_kp_dyadic_ind_mod_base_13))
   
   rownames_of_tab_mat <- as.numeric(rownames(mat_tab_kp_dyadic_ind_mod_base_13)) 
   resp_rownames <- which(rownames_of_tab_mat <= 298)
   length(resp_rownames)
   nonresp_rownames <- which(rownames_of_tab_mat > 298)
   length(nonresp_rownames)


   summary(as.numeric(mat_tab_kp_dyadic_ind_mod_base_13[resp_rownames,]))
   sd(as.numeric(mat_tab_kp_dyadic_ind_mod_base_13[resp_rownames,]))

   summary(as.numeric(mat_tab_kp_dyadic_ind_mod_base_13[nonresp_rownames,]))
   sd(as.numeric(mat_tab_kp_dyadic_ind_mod_base_13[nonresp_rownames,]))

   ## save
   save.image(file="sort_top300_kp_dyadic_ind_mod_base_13_try1.RData")
   saveRDS(names.in.num, file="set300_kp_dyad_ind.RDS")
