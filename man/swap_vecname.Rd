% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-basic.R
\name{swap_vecname}
\alias{swap_vecname}
\title{swap the names and values of a vector}
\usage{
swap_vecname(x)
}
\arguments{
\item{x}{vector without duplicated values}
}
\value{
swapped vector
}
\description{
swap the names and values of a vector
}
\examples{
v <- c("a" = "A", "b" = "B", "c" = "C")
swap_vecname(v)

}
