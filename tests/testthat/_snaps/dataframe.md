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
      2 Ideal    34  0.34
      3 Good     31  0.31

# fancy_count, ext_fmt='count'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "count")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),SI1(5),VS2(5),VVS1(5),IF(4),SI2(4),VVS2(4),VS1(3)
      2 Ideal    34  0.34 SI1(5),VS1(5),VVS1(5),VVS2(5),I1(4),IF(4),SI2(4),VS2(2)
      3 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS2(4),VVS1(4),VVS2(3),VS1(2)

# fancy_count, ext_fmt='ratio'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                     
        <chr> <int> <dbl> <chr>                                                       
      1 Fair     35  0.35 I1(0.14),SI1(0.14),VS2(0.14),VVS1(0.14),IF(0.11),SI2(0.11),~
      2 Ideal    34  0.34 SI1(0.15),VS1(0.15),VVS1(0.15),VVS2(0.15),I1(0.12),IF(0.12)~
      3 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS2(0.13),VVS1(0.13),~

# fancy_count, ext_fmt='clean'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                        
        <chr> <int> <dbl> <chr>                          
      1 Fair     35  0.35 I1,SI1,VS2,VVS1,IF,SI2,VVS2,VS1
      2 Ideal    34  0.34 SI1,VS1,VVS1,VVS2,I1,IF,SI2,VS2
      3 Good     31  0.31 I1,IF,SI1,SI2,VS2,VVS1,VVS2,VS1

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
       2 Fair  SI1         5  0.05 id-1(1),id-64(1),id-65(1),id-68(1),id-76(1) 
       3 Fair  VS2         5  0.05 id-52(1),id-63(1),id-66(1),id-70(1),id-77(1)
       4 Fair  VVS1        5  0.05 id-10(1),id-18(1),id-46(1),id-55(1),id-59(1)
       5 Good  I1          5  0.05 id-16(1),id-34(1),id-69(1),id-82(1),id-91(1)
       6 Good  IF          5  0.05 id-15(1),id-53(1),id-56(1),id-61(1),id-62(1)
       7 Ideal SI1         5  0.05 id-13(1),id-47(1),id-84(1),id-9(1),id-93(1) 
       8 Ideal VS1         5  0.05 id-26(1),id-5(1),id-78(1),id-80(1),id-94(1) 
       9 Ideal VVS1        5  0.05 id-3(1),id-31(1),id-35(1),id-37(1),id-83(1) 
      10 Ideal VVS2        5  0.05 id-14(1),id-19(1),id-54(1),id-60(1),id-96(1)
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
       2 Fair  SI1(5) 
       3 Fair  VS2(5) 
       4 Fair  VVS1(5)
       5 Fair  IF(4)  
       6 Fair  SI2(4) 
       7 Fair  VVS2(4)
       8 Fair  VS1(3) 
       9 Ideal SI1(5) 
      10 Ideal VS1(5) 
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
      ordered_slice(mini_diamond, id, c("id-3", "unknown-id"))
    Warning <simpleWarning>
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
    Warning <simpleWarning>
      3 NA values!
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
    Warning <simpleWarning>
      3 NA values!
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
    Warning <simpleWarning>
      3 NA values!
      3 duplicated values!
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18

