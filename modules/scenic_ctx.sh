#!/bin/bash
#
# =============================================================================
# Job Script
# =============================================================================

#SBATCH --job-name=pyscenic_ctx
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
f_db_names='./data/mm9-500bp-upstream-7species.mc9nr.genes_vs_motifs.rankings.feather mm9-tss-centered-10kb-7species.mc9nr.genes_vs_motifs.rankings.feather'
f_motif_path="./data/motifs-v9-nr.mgi-m0.001-o0.0.tbl"
f_loom_path_scenic="./data/ASC_scenic_count.loom"

# Run pySCENIC command
pyscenic ctx ./results/adj.csv $f_db_names \
    --annotations_fname $f_motif_path \
    --expression_mtx_fname $f_loom_path_scenic \
    --output ./results/reg.csv \
    --mask_dropouts \
    --num_workers 20
