#!/bin/sh

#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --output="parallel-20.out"

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript r-parallel.R
