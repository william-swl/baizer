% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe.R
\name{as_md_table}
\alias{as_md_table}
\title{trans a tibble into markdown format table}
\usage{
as_md_table(x, show = TRUE)
}
\arguments{
\item{x}{tibble}

\item{show}{show result instead of return the markdown string, TRUE as
default}
}
\value{
NULL or markdown string
}
\description{
trans a tibble into markdown format table
}
\examples{

mini_diamond \%>\%
  head(5) \%>\%
  as_md_table()

}
