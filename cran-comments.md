There are four NOTEs:

# First

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

Since `dplyr::join_by()` accepts `expression` objects, I think it's reasonable 
to keep it as is.

https://github.com/tidyverse/dplyr/blob/07934097b71ec98f7112ceee4bf6345825eb39ef/R/join-by.R#L229

# Second

```
checking for detritus in the temp directory ... NOTE Found the following files/directories: 'lastMiKTeXException'
```
As noted in R-hub issue #503, this could be due to a bug/crash in MiKTeX and can likely be ignored.

# Third

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```
Also noted in R-hub issue #548.

# Fourth

```
* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
  ''NULL''
```
Also noted in R-hub issue #560.
