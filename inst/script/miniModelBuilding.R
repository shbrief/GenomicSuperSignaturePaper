## Create mini datasets for testthat
out.dir <- "~/data2/PCAGenomicSignatures/inst/extdata/test_model_building"


##### Select colon-associated datasets #########################################
dir <- system.file("extdata", package = "PCAGenomicSignatures")
load(file.path(dir, "MeSH_terms_1399refinebio.rda"))
ind <- grep("colon|colorectal", mesh_table$name, ignore.case= TRUE)   # 70 studies
colon_studies <- mesh_table$identifier[ind]

## 26 keyword containing studies were used for PCAmodel_536
studyMeta <- read.table(file.path(dir, "studyMeta.tsv"))
colon_studyMeta <- studyMeta[(studyMeta$studyName %in% colon_studies &
                                studyMeta$PCAmodel_536 == TRUE),]

## Based on the study title, I manually selected 6 colon cancer related studies, which
## include not only the patient samples but also cell lines, organoids, etc.
colon_studies_curated <- c("SRP029880", "SRP065317", "SRP068591", "SRP087576", "SRP123604", "SRP144495")
# colon_studyMeta$title[which(colon_studyMeta$studyName %in% colon_studies_curated)] # selected study title
colon_studyMeta_curated <- colon_studyMeta[which(colon_studyMeta$studyName %in% colon_studies_curated),]


in.dir <- "/nobackup/16tb_b/GenomicSignatures/refinebio/rna_seq_v2"
colonStudies <- colon_studyMeta_curated$studyName

##### 05_PCA.R #################################################################
n <- 20   # The number PCs to keep
dir2 <- system.file("extdata", package = "PCAGenomicSignaturesPaper")
cg <- readRDS(dir2, "topGenes_13934.rds")
trainingDatasets <- "test"

## An empty list for PCA results (rotation and variance)
trainingData_PCA <- vector("list", length(colonStudies))
names(trainingData_PCA) <- colonStudies

## Caluclate sd and mean across all the samples
allSamples <- data.frame(matrix(NA, nrow = length(cg)))
rownames(allSamples) <- cg
iter <- 0

for (study in colonStudies) {
  dir.path <- file.path(in.dir, study)
  x <- data.table::fread(file.path(dir.path, paste0(study, "_count.csv")),
                         showProgress = FALSE)
  x <- data.frame(x[,-1], row.names = x$V1) %>% as.matrix
  iter <- iter + 1
  allSamples <- cbind(allSamples, x[cg,])
}

allSamples <- allSamples[,-1]
s <- apply(allSamples, 1, sd)
m <- apply(allSamples, 1, mean)
SdMean <- list(sd = s, mean = m)
fname <- paste0(trainingDatasets, "_", iter, "study")

saveRDS(SdMean, file.path(out.dir, paste0(fname, "_SdMean.rds")))   # sd and mean
saveRDS(allSamples, file.path(out.dir, paste0(fname, ".rds")))   # matrix contaiing all samples

## Remove non-expressing genes in all samples (m == 0)
non_exp <- which(s == 0) %>% names
s <- s[!names(s) %in% non_exp]
m <- m[!names(m) %in% non_exp]

##### PCA ######################################################################
for (study in colonStudies) {
  dir.path <- file.path(in.dir, study)
  x <- data.table::fread(file.path(dir.path, paste0(study, "_count.csv")),
                         showProgress = FALSE)
  x <- data.frame(x[,-1], row.names = x$V1) %>% as.matrix
  x <- x[cg,,drop=FALSE]

  # Remove non-expressing genes in all samples (m == 0)
  x <- x[!rownames(x) %in% non_exp,]

  # This part will be used if any sample is removed upon filtering
  if (ncol(x) <= 20) {
    print(paste(study, "has only", ncol(x), "samples after filtering."))
    next
  }

  # Normalization
  x <- sweep(x, 1, m)
  x <- sweep(x, 1, s, "/")

  # PCA
  pca_res <- prcomp(t(x))
  trainingData_PCA[[study]]$rotation <- pca_res$rotation[,1:n]
  colnames(trainingData_PCA[[study]]$rotation) <- paste0(study, ".PC", c(1:n))
  eigs <- pca_res$sdev^2
  pca_summary <- rbind(SD = sqrt(eigs),
                       Variance = eigs/sum(eigs),
                       Cumulative = cumsum(eigs)/sum(eigs))
  trainingData_PCA[[study]]$variance <- pca_summary[,1:n]
  colnames(trainingData_PCA[[study]]$variance) <- paste0(study, ".PC", c(1:n))

  rm(x)
}

fname <- paste0(trainingDatasets, "_PCs_rowNorm.rda")
save(trainingData_PCA, file = file.path(out.dir, fname))


##### 06_Clustering.R ##########################################################
library(PCAGenomicSignatures)
library(factoextra)

## Combine all PCs
allZ_list <- lapply(trainingData_PCA, function(x) x$rotation)
allZ <- Reduce(cbind, allZ_list)   # 13,934 genes x 120 PCs
all <- t(allZ)   # a matrix of PCs (row) x genes (column)
save(allZ, file = file.path(out.dir, "test_allZ.rda"))

## Calculate distance
res.dist <- factoextra::get_dist(all, method = "spearman")
save(res.dist, file = file.path(out.dir, "test_res_dist.rda"))

## Cut the tree
res.hcut <- factoextra::hcut(res.dist, k = round(nrow(all)/2.25,0), hc_func = "hclust",
                             hc_method = "ward.D", hc_metric = "spearman")
save(res.hcut, file = file.path(out.dir, "test_res_hcut.rda"))

## Build avgLoading
trainingData_PCclusters <- buildAvgLoading(t(all), cluster = res.hcut$cluster)

## Silhouette Width
cl <- trainingData_PCclusters$cluster
silh_res <- cluster::silhouette(cl, res.dist)
cl_silh_width <- summary(silh_res)$clus.avg.widths
trainingData_PCclusters$sw <- cl_silh_width  # add silhouette width to the result

## Save
fname <- paste0(trainingDatasets, "_PCclusters.rda")
save(trainingData_PCclusters, file = file.path(out.dir, fname))


##### 07_Final_Model.R #########################################################
library(PCAGenomicSignatures)
library(dplyr)

note <- "6 colon cancer related studies/ top 20 PCs/ same genes as PCAmodel_536/ GSEA with MSigDB C2.all"
annotGeneSets <- "C2"

## Variance Explained from PCA result
pca_summary <- list()
for (i in seq_along(trainingData_PCA)) {
  pca_summary[[i]] <- trainingData_PCA[[i]]$variance
  names(pca_summary)[i] <- names(trainingData_PCA)[i]
}

## MeSH terms
x <- mesh_table
MeSH_freq <- table(x$name) %>% sort(., decreasing = TRUE) # freq. of each term
for (i in 1:nrow(x)) {x$bagOfWords[i] <- MeSH_freq[x$name[i]]} # add freq. to the main table

x$score <- as.numeric(x$score) # Order based on the score
x <- x[order(x$score, decreasing = TRUE),]
unique_id <- unique(x$identifier) # 1398 studies in the given table

# Split MeSH term table to a list of each study, `all_MeSH`
all_MeSH <- vector("list", length(unique_id))
names(all_MeSH) <- unique_id
for (study in unique_id) {
  ind <- grepl(study, x$identifier)
  all_MeSH[[study]] <- x[ind, c("score", "identifier", "name", "explanation", "bagOfWords")]
}
trainingData_MeSH <- all_MeSH[colonStudies]

##### Build PCAGenomicSignatures object ########################################
PCAmodel <- PCAGenomicSignatures(assays = list(model = as.matrix(trainingData_PCclusters$avgLoading)))
metadata(PCAmodel) <- trainingData_PCclusters[c("cluster", "size", "k", "n")]
names(metadata(PCAmodel)$size) <- paste0("PCcluster", seq_len(ncol(PCAmodel)))
studies(PCAmodel) <- trainingData_PCclusters$studies
silhouetteWidth(PCAmodel) <- trainingData_PCclusters$sw
metadata(PCAmodel)$MeSH_freq <- MeSH_freq
trainingData(PCAmodel)$PCAsummary <- pca_summary
mesh(PCAmodel) <- trainingData_MeSH
updateNote(PCAmodel) <- note

## GSEA
library(PCAGenomicSignatures)
library(msigdbr) # packageVersion("msigdbr") was '7.1.1'
library(clusterProfiler)

out_dir <- file.path(out.dir, "test_gsea_c2")
if (!dir.exists(out_dir)) {dir.create(out_dir)}

msigdbr_df <- msigdbr(species = "Homo sapiens", category = "C2")
term2gene <- msigdbr_df %>% dplyr::select(gs_name, human_gene_symbol) %>% as.data.frame()

for (i in seq_len(ncol(PCAmodel))) {
  fname <- paste0("gsea_", i, ".rds")
  fpath <- file.path(out_dir, fname)

  if (file.exists(fpath)) {next}

  geneList <- model(PCAmodel)[,i]
  geneList <- sort(geneList, decreasing = TRUE)
  res <- clusterProfiler::GSEA(geneList, TERM2GENE = term2gene, pvalueCutoff = 0.05)
  saveRDS(res, fpath)
}

dir <- system.file("scripts", package = "PCAGenomicSignatures")
source(file.path(dir, "searchPathways.R"))  # load the function

gsea_all <- searchPathways(PCAmodel, out_dir)
gsea(PCAmodel) <- gsea_all

## Save
fname <- paste0(trainingDatasets, "_PCAmodel_", annotGeneSets, ".rda")
save(PCAmodel, file = file.path(out.dir, fname))
