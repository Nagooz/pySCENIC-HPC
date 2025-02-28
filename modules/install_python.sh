#!/bin/bash
#SBATCH --job-name=install_python
#SBATCH --output=install_python_%j.log
#SBATCH --ntasks=1
#SBATCH --time=00:20:00
#SBATCH --mem=4GB

# Set up the installation directory
cd $HOME/local

# Download Python
wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz

# Extract the Python source code
tar -xvf Python-3.10.0.tgz

# Navigate into the Python source directory
cd Python-3.10.0

# Configure the installation
./configure --prefix=$HOME/local/python-3.10.0

# Compile the source code using 4 processors (adjust the -j flag as needed based on your machine's capabilities)
make -j4

# Install Python
make install

# Add the new Python installation to the PATH in .bashrc
echo 'export PATH=$HOME/local/python-3.10.0/bin:$PATH' >> ~/.bashrc

# Source the .bashrc to update the environment variables
source ~/.bashrc

# Confirmation
echo "Python 3.10.0 has been installed and added to the PATH"