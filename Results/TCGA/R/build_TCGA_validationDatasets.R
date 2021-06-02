##### Build `TCGA_validationDatasets.rda` ######################################
dat_dir <- "~/GenomicSuperSignaturePaper/Results_temp/TCGA/data"

##### Raw read counts from GSE62944 from ExperimentHub #########################
tcga <- GSEABenchmarkeR::loadEData("tcga", cache = FALSE, paired = FALSE,
                                   map2entrez = FALSE)

## log2 transformation
assay(tcga$COAD) <- log2(assay(tcga$COAD) + 1)
assay(tcga$BRCA) <- log2(assay(tcga$BRCA) + 1)
assay(tcga$LUAD) <- log2(assay(tcga$LUAD) + 1)
assay(tcga$READ) <- log2(assay(tcga$READ) + 1)
assay(tcga$UCEC) <- log2(assay(tcga$UCEC) + 1)

## EntrezID to gene symbol
library(EnrichmentBrowser)
tcga$COAD <- idMap(tcga$COAD, org = "hsa", from = "ENTREZID", to = "SYMBOL")
tcga$BRCA <- idMap(tcga$BRCA, org = "hsa", from = "ENTREZID", to = "SYMBOL")
tcga$LUAD <- idMap(tcga$LUAD, org = "hsa", from = "ENTREZID", to = "SYMBOL")
tcga$READ <- idMap(tcga$READ, org = "hsa", from = "ENTREZID", to = "SYMBOL")
tcga$UCEC <- idMap(tcga$UCEC, org = "hsa", from = "ENTREZID", to = "SYMBOL")

TCGA_validationDatasets <- vector(mode = "list", length = 5)
names(TCGA_validationDatasets) <- c("COAD", "BRCA", "LUAD", "READ", "UCEC")
TCGA_validationDatasets[[1]] <- tcga$COAD
TCGA_validationDatasets[[2]] <- tcga$BRCA
TCGA_validationDatasets[[3]] <- tcga$LUAD
TCGA_validationDatasets[[4]] <- tcga$READ
TCGA_validationDatasets[[5]] <- tcga$UCEC

## TCGA-OVC dataset from curatedOvarianData
library(curatedOvarianData)
data(TCGA.RNASeqV2_eset)
x <- as(TCGA.RNASeqV2_eset, "SummarizedExperiment")

# apply the same filtering condition as `GSEABenchmarkeR::loadEData`
# (defined under the default argument of `min.cpm`)
# (exclude genes with cpm < 2 in more than half of the samples)
# CPM is depth-normalized counts whereas TPM is length normalized (and
# then normalized by the length-normalized values of the other genes)
rs <- rowSums(assay(x) > 2)
keep <-  rs >= ncol(x) / 2
tcga_ovc <- x[keep,]
TCGA_validationDatasets[["OV"]] <- tcga_ovc

save(TCGA_validationDatasets, file = file.path(dat_dir, "TCGA_validationDatasets.rda"))

##### Normalized log2 TPM from GSE62944 from curatedTCGAData ###################
tcga <- GSEABenchmarkeR::loadEData("tcga", cache = FALSE, paired = FALSE,
                                   mode = "cTD", map2entrez = FALSE)
TCGA_cTD_validationDatasets <- vector(mode = "list", length = 3)
names(TCGA_cTD_validationDatasets) <- c("BRCA", "LUAD", "READ")
TCGA_cTD_validationDatasets[[1]] <- tcga$BRCA
TCGA_cTD_validationDatasets[[2]] <- tcga$LUAD
TCGA_cTD_validationDatasets[[3]] <- tcga$UCEC

save(TCGA_cTD_validationDatasets, file = "~/data2/GenomicSignature/data/TCGA_cTD_validationDatasets.rda")
