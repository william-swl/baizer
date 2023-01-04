
<!-- README.md is generated from README.Rmd. Please edit that file -->

# baizer

<!-- badges: start -->
<!-- badges: end -->

In ancient Chinese mythology, Bai Ze is a divine beast that understands
the feelings of all creatures. The purpose of `baizer` is to provide a
set of commonly used and useful functions in data processing. Hope this
package knows what you want, and solves your problems more efficient!

## installation

You can install the development version of `baizer` like so:

``` r
devtools::install_github("william-swl/baizer")
```

``` r
library(baizer)
```

## basic utils

- use `%nin%` to get ‘not in’ logical value

``` r
1 %nin% c(1,2,3)
#> [1] FALSE

1 %nin% c(2,3)
#> [1] TRUE
```

- use `%!=na%` to get `NA` supported ‘not equal’ logical value

``` r
NA != 0
#> [1] NA

NA != NA
#> [1] NA

NA %!=na% 0
#> [1] TRUE

NA %!=na% NA
#> [1] FALSE
```

- dump a vector into string

``` r
vector_dump(c('A'=2, 'B'=3, 'C'=4), former_name = TRUE,  collapse=';')
#> [1] "A(2);B(3);C(4)"

vector_dump(c('A'=2, 'B'=3, 'C'=4), former_name = FALSE,  collapse=',')
#> [1] "2(A),3(B),4(C)"
```

- return the index of nth different character

``` r
# return all the indices by default
diff_index('ATTG', 'ATAC')
#> [1] 3 4

diff_index('ATTG', 'ATAC', nth=1)
#> [1] 3

diff_index('ATTG', 'ATAC', nth=2)
#> [1] 4
```

## numbers

- better round/signif string

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
signif_round_string(20.526, 2, 'short')
#> [1] "21"
signif_round_string(20.526, 2, 'long')
#> [1] "20.53"

# but will keep the raw value if necessary
signif_round_string(0.000002, 3)
#> [1] "0.00000200"
```

- whether the number string only has zero

``` r
is.all_zero('0.000')
#> [1] TRUE

is.all_zero('0.0001')
#> [1] FALSE
```

- float and percent trans

``` r
float_to_percent(0.123, digits=1)
#> [1] "12.3%"

percent_to_float('123%', digits=3)
#> [1] "1.230"
```

## dataframe

- a minimal dataset

``` r
head(mini_diamond)
#>    id carat   cut clarity price    x    y
#> 1 120  0.30 Ideal      IF   863 4.32 4.34
#> 2  45  0.40  Good      I1   491 4.64 4.68
#> 3  59  1.51  Good     VS2 11746 7.27 7.18
#> 4  63  0.34  Good     VS1   596 4.40 4.44
#> 5  10  2.00  Fair     SI2 15351 7.63 7.59
#> 6  58  0.90  Good     VS2  3246 6.16 6.07
```

- shortcut of `dplyr::column_to_rownames` and
  `dplyr::rownames_to_column`

``` r

head(mini_diamond) %>% c2r('id')
#>     carat   cut clarity price    x    y
#> 120  0.30 Ideal      IF   863 4.32 4.34
#> 45   0.40  Good      I1   491 4.64 4.68
#> 59   1.51  Good     VS2 11746 7.27 7.18
#> 63   0.34  Good     VS1   596 4.40 4.44
#> 10   2.00  Fair     SI2 15351 7.63 7.59
#> 58   0.90  Good     VS2  3246 6.16 6.07

head(mini_diamond) %>% c2r('id') %>% r2c('id')
#> # A tibble: 6 × 7
#>   id    carat cut   clarity price     x     y
#>   <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
#> 1 120    0.3  Ideal IF        863  4.32  4.34
#> 2 45     0.4  Good  I1        491  4.64  4.68
#> 3 59     1.51 Good  VS2     11746  7.27  7.18
#> 4 63     0.34 Good  VS1       596  4.4   4.44
#> 5 10     2    Fair  SI2     15351  7.63  7.59
#> 6 58     0.9  Good  VS2      3246  6.16  6.07
```

- better count to show a main column and a fine column

``` r

# sort by n (default)
fancy_count(mini_diamond, 'cut', 'clarity')
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                
#>   <chr> <int> <dbl> <chr>                                                  
#> 1 Fair     35  0.35 I1(5),SI1(5),VS2(5),VVS1(5),IF(4),SI2(4),VVS2(4),VS1(3)
#> 2 Ideal    34  0.34 SI1(5),VS1(5),VVS1(5),VVS2(5),I1(4),IF(4),SI2(4),VS2(2)
#> 3 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS2(4),VVS1(4),VVS2(3),VS1(2)

# sort by character order
fancy_count(mini_diamond, 'cut', 'clarity', sort=FALSE)
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                
#>   <chr> <int> <dbl> <chr>                                                  
#> 1 Fair     35  0.35 I1(5),IF(4),SI1(5),SI2(4),VS1(3),VS2(5),VVS1(5),VVS2(4)
#> 2 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS1(2),VS2(4),VVS1(4),VVS2(3)
#> 3 Ideal    34  0.34 I1(4),IF(4),SI1(5),SI2(4),VS1(5),VS2(2),VVS1(5),VVS2(5)

fancy_count(mini_diamond, 'cut', 'clarity', fine_fmt='ratio')
#> # A tibble: 3 × 4
#>   cut       n     r clarity                                                     
#>   <chr> <int> <dbl> <chr>                                                       
#> 1 Fair     35  0.35 I1(0.14),SI1(0.14),VS2(0.14),VVS1(0.14),IF(0.11),SI2(0.11),…
#> 2 Ideal    34  0.34 SI1(0.15),VS1(0.15),VVS1(0.15),VVS2(0.15),I1(0.12),IF(0.12)…
#> 3 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS2(0.13),VVS1(0.13),…

fancy_count(mini_diamond, 'cut', 'clarity', fine_fmt='clean')
#> # A tibble: 3 × 4
#>   cut       n     r clarity                        
#>   <chr> <int> <dbl> <chr>                          
#> 1 Fair     35  0.35 I1,SI1,VS2,VVS1,IF,SI2,VVS2,VS1
#> 2 Ideal    34  0.34 SI1,VS1,VVS1,VVS2,I1,IF,SI2,VS2
#> 3 Good     31  0.31 I1,IF,SI1,SI2,VS2,VVS1,VVS2,VS1
```
