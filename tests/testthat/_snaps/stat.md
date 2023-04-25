# stat_test, by

    Code
      stat_test(mini_diamond, y = price, x = cut, .by = clarity) %>% print(width = Inf,
        n = Inf)
    Output
      # A tibble: 24 x 9
         y     clarity group1 group2    n1    n2      p  plim symbol
         <chr> <chr>   <chr>  <chr>  <int> <int>  <dbl> <dbl> <chr> 
       1 price I1      Fair   Good       5     5 0.310   1.01 NS    
       2 price I1      Fair   Ideal      5     4 0.905   1.01 NS    
       3 price I1      Good   Ideal      5     4 0.190   1.01 NS    
       4 price IF      Fair   Good       4     5 0.0635  1.01 NS    
       5 price IF      Fair   Ideal      4     4 0.0591  1.01 NS    
       6 price IF      Good   Ideal      5     4 1       1.01 NS    
       7 price SI1     Fair   Good       5     4 1       1.01 NS    
       8 price SI1     Fair   Ideal      5     5 1       1.01 NS    
       9 price SI1     Good   Ideal      4     5 0.413   1.01 NS    
      10 price SI2     Fair   Good       4     4 0.0571  1.01 NS    
      11 price SI2     Fair   Ideal      4     4 0.0571  1.01 NS    
      12 price SI2     Good   Ideal      4     4 0.686   1.01 NS    
      13 price VS1     Fair   Good       3     2 0.2     1.01 NS    
      14 price VS1     Fair   Ideal      3     5 0.0357  0.05 *     
      15 price VS1     Good   Ideal      2     5 0.571   1.01 NS    
      16 price VS2     Fair   Good       5     4 0.413   1.01 NS    
      17 price VS2     Fair   Ideal      5     2 0.857   1.01 NS    
      18 price VS2     Good   Ideal      4     2 0.8     1.01 NS    
      19 price VVS1    Fair   Good       5     4 0.905   1.01 NS    
      20 price VVS1    Fair   Ideal      5     5 0.151   1.01 NS    
      21 price VVS1    Good   Ideal      4     5 0.190   1.01 NS    
      22 price VVS2    Fair   Good       4     3 0.629   1.01 NS    
      23 price VVS2    Fair   Ideal      4     5 0.0317  0.05 *     
      24 price VVS2    Good   Ideal      3     5 0.0714  1.01 NS    

# stat_test

    Code
      stat_test(mini_diamond, y = price, x = cut) %>% print(width = Inf, n = Inf)
    Output
      # A tibble: 3 x 8
        y     group1 group2    n1    n2      p  plim symbol
        <chr> <chr>  <chr>  <int> <int>  <dbl> <dbl> <chr> 
      1 price Fair   Good      35    31 0.0405  0.05 *     
      2 price Fair   Ideal     35    34 0.0178  0.05 *     
      3 price Good   Ideal     31    34 0.932   1.01 NS    

# stat_fc

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity) %>% print(n = Inf)
    Output
      # A tibble: 24 x 8
         y     clarity group1 group2     y1    y2    fc fc_fmt
         <chr> <chr>   <chr>  <chr>   <dbl> <dbl> <dbl> <chr> 
       1 price I1      Fair   Good    4695. 2760. 1.70  1.7x  
       2 price I1      Fair   Ideal   4695. 4249  1.11  1.1x  
       3 price I1      Good   Ideal   2760. 4249  0.649 0.65x 
       4 price IF      Fair   Good    2016  1044. 1.93  1.9x  
       5 price IF      Fair   Ideal   2016   962. 2.10  2.1x  
       6 price IF      Good   Ideal   1044.  962. 1.09  1.1x  
       7 price SI1     Fair   Good    5844. 3227. 1.81  1.8x  
       8 price SI1     Fair   Ideal   5844. 3877. 1.51  1.5x  
       9 price SI1     Good   Ideal   3227. 3877. 0.832 0.83x 
      10 price SI2     Fair   Good   13162. 6539. 2.01  2.0x  
      11 price SI2     Fair   Ideal  13162. 4267. 3.08  3.1x  
      12 price SI2     Good   Ideal   6539. 4267. 1.53  1.5x  
      13 price VS1     Fair   Good    6228.  775  8.04  8.0x  
      14 price VS1     Fair   Ideal   6228. 2256. 2.76  2.8x  
      15 price VS1     Good   Ideal    775  2256. 0.343 0.34x 
      16 price VS2     Fair   Good    3529. 5582. 0.632 0.63x 
      17 price VS2     Fair   Ideal   3529. 3024. 1.17  1.2x  
      18 price VS2     Good   Ideal   5582. 3024. 1.85  1.8x  
      19 price VVS1    Fair   Good    2184  2810. 0.777 0.78x 
      20 price VVS1    Fair   Ideal   2184  4652. 0.469 0.47x 
      21 price VVS1    Good   Ideal   2810. 4652. 0.604 0.60x 
      22 price VVS2    Fair   Good    3543  7481. 0.474 0.47x 
      23 price VVS2    Fair   Ideal   3543  1072. 3.31  3.3x  
      24 price VVS2    Good   Ideal   7481. 1072. 6.98  7.0x  

# stat_fc, rev_div=TRUE

    Code
      stat_fc(mini_diamond, y = price, x = cut, rev_div = TRUE, .by = clarity) %>%
        print(n = Inf)
    Output
      # A tibble: 24 x 8
         y     clarity group1 group2     y1    y2    fc fc_fmt
         <chr> <chr>   <chr>  <chr>   <dbl> <dbl> <dbl> <chr> 
       1 price I1      Fair   Good    4695. 2760. 0.588 0.59x 
       2 price I1      Fair   Ideal   4695. 4249  0.905 0.90x 
       3 price I1      Good   Ideal   2760. 4249  1.54  1.5x  
       4 price IF      Fair   Good    2016  1044. 0.518 0.52x 
       5 price IF      Fair   Ideal   2016   962. 0.477 0.48x 
       6 price IF      Good   Ideal   1044.  962. 0.921 0.92x 
       7 price SI1     Fair   Good    5844. 3227. 0.552 0.55x 
       8 price SI1     Fair   Ideal   5844. 3877. 0.663 0.66x 
       9 price SI1     Good   Ideal   3227. 3877. 1.20  1.2x  
      10 price SI2     Fair   Good   13162. 6539. 0.497 0.50x 
      11 price SI2     Fair   Ideal  13162. 4267. 0.324 0.32x 
      12 price SI2     Good   Ideal   6539. 4267. 0.653 0.65x 
      13 price VS1     Fair   Good    6228.  775  0.124 0.12x 
      14 price VS1     Fair   Ideal   6228. 2256. 0.362 0.36x 
      15 price VS1     Good   Ideal    775  2256. 2.91  2.9x  
      16 price VS2     Fair   Good    3529. 5582. 1.58  1.6x  
      17 price VS2     Fair   Ideal   3529. 3024. 0.857 0.86x 
      18 price VS2     Good   Ideal   5582. 3024. 0.542 0.54x 
      19 price VVS1    Fair   Good    2184  2810. 1.29  1.3x  
      20 price VVS1    Fair   Ideal   2184  4652. 2.13  2.1x  
      21 price VVS1    Good   Ideal   2810. 4652. 1.66  1.7x  
      22 price VVS2    Fair   Good    3543  7481. 2.11  2.1x  
      23 price VVS2    Fair   Ideal   3543  1072. 0.303 0.30x 
      24 price VVS2    Good   Ideal   7481. 1072. 0.143 0.14x 

# stat_fc, method='median'

    Code
      suppressWarnings(stat_fc(mini_diamond, y = price, x = cut, .by = clarity,
        method = "median") %>% print(n = Inf))
    Output
      # A tibble: 24 x 8
         y     clarity group1 group2     y1    y2    fc fc_fmt
         <chr> <chr>   <chr>  <chr>   <dbl> <dbl> <dbl> <chr> 
       1 price I1      Fair   Good    5667  2143  2.64  2.6x  
       2 price I1      Fair   Ideal   5667  3024  1.87  1.9x  
       3 price I1      Good   Ideal   2143  3024  0.709 0.71x 
       4 price IF      Fair   Good    1826. 1052  1.74  1.7x  
       5 price IF      Fair   Ideal   1826.  877  2.08  2.1x  
       6 price IF      Good   Ideal   1052   877  1.20  1.2x  
       7 price SI1     Fair   Good    3027  3533  0.857 0.86x 
       8 price SI1     Fair   Ideal   3027  5370  0.564 0.56x 
       9 price SI1     Good   Ideal   3533  5370  0.658 0.66x 
      10 price SI2     Fair   Good   14716. 5671  2.59  2.6x  
      11 price SI2     Fair   Ideal  14716. 3086. 4.77  4.8x  
      12 price SI2     Good   Ideal   5671  3086. 1.84  1.8x  
      13 price VS1     Fair   Good    6115   775  7.89  7.9x  
      14 price VS1     Fair   Ideal   6115  2498  2.45  2.4x  
      15 price VS1     Good   Ideal    775  2498  0.310 0.31x 
      16 price VS2     Fair   Good    2815  3746. 0.751 0.75x 
      17 price VS2     Fair   Ideal   2815  3024. 0.931 0.93x 
      18 price VS2     Good   Ideal   3746. 3024. 1.24  1.2x  
      19 price VVS1    Fair   Good    1691  1314  1.29  1.3x  
      20 price VVS1    Fair   Ideal   1691  3487  0.485 0.48x 
      21 price VVS1    Good   Ideal   1314  3487  0.377 0.38x 
      22 price VVS2    Fair   Good    3800  6748  0.563 0.56x 
      23 price VVS2    Fair   Ideal   3800   854  4.45  4.4x  
      24 price VVS2    Good   Ideal   6748   854  7.90  7.9x  

# stat_fc, method='geom_mean'

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity, method = "geom_mean") %>%
        print(n = Inf)
    Output
      # A tibble: 24 x 8
         y     clarity group1 group2     y1    y2    fc fc_fmt
         <chr> <chr>   <chr>  <chr>   <dbl> <dbl> <dbl> <chr> 
       1 price I1      Fair   Good    3911. 1571. 2.49  2.5x  
       2 price I1      Fair   Ideal   3911. 3611. 1.08  1.1x  
       3 price I1      Good   Ideal   1571. 3611. 0.435 0.44x 
       4 price IF      Fair   Good    1874.  961. 1.95  1.9x  
       5 price IF      Fair   Ideal   1874.  950. 1.97  2.0x  
       6 price IF      Good   Ideal    961.  950. 1.01  1.0x  
       7 price SI1     Fair   Good    3833. 2401. 1.60  1.6x  
       8 price SI1     Fair   Ideal   3833. 3268. 1.17  1.2x  
       9 price SI1     Good   Ideal   2401. 3268. 0.735 0.73x 
      10 price SI2     Fair   Good   12609. 4605. 2.74  2.7x  
      11 price SI2     Fair   Ideal  12609. 3319. 3.80  3.8x  
      12 price SI2     Good   Ideal   4605. 3319. 1.39  1.4x  
      13 price VS1     Fair   Good    6194.  754. 8.21  8.2x  
      14 price VS1     Fair   Ideal   6194. 1641. 3.77  3.8x  
      15 price VS1     Good   Ideal    754. 1641. 0.459 0.46x 
      16 price VS2     Fair   Good    3330. 4728. 0.704 0.70x 
      17 price VS2     Fair   Ideal   3330. 1845. 1.80  1.8x  
      18 price VS2     Good   Ideal   4728. 1845. 2.56  2.6x  
      19 price VVS1    Fair   Good    1863. 1773. 1.05  1.1x  
      20 price VVS1    Fair   Ideal   1863. 4052. 0.460 0.46x 
      21 price VVS1    Good   Ideal   1773. 4052. 0.438 0.44x 
      22 price VVS2    Fair   Good    3184. 4688. 0.679 0.68x 
      23 price VVS2    Fair   Ideal   3184.  967. 3.29  3.3x  
      24 price VVS2    Good   Ideal   4688.  967. 4.85  4.8x  

