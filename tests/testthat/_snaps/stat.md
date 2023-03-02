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

---

    Code
      stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
    Output
      # A tibble: 1,266 x 7
         clarity cut_1 cut_2 price_1 price_2 fc_price fc_price_fmt
         <chr>   <chr> <chr>   <int>   <int>    <dbl> <chr>       
       1 SI1     Fair  Fair     3027    3027    1     1.0x        
       2 SI1     Fair  Ideal    3027    5590    0.542 0.54x       
       3 SI1     Fair  Ideal    3027    1633    1.85  1.9x        
       4 SI1     Fair  Good     3027    5252    0.576 0.58x       
       5 SI1     Fair  Good     3027     589    5.14  5.1x        
       6 SI1     Fair  Ideal    3027    5370    0.564 0.56x       
       7 SI1     Fair  Good     3027    4851    0.624 0.62x       
       8 SI1     Fair  Fair     3027    4480    0.676 0.68x       
       9 SI1     Fair  Fair     3027    1952    1.55  1.6x        
      10 SI1     Fair  Fair     3027   18026    0.168 0.17x       
      # ... with 1,256 more rows

