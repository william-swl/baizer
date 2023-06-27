#' load packages as a batch
#'
#' @param ... pkgs
#'
#' @export
#'
#' @examples baizer::pkglib(dplyr, purrr)
pkglib <- function(...) {
  pkgs <- rlang::enexprs(...)
  purrr::walk(pkgs, ~ library(deparse(.x), character.only = TRUE))
}


#' information of packages
#'
#' @param ... case-insensitive package names
#'
#' @export
#'
#' @examples baizer::pkginfo(dplyr)
pkginfo <- function(...) {
  x <- enexprs(...) %>%
    as.character() %>%
    stringr::str_to_lower()
  allpkg <- rownames(installed.packages())
  x <- allpkg[stringr::str_to_lower(allpkg) %in% x]

  res <- sessionInfo(x)[["otherPkgs"]]

  return(res)
}


#' versions of packages
#'
#' @param ... case-insensitive package names
#'
#' @export
#'
#' @examples baizer::pkgver(dplyr, purrr)
pkgver <- function(...) {
  pkginfo(...) %>%
    purrr::map(~ .x[["Version"]])
}

#' not in calculation operator
#'
#' @param left left element
#' @param right right element
#'
#' @return logical value, TRUE if left is not in right
#' @export
#'
#' @examples 0 %nin% 1:4
`%nin%` <- function(left, right) {
  purrr::negate(`%in%`)(left, right)
}


#' not equal calculation operator, support NA
#'
#' @param x value x
#' @param y value y
#'
#' @return logical value, TRUE if x and y are not equal
#' @export
#'
#' @examples 1 %neq% NA
`%neq%` <- function(x, y) {
  (x != y | (is.na(x) & !is.na(y)) | (is.na(y) & !is.na(x))) &
    !(is.na(x) & is.na(y))
}

#' not NA
#'
#' @param x value
#'
#' @return logical value
#' @export
#'
#' @examples not.na(NA)
not.na <- function(x) {
  !is.na(x)
}


#' not NULL
#'
#' @param x value
#'
#' @return logical value
#' @export
#'
#' @examples not.null(NULL)
not.null <- function(x) {
  !is.null(x)
}


#' dump a named vector into character
#'
#' @param named_vector a named vector
#' @param front_name if TRUE, put names to former
#' @param collapse collapse separator
#'
#' @return character
#' @export
#'
#' @examples collapse_vector(c(e = 1:4), front_name = TRUE, collapse = ";")
collapse_vector <- function(named_vector, front_name = TRUE, collapse = ",") {
  if (is.null(names(named_vector))) {
    stop("Not a named vector!")
  }
  if (front_name == TRUE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~ stringr::str_glue("{.x}({.y})")) %>%
      stringr::str_c(collapse = collapse)
  } else if (front_name == FALSE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~ stringr::str_glue("{.y}({.x})")) %>%
      stringr::str_c(collapse = collapse)
  }
}


#' slice character vector
#'
#' @param x character vector
#' @param from from
#' @param to to
#' @param unique remove the duplicated boundary characters
#'
#' @return sliced vector
#' @export
#'
#' @examples
#' x <- c("A", "B", "C", "D", "E")
#' slice_char(x, "A", "D")
#' slice_char(x, "D", "A")
#'
#' x <- c("A", "B", "C", "C", "A", "D", "D", "E", "A")
#' slice_char(x, "B", "E")
#' # duplicated element as boundary will throw an error
#' # slice_char(x, 'A', 'E')
#' # unique=TRUE to remove the duplicated boundary characters
#' slice_char(x, "A", "E", unique = TRUE)
#'
slice_char <- function(x, from = x[1], to = x[length(x)], unique = FALSE) {
  if (!is(x, "character")) {
    stop("x should be character vector")
  }
  if (unique == TRUE) {
    x <- x[-c(which(x == from)[-1], which(x == to)[-1])]
  }

  dup_char <- x[duplicated(x)]
  inter <- intersect(c(from, to), dup_char)

  if (length(inter) != 0) {
    stop("x have duplicated characters at slice boundaries")
  }

  res <- x[which(from == x):which(to == x)]
  return(res)
}



#' the index of different character
#'
#' @param s1 string1
#' @param s2 string2
#' @param nth just return nth index
#' @param ignore_case ignore upper or lower cases
#' @return list of different character indices
#' @export
#'
#' @examples diff_index("AAAA", "ABBA")
diff_index <- function(s1, s2, nth = NULL, ignore_case = FALSE) {
  if (ignore_case == TRUE) {
    s1 <- stringr::str_to_upper(s1)
    s2 <- stringr::str_to_upper(s2)
  }
  if (any(nchar(s1) != nchar(s2))) {
    dif_nchar <- which(nchar(s1) != nchar(s2))
    stop(
      stringr::str_c(
        c("strings have different nchar:", dif_nchar),
        collapse = " "
      )
    )
  }

  idx <- purrr::map2(
    stringr::str_split(s1, ""),
    stringr::str_split(s2, ""), `!=`
  ) %>%
    purrr::map(which)

  if (is.null(nth)) {
    return(idx)
  } else {
    res <- purrr::map(idx, ~ .x[nth], .default = NA)
    return(res)
  }
}


#' the index of identical character
#'
#' @param s1 string1
#' @param s2 string2
#' @param nth just return nth index
#' @param ignore_case ignore upper or lower cases
#' @return list of identical character indices
#' @export
#'
#' @examples same_index("AAAA", "ABBA")
same_index <- function(s1, s2, nth = NULL, ignore_case = FALSE) {
  if (ignore_case == TRUE) {
    s1 <- stringr::str_to_upper(s1)
    s2 <- stringr::str_to_upper(s2)
  }
  if (any(nchar(s1) != nchar(s2))) {
    dif_nchar <- which(nchar(s1) != nchar(s2))
    stop(
      stringr::str_c(c("strings have different nchar:", dif_nchar),
        collapse = " "
      )
    )
  }

  idx <- purrr::map2(
    stringr::str_split(s1, ""),
    stringr::str_split(s2, ""), `==`
  ) %>%
    purrr::map(which)

  if (is.null(nth)) {
    return(idx)
  } else {
    res <- purrr::map(idx, ~ .x[nth], .default = NA)
    return(res)
  }
}


#' fetch character from strings
#'
#' @param s strings
#' @param index_list index of nth character,
#' can be output of `diff_index` or `same_index`
#' @param na.rm remove NA values from results or not
#' @param collapse optional string used to combine
#' the characters from a same string
#'
#' @return list of characters
#' @export
#'
#' @examples fetch_char(rep("ABC", 3), list(1, 2, 3))
fetch_char <- function(s, index_list, na.rm = FALSE, collapse = FALSE) {
  res <- purrr::map2(
    s, index_list,
    ~ {
      stringr::str_sub(.x, .y, .y)
    }
  )

  if (na.rm == TRUE) {
    res <- res %>% purrr::map(~ .x[!is.na(.x)])
  }

  if (collapse != FALSE) {
    res <- res %>% purrr::map(~ stringr::str_c(.x, collapse = collapse))
  }

  return(res)
}


#' trans fixed string into regular expression string
#'
#' @param p raw fixed pattern
#'
#' @return regex pattern
#' @export
#'
#' @examples fix_to_regex("ABC|?(*)")
fix_to_regex <- function(p) {
  special_char <- c("^$|()[]{}?*+.") %>%
    stringr::str_split("") %>%
    unlist()
  replace_dict <- special_char %>% stringr::str_c("\\", .)
  names(replace_dict) <- special_char
  stringr::str_replace_all(p, pattern = stringr::fixed(replace_dict))
}



#' detect possible duplication in a vector, ignore case,
#' blank and special character
#'
#' @param vector vector possibly with duplication
#' @param index return duplication index
#'
#' @return duplication sub-vector
#' @export
#'
#' @examples detect_dup(c("a", "C_", "c -", "#A"))
detect_dup <- function(vector, index = FALSE) {
  modified_vector <- vector %>%
    stringr::str_to_lower() %>%
    stringr::str_extract_all("[\\w]+") %>%
    purrr::map_chr(~ stringr::str_c(.x, collapse = "")) %>%
    stringr::str_replace_all("_", "")
  dup_index <- duplicated(modified_vector) |
    duplicated(modified_vector, fromLast = TRUE)
  dup_order <- order(modified_vector[dup_index])
  res <- vector[dup_index][dup_order]

  if (index == TRUE) {
    return(dup_index)
  } else {
    return(res)
  }
}


#' extract key and values for a character vector
#'
#' @param v character vector
#' @param sep separator between key and value
#' @param key_loc key location
#' @param value_loc value location
#'
#' @return a named character vector
#' @export
#'
#' @examples extract_kv(c("x: 1", "y: 2"))
extract_kv <- function(v, sep = ": ", key_loc = 1, value_loc = 2) {
  df <- v %>%
    stringr::str_split(sep) %>%
    data.frame()
  key <- unname(unlist(df[key_loc, ]))
  value <- unname(unlist(df[value_loc, ]) %>% as.character())
  names(value) <- key

  return(value)
}


#' farthest point sampling (FPS) for a vector
#'
#' @param v vector
#' @param n sample size
#' @param method `round|floor|ceiling`, the method used when trans to integer
#'
#' @return sampled vector
#' @export
#'
#' @examples fps_vector(1:10, 4)
fps_vector <- function(v, n, method = "round") {
  len <- length(v)
  stopifnot(n <= len)
  idx <- seq(1, len, length.out = n)
  if (method == "round") {
    idx <- round(idx)
  } else if (method == "floor") {
    idx <- floor(idx)
  } else if (method == "ceiling") {
    idx <- ceiling(idx)
  }

  return(v[idx])
}




#' whether the expression is an atomic one
#'
#' @param ex expression
#'
#' @return logical value
#' @export
#'
#' @examples
#' atomic_expr(rlang::expr(x))
#'
#' atomic_expr(rlang::expr(!x))
#'
#' atomic_expr(rlang::expr(x + y))
#'
#' atomic_expr(rlang::expr(x > 1))
#'
#' atomic_expr(rlang::expr(!x + y))
#'
#' atomic_expr(rlang::expr(x > 1 | y < 2))
#'
atomic_expr <- function(ex) {
  if (!is_expression(ex)) {
    stop("not an expression object!")
  }

  if (length(ex) > 1) {
    if (purrr::map_lgl(as.list(ex), ~ length(.x) == 1) %>% all() == TRUE) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else if (length(ex) == 1) {
    return(TRUE)
  } else {
    stop("error!")
  }
}



#' pileup the subexpressions which is atomic
#'
#' @param ex expression
#'
#' @return the character vector of subexpressions
#' @export
#'
#' @examples
#' ex <- rlang::expr(a == 2 & b == 3 | !b & x + 2)
#' expr_pileup(ex)
#'
expr_pileup <- function(ex) {
  if (!is_expression(ex)) {
    stop("not an expression object!")
  }

  if (atomic_expr(ex)) {
    return(deparse(ex))
  }

  res <- c()
  for (i in as.list(ex)) {
    if (atomic_expr(i)) {
      res <- c(res, deparse(i))
    } else {
      res <- c(res, expr_pileup(i))
    }
  }

  return(res)
}


#' regex match
#'
#' @param x vector
#' @param pattern regex pattern
#' @param group regex group, 1 as default. when group=-1,
#' return full matched tibble
#'
#' @return vector or tibble
#' @export
#'
#' @examples
#' v <- stringr::str_c("id", 1:3, c("A", "B", "C"))
#'
#' reg_match(v, "id(\\d+)(\\w)")
#'
#' reg_match(v, "id(\\d+)(\\w)", group = 2)
#'
#' reg_match(v, "id(\\d+)(\\w)", group = -1)
#'
reg_match <- function(x, pattern, group = 1) {
  res <- suppressMessages(
    stringr::str_match(x, pattern) %>%
      tibble::as_tibble(.name_repair = "unique")
  )
  res <- res %>% rlang::set_names(c(
    "match",
    stringr::str_c("group", seq_along(colnames(res))[-ncol(res)])
  ))
  if (group == -1) {
    return(res)
  } else if (ncol(res) == 1) {
    return(dplyr::pull(res, 1))
  } else {
    return(dplyr::pull(res, group + 1))
  }
}

#' join the matched parts into string
#'
#' @param x character
#' @param pattern regex pattern
#' @param sep separator
#'
#' @return character
#' @export
#'
#' @examples
#' reg_join(c("A_12.B", "C_3.23:2"), "[A-Za-z]+")
#'
#' reg_join(c("A_12.B", "C_3.23:2"), "\\w+")
#'
#' reg_join(c("A_12.B", "C_3.23:2"), "\\d+", sep = ",")
#'
#' reg_join(c("A_12.B", "C_3.23:2"), "\\d", sep = ",")
#'
reg_join <- function(x, pattern, sep = "") {
  x <- as.character(x)
  res <- stringr::str_extract_all(x, pattern) %>%
    purrr::map_chr(~ stringr::str_c(.x, collapse = sep))

  return(res)
}



#' split vector into list
#'
#' @param vector vector
#' @param breaks split breaks
#' @param bounds "(]" as default, can also be "[), []"
#'
#' @return list
#' @export
#'
#' @examples
#' split_vector(1:10, c(3, 7))
#' split_vector(stringr::str_split("ABCDEFGHIJ", "") %>% unlist(),
#'   c(3, 7),
#'   bounds = "[)"
#' )
split_vector <- function(vector, breaks, bounds = "(]") {
  margins <- c(1, breaks, length(vector))

  split_index <- purrr::map2(
    margins[seq_along(margins)[-length(margins)]],
    margins[seq_along(margins)[-1]],
    ~ .x:.y
  )

  if (bounds == "(]") {
    process_index <- seq_along(split_index)[-1]
    split_index[process_index] <- split_index[process_index] %>%
      purrr::map(~ .x[-1])
  } else if (bounds == "[)") {
    process_index <- seq_along(split_index)[-length(split_index)]
    split_index[process_index] <- split_index[process_index] %>%
      purrr::map(~ .x[-length(.x)])
  }

  purrr::map(split_index, ~ vector[.x])
}

#' group character vector by a regex pattern
#'
#' @param x character vector
#' @param pattern regex pattern, '\\w' as default
#'
#' @return list
#' @export
#'
#' @examples
#' v <- c(
#'   stringr::str_c("A", c(1, 2, 9, 10, 11, 12, 99, 101, 102)),
#'   stringr::str_c("B", c(1, 2, 9, 10, 21, 32, 99, 101, 102))
#' ) %>% sample()
#'
#' group_vector(v)
#'
#' group_vector(v, pattern = "\\w\\d")
#'
#' group_vector(v, pattern = "\\w(\\d)")
#'
#' # unmatched part will alse be stored
#' group_vector(v, pattern = "\\d{2}")
#'
group_vector <- function(x, pattern = "\\w") {
  if (!is.character(x)) {
    stop("x must be a character vector")
  }

  # matched part and unmatched part
  reg_result <- x %>% reg_match(pattern)
  match <- reg_result[!is.na(reg_result)]
  x_match <- x[!is.na(reg_result)] # nolint
  unmatch <- reg_result[is.na(reg_result)]
  x_unmatch <- x[is.na(reg_result)]

  group <- match %>%
    unique() %>%
    sort()
  res <- group %>% purrr::map(~ x_match[match == .x])
  names(res) <- group

  if (length(unmatch) > 0) {
    res <- c(res, list(unmatch = x_unmatch))
  }

  return(res)
}


#' sort by a function
#'
#' @param x vector
#' @param func a function used by the sort
#' @param group_pattern a regex pattern to group by, only available if x is a
#' character vector
#'
#' @return vector
#' @export
#'
#' @examples
#' sortf(c(-2, 1, 3), abs)
#'
#' v <- stringr::str_c("id", c(1, 2, 9, 10, 11, 12, 99, 101, 102)) %>% sample()
#'
#' sortf(v, function(x) reg_match(x, "\\d+") %>% as.double())
#'
#' sortf(v, ~ reg_match(.x, "\\d+") %>% as.double())
#'
#' v <- c(
#'   stringr::str_c("A", c(1, 2, 9, 10, 11, 12, 99, 101, 102)),
#'   stringr::str_c("B", c(1, 2, 9, 10, 21, 32, 99, 101, 102))
#' ) %>% sample()
#'
#' sortf(v, ~ reg_match(.x, "\\d+") %>% as.double(), group_pattern = "\\w")
#'
sortf <- function(x, func, group_pattern = NULL) {
  if (!is.null(group_pattern) && is.character(x)) {
    x <- group_vector(x, group_pattern)
    sort_ord <- x %>%
      purrr::map(func) %>%
      purrr::map(order)
    res <- purrr::map2(x, sort_ord, ~ .x[.y]) %>%
      unlist() %>%
      unname()
  } else {
    sort_ord <- x %>%
      purrr::map(func) %>%
      unlist() %>%
      order()
    res <- x[sort_ord]
  }


  return(res)
}


#' pileup another logical vector on the TRUE values of first vector
#'
#' @param x logical vector
#' @param v another logical vector
#'
#' @return logical vector
#' @export
#'
#' @examples
#'
#' # first vector have 2 TRUE value
#' v1 <- c(TRUE, FALSE, TRUE)
#'
#' # the length of second vector should also be 2
#' v2 <- c(FALSE, TRUE)
#'
#' pileup_logical(v1, v2)
#'
pileup_logical <- function(x, v) {
  if (length(v) != sum(x)) {
    stop("the length of v does not equal to the number of TRUE in x!")
  }

  if (sum(x) == 0) {
    return(x)
  }

  vord <- c()
  ord <- 1
  for (i in x) {
    if (i) {
      vord <- c(vord, ord)
      ord <- ord + 1
    } else {
      vord <- c(vord, FALSE)
    }
  }

  v_expand <- purrr::map_lgl(
    vord,
    function(t) {
      if (t != 0) {
        v[t]
      } else {
        FALSE
      }
    }
  )

  res <- x & v_expand

  return(res)
}



#' only keep unique vector values and its names
#'
#' @param x vector
#'
#' @return vector
#' @export
#'
#' @examples
#'
#' x <- c(a = 1, b = 2, c = 3, b = 2, a = 1)
#'
#' uniq(x)
#'
uniq <- function(x) {
  dup_idx <- which(duplicated(x))
  if (length(dup_idx) != 0) {
    return(x[-dup_idx])
  } else {
    return(x)
  }
}

#' replace the items of one object by another
#'
#' @param x number, character or list
#' @param y another object, the class of y should be same as x
#' @param keep_extra whether keep extra items in y
#'
#' @return replaced object
#' @export
#'
#' @examples
#'
#' x <- list(A = 1, B = 3)
#' y <- list(A = 9, C = 10)
#'
#' replace_item(x, y)
#'
#' replace_item(x, y, keep_extra = TRUE)
#'
replace_item <- function(x, y, keep_extra = FALSE) {
  if (class(x) != class(y)) {
    stop("x, y should be two objects from same class,
         such as number, character or list")
  }

  xname <- names(x)
  yname <- names(y)

  if (any(duplicated(xname))) {
    stop("duplicated names in x")
  }

  if (any(duplicated(yname))) {
    stop("duplicated names in y")
  }

  inter_name <- intersect(xname, yname)
  extra_name <- setdiff(yname, xname)

  x[inter_name] <- y[inter_name]
  if (keep_extra == TRUE) {
    x <- c(x, y[extra_name])
  }

  return(x)
}



#' generate characters
#'
#' @param from left bound, lower case letter
#' @param to right bound, lower case letter
#' @param n number of characters to generate
#' @param random random generation
#' @param allow_dup allow duplication when random generation
#' @param add add extra characters other than `base::letters`
#' @param seed random seed
#'
#' @return generated characters
#' @export
#'
#' @examples
#' gen_char(from = "g", n = 5)
#' gen_char(to = "g", n = 5)
#' gen_char(from = "g", to = "j")
#' gen_char(from = "t", n = 5, random = TRUE)
#' gen_char(
#'   from = "x", n = 5, random = TRUE,
#'   allow_dup = FALSE, add = c("+", "-")
#' )
#'
gen_char <- function(from = NULL, to = NULL, n = NULL,
                     random = FALSE, allow_dup = TRUE,
                     add = NULL, seed = NULL) {
  # merge the added vector
  v <- uniq(c(letters, add))

  # letter slice
  if (random == FALSE) {
    if (check_arg(n, from, to, n = 2)) {
      if (is.null(n)) {
        res <- slice_char(v, from, to)
      } else if (is.null(from)) {
        to_index <- which(v == to)
        res <- v[(to_index - n + 1):to_index]
      } else if (is.null(to)) {
        from_index <- which(v == from)
        res <- v[from_index:(from_index + n - 1)]
      }
    } else {
      stop("please only assign two of the three arguments: n, from, to")
    }
  } else {
    # random generation
    if (is.null(n)) {
      stop("please input n")
    }
    # use from and to slice the vector
    from <- if (is.null(from)) v[1] else from
    to <- if (is.null(to)) v[length(v)] else to
    v <- slice_char(v, from, to)

    if (!is.null(seed)) {
      withr::with_seed(
        seed = seed,
        res <- sample(v, size = n, replace = allow_dup)
      )
    } else {
      res <- sample(v, size = n, replace = allow_dup)
    }
  }

  return(res)
}



#' generate strings
#'
#' @param n number of strings to generate
#' @param len string length
#' @param seed random seed
#'
#' @return string
#' @export
#'
#' @examples gen_str(n = 2, len = 3)
gen_str <- function(n = 1, len = 3, seed = NULL) {
  suppressWarnings({
    withr::with_seed(seed, {
      res <- seq_len(n) %>% map_chr(
        ~ gen_char(n = len, random = TRUE) %>%
          str_c(collapse = "")
      )
    })
  })

  return(res)
}


#' trans range character into seq characters
#'
#' @param x range character
#' @param sep range separator
#'
#' @return seq characters
#' @export
#'
#' @examples rng2seq(c("1-5", "2"))
rng2seq <- function(x, sep = "-") {
  pattern <- str_glue("^[\\d{sep}]+$")
  if (any(!str_detect(x, pattern))) {
    stop("input should only have number and sep!")
  }

  func <- function(x) {
    if ((length(x)) == 1) {
      r <- x
    } else if ((length(x)) == 2) {
      r <- seq(as.integer(x[1]), as.integer(x[2])) %>% as.character()
    } else {
      stop("input should be like 1-10")
    }
    return(r)
  }


  res <- str_split(x, sep) %>%
    map(func)
  return(res)
}


#' return top n items with highest frequency
#'
#' @param x character
#' @param n top n
#'
#' @return character
#' @export
#'
#' @examples
#'
#' top_item(c("a", "b", "c", "b"))
#'
top_item <- function(x, n = 1) {
  lev <- tibble(x) %>%
    dplyr::count(x, sort = TRUE) %>%
    dplyr::pull(x)
  res <- lev[seq_len(min(n, length(lev)))]
  return(res)
}



#' melt a vector into single value
#'
#' @param x vector
#' @param method how to melt, should be one of
#' `first|last`, or one of `sum|mean|median` for numeric vector,
#' or some characters (e.g. `,|.| |;`) for character vector
#' @param invalid invalid value to ignore, `NA` as default
#'
#' @return melted single value
#' @export
#'
#' @examples
#'
#' melt_vector(c(NA, 2, 3), method = "first")
#'
#' melt_vector(c(NA, 2, 3), method = "sum")
#'
#' melt_vector(c(NA, 2, 3), method = ",")
#'
#' melt_vector(c(NA, 2, Inf), invalid = c(NA, Inf))
#'
melt_vector <- function(x, method = "first", invalid = NA) {
  res <- x[x %nin% invalid]
  if (method == "first") {
    res <- res[1]
  } else if (method == "last") {
    res <- res[length(res)]
  } else if (method == "sum") {
    res <- sum(res, na.rm = TRUE)
  } else if (method == "mean") {
    res <- mean(res, na.rm = TRUE)
  } else if (method == "median") {
    res <- median(res, na.rm = TRUE)
  } else {
    res <- str_c(res, collapse = method)
  }

  return(res)
}


#' combine multiple vectors into one
#'
#' @param ... vectors
#' @param method how to combine, should be one of
#' `first|last`, or one of `sum|mean|median` for numeric vector,
#' or some characters (e.g. `,|.| |;`) for character vector
#' @param invalid invalid value to ignore, `NA` as default
#'
#' @return combined vector
#' @export
#'
#' @examples
#' x1 <- c(1, 2, NA, NA)
#' x2 <- c(3, NA, 2, NA)
#' x3 <- c(4, NA, NA, 3)
#'
#' combn_vector(x1, x2, x3, method = "sum")
#'
combn_vector <- function(..., method = "first", invalid = NA) {
  res <- apply(
    cbind(...), 1,
    melt_vector,
    method = method, invalid = invalid
  ) %>%
    unlist() %>%
    unname()
  return(res)
}
