  ## libraries
   library(sna)
   library(ergm)

   ## data
   load("R0_net_deidentified.RData")

   ## obtain degree classes and compute mean degrees
   deg.R0.net <- degree(R0.net, cmode="indegree")
   summary(deg.R0.net)
   hist(deg.R0.net)

   length.of.class <- 7
   deg.R0.net.sort <- sort(deg.R0.net, decreasing=FALSE, index=TRUE)

   # deg.R0.net.class.mat <- matrix(deg.R0.net.sort$x, ncol=length.of.class, byrow=TRUE)
   # deg.R0.net.class.means <- apply(deg.R0.net.class.mat, 1, function(x)
   # mean(x, ndeg.R0.net.rm=TRUE))
   #deg.R0.net.sort.index <- deg.R0.net.sort$ix
   
   #deg.R0.net.deg.class <- rep(-1, length(deg.R0.net))
   
   #for (i in 1:length(deg.R0.net.deg.class)){
   #    deg.R0.net.deg.class[i] <- deg.R0.net.class.means[((deg.R0.net.sort.index[i] %/% length.of.class)+1)]
   #}
  
   # Aditya, your apprach meant that the last row got padded with 0s, which were then included in the mean calculation

  n <- network.size(R0.net)
  num.classes <- floor(n/length.of.class)
  remainder <- n - length.of.class*num.classes
  deg.R0.net.deg.class <- rep(1:num.classes, each=length.of.class)
  deg.R0.net.deg.class <- c(deg.R0.net.deg.class, rep(num.classes, remainder))
  deg.R0.net.deg.class[deg.R0.net.sort$ix] <- deg.R0.net.deg.class
  #class.means <- sapply(1:num.classes, function(x) mean(deg.R0.net[deg.R0.net.deg.class==x]))
  #class.sizes <- sapply(1:num.classes, function(x) sum(deg.R0.net.deg.class==x))
  #nodefactor.stats <- class.means*class.sizes           
   
  table(deg.R0.net.deg.class)
  R0.net %v% "deg.class.mean.deg" <- deg.R0.net.deg.class

  ## fit edges-only model
  edges.mod <- ergm(R0.net ~ edges)
  summary(edges.mod)
  edges.mod.gof.deg <- gof(edges.mod ~ degree, control=control.gof.formula(nsim=10), verbose=T)
  plot(edges.mod.gof.deg)
 
  ## fit edges+nodecov model
  #edges.nodecov.mod <- ergm(R0.net ~ edges+nodecov("deg.class.mean.deg"))
  #summary(edges.nodecov.mod)
  #edges.nodecov.mod.gof.deg <- gof(edges.nodecov.mod ~ degree)
  #plot(edges.nodecov.mod.gof.deg)

  ## fit edges+nodefactor model
  edges.nodef.mod <- ergm(R0.net ~ edges+nodefactor("deg.class.mean.deg", base=10))
  summary(edges.nodef.mod)
  edges.nodef.mod.gof.deg <- gof(edges.nodef.mod ~ degree, control=control.gof.formula(nsim=100), verbose=T)
  plot(edges.nodef.mod.gof.deg)
 
  ## Compare gof plots
  #pdf(file="gofs_comparison.pdf")
  #par(mfrow=c(3,1))
  #plot(edges.mod.gof.deg, ylim=c(0, 1.5), main="edges only")
  #plot(edges.nodecov.mod.gof.deg, main="edges+nodecov only", ylim=c(0, 0.15))
  #plot(edges.nodef.mod.gof.deg, main="edges+nodefactor only", ylim=c(0, 0.15))  
  #dev.off()
