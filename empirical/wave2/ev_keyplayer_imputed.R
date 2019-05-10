## Run keyplayer and eigenvector centrality algorithms on imputed networks
rm(list=ls())

## libraries
library(igraph)
library(network)
library(intergraph)
library(influenceR)

## data
load("sim_from_fitted_ergm_w1w2.RData")

##### EV persistence ######

sim_results_w1 <- lapply(1:100, function(x) asIgraph(sim_results_w1[[x]]))
w1.ev.imputed <- lapply(1:100, function(x) evcent(sim_results_w1[[x]]))  
w1.ev.imputed.df <- lapply(1:100, function(x) as.data.frame(w1.ev.imputed[[x]]))
w1.ev.imputed.df <- lapply(1:100, function(x) cbind(w1.ev.imputed.df[[x]], row.names(w1.ev.imputed.df[[x]])))
w1.ev.sorted <- lapply(1:100, function(x) w1.ev.imputed.df[[x]][order(w1.ev.imputed.df[[x]]$vector, decreasing = TRUE),])

w1.top.300.imputed <- lapply(1:100, function(x) head(w1.ev.sorted[[x]]$`row.names(w1.ev.imputed.df[[x]])`, 300))

sim_results_w2 <- lapply(1:100, function(x) asIgraph(sim_results_w2[[x]]))
w2.ev.imputed <- lapply(1:100, function(x) evcent(sim_results_w2[[x]]))
w2.ev.imputed.df <- lapply(1:100, function(x) as.data.frame(w2.ev.imputed[[x]]))
w2.ev.imputed.df <- lapply(1:100, function(x) cbind(w2.ev.imputed.df[[x]], row.names(w2.ev.imputed.df[[x]])))
w2.ev.sorted <- lapply(1:100, function(x) w2.ev.imputed.df[[x]][order(w2.ev.imputed.df[[x]]$vector, decreasing = TRUE),])

w2.top.300.imputed <- lapply(1:100, function(x) head(w2.ev.sorted[[x]]$`row.names(w2.ev.imputed.df[[x]])`, 300))

#Find frequency that nodes are selected across the 100 imputed networks, w1
w1.frequency <- unlist(w1.top.300.imputed) #table ,plot
w1.freq.table <- table(w1.frequency)
w1.freq.300 <- head(sort(w1.freq.table, decreasing = TRUE), 300)
w1.freq.300.names <- names(w1.freq.300)

#Find frequency that nodes are selected across the 100 imputed networks, w2
w2.frequency <- unlist(w2.top.300.imputed) #table ,plot
w2.freq.table <- table(w2.frequency)
w2.freq.300 <- head(sort(w2.freq.table, decreasing = TRUE), 300)
w2.freq.300.names <- names(w2.freq.300)

#Distribution of nodes that were selected 
hist(w1.freq.table, main = 'Distribution of PCA Selection Across Imputed Networks, Wave 1', xlab = 'Number of PCA Selections', ylab = 'Number of Nodes')
hist(w2.freq.table, main = 'Distribution of PCA Selection Across Imputed Networks, Wave 2', xlab = 'Number of PCA Selections', ylab = 'Number of Nodes')

#mean number of PCA selections
mean(w1.freq.table)
sd(w1.freq.table)
mean(w2.freq.table)
sd(w2.freq.table)

#Find frequency of nodes selected at least once 
length(which(w1.freq.table > 0))
length(which(w2.freq.table > 0))

#by non respondents and respondents
length(which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) <= 235)) #respondents
length(which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) > 235)) #nonrespondents

length(which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) <= 318)) #respondents
length(which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) > 318)) #nonrespondents

#Find mean number of times selected, given at least one selection
mean(w1.freq.table[which(w1.freq.table > 0)])
sd(w1.freq.table[which(w1.freq.table > 0)])
mean(w2.freq.table[which(w2.freq.table > 0)])
sd(w2.freq.table[which(w2.freq.table > 0)])

#respondents, nonrespondents
mean(w1.freq.table[which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) <= 235)])
sd(w1.freq.table[which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) <= 235)])
mean(w2.freq.table[which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) <= 318)])
sd(w2.freq.table[which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) <= 318)])

mean(w1.freq.table[which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) > 235)])
sd(w1.freq.table[which(w1.freq.table > 0 & as.numeric(names(w1.freq.table)) > 235)])
mean(w2.freq.table[which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) > 318)])
sd(w2.freq.table[which(w2.freq.table > 0 & as.numeric(names(w2.freq.table)) > 318)])


nr1 <- which(as.numeric(names(w1.freq.300)) > 235)
mean(w1.freq.300[nr1])
sd(w1.freq.300[nr1])

r1 <- which(as.numeric(names(w1.freq.300)) <= 235)
mean(w1.freq.300[r1])
sd(w1.freq.300[r1])

nr2 <- which(as.numeric(names(w2.freq.300)) > 318)
mean(w2.freq.300[nr2])
sd(w2.freq.300[nr2])

r2 <- which(as.numeric(names(w2.freq.300)) <= 318)
mean(w2.freq.300[r2])
sd(w2.freq.300[r2])

mean(w1.freq.300)
sd(w1.freq.300)

mean(w2.freq.300)
sd(w2.freq.300)


nrw1 <- names(w1.freq.300)[which(as.numeric(names(w1.freq.300)) > 235)] 
rw1 <- names(w1.freq.300)[which(as.numeric(names(w1.freq.300)) <= 235)]
nrw2 <- names(w2.freq.300)[which(as.numeric(names(w2.freq.300)) > 318)] 
rw2 <- names(w2.freq.300)[which(as.numeric(names(w2.freq.300)) <= 318)]

#Find overlaps between waves
length(which(nrw2 %in% rw1))
length(which(nrw2 %in% nrw1))
length(which(rw2 %in% rw1))
length(which(rw2 %in% nrw1))

#Find all overlap
length(which(names(w1.freq.300) %in% names(w2.freq.300)))


#Find frequency of nodes selected across the 100 imputed networks, w2
w2.frequency <- unlist(w2.top.300.imputed) #table ,plot
w2.freq.table <- table(w2.frequency)
w2.freq.300 <- head(sort(w2.freq.table, decreasing = TRUE), 300)
w2.freq.300.names <- names(w2.freq.300)


#No longer using Keyplayer to determine PCAs
#Keyplayer 
#w1.kp.imputed <- lapply(1:100, function(x) replicate(25, keyplayer((sim_results_w1[[x]]), 300, prob = 0, tol = 0)))
#w1.kp.300 <- lapply(1:100, V(asIgraph(sim_results_w1[[x]]))[w1.kp[[x]]]$name)
#w1.kp.common <- lapply(1:100, function(x) sort(table(w1.kp.300[[x]]), decreasing = TRUE)[1:300])

#w2.kp <- lapply(1:100, function(x) replicate(25, keyplayer((sim_results_w2[[x]]), 300, prob = 0, tol = 0)))
#w2.kp.300 <- lapply(1:100, V(asIgraph(sim_results_w2[[x]]))[w2.kp[[x]]]$name)
#w2.kp.common <- lapply(1:100, function(x) sort(table(w2.kp.300[[x]]), decreasing = TRUE)[1:100])

#Measure persistence for top 100, top 50
#kp.100.common <- length(which(rownames(w1.kp.common) %in% rownames(w2.kp.common)))
#kp.100.common.ids <- w2.kp.100[which(rownames(w2.kp.common) %in% rownames(w1.kp.common))] 

#Persistence for replication
#kp.100.common.rep <- length(which(rownames(w1.kp.common) %in% rownames(w2.kp.common)))

#### Keyplayer, EV overlap
#length(which(w1.top.100 %in% rownames(w1.kp.common)))
#length(which(w2.top.100 %in% rownames(w2.kp.common)))

#save.image("ev_keyplayer_results.RData")
