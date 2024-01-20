*! version 1.1.0  16mar2009
program xtset
	version 9.2
	syntax [varlist(numeric max=2 default=none)] [, MI *]

	if ("`mi'"=="") {
		u_mi_not_mi_set xtset
	}
	else {
		u_mi_check_setvars settime xtset `varlist'
	}

	local nvars : list sizeof varlist
	if (`nvars' == 2) {
		tsset `0'
	}
	else if (`nvars' == 1) {
		PanelSet `0'
	}
	else {
		syntax [, clear MI]
		if ("`clear'" != "") {
			tsset, clear `mi'
		}
		else {
			if (`"`_dta[_TStvar]'"' == "") {
				PanelSet, `options' `mi'
			}
			else {
				tsset, `mi'
			}
		}
	}
end

program PanelSet, rclass sortpreserve

	/* ------------------------------------------------------------ */
	syntax [varlist(max=1 default=none)] [, MI *]

	if ("`mi'"=="") {
		u_mi_not_mi_set xtset
		local checkvars "*"
	}
	else {
		local checkvars "u_mi_check_setvars settime xtset"
	}
	

	if "`options'" != "" {
		di as err ///
		"options not allowed unless a time variable is specified"
		exit 101
	}
	/* ------------------------------------------------------------ */

	if "`varlist'" != "" {
		`checkvars' `varlist'
		tsset, clear `mi'
		char _dta[iis]      `varlist'
		char _dta[_TSpanel] `varlist'
	}
	else {
		local varlist : char _dta[_TSpanel]
		if "`varlist'" == "" {
			local varlist : char _dta[iis]
		}
	}
	if "`varlist'" == "" {
		local cmd = cond("`mi'"=="", "xtset", "mi xtset")
		di as smcl as err ///
		"panel variable not set; use {bf:`cmd'} {it:varname} ..."
		exit 459
	}
	sort `varlist'
	tempvar nobs
	quietly by `varlist': gen `nobs' = _N
	capture assert `nobs' == `nobs'[1]
	if c(rc) {
		local bal unbalanced
	}
	else	local bal balanced
	di as txt _col(8) "panel variable:  " as res "`varlist' (`bal')"
	return local balanced `bal'
	return local panelvar `varlist'
	sum `varlist', meanonly
	return scalar imin = r(min)
	return scalar imax = r(max)
end
