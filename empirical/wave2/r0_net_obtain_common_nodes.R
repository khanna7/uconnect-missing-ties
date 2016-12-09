## compute EDA characteristics between Waves 1 and 2.

rm(list=ls())
library(ergm)
library(intergraph)
library(igraph)
library(foreign)

## all respondent node graphs (not restricted only to common nodes)

## wave 1
w1.resp.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_resp_edges_only_edges.csv")
w1.resp.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_resp_edges_only_nodes.csv")
w1.resp.ig <- graph_from_data_frame(w1.resp.edges.dat[,c(1:2)], directed=FALSE, vertices=w1.resp.nodes.dat[,1])

## wave 2
w2.resp.edges.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_resp_edges_only_edges.csv")
w2.resp.nodes.dat <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/Wave_2/fb_graph_resp_edges_only_nodes.csv")
w2.resp.ig <- graph_from_data_frame(w2.resp.edges.dat[,c(1:2)], directed=FALSE, vertices=w2.resp.nodes.dat[,1])

## common nodes
w1_in_w2_id <- which(w1.resp.nodes.dat$id %in% w2.resp.nodes.dat$id)
w2_in_w1_id <- which(w2.resp.nodes.dat$id %in% w1.resp.nodes.dat$id)

w1_com_resp_ig <- induced_subgraph(w1.resp.ig, vids=w1_in_w2_id)
w2_com_resp_ig <- induced_subgraph(w2.resp.ig, vids=w2_in_w1_id)

#####################################################
## THUS THERE ARE 294 nodes in the Facebook networks on the two waves
## However, for 28 of these individuals, there are no in-person survey data in Wave 2"

## See email to John dated 17/7/15 titled RE: Stuart's explanation about n=266 for Wave 2 respondents:

## For these 28 participants, we have Facebook data in both waves, survey (i.e. uConnect) data in wave 1, and no survey data in wave 2 (which includes parameters such as PrEP awareness and use).
#####################################################

## cross-check with wave2 data
w2_ego <- read.dta("/project/khanna7/Projects/UConnect/Wave 2_CC_Aug2016/EGO.dta")

## BELOW GIVES A RESULT OF 266!!!:
length(which(V(w2_com_resp_ig)$name %in% w2_ego$su_id))

## AND WE CAN VERIFY THAT THERE ARE 28 INDIVIDUALS FOR
## in the COMMON RESPONDENTS FB NETWORK AT W2
## ON WHOM WE HAVE NO FB DATA
length(which(!V(w2_com_resp_ig)$name %in% w2_ego$su_id))

## THEREFORE WE WILL USE THE 266 RESPONDENTS ON WHOM WE HAVE 
## FB and SURVEY DATA FOR WAVES 1 and 2.
w2_id_w_svy_data <- which(V(w2_com_resp_ig)$name %in% w2_ego$su_id)
w2_com_resp_ig_wsvydata <- induced_subgraph(w2_com_resp_ig, vids=w2_id_w_svy_data)

w1_id_w_w2_svy_data <- which(V(w1_com_resp_ig)$name %in% V(w2_com_resp_ig_wsvydata)$name)
w1_com_resp_ig_w_w2svydata <- induced_subgraph(w1_com_resp_ig, vids=w1_id_w_w2_svy_data)

## permute nodes so that RDS seeds are first
w1_vnames <- V(w1_com_resp_ig_w_w2svydata)$name
w2_vnames <- V(w2_com_resp_ig_wsvydata)$name

w1_vnames_ord <- sort(as.numeric(w1_vnames))
w2_vnames_ord <- sort(as.numeric(w2_vnames))
identical(w1_vnames_ord, w2_vnames_ord)

w1_com_resp_ig_w_w2svydata_ord <- permute.vertices(w1_com_resp_ig_w_w2svydata, 
                                                   match(w1_vnames, w1_vnames_ord)
)
w2_com_resp_ig_wsvydata_ord <- permute.vertices(w2_com_resp_ig_wsvydata,
                                                match(w2_vnames, w2_vnames_ord))

## Compare degree distributions
deg_w1_com_resp_ig_w_w2svydata <- degree(w1_com_resp_ig_w_w2svydata_ord)
deg_w2_com_resp_ig_wsvydata <- degree(w2_com_resp_ig_wsvydata_ord)

par(mfrow=c(1,2))
hist(deg_w1_com_resp_ig_w_w2svydata, main="Wave 1", xlab="Degree", breaks=seq(0, 120, 10))
hist(deg_w2_com_resp_ig_wsvydata, main="Wave 2", xlab="Degree", breaks=seq(0, 120, 10))

## Compare esp
w1_com_resp_net_w_w2svydata <- asNetwork(w1_com_resp_ig_w_w2svydata_ord)
w2_com_resp_net_wsvydata <- asNetwork(w2_com_resp_ig_wsvydata_ord)

w1_com_resp_net_w_w2svydata_esp_sum <- summary(w1_com_resp_net_w_w2svydata ~ gwesp)
w2_com_resp_net_wsvydata_esp_sum <- summary(w2_com_resp_net_wsvydata ~ gwesp)

par(mfrow=c(2,1))
barplot(w1_com_resp_net_w_w2svydata_esp_sum)
barplot(w2_com_resp_net_wsvydata_esp_sum)

## calculate numbers of dissolved and new ties 
el_w1 <- as_edgelist(w1_com_resp_ig_w_w2svydata_ord) 
         #edgelists needed on ordered networks to 
         #produce correct summaries of formed/dissolved ties 
el_w2 <- as_edgelist(w2_com_resp_ig_wsvydata_ord)

el_rbind <- rbind(el_w1, el_w2) 
nrow(el_rbind[duplicated(el_rbind), 
              ,drop = FALSE]) #number of common ties

ecount(w2_com_resp_ig_wsvydata) - 
  nrow(el_rbind[duplicated(el_rbind), ,drop = FALSE])
  # number of newly formed ties

ecount(w1_com_resp_ig_w_w2svydata) -
  nrow(el_rbind[duplicated(el_rbind), 
                ,drop = FALSE]) #num. of ties at w1 that had dissolved in w2 

## produce heatmap of edges between the two waves
   ## prepare adjacency matrices
   adj_w1 <- get.adjacency(w1_com_resp_ig_w_w2svydata_ord)
   adj_w2 <- get.adjacency(w2_com_resp_ig_wsvydata_ord)
   n <- nrow(adj_w1)

   adj_list <- array(NA, dim=c(n, n, 2))
   adj_list[, , 1] <- as.matrix(adj_w1)
   adj_list[, , 2] <- as.matrix(adj_w2)

   ## compute frequencies
   freq <- apply(adj_list, c(1,2), sum)
   colnames(freq) <- w1_vnames
   rownames(freq) <- w2_vnames

   ## visualize
   par(mfrow=c(1,1))
   image(freq, col=gray(32:0/32), xaxt="n", yaxt="n")
 
   ## label
   seed_idx <- which(substr(w1_vnames_ord, 1, 4) == "1111")
   seed_idx_prop <- length(seed_idx)/n

   axis(1, at=seed_idx_prop/2, labels="seeds")
   axis(1, at=(seed_idx_prop+(1-seed_idx_prop)/2), labels="recruits")
   axis(1, at=seed_idx_prop, labels="")

   axis(2, at=seed_idx_prop/2, labels="seeds")
   axis(2, at=(seed_idx_prop+(1-seed_idx_prop)/2), labels="recruits")
   axis(2, at=seed_idx_prop, labels="")

   seed_idx_prop <- 1/2
   image(freq[1:80, 1:80], col=gray(32:0/32), xaxt="n", yaxt="n")
   axis(1, at=seed_idx_prop/2, labels="seeds")
   axis(1, at=(seed_idx_prop+(1-seed_idx_prop)/2), labels="recruits")
   axis(1, at=seed_idx_prop, labels="")

   axis(2, at=seed_idx_prop/2, labels="seeds")
   axis(2, at=(seed_idx_prop+(1-seed_idx_prop)/2), labels="recruits")
   axis(2, at=seed_idx_prop, labels="")

   ## nuances in the figures above: which ties formed and dissolved or vice versa.
   adj_w1 <- as.matrix(adj_w1)
   adj_w2 <- as.matrix(adj_w2)
   
   length(which(adj_w1 == 1))/2 #as expected, 2800 ties
   length(which(adj_w2 == 1))/2 #as expected, 3301 ties
   
   formed <- intersect(which(adj_w1 == 0), which(adj_w2 == 1))
   dissolved <- intersect(which(adj_w1 == 1), which(adj_w2 == 0)) 
   persisted <- intersect(which(adj_w1 == 1), which(adj_w2 == 1))
   never_existed <- intersect(which(adj_w1 == 0), which(adj_w2 == 0))

   length(formed)+length(dissolved)+length(persisted)+length(never_existed) == (266^2)

   length(dissolved)/2
   length(formed)/2
   length(persisted)/2
   length(never_existed)/2      

## save image
save.image(file="r0_nets_obtain_com_respondents_w_svy_data.RData")


  
