# pySCENIC-HPC: Adaptation de PySCENIC pour HPC avec Nextflow

## Description
Ce dépôt contient une adaptation du code `pySCENIC` pour l'exécution **sur un cluster HPC sans utiliser Docker ou Singularity**. Le projet est configuré pour être exécuté via Nextflow pour gérer l'exécution des différentes étapes de l'analyse. L'objectif est de permettre l'exécution de pySCENIC sur des ressources de calcul à grande échelle, tout en restant compatible avec des systèmes sans conteneurs.

## Prérequis
+ Nextflow installé sur votre machine ou sur le système HPC
+ Un environnement Python configuré via Miniconda ou Anaconda (voir `requirements.txt`)
+ Accès à un cluster HPC avec les ressources nécessaires pour l'exécution des analyses

## Structure du Répertoire
Voici un aperçu de la structure du projet et de ce que contient chaque répertoire :

### `data/`
Ce répertoire contient les fichiers de données nécessaires pour exécuter pySCENIC :

+ `allTFs_mm.txt` : Liste des facteurs de transcription
+ `ASC.h5ad` : Données de single-cell au format `Anndata`
+ `ASC_scenic_count.loom` : Données de single-cell au format `loom`
+ `motifs-v9-nr.mgi-m0.001-o0.0.tbl` : Table des motifs régulateurs
+ `*.feather` : Scores des motifs régulateurs 

### `env/`
Ce répertoire contient les fichiers nécessaires pour configurer l'environnement Python et les dépendances :

+ `requirements.txt` : Liste des dépendances Python nécessaires

### `modules/`
Les modules contiennent des scripts et des notebooks pour exécuter différentes parties du pipeline pySCENIC :

+ `download_aux_datasets.sh` : Script pour télécharger les datasets auxiliaires pour l'analyse (`allTFs_mm.txt`, `motifs-v9-nr.mgi-m0.001-o0.0.tbl`, `*.feather`)
+ `Seurat_to_Anndata.Rmd` , `Anndata_loom_file.ipynb` : Notebooks pour convertir des objets Seurat en objets Anndata et en format loom
+ `install_miniconda.sh` , `install_python.sh` : Script pour installer python v3.10 et miniconda
+ `environment_setup.sh` : Script pour configurer l'environnement de travail
+ `scenic_aucell.sh`, `scenic_ctx.sh`, `scenic_grn.sh` : Scripts pour exécuter différentes étapes de l'analyse (AUCELL, SCENIC, GRN)

### `scripts/`
Les scripts nécessaires pour exécuter le pipeline avec Nextflow et soumettre les tâches au cluster HPC :

+ `nextflow.config` : Configuration pour Nextflow, spécifiant les ressources à utiliser pour chaque étape du pipeline
+ `pyscenic_pipeline.nf` : Le pipeline Nextflow principal qui orchestre l'exécution des étapes
+ `submit_pyscenic_pipeline.sh` : Script pour soumettre le pipeline Nextflow au cluster HPC

### `results/`
Ce répertoire contient les résultats générés par le pipeline pySCENIC :

+ Fichiers `.loom` et `.csv` générés après l'analyse avec pySCENIC

## Installation
1. Cloner le dépôt :
```bash
git clone https://github.com/Nagooz/pySCENIC-HPC.git
cd pySCENIC-HPC
```
2. Installer Miniconda (si nécessaire) : Si vous n'avez pas Miniconda, exécutez le script pour l'installer :
```bash
./modules/install_miniconda.sh
```
3. Mettre en place l'environnement : Vous pouvez créer un environnement Conda et installer les dépendances nécessaires avec le fichier `requirements.txt` :
```bash
./modules/environment_setup.sh
```
4. Configurer Nextflow : Assurez-vous d'avoir Nextflow installé sur votre machine ou votre environnement HPC :
```bash
curl -s https://get.nextflow.io | bash
```

## Utilisation
1. Configurer les ressources HPC (facultatif) : Si nécessaire, ajustez le fichier `nextflow.config` pour configurer les ressources (mémoire, CPU, etc.) pour chaque étape du pipeline.

2. Exécuter le pipeline Nextflow : Une fois l'environnement configuré, vous pouvez exécuter le pipeline avec Nextflow en utilisant la commande suivante :
```bash
nextflow run pyscenic_pipeline.nf -c nextflow.config
```
Si vous devez soumettre le pipeline à un système de gestion de tâches HPC, vous pouvez utiliser le script de soumission :
```bash
./scripts/submit_pyscenic_pipeline.sh
```
4. Résultats : Les résultats seront stockés dans le répertoire `results/` sous forme de fichiers `.loom` et `.csv`.

## Exemple de Pipeline
Voici un exemple d'exécution d'une étape avec Nextflow sur un cluster HPC :
```bash
sbatch submit_pyscenic_pipeline.sh
```
