There is one NOTE:

```
* checking R code for possible problems ... [7s/21s] NOTE
hist_bins: no visible global function definition for ‘between’
hist_bins: no visible binding for global variable ‘value’
hist_bins: no visible binding for global variable ‘start’
hist_bins: no visible binding for global variable ‘end’
Undefined global functions or variables:
  between end start value
Consider adding
  importFrom("stats", "end", "start")
to your NAMESPACE file.
```

The corresponding source code:
```r
dfres <- dfvec %>% dplyr::left_join(dfbin, by = dplyr::join_by(
  between(value, start, end, bounds = "(]")
))
```

Since `dplyr::join_by()` accepts `expression` objects, I think it's proper to 
keep it as is.

https://github.com/tidyverse/dplyr/blob/07934097b71ec98f7112ceee4bf6345825eb39ef/R/join-by.R#L229
