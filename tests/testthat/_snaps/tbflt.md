# tbflt1

    Code
      mini_diamond %>% filterC(c1)
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 35 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-6   2.02 Fair  SI2     14080  8.33  8.37
       3 id-10  0.7  Fair  VVS1     1691  5.56  5.41
       4 id-12  0.71 Fair  IF       3205  5.87  5.81
       5 id-18  0.34 Fair  VVS1     1012  4.8   4.76
       6 id-20  1.2  Fair  I1       3011  6.61  6.54
       7 id-23  0.7  Fair  I1       1158  5.64  5.5 
       8 id-25  2.1  Fair  SI2     15827  7.97  7.92
       9 id-28  2.02 Fair  I1       6346  7.87  7.8 
      10 id-30  0.52 Fair  VVS2     1401  5.26  5.2 
      # ... with 25 more rows

# tbflt2

    Code
      mini_diamond %>% filterC(!c1)
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 65 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-2   1.51 Good  VS2     11746  7.27  7.18
       2 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       3 id-4   1.54 Ideal SI2      9452  7.43  7.45
       4 id-5   0.72 Ideal VS1      2498  5.73  5.77
       5 id-7   0.27 Good  VVS1      752  4.1   4.07
       6 id-8   0.51 Good  SI2      1029  5.05  5.08
       7 id-9   1.01 Ideal SI1      5590  6.43  6.4 
       8 id-11  1.02 Good  VVS1     7861  6.37  6.4 
       9 id-13  0.56 Ideal SI1      1633  5.31  5.32
      10 id-14  0.3  Ideal VVS2      812  4.33  4.39
      # ... with 55 more rows

# tbflt3

    Code
      mini_diamond %>% filterC(c1 & c2)
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 3 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-6   2.02 Fair  SI2     14080  8.33  8.37
      2 id-48  2.01 Fair  I1       7294  8.3   8.19
      3 id-68  2.32 Fair  SI1     18026  8.47  8.31

# tbflt4

    Code
      mini_diamond %>% filterC(c1 | c2)
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 37 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-1   1.02 Fair  SI1      3027  6.25  6.18
       2 id-6   2.02 Fair  SI2     14080  8.33  8.37
       3 id-10  0.7  Fair  VVS1     1691  5.56  5.41
       4 id-12  0.71 Fair  IF       3205  5.87  5.81
       5 id-18  0.34 Fair  VVS1     1012  4.8   4.76
       6 id-20  1.2  Fair  I1       3011  6.61  6.54
       7 id-23  0.7  Fair  I1       1158  5.64  5.5 
       8 id-25  2.1  Fair  SI2     15827  7.97  7.92
       9 id-28  2.02 Fair  I1       6346  7.87  7.8 
      10 id-30  0.52 Fair  VVS2     1401  5.26  5.2 
      # ... with 27 more rows

