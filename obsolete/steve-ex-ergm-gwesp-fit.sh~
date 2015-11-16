#!/bin/sh

#SBATCH --ntasks=32
#SBATCH --exclusive

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript model-steve-network.R
