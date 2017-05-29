## illustrate data structure of network data

library(sna)

data_matrix <- matrix(c(1, 1, 1, 0,
                        1, 1, 0, 1,
                        1, 0, 1, 1,
                        0,1,1,0),
                         nrow=4, ncol=4, byrow=T
                         )
net <- as.network(data_matrix, directed=FALSE, diag=FALSE)

coord <- matrix(c(0, 0, 3, 0, 0, 3, 3, 3), byrow=TRUE, nrow=4, ncol=2)

png("net_data_illust.png")
p <- gplot(net, gmode="graph", vertex.col=c("green", "green", "orange", "orange"), edge.lty=c(1, 1, 1, 3))
dev.off()