#!/bin/bash
#SBATCH --job-name=download_db_feather
#SBATCH --output=download_db_feather_%j.log
#SBATCH --ntasks=1
#SBATCH --time=00:20:00
#SBATCH --mem=4GB

feather_database_urls=(
    'https://resources.aertslab.org/cistarget/databases/mus_musculus/mm9/refseq_r45/mc9nr/gene_based/mm9-500bp-upstream-7species.mc9nr.genes_vs_motifs.rankings.feather'
    'https://resources.aertslab.org/cistarget/databases/mus_musculus/mm9/refseq_r45/mc9nr/gene_based/mm9-tss-centered-5kb-7species.mc9nr.genes_vs_motifs.rankings.feather'
    )

# Loop through the list and download each feather database
for url in "${feather_database_urls[@]}"; do
  echo "Downloading $url..."
  wget "$url" -P ./data
done

echo "All downloads complete!"