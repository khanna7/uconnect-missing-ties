## mcmc diagnostics for gwesp (maxit = 2)

   rm(list=ls())

   library(network)
   library(ergm)

   ## gwesp (alpha = 1)
      ## maxit = 2
      ## load("fitted_ergm_imputed_network_gwesp1_maxit2.RData")

      ## class(ergm.imputed_network)
      ## mcmc.diagnostics(ergm.imputed_network)

      ## pdf(file="mcmc_diag_gwesp1.pdf")
      ## mcmc.diagnostics(ergm.imputed_network)
      ## dev.off()

      ## ## maxit = 30
      ## load("fitted_ergm_imputed_network_gwesp1_maxit2.RData")

      ## class(ergm.imputed_network)
      ## mcmc.diagnostics(ergm.imputed_network)

      ## pdf(file="mcmc_diag_gwesp1_maxit30.pdf")
      ## mcmc.diagnostics(ergm.imputed_network)
      ## dev.off()

      ## mcmc for gwesp model with nodemix for respondent-nonrespondent mixing
      ## load("fitted_ergm_imputed_network_gwesp1_wnodemix_maxit50.RData")
      ## pdf(file="mcmc_diag_gwesp1_wnodemix_maxit50.pdf")
      ## mcmc.diagnostics(ergm.imputed_network)
      ## dev.off()

      ## mcmc for gwesp model with nodemix for respondent-respondent mixing
         ## model was:    ergm.imputed_network <- ergm(imputed_network ~ edges +
                                 ##                   nodecov('respdeg')+
                                 ##                   gwesp(1, fixed=TRUE)+
                                 ##                   nodemix("respondent", base=c(-2)),
                                 ##                   verbose=TRUE,
                                 ## control=control.ergm(MCMLE.maxit=50)
                                 ## )

         load("fitted_ergm_imputed_network_gwesp1_wnodemix_maxit50.RData")
         pdf(file="mcmc_diag_gwesp1_wnodemix_baseneg2_maxit50.pdf")
         mcmc.diagnostics(ergm.imputed_network)
         dev.off()

      ## mcmc for gwesp model with nodemix for respondent-respondent mixing (base 1): maxit 50
         load("fitted_ergm_imputed_network_gwesp1_wnodemix-base1_maxit50.RData")
         pdf(file="mcmc_diag_gwesp1_wnodemix_base1_maxit50.pdf")
         mcmc.diagnostics(ergm.imputed_network)
         dev.off()

      ## mcmc for gwesp model with nodemix for respondent-respondent mixing (base 1): maxit 15
         ## load("fitted_ergm_imputed_network_gwesp1_wnodemix-base1_maxit15.RData")
         ## pdf(file="mcmc_diag_gwesp1_wnodemix_base1_maxit15.pdf")
         ## mcmc.diagnostics(ergm.imputed_network)
         ## dev.off()

      ## mcmc for gwesp model with nodemix for respondent-respondent mixing (base -2): maxit 15
         load("fitted_ergm_imputed_network_gwesp1_wnodemix-base-neg2_maxit15.RData")
         pdf(file="mcmc_diag_gwesp1_wnodemix_baseneg2_maxit15.pdf")
         mcmc.diagnostics(ergm.imputed_network)
         dev.off()

   ## ## gwesp (alpha = 5)
   ##    ## maxit = 2
   ##    load("fitted_ergm_imputed_network_gwesp5_maxit2.RData")

   ##    pdf(file="mcmc_diag_gwesp5.pdf")
   ##    mcmc.diagnostics(ergm.imputed_network)
   ##    dev.off()

         ## load("fitted_ergm_imputed_network_gwesp1_wnodemix-base3_maxit15-try2.RData")     
         ## pdf(file="mcmc_diag_gwesp_wnodemix-base3-maxit15.pdf")
         ## mcmc.diagnostics(ergm.imputed_network)
         ## dev.off()

         rm(list=ls())
         load("fitted_ergm_imputed_network_gwesp1_wnodemix-base13_maxit15-try2.RData")
         pdf(file="gwesp-nodemix-base13.pdf")
         mcmc.diagnostics(ergm.imputed_network)
         dev.off()

         ## no nodecov model
#          ## edges+gwesp(1, fixed=TRUE)+nodemix("respondent", base=1)
#          rm(list=ls())
#          mod <- readRDS("fitted_ergm_imputed_network_gwesp1_wo-nodecov-respdeg-base1_in_parallel_wo_mpi.RDS")
#          mcmc.diagnostics(mod)
#          sim1 <- simulate(mod, 
#                           control = control.simulate.ergm(MCMC.burnin = 1e6,
#                                                           MCMC.interval = 1e5)
#          )

            load("sim_from_gwesp_no_nodecov.RData")
   