#!/bin/bash
# parallel job using 1 processor and runs for 8 hours (max)
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -t 6:00:00
# Execute commands

Rscript --vanilla $arg4/estimate_subjgraph.R $arg1 $arg2 $arg3 $arg4
