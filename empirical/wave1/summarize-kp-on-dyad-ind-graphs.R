## summarize KP on igraphs

   rm(list=ls())

   ## libraries and data
   library(network)
   load("sort_top300_kp_dyadic_ind_mod_base_13.RData")

   ## summarize results
   vec_kp_dyadic_ind_mod_base_13 <- unlist(kp_dyadic_ind_mod_base_13)
   length(vec_kp_dyadic_ind_mod_base_13)

   tab_kp_dyadic_ind_mod_base_13 <- table(vec_kp_dyadic_ind_mod_base_13)
   length(tab_kp_dyadic_ind_mod_base_13)
   sort_tab_kp_dyadic_ind_mod_base_13 <- sort(tab_kp_dyadic_ind_mod_base_13, decreasing=TRUE)

   ## save
   save.image(file="sort_top300_kp_dyadic_ind_mod_base_13_try1.RData")
