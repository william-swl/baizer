
#' load packages as a batch
#'
#' @param ... pkgs
#'
#' @return nothing
#' @export
#'
#' @examples baizer::pkglib(dplyr, purrr, tidyr)
pkglib <- function(...) {
  pkgs <- rlang::enexprs(...)
  purrr::walk(pkgs, ~ library(deparse(.x), character.only = TRUE))
}



#' get the command line arguments
#'
#' @param x one of 'wd, R_env, script_path, script_dir, env_configs'
#'
#' @return list of all arguments, or single value of select argument
#' @export
#'
#' @examples cmdargs()
#'
cmdargs <- function(x = NULL) {
  res <- list()
  res$wd <- getwd()
  res$R_env <- commandArgs() %>% grep("^RStudio|/R$", ., value = TRUE)
  res$script_path <- commandArgs() %>%
    grep("^--file=", ., value = TRUE) %>%
    stringr::str_replace("^--file=", "")
  res$script_dir <- res$script_path %>% stringr::str_replace("/[^/]+$", "")
  res$env_configs <- list(commandArgs(), res$R_env, res$script_path) %>%
    purrr::reduce(setdiff)

  if (is.null(x)) {
    return(res)
  } else {
    return(res[[x]])
  }
}


#' detect whether directory is empty recursively
#'
#' @param dir
#'
#' @return logical value
#' @export
#'
#' @examples
#' # create an empty directory
#' dir.create("some/deep/path/in/a/folder", recursive = TRUE)
#' empty_dir("some/deep/path/in/a/folder")
#'
#' # create an empty file
#' file.create("some/deep/path/in/a/folder/there_is_a_file.txt")
#' empty_dir("some/deep/path/in/a/folder")
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)
#'
#' # create a file with only character of length 0
#' write("", "some/deep/path/in/a/folder/there_is_a_file.txt")
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt")
#'
#' # clean
#' unlink("some", recursive = TRUE)
#'
empty_dir <- function(dir) {
  purrr::map_lgl(dir, ~ length(dir(.x, recursive = TRUE)) == 0)
}


#' detect whether file is empty recursively
#'
#' @param path the path of file
#' @param strict `FALSE` as default. If `TRUE`, a file with only one
#' character of length 0 will be considered as not empty
#'
#' @return logical value
#' @export
#'
#' @examples
#' # create an empty directory
#' dir.create("some/deep/path/in/a/folder", recursive = TRUE)
#' empty_dir("some/deep/path/in/a/folder")
#'
#' # create an empty file
#' file.create("some/deep/path/in/a/folder/there_is_a_file.txt")
#' empty_dir("some/deep/path/in/a/folder")
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)
#'
#' # create a file with only character of length 0
#' write("", "some/deep/path/in/a/folder/there_is_a_file.txt")
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt", strict = TRUE)
#' empty_file("some/deep/path/in/a/folder/there_is_a_file.txt")
#'
#' # clean
#' unlink("some", recursive = TRUE)
#'
empty_file <- function(path, strict = FALSE) {
  if (strict == TRUE) {
    file.info(path)$size == 0
  } else {
    file.info(path)$size <= 1
  }
}


#' split a path into ancestor paths recursively
#'
#' @param path path to split
#'
#' @return character vectors of ancestor paths
#' @export
#'
#' @examples split_path("/home/someone/a/test/path.txt")
split_path <- function(path) {
  func <- function(vec) {
    r <- purrr::accumulate(
      vec,
      ~ stringr::str_c(c(.x, .y), collapse = "/")
    )
    r[r != ""]
  }

  res <- stringr::str_split(path, "/") %>% purrr::map(func)

  return(res)
}



#' write a tibble into an excel file
#'
#' @param df tibble or a list of tibbles
#' @param filename the output filename
#' @param sheetname the names of sheets. If not given, will use 'sheet1', or
#' the names of list
#' @param creator creator
#'
#' @return return status
#' @export
#'
#' @examples # write_excel(mini_diamond, "mini_diamond.xlsx")
write_excel <- function(df, filename, sheetname = NULL, creator = "") {
  if (!stringr::str_detect(filename, "\\.xlsx*$")) {
    stop("File name should have xlsx/xls suffix!")
  }
  wb <- openxlsx::createWorkbook(creator = creator)
  addsheet <- function(wb, name, table) {
    openxlsx::addWorksheet(wb, sheetName = name)
    openxlsx::writeData(wb, sheet = name, x = table)
  }

  if (is.data.frame(df) == TRUE) {
    if (is.null(sheetname)) {
      sheetname <- "sheet1"
    }
    if (length(sheetname) != 1) {
      stop("Different numbers between dataframe and sheet names!")
    }

    addsheet(wb, sheetname, df)
  } else if (is.list(df) == TRUE && is.data.frame(df) == FALSE) {
    if (is.null(sheetname) && is.null(names(df))) {
      sheetname <- stringr::str_c("sheet", seq_along(df))
    } else if (is.null(sheetname) && any(names(df) != "")) {
      names(df)[which(names(df) == "")] <- stringr::str_c(
        "sheet", which(names(df) == "")
      )
      sheetname <- names(df)
    }

    if (length(df) != length(sheetname)) {
      stop("Different numbers between dataframe and sheet names!")
    }
    purrr::walk2(sheetname, df, ~ addsheet(wb, .x, .y))
  }

  openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
}
