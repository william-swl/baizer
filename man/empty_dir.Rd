% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IO.R
\name{empty_dir}
\alias{empty_dir}
\title{detect whether directory is empty recursively}
\usage{
empty_dir(dir)
}
\arguments{
\item{dir}{the directory}
}
\value{
logical value
}
\description{
detect whether directory is empty recursively
}
\examples{
# create an empty directory
dir.create("some/deep/path/in/a/folder", recursive = TRUE)
empty_dir("some/deep/path/in/a/folder")

# create an empty file
file.create("some/deep/path/in/a/folder/there_is_a_file.txt")
empty_dir("some/deep/path/in/a/folder")
empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)

# create a file with only character of length 0
write("", "some/deep/path/in/a/folder/there_is_a_file.txt")
empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)
empty_file("some/deep/path/in/a/folder/there_is_a_file.txt")

# clean
unlink("some", recursive = TRUE)

}
