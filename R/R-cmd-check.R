# fix the note:
# hist_bins: no visible global function definition for 'between'
# hist_bins: no visible binding for global variable 'value'
# hist_bins: no visible binding for global variable 'start'
# hist_bins: no visible binding for global variable 'end'
utils::globalVariables(c("between", "value", "start", "end"))

# fix the note:
# stat_test : stat_ingroup: no visible global function definition for 'closest'
# stat_test : stat_ingroup: no visible binding for global variable 'p'
# stat_test : stat_ingroup: no visible binding for global variable 'plim'
utils::globalVariables(c("closest", "p", "plim"))
