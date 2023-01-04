# c2r

    Code
      head(mini_diamond) %>% c2r("id")
    Output
          carat   cut clarity price    x    y
      120  0.30 Ideal      IF   863 4.32 4.34
      45   0.40  Good      I1   491 4.64 4.68
      59   1.51  Good     VS2 11746 7.27 7.18
      63   0.34  Good     VS1   596 4.40 4.44
      10   2.00  Fair     SI2 15351 7.63 7.59
      58   0.90  Good     VS2  3246 6.16 6.07

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
