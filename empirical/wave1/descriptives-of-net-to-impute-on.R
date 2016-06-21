## Simulate from fitted ergm object
   rm(list=ls())

   ## libraries
   library(ergm)
   library(network)
   library(sna)
   
   ## data
   load("dyad-ind-model/fitted_ergm_imputed_network.RData")
   node_data <- read.csv("/project/khanna7/Projects/UConnect/UConnect_FB/FB_W1_Identified_4.15.2015/fb_graph_nodes.csv")

   ## save network for use in futire analyses
   saveRDS(w1.net.deg.greq.30, file="r0-net-for-885-nodes.RDS")

   ## descriptives
   w1.net.deg.greq.30
   list.vertex.attributes(w1.net.deg.greq.30)

   vnames <- w1.net.deg.greq.30 %v% "vertex.names"
   rds_seeds <- which(substr(vnames, 1, 4) == "1111")
   rds_recruits <- which(substr(vnames, 1, 4) == "2222")


   el <- as.edgelist(w1.net.deg.greq.30)
   resp_resp_ties_id1 <- union(which(el[,1] %in% rds_seeds),
                               which(el[,1] %in% rds_recruits))
   resp_resp_ties_id2 <- union(which(el[,2] %in% rds_seeds),
                               which(el[,2] %in% rds_recruits))
   resp_resp_ties <- intersect(resp_resp_ties_id1,
                               resp_resp_ties_id2)

   resp_resp_el <- el[resp_resp_ties,]
   dim(resp_resp_el)
   nrow(el) - nrow(resp_resp_el)

   ## individual level attributes
   
      ## read data
      list.vertex.attributes(w1.net.deg.greq.30)
      node_id_in_full_data <- which(node_data$id %in% (w1.net.deg.greq.30%v%"vertex.names"))
      imp_nodes_data <- node_data[node_id_in_full_data,]
      dim(imp_nodes_data)
   
      ## summarize data
      colnames(imp_nodes_data)
      seeds <- which(substr(imp_nodes_data$id, 1 ,4) == "1111")
      recruits <- which(substr(imp_nodes_data$id, 1 ,4) == "2222")
      respondents <- c(seeds, recruits)
   
      respondent_data <- imp_nodes_data[respondents,]
      alter_data <- imp_nodes_data[-respondents,]
      
      dim(respondent_data)
      dim(alter_data)
   
      ## compute metrics
         colnames_data <- as.data.frame(colnames(imp_nodes_data))
         ## age
         summary(imp_nodes_data$fb_age, exclude=NULL)
         summary(respondent_data$fb_age, exclude=NULL)
         summary(alter_data$fb_age, exclude=NULL)  
         ## sex
         table(imp_nodes_data$fb_sex, exclude=NULL)
         table(respondent_data$fb_sex, exclude=NULL)
         summary(alter_data$fb_sex, exclude=NULL)
         ## city chicago
         table(imp_nodes_data$fb_city_chicago, exclude=NULL)
         table(respondent_data$fb_city_chicago, exclude=NULL)
         table(alter_data$fb_city_chicago, exclude=NULL)
         ## city
         table(imp_nodes_data$fb_city, exclude=NULL)
         table(respondent_data$fb_city, exclude=NULL)
         respondent_data$fb_city[which(respondent_data$fb_city != "chicago")]         
         table(alter_data$fb_city_chicago, exclude=NULL) 
         
         xtabs(~ factor(respondent_data$fb_city_chicago, exclude=NULL)+
                 factor(respondent_data$fb_state_illinois, exclude=NULL))
         
         xtabs(~ factor(respondent_data$fb_state, exclude=NULL)+
                        factor(respondent_data$fb_city_chicago, exclude=NULL))
   
   ## PrEP know
         table(imp_nodes_data$prepknow2, exclude=NULL)
         table(respondent_data$prepknow2, exclude=NULL)
         table(alter_data$prepknow2, exclude=NULL)    
   ## save

 
