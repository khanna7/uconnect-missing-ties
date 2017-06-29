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

## nonrespondent data on raw and imputed networks

resp_deg_dist_data_df_raw_only <- resp_deg_dist_data_df[299:596,]
resp_deg_dist_data_df_raw_only$network <- "raw_&_imputed"
p_resp_deg_dist_raw_only <- ggplot(resp_deg_dist_data_df_raw_only, 
                                   aes(x=frequency,  
                                       color=network))+
  geom_histogram(binwidth=10)+
  xlab("Degrees")+ylab("Number of nodes")+
  scale_x_continuous(breaks=(seq(0, 1200, by=100)))+
  ggtitle("Degree Distribution for Respondents")+
  scale_color_manual(values=c("#00BFC4"))+
  theme_minimal()

p_nonresp_deg_dist <- ggplot(nonresp_deg_dist_data_df, 
                             aes(x=frequency,  
                                 color=network))+
  geom_histogram(binwidth=10)+
  xlab("Degrees")+ylab("Number of nodes")+
  scale_x_continuous(breaks=(seq(0, 1200, by=100)))+
  ggtitle("Degree Distribution for Nonrespondents")+
  theme_minimal()

png(file="raw_and_imputed_deg_dist.png")
grid.arrange(p_resp_deg_dist_raw_only, p_nonresp_deg_dist, nrow=2)
dev.off()
