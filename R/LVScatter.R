calculateRsq <- function (x, y) stats::cor(x, y) ^ 2

#' Draw scatter plot with R-squared value
#'
#' @import ggplot2
#'
#' @param dat A data frame containing the summary of scores and metadata.
#' @param lv A RAV name for x-axis.
#' @param y.var A name of y-axis.
#' @param ylab A label for y-axis.
#' @param title The text for the title.
#' @param subtitle The text for the subtitle for the plot which will be displayed below the title.
#'
#' @return A scatter plot.
#'
#' @note Modified from https://github.com/greenelab/multi-plier/blob/master/07-sle_cell_type_recount2_model.Rmd
#' @export
LVScatter <- function(dat, lv, y.var = "Neutrophil.Count", ylab = "",
                      title = NULL, subtitle = NULL) {
  neutro.df <- dat

  # calculate where to put the r-squared value
  x.range <- max(neutro.df[, lv]) - min(neutro.df[, lv])
  x.coord <- min(neutro.df[, lv]) + (x.range * 0.25)
  y.range <- max(neutro.df[, y.var]) - min(neutro.df[, y.var])
  if (y.range >= 5) {
    y.coord <- max(neutro.df[, y.var]) - (y.range * 0.05)
  } else {
    y.coord <- max(neutro.df[, y.var])
  }


  rsq <- calculateRsq(neutro.df[, lv], neutro.df[, y.var])
  rsq <- round(rsq, 3)

  ggplot(neutro.df, aes_string(x = lv, y = y.var)) +
    geom_point(alpha = 0.7) +
    geom_smooth(method = "lm") +
    theme_bw() +
    labs(y = ylab) +
    labs(title = title, subtitle = subtitle) +
    theme(legend.position = "none",
          text = element_text(size = 16),
          plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
          plot.subtitle = element_text(size = 16, hjust = 0.5)) +
    annotate("text", x = x.coord, y = y.coord, size = 5,
             label = paste("r-squared =", rsq))
}
