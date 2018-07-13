

library()

## order vertex names to avoid trouble later
   vnames <- wave1.wave2.all.ig %v% "vertex.names"
   resp.1 <- which(substr(vnames, 1, 4) == "1111")
   resp.2 <- which(substr(vnames, 1, 4) == "2222")
   vnames.nr <- vnames[-c(resp.1, resp.2)]
   vnames.nr <- paste0("NR.", vnames.nr)
   vnames[-c(resp.1, resp.2)] <- vnames.nr
   nonresp <- which(substr(vnames, 1, 3) == "NR.")

   vnames.ordered <- c(resp.1, resp.2, nonresp)

    permute.vertexIDs(wave1.wave2.all.ig,
                      vids=vnames.ordered)

   ## add na's to edges of non-participant nodes
   adj.mat.wave1.wave2.all.ig <- as.matrix.network(wave1.wave2.all.ig, "adjacency")
   dim(adj.mat.wave1.wave2.all.ig)
   v.names <- wave1.wave2.all.ig %v% "vertex.names"

   mat.to.impute <- adj.mat.wave1.wave2.all.ig
   row.names <- substr(rownames(mat.to.impute), 1, 4)
   col.names <- substr(rownames(mat.to.impute), 1, 4)

  for (i in 1:nrow(mat.to.impute)){
       for (j in 1:ncol(mat.to.impute)){
           if (row.names[i] != "1111" && row.names[i] != "2222"){
               if (col.names[j] != "1111" && col.names[j] != "2222"){
                   mat.to.impute[i,j] <- NA
               }
           }
       }
   }

