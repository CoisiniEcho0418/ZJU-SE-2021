*! version 4.1.0  28may2009
program define xtabond, byable(onecall) eclass prop(xt)

	version 10, missing

	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}

	if _caller() < 10 {
		`BY' _xtabond9 `0'
		exit
	}	

	if replay() {
		if "`e(cmd)'" != "xtabond" {
			error 301 
		} 
		if _by() { 
			error 190 
		}
		syntax [, Level(cilevel) *]
		xtdpd , level(`level') `options'
		exit
	}

	syntax varlist(ts default=none) [if] [in], [ * ]

	_xtab_parser `varlist' `if' `in', `options' xtabond
	
	local xtdpd_cmd `r(cmd)'

	`BY' xtdpd `xtdpd_cmd'
	ereturn local cmdline `"xtabond `0'"'

end
