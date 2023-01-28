#' write a tibble into an excel file
#'
#' @param filename the output filename
#' @param sheetname the sheet name, `sheet1` as default
#' @param creator creator
#' @param df tibble
#'
#' @return return status
#' @export
#'
#' @examples write_excel(mini_diamond, "mini_diamond.xlsx")
write_excel <- function(df, filename, sheetname = "sheet1", creator = "") {
  wb <- openxlsx::createWorkbook(creator = creator)
  openxlsx::addWorksheet(wb, sheetName = sheetname)
  openxlsx::writeData(wb, sheet = sheetname, x = df)
  if (!stringr::str_detect(filename, "\\.xlsx*$")) {
    stop("File name should have xlsx/xls suffix!")
  }
  openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
}
