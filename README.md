
<!-- README.md is generated from README.Rmd. Please edit that file -->

# baizer <img src="man/figures/logo.png" align="right" />

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/william-swl/baizer/branch/master/graph/badge.svg)](https://app.codecov.io/gh/william-swl/baizer?branch=master)
[![R-CMD-check](https://github.com/william-swl/baizer/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/william-swl/baizer/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

- In ancient Chinese mythology, Bai Ze is a divine creature that knows
  the needs of everything.
- `baizer` provides data processing functions frequently used by the
  author.
- Hope this package also knows what you want!

## installation

You can install the stable version of `baizer` like so:

``` r
install.packages("baizer")
```

Or install the development version of `baizer` like so:

``` r
devtools::install_github("william-swl/baizer")
```

## S3 classes in `baizer`

### tbflt

- save a series of filter conditions, and support logical operating
  among conditions
- use `filterC` to apply `tbflt` on `dplyr::filter`

``` r
c1 <- tbflt(cut == "Fair")
c2 <- tbflt(x > 8)
c1 | c2
#> cut == "Fair" | x > 8

mini_diamond %>%
  filterC(c1) %>%
  head(5)
#> # A tibble: 5 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-1   1.02 Fair  SI1      3027  6.25  6.18
#> 2 id-6   2.02 Fair  SI2     14080  8.33  8.37
#> 3 id-10  0.7  Fair  VVS1     1691  5.56  5.41
#> 4 id-12  0.71 Fair  IF       3205  5.87  5.81
#> 5 id-18  0.34 Fair  VVS1     1012  4.8   4.76

mini_diamond %>%
  filterC(!c1) %>%
  head(5)
#> # A tibble: 5 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 2 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 3 id-4   1.54 Ideal SI2      9452  7.43  7.45
#> 4 id-5   0.72 Ideal VS1      2498  5.73  5.77
#> 5 id-7   0.27 Good  VVS1      752  4.1   4.07

mini_diamond %>% filterC(c1 & c2)
#> # A tibble: 3 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-6   2.02 Fair  SI2     14080  8.33  8.37
#> 2 id-48  2.01 Fair  I1       7294  8.3   8.19
#> 3 id-68  2.32 Fair  SI1     18026  8.47  8.31
```

## basic utils

- use `%nin%` to get ‘not in’ logical value

``` r
1 %nin% c(1, 2, 3)
#> [1] FALSE

1 %nin% c(2, 3)
#> [1] TRUE
```

- use `%neq%` to get `NA` supported ‘not equal’ logical value

``` r
NA != 0
#> [1] NA

NA != NA
#> [1] NA

NA %neq% 0
#> [1] TRUE

NA %neq% NA
#> [1] FALSE
```

- dump a vector into string

``` r
collapse_vector(c("A" = 2, "B" = 3, "C" = 4), front_name = TRUE, collapse = ";")
#> [1] "A(2);B(3);C(4)"

collapse_vector(c("A" = 2, "B" = 3, "C" = 4), front_name = FALSE, collapse = ",")
#> [1] "2(A),3(B),4(C)"
```

- the index of different character

``` r
diff_index("AAAA", "ABBA")
#> [[1]]
#> [1] 2 3

# ignore case
diff_index("AAAA", "abba", ignore_case = TRUE)
#> [[1]]
#> [1] 2 3

# only the index of nth different character, NA if unaccessible
diff_index("AAAA", "ABBA", nth = 2)
#> [[1]]
#> [1] 3

diff_index("AAAA", "ABBA", 10)
#> [[1]]
#> [1] NA

# second and third indices
diff_index("AAAA", "ABBB", nth = 2:3)
#> [[1]]
#> [1] 3 4

# support vectorized operations
diff_index(c("ABBA", "AABB"), "AAAA")
#> [[1]]
#> [1] 2 3
#> 
#> [[2]]
#> [1] 3 4
```

- the index of same character

``` r
# just like diff_index
same_index(c("ABBA", "AABB"), "AAAA")
#> [[1]]
#> [1] 1 4
#> 
#> [[2]]
#> [1] 1 2
```

- fetch character from strings

``` r
fetch_char(rep("ABC", 3), list(1, 2, 3))
#> [[1]]
#> [1] "A"
#> 
#> [[2]]
#> [1] "B"
#> 
#> [[3]]
#> [1] "C"

# accept the output of `diff_index` or `same_index`
str1 <- c("ABCD", "AAEF")
str2 <- c("AAAA", "AAAA")
fetch_char(str1, diff_index(str1, str2))
#> [[1]]
#> [1] "B" "C" "D"
#> 
#> [[2]]
#> [1] "E" "F"

# if the output of `diff_index` have NA, also return NA
fetch_char(str1, diff_index(str1, str2, nth = 1:3), na.rm = FALSE)
#> [[1]]
#> [1] "B" "C" "D"
#> 
#> [[2]]
#> [1] "E" "F" NA

# remove NA
fetch_char(str1, diff_index(str1, str2, nth = 1:5), na.rm = TRUE)
#> [[1]]
#> [1] "B" "C" "D"
#> 
#> [[2]]
#> [1] "E" "F"

# collapse the characters from a same string
fetch_char(str1, diff_index(str1, str2, nth = 1:5), na.rm = TRUE, collapse = ",")
#> [[1]]
#> [1] "B,C,D"
#> 
#> [[2]]
#> [1] "E,F"
```

- trans fixed string into regular expression string

``` r
fix_to_regex("ABC|?(*)")
#> [1] "ABC\\|\\?\\(\\*\\)"
```

- detect possible duplication in a vector, ignore case, blank and
  special character

``` r
detect_dup(c("a", "B", "C_", "c -", "#A"))
#> [1] "a"   "#A"  "C_"  "c -"
```

- extract key and values for a character vector

``` r
extract_kv(c("x: 1", "y: 2"))
#>   x   y 
#> "1" "2"
```

- farthest point sampling (FPS) for a vector

``` r
fps_vector(1:10, 2)
#> [1]  1 10

fps_vector(1:10, 4)
#> [1]  1  4  7 10

fps_vector(c(1, 2, NULL), 2)
#> [1] 1 2

fps_vector(c(1, 2, NA), 2)
#> [1]  1 NA
```

## numbers

- from float number to fixed digits character

``` r
round(2.1951, 2)
#> [1] 2.2

round_string(2.1951, 2)
#> [1] "2.20"

signif(2.1951, 3)
#> [1] 2.2

signif_string(2.1951, 3)
#> [1] "2.20"
```

- signif or round string depend on the character length

``` r
signif_round_string(20.526, 2, "short")
#> [1] "21"
signif_round_string(20.526, 2, "long")
#> [1] "20.53"

# but will keep the raw value if necessary
signif_round_string(0.000002654, 3)
#> [1] "0.00000265"
```

- whether the number string only has zero

``` r
is.zero("0.000")
#> [1] TRUE

is.zero("0.0001")
#> [1] FALSE
```

- float and percent trans

``` r
float_to_percent(0.123, digits = 1)
#> [1] "12.3%"

percent_to_float("123%", digits = 3)
#> [1] "1.230"
```

- wrapper of the functions to process number string with prefix and
  suffix

``` r
number_fun_wrapper(">=2.134%", function(x) round(x, 2))
#> [1] ">=2.13%"
```

- expand a number vector according to the adjacent two numbers

``` r
adjacent_div(10^c(1:3), n_div = 10)
#>  [1]   10   20   30   40   50   60   70   80   90  100  100  200  300  400  500
#> [16]  600  700  800  900 1000

# only keep the unique numbers
adjacent_div(10^c(1:3), n_div = 10, .unique = TRUE)
#>  [1]   10   20   30   40   50   60   70   80   90  100  200  300  400  500  600
#> [16]  700  800  900 1000
```

## dataframe

- a minimal dataset

``` r
head(mini_diamond)
#> # A tibble: 6 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-1   1.02 Fair  SI1      3027  6.25  6.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 3 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 4 id-4   1.54 Ideal SI2      9452  7.43  7.45
#> 5 id-5   0.72 Ideal VS1      2498  5.73  5.77
#> 6 id-6   2.02 Fair  SI2     14080  8.33  8.37
```

- shortcut of `dplyr::column_to_rownames` and
  `dplyr::rownames_to_column`

``` r
head(mini_diamond) %>% c2r("id")
#>      carat   cut clarity price    x    y
#> id-1  1.02  Fair     SI1  3027 6.25 6.18
#> id-2  1.51  Good     VS2 11746 7.27 7.18
#> id-3  0.52 Ideal    VVS1  2029 5.15 5.18
#> id-4  1.54 Ideal     SI2  9452 7.43 7.45
#> id-5  0.72 Ideal     VS1  2498 5.73 5.77
#> id-6  2.02  Fair     SI2 14080 8.33 8.37

# use column index
head(mini_diamond) %>% c2r(1)
#>      carat   cut clarity price    x    y
#> id-1  1.02  Fair     SI1  3027 6.25 6.18
#> id-2  1.51  Good     VS2 11746 7.27 7.18
#> id-3  0.52 Ideal    VVS1  2029 5.15 5.18
#> id-4  1.54 Ideal     SI2  9452 7.43 7.45
#> id-5  0.72 Ideal     VS1  2498 5.73 5.77
#> id-6  2.02  Fair     SI2 14080 8.33 8.37

head(mini_diamond) %>%
  c2r("id") %>%
  r2c("id")
#> # A tibble: 6 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-1   1.02 Fair  SI1      3027  6.25  6.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 3 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 4 id-4   1.54 Ideal SI2      9452  7.43  7.45
#> 5 id-5   0.72 Ideal VS1      2498  5.73  5.77
#> 6 id-6   2.02 Fair  SI2     14080  8.33  8.37
```

- fancy count to show an extended column

``` r

# count one column
fancy_count(mini_diamond, cut)
#> # A tibble: 3 × 3
#>   cut       n     r
#>   <chr> <int> <dbl>
#> 1 Fair     35  0.35
#> 2 Ideal    34  0.34
#> 3 Good     31  0.31

# count an extended column, in a default order by n
fancy_count(mini_diamond, cut, ext = clarity)
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                
#>   <chr> <int> <dbl> <chr>                                                  
#> 1 Fair     35  0.35 I1(5),SI1(5),VS2(5),VVS1(5),IF(4),SI2(4),VVS2(4),VS1(3)
#> 2 Ideal    34  0.34 SI1(5),VS1(5),VVS1(5),VVS2(5),I1(4),IF(4),SI2(4),VS2(2)
#> 3 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS2(4),VVS1(4),VVS2(3),VS1(2)

# change format
fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                     
#>   <chr> <int> <dbl> <chr>                                                       
#> 1 Fair     35  0.35 I1(0.14),SI1(0.14),VS2(0.14),VVS1(0.14),IF(0.11),SI2(0.11),…
#> 2 Ideal    34  0.34 SI1(0.15),VS1(0.15),VVS1(0.15),VVS2(0.15),I1(0.12),IF(0.12)…
#> 3 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS2(0.13),VVS1(0.13),…

fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
#> # A tibble: 3 × 4
#>   cut       n     r clarity                        
#>   <chr> <int> <dbl> <chr>                          
#> 1 Fair     35  0.35 I1,SI1,VS2,VVS1,IF,SI2,VVS2,VS1
#> 2 Ideal    34  0.34 SI1,VS1,VVS1,VVS2,I1,IF,SI2,VS2
#> 3 Good     31  0.31 I1,IF,SI1,SI2,VS2,VVS1,VVS2,VS1

# count an extended column, in an order by character
fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                
#>   <chr> <int> <dbl> <chr>                                                  
#> 1 Fair     35  0.35 I1(5),IF(4),SI1(5),SI2(4),VS1(3),VS2(5),VVS1(5),VVS2(4)
#> 2 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS1(2),VS2(4),VVS1(4),VVS2(3)
#> 3 Ideal    34  0.34 I1(4),IF(4),SI1(5),SI2(4),VS1(5),VS2(2),VVS1(5),VVS2(5)

# extended column after a two-column count
fancy_count(mini_diamond, cut, clarity, ext = id) %>% head(5)
#> # A tibble: 5 × 5
#>   cut   clarity     n     r id                                          
#>   <chr> <chr>   <int> <dbl> <chr>                                       
#> 1 Fair  I1          5  0.05 id-20(1),id-23(1),id-28(1),id-32(1),id-48(1)
#> 2 Fair  SI1         5  0.05 id-1(1),id-64(1),id-65(1),id-68(1),id-76(1) 
#> 3 Fair  VS2         5  0.05 id-52(1),id-63(1),id-66(1),id-70(1),id-77(1)
#> 4 Fair  VVS1        5  0.05 id-10(1),id-18(1),id-46(1),id-55(1),id-59(1)
#> 5 Good  I1          5  0.05 id-16(1),id-34(1),id-69(1),id-82(1),id-91(1)
```

- split a column and return a longer tibble

``` r
fancy_count(mini_diamond, cut, ext = clarity) %>%
  split_column(name_col = cut, value_col = clarity)
#> # A tibble: 24 × 2
#>    cut   clarity
#>    <chr> <chr>  
#>  1 Fair  I1(5)  
#>  2 Fair  SI1(5) 
#>  3 Fair  VS2(5) 
#>  4 Fair  VVS1(5)
#>  5 Fair  IF(4)  
#>  6 Fair  SI2(4) 
#>  7 Fair  VVS2(4)
#>  8 Fair  VS1(3) 
#>  9 Ideal SI1(5) 
#> 10 Ideal VS1(5) 
#> # … with 14 more rows
```

- move selected rows to target location

``` r
# move row 3-5 after row 8
move_row(mini_diamond, 3:5, .after = 8)
#> # A tibble: 100 × 7
#>    id    carat cut   clarity price     x     y
#>    <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#>  1 id-1   1.02 Fair  SI1      3027  6.25  6.18
#>  2 id-2   1.51 Good  VS2     11746  7.27  7.18
#>  3 id-6   2.02 Fair  SI2     14080  8.33  8.37
#>  4 id-7   0.27 Good  VVS1      752  4.1   4.07
#>  5 id-8   0.51 Good  SI2      1029  5.05  5.08
#>  6 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#>  7 id-4   1.54 Ideal SI2      9452  7.43  7.45
#>  8 id-5   0.72 Ideal VS1      2498  5.73  5.77
#>  9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
#> 10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
#> # … with 90 more rows

# move row 3-5 before the first row
move_row(mini_diamond, 3:5, .before = TRUE)
#> # A tibble: 100 × 7
#>    id    carat cut   clarity price     x     y
#>    <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#>  1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#>  2 id-4   1.54 Ideal SI2      9452  7.43  7.45
#>  3 id-5   0.72 Ideal VS1      2498  5.73  5.77
#>  4 id-1   1.02 Fair  SI1      3027  6.25  6.18
#>  5 id-2   1.51 Good  VS2     11746  7.27  7.18
#>  6 id-6   2.02 Fair  SI2     14080  8.33  8.37
#>  7 id-7   0.27 Good  VVS1      752  4.1   4.07
#>  8 id-8   0.51 Good  SI2      1029  5.05  5.08
#>  9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
#> 10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
#> # … with 90 more rows

# move row 3-5 after the last row
move_row(mini_diamond, 3:5, .after = TRUE)
#> # A tibble: 100 × 7
#>    id    carat cut   clarity price     x     y
#>    <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#>  1 id-1   1.02 Fair  SI1      3027  6.25  6.18
#>  2 id-2   1.51 Good  VS2     11746  7.27  7.18
#>  3 id-6   2.02 Fair  SI2     14080  8.33  8.37
#>  4 id-7   0.27 Good  VVS1      752  4.1   4.07
#>  5 id-8   0.51 Good  SI2      1029  5.05  5.08
#>  6 id-9   1.01 Ideal SI1      5590  6.43  6.4 
#>  7 id-10  0.7  Fair  VVS1     1691  5.56  5.41
#>  8 id-11  1.02 Good  VVS1     7861  6.37  6.4 
#>  9 id-12  0.71 Fair  IF       3205  5.87  5.81
#> 10 id-13  0.56 Ideal SI1      1633  5.31  5.32
#> # … with 90 more rows
```

- slice a tibble by an ordered vector

``` r
ordered_slice(mini_diamond, id, c("id-3", "id-2"))
#> # A tibble: 2 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18

# support NA and known values in ordered vector
ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", "id-3", NA))
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> NA values!
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> duplicated values!
#> # A tibble: 5 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 3 <NA>  NA    <NA>  <NA>       NA NA    NA   
#> 4 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 5 <NA>  NA    <NA>  <NA>       NA NA    NA

# remove NA
ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", "id-3", NA),
  na.rm = TRUE
)
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> NA values!
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> duplicated values!
#> # A tibble: 3 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 3 id-3   0.52 Ideal VVS1     2029  5.15  5.18

# remove duplication
ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", "id-3", NA),
  dup.rm = TRUE
)
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> NA values!
#> Warning in ordered_slice(mini_diamond, id, c("id-3", "id-2", "unknown_id", : 2
#> duplicated values!
#> # A tibble: 3 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
#> 2 id-2   1.51 Good  VS2     11746  7.27  7.18
#> 3 <NA>  NA    <NA>  <NA>       NA NA    NA
```

## stat

- statistical test which returns a extensible tibble

``` r
stat_test(mini_diamond, y = price, x = cut, .by = clarity)
#> # A tibble: 24 × 11
#>    clarity .y.   group1 group2    n1    n2 statistic     p p.adj p.adj…¹ p.sig…²
#>    <chr>   <chr> <chr>  <chr>  <int> <int>     <dbl> <dbl> <dbl> <chr>   <chr>  
#>  1 I1      price Fair   Good       5     5        18 0.31  0.62  ns      NS     
#>  2 I1      price Fair   Ideal      5     4        11 0.905 0.905 ns      NS     
#>  3 I1      price Good   Ideal      5     4         4 0.19  0.57  ns      NS     
#>  4 IF      price Fair   Good       4     5        18 0.064 0.177 ns      NS     
#>  5 IF      price Fair   Ideal      4     4        15 0.059 0.177 ns      NS     
#>  6 IF      price Good   Ideal      5     4        10 1     1     ns      NS     
#>  7 SI1     price Fair   Good       5     4        10 1     1     ns      NS     
#>  8 SI1     price Fair   Ideal      5     5        13 1     1     ns      NS     
#>  9 SI1     price Good   Ideal      4     5         6 0.413 1     ns      NS     
#> 10 SI2     price Fair   Good       4     4        15 0.057 0.171 ns      NS     
#> # … with 14 more rows, and abbreviated variable names ¹​p.adj.signif, ²​p.signif
```

- fold change calculation which returns a extensible tibble

``` r
stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
#> # A tibble: 72 × 7
#>    clarity group1 group2    y1    y2    fc fc_fmt
#>    <chr>   <chr>  <chr>  <dbl> <dbl> <dbl> <chr> 
#>  1 SI1     Fair   Fair   5844. 5844.  1    1.0x  
#>  2 SI1     Fair   Ideal  5844. 3877.  1.51 1.5x  
#>  3 SI1     Fair   Good   5844. 3227.  1.81 1.8x  
#>  4 VS2     Good   Good   5582. 5582.  1    1.0x  
#>  5 VS2     Good   Ideal  5582. 3024.  1.85 1.8x  
#>  6 VS2     Good   Fair   5582. 3529.  1.58 1.6x  
#>  7 VVS1    Ideal  Ideal  4652. 4652.  1    1.0x  
#>  8 VVS1    Ideal  Good   4652. 2810.  1.66 1.7x  
#>  9 VVS1    Ideal  Fair   4652. 2184   2.13 2.1x  
#> 10 SI2     Ideal  Ideal  4267. 4267.  1    1.0x  
#> # … with 62 more rows
```

## IO

- load packages as a batch

``` r
baizer::pkglib(dplyr, purrr, tidyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

- get the command line arguments

``` r
cmdargs()
#> $wd
#> [1] "/home/william/rpkg/baizer"
#> 
#> $R_env
#> [1] "/home/william/software/mambaforge/envs/baizer/lib/R/bin/exec/R"
#> 
#> $script_path
#> character(0)
#> 
#> $script_dir
#> character(0)
#> 
#> $env_configs
#> [1] "--slave"                               
#> [2] "--no-save"                             
#> [3] "--no-restore"                          
#> [4] "-f"                                    
#> [5] "/tmp/RtmpnpISG6/callr-scr-2f9322f7eb79"

cmdargs("R_env")
#> [1] "/home/william/software/mambaforge/envs/baizer/lib/R/bin/exec/R"
```

- write a tibble, or a list of tibbles into an excel file

``` r
# write_excel(mini_diamond, "mini_diamond.xlsx")

# Ldf <- list(mini_diamond[1:3, ], mini_diamond[4:6, ])
# write_excel(Ldf, '2sheets.xlsx')
```

## Code of Conduct

Please note that the baizer project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
