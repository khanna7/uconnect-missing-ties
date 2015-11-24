## image plot

   rm(list=ls())   

   library(network)
       
   ## data
   load("matrices_for_imageplot.RData")
   load(file="sim_from_fitted_ergm_objects_in_parallel_ten.RData")

   net <- sim_results[[1]]
   n <- network.size(net)
   matrix.list <- array(NA, dim=c(n, n, 10))
   for (i in 1:10) {
       matrix.list[, , i] <- matrices[[i]]
   }

   save(matrix.list, file="matrix_list.RData")

   ## obtain frequencies
   freq <- apply(matrix.list, c(1,2), sum)
   colnames(freq) <- net%v%"vertex.names"
   rownames(freq) <- net%v%"vertex.names"

   ## colnames(freq) <- substr(colnames(freq), 1, 4)
   ## n.1111 <- which(colnames(freq) == "1111")
   ## n.2222 <- which(colnames(freq) == "2222")
   ## resp <- c(n.1111, n.2222)

   ## colnames(freq)[-resp] <- "NR"
   ## new_names <- colnames(freq)

   ## rownames(freq) <- new_names
   

   ## freq <- freq[,c(rep("1111", length(n.1111)), rep("2222", length(n.2222)),
   ##                 rep("NR", n-length(resp)))]
   ## rownames(freq) <- freq[c(rep("1111", length(n.1111)), rep("2222", length(n.2222)),
   ##                 rep("NR", n-length(resp))),]
   ## plot
   pdf(file="heat-map.pdf")
   image(freq, xlim=c(0,1), ylim=c(1,0), col=gray(100:0/100))
   dev.off()

   resp.rows <- rep(0, n)
   for (i in 1:nrow(freq)){
       if (all(freq[i,] %% 10 == 0)){
           resp.rows[i] = 1
           }
  } 
  table(resp.rows)
