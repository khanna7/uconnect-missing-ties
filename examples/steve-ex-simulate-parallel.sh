#!/bin/sh

#SBATCH --ntasks=3
#SBATCH --time=5
#SBATCH --mem-per-cpu=10000

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript simulate-steve-example.R
