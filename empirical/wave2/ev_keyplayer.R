

library(igraph)
library(network)
library(intergraph)
library(influenceR)

load('all_graphs.RData')


##### Calculate EV  ######

w1.ev <- evcent(wave1.fb.ig.10) 
w1.ev.df <- as.data.frame(w1.ev)
w1.ev.sorted <- w1.ev.df[order(w1.ev.df$vector, decreasing = TRUE),]

w1.top.300 <- head(row.names(w1.ev.sorted), 300)
w1.top.50 <- head(row.names(w1.ev.sorted), 50)

w2.ev <- evcent(wave2.fb.ig.10)
w2.ev.df <- as.data.frame(w2.ev)
w2.ev.sorted <- w2.ev.df[order(w2.ev.df$vector, decreasing = TRUE),]

w2.top.300 <- head(row.names(w2.ev.sorted), 300)
w2.top.50 <- head(row.names(w2.ev.sorted), 50)

length(which(w1.top.300 %in% w2.top.300))
length(which(w1.top.50 %in% w2.top.50))

ev.300.common.ids <- w1.top.300[which(w1.top.300 %in% w2.top.300)]
ev.50.common.ids <- w1.top.50[which(w1.top.50 %in% w2.top.50)]

save(w1.top.300, w2.top.300, file = "w1w2PCAids.RData")

#Respondent and nonrespondent breakdown of PCA's
wave1_ev_resp <- union(which(substr(w1.top.300, 1, 4) == "1111"),
                       which(substr(w1.top.300, 1, 4) == "2222")
)
length(wave1_ev_resp)

wave2_ev_resp <- union(which(substr(w2.top.300, 1, 4) == "1111"),
                    which(substr(w2.top.300, 1, 4) == "2222")
)
length(wave2_ev_resp)

#overlap of PCAs between waves
 #respondents
length(which(wave1_ev_resp %in% wave2_ev_resp))
 #nonrespondents
w1.nr <- w1.top.300[!wave1_ev_resp]
w2.nr <- w2.top.300[!wave2_ev_resp]
length(which(w1.nr %in% w2.nr))


#Keyplayer persistence 
w1.kp <- replicate(100, keyplayer(wave1.ig, 100, prob = 0, tol = 0))
w1.kp.100 <- V(wave1.ig)[w1.kp]$name
w1.kp.common <- sort(table(w1.kp.100), decreasing = TRUE)[1:100]

w1.kp.2 <- keyplayer(wave1.ig, 50, prob = 0, tol = 0)
w1.kp.50 <- V(wave1.ig)[w1.kp.2]$name

w2.kp <- replicate(100, keyplayer(wave2.ig, 100, prob = 0, tol = 0))
w2.kp.100 <- V(wave2.ig)[w2.kp]$name
w2.kp.common <- sort(table(w2.kp.100), decreasing = TRUE)[1:100]

w2.kp.2 <- keyplayer(wave2.ig, 50, prob = 0, tol = 0)
w2.kp.50 <- V(wave2.ig)[w2.kp.2]$name 

#Measure persistence for top 100, top 50
kp.100.common <- length(which(rownames(w1.kp.common) %in% rownames(w2.kp.common)))
kp.100.common.ids <- w2.kp.100[which(rownames(w2.kp.common) %in% rownames(w1.kp.common))] 

kp.50.common <- length(which(w1.kp.50 %in% w2.kp.100))
kp.50.common.ids <- w2.kp.50[which(w2.kp.50 %in% w1.kp.50)]

#Persistence for replication
kp.100.common.rep <- length(which( rownames(w1.kp.common) %in% rownames(w2.kp.common)))

#### Keyplayer, EV overlap
#length(which(w1.top.100 %in% rownames(w1.kp.common)))
#length(which(w2.top.100 %in% rownames(w2.kp.common)))