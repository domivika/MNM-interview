library(vcfR)
library(dplyr)
library(tidyverse)


setwd("D:/Dominika/mnm_interview")

manta_annotated <- "tumor_vs_normal.manta.somatic_PASS.ann.vcf"

pkg <- "pinfsc50"
vcf_file <- system.file("extdata", "pinf_sc50.vcf.gz", package = pkg)
vcf <- read.vcfR(manta_annotated, verbose = FALSE )

manta_ann_df <- cbind(as.data.frame(getFIX(vcf)), INFO2df(vcf))
manta_LOF <- manta_ann_df |> filter(!str_detect(LOF, "NA"))
manta_LOF_short <- manta_LOF$LOF
manta_LOF_genes <- as.data.frame(manta_LOF_short)  # TODO: extract genes




