% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LVScatter.R
\name{LVScatter}
\alias{LVScatter}
\title{Draw scatter plot with R-squared value}
\usage{
LVScatter(
  dat,
  lv,
  y.var = "Neutrophil.Count",
  ylab = "",
  title = NULL,
  subtitle = NULL
)
}
\arguments{
\item{dat}{A data frame containing the summary of scores and metadata.}

\item{lv}{A RAV name for x-axis.}

\item{y.var}{A name of y-axis.}

\item{ylab}{A label for y-axis.}

\item{title}{The text for the title.}

\item{subtitle}{The text for the subtitle for the plot which will be displayed below the title.}
}
\value{
A scatter plot.
}
\description{
Draw scatter plot with R-squared value
}
\note{
Modified from https://github.com/greenelab/multi-plier/blob/master/07-sle_cell_type_recount2_model.Rmd
}
