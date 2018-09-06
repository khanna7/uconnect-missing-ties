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
resp_deg_dist_data_df[,2] <- c(rep("Raw", 298), rep("Imputed", 298))                                                           
colnames(resp_deg_dist_data_df) <- c("Frequency", "Network")

resp_deg_dist_data_df$Network <- as.factor(resp_deg_dist_data_df$Network)
levels(resp_deg_dist_data_df$Network) <- rev(levels(resp_deg_dist_data_df$Network))

resp_deg_dist_data_df_raw_only <- resp_deg_dist_data_df[299:596,]
resp_deg_dist_data_df_raw_only$Network <- "Observed_and_imputed"
p_resp_deg_dist_raw_only <- 
  ggplot(resp_deg_dist_data_df_raw_only, 
                                   aes(x=Frequency,  
                                       color=Network))+
  geom_histogram(binwidth=10, aes(y=..count../sum(..count..)*100))+
  xlab("Degrees")+ylab("% of nodes")+
  scale_x_continuous(breaks=(seq(0, 600, by=100)))+
  scale_y_continuous(breaks=seq(0, 30, 5))+
  ggtitle("Degree distribution for respondents")+
  scale_color_manual(values=c("#00BFC4"))+
  theme_minimal()

## nonrespondent data on raw and imputed Networks
nonresp_deg_dist_data <- as.data.frame(c(r0_net_degrees_nonrespondents, 
                                      imp_net_degrees_nonrespondents))
nonresp_deg_dist_data_df <- as.data.frame(nonresp_deg_dist_data)
nonresp_deg_dist_data_df[,2] <- c(rep("Observed", 587), rep("Imputed", 587))                                                           
colnames(nonresp_deg_dist_data_df) <- c("Frequency", "Network")

p_nonresp_deg_dist <- ggplot(nonresp_deg_dist_data_df, 
                             aes(x=Frequency,  
                                 color=Network))+
  geom_histogram(binwidth=10, aes(y=..count../sum(..count..)*100))+
  xlab("Degrees")+ylab("% of nodes")+
  scale_x_continuous(breaks=(c(seq(0, 30, 30), seq(100, 600, by=100))))+
  scale_y_continuous(breaks=seq(0, 30, 5))+
  ggtitle("Degree distribution for nonrespondents")+
  theme_minimal()

png(file="raw_and_imputed_deg_dist.png", width = 7, height = 7, 
    units = 'in', res = 1200)
grid.arrange(p_resp_deg_dist_raw_only, p_nonresp_deg_dist, nrow=2)
dev.off()

## save
save.image(file="deg-dis.RData")
