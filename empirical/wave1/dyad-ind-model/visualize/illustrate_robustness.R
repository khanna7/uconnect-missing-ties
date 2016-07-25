## proportion of respondents selected on imputed networks also selected on raw network
library(ggplot2)

## order is btwn, EV, bridging, KP
resp_sel_bet_imp_raw <- c(75/75, 68/68, 175/180, 54/103)
nonresp_sel_bet_imp_raw <- c(117/222, 163/231, 62/117, 85/197)

robustness_data <- as.data.frame(matrix(NA, nrow=8, ncol=3))

robustness_data[,1] <- c(resp_sel_bet_imp_raw, nonresp_sel_bet_imp_raw)
robustness_data[,2] <- c("Betweenness", "Eigenvector", "Bridging", "Keyplayer")
robustness_data[,3] <- c(rep("Respondent", 4), rep("Nonrespondent", 4))

colnames(robustness_data) <- c("prop", "algorithm", "node")

png(file="robustness.png")
ggplot(robustness_data, aes(x=algorithm, y=prop, fill=node))+
  geom_bar(position="dodge", stat="identity")+
  ylab("Proportion of Agents")+ylab("proportion")
dev.off()
