##### Script to build microRAVmodel ############################################
## For Galaxy implementation, we make microRAVmodel from microRAVmodel aiming to
## have an object size below 500Kb.

## RAVs to keep in the microRAVmodel
dir <- "~/data2/GenomicSuperSignaturePaper/inst/extdata"
RAVmodel <- readRDS(file.path(dir, "RAVmodel_PLIERpriors.rds"))
keep_ind <- c(1076, 725, 884, 1994)

## Subset RAVmodel with 4 RAVs
microRAVmodel <- RAVmodel[1:100, keep_ind]
cl_ind <- which(metadata(microRAVmodel)$cluster %in% keep_ind)
metadata(microRAVmodel)$cluster <- metadata(microRAVmodel)$cluster[cl_ind]
metadata(microRAVmodel)$size <- metadata(microRAVmodel)$size[keep_ind]

## Restructure RAVmodel <= TRY THIS after GenomicSuperSignature is updated
# colData(microRAVmodel)$size <- metadata(microRAVmodel)$size   # move 'size'
# cl_df <- list()
# cl <- metadata(microRAVmodel)$cluster
# for (i in colnames(microRAVmodel)) {   # convert vector into table
#     rav_num <- gsub("RAV", "", i)
#     ind <- which(cl == rav_num)
#     cl_df[[i]] <- names(cl[ind])
# }
# colData(microRAVmodel)$cluster <- cl_df   # move cluster
# metadata(microRAVmodel) <- metadata(microRAVmodel)[3:7]   # remove old slots

## Remove extra PCAsummary and MeSH annotations
studies <- metadata(microRAVmodel)$cluster
studyNames <- gsub("\\..*", "", names(studies)) %>% unique
trainingData(microRAVmodel) <- trainingData(microRAVmodel)[studyNames,]

# mesh_include <- which(names(mesh(microRAVmodel)) %in% studyNames)
# mesh(microRAVmodel) <- mesh(microRAVmodel)[mesh_include]
# pcaSummary_include <- which(names(trainingData(microRAVmodel)$PCAsummary) %in% studyNames)
# trainingData(microRAVmodel)$PCAsummary[-pcaSummary_include] <- NA

## Save microRAVmodel
saveRDS(microRAVmodel,
        "~/data2/GenomicSuperSignature/inst/scripts/microRAVmodel_v2.rds")

