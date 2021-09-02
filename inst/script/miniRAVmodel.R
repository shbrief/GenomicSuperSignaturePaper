##### Script to build miniRAVmodel #############################################

## Select RAVs to keep in the miniRAVmodel
dir <- "~/data2/GenomicSuperSignaturePaper/inst/extdata"
RAVmodel <- readRDS(file.path(dir, "RAVmodel_PLIERpriors.rds"))

# Validated index
library(bcellViper)
data(bcellViper)
val_all <- validate(dset, RAVmodel)
validated_ind <- validatedSignatures(val_all, num.out = 3,
                                     swCutoff = 0, indexOnly = TRUE)  # 2538 1139 884

# Keyword-containing index
keyword_ind <- findSignature(RAVmodel, "Bcell", k = 5)  # 695 1994

# RAVs to keep (haven't found the script I got others)
keep_ind <- c(1076, 338, 1467, 1614, 294, 3071, 1694, 438, 725, 1497, 501, 941,
              validated_ind, keyword_ind)


## Subset RAVmodel with 17 RAVs
miniRAVmodel <- RAVmodel[, keep_ind]
cl_ind <- which(metadata(miniRAVmodel_final)$cluster %in% keep_ind)
metadata(miniRAVmodel)$cluster <- metadata(miniRAVmodel)$cluster[cl_ind]
metadata(miniRAVmodel)$size <- metadata(miniRAVmodel)$size[keep_ind]

## Save miniRAVmodel
# Run tools::checkRdaFiles() to determine the best compression for each file
# save(miniRAVmodel, "~/data2/GenomicSuperSignature/data/miniRAVmodel.RData")
# tools::checkRdaFiles("~/data2/GenomicSuperSignature/data/miniRAVmodel.RData")

tools::resaveRdaFiles("~/data2/GenomicSuperSignature/data/miniRAVmodel.RData",
                      version = 3)
