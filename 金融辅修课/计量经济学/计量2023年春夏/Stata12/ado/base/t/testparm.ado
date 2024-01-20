*! version 3.2.1  11aug2010
program testparm
	version 8.2
	local caller : display string(_caller())
	local version "version `caller':"

	syntax varlist(fv ts) [, EQuation(str) Equal]

	if `"`equation'"' != "" {
		local eqtxt [`equation']
		local eqopt eq(`equation')
	}
	else if "`e(cmd)'" == "mlogit" {
		if e(ibaseout) == 1 {
			local eqopt eq(#2)
		}
	}

	_ms_extract_varlist `varlist', `eqopt' noomit nofatal
	local varlist `"`r(varlist)'"'

	// check that variables in model
	foreach v of local varlist {
		capture `version' test `eqtxt' `v', notest
		if (_rc==0) {
			local ourlist `ourlist' `v'
		}
	}
	if "`ourlist'" == "" {
		di as err "no such variables"
		exit 111
	}

	// test coefs all zero

	if "`equal'" == "" {
		if "`eqtxt'" != "" {
			`version' test `eqtxt': `ourlist'
		}
		else	`version' test `ourlist'
		exit
	}

	// test coefs all equal

	tokenize "`ourlist'"
	if "`2'" == "" {
		error 102 // too few variables
	}

	if `caller' < 8 {
		local lhs "`1'"
		mac shift
		qui `version' test `eqtxt'`1' = `eqtxt'`lhs', notest
		mac shift
		while "`1'" != "" {
			qui `version' test `eqtxt'`1' = `eqtxt'`lhs', ///
				acc notest
			mac shift
		}
		`version' test
	}
	else {
		local lhs "`1'"
		mac shift
		local tests (`eqtxt'`1' = `eqtxt'`lhs')
		mac shift
		while "`1'" != "" {
			local tests `tests' (`eqtxt'`1' = `eqtxt'`lhs')
			mac shift
		}
		`version' test `tests'
	}

end
exit
