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

