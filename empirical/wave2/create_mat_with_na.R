rm(list=ls())

library(network)

#load data
wave1.fb.net.common <- readRDS(file = "wave1.fb.net.common.rds")

## add na's to edges of non-participant nodes, wave 1
mat.to.impute.w1 <- as.matrix.network(wave1.fb.net.common, "adjacency", directed = FALSE)

dim(mat.to.impute.w1)
v.names <-   wave1.fb.net.common %v% "vertex.names"

row.names <- substr(rownames(mat.to.impute.w1), 1, 4)
col.names <- substr(colnames(mat.to.impute.w1), 1, 4)


for (i in 1:nrow(mat.to.impute.w1)){
  for (j in 1:ncol(mat.to.impute.w1)){
    if (row.names[i] != "1111" && row.names[i] != "2222"){
      if (col.names[j] != "1111" && col.names[j] != "2222"){
        mat.to.impute.w1[i,j] <- NA
      }
    }
  }
}


saveRDS(mat.to.impute.w1, file ="wave1.imputed.mat.rds")

wave2.fb.net.common <- readRDS(file = "wave2.fb.net.common.rds")

## add na's to edges of non-participant nodes, wave 2
mat.to.impute.w2 <- as.matrix.network(wave2.fb.net.common, "adjacency")

v.names <-   wave2.fb.net.common %v% "vertex.names"

row.names <- substr(rownames(mat.to.impute.w2), 1, 4)
col.names <- substr(rownames(mat.to.impute.w2), 1, 4)


for (i in 1:nrow(mat.to.impute.w2)){
  for (j in 1:ncol(mat.to.impute.w2)){
    if (row.names[i] != "1111" && row.names[i] != "2222"){
      if (col.names[j] != "1111" && col.names[j] != "2222"){
        mat.to.impute.w2[i,j] <- NA
      }
    }
  }
}


saveRDS(mat.to.impute.w2, file = "wave2.imputed.mat.rds")