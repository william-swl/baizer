# tbflt1

    Code
      mini_diamond %>% filterC(c1) %>% print(n = Inf)
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
      11 id-32  2    Fair  I1       5667  7.78  7.74
      12 id-36  1    Fair  VS1      6115  6.26  6.21
      13 id-40  1.52 Fair  SI2      7388  7.23  7.19
      14 id-43  1.12 Fair  VS1      5487  6.48  6.52
      15 id-45  0.47 Fair  IF       2211  5.09  4.98
      16 id-46  0.34 Fair  VVS1     1040  4.72  4.77
      17 id-48  2.01 Fair  I1       7294  8.3   8.19
      18 id-52  0.72 Fair  VS2      2306  5.66  5.71
      19 id-55  0.71 Fair  VVS1     3062  5.67  5.57
      20 id-58  0.9  Fair  VVS2     3288  6.1   6.12
      21 id-59  0.91 Fair  VVS1     4115  6.38  6.4 
      22 id-63  1.35 Fair  VS2      5625  6.98  6.93
      23 id-64  1.01 Fair  SI1      4480  6.34  6.29
      24 id-65  0.63 Fair  SI1      1952  5.36  5.41
      25 id-66  0.9  Fair  VS2      2815  6.08  6.04
      26 id-68  2.32 Fair  SI1     18026  8.47  8.31
      27 id-70  0.9  Fair  VS2      4277  6.26  6.29
      28 id-76  0.64 Fair  SI1      1733  5.65  5.39
      29 id-77  0.71 Fair  VS2      2623  5.83  5.81
      30 id-79  1.08 Fair  VVS2     5171  6.9   6.8 
      31 id-85  1    Fair  VS1      7083  6.77  6.71
      32 id-89  0.3  Fair  IF       1208  4.47  4.35
      33 id-95  0.37 Fair  IF       1440  4.68  4.73
      34 id-98  1    Fair  VVS2     4312  6.27  6.23
      35 id-99  2    Fair  SI2     15351  7.63  7.59

# tbflt2

    Code
      mini_diamond %>% filterC(!c1) %>% print(n = Inf)
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
         id     carat cut   clarity price     x     y
         <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
       1 id-2    1.51 Good  VS2     11746  7.27  7.18
       2 id-3    0.52 Ideal VVS1     2029  5.15  5.18
       3 id-4    1.54 Ideal SI2      9452  7.43  7.45
       4 id-5    0.72 Ideal VS1      2498  5.73  5.77
       5 id-7    0.27 Good  VVS1      752  4.1   4.07
       6 id-8    0.51 Good  SI2      1029  5.05  5.08
       7 id-9    1.01 Ideal SI1      5590  6.43  6.4 
       8 id-11   1.02 Good  VVS1     7861  6.37  6.4 
       9 id-13   0.56 Ideal SI1      1633  5.31  5.32
      10 id-14   0.3  Ideal VVS2      812  4.33  4.39
      11 id-15   0.28 Good  IF        612  4.09  4.12
      12 id-16   0.41 Good  I1        467  4.7   4.74
      13 id-17   0.97 Ideal I1       2239  6.4   6.43
      14 id-19   0.59 Ideal VVS2     2155  5.34  5.39
      15 id-21   0.4  Good  VVS1     1080  4.71  4.73
      16 id-22   0.9  Good  VS2      3246  6.16  6.07
      17 id-24   0.92 Good  VS2      4247  6.11  6.17
      18 id-26   0.31 Ideal VS1       717  4.36  4.41
      19 id-27   1.13 Good  SI2      4998  6.93  6.88
      20 id-29   0.72 Ideal SI2      2300  5.72  5.78
      21 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
      22 id-33   1.21 Good  SI1      5252  6.63  6.71
      23 id-34   1.14 Good  I1       2327  6.63  6.55
      24 id-35   1    Ideal VVS1     6535  6.37  6.41
      25 id-37   0.51 Ideal VVS1     2812  5.15  5.11
      26 id-38   1.09 Ideal VS2      5421  6.62  6.67
      27 id-39   0.3  Ideal IF        863  4.33  4.36
      28 id-41   0.98 Ideal SI2      3873  6.35  6.39
      29 id-42   0.32 Good  SI1       589  4.33  4.35
      30 id-44   0.7  Good  VS2      3087  5.49  5.56
      31 id-47   1.1  Ideal SI1      5370  6.66  6.7 
      32 id-49   2.16 Ideal I1       8709  8.31  8.26
      33 id-50   1    Good  SI1      4851  6.27  6.31
      34 id-51   1    Good  VVS2     6748  6.32  6.3 
      35 id-53   0.33 Good  IF       1052  4.57  4.55
      36 id-54   0.4  Ideal VVS2      931  4.72  4.75
      37 id-56   0.4  Good  IF       1120  4.75  4.8 
      38 id-57   0.3  Ideal IF        863  4.32  4.34
      39 id-60   0.29 Ideal VVS2      607  4.27  4.29
      40 id-61   0.3  Good  IF        631  4.23  4.3 
      41 id-62   0.46 Good  IF       1806  5.12  5.18
      42 id-67   0.58 Ideal SI2      1442  5.4   5.36
      43 id-69   0.4  Good  I1        491  4.64  4.68
      44 id-71   0.97 Ideal I1       2370  6.34  6.28
      45 id-72   0.42 Good  VVS2     1042  4.72  4.78
      46 id-73   0.4  Ideal IF       1229  4.73  4.76
      47 id-74   0.45 Good  VVS1     1548  4.85  4.78
      48 id-75   0.71 Good  SI1      2215  5.62  5.59
      49 id-78   0.7  Ideal VS1      3535  5.69  5.72
      50 id-80   0.8  Ideal VS1      4070  5.91  5.96
      51 id-81   0.41 Good  VS1       954  4.77  4.79
      52 id-82   0.9  Good  I1       2143  6.09  6.05
      53 id-83   0.73 Ideal VVS1     3487  5.77  5.82
      54 id-84   0.5  Ideal SI1      1415  5.11  5.05
      55 id-86   0.31 Ideal IF        891  4.38  4.4 
      56 id-87   0.34 Good  VS1       596  4.4   4.44
      57 id-88   0.31 Ideal VS2       628  4.38  4.34
      58 id-90   1.13 Ideal I1       3678  6.65  6.69
      59 id-91   1.73 Good  I1       8370  7.6   7.56
      60 id-92   1.51 Good  VVS2    14654  7.18  7.24
      61 id-93   1.09 Ideal SI1      5376  6.6   6.64
      62 id-94   0.28 Ideal VS1       462  4.19  4.23
      63 id-96   0.32 Ideal VVS2      854  4.45  4.46
      64 id-97   2.61 Good  SI2     13784  8.66  8.57
      65 id-100  1.2  Good  SI2      6344  6.72  6.68

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
      mini_diamond %>% filterC(c1 | c2) %>% print(n = Inf)
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
      11 id-32  2    Fair  I1       5667  7.78  7.74
      12 id-36  1    Fair  VS1      6115  6.26  6.21
      13 id-40  1.52 Fair  SI2      7388  7.23  7.19
      14 id-43  1.12 Fair  VS1      5487  6.48  6.52
      15 id-45  0.47 Fair  IF       2211  5.09  4.98
      16 id-46  0.34 Fair  VVS1     1040  4.72  4.77
      17 id-48  2.01 Fair  I1       7294  8.3   8.19
      18 id-49  2.16 Ideal I1       8709  8.31  8.26
      19 id-52  0.72 Fair  VS2      2306  5.66  5.71
      20 id-55  0.71 Fair  VVS1     3062  5.67  5.57
      21 id-58  0.9  Fair  VVS2     3288  6.1   6.12
      22 id-59  0.91 Fair  VVS1     4115  6.38  6.4 
      23 id-63  1.35 Fair  VS2      5625  6.98  6.93
      24 id-64  1.01 Fair  SI1      4480  6.34  6.29
      25 id-65  0.63 Fair  SI1      1952  5.36  5.41
      26 id-66  0.9  Fair  VS2      2815  6.08  6.04
      27 id-68  2.32 Fair  SI1     18026  8.47  8.31
      28 id-70  0.9  Fair  VS2      4277  6.26  6.29
      29 id-76  0.64 Fair  SI1      1733  5.65  5.39
      30 id-77  0.71 Fair  VS2      2623  5.83  5.81
      31 id-79  1.08 Fair  VVS2     5171  6.9   6.8 
      32 id-85  1    Fair  VS1      7083  6.77  6.71
      33 id-89  0.3  Fair  IF       1208  4.47  4.35
      34 id-95  0.37 Fair  IF       1440  4.68  4.73
      35 id-97  2.61 Good  SI2     13784  8.66  8.57
      36 id-98  1    Fair  VVS2     4312  6.27  6.23
      37 id-99  2    Fair  SI2     15351  7.63  7.59

# tbflt in function

    Code
      foo(mini_diamond, "Ideal") %>% print(n = Inf)
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
      11 id-31  1.03 Ideal VVS1     8398  6.54  6.5 
      12 id-35  1    Ideal VVS1     6535  6.37  6.41
      13 id-37  0.51 Ideal VVS1     2812  5.15  5.11
      14 id-38  1.09 Ideal VS2      5421  6.62  6.67
      15 id-39  0.3  Ideal IF        863  4.33  4.36
      16 id-41  0.98 Ideal SI2      3873  6.35  6.39
      17 id-47  1.1  Ideal SI1      5370  6.66  6.7 
      18 id-49  2.16 Ideal I1       8709  8.31  8.26
      19 id-54  0.4  Ideal VVS2      931  4.72  4.75
      20 id-57  0.3  Ideal IF        863  4.32  4.34
      21 id-60  0.29 Ideal VVS2      607  4.27  4.29
      22 id-67  0.58 Ideal SI2      1442  5.4   5.36
      23 id-71  0.97 Ideal I1       2370  6.34  6.28
      24 id-73  0.4  Ideal IF       1229  4.73  4.76
      25 id-78  0.7  Ideal VS1      3535  5.69  5.72
      26 id-80  0.8  Ideal VS1      4070  5.91  5.96
      27 id-83  0.73 Ideal VVS1     3487  5.77  5.82
      28 id-84  0.5  Ideal SI1      1415  5.11  5.05
      29 id-86  0.31 Ideal IF        891  4.38  4.4 
      30 id-88  0.31 Ideal VS2       628  4.38  4.34
      31 id-90  1.13 Ideal I1       3678  6.65  6.69
      32 id-93  1.09 Ideal SI1      5376  6.6   6.64
      33 id-94  0.28 Ideal VS1       462  4.19  4.23
      34 id-96  0.32 Ideal VVS2      854  4.45  4.46

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

