#' Evaluate Hierarchical Clustering
#'
#' @param res Output from \code{factoextra::hcut} or \code{communities} object from \code{igraph}.
#' @param controlType Type of controls to evaluate. Choose "Pos" or "Neg".
#' @param hmTable Under default (\code{hmTable}), the output matrix will be plotted
#' in heatmap table.
#' @param onlyPC1 Under default (\code{TRUE}), only the distribution of PC1s will be
#' tested. If it's set to (\code{FALSE}), the distribusion of PC1-PC4 will be tested
#' @param agglomeration.method The agglomeration method (e.g. \code{hc_method} parameter
#' in \code{factoextra::hcut}) used to cut the tree during hierarchical clustering.
#' This input will be a part of heatmap table name if \code{hmTable = TRUE}.
#'
#' @return A matrix with the PC of interest in row and the clusters with that PCs in.
#' The value represents how many of negative control PCs are in a given cluster.
#'
evaluateCluster <- function(res, controlType, hmTable = TRUE,
                            onlyPC1 = TRUE, agglomeration.method = NULL) {

    if ("hclust" %in% class(res)) {
        NumOfCl <- res$nbclust
        ClNum <- res$cluster
        ClNames <- names(ClNum)

        if (isTRUE(onlyPC1)) {NumOfControl <- grep(controlType, res$labels) %>% length}

    } else if ("communities" %in% class(res)) {
        NumOfCl <- length(unique(res$membership))
        ClNum <- res$membership
        ClNames <- res$names
    }

    cl <- list()
    for (i in 1:NumOfCl) {cl[[i]] <- ClNames[ClNum == i]}
    names(cl) <- paste0("PCcluster_", 1:NumOfCl)

    if (isTRUE(onlyPC1)) {
        PC1s <- paste0(controlType, "_", c(1:NumOfControl), ".PC1")
        pc1 <- sapply(cl, function(x) length(intersect(x, PC1s)))
        df <- data.frame(PC1s = pc1)
    } else {
        PC1s <- paste0(controlType, "_", c(1:10), ".PC1")
        PC2s <- paste0(controlType, "_", c(1:10), ".PC2")
        PC3s <- paste0(controlType, "_", c(1:10), ".PC3")
        PC4s <- paste0(controlType, "_", c(1:10), ".PC4")
        pc1 <- sapply(cl, function(x) length(intersect(x, PC1s)))
        pc2 <- sapply(cl, function(x) length(intersect(x, PC2s)))
        pc3 <- sapply(cl, function(x) length(intersect(x, PC3s)))
        pc4 <- sapply(cl, function(x) length(intersect(x, PC4s)))
        df <- data.frame(PC1s = pc1, PC2s = pc2, PC3s = pc3, PC4s = pc4)
    }
    rownames(df) <- paste0("hcluster_", 1:NumOfCl)
    df <- df[rowSums(df)!=0,,drop=FALSE]

    # heatmap table
    if (controlType == "Pos") {col <- "Purples3"}
    else if (controlType == "Neg") {col <- "Reds2"}

    if (ncol(df) == 1) {df <- t(df)}
    if (isTRUE(hmTable)) {
        GenomicSignatures::heatmapTable(df,
                                        column_title = paste(agglomeration.method, "with k = ", NumOfCl),
                                        breaks = c(0, 4, 8),
                                        colors = hcl.colors(3, col, rev = TRUE),
                                        show_heatmap_legend = FALSE)
    } else {return(df)}
}
