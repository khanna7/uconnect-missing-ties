## MCMC diagnostics for models without edges: gwesp
## with alpha=1 (RData file not produced due to memory error), 
              ##0.5 (RData file not produced due to memory error) and 
              ##2.0 (RData file produced on bigmem nodes)

## libraries and data
   library(ergm)
   library(coda)
   load("fitted_ergm_imputed_network_gwesp2-wo-edges-w-nodecov-respdegin_parallel_wo_mpi.RData")

## mcmc diagnostics
   pdf(file="gwesp2-noedges.pdf")
   mcmc.diagnostics(ergm.imputed_network)
   dev.off()
   
   class(ergm.imputed_network$sample)
   densplot(ergm.imputed_network$sample)

   