#' check whether your pathway of interest is in the model
#'
#' @param PCAmodel A PCAGenomicSignatures object.
#' @param pathwaySet A character vector. Keywords you are looking for.
#' @param cutoff_nes A minimum NES to be kept.
#' @param cutoff_n A number of pathways to keep.
#'
#' @export
getAssociatedRAVs <- function(PCAmodel, pathwaySet, cutoff_nes, cutoff_n) {

  associated_RAV <- c()

  for (i in seq_len(ncol(PCAmodel))) {
    search_pattern <- paste(pathwaySet, collapse = "|")
    annotatedCluster <- GenomicSuperSignature::gsea(PCAmodel)[[i]]
    topAnnotation <- annotatedCluster[order(abs(annotatedCluster$NES), decreasing = TRUE),]

    # Filtering
    if (!is.null(cutoff_nes)) {topAnnotation <- topAnnotation[(abs(topAnnotation$NES) >= cutoff_nes),,drop=FALSE]}
    if (!is.null(cutoff_n)) {topAnnotation <- topAnnotation[seq_along(cutoff_n),,drop=FALSE]}

    # Find the RAV containing pathwaySet
    ind <- grep(search_pattern, topAnnotation$Description, ignore.case = TRUE)
    if (length(ind) != 0) {associated_RAV <- c(associated_RAV, i)}
  }

  return(associated_RAV)
}



#' Check a pair of pathways are captured in the signature model
#'
#' Arguments \code{pathway1} and \code{pathway2} are character vectors containing
#' lists of pathways that you want to separate through the model.
#'
#' @param PCAmodel PCAGenomicSignatures object.
#' @param pathway1 A character vector. Keywords you are looking for.
#' @param pathway2 A character vector. Keywords you are looking for.
#' @param cutoff_nes A minimum NES to be kept. Under the default (\code{NULL}), this
#' filter is not used.
#' @param cutoff_n A number of pathways to keep.Default is 5. If you don't want to
#' use this filter, assign it as \code{NULL}.
#'
#' @note https://github.com/greenelab/multi-plier/blob/master/32-explore_pathway_separation.Rmd
#' @export
checkPathwaySeparation <- function(PCAmodel, pathway1, pathway2, cutoff_nes = NULL, cutoff_n = 5) {

  # RAVs associated with each set
  RAV1 <- getAssociatedRAVs(PCAmodel, pathway1, cutoff_nes = cutoff_nes, cutoff_n = cutoff_n)
  RAV2 <- getAssociatedRAVs(PCAmodel, pathway2, cutoff_nes = cutoff_nes, cutoff_n = cutoff_n)

  # Check whether both pathways are captured
  captured <- all(c(length(RAV1) > 0, length(RAV2) > 0))

  if (!captured) {
    return(FALSE)
  } else {
    set1.unique <- length(setdiff(RAV1, RAV2)) > 0
    set2.unique <- length(setdiff(RAV2, RAV1)) > 0
    return(all(set1.unique, set2.unique))
  }
}
