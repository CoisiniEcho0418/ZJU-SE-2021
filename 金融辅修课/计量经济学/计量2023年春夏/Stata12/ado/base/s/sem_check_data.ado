*! version 1.0.1  29jun2011
program sem_check_data
	version 12

	local ovars  `e(oyvars)' `e(oxvars)'
	confirm numeric variable `ovars', exact

	local ng = `e(N_groups)'
	if `ng' <= 1 {
		exit
	}

	local gvar `e(groupvar)'
	confirm numeric variable `gvar', exact

	capture assert (`gvar' == floor(`gvar')) & (`gvar' >= 0) if e(sample)
	if c(rc) {
		di as err ///
"variable '`gvar'' is not nonnegative integer valued"
		exit 459
	}
end

exit
