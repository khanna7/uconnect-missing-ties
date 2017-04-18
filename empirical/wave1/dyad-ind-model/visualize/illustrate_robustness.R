## proportion of respondents selected on imputed networks also selected on raw network
rm(list=ls())

library(ggplot2)
load("../summarize-centrality-results/node-stability-witin-measure-btwn-control-and-imputations.RData")

## order is btwn, EV, bridging, KP
resp_sel_bet_imp_raw <- 
  c(length(resp_sel_in_control_imputed_btwn)/length(resp_btwn_after_cutoff),
    length(resp_sel_in_control_imputed_evcent)/length(resp_evcent_after_cutoff),
    length(resp_sel_in_control_imputed_bridging)/length(resp_bridging_after_cutoff),
    length(resp_sel_in_control_imputed_kp)/length(resp_kp_after_cutoff)
  )

nonresp_sel_bet_imp_raw <- 
  c(length(nonresp_btwn_control_885nodes)/length(nonresp_btwn_after_cutoff),
    length(nonresp_evcent_control_885nodes)/length(nonresp_evcent_after_cutoff),
    length(nonresp_bridging_control_885nodes)/length(nonresp_bridging_after_cutoff),
    length(nonresp_kp_control_885nodes)/length(nonresp_kp_after_cutoff))

robustness_data <- as.data.frame(matrix(NA, nrow=8, ncol=3))

robustness_data[,1] <- c(resp_sel_bet_imp_raw, nonresp_sel_bet_imp_raw)
robustness_data[,2] <- c("Betweenness", "Eigenvector", "Bridging", "Keyplayer")
robustness_data[,3] <- c(rep("Respondent", 4), rep("Nonrespondent", 4))

colnames(robustness_data) <- c("prop", "algorithm", "node")
robustness_data$algorithm <- factor(robustness_data$algorithm, levels=c("Betweenness", "Eigenvector", "Bridging", 
                                                                        "Keyplayer")) #to order nonalphabetically
png(file="robustness.png")
ggplot(robustness_data, aes(x=algorithm, y=prop, fill=node))+
  geom_bar(position="dodge", stat="identity")+
  ylab("Proportion of Agents")+ylab("proportion")
dev.off()
