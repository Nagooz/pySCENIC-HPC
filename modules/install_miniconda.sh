#!/bin/bash
#SBATCH --job-name=install_miniconda
#SBATCH --output=install_miniconda_%j.log
#SBATCH --ntasks=1
#SBATCH --time=00:20:00
#SBATCH --mem=4GB

# Set up the installation directory
cd $HOME/local

# Download the Miniconda installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Verify the checksum (this step is optional but recommended for security)
sha256sum Miniconda3-latest-Linux-x86_64.sh

# Run the Miniconda installer
bash Miniconda3-latest-Linux-x86_64.sh 

# Initialize conda and update the shell configuration
echo 'export PATH="$HOME/local/miniconda3/bin:$PATH"' >> ~/.bashrc

# Source .bashrc to make conda available immediately
source ~/.bashrc

# Check the installed version of conda
conda --version

# Confirmation
echo "Miniconda installation complete. Conda version: $(conda --version)"