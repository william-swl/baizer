test_that("write_excel", {
  write_excel_path <- function(df) {
    path <- tempfile(fileext = ".xlsx")
    write_excel(df, path)
    return(path)
  }

  announce_snapshot_file("1sheet.xlsx")
  path <- write_excel_path(mini_diamond[1:5, ])
  expect_snapshot_file(path, "1sheet.xlsx", compare = compare_file_text)
})

test_that("write_excel multi sheets", {
  write_excel_path <- function(df_list) {
    path <- tempfile(fileext = ".xlsx")
    write_excel(df_list, path)
    return(path)
  }

  announce_snapshot_file("2sheets.xlsx")
  path <- write_excel_path(list(
    mini_diamond[1:5, 1:3],
    mini_diamond[6:10, 1:3]
  ))
  expect_snapshot_file(path, "2sheets.xlsx", compare = compare_file_text)
})


test_that("write_excel, wrong suffix", {
  expect_error(write_excel(mini_diamond, "m.jpg"))
})
