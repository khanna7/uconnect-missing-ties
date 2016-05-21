## summarize bridging results

   ## libraries and data
   rm(list=ls())

   library(igraph)

   ## data and lists
      load("sort_top300_bridge_dyadic_ind_mod_base_13_25igraphs_47nodes.RData")

      scores_1to25 <- scores
      scores_26to50 <- readRDS("bridging_scores_ind_imp_igraphs_26to50.RDS")
      scores_51to75 <- readRDS("bridging_scores_ind_imp_igraphs_51to75.RDS")
      scores_76to101 <- readRDS("bridging_scores_ind_imp_igraphs_76to101.RDS")

      bridging_885nodes <- c(scores_1to25, scores_26to50,
                             scores_51to75, scores_76to101)
      length(bridging_885nodes)

   ## obtain top 300
      ordered.bridging_885nodes <- lapply(bridging_885nodes,
                                          function (x)
                                              order(x, decreasing=TRUE)
                                          )

      top300.bridging_885nodes <- lapply(ordered.bridging_885nodes,
                                         function (x)
                                             x[1:300]
                                         )
   ## compute distribution 
      freq_top300.bridging_885nodes <- table(unlist(top300.bridging_885nodes))
      sort_top300.bridging_885nodes <- sort(freq_top300.bridging_885nodes,
                                            decreasing=TRUE)
      length(sort_top300.bridging_885nodes)

      names.in.num <- as.numeric(names(sort_top300.bridging_885nodes))
      length(which(names.in.num > 298))

   ## number of top300 bridges from controls in imputed graphs
      top300_control_bridges <- readRDS("control_885nodes_bridging_top300.RDS")
      top300_br_resp <- which(top300_control_bridges < 299)
      length(top300_br_resp)

      length(which(top300_br_resp %in% names.in.num))

   ## save 
      save.image(file="sort_top300.bridging_885nodes.RData")
      saveRDS(sort_top300.bridging_885nodes, file="top300.bridging_dyad_ind.RDS")
