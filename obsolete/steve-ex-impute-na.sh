#!/bin/sh

#SBATCH --nodes=20
#SBATCH --output="steve-example-bignetworkNA.out"
#SBATCH --time=10

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
mpirun -n 1 Rscript imputation-steve-assignNA.R
