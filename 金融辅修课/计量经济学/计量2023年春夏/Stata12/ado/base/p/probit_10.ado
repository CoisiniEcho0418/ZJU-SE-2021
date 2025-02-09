*! version 1.1.1  30oct2008
program define probit_10, eclass byable(onecall) prop(svyb svyj svyr swml)
	version 9, missing
	local version : di "version " string(_caller()) ", missing :"

	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	syntax [anything] [if] [in] [fw iw pw aw] [, DOOPT	///
		VCE(passthru) Robust CLuster(passthru) *	///
	]
	if `:length local vce' {
		`version' `BY' _vce_parserun probit_10,	///
			mark(OFFset CLuster) : `0'
		if "`s(exit)'" != "" {
			ereturn local cmdline `"`version' probit_10 `0'"'
			exit
		}
		_vce_parse, argopt(CLuster) opt(OIM Robust) old		///
			: [`weight'`exp'], `vce' `robust' `cluster'
		if "`r(cluster)'" != "" {
			local cluster cluster(`r(cluster)')
		}
		local robust `r(robust)'
		local vce = cond("`r(vce)'" != "", "`r(vce)'", "oim")
	}
	else if "`weight'" == "pweight" | "`robust'`cluster'" != "" {
		local vce robust
	}
	else	local vce oim
	if replay() {
		if !inlist("`e(cmd)'", "probit", "bprobit", "dprobit") {
			error 301
		}
		if _by() {
			error 190
		}
		`version' Display `0'
		exit
	}
	`version' `BY' _probit `anything' `if' `in'		///
		[`weight'`exp'], `options' `robust' `cluster'
	ereturn local vce "`vce'"
	ereturn local title "Probit regression"
	ereturn local cmdline `"`version' probit `0'"'
end

program Display
	version 9
	local version : di "version " string(_caller()) ":"
	syntax [, Level(cilevel) GROUPED * ]
	if "`e(prefix)'" != "" {
		_prefix_display, level(`level') `options'
	}
	else	`version' _probit, level(`level') `options' `grouped'
end

exit
