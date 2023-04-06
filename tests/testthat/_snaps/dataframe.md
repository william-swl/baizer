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

# fancy_count, one column

    Code
      fancy_count(mini_diamond, cut)
    Output
      # A tibble: 3 x 3
        cut       n     r
        <chr> <int> <dbl>
      1 Fair     35  0.35
      2 Good     31  0.31
      3 Ideal    34  0.34

# fancy_count, ext_fmt='count'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "count")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),IF(4),SI1(5),SI2(4),VS1(3),VS2(5),VVS1(5),VVS2(4)
      2 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS1(2),VS2(4),VVS1(4),VVS2(3)
      3 Ideal    34  0.34 I1(4),IF(4),SI1(5),SI2(4),VS1(5),VS2(2),VVS1(5),VVS2(5)

# fancy_count, ext_fmt='ratio'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                     
        <chr> <int> <dbl> <chr>                                                       
      1 Fair     35  0.35 I1(0.14),IF(0.11),SI1(0.14),SI2(0.11),VS1(0.09),VS2(0.14),V~
      2 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS1(0.06),VS2(0.13),V~
      3 Ideal    34  0.34 I1(0.12),IF(0.12),SI1(0.15),SI2(0.12),VS1(0.15),VS2(0.06),V~

# fancy_count, ext_fmt='clean'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                        
        <chr> <int> <dbl> <chr>                          
      1 Fair     35  0.35 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2
      2 Good     31  0.31 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2
      3 Ideal    34  0.34 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2

# fancy_count, sort=FALSE

    Code
      fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),IF(4),SI1(5),SI2(4),VS1(3),VS2(5),VVS1(5),VVS2(4)
      2 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS1(2),VS2(4),VVS1(4),VVS2(3)
      3 Ideal    34  0.34 I1(4),IF(4),SI1(5),SI2(4),VS1(5),VS2(2),VVS1(5),VVS2(5)

# fancy_count, three column

    Code
      fancy_count(mini_diamond, cut, clarity, ext = id)
    Output
      # A tibble: 24 x 5
         cut   clarity     n     r id                                          
         <chr> <chr>   <int> <dbl> <chr>                                       
       1 Fair  I1          5  0.05 id-20(1),id-23(1),id-28(1),id-32(1),id-48(1)
       2 Fair  IF          4  0.04 id-12(1),id-45(1),id-89(1),id-95(1)         
       3 Fair  SI1         5  0.05 id-1(1),id-64(1),id-65(1),id-68(1),id-76(1) 
       4 Fair  SI2         4  0.04 id-25(1),id-40(1),id-6(1),id-99(1)          
       5 Fair  VS1         3  0.03 id-36(1),id-43(1),id-85(1)                  
       6 Fair  VS2         5  0.05 id-52(1),id-63(1),id-66(1),id-70(1),id-77(1)
       7 Fair  VVS1        5  0.05 id-10(1),id-18(1),id-46(1),id-55(1),id-59(1)
       8 Fair  VVS2        4  0.04 id-30(1),id-58(1),id-79(1),id-98(1)         
       9 Good  I1          5  0.05 id-16(1),id-34(1),id-69(1),id-82(1),id-91(1)
      10 Good  IF          5  0.05 id-15(1),id-53(1),id-56(1),id-61(1),id-62(1)
      # ... with 14 more rows

# expand_df

    Code
      fancy_count(mini_diamond, cut, ext = clarity) %>% split_column(name_col = cut,
        value_col = clarity)
    Output
      # A tibble: 24 x 2
         cut   clarity
         <chr> <chr>  
       1 Fair  I1(5)  
       2 Fair  IF(4)  
       3 Fair  SI1(5) 
       4 Fair  SI2(4) 
       5 Fair  VS1(3) 
       6 Fair  VS2(5) 
       7 Fair  VVS1(5)
       8 Fair  VVS2(4)
       9 Good  I1(5)  
      10 Good  IF(5)  
      # ... with 14 more rows

# move_row, .after=TRUE

    Code
      move_row(mini_diamond, 3:5, .after = TRUE)
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-2   1.51 Good  VS2     11746  7.27  7.18
       3 id-6   2.02 Fair  SI2     14080  8.33  8.37
       4 id-7   0.27 Good  VVS1      752  4.1   4.07
       5 id-8   0.51 Good  SI2      1029  5.05  5.08
       6 id-9   1.01 Ideal SI1      5590  6.43  6.4 
       7 id-10  0.7  Fair  VVS1     1691  5.56  5.41
       8 id-11  1.02 Good  VVS1     7861  6.37  6.4 
       9 id-12  0.71 Fair  IF       3205  5.87  5.81
      10 id-13  0.56 Ideal SI1      1633  5.31  5.32
      # ... with 90 more rows

# move_row, after last row

    Code
      move_row(mini_diamond, 3:5, .after = nrow(mini_diamond))
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-2   1.51 Good  VS2     11746  7.27  7.18
       3 id-6   2.02 Fair  SI2     14080  8.33  8.37
       4 id-7   0.27 Good  VVS1      752  4.1   4.07
       5 id-8   0.51 Good  SI2      1029  5.05  5.08
       6 id-9   1.01 Ideal SI1      5590  6.43  6.4 
       7 id-10  0.7  Fair  VVS1     1691  5.56  5.41
       8 id-11  1.02 Good  VVS1     7861  6.37  6.4 
       9 id-12  0.71 Fair  IF       3205  5.87  5.81
      10 id-13  0.56 Ideal SI1      1633  5.31  5.32
      # ... with 90 more rows

# move_row, after first row

    Code
      move_row(mini_diamond, 3:5, .after = 1)
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       3 id-4   1.54 Ideal SI2      9452  7.43  7.45
       4 id-5   0.72 Ideal VS1      2498  5.73  5.77
       5 id-2   1.51 Good  VS2     11746  7.27  7.18
       6 id-6   2.02 Fair  SI2     14080  8.33  8.37
       7 id-7   0.27 Good  VVS1      752  4.1   4.07
       8 id-8   0.51 Good  SI2      1029  5.05  5.08
       9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
      10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
      # ... with 90 more rows

# move_row, .before=TRUE

    Code
      move_row(mini_diamond, 3:5, .before = TRUE)
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       2 id-4   1.54 Ideal SI2      9452  7.43  7.45
       3 id-5   0.72 Ideal VS1      2498  5.73  5.77
       4 id-1   1.02 Fair  SI1      3027  6.25  6.18
       5 id-2   1.51 Good  VS2     11746  7.27  7.18
       6 id-6   2.02 Fair  SI2     14080  8.33  8.37
       7 id-7   0.27 Good  VVS1      752  4.1   4.07
       8 id-8   0.51 Good  SI2      1029  5.05  5.08
       9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
      10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
      # ... with 90 more rows

# move_row, beofre first row

    Code
      move_row(mini_diamond, 3:5, .before = 1)
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       2 id-4   1.54 Ideal SI2      9452  7.43  7.45
       3 id-5   0.72 Ideal VS1      2498  5.73  5.77
       4 id-1   1.02 Fair  SI1      3027  6.25  6.18
       5 id-2   1.51 Good  VS2     11746  7.27  7.18
       6 id-6   2.02 Fair  SI2     14080  8.33  8.37
       7 id-7   0.27 Good  VVS1      752  4.1   4.07
       8 id-8   0.51 Good  SI2      1029  5.05  5.08
       9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
      10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
      # ... with 90 more rows

# move_row, beofre last row

    Code
      move_row(mini_diamond, 3:5, .before = nrow(mini_diamond))
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-2   1.51 Good  VS2     11746  7.27  7.18
       3 id-6   2.02 Fair  SI2     14080  8.33  8.37
       4 id-7   0.27 Good  VVS1      752  4.1   4.07
       5 id-8   0.51 Good  SI2      1029  5.05  5.08
       6 id-9   1.01 Ideal SI1      5590  6.43  6.4 
       7 id-10  0.7  Fair  VVS1     1691  5.56  5.41
       8 id-11  1.02 Good  VVS1     7861  6.37  6.4 
       9 id-12  0.71 Fair  IF       3205  5.87  5.81
      10 id-13  0.56 Ideal SI1      1633  5.31  5.32
      # ... with 90 more rows

# move_row

    Code
      move_row(mini_diamond, 3:5, .after = 8)
    Output
      # A tibble: 100 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-2   1.51 Good  VS2     11746  7.27  7.18
       3 id-6   2.02 Fair  SI2     14080  8.33  8.37
       4 id-7   0.27 Good  VVS1      752  4.1   4.07
       5 id-8   0.51 Good  SI2      1029  5.05  5.08
       6 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       7 id-4   1.54 Ideal SI2      9452  7.43  7.45
       8 id-5   0.72 Ideal VS1      2498  5.73  5.77
       9 id-9   1.01 Ideal SI1      5590  6.43  6.4 
      10 id-10  0.7  Fair  VVS1     1691  5.56  5.41
      # ... with 90 more rows

# ordered_slice

    Code
      ordered_slice(mini_diamond, id, c("id-3", "id-2"))
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18

# ordered_slice, with NA and dup

    Code
      ordered_slice(mini_diamond, id, c("id-3", "id-2", "id-3", NA, NA))
    Condition
      Warning in `ordered_slice()`:
      2 NA values!
      Warning in `ordered_slice()`:
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
      ordered_slice(mini_diamond, id, c("id-3", "unknown-id"))
    Condition
      Warning in `ordered_slice()`:
      1 NA values!
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 <NA>  NA    <NA>  <NA>       NA NA    NA   

# ordered_slice, remove dup

    Code
      ordered_slice(mini_diamond, id, c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      dup.rm = TRUE)
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
      3 duplicated values!
    Output
      # A tibble: 3 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18
      3 <NA>  NA    <NA>  <NA>       NA NA    NA   

# ordered_slice, remove NA

    Code
      ordered_slice(mini_diamond, id, c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE)
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
      3 duplicated values!
    Output
      # A tibble: 3 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18
      3 id-3   0.52 Ideal VVS1     2029  5.15  5.18

# ordered_slice, remove dup and NA

    Code
      ordered_slice(mini_diamond, id, c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE, dup = TRUE)
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
      3 duplicated values!
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18

# hist_bins

    Code
      hist_bins(vector)
    Output
      # A tibble: 100 x 5
         id    value  start    end   bin
         <chr> <int>  <dbl>  <dbl> <int>
       1 id-1   3027  2218.  3975.     2
       2 id-2  11746 11000. 12757.     7
       3 id-3   2029   462   2218.     1
       4 id-4   9452  9244  11000.     6
       5 id-5   2498  2218.  3975.     2
       6 id-6  14080 12757. 14513.     8
       7 id-7    752   462   2218.     1
       8 id-8   1029   462   2218.     1
       9 id-9   5590  3975.  5731.     3
      10 id-10  1691   462   2218.     1
      # ... with 90 more rows

