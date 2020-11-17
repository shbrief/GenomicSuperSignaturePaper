#' Build synthetic datasets as negative controls to decide the optimum culster number
#'
#' Process:
#' 1. Generate 50 synthetic datasets:
#'    - Each dataset contains 50 random samples from 44,890 samples (with replacement).
#'    - Scaramble genes in each dataset by random selection without replacement and
#'    add random value between -0.1 and 0.1
#' 2. Row-normalize synthetic datasets
#' 3. PCA on synthetic datasets --> `bootstrap_PCs_rowNorm_Neg.rds`
#' 4. Combine top 20 PCs from traning datasets and PC1s from synthetic datasets --> `all_{#neg}.rds`
#' 5. Calculate distance matrix and hcut for each combined dataset --> `res_dist_{#neg}.rds` and `res_hclust_{#neg}.rds`
#' 6. Evaluate how the negative controls were separated --> `evals_{#neg}.rds` and `eval_summary_{#neg}.rds`




suppressPackageStartupMessages({
    library(dplyr)
})

##### Load 536 refine.bio datasets #############################################
wd <- "~/data2/GenomicSuperSignatureLibrary/refinebioRseq/PCAmodel_536"
allZ <- readRDS(file.path(wd, "allZ.rds"))   # genes x 44,890 samples
genes <- readRDS("~/data2/model_building/data/topGenes_13934.rds")   # top 13,934 genes
stat <- readRDS(file.path(wd, "refinebioRseq_536study_SdMean.rds"))
s <- stat$sd
m <- stat$mean
numOfDatasets <- c(10, 20, 30, 40, 50)
n <- numOfTopPCs <- 20






##### Synthetic 'experiment' from random sample selectiong #####################
fname <- paste0("Neg_", 1:50)
synData <- vector("list", length(fname))
names(synData) <- fname

set.seed(1234)
for (i in seq_along(fname)) {
    dataName <- fname[i]
    scrambled <- allZ[, sample(ncol(allZ), 50, replace = TRUE)] # randomly select 50 samples
    for (j in 1:50) {
        # scramble genes for each sample in the synthetic dataset
        scrambled[,j] <- scrambled[sample(nrow(allZ), replace = FALSE), j] +
            runif(nrow(allZ), min = -0.1, max = 0.1)
        rownames(scrambled) <- genes
    }
    synData[[dataName]] <- scrambled

}



##### PCA ######################################################################
synData_PCA <- vector("list", length(synData))
names(synData_PCA) <- names(synData)

for (study in names(synData)) {
    x <- synData[[study]]

    # Row normalization
    x <- sweep(x, 1, m)
    x <- sweep(x, 1, s, "/")

    # PCA
    pca_res <- prcomp(t(x))
    synData_PCA[[study]]$rotation <- pca_res$rotation[,1:n]
    colnames(synData_PCA[[study]]$rotation) <- paste0(study, ".PC", c(1:n))
    eigs <- pca_res$sdev^2
    pca_summary <- rbind(SD <- sqrt(eigs),
                         Variance <- eigs/sum(eigs),
                         Cumulative <- cumsum(eigs)/sum(eigs))
    synData_PCA[[study]]$variance <- pca_summary[,1:n]
    colnames(synData_PCA[[study]]$variance) <- paste0(study, ".PC", c(1:n))

    rm(x)
}

dat_dir <- "~/data2/GenomicSuperSignaturePaper/inst/extdata/Neg_Controls"
saveRDS(synData_PCA, file.path(dat_dir, "bootstrap_PCs_rowNorm_Neg.rds"))






##### Distance matrix ##########################################################
dat_dir <- "~/data2/GenomicSuperSignaturePaper/inst/extdata/Neg_Controls"
neg <- readRDS(file.path(dat_dir, "bootstrap_PCs_rowNorm_Neg.rds"))
data <- lapply(neg, function(x) x$rotation) %>% Reduce(cbind,.) %>% t

## Select only PC1s from different number of negative controls
for (numOfDataset in numOfDatasets) {
    ## combine all samples with PC1s from different number of controls
    ind <- c()
    for (i in 1:numOfDataset) {
        new_ind <- c(1) + numOfTopPCs*(i - 1)   # select only PC1s
        ind <- c(ind, new_ind)
    }
    neg_dat <- data[ind,]
    all <- cbind(allZ, t(neg_dat)) %>% t   # combine synData and training data
    saveRDS(all, file.path(dat_dir, paste0("all_", numOfDataset, ".rds")))

    ## calculate distance matrix
    all <- readRDS(file.path(dat_dir, paste0("all_", numOfDataset, ".rds")))
    res.dist <- factoextra::get_dist(all, method = "spearman")
    res.hclust <- stats::hclust(res.dist, method = "ward.D")
    saveRDS(res.dist, file.path(dat_dir, paste0("res_dist_",numOfDataset,".rds")))
    saveRDS(res.hclust, file.path(dat_dir, paste0("res_hclust_",numOfDataset,".rds")))
}





##### Find the minimum number of clusters ######################################
source("evaluateCluster.R")
dat_dir <- "~/data2/GenomicSuperSignaturePaper/inst/extdata/Neg_Controls"
evals <- vector(mode = "list", length = 9)

for (numOfDataset in numOfDatasets) {
    ## Load the target synthetic dataset
    all <- readRDS(file.path(dat_dir, paste0("all_", numOfDataset,".rds")))
    res.dist <- readRDS(file.path(dat_dir, paste0("res_dist_",numOfDataset,".rds")))

    k_range <- c(round(nrow(all)/7,0), round(nrow(all)/6,0), round(nrow(all)/5,0),
                 round(nrow(all)/4,0), round(nrow(all)/3,0), round(nrow(all)/2.75,0),
                 round(nrow(all)/2.5,0), round(nrow(all)/2.25,0), round(nrow(all)/2,0))

    ## Evaluate clustering result
    ## For detail, check the function evaluateCluster
    for (i in seq_along(k_range)) {
        res.hcut <- factoextra::hcut(res.dist, k = k_range[i], hc_funct = "hclust",
                                     hc_method = "ward.D", hc_metric = "spearman")
        eval <- evaluateCluster(res.hcut, controlType = "Neg", hmTable = FALSE)
        evals[[i]] <- eval
    }

    ## `eval_summary` is a data frame with three columns:
    ## numSeparated, sizeOfMaxCluster, and numOfCluster.
    eval_summary <- sapply(evals, function(x) {
        data.frame(numSeparated = sum(x == 1),
                   sizeOfMaxCluster = max(x))
    }) %>% t %>% as.data.frame
    eval_summary$numOfCluster <- k_range

    ## Save
    saveRDS(evals, file.path(dat_dir, paste0("evals_",numOfDataset,".rds")))
    saveRDS(eval_summary, file.path(dat_dir, paste0("eval_summary_",numOfDataset,".rds")))
}
