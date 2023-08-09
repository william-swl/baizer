There are four NOTEs:

# First

```
* checking dependencies in R code ... NOTE
Unexported object imported by a ':::' call: 'waldo:::ses_shortest'
  See the note in ?`:::` about the use of this operator.
```

`ses_shortest()` is a necessary function for `baizer::diff_tb()` while not been exported 
from `waldo` package.



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
