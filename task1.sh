#!/bin/bash 


cd /data/leuven/343/vsc34319/MNM_interview/MNM-interview
conda activate samtools

samtools index miniMNM00065.bam
samtools view -h miniMNM00065.bam 1 > miniMNM00065.chr1.bam
samtools sort -n miniMNM00065.chr1.bam -o miniMNM00065_chr1_sorted.bam

samtools fastq -@ 4 miniMNM00065_chr1_sorted.bam \
    -1 miniMNM00065_chr1_R1.fastq.gz \
    -2 miniMNM00065_chr1_R2.fastq.gz
	
	
conda activate bwa

bwa aln -t 4 /data/leuven/343/vsc34319/reference/hg38bwaidx miniMNM00065_chr1_R1.fastq.gz > miniMNM00065_chr1_R1.sai
bwa aln -t 4 /data/leuven/343/vsc34319/reference/hg38bwaidx miniMNM00065_chr1_R2.fastq.gz > miniMNM00065_chr1_R2.sai

bwa sampe /data/leuven/343/vsc34319/reference/hg38bwaidx \
miniMNM00065_chr1_R1.sai miniMNM00065_chr1_R2.sai \
miniMNM00065_chr1_R1.fq.gz miniMNM00065_chr1_R2.fq.gz > miniMNM00065_chr1_12_pe.sam


conda activate samtools

samtools view -bT /data/leuven/343/vsc34319/reference/hg38.fa miniMNM00065_chr1_12_pe.sam > miniMNM00065_chr1_pe.bam

samtools sort -O bam -o miniMNM00065_chr1_pe.sorted.bam -T temp miniMNM00065_chr1_pe.bam

samtools index miniMNM00065_chr1_pe.sorted.bam