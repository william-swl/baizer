% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe.R
\name{fancy_count}
\alias{fancy_count}
\title{fancy count to show an extended column}
\usage{
fancy_count(df, ..., ext = NULL, ext_fmt = "count", sort = FALSE, digits = 2)
}
\arguments{
\item{df}{tibble}

\item{...}{other arguments from \code{dplyr::count()}}

\item{ext}{extended column}

\item{ext_fmt}{\code{count|ratio|clean}, output format of extended column}

\item{sort}{sort by frequency or not}

\item{digits}{if \code{ext_fmt=ratio}, the digits of ratio}
}
\value{
count tibble
}
\description{
fancy count to show an extended column
}
\examples{
fancy_count(mini_diamond, cut, ext = clarity)

fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")

fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")

fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)

fancy_count(mini_diamond, cut, clarity, ext = id) \%>\% head(5)
}
