# tbflt1

    Code
      mini_diamond %>% filterC(c1)
    Condition
      Warning:
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
    Condition
      Warning:
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
    Condition
      Warning:
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
    Condition
      Warning:
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

# tbflt in function

    Code
      foo(mini_diamond, "Ideal")
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 34 x 7
         id    carat cut   clarity price     x     y
         <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
       2 id-4   1.54 Ideal SI2      9452  7.43  7.45
       3 id-5   0.72 Ideal VS1      2498  5.73  5.77
       4 id-9   1.01 Ideal SI1      5590  6.43  6.4 
       5 id-13  0.56 Ideal SI1      1633  5.31  5.32
       6 id-14  0.3  Ideal VVS2      812  4.33  4.39
       7 id-17  0.97 Ideal I1       2239  6.4   6.43
       8 id-19  0.59 Ideal VVS2     2155  5.34  5.39
       9 id-26  0.31 Ideal VS1       717  4.36  4.41
      10 id-29  0.72 Ideal SI2      2300  5.72  5.78
      # ... with 24 more rows

# tbflt logical operation in function

    Code
      foo(mini_diamond, "Ideal", "VVS1")
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-31  1.03 Ideal VVS1     8398  6.54  6.5 
      3 id-35  1    Ideal VVS1     6535  6.37  6.41
      4 id-37  0.51 Ideal VVS1     2812  5.15  5.11
      5 id-83  0.73 Ideal VVS1     3487  5.77  5.82

# tbflt logical operation in and out of function

    Code
      foo(mini_diamond, "Ideal", cond2)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-31  1.03 Ideal VVS1     8398  6.54  6.5 
      3 id-35  1    Ideal VVS1     6535  6.37  6.41
      4 id-37  0.51 Ideal VVS1     2812  5.15  5.11
      5 id-83  0.73 Ideal VVS1     3487  5.77  5.82

# tbflt logical operation out of function

    Code
      foo(mini_diamond, cond1, cond2)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-31  1.03 Ideal VVS1     8398  6.54  6.5 
      3 id-35  1    Ideal VVS1     6535  6.37  6.41
      4 id-37  0.51 Ideal VVS1     2812  5.15  5.11
      5 id-83  0.73 Ideal VVS1     3487  5.77  5.82

# tbflt, usecol=FALSE

    Code
      filterC(mini_diamond, cond, usecol = FALSE)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-6   2.02 Fair  SI2     14080  8.33  8.37
      2 id-48  2.01 Fair  I1       7294  8.3   8.19
      3 id-49  2.16 Ideal I1       8709  8.31  8.26
      4 id-68  2.32 Fair  SI1     18026  8.47  8.31
      5 id-97  2.61 Good  SI2     13784  8.66  8.57

# tbflt, usecol=FALSE, use .env

    Code
      filterC(mini_diamond, cond)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(.by)
      
        # Now:
        data %>% select(all_of(.by))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 5 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-6   2.02 Fair  SI2     14080  8.33  8.37
      2 id-48  2.01 Fair  I1       7294  8.3   8.19
      3 id-49  2.16 Ideal I1       8709  8.31  8.26
      4 id-68  2.32 Fair  SI1     18026  8.47  8.31
      5 id-97  2.61 Good  SI2     13784  8.66  8.57

