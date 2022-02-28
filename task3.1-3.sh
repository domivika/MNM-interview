#!/bin/bash 

# task 3.1

cd /data/leuven/343/vsc34319/MNM_interview/MNM-interview/task3

awk 'BEGIN{FS="\t"} $0 ~ /^#/ || $7 == "PASS"{print}' tumor_vs_normal.manta.somatic.vcf > tumor_vs_normal.manta.somatic_PASS.vcf



# task 3.2

conda activate snpEff

snpEff hg19 tumor_vs_normal.manta.somatic_PASS.vcf > tumor_vs_normal.manta.somatic_PASS.ann.vcf



# task 3.3

# print only gene names, variants_impact_HIGH and variants_impact_MODERATE columns
awk 'BEGIN{FS=" "; OFS=" "} $0~/^#/ {next};{print $1,$5,$7}' snpEff_genes.txt > snpeff_genes_cut.txt

# print only the gens that have at least 1 high or moderate possible impact on the protein
awk '$2 != 0 || $3 !=0' snpeff_genes_cut.txt > snpeff_genes_cut_short.txt

# print only unique genes
awk -F" " '!_[$1]++' snpeff_genes_cut_short.txt > snpeff_genes_uniq.txt

# print only gene names
awk '{print $1}' snpeff_genes_uniq.txt > snpeff_genes_impact.txt



# task 3.4

### done in R "task3.4"
