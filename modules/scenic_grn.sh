#!/bin/bash
#
# =============================================================================
# Job Script
# =============================================================================

#SBATCH --job-name=pyscenic_grn
#SBATCH --export=ALL
#SBATCH --no-requeue
#SBATCH --output=pyscenic_output.txt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=128GB
#SBATCH --time=01:00:00
#SBATCH --mail-user=mx.lab@hotmail.fr
#SBATCH --mail-type=ALL
#SBATCH -o serial_test_%j.log

source ~/miniconda3/etc/profile.d/conda.sh

# Activate the environment
conda activate myenv

# Set working directory
cd $HOME/scenic

# File paths
f_loom_path_scenic="./data/ASC_scenic_count.loom"
f_tfs="./data/allTFs_mm.txt"

# Run pySCENIC command
pyscenic grn $f_loom_path_scenic $f_tfs -o ./results/adj.csv --num_workers 20