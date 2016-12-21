## label missing edges as NA
rm(list=ls())


library(intergraph)
library(network)
library(igraph)

load("../fb_net_comparison.RData")

  ## first order vertex ID's
  vnames <- V(w1.fb.ig.10pc)$name
  resp.1 <- which(substr(vnames, 1, 4) == "1111")
  resp.2 <- which(substr(vnames, 1, 4) == "2222")
  vnames.nr <- vnames[-c(resp.1, resp.2)]
  vnames.ord <- c(vnames[resp.1], vnames[resp.2], vnames.nr)

  w1.fb.ig.10pc.ord <- permute.vertices(w1.fb.ig.10pc, 
                                        match(vnames, vnames.ord)
                                        )

  ## convert into network format
  w1.fb.net.10pc.ord <- asNetwork(w1.fb.ig.10pc.ord)
  len.resp <- length(resp.1) + length(resp.2)                     
  w1.size <- network.size(w1.fb.net.10pc.ord)

  ## denote unobserved edges as NA
  adj.w1.fb.net.10pc.ord <- as.matrix.network(w1.fb.net.10pc.ord, "adjacency")
  row.names <- substr(rownames(adj.w1.fb.net.10pc.ord), 1, 4)
  col.names <- row.names  

  for (i in 1:nrow(adj.w1.fb.net.10pc.ord )){
    for (j in 1:ncol(adj.w1.fb.net.10pc.ord )){
      if (row.names[i] != "1111" && row.names[i] != "2222"){
        if (col.names[j] != "1111" && col.names[j] != "2222"){
          adj.w1.fb.net.10pc.ord [i,j] <- NA
        }
      }
    }
  }
  
  w1.fb.net.10pc.wna <- as.network.matrix(adj.w1.fb.net.10pc.ord,
                                          directed=FALSE)

  saveRDS(w1.fb.net.10pc.wna, "w1.fb.net.10pc.wna.RDS")
