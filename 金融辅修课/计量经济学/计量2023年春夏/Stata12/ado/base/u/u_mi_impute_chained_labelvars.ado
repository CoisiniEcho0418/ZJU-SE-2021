*! version 1.0.0  14jun2011
program u_mi_impute_chained_labelvars
	version 12
	args fname ivarsincord
	preserve
	use `"`fname'"', clear
	qui compress
	local ind 1
	foreach ivar in `ivarsincord' {
		cap unab vars : `ivar'_*
		if _rc { // long variable names
			cap unab vars : _mi_`ind'_*
			local ++ind
		}
		gettoken var vars : vars
		label variable `var' "Mean of `ivar'"
		gettoken var vars : vars
		label variable `var' "Std. Dev. of `ivar'"
		if ("`vars'"!="") {
			gettoken var vars : vars
			label variable `var' "Minimum of `ivar'"
			gettoken var vars : vars
			label variable `var' "25th percentile of `ivar'"
			gettoken var vars : vars
			label variable `var' "Median of `ivar'"
			gettoken var vars : vars
			label variable `var' "75th percentile of `ivar'"
			gettoken var vars : vars
			label variable `var' "Maximum of `ivar'"
		}
	}
	label variable iter "Iteration numbers"
	label variable m "Imputation numbers"
	qui label data "Summaries of imputed values from -mi impute chained-"
	qui save, replace
end
