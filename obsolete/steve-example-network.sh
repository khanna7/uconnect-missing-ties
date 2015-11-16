#!/bin/sh

#SBATCH --nodes=20
#SBATCH --output="steve-example-n1e3.out"
#SBATCH --exclusive

# Always use -n 1 for the Rmpi package. It spawns additional processes dynamically
R CMD BATCH imputation-steve-network.R
