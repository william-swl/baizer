% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataframe.R
\name{remove_nacol}
\alias{remove_nacol}
\title{remove columns by the ratio of NA}
\usage{
remove_nacol(df, max_ratio = 1)
}
\arguments{
\item{df}{tibble}

\item{max_ratio}{the max NA ratio to keep this column, default is 1
have NA}
}
\value{
tibble
}
\description{
remove columns by the ratio of NA
}
\examples{
# remove_nacol(df)
}
