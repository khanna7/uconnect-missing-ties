#!/bin/sh

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --exclusive
#SBATCH --mem-per-cpu=2000

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript fit-ergm-to-imputed-network-gwesp1_wnodemix-base13_in_parallel.R 
