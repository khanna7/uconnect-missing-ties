## illustrate the problem at hand

rm(list=ls())
## Visualize heatmap for imputed graphs
  prob_mat <- matrix(0, nrow=2, ncol=2)
  #prob_mat[2,2] <- 1.5
  dim(prob_mat)

png("problem-illuz.png", width = 7, height = 7, 
    units = 'in', res = 1200)

  image(prob_mat, col=gray(1), xaxt="n", yaxt="n")
  axis(1, at=c(0, 0.5, 1.0), labels=c("Respondents (n=298)", "", "Nonrespondents (n=182,998)"))
  axis(2, at=c(0, 0.5, 1.0), labels=c("Respondents", "", "Nonrespondents"))
  abline(h=0.5, v=0.5)
  abline(v=c(-0.5, 1.5), h=c(-0.5, 1.5))
  text(0, 0, "Observed")
  text(0, -0.15, paste0("n~44K"))
  text(1, 0, "Observed")
  text(1, -0.15, paste0("n~54M"))
  text(0, 1, "Observed")
  text(0, 0.85, paste0("n~54M"))
  text(1,1, "Unobserved")
  text(1, 0.85, paste0("n~17B"))

dev.off()

  