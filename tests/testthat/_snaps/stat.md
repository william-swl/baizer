# stat_test, by

    Code
      stat_test(mini_diamond, y = price, x = cut, .by = clarity) %>% print(width = Inf,
        n = Inf)
    Output
      # A tibble: 24 x 11
         clarity .y.   group1 group2    n1    n2 statistic     p p.adj p.adj.signif
         <chr>   <chr> <chr>  <chr>  <int> <int>     <dbl> <dbl> <dbl> <chr>       
       1 I1      price Fair   Good       5     5        18 0.31  0.62  ns          
       2 I1      price Fair   Ideal      5     4        11 0.905 0.905 ns          
       3 I1      price Good   Ideal      5     4         4 0.19  0.57  ns          
       4 IF      price Fair   Good       4     5        18 0.064 0.177 ns          
       5 IF      price Fair   Ideal      4     4        15 0.059 0.177 ns          
       6 IF      price Good   Ideal      5     4        10 1     1     ns          
       7 SI1     price Fair   Good       5     4        10 1     1     ns          
       8 SI1     price Fair   Ideal      5     5        13 1     1     ns          
       9 SI1     price Good   Ideal      4     5         6 0.413 1     ns          
      10 SI2     price Fair   Good       4     4        15 0.057 0.171 ns          
      11 SI2     price Fair   Ideal      4     4        15 0.057 0.171 ns          
      12 SI2     price Good   Ideal      4     4        10 0.686 0.686 ns          
      13 VS1     price Fair   Good       3     2         6 0.2   0.4   ns          
      14 VS1     price Fair   Ideal      3     5        15 0.036 0.107 ns          
      15 VS1     price Good   Ideal      2     5         3 0.571 0.571 ns          
      16 VS2     price Fair   Good       5     4         6 0.413 1     ns          
      17 VS2     price Fair   Ideal      5     2         6 0.857 1     ns          
      18 VS2     price Good   Ideal      4     2         5 0.8   1     ns          
      19 VVS1    price Fair   Good       5     4        11 0.905 0.905 ns          
      20 VVS1    price Fair   Ideal      5     5         5 0.151 0.453 ns          
      21 VVS1    price Good   Ideal      4     5         4 0.19  0.453 ns          
      22 VVS2    price Fair   Good       4     3         4 0.629 0.629 ns          
      23 VVS2    price Fair   Ideal      4     5        19 0.032 0.095 ns          
      24 VVS2    price Good   Ideal      3     5        14 0.071 0.143 ns          
         p.signif
         <chr>   
       1 NS      
       2 NS      
       3 NS      
       4 NS      
       5 NS      
       6 NS      
       7 NS      
       8 NS      
       9 NS      
      10 NS      
      11 NS      
      12 NS      
      13 NS      
      14 *       
      15 NS      
      16 NS      
      17 NS      
      18 NS      
      19 NS      
      20 NS      
      21 NS      
      22 NS      
      23 *       
      24 NS      

# stat_test

    Code
      stat_test(mini_diamond, y = price, x = cut) %>% print(width = Inf, n = Inf)
    Output
      # A tibble: 3 x 10
        .y.   group1 group2    n1    n2 statistic     p p.adj p.adj.signif p.signif
        <chr> <chr>  <chr>  <int> <int>     <dbl> <dbl> <dbl> <chr>        <chr>   
      1 price Fair   Good      35    31       702 0.04  0.081 ns           *       
      2 price Fair   Ideal     35    34       793 0.018 0.053 ns           *       
      3 price Good   Ideal     31    34       520 0.932 0.932 ns           NS      

# stat_fc

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity) %>% print(n = Inf)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2     y1     y2    fc fc_fmt
         <chr>   <chr>  <chr>   <dbl>  <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair    5844.  5844. 1     1.0x  
       2 SI1     Fair   Ideal   5844.  3877. 1.51  1.5x  
       3 SI1     Fair   Good    5844.  3227. 1.81  1.8x  
       4 VS2     Good   Good    5582.  5582. 1     1.0x  
       5 VS2     Good   Ideal   5582.  3024. 1.85  1.8x  
       6 VS2     Good   Fair    5582.  3529. 1.58  1.6x  
       7 VVS1    Ideal  Ideal   4652.  4652. 1     1.0x  
       8 VVS1    Ideal  Good    4652.  2810. 1.66  1.7x  
       9 VVS1    Ideal  Fair    4652.  2184  2.13  2.1x  
      10 SI2     Ideal  Ideal   4267.  4267. 1     1.0x  
      11 SI2     Ideal  Fair    4267. 13162. 0.324 0.32x 
      12 SI2     Ideal  Good    4267.  6539. 0.653 0.65x 
      13 VS1     Ideal  Ideal   2256.  2256. 1     1.0x  
      14 VS1     Ideal  Fair    2256.  6228. 0.362 0.36x 
      15 VS1     Ideal  Good    2256.   775  2.91  2.9x  
      16 SI2     Fair   Ideal  13162.  4267. 3.08  3.1x  
      17 SI2     Fair   Fair   13162. 13162. 1     1.0x  
      18 SI2     Fair   Good   13162.  6539. 2.01  2.0x  
      19 VVS1    Good   Ideal   2810.  4652. 0.604 0.60x 
      20 VVS1    Good   Good    2810.  2810. 1     1.0x  
      21 VVS1    Good   Fair    2810.  2184  1.29  1.3x  
      22 SI2     Good   Ideal   6539.  4267. 1.53  1.5x  
      23 SI2     Good   Fair    6539. 13162. 0.497 0.50x 
      24 SI2     Good   Good    6539.  6539. 1     1.0x  
      25 SI1     Ideal  Fair    3877.  5844. 0.663 0.66x 
      26 SI1     Ideal  Ideal   3877.  3877. 1     1.0x  
      27 SI1     Ideal  Good    3877.  3227. 1.20  1.2x  
      28 VVS1    Fair   Ideal   2184   4652. 0.469 0.47x 
      29 VVS1    Fair   Good    2184   2810. 0.777 0.78x 
      30 VVS1    Fair   Fair    2184   2184  1     1.0x  
      31 IF      Fair   Fair    2016   2016  1     1.0x  
      32 IF      Fair   Good    2016   1044. 1.93  1.9x  
      33 IF      Fair   Ideal   2016    962. 2.10  2.1x  
      34 VVS2    Ideal  Ideal   1072.  1072. 1     1.0x  
      35 VVS2    Ideal  Fair    1072.  3543  0.303 0.30x 
      36 VVS2    Ideal  Good    1072.  7481. 0.143 0.14x 
      37 IF      Good   Fair    1044.  2016  0.518 0.52x 
      38 IF      Good   Good    1044.  1044. 1     1.0x  
      39 IF      Good   Ideal   1044.   962. 1.09  1.1x  
      40 I1      Good   Good    2760.  2760. 1     1.0x  
      41 I1      Good   Ideal   2760.  4249  0.649 0.65x 
      42 I1      Good   Fair    2760.  4695. 0.588 0.59x 
      43 I1      Ideal  Good    4249   2760. 1.54  1.5x  
      44 I1      Ideal  Ideal   4249   4249  1     1.0x  
      45 I1      Ideal  Fair    4249   4695. 0.905 0.90x 
      46 I1      Fair   Good    4695.  2760. 1.70  1.7x  
      47 I1      Fair   Ideal   4695.  4249  1.11  1.1x  
      48 I1      Fair   Fair    4695.  4695. 1     1.0x  
      49 VVS2    Fair   Ideal   3543   1072. 3.31  3.3x  
      50 VVS2    Fair   Fair    3543   3543  1     1.0x  
      51 VVS2    Fair   Good    3543   7481. 0.474 0.47x 
      52 SI1     Good   Fair    3227.  5844. 0.552 0.55x 
      53 SI1     Good   Ideal   3227.  3877. 0.832 0.83x 
      54 SI1     Good   Good    3227.  3227. 1     1.0x  
      55 VS1     Fair   Ideal   6228.  2256. 2.76  2.8x  
      56 VS1     Fair   Fair    6228.  6228. 1     1.0x  
      57 VS1     Fair   Good    6228.   775  8.04  8.0x  
      58 VS2     Ideal  Good    3024.  5582. 0.542 0.54x 
      59 VS2     Ideal  Ideal   3024.  3024. 1     1.0x  
      60 VS2     Ideal  Fair    3024.  3529. 0.857 0.86x 
      61 IF      Ideal  Fair     962.  2016  0.477 0.48x 
      62 IF      Ideal  Good     962.  1044. 0.921 0.92x 
      63 IF      Ideal  Ideal    962.   962. 1     1.0x  
      64 VVS2    Good   Ideal   7481.  1072. 6.98  7.0x  
      65 VVS2    Good   Fair    7481.  3543  2.11  2.1x  
      66 VVS2    Good   Good    7481.  7481. 1     1.0x  
      67 VS2     Fair   Good    3529.  5582. 0.632 0.63x 
      68 VS2     Fair   Ideal   3529.  3024. 1.17  1.2x  
      69 VS2     Fair   Fair    3529.  3529. 1     1.0x  
      70 VS1     Good   Ideal    775   2256. 0.343 0.34x 
      71 VS1     Good   Fair     775   6228. 0.124 0.12x 
      72 VS1     Good   Good     775    775  1     1.0x  

# stat_fc, rev_div=TRUE

    Code
      stat_fc(mini_diamond, y = price, x = cut, rev_div = TRUE, .by = clarity) %>%
        print(n = Inf)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2     y1     y2    fc fc_fmt
         <chr>   <chr>  <chr>   <dbl>  <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair    5844.  5844. 1     1.0x  
       2 SI1     Fair   Ideal   5844.  3877. 0.663 0.66x 
       3 SI1     Fair   Good    5844.  3227. 0.552 0.55x 
       4 VS2     Good   Good    5582.  5582. 1     1.0x  
       5 VS2     Good   Ideal   5582.  3024. 0.542 0.54x 
       6 VS2     Good   Fair    5582.  3529. 0.632 0.63x 
       7 VVS1    Ideal  Ideal   4652.  4652. 1     1.0x  
       8 VVS1    Ideal  Good    4652.  2810. 0.604 0.60x 
       9 VVS1    Ideal  Fair    4652.  2184  0.469 0.47x 
      10 SI2     Ideal  Ideal   4267.  4267. 1     1.0x  
      11 SI2     Ideal  Fair    4267. 13162. 3.08  3.1x  
      12 SI2     Ideal  Good    4267.  6539. 1.53  1.5x  
      13 VS1     Ideal  Ideal   2256.  2256. 1     1.0x  
      14 VS1     Ideal  Fair    2256.  6228. 2.76  2.8x  
      15 VS1     Ideal  Good    2256.   775  0.343 0.34x 
      16 SI2     Fair   Ideal  13162.  4267. 0.324 0.32x 
      17 SI2     Fair   Fair   13162. 13162. 1     1.0x  
      18 SI2     Fair   Good   13162.  6539. 0.497 0.50x 
      19 VVS1    Good   Ideal   2810.  4652. 1.66  1.7x  
      20 VVS1    Good   Good    2810.  2810. 1     1.0x  
      21 VVS1    Good   Fair    2810.  2184  0.777 0.78x 
      22 SI2     Good   Ideal   6539.  4267. 0.653 0.65x 
      23 SI2     Good   Fair    6539. 13162. 2.01  2.0x  
      24 SI2     Good   Good    6539.  6539. 1     1.0x  
      25 SI1     Ideal  Fair    3877.  5844. 1.51  1.5x  
      26 SI1     Ideal  Ideal   3877.  3877. 1     1.0x  
      27 SI1     Ideal  Good    3877.  3227. 0.832 0.83x 
      28 VVS1    Fair   Ideal   2184   4652. 2.13  2.1x  
      29 VVS1    Fair   Good    2184   2810. 1.29  1.3x  
      30 VVS1    Fair   Fair    2184   2184  1     1.0x  
      31 IF      Fair   Fair    2016   2016  1     1.0x  
      32 IF      Fair   Good    2016   1044. 0.518 0.52x 
      33 IF      Fair   Ideal   2016    962. 0.477 0.48x 
      34 VVS2    Ideal  Ideal   1072.  1072. 1     1.0x  
      35 VVS2    Ideal  Fair    1072.  3543  3.31  3.3x  
      36 VVS2    Ideal  Good    1072.  7481. 6.98  7.0x  
      37 IF      Good   Fair    1044.  2016  1.93  1.9x  
      38 IF      Good   Good    1044.  1044. 1     1.0x  
      39 IF      Good   Ideal   1044.   962. 0.921 0.92x 
      40 I1      Good   Good    2760.  2760. 1     1.0x  
      41 I1      Good   Ideal   2760.  4249  1.54  1.5x  
      42 I1      Good   Fair    2760.  4695. 1.70  1.7x  
      43 I1      Ideal  Good    4249   2760. 0.649 0.65x 
      44 I1      Ideal  Ideal   4249   4249  1     1.0x  
      45 I1      Ideal  Fair    4249   4695. 1.11  1.1x  
      46 I1      Fair   Good    4695.  2760. 0.588 0.59x 
      47 I1      Fair   Ideal   4695.  4249  0.905 0.90x 
      48 I1      Fair   Fair    4695.  4695. 1     1.0x  
      49 VVS2    Fair   Ideal   3543   1072. 0.303 0.30x 
      50 VVS2    Fair   Fair    3543   3543  1     1.0x  
      51 VVS2    Fair   Good    3543   7481. 2.11  2.1x  
      52 SI1     Good   Fair    3227.  5844. 1.81  1.8x  
      53 SI1     Good   Ideal   3227.  3877. 1.20  1.2x  
      54 SI1     Good   Good    3227.  3227. 1     1.0x  
      55 VS1     Fair   Ideal   6228.  2256. 0.362 0.36x 
      56 VS1     Fair   Fair    6228.  6228. 1     1.0x  
      57 VS1     Fair   Good    6228.   775  0.124 0.12x 
      58 VS2     Ideal  Good    3024.  5582. 1.85  1.8x  
      59 VS2     Ideal  Ideal   3024.  3024. 1     1.0x  
      60 VS2     Ideal  Fair    3024.  3529. 1.17  1.2x  
      61 IF      Ideal  Fair     962.  2016  2.10  2.1x  
      62 IF      Ideal  Good     962.  1044. 1.09  1.1x  
      63 IF      Ideal  Ideal    962.   962. 1     1.0x  
      64 VVS2    Good   Ideal   7481.  1072. 0.143 0.14x 
      65 VVS2    Good   Fair    7481.  3543  0.474 0.47x 
      66 VVS2    Good   Good    7481.  7481. 1     1.0x  
      67 VS2     Fair   Good    3529.  5582. 1.58  1.6x  
      68 VS2     Fair   Ideal   3529.  3024. 0.857 0.86x 
      69 VS2     Fair   Fair    3529.  3529. 1     1.0x  
      70 VS1     Good   Ideal    775   2256. 2.91  2.9x  
      71 VS1     Good   Fair     775   6228. 8.04  8.0x  
      72 VS1     Good   Good     775    775  1     1.0x  

# stat_fc, method='median'

    Code
      suppressWarnings(stat_fc(mini_diamond, y = price, x = cut, .by = clarity,
        method = "median") %>% print(n = Inf))
    Output
      # A tibble: 72 x 7
         clarity group1 group2     y1     y2    fc fc_fmt
         <chr>   <chr>  <chr>   <dbl>  <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair    3027   3027  1     1.0x  
       2 SI1     Fair   Ideal   3027   5370  0.564 0.56x 
       3 SI1     Fair   Good    3027   3533  0.857 0.86x 
       4 VS2     Good   Good    3746.  3746. 1     1.0x  
       5 VS2     Good   Ideal   3746.  3024. 1.24  1.2x  
       6 VS2     Good   Fair    3746.  2815  1.33  1.3x  
       7 VVS1    Ideal  Ideal   3487   3487  1     1.0x  
       8 VVS1    Ideal  Good    3487   1314  2.65  2.7x  
       9 VVS1    Ideal  Fair    3487   1691  2.06  2.1x  
      10 SI2     Ideal  Ideal   3086.  3086. 1     1.0x  
      11 SI2     Ideal  Fair    3086. 14716. 0.210 0.21x 
      12 SI2     Ideal  Good    3086.  5671  0.544 0.54x 
      13 VS1     Ideal  Ideal   2498   2498  1     1.0x  
      14 VS1     Ideal  Fair    2498   6115  0.409 0.41x 
      15 VS1     Ideal  Good    2498    775  3.22  3.2x  
      16 SI2     Fair   Ideal  14716.  3086. 4.77  4.8x  
      17 SI2     Fair   Fair   14716. 14716. 1     1.0x  
      18 SI2     Fair   Good   14716.  5671  2.59  2.6x  
      19 VVS1    Good   Ideal   1314   3487  0.377 0.38x 
      20 VVS1    Good   Good    1314   1314  1     1.0x  
      21 VVS1    Good   Fair    1314   1691  0.777 0.78x 
      22 SI2     Good   Ideal   5671   3086. 1.84  1.8x  
      23 SI2     Good   Fair    5671  14716. 0.385 0.39x 
      24 SI2     Good   Good    5671   5671  1     1.0x  
      25 SI1     Ideal  Fair    5370   3027  1.77  1.8x  
      26 SI1     Ideal  Ideal   5370   5370  1     1.0x  
      27 SI1     Ideal  Good    5370   3533  1.52  1.5x  
      28 VVS1    Fair   Ideal   1691   3487  0.485 0.48x 
      29 VVS1    Fair   Good    1691   1314  1.29  1.3x  
      30 VVS1    Fair   Fair    1691   1691  1     1.0x  
      31 IF      Fair   Fair    1826.  1826. 1     1.0x  
      32 IF      Fair   Good    1826.  1052  1.74  1.7x  
      33 IF      Fair   Ideal   1826.   877  2.08  2.1x  
      34 VVS2    Ideal  Ideal    854    854  1     1.0x  
      35 VVS2    Ideal  Fair     854   3800  0.225 0.22x 
      36 VVS2    Ideal  Good     854   6748  0.127 0.13x 
      37 IF      Good   Fair    1052   1826. 0.576 0.58x 
      38 IF      Good   Good    1052   1052  1     1.0x  
      39 IF      Good   Ideal   1052    877  1.20  1.2x  
      40 I1      Good   Good    2143   2143  1     1.0x  
      41 I1      Good   Ideal   2143   3024  0.709 0.71x 
      42 I1      Good   Fair    2143   5667  0.378 0.38x 
      43 I1      Ideal  Good    3024   2143  1.41  1.4x  
      44 I1      Ideal  Ideal   3024   3024  1     1.0x  
      45 I1      Ideal  Fair    3024   5667  0.534 0.53x 
      46 I1      Fair   Good    5667   2143  2.64  2.6x  
      47 I1      Fair   Ideal   5667   3024  1.87  1.9x  
      48 I1      Fair   Fair    5667   5667  1     1.0x  
      49 VVS2    Fair   Ideal   3800    854  4.45  4.4x  
      50 VVS2    Fair   Fair    3800   3800  1     1.0x  
      51 VVS2    Fair   Good    3800   6748  0.563 0.56x 
      52 SI1     Good   Fair    3533   3027  1.17  1.2x  
      53 SI1     Good   Ideal   3533   5370  0.658 0.66x 
      54 SI1     Good   Good    3533   3533  1     1.0x  
      55 VS1     Fair   Ideal   6115   2498  2.45  2.4x  
      56 VS1     Fair   Fair    6115   6115  1     1.0x  
      57 VS1     Fair   Good    6115    775  7.89  7.9x  
      58 VS2     Ideal  Good    3024.  3746. 0.807 0.81x 
      59 VS2     Ideal  Ideal   3024.  3024. 1     1.0x  
      60 VS2     Ideal  Fair    3024.  2815  1.07  1.1x  
      61 IF      Ideal  Fair     877   1826. 0.480 0.48x 
      62 IF      Ideal  Good     877   1052  0.834 0.83x 
      63 IF      Ideal  Ideal    877    877  1     1.0x  
      64 VVS2    Good   Ideal   6748    854  7.90  7.9x  
      65 VVS2    Good   Fair    6748   3800  1.78  1.8x  
      66 VVS2    Good   Good    6748   6748  1     1.0x  
      67 VS2     Fair   Good    2815   3746. 0.751 0.75x 
      68 VS2     Fair   Ideal   2815   3024. 0.931 0.93x 
      69 VS2     Fair   Fair    2815   2815  1     1.0x  
      70 VS1     Good   Ideal    775   2498  0.310 0.31x 
      71 VS1     Good   Fair     775   6115  0.127 0.13x 
      72 VS1     Good   Good     775    775  1     1.0x  

# stat_fc, method='geom_mean'

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity, method = "geom_mean") %>%
        print(n = Inf)
    Condition
      Warning:
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2     y1     y2    fc fc_fmt
         <chr>   <chr>  <chr>   <dbl>  <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair    3833.  3833. 1     1.0x  
       2 SI1     Fair   Ideal   3833.  3268. 1.17  1.2x  
       3 SI1     Fair   Good    3833.  2401. 1.60  1.6x  
       4 VS2     Good   Good    4728.  4728. 1     1.0x  
       5 VS2     Good   Ideal   4728.  1845. 2.56  2.6x  
       6 VS2     Good   Fair    4728.  3330. 1.42  1.4x  
       7 VVS1    Ideal  Ideal   4052.  4052. 1     1.0x  
       8 VVS1    Ideal  Good    4052.  1773. 2.29  2.3x  
       9 VVS1    Ideal  Fair    4052.  1863. 2.18  2.2x  
      10 SI2     Ideal  Ideal   3319.  3319. 1     1.0x  
      11 SI2     Ideal  Fair    3319. 12609. 0.263 0.26x 
      12 SI2     Ideal  Good    3319.  4605. 0.721 0.72x 
      13 VS1     Ideal  Ideal   1641.  1641. 1     1.0x  
      14 VS1     Ideal  Fair    1641.  6194. 0.265 0.26x 
      15 VS1     Ideal  Good    1641.   754. 2.18  2.2x  
      16 SI2     Fair   Ideal  12609.  3319. 3.80  3.8x  
      17 SI2     Fair   Fair   12609. 12609. 1     1.0x  
      18 SI2     Fair   Good   12609.  4605. 2.74  2.7x  
      19 VVS1    Good   Ideal   1773.  4052. 0.438 0.44x 
      20 VVS1    Good   Good    1773.  1773. 1     1.0x  
      21 VVS1    Good   Fair    1773.  1863. 0.952 0.95x 
      22 SI2     Good   Ideal   4605.  3319. 1.39  1.4x  
      23 SI2     Good   Fair    4605. 12609. 0.365 0.37x 
      24 SI2     Good   Good    4605.  4605. 1     1.0x  
      25 SI1     Ideal  Fair    3268.  3833. 0.853 0.85x 
      26 SI1     Ideal  Ideal   3268.  3268. 1     1.0x  
      27 SI1     Ideal  Good    3268.  2401. 1.36  1.4x  
      28 VVS1    Fair   Ideal   1863.  4052. 0.460 0.46x 
      29 VVS1    Fair   Good    1863.  1773. 1.05  1.1x  
      30 VVS1    Fair   Fair    1863.  1863. 1     1.0x  
      31 IF      Fair   Fair    1874.  1874. 1     1.0x  
      32 IF      Fair   Good    1874.   961. 1.95  1.9x  
      33 IF      Fair   Ideal   1874.   950. 1.97  2.0x  
      34 VVS2    Ideal  Ideal    967.   967. 1     1.0x  
      35 VVS2    Ideal  Fair     967.  3184. 0.304 0.30x 
      36 VVS2    Ideal  Good     967.  4688. 0.206 0.21x 
      37 IF      Good   Fair     961.  1874. 0.513 0.51x 
      38 IF      Good   Good     961.   961. 1     1.0x  
      39 IF      Good   Ideal    961.   950. 1.01  1.0x  
      40 I1      Good   Good    1571.  1571. 1     1.0x  
      41 I1      Good   Ideal   1571.  3611. 0.435 0.44x 
      42 I1      Good   Fair    1571.  3911. 0.402 0.40x 
      43 I1      Ideal  Good    3611.  1571. 2.30  2.3x  
      44 I1      Ideal  Ideal   3611.  3611. 1     1.0x  
      45 I1      Ideal  Fair    3611.  3911. 0.923 0.92x 
      46 I1      Fair   Good    3911.  1571. 2.49  2.5x  
      47 I1      Fair   Ideal   3911.  3611. 1.08  1.1x  
      48 I1      Fair   Fair    3911.  3911. 1     1.0x  
      49 VVS2    Fair   Ideal   3184.   967. 3.29  3.3x  
      50 VVS2    Fair   Fair    3184.  3184. 1     1.0x  
      51 VVS2    Fair   Good    3184.  4688. 0.679 0.68x 
      52 SI1     Good   Fair    2401.  3833. 0.626 0.63x 
      53 SI1     Good   Ideal   2401.  3268. 0.735 0.73x 
      54 SI1     Good   Good    2401.  2401. 1     1.0x  
      55 VS1     Fair   Ideal   6194.  1641. 3.77  3.8x  
      56 VS1     Fair   Fair    6194.  6194. 1     1.0x  
      57 VS1     Fair   Good    6194.   754. 8.21  8.2x  
      58 VS2     Ideal  Good    1845.  4728. 0.390 0.39x 
      59 VS2     Ideal  Ideal   1845.  1845. 1     1.0x  
      60 VS2     Ideal  Fair    1845.  3330. 0.554 0.55x 
      61 IF      Ideal  Fair     950.  1874. 0.507 0.51x 
      62 IF      Ideal  Good     950.   961. 0.988 0.99x 
      63 IF      Ideal  Ideal    950.   950. 1     1.0x  
      64 VVS2    Good   Ideal   4688.   967. 4.85  4.8x  
      65 VVS2    Good   Fair    4688.  3184. 1.47  1.5x  
      66 VVS2    Good   Good    4688.  4688. 1     1.0x  
      67 VS2     Fair   Good    3330.  4728. 0.704 0.70x 
      68 VS2     Fair   Ideal   3330.  1845. 1.80  1.8x  
      69 VS2     Fair   Fair    3330.  3330. 1     1.0x  
      70 VS1     Good   Ideal    754.  1641. 0.459 0.46x 
      71 VS1     Good   Fair     754.  6194. 0.122 0.12x 
      72 VS1     Good   Good     754.   754. 1     1.0x  

