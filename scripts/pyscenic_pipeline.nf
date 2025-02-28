#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Define the process for each step
process grn {
    tag "GRN"

    input:
    path loom_file
    path tfs_file
    path output_dir

    output:
    path "$output_dir/adj.csv"

    script:
    """
    echo "Running GRN step..."
    pyscenic grn \$loom_file \$tfs_file -o \$output_dir/adj.csv --num_workers 20
    """
}

process ctx {
    tag "CTX"

    input:
    path db_file
    path motif_file
    path loom_file
    path adj_file
    path output_dir

    output:
    path "$output_dir/reg.csv"

    script:
    """
    echo "Running CTX step..."
    pyscenic ctx \$adj_file \$db_file \$motif_file \$loom_file -o \$output_dir/reg.csv --num_workers 20
    """
}

process aucell {
    tag "AUCELL"

    input:
    path loom_file
    path ctx_file
    path output_dir

    output:
    path "$output_dir/pyscenic_output.loom"

    script:
    """
    echo "Running AUCELL step..."
    pyscenic aucell \$loom_file \$ctx_file -o \$output_dir/pyscenic_output.loom --num_workers 20
    """
}


// Workflow definition
workflow {
    // Define file paths
    loom_file = "./data/ASC_scenic_count.loom"
    tfs_file = "./data/allTFs_mm.txt"
    output_dir = "./results"
    db_file="./data/mm9-500bp-upstream-7species.mc9nr.genes_vs_motifs.rankings.feather mm9-tss-centered-10kb-7species.mc9nr.genes_vs_motifs.rankings.feather"
    motif_file="./data/motifs-v9-nr.mgi-m0.001-o0.0.tbl"

    // Run the processes sequentially
    adj_file = grn(loom_file, tfs_file, output_dir)
    ctx_file = ctx(loom_file, db_file, motif_file, adj_file, output_dir)
    aucell_file = aucell(loom_file, ctx_file, output_dir)

    // Print completion message
    println "All steps completed successfully."
}