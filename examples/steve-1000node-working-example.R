## from email dated 11 Nov 2015

# Demonstration of imputation of alter-alter ties using degree with
#      with respondents as one predictor of the missing ties

##########################
# params to set
nresp <- 300
nalters <- 700
mdeg <- 22*(nresp+nalters)/nresp

##########################
# Process
library(network)
library(ergm)
n <- nresp + nalters

###########################
# Create init net

success <- 0

while (success==0) {
  mynet <- network.initialize(n, directed=F)
  greg <- runif(n) # just to get extra variation in underlying observed degree
  mynet <- set.vertex.attribute(mynet, 'greg', greg)
  myfit <- ergm(mynet~edges+nodecov('greg'),
                target.stats=c(mdeg*n/2, 1.1*mdeg*n/2), verbose=T) # The 1.1 means that those with higher 'gregariousness' will form more ties.
  mynet <- simulate(myfit)

  mynet.mat <- as.matrix(mynet, "adjacency")
  imputed_matrix <- matrix(NA, nalters, nalters)
  mynet.mat[((nresp+1):n),((nresp+1):n)] <- imputed_matrix

  mynet.imputed <- as.network.matrix(mynet.mat, matrix.type="adjacency",
                                     directed=FALSE)
  summary(mynet.imputed ~ edges)

  ratio <- mean(rowSums(mynet.imputed[1:nresp,1:nresp])) /
             mean(rowSums(mynet.imputed[(nresp+1):n,1:nresp]))
  if(ratio>0.99 & ratio<1.01) success <- 1
}

# Check that NA's are registering in
#aaa <- ergm(mynet~edges)$coef
#density <- exp(aaa)/(1+exp(aaa))
#density * n *(n-1) / 2
#density * (((nresp)*(nresp-1)/2) + (nresp*nalters))

respdeg <- sapply(1:n, function(x) sum(mynet.imputed[x,1:nresp]))
mynet.imputed <- set.vertex.attribute(mynet.imputed, 'respdeg', respdeg)
table(mynet.imputed%v%"respdeg"); length(mynet.imputed%v%"respdeg")

t0 <- proc.time()
mynet.imputed.ergm <- ergm(mynet.imputed ~ edges+nodecov('respdeg'), verbose=TRUE
)
proc.time() - t0

sim <- simulate(mynet.imputed.ergm,
                constraints=~observed, nsim=5, verbose=TRUE,
                control=control.simulate.ergm(MCMC.burnin=1e6, MCMC.interval=1e5))

mdeg.obs <- sapply(1:length(sim), function(x) summary(sim[[x]]~edges)*2/n)
mdeg.obs; mdeg

# Should be equal
mean(rowSums(sim[[1]][1:nresp,1:nresp]))
mean(rowSums(sim[[1]][(nresp+1):n,1:nresp]))

# Should be equal
mean(rowSums(sim[[1]][1:nresp,(nresp+1):n]))
mean(rowSums(sim[[1]][(nresp+1):n,(nresp+1):n]))

# Should show no difference in the left section and the right section
plot(rowSums(sim[[1]][,1:nresp]))
plot(rowSums(sim[[1]][,(nresp+1):n]))

save.image("steve-imputation-1000v-ex.RData")
