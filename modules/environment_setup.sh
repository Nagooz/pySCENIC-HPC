#!/bin/bash
#SBATCH --job-name=setup_conda_env
#SBATCH --output=setup_conda_env_%j.log
#SBATCH --ntasks=1
#SBATCH --time=00:30:00
#SBATCH --mem=4GB

cd $HOME/scenic

# Activate conda (ensure that Miniconda is already installed via previous script)
source $HOME/local/anaconda3/bin/activate

# Create a new conda environment named 'myenv' with Python 3.10
conda create -n myenv python=3.10 

# Activate the new environment
conda activate myenv

# Install required dependencies from requirements.txt
pip install -r ./env/requirements.txt

# List installed packages to confirm
pip list

# Confirmation
echo "Environment 'myenv' has been set up, and dependencies are installed."