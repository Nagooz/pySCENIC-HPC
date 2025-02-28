#!/bin/bash
#
# =============================================================================
# SLURM Job Script for Running Nextflow Pipeline
# =============================================================================

#SBATCH --job-name=pyscenic_pipeline
#SBATCH --output=pyscenic_pipeline_%j.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2    # Only need a few CPUs to launch Nextflow
#SBATCH --mem=4GB            # Minimal memory for Nextflow itself
#SBATCH --time=02:00:00      # Enough time for Nextflow to manage jobs
#SBATCH --mail-user=mx.lab@hotmail.fr
#SBATCH --mail-type=ALL
#SBATCH --partition=normal   # Adjust based on your SLURM cluster

# Load Nextflow with conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate nextflow-env

# You can skip the above if Nextflow is available globally
# (ensure you have 'nextflow' in your PATH)

# Run the Nextflow pipeline
nextflow run pyscenic_pipeline.nf -c nextflow.config