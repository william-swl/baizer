test_that("empty", {
  dir.create("some/deep/path/in/a/folder", recursive = TRUE)
  expect_identical(empty_dir("some/deep/path/in/a/folder"), TRUE)
  file.create("some/deep/path/in/a/folder/there_is_a_file.txt")
  expect_identical(empty_dir("some/deep/path/in/a/folder"), FALSE)

  expect_identical(empty_file("some/deep/path/in/a/folder/there_is_a_file.txt",
    strict = TRUE
  ), TRUE)
  write("", "some/deep/path/in/a/folder/there_is_a_file.txt")
  expect_identical(empty_file("some/deep/path/in/a/folder/there_is_a_file.txt",
    strict = TRUE
  ), FALSE)
  expect_identical(
    empty_file("some/deep/path/in/a/folder/there_is_a_file.txt"),
    if (Sys.info()["sysname"] == "Windows") FALSE else TRUE
  )
  unlink("some", recursive = TRUE)
})


test_that("split_path", {
  expect_identical(
    split_path("/home/someone/a/test/path.txt"),
    list(c(
      "/home", "/home/someone", "/home/someone/a",
      "/home/someone/a/test", "/home/someone/a/test/path.txt"
    ))
  )
})




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


test_that("write_excel, errors", {
  expect_error(write_excel(mini_diamond, "m.jpg"))
  expect_error(write_excel(mini_diamond, "t.xlsx", c("s1", "s2")))
  expect_error(write_excel(
    list(mini_diamond[1:5, 1:3], mini_diamond[6:10, 1:3]),
    "t.xlsx", c("s1")
  ))
})
