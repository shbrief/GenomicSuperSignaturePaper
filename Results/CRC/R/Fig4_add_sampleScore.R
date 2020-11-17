library(Biobase)
library(tidyverse)
library(GenomicSuperSignature)
library(GenomicSuperSignaturePaper)

### Load validation samples ----------------------------------------------------
wd <- "Results/CRC/data/eSets"
load(file.path(wd, "setNames.RData"))
## CRC paper actually used both training and validation datasets (total of 18),
## for Figure 4. So here, we are using all of them. However, for Figure 4C, we'll
## try to use only 10 validation datasets.
# load(file.path(wd, "trainingSetNames.RData"))
# validationSetNames <- setdiff(setNames, trainingSetNames)

for (set in setNames) {
  load(paste0(wd, "/new/", set, ".RData"))
}

# Create output directory
out.dir <- paste0(wd, "_new")
if (!dir.exists(out.dir)) {dir.create(out.dir)}

### RAVmodel -------------------------------------------------------------------
data.dir <- system.file("extdata", package = "GenomicSuperSignaturePaper")
RAVmodel <- readRDS(file.path(data.dir, "RAVmodel_C2.rds"))

### Load average loadings ------------------------------------------------------
# Most similar to PCSS1/PCSS2 : 1575 & 834
sampleScore1 <- 1575
sampleScore2 <- 834
# Best validation scores overall on CRC validation datasets : 832 & 188
sampleScore3 <- 832
sampleScore4 <- 188
# CMS-associated : 833 & 834
sampleScore5 <- 833
# Clinial data associated : 3290(stage) & 596(grade)
sampleScore6 <- 3290
sampleScore7 <- 596

## For faster computing, we used the 7 candidates RAVs instead of the whole model.
cl_ind <- c(sampleScore1, sampleScore2, sampleScore3,
            sampleScore4, sampleScore5, sampleScore6, sampleScore7)
avg_loadings <- model(RAVmodel)[,cl_ind]

### Calculate score by RAVmodel ------------------------------------------------
for (set in setNames) {
  eSet <- get(set)
  score <- calculateScore(eSet, avg_loadings, rescale.after = TRUE)  # calculate score from selected RAVs
  colnames(score) <- paste0("RAV", cl_ind)

  pdata <- pData(eSet)
  pdata[, paste0("RAV", cl_ind)] <- score  # add score to the pData of each ExpressionSet
  pData(eSet) <- pdata

  assign(x = set, value = eSet)
  save(list = set, file = file.path(out.dir, paste0(set, '.RData')))  # save updated eSets
}

### Summarize output for plotting ----------------------------------------------
for (set in setNames) {
  load(out.dir, paste0(set, '.RData'))
}

df.results <- lapply(setNames, function(set) {
  eSet <- get(set)
  pdata <- pData(eSet)
  eSet_tmp <- eSet[, pdata$sample_type %in% "tumor"]
  exprs_tmp <- exprs(eSet_tmp)
  pdata_tmp <- pData(eSet_tmp)

  pdata_tmp$study <- set

  ind_rm <- grep("CRIS_", colnames(pdata_tmp))  # remove CIRS_* pData assigned to training datasets
  if (length(ind_rm) != 0) {pdata_tmp <- pdata_tmp[,-ind_rm]}
  return(pdata_tmp)

}) %>% Reduce('rbind', .)

saveRDS(df.results, "data/SummaryForFig4.rds")
