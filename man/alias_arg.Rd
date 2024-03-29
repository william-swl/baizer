% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dev.R
\name{alias_arg}
\alias{alias_arg}
\title{use aliases for function arguments}
\usage{
alias_arg(..., default = NULL)
}
\arguments{
\item{...}{aliases of an argument}

\item{default}{a alias with a default value}
}
\value{
the finally value of this argument across all aliases
}
\description{
use aliases for function arguments
}
\examples{

# set y, z as aliases of x when create a function
func <- function(x = 1, y = NULL, z = NULL) {
  x <- alias_arg(x, y, z, default = x)
  return(x)
}
}
