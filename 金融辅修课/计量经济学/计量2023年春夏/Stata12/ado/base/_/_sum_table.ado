*! version 2.0.1  12may2011
program _sum_table, rclass
	version 9
	if !c(noisily) {
		exit
	}
	if "`e(cmd)'" == "" {
		error 301
	}
	if "`e(mi)'"=="mi" {
		local MIOPTS BMATrix(string) VMATrix(string) DFMATrix(string)
		local MIOPTS `MIOPTS' PISEMATrix(string) EMATrix(string)
		local MIOPTS `MIOPTS' DFTable NOCLUSTReport NOEQCHECK DFONLY
		local MIOPTS `MIOPTS' ROWMATrix(string) ROWCFormat(string) 
		local MIOPTS `MIOPTS' NOROWCI 
        }

	syntax [,	Level(cilevel)		///
			COEFLegend		///
			SELEGEND		///
			cformat(passthru)	///
			noLSTRETCH		///
			`MIOPTS'		///
	]
	_get_diopts ignore, `cformat'
	local cformat `"`s(cformat)'"'

	if ("`e(mi)'"=="mi") {
		is_svysum `e(cmd_mi)'
	}
	else {
		is_svysum `e(cmd)'
	}
	if !r(is_svysum) {
		error 301
	}

	local type `coeflegend' `selegend' `dfonly'
	opts_exclusive "`type'"
	if "`type'" == "" {
		local type cionly
	}
	if "`e(over)'" != "" {
		local depname `"Over"'
	}
	else	local depname `" "'
	local coefttl "`e(depvar)'"
	local cmdextras cmdextras

	mata: _coef_table()
	return add
end

exit
