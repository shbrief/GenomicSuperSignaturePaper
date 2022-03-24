.topNES <- function(gsList, n) {
    m <- min(n, nrow(gsList))
    res <- gsList %>% arrange(desc(abs(NES))) %>% .[1:m, "Description"]
    return(res)
}

#' Calculate pathway coverage
#'
#' @param RAVmodel RAVmodel
#' @param geneSets Currently taking only "C2" and "PLIERpriors"
#' @param n The number of top enriched gene sets ranked by the absolute value
#' of NES. Under the default (\code{NULL}), all the pathways are used.
#' @return pathway coverage in percentile

pathwayCoverage <- function(RAVmodel, geneSets, n = NULL) {

    ## input gene sets
    if (geneSets == "C2") {
        dir <- system.file("extdata", package = "GenomicSuperSignaturePaper")
        term2gene <- clusterProfiler::read.gmt(file.path(dir, "c2.all.v7.1.symbols.gmt"))
        all_in <- length(unique(term2gene$term))
    } else if (geneSets == "PLIERpriors") {
        library(PLIER)
        data(canonicalPathways)
        data(bloodCellMarkersIRISDMAP)
        data(svmMarkers)
        allPaths <- combinePaths(canonicalPathways, bloodCellMarkersIRISDMAP, svmMarkers)
        all_in <- length(colnames(allPaths))
    }

    ## pathways used in the RAVmodel
    gs <- gsea(RAVmodel)
    if (is.null(n)) {
        all_out <- sapply(gs, function(x) {x$Description})
        all_out <- length(unique(unlist(all_out)))
    } else {
        all_out <- sapply(gs, function(x) {.topNES(x, n)})
        all_out <- length(unique(unlist(all_out)))
    }

    ## pathway coverage
    res <- round((all_out/all_in)*100, 2)
    return(res)
}

