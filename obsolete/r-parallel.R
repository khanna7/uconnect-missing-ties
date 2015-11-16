library(network)
library(ergm)

load("mynet.RData")


mynet.mat <- as.matrix(mynet, "adjacency")
na.mat <- apply(mynet.mat, c(1:2), function(x) mynet.mat[x,] <- NA)

proc.time()

library(snow)
library(Rmpi)

assign.na <- function(X){
  #apply(net.mat, c(1:2), function(x) net.mat[x,] <- NA)
  X <- NA
}

mynet1
mynet1.mat <- as.matrix(mynet1, "adjacency")

np <- mpi.universe.size() - 1
cl <- makeCluster(np, type="MPI")
ans <- parApply(cl, mynet1.mat, c(1:2), assign.na)
proc.time()
dim(ans)

stopCluster(cl)
mpi.exit()
##
# Source: http://www.umbc.edu/hpcf/resources-tara/how-to-run-R.html
# filename: snow-test.R
# 
# SNOW quick ref: http://www.sfu.ca/~sblay/R/snow.html
#
# Notes:
#   - Library loading order matters
#   - system.time([function]) is an easy way to test optimizations
#   - parApply is snow parallel version of 'apply'
#
##

## library(Rmpi)
## library(snow)

## # Initialize SNOW using MPI communication. The first line will get the number of
## # MPI processes the scheduler assigned to us. Everything else is standard SNOW
## np <- mpi.universe.size() - 1
## cluster <- makeMPIcluster(np)

## # Print the hostname for each cluster member
## sayhello <- function() {
##   info <- Sys.info()[c("nodename", "machine")]
##   paste("Hello from", info[1], "with CPU type", info[2])
## }

## names <- clusterCall(cluster, sayhello)
## print(unlist(names))

## # Compute row sums in parallel using all processes, then a grand sum at the end
## # on the master process
## parallelSum <- function(m, n) {
##   A <- matrix(rnorm(m*n), nrow = m, ncol = n)
##   # Parallelize the summation
##   row.sums <- parApply(cluster, A, 1, sum)
##   print(sum(row.sums))
## }

## # Run the operation over different size matricies
## system.time(parallelSum(5000, 5000))

## # Always stop your cluster and exit MPI to ensure resources are properly freed
## stopCluster(cluster)
## mpi.exit()
