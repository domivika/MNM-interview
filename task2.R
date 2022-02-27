setwd("D:/Dominika/mnm_interview")

manta <- "tumor_vs_normal.manta.somatic.vcf" # the file must be unzipped 

pkg <- "pinfsc50"

vcf_file <- system.file("extdata", "pinf_sc50.vcf.gz", package = pkg)

library(vcfR)
vcf <- read.vcfR( manta, verbose = FALSE )

manta.vcf.df <- cbind(as.data.frame(getFIX(vcf)), INFO2df(vcf))

View(manta.vcf.df)


### 1) I assume I am asked to count non-BND variants... 
manta_no_BND <- manta.vcf.df |> filter(!str_detect(ID, "BND"))  
nrow(manta_no_BND)

### 2) 
manta_DEL <- manta.vcf.df |> filter(str_detect(ID, "DEL"))

#joined boxplot fro all SVs
boxplot(as.numeric(as.character(manta.vcf.df$SVLEN))~ as.numeric(as.character(manta.vcf.df$CHROM)))

#boxplots per chromosome
chr_list = split.data.frame(manta_DEL, manta_DEL$CHROM )
lapply(chr_list, function(x){boxplot(as.numeric(as.character(x[,10]))~ as.numeric(as.character(x[, 1])))} )


### 3)
manta_FAIL <- manta.vcf.df |> filter(!str_detect(FILTER, "PASS"))
nrow(manta_FAIL)
tail(names(sort(table(manta_FAIL$FILTER))), 1)
pie(manta_FAIL)
pie(table(manta_FAIL$FILTER))


### 4)
manta_max_cipos <- manta.vcf.df[which.max(as.numeric(as.character(gsub(",", ".", manta.vcf.df$CIPOS)))), ]
manta_max_cipos


### 5)
manta.vcf.df[manta.vcf.df$ID == "MantaBND:28842:0:1:0:0:0:0","SVTYPE"]

