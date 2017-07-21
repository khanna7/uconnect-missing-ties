#!/bin/sh

#SBATCH --ntasks-per-node=10
#SBACH --nodes=1
#SBATCH --exclusive
#SBATCH --mem-per-cpu=3200

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript cont_fit-ergm-to-imputed-network-gwesp13_maxit15_in_parallel.R
