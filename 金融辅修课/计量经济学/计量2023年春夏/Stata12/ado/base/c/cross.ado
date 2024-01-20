*! version 2.3.0  21mar2011
program define cross
	if _caller() >= 12 {
		local vv : di "version " string(_caller()) ":"
	}
	version 6
	syntax using/
	local nob = _N
	tempfile cross2
	tempvar order midx
	preserve
	quietly {
		use `"`using'"', clear
		gen long `order'=_n
		expand `nob', clear 
		`vv' sort `order' 
		by `order': gen long `midx' = _n
		`vv' sort `midx' `order' 
		drop `order'
		save `"`cross2'"', replace 
		restore, preserve
		gen long `midx' = _n 
		`vv' sort `midx' 
		merge `midx' using `"`cross2'"'
		drop `midx' _merge 
		restore, not
	}
end
