*! version 1.1.1  02nov2009


// This program takes two lists of linearly independent variables
// and checks for collinearity in the union of the two lists.  Collinear
// variables are removed from the second list.

program define _rmcoll2list, rclass

	local vv : di "version " string(_caller()) ":"
	syntax , 					///
		alist(varlist fv ts) 			///
		blist(varlist fv ts) 			///
		normwt(varname)				///		
		touse(varname)				///
		[					///
		name(string)				///
		]					///

	local fvops = "`s(fvops)'" == "true" | _caller() >= 11
	if `fvops' {
		if _caller() < 11 {
			local vv "version 11:"
		}
		fvexpand `alist' if `touse'
		local alist `r(varlist)'
		fvexpand `blist' if `touse'
		local blist `r(varlist)'
		local expand "expand"
	}
	if "`alist'" == ""  {
		return local blist `blist'
		exit
	}

	if "`blist'" == "" exit

	local full `alist' `blist'
	local remove : list blist & alist
	foreach v of local remove {
		if "`name'" != "" {
			di 	///
"{txt}note: `v' dropped from `name'() because of collinearity"
		}
		else {
			di "{txt}note: `v' dropped because of collinearity"
		}
	}
	local blist : list blist - remove
	local full `alist' `blist'
	tempname noomit
	NoOmit `full', touse(`touse')
	mat `noomit' = r(noomit)
	local hasfv = `r(hasfv)'
	local full_noomit "`r(noomitvars)'"

	NoOmit `alist', touse(`touse')
	local alist_c = `r(noomitted)'

	`vv' ///
	qui _rmcoll `full' if `touse', noconstant `expand'
	local dropped `r(varlist)'

	local same : list full == dropped
	if !`same' {
		local full_noomit `full_noomit'
		local ndivs = `alist_c'
		mata: ///
		_rmcoll2list_wrk(`ndivs', "full", "full_noomit","`normwt'","`touse'",`hasfv')
		local blist `full'
	}

	return local blist `blist'
end

program NoOmit, rclass
	syntax [varlist(fv ts default=none)] [,touse(string)]
	if "`varlist'" == "" {
		local hasfv = 0
		local omitted 0 
		local noomitted 0
		return scalar omitted = `omitted'
		return scalar noomitted = `noomitted'
		return scalar hasfv = `hasfv'
		exit
	}
	local hasfv = "`s(fvops)'" == "true"	
	fvexpand `varlist' if `touse'
	local full_list `r(varlist)'
	local cols : word count `full_list'
	tempname noomit 
	mat `noomit' = J(1,`cols',1)
	local omitted 0
	local noomitted 0
	local i 1
	foreach var of local full_list {
		_ms_parse_parts `var'
		if `r(omit)' {
			local ++omitted	
			mat `noomit'[1,`i'] == 0
			if !`hasfv' {
				local hasfv 1
			}
		}
		else {
			local ++noomitted
			local noomitvars `noomitvars' `var'
		}
		local ++i
	}
	return scalar omitted = `omitted'
	return scalar noomitted = `noomitted'
	return scalar hasfv = `hasfv'
	return matrix noomit = `noomit'
	return local noomitvars "`noomitvars'"
end

