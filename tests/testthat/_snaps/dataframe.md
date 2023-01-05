# c2r

    Code
      head(mini_diamond) %>% c2r("id")
    Output
           carat   cut clarity price    x    y
      id-1  1.02  Fair     SI1  3027 6.25 6.18
      id-2  1.51  Good     VS2 11746 7.27 7.18
      id-3  0.52 Ideal    VVS1  2029 5.15 5.18
      id-4  1.54 Ideal     SI2  9452 7.43 7.45
      id-5  0.72 Ideal     VS1  2498 5.73 5.77
      id-6  2.02  Fair     SI2 14080 8.33 8.37

# fancy_count, fine_fmt='count'

    Code
      fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "count")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),SI1(5),VS2(5),VVS1(5),IF(4),SI2(4),VVS2(4),VS1(3)
      2 Ideal    34  0.34 SI1(5),VS1(5),VVS1(5),VVS2(5),I1(4),IF(4),SI2(4),VS2(2)
      3 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS2(4),VVS1(4),VVS2(3),VS1(2)

# fancy_count, fine_fmt='ratio'

    Code
      fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "ratio")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                     
        <chr> <int> <dbl> <chr>                                                       
      1 Fair     35  0.35 I1(0.14),SI1(0.14),VS2(0.14),VVS1(0.14),IF(0.11),SI2(0.11),~
      2 Ideal    34  0.34 SI1(0.15),VS1(0.15),VVS1(0.15),VVS2(0.15),I1(0.12),IF(0.12)~
      3 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS2(0.13),VVS1(0.13),~

# fancy_count, fine_fmt='clean'

    Code
      fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "clean")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                        
        <chr> <int> <dbl> <chr>                          
      1 Fair     35  0.35 I1,SI1,VS2,VVS1,IF,SI2,VVS2,VS1
      2 Ideal    34  0.34 SI1,VS1,VVS1,VVS2,I1,IF,SI2,VS2
      3 Good     31  0.31 I1,IF,SI1,SI2,VS2,VVS1,VVS2,VS1

# fancy_count, sort=TRUE

    Code
      fancy_count(mini_diamond, "cut", "clarity", sort = TRUE)
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),SI1(5),VS2(5),VVS1(5),IF(4),SI2(4),VVS2(4),VS1(3)
      2 Ideal    34  0.34 SI1(5),VS1(5),VVS1(5),VVS2(5),I1(4),IF(4),SI2(4),VS2(2)
      3 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS2(4),VVS1(4),VVS2(3),VS1(2)

# ordered_slice

    Code
      ordered_slice(mini_diamond, "id", c("id-3", "id-2"))
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18

# ordered_slice, with NA and dup

    Code
      ordered_slice(mini_diamond, "id", c("id-3", "id-2", "id-3", NA, NA))
    Warning <simpleWarning>
      2 NA values!
      2 duplicated values!
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18
      3 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      4 <NA>  NA    <NA>  <NA>       NA NA    NA   
      5 <NA>  NA    <NA>  <NA>       NA NA    NA   

# ordered_slice, with unknown id

    Code
      ordered_slice(mini_diamond, "id", c("id-3", "unknown-id"))
    Warning <simpleWarning>
      1 NA values!
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 <NA>  NA    <NA>  <NA>       NA NA    NA   

