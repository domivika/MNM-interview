library(dplyr)
library(vcfR)

setwd("D:/Dominika/mnm_interview")

manta <- "tumor_vs_normal.manta.somatic.vcf" # the file must be unzipped 
pkg <- "pinfsc50"
vcf_file <- system.file("extdata", "pinf_sc50.vcf.gz", package = pkg)
vcf <- read.vcfR( manta, verbose = FALSE )
manta.vcf.df <- cbind(as.data.frame(getFIX(vcf)), INFO2df(vcf))


### 1) I assume I am asked to count non-BND variants... 
manta_no_BND <- manta.vcf.df |> filter(!str_detect(ID, "BND"))  
nrow(manta_no_BND)


### 2) 
manta_DEL <- manta.vcf.df |> filter(str_detect(ID, "DEL"))

#joined boxplot for all SVs
boxplot(as.numeric(as.character(manta.vcf.df$SVLEN))~ as.numeric(as.character(manta.vcf.df$CHROM)), xlab = "Chromosomes", ylab = "SV length")

#boxplots per chromosome
chr_list = split.data.frame(manta_DEL, manta_DEL$CHROM )
lapply(chr_list, function(x){boxplot(as.numeric(as.character(x[,10]))~ as.numeric(as.character(x[, 1])))})  # TODO: xlabs and ylabs must be adjusted


### 3)
manta_FAIL <- manta.vcf.df |> filter(!str_detect(FILTER, "PASS"))
nrow(manta_FAIL)
#tail(names(sort(table(manta_FAIL$FILTER))), 1)  # the most frequent element
pie(table(manta_FAIL$FILTER))


### 4)
manta_max_cipos <- manta.vcf.df[which.max(as.numeric(as.character(gsub(",", ".", manta.vcf.df$CIPOS)))), ]
manta_max_cipos$ID


### 5)
manta.vcf.df[manta.vcf.df$ID == "MantaBND:28842:0:1:0:0:0:0","SVTYPE"]
