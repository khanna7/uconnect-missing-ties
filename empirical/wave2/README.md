Abby_wave2_revised.R
  Reads in facebook data, removes problem nodes, applies boundary condition for nonrespondents, calculates descriptive      statistics for observed network
  
Create_mat_with_na.R	
  Adds na’s to nonrespondent-nonrespondent edges, saves wave1.imputed.mat.rds, wave2.imputed.mat.rds
Fit_ergm_w1_w2.R
  Fits ERGM to imputed matrices, saves fitted_ergm_w1w2.RData
Sim_from_fitted_ergm_w1w2.R
  Simulates missing edges, saves sim_from_fitted_ergm_w1w2.RData
ev_keyplayer.R
  Calculates eigenvector centrality and PCAs on observed networks
ev_keyplayer_imputed.R
  Calculates eigenvector centrality and PCAs on imputed networks
Sim_network_analysis
  Analysis of simulated networks and imputed edges
