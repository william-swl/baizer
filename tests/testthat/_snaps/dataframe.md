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
      2 Good     31  0.31
      3 Ideal    34  0.34

# fancy_count, ext_fmt='count'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "count")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                
        <chr> <int> <dbl> <chr>                                                  
      1 Fair     35  0.35 I1(5),IF(4),SI1(5),SI2(4),VS1(3),VS2(5),VVS1(5),VVS2(4)
      2 Good     31  0.31 I1(5),IF(5),SI1(4),SI2(4),VS1(2),VS2(4),VVS1(4),VVS2(3)
      3 Ideal    34  0.34 I1(4),IF(4),SI1(5),SI2(4),VS1(5),VS2(2),VVS1(5),VVS2(5)

# fancy_count, ext_fmt='ratio'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                                                     
        <chr> <int> <dbl> <chr>                                                       
      1 Fair     35  0.35 I1(0.14),IF(0.11),SI1(0.14),SI2(0.11),VS1(0.09),VS2(0.14),V~
      2 Good     31  0.31 I1(0.16),IF(0.16),SI1(0.13),SI2(0.13),VS1(0.06),VS2(0.13),V~
      3 Ideal    34  0.34 I1(0.12),IF(0.12),SI1(0.15),SI2(0.12),VS1(0.15),VS2(0.06),V~

# fancy_count, ext_fmt='clean'

    Code
      fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
    Output
      # A tibble: 3 x 4
        cut       n     r clarity                        
        <chr> <int> <dbl> <chr>                          
      1 Fair     35  0.35 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2
      2 Good     31  0.31 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2
      3 Ideal    34  0.34 I1,IF,SI1,SI2,VS1,VS2,VVS1,VVS2

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
      fancy_count(mini_diamond, cut, clarity, ext = id) %>% print(n = Inf)
    Output
      # A tibble: 24 x 5
         cut   clarity     n     r id                                          
         <chr> <chr>   <int> <dbl> <chr>                                       
       1 Fair  I1          5  0.05 id-20(1),id-23(1),id-28(1),id-32(1),id-48(1)
       2 Fair  IF          4  0.04 id-12(1),id-45(1),id-89(1),id-95(1)         
       3 Fair  SI1         5  0.05 id-1(1),id-64(1),id-65(1),id-68(1),id-76(1) 
       4 Fair  SI2         4  0.04 id-25(1),id-40(1),id-6(1),id-99(1)          
       5 Fair  VS1         3  0.03 id-36(1),id-43(1),id-85(1)                  
       6 Fair  VS2         5  0.05 id-52(1),id-63(1),id-66(1),id-70(1),id-77(1)
       7 Fair  VVS1        5  0.05 id-10(1),id-18(1),id-46(1),id-55(1),id-59(1)
       8 Fair  VVS2        4  0.04 id-30(1),id-58(1),id-79(1),id-98(1)         
       9 Good  I1          5  0.05 id-16(1),id-34(1),id-69(1),id-82(1),id-91(1)
      10 Good  IF          5  0.05 id-15(1),id-53(1),id-56(1),id-61(1),id-62(1)
      11 Good  SI1         4  0.04 id-33(1),id-42(1),id-50(1),id-75(1)         
      12 Good  SI2         4  0.04 id-100(1),id-27(1),id-8(1),id-97(1)         
      13 Good  VS1         2  0.02 id-81(1),id-87(1)                           
      14 Good  VS2         4  0.04 id-2(1),id-22(1),id-24(1),id-44(1)          
      15 Good  VVS1        4  0.04 id-11(1),id-21(1),id-7(1),id-74(1)          
      16 Good  VVS2        3  0.03 id-51(1),id-72(1),id-92(1)                  
      17 Ideal I1          4  0.04 id-17(1),id-49(1),id-71(1),id-90(1)         
      18 Ideal IF          4  0.04 id-39(1),id-57(1),id-73(1),id-86(1)         
      19 Ideal SI1         5  0.05 id-13(1),id-47(1),id-84(1),id-9(1),id-93(1) 
      20 Ideal SI2         4  0.04 id-29(1),id-4(1),id-41(1),id-67(1)          
      21 Ideal VS1         5  0.05 id-26(1),id-5(1),id-78(1),id-80(1),id-94(1) 
      22 Ideal VS2         2  0.02 id-38(1),id-88(1)                           
      23 Ideal VVS1        5  0.05 id-3(1),id-31(1),id-35(1),id-37(1),id-83(1) 
      24 Ideal VVS2        5  0.05 id-14(1),id-19(1),id-54(1),id-60(1),id-96(1)

# expand_df

    Code
      fancy_count(mini_diamond, cut, ext = clarity) %>% split_column(name_col = cut,
        value_col = clarity) %>% print(n = Inf)
    Output
      # A tibble: 24 x 2
         cut   clarity
         <chr> <chr>  
       1 Fair  I1(5)  
       2 Fair  IF(4)  
       3 Fair  SI1(5) 
       4 Fair  SI2(4) 
       5 Fair  VS1(3) 
       6 Fair  VS2(5) 
       7 Fair  VVS1(5)
       8 Fair  VVS2(4)
       9 Good  I1(5)  
      10 Good  IF(5)  
      11 Good  SI1(4) 
      12 Good  SI2(4) 
      13 Good  VS1(2) 
      14 Good  VS2(4) 
      15 Good  VVS1(4)
      16 Good  VVS2(3)
      17 Ideal I1(4)  
      18 Ideal IF(4)  
      19 Ideal SI1(5) 
      20 Ideal SI2(4) 
      21 Ideal VS1(5) 
      22 Ideal VS2(2) 
      23 Ideal VVS1(5)
      24 Ideal VVS2(5)

# move_row, .after=TRUE

    Code
      move_row(mini_diamond, 3:5, .after = TRUE) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-1    1.02 Fair  SI1      3027  6.25  6.18
        2 id-2    1.51 Good  VS2     11746  7.27  7.18
        3 id-6    2.02 Fair  SI2     14080  8.33  8.37
        4 id-7    0.27 Good  VVS1      752  4.1   4.07
        5 id-8    0.51 Good  SI2      1029  5.05  5.08
        6 id-9    1.01 Ideal SI1      5590  6.43  6.4 
        7 id-10   0.7  Fair  VVS1     1691  5.56  5.41
        8 id-11   1.02 Good  VVS1     7861  6.37  6.4 
        9 id-12   0.71 Fair  IF       3205  5.87  5.81
       10 id-13   0.56 Ideal SI1      1633  5.31  5.32
       11 id-14   0.3  Ideal VVS2      812  4.33  4.39
       12 id-15   0.28 Good  IF        612  4.09  4.12
       13 id-16   0.41 Good  I1        467  4.7   4.74
       14 id-17   0.97 Ideal I1       2239  6.4   6.43
       15 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       16 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       17 id-20   1.2  Fair  I1       3011  6.61  6.54
       18 id-21   0.4  Good  VVS1     1080  4.71  4.73
       19 id-22   0.9  Good  VS2      3246  6.16  6.07
       20 id-23   0.7  Fair  I1       1158  5.64  5.5 
       21 id-24   0.92 Good  VS2      4247  6.11  6.17
       22 id-25   2.1  Fair  SI2     15827  7.97  7.92
       23 id-26   0.31 Ideal VS1       717  4.36  4.41
       24 id-27   1.13 Good  SI2      4998  6.93  6.88
       25 id-28   2.02 Fair  I1       6346  7.87  7.8 
       26 id-29   0.72 Ideal SI2      2300  5.72  5.78
       27 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       28 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       29 id-32   2    Fair  I1       5667  7.78  7.74
       30 id-33   1.21 Good  SI1      5252  6.63  6.71
       31 id-34   1.14 Good  I1       2327  6.63  6.55
       32 id-35   1    Ideal VVS1     6535  6.37  6.41
       33 id-36   1    Fair  VS1      6115  6.26  6.21
       34 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       35 id-38   1.09 Ideal VS2      5421  6.62  6.67
       36 id-39   0.3  Ideal IF        863  4.33  4.36
       37 id-40   1.52 Fair  SI2      7388  7.23  7.19
       38 id-41   0.98 Ideal SI2      3873  6.35  6.39
       39 id-42   0.32 Good  SI1       589  4.33  4.35
       40 id-43   1.12 Fair  VS1      5487  6.48  6.52
       41 id-44   0.7  Good  VS2      3087  5.49  5.56
       42 id-45   0.47 Fair  IF       2211  5.09  4.98
       43 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       44 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       45 id-48   2.01 Fair  I1       7294  8.3   8.19
       46 id-49   2.16 Ideal I1       8709  8.31  8.26
       47 id-50   1    Good  SI1      4851  6.27  6.31
       48 id-51   1    Good  VVS2     6748  6.32  6.3 
       49 id-52   0.72 Fair  VS2      2306  5.66  5.71
       50 id-53   0.33 Good  IF       1052  4.57  4.55
       51 id-54   0.4  Ideal VVS2      931  4.72  4.75
       52 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       53 id-56   0.4  Good  IF       1120  4.75  4.8 
       54 id-57   0.3  Ideal IF        863  4.32  4.34
       55 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       56 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       57 id-60   0.29 Ideal VVS2      607  4.27  4.29
       58 id-61   0.3  Good  IF        631  4.23  4.3 
       59 id-62   0.46 Good  IF       1806  5.12  5.18
       60 id-63   1.35 Fair  VS2      5625  6.98  6.93
       61 id-64   1.01 Fair  SI1      4480  6.34  6.29
       62 id-65   0.63 Fair  SI1      1952  5.36  5.41
       63 id-66   0.9  Fair  VS2      2815  6.08  6.04
       64 id-67   0.58 Ideal SI2      1442  5.4   5.36
       65 id-68   2.32 Fair  SI1     18026  8.47  8.31
       66 id-69   0.4  Good  I1        491  4.64  4.68
       67 id-70   0.9  Fair  VS2      4277  6.26  6.29
       68 id-71   0.97 Ideal I1       2370  6.34  6.28
       69 id-72   0.42 Good  VVS2     1042  4.72  4.78
       70 id-73   0.4  Ideal IF       1229  4.73  4.76
       71 id-74   0.45 Good  VVS1     1548  4.85  4.78
       72 id-75   0.71 Good  SI1      2215  5.62  5.59
       73 id-76   0.64 Fair  SI1      1733  5.65  5.39
       74 id-77   0.71 Fair  VS2      2623  5.83  5.81
       75 id-78   0.7  Ideal VS1      3535  5.69  5.72
       76 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       77 id-80   0.8  Ideal VS1      4070  5.91  5.96
       78 id-81   0.41 Good  VS1       954  4.77  4.79
       79 id-82   0.9  Good  I1       2143  6.09  6.05
       80 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       81 id-84   0.5  Ideal SI1      1415  5.11  5.05
       82 id-85   1    Fair  VS1      7083  6.77  6.71
       83 id-86   0.31 Ideal IF        891  4.38  4.4 
       84 id-87   0.34 Good  VS1       596  4.4   4.44
       85 id-88   0.31 Ideal VS2       628  4.38  4.34
       86 id-89   0.3  Fair  IF       1208  4.47  4.35
       87 id-90   1.13 Ideal I1       3678  6.65  6.69
       88 id-91   1.73 Good  I1       8370  7.6   7.56
       89 id-92   1.51 Good  VVS2    14654  7.18  7.24
       90 id-93   1.09 Ideal SI1      5376  6.6   6.64
       91 id-94   0.28 Ideal VS1       462  4.19  4.23
       92 id-95   0.37 Fair  IF       1440  4.68  4.73
       93 id-96   0.32 Ideal VVS2      854  4.45  4.46
       94 id-97   2.61 Good  SI2     13784  8.66  8.57
       95 id-98   1    Fair  VVS2     4312  6.27  6.23
       96 id-99   2    Fair  SI2     15351  7.63  7.59
       97 id-100  1.2  Good  SI2      6344  6.72  6.68
       98 id-3    0.52 Ideal VVS1     2029  5.15  5.18
       99 id-4    1.54 Ideal SI2      9452  7.43  7.45
      100 id-5    0.72 Ideal VS1      2498  5.73  5.77

# move_row, after last row

    Code
      move_row(mini_diamond, 3:5, .after = nrow(mini_diamond)) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-1    1.02 Fair  SI1      3027  6.25  6.18
        2 id-2    1.51 Good  VS2     11746  7.27  7.18
        3 id-6    2.02 Fair  SI2     14080  8.33  8.37
        4 id-7    0.27 Good  VVS1      752  4.1   4.07
        5 id-8    0.51 Good  SI2      1029  5.05  5.08
        6 id-9    1.01 Ideal SI1      5590  6.43  6.4 
        7 id-10   0.7  Fair  VVS1     1691  5.56  5.41
        8 id-11   1.02 Good  VVS1     7861  6.37  6.4 
        9 id-12   0.71 Fair  IF       3205  5.87  5.81
       10 id-13   0.56 Ideal SI1      1633  5.31  5.32
       11 id-14   0.3  Ideal VVS2      812  4.33  4.39
       12 id-15   0.28 Good  IF        612  4.09  4.12
       13 id-16   0.41 Good  I1        467  4.7   4.74
       14 id-17   0.97 Ideal I1       2239  6.4   6.43
       15 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       16 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       17 id-20   1.2  Fair  I1       3011  6.61  6.54
       18 id-21   0.4  Good  VVS1     1080  4.71  4.73
       19 id-22   0.9  Good  VS2      3246  6.16  6.07
       20 id-23   0.7  Fair  I1       1158  5.64  5.5 
       21 id-24   0.92 Good  VS2      4247  6.11  6.17
       22 id-25   2.1  Fair  SI2     15827  7.97  7.92
       23 id-26   0.31 Ideal VS1       717  4.36  4.41
       24 id-27   1.13 Good  SI2      4998  6.93  6.88
       25 id-28   2.02 Fair  I1       6346  7.87  7.8 
       26 id-29   0.72 Ideal SI2      2300  5.72  5.78
       27 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       28 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       29 id-32   2    Fair  I1       5667  7.78  7.74
       30 id-33   1.21 Good  SI1      5252  6.63  6.71
       31 id-34   1.14 Good  I1       2327  6.63  6.55
       32 id-35   1    Ideal VVS1     6535  6.37  6.41
       33 id-36   1    Fair  VS1      6115  6.26  6.21
       34 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       35 id-38   1.09 Ideal VS2      5421  6.62  6.67
       36 id-39   0.3  Ideal IF        863  4.33  4.36
       37 id-40   1.52 Fair  SI2      7388  7.23  7.19
       38 id-41   0.98 Ideal SI2      3873  6.35  6.39
       39 id-42   0.32 Good  SI1       589  4.33  4.35
       40 id-43   1.12 Fair  VS1      5487  6.48  6.52
       41 id-44   0.7  Good  VS2      3087  5.49  5.56
       42 id-45   0.47 Fair  IF       2211  5.09  4.98
       43 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       44 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       45 id-48   2.01 Fair  I1       7294  8.3   8.19
       46 id-49   2.16 Ideal I1       8709  8.31  8.26
       47 id-50   1    Good  SI1      4851  6.27  6.31
       48 id-51   1    Good  VVS2     6748  6.32  6.3 
       49 id-52   0.72 Fair  VS2      2306  5.66  5.71
       50 id-53   0.33 Good  IF       1052  4.57  4.55
       51 id-54   0.4  Ideal VVS2      931  4.72  4.75
       52 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       53 id-56   0.4  Good  IF       1120  4.75  4.8 
       54 id-57   0.3  Ideal IF        863  4.32  4.34
       55 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       56 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       57 id-60   0.29 Ideal VVS2      607  4.27  4.29
       58 id-61   0.3  Good  IF        631  4.23  4.3 
       59 id-62   0.46 Good  IF       1806  5.12  5.18
       60 id-63   1.35 Fair  VS2      5625  6.98  6.93
       61 id-64   1.01 Fair  SI1      4480  6.34  6.29
       62 id-65   0.63 Fair  SI1      1952  5.36  5.41
       63 id-66   0.9  Fair  VS2      2815  6.08  6.04
       64 id-67   0.58 Ideal SI2      1442  5.4   5.36
       65 id-68   2.32 Fair  SI1     18026  8.47  8.31
       66 id-69   0.4  Good  I1        491  4.64  4.68
       67 id-70   0.9  Fair  VS2      4277  6.26  6.29
       68 id-71   0.97 Ideal I1       2370  6.34  6.28
       69 id-72   0.42 Good  VVS2     1042  4.72  4.78
       70 id-73   0.4  Ideal IF       1229  4.73  4.76
       71 id-74   0.45 Good  VVS1     1548  4.85  4.78
       72 id-75   0.71 Good  SI1      2215  5.62  5.59
       73 id-76   0.64 Fair  SI1      1733  5.65  5.39
       74 id-77   0.71 Fair  VS2      2623  5.83  5.81
       75 id-78   0.7  Ideal VS1      3535  5.69  5.72
       76 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       77 id-80   0.8  Ideal VS1      4070  5.91  5.96
       78 id-81   0.41 Good  VS1       954  4.77  4.79
       79 id-82   0.9  Good  I1       2143  6.09  6.05
       80 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       81 id-84   0.5  Ideal SI1      1415  5.11  5.05
       82 id-85   1    Fair  VS1      7083  6.77  6.71
       83 id-86   0.31 Ideal IF        891  4.38  4.4 
       84 id-87   0.34 Good  VS1       596  4.4   4.44
       85 id-88   0.31 Ideal VS2       628  4.38  4.34
       86 id-89   0.3  Fair  IF       1208  4.47  4.35
       87 id-90   1.13 Ideal I1       3678  6.65  6.69
       88 id-91   1.73 Good  I1       8370  7.6   7.56
       89 id-92   1.51 Good  VVS2    14654  7.18  7.24
       90 id-93   1.09 Ideal SI1      5376  6.6   6.64
       91 id-94   0.28 Ideal VS1       462  4.19  4.23
       92 id-95   0.37 Fair  IF       1440  4.68  4.73
       93 id-96   0.32 Ideal VVS2      854  4.45  4.46
       94 id-97   2.61 Good  SI2     13784  8.66  8.57
       95 id-98   1    Fair  VVS2     4312  6.27  6.23
       96 id-99   2    Fair  SI2     15351  7.63  7.59
       97 id-100  1.2  Good  SI2      6344  6.72  6.68
       98 id-3    0.52 Ideal VVS1     2029  5.15  5.18
       99 id-4    1.54 Ideal SI2      9452  7.43  7.45
      100 id-5    0.72 Ideal VS1      2498  5.73  5.77

# move_row, after first row

    Code
      move_row(mini_diamond, 3:5, .after = 1) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-1    1.02 Fair  SI1      3027  6.25  6.18
        2 id-3    0.52 Ideal VVS1     2029  5.15  5.18
        3 id-4    1.54 Ideal SI2      9452  7.43  7.45
        4 id-5    0.72 Ideal VS1      2498  5.73  5.77
        5 id-2    1.51 Good  VS2     11746  7.27  7.18
        6 id-6    2.02 Fair  SI2     14080  8.33  8.37
        7 id-7    0.27 Good  VVS1      752  4.1   4.07
        8 id-8    0.51 Good  SI2      1029  5.05  5.08
        9 id-9    1.01 Ideal SI1      5590  6.43  6.4 
       10 id-10   0.7  Fair  VVS1     1691  5.56  5.41
       11 id-11   1.02 Good  VVS1     7861  6.37  6.4 
       12 id-12   0.71 Fair  IF       3205  5.87  5.81
       13 id-13   0.56 Ideal SI1      1633  5.31  5.32
       14 id-14   0.3  Ideal VVS2      812  4.33  4.39
       15 id-15   0.28 Good  IF        612  4.09  4.12
       16 id-16   0.41 Good  I1        467  4.7   4.74
       17 id-17   0.97 Ideal I1       2239  6.4   6.43
       18 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       19 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       20 id-20   1.2  Fair  I1       3011  6.61  6.54
       21 id-21   0.4  Good  VVS1     1080  4.71  4.73
       22 id-22   0.9  Good  VS2      3246  6.16  6.07
       23 id-23   0.7  Fair  I1       1158  5.64  5.5 
       24 id-24   0.92 Good  VS2      4247  6.11  6.17
       25 id-25   2.1  Fair  SI2     15827  7.97  7.92
       26 id-26   0.31 Ideal VS1       717  4.36  4.41
       27 id-27   1.13 Good  SI2      4998  6.93  6.88
       28 id-28   2.02 Fair  I1       6346  7.87  7.8 
       29 id-29   0.72 Ideal SI2      2300  5.72  5.78
       30 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       31 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       32 id-32   2    Fair  I1       5667  7.78  7.74
       33 id-33   1.21 Good  SI1      5252  6.63  6.71
       34 id-34   1.14 Good  I1       2327  6.63  6.55
       35 id-35   1    Ideal VVS1     6535  6.37  6.41
       36 id-36   1    Fair  VS1      6115  6.26  6.21
       37 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       38 id-38   1.09 Ideal VS2      5421  6.62  6.67
       39 id-39   0.3  Ideal IF        863  4.33  4.36
       40 id-40   1.52 Fair  SI2      7388  7.23  7.19
       41 id-41   0.98 Ideal SI2      3873  6.35  6.39
       42 id-42   0.32 Good  SI1       589  4.33  4.35
       43 id-43   1.12 Fair  VS1      5487  6.48  6.52
       44 id-44   0.7  Good  VS2      3087  5.49  5.56
       45 id-45   0.47 Fair  IF       2211  5.09  4.98
       46 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       47 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       48 id-48   2.01 Fair  I1       7294  8.3   8.19
       49 id-49   2.16 Ideal I1       8709  8.31  8.26
       50 id-50   1    Good  SI1      4851  6.27  6.31
       51 id-51   1    Good  VVS2     6748  6.32  6.3 
       52 id-52   0.72 Fair  VS2      2306  5.66  5.71
       53 id-53   0.33 Good  IF       1052  4.57  4.55
       54 id-54   0.4  Ideal VVS2      931  4.72  4.75
       55 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       56 id-56   0.4  Good  IF       1120  4.75  4.8 
       57 id-57   0.3  Ideal IF        863  4.32  4.34
       58 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       59 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       60 id-60   0.29 Ideal VVS2      607  4.27  4.29
       61 id-61   0.3  Good  IF        631  4.23  4.3 
       62 id-62   0.46 Good  IF       1806  5.12  5.18
       63 id-63   1.35 Fair  VS2      5625  6.98  6.93
       64 id-64   1.01 Fair  SI1      4480  6.34  6.29
       65 id-65   0.63 Fair  SI1      1952  5.36  5.41
       66 id-66   0.9  Fair  VS2      2815  6.08  6.04
       67 id-67   0.58 Ideal SI2      1442  5.4   5.36
       68 id-68   2.32 Fair  SI1     18026  8.47  8.31
       69 id-69   0.4  Good  I1        491  4.64  4.68
       70 id-70   0.9  Fair  VS2      4277  6.26  6.29
       71 id-71   0.97 Ideal I1       2370  6.34  6.28
       72 id-72   0.42 Good  VVS2     1042  4.72  4.78
       73 id-73   0.4  Ideal IF       1229  4.73  4.76
       74 id-74   0.45 Good  VVS1     1548  4.85  4.78
       75 id-75   0.71 Good  SI1      2215  5.62  5.59
       76 id-76   0.64 Fair  SI1      1733  5.65  5.39
       77 id-77   0.71 Fair  VS2      2623  5.83  5.81
       78 id-78   0.7  Ideal VS1      3535  5.69  5.72
       79 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       80 id-80   0.8  Ideal VS1      4070  5.91  5.96
       81 id-81   0.41 Good  VS1       954  4.77  4.79
       82 id-82   0.9  Good  I1       2143  6.09  6.05
       83 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       84 id-84   0.5  Ideal SI1      1415  5.11  5.05
       85 id-85   1    Fair  VS1      7083  6.77  6.71
       86 id-86   0.31 Ideal IF        891  4.38  4.4 
       87 id-87   0.34 Good  VS1       596  4.4   4.44
       88 id-88   0.31 Ideal VS2       628  4.38  4.34
       89 id-89   0.3  Fair  IF       1208  4.47  4.35
       90 id-90   1.13 Ideal I1       3678  6.65  6.69
       91 id-91   1.73 Good  I1       8370  7.6   7.56
       92 id-92   1.51 Good  VVS2    14654  7.18  7.24
       93 id-93   1.09 Ideal SI1      5376  6.6   6.64
       94 id-94   0.28 Ideal VS1       462  4.19  4.23
       95 id-95   0.37 Fair  IF       1440  4.68  4.73
       96 id-96   0.32 Ideal VVS2      854  4.45  4.46
       97 id-97   2.61 Good  SI2     13784  8.66  8.57
       98 id-98   1    Fair  VVS2     4312  6.27  6.23
       99 id-99   2    Fair  SI2     15351  7.63  7.59
      100 id-100  1.2  Good  SI2      6344  6.72  6.68

# move_row, .before=TRUE

    Code
      move_row(mini_diamond, 3:5, .before = TRUE) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-3    0.52 Ideal VVS1     2029  5.15  5.18
        2 id-4    1.54 Ideal SI2      9452  7.43  7.45
        3 id-5    0.72 Ideal VS1      2498  5.73  5.77
        4 id-1    1.02 Fair  SI1      3027  6.25  6.18
        5 id-2    1.51 Good  VS2     11746  7.27  7.18
        6 id-6    2.02 Fair  SI2     14080  8.33  8.37
        7 id-7    0.27 Good  VVS1      752  4.1   4.07
        8 id-8    0.51 Good  SI2      1029  5.05  5.08
        9 id-9    1.01 Ideal SI1      5590  6.43  6.4 
       10 id-10   0.7  Fair  VVS1     1691  5.56  5.41
       11 id-11   1.02 Good  VVS1     7861  6.37  6.4 
       12 id-12   0.71 Fair  IF       3205  5.87  5.81
       13 id-13   0.56 Ideal SI1      1633  5.31  5.32
       14 id-14   0.3  Ideal VVS2      812  4.33  4.39
       15 id-15   0.28 Good  IF        612  4.09  4.12
       16 id-16   0.41 Good  I1        467  4.7   4.74
       17 id-17   0.97 Ideal I1       2239  6.4   6.43
       18 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       19 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       20 id-20   1.2  Fair  I1       3011  6.61  6.54
       21 id-21   0.4  Good  VVS1     1080  4.71  4.73
       22 id-22   0.9  Good  VS2      3246  6.16  6.07
       23 id-23   0.7  Fair  I1       1158  5.64  5.5 
       24 id-24   0.92 Good  VS2      4247  6.11  6.17
       25 id-25   2.1  Fair  SI2     15827  7.97  7.92
       26 id-26   0.31 Ideal VS1       717  4.36  4.41
       27 id-27   1.13 Good  SI2      4998  6.93  6.88
       28 id-28   2.02 Fair  I1       6346  7.87  7.8 
       29 id-29   0.72 Ideal SI2      2300  5.72  5.78
       30 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       31 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       32 id-32   2    Fair  I1       5667  7.78  7.74
       33 id-33   1.21 Good  SI1      5252  6.63  6.71
       34 id-34   1.14 Good  I1       2327  6.63  6.55
       35 id-35   1    Ideal VVS1     6535  6.37  6.41
       36 id-36   1    Fair  VS1      6115  6.26  6.21
       37 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       38 id-38   1.09 Ideal VS2      5421  6.62  6.67
       39 id-39   0.3  Ideal IF        863  4.33  4.36
       40 id-40   1.52 Fair  SI2      7388  7.23  7.19
       41 id-41   0.98 Ideal SI2      3873  6.35  6.39
       42 id-42   0.32 Good  SI1       589  4.33  4.35
       43 id-43   1.12 Fair  VS1      5487  6.48  6.52
       44 id-44   0.7  Good  VS2      3087  5.49  5.56
       45 id-45   0.47 Fair  IF       2211  5.09  4.98
       46 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       47 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       48 id-48   2.01 Fair  I1       7294  8.3   8.19
       49 id-49   2.16 Ideal I1       8709  8.31  8.26
       50 id-50   1    Good  SI1      4851  6.27  6.31
       51 id-51   1    Good  VVS2     6748  6.32  6.3 
       52 id-52   0.72 Fair  VS2      2306  5.66  5.71
       53 id-53   0.33 Good  IF       1052  4.57  4.55
       54 id-54   0.4  Ideal VVS2      931  4.72  4.75
       55 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       56 id-56   0.4  Good  IF       1120  4.75  4.8 
       57 id-57   0.3  Ideal IF        863  4.32  4.34
       58 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       59 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       60 id-60   0.29 Ideal VVS2      607  4.27  4.29
       61 id-61   0.3  Good  IF        631  4.23  4.3 
       62 id-62   0.46 Good  IF       1806  5.12  5.18
       63 id-63   1.35 Fair  VS2      5625  6.98  6.93
       64 id-64   1.01 Fair  SI1      4480  6.34  6.29
       65 id-65   0.63 Fair  SI1      1952  5.36  5.41
       66 id-66   0.9  Fair  VS2      2815  6.08  6.04
       67 id-67   0.58 Ideal SI2      1442  5.4   5.36
       68 id-68   2.32 Fair  SI1     18026  8.47  8.31
       69 id-69   0.4  Good  I1        491  4.64  4.68
       70 id-70   0.9  Fair  VS2      4277  6.26  6.29
       71 id-71   0.97 Ideal I1       2370  6.34  6.28
       72 id-72   0.42 Good  VVS2     1042  4.72  4.78
       73 id-73   0.4  Ideal IF       1229  4.73  4.76
       74 id-74   0.45 Good  VVS1     1548  4.85  4.78
       75 id-75   0.71 Good  SI1      2215  5.62  5.59
       76 id-76   0.64 Fair  SI1      1733  5.65  5.39
       77 id-77   0.71 Fair  VS2      2623  5.83  5.81
       78 id-78   0.7  Ideal VS1      3535  5.69  5.72
       79 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       80 id-80   0.8  Ideal VS1      4070  5.91  5.96
       81 id-81   0.41 Good  VS1       954  4.77  4.79
       82 id-82   0.9  Good  I1       2143  6.09  6.05
       83 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       84 id-84   0.5  Ideal SI1      1415  5.11  5.05
       85 id-85   1    Fair  VS1      7083  6.77  6.71
       86 id-86   0.31 Ideal IF        891  4.38  4.4 
       87 id-87   0.34 Good  VS1       596  4.4   4.44
       88 id-88   0.31 Ideal VS2       628  4.38  4.34
       89 id-89   0.3  Fair  IF       1208  4.47  4.35
       90 id-90   1.13 Ideal I1       3678  6.65  6.69
       91 id-91   1.73 Good  I1       8370  7.6   7.56
       92 id-92   1.51 Good  VVS2    14654  7.18  7.24
       93 id-93   1.09 Ideal SI1      5376  6.6   6.64
       94 id-94   0.28 Ideal VS1       462  4.19  4.23
       95 id-95   0.37 Fair  IF       1440  4.68  4.73
       96 id-96   0.32 Ideal VVS2      854  4.45  4.46
       97 id-97   2.61 Good  SI2     13784  8.66  8.57
       98 id-98   1    Fair  VVS2     4312  6.27  6.23
       99 id-99   2    Fair  SI2     15351  7.63  7.59
      100 id-100  1.2  Good  SI2      6344  6.72  6.68

# move_row, beofre first row

    Code
      move_row(mini_diamond, 3:5, .before = 1) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-3    0.52 Ideal VVS1     2029  5.15  5.18
        2 id-4    1.54 Ideal SI2      9452  7.43  7.45
        3 id-5    0.72 Ideal VS1      2498  5.73  5.77
        4 id-1    1.02 Fair  SI1      3027  6.25  6.18
        5 id-2    1.51 Good  VS2     11746  7.27  7.18
        6 id-6    2.02 Fair  SI2     14080  8.33  8.37
        7 id-7    0.27 Good  VVS1      752  4.1   4.07
        8 id-8    0.51 Good  SI2      1029  5.05  5.08
        9 id-9    1.01 Ideal SI1      5590  6.43  6.4 
       10 id-10   0.7  Fair  VVS1     1691  5.56  5.41
       11 id-11   1.02 Good  VVS1     7861  6.37  6.4 
       12 id-12   0.71 Fair  IF       3205  5.87  5.81
       13 id-13   0.56 Ideal SI1      1633  5.31  5.32
       14 id-14   0.3  Ideal VVS2      812  4.33  4.39
       15 id-15   0.28 Good  IF        612  4.09  4.12
       16 id-16   0.41 Good  I1        467  4.7   4.74
       17 id-17   0.97 Ideal I1       2239  6.4   6.43
       18 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       19 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       20 id-20   1.2  Fair  I1       3011  6.61  6.54
       21 id-21   0.4  Good  VVS1     1080  4.71  4.73
       22 id-22   0.9  Good  VS2      3246  6.16  6.07
       23 id-23   0.7  Fair  I1       1158  5.64  5.5 
       24 id-24   0.92 Good  VS2      4247  6.11  6.17
       25 id-25   2.1  Fair  SI2     15827  7.97  7.92
       26 id-26   0.31 Ideal VS1       717  4.36  4.41
       27 id-27   1.13 Good  SI2      4998  6.93  6.88
       28 id-28   2.02 Fair  I1       6346  7.87  7.8 
       29 id-29   0.72 Ideal SI2      2300  5.72  5.78
       30 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       31 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       32 id-32   2    Fair  I1       5667  7.78  7.74
       33 id-33   1.21 Good  SI1      5252  6.63  6.71
       34 id-34   1.14 Good  I1       2327  6.63  6.55
       35 id-35   1    Ideal VVS1     6535  6.37  6.41
       36 id-36   1    Fair  VS1      6115  6.26  6.21
       37 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       38 id-38   1.09 Ideal VS2      5421  6.62  6.67
       39 id-39   0.3  Ideal IF        863  4.33  4.36
       40 id-40   1.52 Fair  SI2      7388  7.23  7.19
       41 id-41   0.98 Ideal SI2      3873  6.35  6.39
       42 id-42   0.32 Good  SI1       589  4.33  4.35
       43 id-43   1.12 Fair  VS1      5487  6.48  6.52
       44 id-44   0.7  Good  VS2      3087  5.49  5.56
       45 id-45   0.47 Fair  IF       2211  5.09  4.98
       46 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       47 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       48 id-48   2.01 Fair  I1       7294  8.3   8.19
       49 id-49   2.16 Ideal I1       8709  8.31  8.26
       50 id-50   1    Good  SI1      4851  6.27  6.31
       51 id-51   1    Good  VVS2     6748  6.32  6.3 
       52 id-52   0.72 Fair  VS2      2306  5.66  5.71
       53 id-53   0.33 Good  IF       1052  4.57  4.55
       54 id-54   0.4  Ideal VVS2      931  4.72  4.75
       55 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       56 id-56   0.4  Good  IF       1120  4.75  4.8 
       57 id-57   0.3  Ideal IF        863  4.32  4.34
       58 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       59 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       60 id-60   0.29 Ideal VVS2      607  4.27  4.29
       61 id-61   0.3  Good  IF        631  4.23  4.3 
       62 id-62   0.46 Good  IF       1806  5.12  5.18
       63 id-63   1.35 Fair  VS2      5625  6.98  6.93
       64 id-64   1.01 Fair  SI1      4480  6.34  6.29
       65 id-65   0.63 Fair  SI1      1952  5.36  5.41
       66 id-66   0.9  Fair  VS2      2815  6.08  6.04
       67 id-67   0.58 Ideal SI2      1442  5.4   5.36
       68 id-68   2.32 Fair  SI1     18026  8.47  8.31
       69 id-69   0.4  Good  I1        491  4.64  4.68
       70 id-70   0.9  Fair  VS2      4277  6.26  6.29
       71 id-71   0.97 Ideal I1       2370  6.34  6.28
       72 id-72   0.42 Good  VVS2     1042  4.72  4.78
       73 id-73   0.4  Ideal IF       1229  4.73  4.76
       74 id-74   0.45 Good  VVS1     1548  4.85  4.78
       75 id-75   0.71 Good  SI1      2215  5.62  5.59
       76 id-76   0.64 Fair  SI1      1733  5.65  5.39
       77 id-77   0.71 Fair  VS2      2623  5.83  5.81
       78 id-78   0.7  Ideal VS1      3535  5.69  5.72
       79 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       80 id-80   0.8  Ideal VS1      4070  5.91  5.96
       81 id-81   0.41 Good  VS1       954  4.77  4.79
       82 id-82   0.9  Good  I1       2143  6.09  6.05
       83 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       84 id-84   0.5  Ideal SI1      1415  5.11  5.05
       85 id-85   1    Fair  VS1      7083  6.77  6.71
       86 id-86   0.31 Ideal IF        891  4.38  4.4 
       87 id-87   0.34 Good  VS1       596  4.4   4.44
       88 id-88   0.31 Ideal VS2       628  4.38  4.34
       89 id-89   0.3  Fair  IF       1208  4.47  4.35
       90 id-90   1.13 Ideal I1       3678  6.65  6.69
       91 id-91   1.73 Good  I1       8370  7.6   7.56
       92 id-92   1.51 Good  VVS2    14654  7.18  7.24
       93 id-93   1.09 Ideal SI1      5376  6.6   6.64
       94 id-94   0.28 Ideal VS1       462  4.19  4.23
       95 id-95   0.37 Fair  IF       1440  4.68  4.73
       96 id-96   0.32 Ideal VVS2      854  4.45  4.46
       97 id-97   2.61 Good  SI2     13784  8.66  8.57
       98 id-98   1    Fair  VVS2     4312  6.27  6.23
       99 id-99   2    Fair  SI2     15351  7.63  7.59
      100 id-100  1.2  Good  SI2      6344  6.72  6.68

# move_row, beofre last row

    Code
      move_row(mini_diamond, 3:5, .before = nrow(mini_diamond)) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-1    1.02 Fair  SI1      3027  6.25  6.18
        2 id-2    1.51 Good  VS2     11746  7.27  7.18
        3 id-6    2.02 Fair  SI2     14080  8.33  8.37
        4 id-7    0.27 Good  VVS1      752  4.1   4.07
        5 id-8    0.51 Good  SI2      1029  5.05  5.08
        6 id-9    1.01 Ideal SI1      5590  6.43  6.4 
        7 id-10   0.7  Fair  VVS1     1691  5.56  5.41
        8 id-11   1.02 Good  VVS1     7861  6.37  6.4 
        9 id-12   0.71 Fair  IF       3205  5.87  5.81
       10 id-13   0.56 Ideal SI1      1633  5.31  5.32
       11 id-14   0.3  Ideal VVS2      812  4.33  4.39
       12 id-15   0.28 Good  IF        612  4.09  4.12
       13 id-16   0.41 Good  I1        467  4.7   4.74
       14 id-17   0.97 Ideal I1       2239  6.4   6.43
       15 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       16 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       17 id-20   1.2  Fair  I1       3011  6.61  6.54
       18 id-21   0.4  Good  VVS1     1080  4.71  4.73
       19 id-22   0.9  Good  VS2      3246  6.16  6.07
       20 id-23   0.7  Fair  I1       1158  5.64  5.5 
       21 id-24   0.92 Good  VS2      4247  6.11  6.17
       22 id-25   2.1  Fair  SI2     15827  7.97  7.92
       23 id-26   0.31 Ideal VS1       717  4.36  4.41
       24 id-27   1.13 Good  SI2      4998  6.93  6.88
       25 id-28   2.02 Fair  I1       6346  7.87  7.8 
       26 id-29   0.72 Ideal SI2      2300  5.72  5.78
       27 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       28 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       29 id-32   2    Fair  I1       5667  7.78  7.74
       30 id-33   1.21 Good  SI1      5252  6.63  6.71
       31 id-34   1.14 Good  I1       2327  6.63  6.55
       32 id-35   1    Ideal VVS1     6535  6.37  6.41
       33 id-36   1    Fair  VS1      6115  6.26  6.21
       34 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       35 id-38   1.09 Ideal VS2      5421  6.62  6.67
       36 id-39   0.3  Ideal IF        863  4.33  4.36
       37 id-40   1.52 Fair  SI2      7388  7.23  7.19
       38 id-41   0.98 Ideal SI2      3873  6.35  6.39
       39 id-42   0.32 Good  SI1       589  4.33  4.35
       40 id-43   1.12 Fair  VS1      5487  6.48  6.52
       41 id-44   0.7  Good  VS2      3087  5.49  5.56
       42 id-45   0.47 Fair  IF       2211  5.09  4.98
       43 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       44 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       45 id-48   2.01 Fair  I1       7294  8.3   8.19
       46 id-49   2.16 Ideal I1       8709  8.31  8.26
       47 id-50   1    Good  SI1      4851  6.27  6.31
       48 id-51   1    Good  VVS2     6748  6.32  6.3 
       49 id-52   0.72 Fair  VS2      2306  5.66  5.71
       50 id-53   0.33 Good  IF       1052  4.57  4.55
       51 id-54   0.4  Ideal VVS2      931  4.72  4.75
       52 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       53 id-56   0.4  Good  IF       1120  4.75  4.8 
       54 id-57   0.3  Ideal IF        863  4.32  4.34
       55 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       56 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       57 id-60   0.29 Ideal VVS2      607  4.27  4.29
       58 id-61   0.3  Good  IF        631  4.23  4.3 
       59 id-62   0.46 Good  IF       1806  5.12  5.18
       60 id-63   1.35 Fair  VS2      5625  6.98  6.93
       61 id-64   1.01 Fair  SI1      4480  6.34  6.29
       62 id-65   0.63 Fair  SI1      1952  5.36  5.41
       63 id-66   0.9  Fair  VS2      2815  6.08  6.04
       64 id-67   0.58 Ideal SI2      1442  5.4   5.36
       65 id-68   2.32 Fair  SI1     18026  8.47  8.31
       66 id-69   0.4  Good  I1        491  4.64  4.68
       67 id-70   0.9  Fair  VS2      4277  6.26  6.29
       68 id-71   0.97 Ideal I1       2370  6.34  6.28
       69 id-72   0.42 Good  VVS2     1042  4.72  4.78
       70 id-73   0.4  Ideal IF       1229  4.73  4.76
       71 id-74   0.45 Good  VVS1     1548  4.85  4.78
       72 id-75   0.71 Good  SI1      2215  5.62  5.59
       73 id-76   0.64 Fair  SI1      1733  5.65  5.39
       74 id-77   0.71 Fair  VS2      2623  5.83  5.81
       75 id-78   0.7  Ideal VS1      3535  5.69  5.72
       76 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       77 id-80   0.8  Ideal VS1      4070  5.91  5.96
       78 id-81   0.41 Good  VS1       954  4.77  4.79
       79 id-82   0.9  Good  I1       2143  6.09  6.05
       80 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       81 id-84   0.5  Ideal SI1      1415  5.11  5.05
       82 id-85   1    Fair  VS1      7083  6.77  6.71
       83 id-86   0.31 Ideal IF        891  4.38  4.4 
       84 id-87   0.34 Good  VS1       596  4.4   4.44
       85 id-88   0.31 Ideal VS2       628  4.38  4.34
       86 id-89   0.3  Fair  IF       1208  4.47  4.35
       87 id-90   1.13 Ideal I1       3678  6.65  6.69
       88 id-91   1.73 Good  I1       8370  7.6   7.56
       89 id-92   1.51 Good  VVS2    14654  7.18  7.24
       90 id-93   1.09 Ideal SI1      5376  6.6   6.64
       91 id-94   0.28 Ideal VS1       462  4.19  4.23
       92 id-95   0.37 Fair  IF       1440  4.68  4.73
       93 id-96   0.32 Ideal VVS2      854  4.45  4.46
       94 id-97   2.61 Good  SI2     13784  8.66  8.57
       95 id-98   1    Fair  VVS2     4312  6.27  6.23
       96 id-99   2    Fair  SI2     15351  7.63  7.59
       97 id-3    0.52 Ideal VVS1     2029  5.15  5.18
       98 id-4    1.54 Ideal SI2      9452  7.43  7.45
       99 id-5    0.72 Ideal VS1      2498  5.73  5.77
      100 id-100  1.2  Good  SI2      6344  6.72  6.68

# move_row

    Code
      move_row(mini_diamond, 3:5, .after = 8) %>% print(n = Inf)
    Output
      # A tibble: 100 x 7
          id     carat cut   clarity price     x     y
          <chr>  <dbl> <chr> <chr>   <int> <dbl> <dbl>
        1 id-1    1.02 Fair  SI1      3027  6.25  6.18
        2 id-2    1.51 Good  VS2     11746  7.27  7.18
        3 id-6    2.02 Fair  SI2     14080  8.33  8.37
        4 id-7    0.27 Good  VVS1      752  4.1   4.07
        5 id-8    0.51 Good  SI2      1029  5.05  5.08
        6 id-3    0.52 Ideal VVS1     2029  5.15  5.18
        7 id-4    1.54 Ideal SI2      9452  7.43  7.45
        8 id-5    0.72 Ideal VS1      2498  5.73  5.77
        9 id-9    1.01 Ideal SI1      5590  6.43  6.4 
       10 id-10   0.7  Fair  VVS1     1691  5.56  5.41
       11 id-11   1.02 Good  VVS1     7861  6.37  6.4 
       12 id-12   0.71 Fair  IF       3205  5.87  5.81
       13 id-13   0.56 Ideal SI1      1633  5.31  5.32
       14 id-14   0.3  Ideal VVS2      812  4.33  4.39
       15 id-15   0.28 Good  IF        612  4.09  4.12
       16 id-16   0.41 Good  I1        467  4.7   4.74
       17 id-17   0.97 Ideal I1       2239  6.4   6.43
       18 id-18   0.34 Fair  VVS1     1012  4.8   4.76
       19 id-19   0.59 Ideal VVS2     2155  5.34  5.39
       20 id-20   1.2  Fair  I1       3011  6.61  6.54
       21 id-21   0.4  Good  VVS1     1080  4.71  4.73
       22 id-22   0.9  Good  VS2      3246  6.16  6.07
       23 id-23   0.7  Fair  I1       1158  5.64  5.5 
       24 id-24   0.92 Good  VS2      4247  6.11  6.17
       25 id-25   2.1  Fair  SI2     15827  7.97  7.92
       26 id-26   0.31 Ideal VS1       717  4.36  4.41
       27 id-27   1.13 Good  SI2      4998  6.93  6.88
       28 id-28   2.02 Fair  I1       6346  7.87  7.8 
       29 id-29   0.72 Ideal SI2      2300  5.72  5.78
       30 id-30   0.52 Fair  VVS2     1401  5.26  5.2 
       31 id-31   1.03 Ideal VVS1     8398  6.54  6.5 
       32 id-32   2    Fair  I1       5667  7.78  7.74
       33 id-33   1.21 Good  SI1      5252  6.63  6.71
       34 id-34   1.14 Good  I1       2327  6.63  6.55
       35 id-35   1    Ideal VVS1     6535  6.37  6.41
       36 id-36   1    Fair  VS1      6115  6.26  6.21
       37 id-37   0.51 Ideal VVS1     2812  5.15  5.11
       38 id-38   1.09 Ideal VS2      5421  6.62  6.67
       39 id-39   0.3  Ideal IF        863  4.33  4.36
       40 id-40   1.52 Fair  SI2      7388  7.23  7.19
       41 id-41   0.98 Ideal SI2      3873  6.35  6.39
       42 id-42   0.32 Good  SI1       589  4.33  4.35
       43 id-43   1.12 Fair  VS1      5487  6.48  6.52
       44 id-44   0.7  Good  VS2      3087  5.49  5.56
       45 id-45   0.47 Fair  IF       2211  5.09  4.98
       46 id-46   0.34 Fair  VVS1     1040  4.72  4.77
       47 id-47   1.1  Ideal SI1      5370  6.66  6.7 
       48 id-48   2.01 Fair  I1       7294  8.3   8.19
       49 id-49   2.16 Ideal I1       8709  8.31  8.26
       50 id-50   1    Good  SI1      4851  6.27  6.31
       51 id-51   1    Good  VVS2     6748  6.32  6.3 
       52 id-52   0.72 Fair  VS2      2306  5.66  5.71
       53 id-53   0.33 Good  IF       1052  4.57  4.55
       54 id-54   0.4  Ideal VVS2      931  4.72  4.75
       55 id-55   0.71 Fair  VVS1     3062  5.67  5.57
       56 id-56   0.4  Good  IF       1120  4.75  4.8 
       57 id-57   0.3  Ideal IF        863  4.32  4.34
       58 id-58   0.9  Fair  VVS2     3288  6.1   6.12
       59 id-59   0.91 Fair  VVS1     4115  6.38  6.4 
       60 id-60   0.29 Ideal VVS2      607  4.27  4.29
       61 id-61   0.3  Good  IF        631  4.23  4.3 
       62 id-62   0.46 Good  IF       1806  5.12  5.18
       63 id-63   1.35 Fair  VS2      5625  6.98  6.93
       64 id-64   1.01 Fair  SI1      4480  6.34  6.29
       65 id-65   0.63 Fair  SI1      1952  5.36  5.41
       66 id-66   0.9  Fair  VS2      2815  6.08  6.04
       67 id-67   0.58 Ideal SI2      1442  5.4   5.36
       68 id-68   2.32 Fair  SI1     18026  8.47  8.31
       69 id-69   0.4  Good  I1        491  4.64  4.68
       70 id-70   0.9  Fair  VS2      4277  6.26  6.29
       71 id-71   0.97 Ideal I1       2370  6.34  6.28
       72 id-72   0.42 Good  VVS2     1042  4.72  4.78
       73 id-73   0.4  Ideal IF       1229  4.73  4.76
       74 id-74   0.45 Good  VVS1     1548  4.85  4.78
       75 id-75   0.71 Good  SI1      2215  5.62  5.59
       76 id-76   0.64 Fair  SI1      1733  5.65  5.39
       77 id-77   0.71 Fair  VS2      2623  5.83  5.81
       78 id-78   0.7  Ideal VS1      3535  5.69  5.72
       79 id-79   1.08 Fair  VVS2     5171  6.9   6.8 
       80 id-80   0.8  Ideal VS1      4070  5.91  5.96
       81 id-81   0.41 Good  VS1       954  4.77  4.79
       82 id-82   0.9  Good  I1       2143  6.09  6.05
       83 id-83   0.73 Ideal VVS1     3487  5.77  5.82
       84 id-84   0.5  Ideal SI1      1415  5.11  5.05
       85 id-85   1    Fair  VS1      7083  6.77  6.71
       86 id-86   0.31 Ideal IF        891  4.38  4.4 
       87 id-87   0.34 Good  VS1       596  4.4   4.44
       88 id-88   0.31 Ideal VS2       628  4.38  4.34
       89 id-89   0.3  Fair  IF       1208  4.47  4.35
       90 id-90   1.13 Ideal I1       3678  6.65  6.69
       91 id-91   1.73 Good  I1       8370  7.6   7.56
       92 id-92   1.51 Good  VVS2    14654  7.18  7.24
       93 id-93   1.09 Ideal SI1      5376  6.6   6.64
       94 id-94   0.28 Ideal VS1       462  4.19  4.23
       95 id-95   0.37 Fair  IF       1440  4.68  4.73
       96 id-96   0.32 Ideal VVS2      854  4.45  4.46
       97 id-97   2.61 Good  SI2     13784  8.66  8.57
       98 id-98   1    Fair  VVS2     4312  6.27  6.23
       99 id-99   2    Fair  SI2     15351  7.63  7.59
      100 id-100  1.2  Good  SI2      6344  6.72  6.68

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
    Condition
      Warning in `ordered_slice()`:
      2 NA values!
      Warning in `ordered_slice()`:
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
    Condition
      Warning in `ordered_slice()`:
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
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
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
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
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
    Condition
      Warning in `ordered_slice()`:
      3 NA values!
      Warning in `ordered_slice()`:
      3 duplicated values!
    Output
      # A tibble: 2 x 7
        id    carat cut   clarity price     x     y
        <chr> <dbl> <chr> <chr>   <int> <dbl> <dbl>
      1 id-3   0.52 Ideal VVS1     2029  5.15  5.18
      2 id-2   1.51 Good  VS2     11746  7.27  7.18

# hist_bins

    Code
      hist_bins(vector) %>% print(n = Inf)
    Output
      # A tibble: 100 x 5
          id     value  start    end   bin
          <chr>  <int>  <dbl>  <dbl> <int>
        1 id-1    3027  2218.  3975.     2
        2 id-2   11746 11000. 12757.     7
        3 id-3    2029   462   2218.     1
        4 id-4    9452  9244  11000.     6
        5 id-5    2498  2218.  3975.     2
        6 id-6   14080 12757. 14513.     8
        7 id-7     752   462   2218.     1
        8 id-8    1029   462   2218.     1
        9 id-9    5590  3975.  5731.     3
       10 id-10   1691   462   2218.     1
       11 id-11   7861  7488.  9244      5
       12 id-12   3205  2218.  3975.     2
       13 id-13   1633   462   2218.     1
       14 id-14    812   462   2218.     1
       15 id-15    612   462   2218.     1
       16 id-16    467   462   2218.     1
       17 id-17   2239  2218.  3975.     2
       18 id-18   1012   462   2218.     1
       19 id-19   2155   462   2218.     1
       20 id-20   3011  2218.  3975.     2
       21 id-21   1080   462   2218.     1
       22 id-22   3246  2218.  3975.     2
       23 id-23   1158   462   2218.     1
       24 id-24   4247  3975.  5731.     3
       25 id-25  15827 14513. 16270.     9
       26 id-26    717   462   2218.     1
       27 id-27   4998  3975.  5731.     3
       28 id-28   6346  5731.  7488.     4
       29 id-29   2300  2218.  3975.     2
       30 id-30   1401   462   2218.     1
       31 id-31   8398  7488.  9244      5
       32 id-32   5667  3975.  5731.     3
       33 id-33   5252  3975.  5731.     3
       34 id-34   2327  2218.  3975.     2
       35 id-35   6535  5731.  7488.     4
       36 id-36   6115  5731.  7488.     4
       37 id-37   2812  2218.  3975.     2
       38 id-38   5421  3975.  5731.     3
       39 id-39    863   462   2218.     1
       40 id-40   7388  5731.  7488.     4
       41 id-41   3873  2218.  3975.     2
       42 id-42    589   462   2218.     1
       43 id-43   5487  3975.  5731.     3
       44 id-44   3087  2218.  3975.     2
       45 id-45   2211   462   2218.     1
       46 id-46   1040   462   2218.     1
       47 id-47   5370  3975.  5731.     3
       48 id-48   7294  5731.  7488.     4
       49 id-49   8709  7488.  9244      5
       50 id-50   4851  3975.  5731.     3
       51 id-51   6748  5731.  7488.     4
       52 id-52   2306  2218.  3975.     2
       53 id-53   1052   462   2218.     1
       54 id-54    931   462   2218.     1
       55 id-55   3062  2218.  3975.     2
       56 id-56   1120   462   2218.     1
       57 id-57    863   462   2218.     1
       58 id-58   3288  2218.  3975.     2
       59 id-59   4115  3975.  5731.     3
       60 id-60    607   462   2218.     1
       61 id-61    631   462   2218.     1
       62 id-62   1806   462   2218.     1
       63 id-63   5625  3975.  5731.     3
       64 id-64   4480  3975.  5731.     3
       65 id-65   1952   462   2218.     1
       66 id-66   2815  2218.  3975.     2
       67 id-67   1442   462   2218.     1
       68 id-68  18026 16270. 18026     10
       69 id-69    491   462   2218.     1
       70 id-70   4277  3975.  5731.     3
       71 id-71   2370  2218.  3975.     2
       72 id-72   1042   462   2218.     1
       73 id-73   1229   462   2218.     1
       74 id-74   1548   462   2218.     1
       75 id-75   2215   462   2218.     1
       76 id-76   1733   462   2218.     1
       77 id-77   2623  2218.  3975.     2
       78 id-78   3535  2218.  3975.     2
       79 id-79   5171  3975.  5731.     3
       80 id-80   4070  3975.  5731.     3
       81 id-81    954   462   2218.     1
       82 id-82   2143   462   2218.     1
       83 id-83   3487  2218.  3975.     2
       84 id-84   1415   462   2218.     1
       85 id-85   7083  5731.  7488.     4
       86 id-86    891   462   2218.     1
       87 id-87    596   462   2218.     1
       88 id-88    628   462   2218.     1
       89 id-89   1208   462   2218.     1
       90 id-90   3678  2218.  3975.     2
       91 id-91   8370  7488.  9244      5
       92 id-92  14654 14513. 16270.     9
       93 id-93   5376  3975.  5731.     3
       94 id-94    462   462   2218.     1
       95 id-95   1440   462   2218.     1
       96 id-96    854   462   2218.     1
       97 id-97  13784 12757. 14513.     8
       98 id-98   4312  3975.  5731.     3
       99 id-99  15351 14513. 16270.     9
      100 id-100  6344  5731.  7488.     4

# hist_bins, lim

    Code
      hist_bins(vector, lim = c(0, 20000)) %>% print(n = Inf)
    Output
      # A tibble: 100 x 5
          id     value start   end   bin
          <chr>  <int> <dbl> <dbl> <int>
        1 id-1    3027  2000  4000     2
        2 id-2   11746 10000 12000     6
        3 id-3    2029  2000  4000     2
        4 id-4    9452  8000 10000     5
        5 id-5    2498  2000  4000     2
        6 id-6   14080 14000 16000     8
        7 id-7     752     0  2000     1
        8 id-8    1029     0  2000     1
        9 id-9    5590  4000  6000     3
       10 id-10   1691     0  2000     1
       11 id-11   7861  6000  8000     4
       12 id-12   3205  2000  4000     2
       13 id-13   1633     0  2000     1
       14 id-14    812     0  2000     1
       15 id-15    612     0  2000     1
       16 id-16    467     0  2000     1
       17 id-17   2239  2000  4000     2
       18 id-18   1012     0  2000     1
       19 id-19   2155  2000  4000     2
       20 id-20   3011  2000  4000     2
       21 id-21   1080     0  2000     1
       22 id-22   3246  2000  4000     2
       23 id-23   1158     0  2000     1
       24 id-24   4247  4000  6000     3
       25 id-25  15827 14000 16000     8
       26 id-26    717     0  2000     1
       27 id-27   4998  4000  6000     3
       28 id-28   6346  6000  8000     4
       29 id-29   2300  2000  4000     2
       30 id-30   1401     0  2000     1
       31 id-31   8398  8000 10000     5
       32 id-32   5667  4000  6000     3
       33 id-33   5252  4000  6000     3
       34 id-34   2327  2000  4000     2
       35 id-35   6535  6000  8000     4
       36 id-36   6115  6000  8000     4
       37 id-37   2812  2000  4000     2
       38 id-38   5421  4000  6000     3
       39 id-39    863     0  2000     1
       40 id-40   7388  6000  8000     4
       41 id-41   3873  2000  4000     2
       42 id-42    589     0  2000     1
       43 id-43   5487  4000  6000     3
       44 id-44   3087  2000  4000     2
       45 id-45   2211  2000  4000     2
       46 id-46   1040     0  2000     1
       47 id-47   5370  4000  6000     3
       48 id-48   7294  6000  8000     4
       49 id-49   8709  8000 10000     5
       50 id-50   4851  4000  6000     3
       51 id-51   6748  6000  8000     4
       52 id-52   2306  2000  4000     2
       53 id-53   1052     0  2000     1
       54 id-54    931     0  2000     1
       55 id-55   3062  2000  4000     2
       56 id-56   1120     0  2000     1
       57 id-57    863     0  2000     1
       58 id-58   3288  2000  4000     2
       59 id-59   4115  4000  6000     3
       60 id-60    607     0  2000     1
       61 id-61    631     0  2000     1
       62 id-62   1806     0  2000     1
       63 id-63   5625  4000  6000     3
       64 id-64   4480  4000  6000     3
       65 id-65   1952     0  2000     1
       66 id-66   2815  2000  4000     2
       67 id-67   1442     0  2000     1
       68 id-68  18026 18000 20000    10
       69 id-69    491     0  2000     1
       70 id-70   4277  4000  6000     3
       71 id-71   2370  2000  4000     2
       72 id-72   1042     0  2000     1
       73 id-73   1229     0  2000     1
       74 id-74   1548     0  2000     1
       75 id-75   2215  2000  4000     2
       76 id-76   1733     0  2000     1
       77 id-77   2623  2000  4000     2
       78 id-78   3535  2000  4000     2
       79 id-79   5171  4000  6000     3
       80 id-80   4070  4000  6000     3
       81 id-81    954     0  2000     1
       82 id-82   2143  2000  4000     2
       83 id-83   3487  2000  4000     2
       84 id-84   1415     0  2000     1
       85 id-85   7083  6000  8000     4
       86 id-86    891     0  2000     1
       87 id-87    596     0  2000     1
       88 id-88    628     0  2000     1
       89 id-89   1208     0  2000     1
       90 id-90   3678  2000  4000     2
       91 id-91   8370  8000 10000     5
       92 id-92  14654 14000 16000     8
       93 id-93   5376  4000  6000     3
       94 id-94    462     0  2000     1
       95 id-95   1440     0  2000     1
       96 id-96    854     0  2000     1
       97 id-97  13784 12000 14000     7
       98 id-98   4312  4000  6000     3
       99 id-99  15351 14000 16000     8
      100 id-100  6344  6000  8000     4

# hist_bins, breaks

    Code
      hist_bins(vector, breaks = seq(0, 20000, length.out = 11)) %>% print(n = Inf)
    Output
      # A tibble: 100 x 5
          id     value start   end   bin
          <chr>  <int> <dbl> <dbl> <int>
        1 id-1    3027  2000  4000     2
        2 id-2   11746 10000 12000     6
        3 id-3    2029  2000  4000     2
        4 id-4    9452  8000 10000     5
        5 id-5    2498  2000  4000     2
        6 id-6   14080 14000 16000     8
        7 id-7     752     0  2000     1
        8 id-8    1029     0  2000     1
        9 id-9    5590  4000  6000     3
       10 id-10   1691     0  2000     1
       11 id-11   7861  6000  8000     4
       12 id-12   3205  2000  4000     2
       13 id-13   1633     0  2000     1
       14 id-14    812     0  2000     1
       15 id-15    612     0  2000     1
       16 id-16    467     0  2000     1
       17 id-17   2239  2000  4000     2
       18 id-18   1012     0  2000     1
       19 id-19   2155  2000  4000     2
       20 id-20   3011  2000  4000     2
       21 id-21   1080     0  2000     1
       22 id-22   3246  2000  4000     2
       23 id-23   1158     0  2000     1
       24 id-24   4247  4000  6000     3
       25 id-25  15827 14000 16000     8
       26 id-26    717     0  2000     1
       27 id-27   4998  4000  6000     3
       28 id-28   6346  6000  8000     4
       29 id-29   2300  2000  4000     2
       30 id-30   1401     0  2000     1
       31 id-31   8398  8000 10000     5
       32 id-32   5667  4000  6000     3
       33 id-33   5252  4000  6000     3
       34 id-34   2327  2000  4000     2
       35 id-35   6535  6000  8000     4
       36 id-36   6115  6000  8000     4
       37 id-37   2812  2000  4000     2
       38 id-38   5421  4000  6000     3
       39 id-39    863     0  2000     1
       40 id-40   7388  6000  8000     4
       41 id-41   3873  2000  4000     2
       42 id-42    589     0  2000     1
       43 id-43   5487  4000  6000     3
       44 id-44   3087  2000  4000     2
       45 id-45   2211  2000  4000     2
       46 id-46   1040     0  2000     1
       47 id-47   5370  4000  6000     3
       48 id-48   7294  6000  8000     4
       49 id-49   8709  8000 10000     5
       50 id-50   4851  4000  6000     3
       51 id-51   6748  6000  8000     4
       52 id-52   2306  2000  4000     2
       53 id-53   1052     0  2000     1
       54 id-54    931     0  2000     1
       55 id-55   3062  2000  4000     2
       56 id-56   1120     0  2000     1
       57 id-57    863     0  2000     1
       58 id-58   3288  2000  4000     2
       59 id-59   4115  4000  6000     3
       60 id-60    607     0  2000     1
       61 id-61    631     0  2000     1
       62 id-62   1806     0  2000     1
       63 id-63   5625  4000  6000     3
       64 id-64   4480  4000  6000     3
       65 id-65   1952     0  2000     1
       66 id-66   2815  2000  4000     2
       67 id-67   1442     0  2000     1
       68 id-68  18026 18000 20000    10
       69 id-69    491     0  2000     1
       70 id-70   4277  4000  6000     3
       71 id-71   2370  2000  4000     2
       72 id-72   1042     0  2000     1
       73 id-73   1229     0  2000     1
       74 id-74   1548     0  2000     1
       75 id-75   2215  2000  4000     2
       76 id-76   1733     0  2000     1
       77 id-77   2623  2000  4000     2
       78 id-78   3535  2000  4000     2
       79 id-79   5171  4000  6000     3
       80 id-80   4070  4000  6000     3
       81 id-81    954     0  2000     1
       82 id-82   2143  2000  4000     2
       83 id-83   3487  2000  4000     2
       84 id-84   1415     0  2000     1
       85 id-85   7083  6000  8000     4
       86 id-86    891     0  2000     1
       87 id-87    596     0  2000     1
       88 id-88    628     0  2000     1
       89 id-89   1208     0  2000     1
       90 id-90   3678  2000  4000     2
       91 id-91   8370  8000 10000     5
       92 id-92  14654 14000 16000     8
       93 id-93   5376  4000  6000     3
       94 id-94    462     0  2000     1
       95 id-95   1440     0  2000     1
       96 id-96    854     0  2000     1
       97 id-97  13784 12000 14000     7
       98 id-98   4312  4000  6000     3
       99 id-99  15351 14000 16000     8
      100 id-100  6344  6000  8000     4

# as_tibble_md

    Code
      as_tibble_md(x)
    Output
      # A tibble: 2 x 3
        col1  col2  col3 
        <chr> <chr> <chr>
      1 v1    v2    v3   
      2 r1    r2    r3   

# as_md_table

    Code
      mini_diamond %>% head(5) %>% as_md_table()
    Output
      | id | carat | cut | clarity | price | x | y |
      | - | - | - | - | - | - | - |
      | id-1 | 1.02 | Fair | SI1 |  3027 | 6.25 | 6.18 |
      | id-2 | 1.51 | Good | VS2 | 11746 | 7.27 | 7.18 |
      | id-3 | 0.52 | Ideal | VVS1 |  2029 | 5.15 | 5.18 |
      | id-4 | 1.54 | Ideal | SI2 |  9452 | 7.43 | 7.45 |
      | id-5 | 0.72 | Ideal | VS1 |  2498 | 5.73 | 5.77 |

# cross_count

    Code
      cross_count(mini_diamond, cut, clarity)
    Output
            I1 IF SI1 SI2 VS1 VS2 VVS1 VVS2
      Fair   5  4   5   4   3   5    5    4
      Good   5  5   4   4   2   4    4    3
      Ideal  4  4   5   4   5   2    5    5

# cross_count, method='rowr'

    Code
      cross_count(mini_diamond, cut, clarity, method = "rowr")
    Output
              I1   IF  SI1  SI2  VS1  VS2 VVS1 VVS2
      Fair  0.14 0.11 0.14 0.11 0.09 0.14 0.14 0.11
      Good  0.16 0.16 0.13 0.13 0.06 0.13 0.13 0.10
      Ideal 0.12 0.12 0.15 0.12 0.15 0.06 0.15 0.15

# cross_count, method='colr'

    Code
      cross_count(mini_diamond, cut, clarity, method = "colr")
    Output
              I1   IF  SI1  SI2 VS1  VS2 VVS1 VVS2
      Fair  0.36 0.31 0.36 0.33 0.3 0.45 0.36 0.33
      Good  0.36 0.38 0.29 0.33 0.2 0.36 0.29 0.25
      Ideal 0.29 0.31 0.36 0.33 0.5 0.18 0.36 0.42

# list2tibble, method='row'

    Code
      list2tibble(x, colnames = c("char", "num"))
    Output
      # A tibble: 3 x 2
        char  num  
        <chr> <chr>
      1 a     1    
      2 b     2    
      3 c     3    

# list2tibble, method='col'

    Code
      list2tibble(x, method = "col")
    Output
      # A tibble: 3 x 2
        V1    V2   
        <chr> <chr>
      1 a     1    
      2 b     2    
      3 c     3    

# exist_matrix

    Code
      exist_matrix(x)
    Output
      # A tibble: 5 x 11
        g     i     k     a     b     c     d     e     f     h     j    
      * <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl>
      1 TRUE  TRUE  FALSE TRUE  TRUE  FALSE TRUE  FALSE FALSE FALSE FALSE
      2 FALSE FALSE FALSE TRUE  FALSE FALSE FALSE TRUE  TRUE  TRUE  FALSE
      3 TRUE  FALSE FALSE FALSE FALSE FALSE TRUE  TRUE  FALSE FALSE TRUE 
      4 TRUE  FALSE TRUE  FALSE FALSE TRUE  FALSE FALSE FALSE TRUE  FALSE
      5 FALSE TRUE  TRUE  FALSE TRUE  FALSE FALSE FALSE FALSE FALSE FALSE

# exist_matrix, sort_items

    Code
      exist_matrix(x, sort_items = ~ str_sub(.x, start = 2))
    Output
      # A tibble: 5 x 12
        bP    cQ    dR    aS    bT    cT    cU    dV    aW    bX    cY    dZ   
      * <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl> <lgl>
      1 FALSE FALSE TRUE  FALSE FALSE FALSE TRUE  FALSE TRUE  FALSE FALSE FALSE
      2 FALSE FALSE FALSE TRUE  TRUE  TRUE  FALSE FALSE FALSE FALSE FALSE FALSE
      3 FALSE FALSE FALSE TRUE  FALSE FALSE FALSE FALSE FALSE TRUE  FALSE TRUE 
      4 FALSE TRUE  FALSE FALSE FALSE FALSE FALSE TRUE  FALSE FALSE TRUE  FALSE
      5 TRUE  FALSE FALSE FALSE FALSE FALSE FALSE FALSE TRUE  FALSE TRUE  FALSE

# seriate_df

    Code
      seriate_df(x)
    Output
              carat  price      x      y
      id-7   0.1034 0.0417 0.4734 0.4749
      id-15  0.1073 0.0340 0.4723 0.4807
      id-94  0.1073 0.0256 0.4838 0.4936
      id-60  0.1111 0.0337 0.4931 0.5006
      id-61  0.1149 0.0350 0.4885 0.5018
      id-42  0.1226 0.0327 0.5000 0.5076
      id-88  0.1188 0.0348 0.5058 0.5064
      id-87  0.1303 0.0331 0.5081 0.5181
      id-26  0.1188 0.0398 0.5035 0.5146
      id-86  0.1188 0.0494 0.5058 0.5134
      id-14  0.1149 0.0450 0.5000 0.5123
      id-39  0.1149 0.0479 0.5000 0.5088
      id-57  0.1149 0.0479 0.4988 0.5064
      id-89  0.1149 0.0670 0.5162 0.5076
      id-96  0.1226 0.0474 0.5139 0.5204
      id-53  0.1264 0.0584 0.5277 0.5309
      id-69  0.1533 0.0272 0.5358 0.5461
      id-16  0.1571 0.0259 0.5427 0.5531
      id-54  0.1533 0.0516 0.5450 0.5543
      id-81  0.1571 0.0529 0.5508 0.5589
      id-72  0.1609 0.0578 0.5450 0.5578
      id-21  0.1533 0.0599 0.5439 0.5519
      id-73  0.1533 0.0682 0.5462 0.5554
      id-56  0.1533 0.0621 0.5485 0.5601
      id-18  0.1303 0.0561 0.5543 0.5554
      id-46  0.1303 0.0577 0.5450 0.5566
      id-95  0.1418 0.0799 0.5404 0.5519
      id-74  0.1724 0.0859 0.5600 0.5578
      id-37  0.1954 0.1560 0.5947 0.5963
      id-45  0.1801 0.1227 0.5878 0.5811
      id-3   0.1992 0.1126 0.5947 0.6044
      id-62  0.1762 0.1002 0.5912 0.6044
      id-84  0.1916 0.0785 0.5901 0.5893
      id-8   0.1954 0.0571 0.5831 0.5928
      id-30  0.1992 0.0777 0.6074 0.6068
      id-13  0.2146 0.0906 0.6132 0.6208
      id-67  0.2222 0.0800 0.6236 0.6254
      id-19  0.2261 0.1195 0.6166 0.6289
      id-65  0.2414 0.1083 0.6189 0.6313
      id-76  0.2452 0.0961 0.6524 0.6289
      id-10  0.2682 0.0938 0.6420 0.6313
      id-23  0.2682 0.0642 0.6513 0.6418
      id-75  0.2720 0.1229 0.6490 0.6523
      id-52  0.2759 0.1279 0.6536 0.6663
      id-29  0.2759 0.1276 0.6605 0.6744
      id-5   0.2759 0.1386 0.6617 0.6733
      id-77  0.2720 0.1455 0.6732 0.6779
      id-55  0.2720 0.1699 0.6547 0.6499
      id-44  0.2682 0.1713 0.6339 0.6488
      id-78  0.2682 0.1961 0.6570 0.6674
      id-83  0.2797 0.1934 0.6663 0.6791
      id-12  0.2720 0.1778 0.6778 0.6779
      id-80  0.3065 0.2258 0.6824 0.6954
      id-24  0.3525 0.2356 0.7055 0.7200
      id-70  0.3448 0.2373 0.7229 0.7340
      id-59  0.3487 0.2283 0.7367 0.7468
      id-41  0.3755 0.2149 0.7333 0.7456
      id-50  0.3831 0.2691 0.7240 0.7363
      id-64  0.3870 0.2485 0.7321 0.7340
      id-98  0.3831 0.2392 0.7240 0.7270
      id-1   0.3908 0.1679 0.7217 0.7211
      id-58  0.3448 0.1824 0.7044 0.7141
      id-22  0.3448 0.1801 0.7113 0.7083
      id-66  0.3448 0.1562 0.7021 0.7048
      id-82  0.3448 0.1189 0.7032 0.7060
      id-71  0.3716 0.1315 0.7321 0.7328
      id-17  0.3716 0.1242 0.7390 0.7503
      id-34  0.4368 0.1291 0.7656 0.7643
      id-20  0.4598 0.1670 0.7633 0.7631
      id-90  0.4330 0.2040 0.7679 0.7806
      id-9   0.3870 0.3101 0.7425 0.7468
      id-36  0.3831 0.3392 0.7229 0.7246
      id-35  0.3831 0.3625 0.7356 0.7480
      id-51  0.3831 0.3743 0.7298 0.7351
      id-11  0.3908 0.4361 0.7356 0.7468
      id-31  0.3946 0.4659 0.7552 0.7585
      id-85  0.3831 0.3929 0.7818 0.7830
      id-100 0.4598 0.3519 0.7760 0.7795
      id-33  0.4636 0.2914 0.7656 0.7830
      id-43  0.4291 0.3044 0.7483 0.7608
      id-93  0.4176 0.2982 0.7621 0.7748
      id-38  0.4176 0.3007 0.7644 0.7783
      id-47  0.4215 0.2979 0.7691 0.7818
      id-79  0.4138 0.2869 0.7968 0.7935
      id-27  0.4330 0.2773 0.8002 0.8028
      id-63  0.5172 0.3120 0.8060 0.8086
      id-40  0.5824 0.4099 0.8349 0.8390
      id-4   0.5900 0.5244 0.8580 0.8693
      id-91  0.6628 0.4643 0.8776 0.8821
      id-32  0.7663 0.3144 0.8984 0.9032
      id-28  0.7739 0.3520 0.9088 0.9102
      id-48  0.7701 0.4046 0.9584 0.9557
      id-49  0.8276 0.4831 0.9596 0.9638
      id-97  1.0000 0.7647 1.0000 1.0000
      id-68  0.8889 1.0000 0.9781 0.9697
      id-6   0.7739 0.7811 0.9619 0.9767
      id-25  0.8046 0.8780 0.9203 0.9242
      id-99  0.7663 0.8516 0.8811 0.8856
      id-92  0.5785 0.8129 0.8291 0.8448
      id-2   0.5785 0.6516 0.8395 0.8378

# dx_tb

    Code
      dx_tb(x)
    Output
      $chr_na
      # A tibble: 1 x 2
          row   col
        <int> <int>
      1     1     1
      
      $chr_null
      # A tibble: 1 x 2
          row   col
        <int> <int>
      1     4     2
      
      $only_tf
      [1] 3 4
      
      $blank_in_cell
      [1] " "  "\t" "\n"
      
      $stat
             chr_na      chr_null       only_tf blank_in_cell 
                  1             1             2             3 
      
      $pass
      [1] FALSE
      

# gen_tb

    Code
      gen_tb(fill = "str", nrow = 3, ncol = 4, len = 3, seed = 123)
    Output
      # A tibble: 3 x 4
        V1    V2    V3    V4   
        <chr> <chr> <chr> <chr>
      1 osn   tnv   ich   nqk  
      2 cjr   yze   zgj   gul  
      3 vke   syy   isd   ojm  

# diff_tb

    Code
      diff_tb(tb1, tb2)
    Output
      # A tibble: 6 x 5
        compare V1    V2    V3    V4   
        <chr>   <chr> <chr> <chr> <chr>
      1 -[1,]   -7    15    4     -4   
      2 +[1,]   -10   -12   0     12   
      3 -[2,]   1     3     7     15   
      4 +[2,]   -3    1     11    -8   
      5 -[3,]   -9    -9    5     3    
      6 +[3,]   2     0     -13   -12  

# tdf

    Code
      tdf(head(mini_diamond))
    Condition
      Warning:
      The `x` argument of `as_tibble.matrix()` must have unique column names if `.name_repair` is omitted as of tibble 2.0.0.
      i Using compatibility `.name_repair`.
    Output
      # A tibble: 7 x 7
        item    V2      V3    V4      V5      V6      V7   
        <chr>   <chr>   <chr> <chr>   <chr>   <chr>   <chr>
      1 id      "id-1"  id-2  "id-3"  "id-4"  "id-5"  id-6 
      2 carat   "1.02"  1.51  "0.52"  "1.54"  "0.72"  2.02 
      3 cut     "Fair"  Good  "Ideal" "Ideal" "Ideal" Fair 
      4 clarity "SI1"   VS2   "VVS1"  "SI2"   "VS1"   SI2  
      5 price   " 3027" 11746 " 2029" " 9452" " 2498" 14080
      6 x       "6.25"  7.27  "5.15"  "7.43"  "5.73"  8.33 
      7 y       "6.18"  7.18  "5.18"  "7.45"  "5.77"  8.37 

# tdf, with rownames

    Code
      tdf(c2r(head(mini_diamond), "id"))
    Output
      # A tibble: 6 x 7
        item    `id-1`  `id-2` `id-3`  `id-4`  `id-5`  `id-6`
        <chr>   <chr>   <chr>  <chr>   <chr>   <chr>   <chr> 
      1 carat   "1.02"  1.51   "0.52"  "1.54"  "0.72"  2.02  
      2 cut     "Fair"  Good   "Ideal" "Ideal" "Ideal" Fair  
      3 clarity "SI1"   VS2    "VVS1"  "SI2"   "VS1"   SI2   
      4 price   " 3027" 11746  " 2029" " 9452" " 2498" 14080 
      5 x       "6.25"  7.27   "5.15"  "7.43"  "5.73"  8.33  
      6 y       "6.18"  7.18   "5.18"  "7.45"  "5.77"  8.37  

# uniq_in_cols

    Code
      uniq_in_cols(mini_diamond)
    Condition
      Warning:
      The `x` argument of `as_tibble.matrix()` must have unique column names if `.name_repair` is omitted as of tibble 2.0.0.
      i Using compatibility `.name_repair`.
    Output
      # A tibble: 7 x 2
        col     uniqe_values
        <chr>   <chr>       
      1 id      100         
      2 carat   57          
      3 cut     3           
      4 clarity 8           
      5 price   99          
      6 x       89          
      7 y       87          

