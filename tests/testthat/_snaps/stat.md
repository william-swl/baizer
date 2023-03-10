# stat_test

    Code
      stat_test(mini_diamond, y = price, x = cut, .by = clarity)
    Output
      # A tibble: 24 x 11
         clarity .y.   group1 group2    n1    n2 statistic     p p.adj p.adj~1 p.sig~2
         <chr>   <chr> <chr>  <chr>  <int> <int>     <dbl> <dbl> <dbl> <chr>   <chr>  
       1 I1      price Fair   Good       5     5        18 0.31  0.62  ns      NS     
       2 I1      price Fair   Ideal      5     4        11 0.905 0.905 ns      NS     
       3 I1      price Good   Ideal      5     4         4 0.19  0.57  ns      NS     
       4 IF      price Fair   Good       4     5        18 0.064 0.177 ns      NS     
       5 IF      price Fair   Ideal      4     4        15 0.059 0.177 ns      NS     
       6 IF      price Good   Ideal      5     4        10 1     1     ns      NS     
       7 SI1     price Fair   Good       5     4        10 1     1     ns      NS     
       8 SI1     price Fair   Ideal      5     5        13 1     1     ns      NS     
       9 SI1     price Good   Ideal      4     5         6 0.413 1     ns      NS     
      10 SI2     price Fair   Good       4     4        15 0.057 0.171 ns      NS     
      # ... with 14 more rows, and abbreviated variable names 1: p.adj.signif,
      #   2: p.signif

# stat_fc

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2    y1    y2    fc fc_fmt
         <chr>   <chr>  <chr>  <dbl> <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair   5844. 5844.  1    1.0x  
       2 SI1     Fair   Ideal  5844. 3877.  1.51 1.5x  
       3 SI1     Fair   Good   5844. 3227.  1.81 1.8x  
       4 VS2     Good   Good   5582. 5582.  1    1.0x  
       5 VS2     Good   Ideal  5582. 3024.  1.85 1.8x  
       6 VS2     Good   Fair   5582. 3529.  1.58 1.6x  
       7 VVS1    Ideal  Ideal  4652. 4652.  1    1.0x  
       8 VVS1    Ideal  Good   4652. 2810.  1.66 1.7x  
       9 VVS1    Ideal  Fair   4652. 2184   2.13 2.1x  
      10 SI2     Ideal  Ideal  4267. 4267.  1    1.0x  
      # ... with 62 more rows

# stat_fc, method='median'

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity, method = "median")
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2    y1    y2    fc fc_fmt
         <chr>   <chr>  <chr>  <dbl> <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair   3027  3027  1     1.0x  
       2 SI1     Fair   Ideal  3027  5370  0.564 0.56x 
       3 SI1     Fair   Good   3027  3533  0.857 0.86x 
       4 VS2     Good   Good   3746. 3746. 1     1.0x  
       5 VS2     Good   Ideal  3746. 3024. 1.24  1.2x  
       6 VS2     Good   Fair   3746. 2815  1.33  1.3x  
       7 VVS1    Ideal  Ideal  3487  3487  1     1.0x  
       8 VVS1    Ideal  Good   3487  1314  2.65  2.7x  
       9 VVS1    Ideal  Fair   3487  1691  2.06  2.1x  
      10 SI2     Ideal  Ideal  3086. 3086. 1     1.0x  
      # ... with 62 more rows

# stat_fc, method='geom_mean'

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity, method = "geom_mean")
    Warning <lifecycle_warning_deprecated>
      Using an external vector in selections was deprecated in tidyselect 1.1.0.
      i Please use `all_of()` or `any_of()` instead.
        # Was:
        data %>% select(rename_vector)
      
        # Now:
        data %>% select(all_of(rename_vector))
      
      See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    Output
      # A tibble: 72 x 7
         clarity group1 group2    y1    y2    fc fc_fmt
         <chr>   <chr>  <chr>  <dbl> <dbl> <dbl> <chr> 
       1 SI1     Fair   Fair   3833. 3833.  1    1.0x  
       2 SI1     Fair   Ideal  3833. 3268.  1.17 1.2x  
       3 SI1     Fair   Good   3833. 2401.  1.60 1.6x  
       4 VS2     Good   Good   4728. 4728.  1    1.0x  
       5 VS2     Good   Ideal  4728. 1845.  2.56 2.6x  
       6 VS2     Good   Fair   4728. 3330.  1.42 1.4x  
       7 VVS1    Ideal  Ideal  4052. 4052.  1    1.0x  
       8 VVS1    Ideal  Good   4052. 1773.  2.29 2.3x  
       9 VVS1    Ideal  Fair   4052. 1863.  2.18 2.2x  
      10 SI2     Ideal  Ideal  3319. 3319.  1    1.0x  
      # ... with 62 more rows

