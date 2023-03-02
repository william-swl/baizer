#' write a tibble into an excel file
#'
#' @param df tibble or a list of tibbles
#' @param filename the output filename
#' @param sheetname the name of sheets, `sheet1` as default
#' @param creator creator
#'
#' @return return status
#' @export
#'
#' @examples # write_excel(mini_diamond, "mini_diamond.xlsx")
write_excel <- function(df, filename, sheetname = "sheet1", creator = "") {
  if (!stringr::str_detect(filename, "\\.xlsx*$")) {
    stop("File name should have xlsx/xls suffix!")
  }

  wb <- openxlsx::createWorkbook(creator = creator)

  addsheet <- function(wb, name, table) {
    openxlsx::addWorksheet(wb, sheetName = name)
    openxlsx::writeData(wb, sheet = name, x = table)
  }

  # data.frame is list, but list is not data.frame
  if (is.data.frame(df) == TRUE) {
    addsheet(wb, sheetname, df)
  } else if (is.list(df) == TRUE) {
    # sheet names
    if (sheetname == "sheet1") {
      sheetname <- stringr::str_c("sheet", seq_along(df))
    }

    if (length(df) != length(sheetname)) {
      stop("Different numbers between dataframe and sheet names!")
    }

    purrr::walk2(sheetname, df, ~ addsheet(wb, .x, .y))
  }

  openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
}
