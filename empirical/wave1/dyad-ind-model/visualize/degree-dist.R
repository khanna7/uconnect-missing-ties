rm(list=ls())

suppressPackageStartupMessages(library(sna))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(ggthemes))
suppressPackageStartupMessages(library(gridExtra))

load(file="data_to_plot_nets.RData")

### degree distributions of respondents and nonrespondents
### in the raw and imputed networks

## raw network
r0_net_degrees <- degree(r0_net, gmode="graph")
r0_net_degrees_respondents <- r0_net_degrees[1:298]
r0_net_degrees_nonrespondents <- r0_net_degrees[299:length(r0_net_degrees)]

## selected imputed network
imp_net_degrees <- degree(imp_to_plot, gmode="graph")
imp_net_degrees_respondents <- imp_net_degrees[1:298]
imp_net_degrees_nonrespondents <- imp_net_degrees[299:length(imp_net_degrees)]

## respondent data on raw and imputed network
resp_deg_dist_data <- as.data.frame(c(r0_net_degrees_respondents, 
                                      imp_net_degrees_respondents))
resp_deg_dist_data_df <- as.data.frame(resp_deg_dist_data)
resp_deg_dist_data_df[,2] <- c(rep("raw", 298), rep("imputed", 298))                                                           
colnames(resp_deg_dist_data_df) <- c("frequency", "network")

resp_deg_dist_data_df$network <- as.factor(resp_deg_dist_data_df$network)
levels(resp_deg_dist_data_df$network) <- rev(levels(resp_deg_dist_data_df$network))

resp_deg_dist_data_df_raw_only <- resp_deg_dist_data_df[299:596,]
resp_deg_dist_data_df_raw_only$network <- "observed_&_imputed"
p_resp_deg_dist_raw_only <- 
  ggplot(resp_deg_dist_data_df_raw_only, 
                                   aes(x=frequency,  
                                       color=network))+
  geom_histogram(binwidth=10, aes(y=..count../sum(..count..)*100))+
  xlab("Degrees")+ylab("% of nodes")+
  scale_x_continuous(breaks=(seq(0, 600, by=100)))+
  scale_y_continuous(breaks=seq(0, 30, 5))+
  ggtitle("Degree Distribution for Respondents")+
  scale_color_manual(values=c("#00BFC4"))+
  theme_minimal()

## nonrespondent data on raw and imputed networks
nonresp_deg_dist_data <- as.data.frame(c(r0_net_degrees_nonrespondents, 
                                      imp_net_degrees_nonrespondents))
nonresp_deg_dist_data_df <- as.data.frame(nonresp_deg_dist_data)
nonresp_deg_dist_data_df[,2] <- c(rep("observed", 587), rep("imputed", 587))                                                           
colnames(nonresp_deg_dist_data_df) <- c("frequency", "network")

p_nonresp_deg_dist <- ggplot(nonresp_deg_dist_data_df, 
                             aes(x=frequency,  
                                 color=network))+
  geom_histogram(binwidth=10, aes(y=..count../sum(..count..)*100))+
  xlab("Degrees")+ylab("% of nodes")+
  scale_x_continuous(breaks=(c(seq(0, 30, 30), seq(100, 600, by=100))))+
  scale_y_continuous(breaks=seq(0, 30, 5))+
  ggtitle("Degree Distribution for Nonrespondents")+
  theme_minimal()

png(file="raw_and_imputed_deg_dist.png")
grid.arrange(p_resp_deg_dist_raw_only, p_nonresp_deg_dist, nrow=2)
dev.off()

## save
save.image(file="deg-dis.RData")