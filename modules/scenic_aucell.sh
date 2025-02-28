#!/bin/bash
#
# =============================================================================
# Job Script
# =============================================================================

#SBATCH --job-name=pyscenic_aucell
#SBATCH --export=ALL
#SBATCH --no-requeue
#SBATCH --output=pyscenic_output.txt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
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
f_pyscenic_output="./results/pyscenic_output.loom"

# Run pySCENIC command
pyscenic aucell \
    $f_loom_path_scenic \
    ./results/reg.csv \
    --output $f_pyscenic_output \
    --num_workers 8
