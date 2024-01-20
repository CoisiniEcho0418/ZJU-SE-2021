*! version 1.0.0  07jul2003
program svymarkout_8, rclass
	version 8.1
	syntax varname

	// retrieve the variables that identify the survey design
	// charactersitics
	quietly svyset
	local wvar `r(`r(wtype)')'
	local strata `r(strata)'
	local psu `r(psu)'
	local fpc `r(fpc)'

	// markout observations containing missing values
	local touse `varlist'
	markout `touse' `wvar' `fpc'
	markout `touse' `strata' `psu', strok

	// return the name of the weight var
	return local weight `wvar'
end
exit
