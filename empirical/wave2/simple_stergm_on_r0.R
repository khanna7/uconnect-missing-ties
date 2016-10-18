library(intergraph)
library(tergm)
library(network)

load("/project/khanna7/Projects/UConnect/UConnect_FB/w1_w2_com_respondents_from_igraph/prep-awareness-use-and-fb-networks/pu-vs-ba-correct.RData")
load("../wave1/imputed_matrix.RData)

w1.com.resp.w.w2.data.ig
w1.com.resp.w.w2.data.net

w2.com.resp.ig
w2.com.resp.net

## model data longitudinally, without any missing values
temp_r0_net <- list(w1.com.resp.w.w2.data.net, w2.com.resp.net)

## simplest stergm 
r0_stergm <- stergm(temp_r0_net, 
                    formation =~edges,
                    dissolution=~edges,
                    estimate="CMLE"
                    )

