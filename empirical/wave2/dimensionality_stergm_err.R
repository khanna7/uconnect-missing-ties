## reproduce dimensionality error in stergm
   rm(list=ls())
   library(tergm)

   ## set up network
   n.r <- 300
   n.nr <- 600
   n <- n.r + n.nr
   
   mean.deg <- 150
   nedges <- n*mean.deg/2
   
   n0 <- network.initialize(n=n, directed=FALSE)
   
   ## network at time 1
   n_t1_est <- ergm(n0~edges, target.stats=nedges)
   n_t1 <- simulate(n_t1_est)
   n_t1
   
   n_t1_mat <- as.matrix.network(n_t1, "adjacency")
   n_t1_mat_resp <- n_t1_mat[1:n.r, 1:n.r]
   
   ## toggle the first 10% of the resp-resp edges
   n_t1_mat_resp_10pc <- 1-n_t1_mat[(1:(n.r/10)), (1:(n.r/10))]
   dim(n_t1_mat_resp_10pc)
   
   n_t2_mat_resp <- n_t1_mat_resp
   n_t2_mat_resp[(1:(n.r/10)), (1:(n.r/10))] <- n_t1_mat_resp_10pc
   
   ## network at time 2
   n_t2_mat <- n_t1_mat
   n_t2_mat[(1:n.r), (1:n.r)] <- n_t2_mat_resp
   nonresp_nonresp_idx <- (n.r+1):n
   n_t2_mat[nonresp_nonresp_idx, nonresp_nonresp_idx] <- NA
   
   n_t2 <- as.network.matrix(n_t2_mat, directed=FALSE)
   n_t2
   
   ## fit stergm
   net_list <- list(n_t1, n_t2)
   stergm_ex <- stergm(net_list, 
                       formation=~edges,
                       dissolution = ~edges,
                       estimate = "CMLE")
