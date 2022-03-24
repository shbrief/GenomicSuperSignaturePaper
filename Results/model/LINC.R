##### Build C2 annotation for RAVindex w/o LINC ################################
## LINC
dat_dir <- "~/GSS/GenomicSuperSignatureLibrary/refinebioRseq"
RAVmodel <- readRDS(file.path(dat_dir, "RAVmodel_536/refinebioRseq_RAVmodel_20211207.rds"))
linc_ind <- grep("LINC", rownames(RAVmodel))
RAVmodel <- RAVmodel[-linc_ind,]

out_dir <- file.path(dat_dir, "RAVmodel_536_noLINC/gsea_c2")
if (!dir.exists(out_dir)) {dir.create(out_dir)}

## Load the packages
library(GenomicSuperSignature)
library(clusterProfiler)

## Load the function
dir2 <- system.file("scripts", package = "GenomicSuperSignature")
searchPathways_func <- file.path(dir2, "searchPathways.R")
source(searchPathways_func)

## Input variables
out_dir <- "~/GSS/GenomicSuperSignatureLibrary/refinebioRseq/RAVmodel_536_noLINC"
annotGeneSets <- "C2"
trainingDatasets <- "refinebioRseq"

## GSEA
term2gene <- clusterProfiler::read.gmt("~/Archive/[archive]Genomic_Super_Signature/GSEA/data/c2.all.v7.1.symbols.gmt")
colnames(term2gene) <- c("gs_name", "entrez_gene")

for (i in seq_len(ncol(RAVmodel))) {
    fname <- paste0("gsea_", i, ".rds")
    fpath <- file.path(out_dir, fname)

    geneList <- RAVindex(RAVmodel)[,i]
    geneList <- sort(geneList, decreasing = TRUE)
    res <- clusterProfiler::GSEA(geneList, TERM2GENE = term2gene, pvalueCutoff = 0.05)
    saveRDS(res, fpath)
}

## Add GSEA output to RAVmodel
gsea_dir <- file.path(out_dir, paste0("gsea_", annotGeneSets))  # GSEA C2 DB is saved here
gsea_all <- searchPathways(RAVmodel, gsea_dir)
gsea(RAVmodel) <- gsea_all

## Update metadata
updateNote(RAVmodel) <- "Without non-coding RNA (gene name starts with \"LINC\")"
metadata(RAVmodel)$version <- "1.1.1"

## Save the new RAVmodel
fname <- paste0(trainingDatasets, "_RAVmodel_", annotGeneSets,
                "_", format(Sys.Date(), format="%Y%m%d"),".rds")
saveRDS(RAVmodel, file.path(out_dir, fname))


##### Build PLIERpriors annotation for RAVindex w/o LINC #######################
## LINC
dat_dir <- "~/GSS/GenomicSuperSignatureLibrary/refinebioRseq"
RAVmodel <- readRDS(file.path(dat_dir, "RAVmodel_536/refinebioRseq_RAVmodel_20211207.rds"))
linc_ind <- grep("LINC", rownames(RAVmodel))
RAVmodel <- RAVmodel[-linc_ind,]

out_dir <- file.path(dat_dir, "RAVmodel_536_noLINC/gsea_PLIERpriors")
if (!dir.exists(out_dir)) {dir.create(out_dir)}

## Load the packages
library(GenomicSuperSignature)
library(PLIER)
library(clusterProfiler)

## Load the function
dir2 <- system.file("scripts", package = "GenomicSuperSignature")
searchPathways_func <- file.path(dir2, "searchPathways.R")
source(searchPathways_func)

## Input variables
out_dir <- "~/GSS/GenomicSuperSignatureLibrary/refinebioRseq/RAVmodel_536_noLINC"
annotGeneSets <- "PLIERpriors"
trainingDatasets <- "refinebioRseq"

## GSEA
data(canonicalPathways)
data(bloodCellMarkersIRISDMAP)
data(svmMarkers)
allPaths <- combinePaths(canonicalPathways, bloodCellMarkersIRISDMAP, svmMarkers)

source('~/GSS/GenomicSuperSignature/inst/scripts/gmtToMatrix.R')
term2gene <- matrixToTERM2GENE(allPaths)

for (i in seq_len(ncol(RAVmodel))) {
    fname <- paste0("gsea_", i, ".rds")
    fpath <- file.path(out_dir, paste0("gsea_", annotGeneSets), fname)

    geneList <- RAVindex(RAVmodel)[,i]
    geneList <- sort(geneList, decreasing = TRUE)
    res <- clusterProfiler::GSEA(geneList, TERM2GENE = term2gene, pvalueCutoff = 0.05)
    saveRDS(res, fpath)
}

## Add GSEA output to RAVmodel
gsea_dir <- file.path(out_dir, paste0("gsea_", annotGeneSets))  # GSEA C2 DB is saved here
gsea_all <- searchPathways(RAVmodel, gsea_dir)
gsea(RAVmodel) <- gsea_all

## Update metadata
updateNote(RAVmodel) <- "Without non-coding RNA (gene name starts with 'LINC')"
metadata(RAVmodel)$version <- "1.1.2"

## Save the new RAVmodel
fname <- paste0(trainingDatasets, "_RAVmodel_", annotGeneSets,
                "_", format(Sys.Date(), format="%Y%m%d"),".rds")
saveRDS(RAVmodel, file.path(out_dir, fname))
