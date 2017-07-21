## illustrate data structure of network data

library(sna)
library(GGally)

data_matrix <- matrix(c(1, 1, 1, 0, 1, 0,
                        1, 1, 0, 1, 0, 1,
                        1, 1, 1, 1, 1, 1, 
                        0, 1, 1, 0, 1, 1,
                        1, 0, 1, 1, 1, 1,
                        0, 1, 1, 1, 1, 1),
                         nrow=6, ncol=6, byrow=T
                         )
net <- as.network(data_matrix, directed=FALSE, diag=FALSE)
as.matrix(as.edgelist(net))
net %v% "node_type" <- c(rep("respondent", 2), rep("nonrespondent", 4))
net %e% "edge_type" <- c(rep("observed", 5), rep("unobserved", 6))

#coord <- matrix(c(0, 0, 3, 0, 0, 3, 3, 3), byrow=TRUE, nrow=4, ncol=2)

png("net_data_illust.png")
gplot(net, gmode="graph", vertex.col=c("green", "green", rep("orange", 4)), 
      edge.lty=c(rep(1, 6), rep(2, 6))
      )
legend("topleft", c("Respondent", "Nonrespondent"), pch=19, col=c("green", "orange"), bty="n", title.adj=0)
legend("topright", c("Observed", "Unobserved"), lty=c(1,3), bty="n", title.adj=0)
dev.off()

ggnet2(net, color="node_type", palette="Set2", edge.lty=ifelse(net%e%"edge_type" == "unobserved", 2, 1))
