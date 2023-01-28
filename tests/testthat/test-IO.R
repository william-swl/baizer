test_that("write_excel", {
  write_excel_path <- function(df) {
    path <- tempfile(fileext = ".xlsx")
    write_excel(df, path)
    return(path)
  }

  announce_snapshot_file("mini_diamond.xlsx")
  path <- write_excel_path(mini_diamond)
  expect_snapshot_file(path, "mini_diamond.xlsx", compare = compare_file_text)
})


test_that("write_excel, wrong suffix", {
  expect_error(write_excel(mini_diamond, "m.jpg"))
})
