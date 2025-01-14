*! version 1.0.1  15jul2004
program define irf_create, 
	version 8.2

	syntax name(id="irfname" name=irfname)		///
		[ , 					///
		ESTimates(string) *			///
		]


	if `"`estimates'"' != "" {
		tempname esamp ename
		_estimates hold `ename', restore nullok	varname(`esamp')
		capture estimates restore `estimates'
		if _rc > 0 {
			di as err "cannot restore `estimates'"
			exit 498
		}
	}

	local cmd "`e(cmd)'"
	
	if "`cmd'" == "var" | "`cmd'" == "svar" {
		varirf create `irfname', `options'
		exit		
	}

	if "`cmd'" == "vec" {
		vecirf_create `irfname', `options'
		exit		
	}

	if "`cmd'" == "" {
		di as err "estimates not found"
		exit 301
	}

	di as err "cannot compute IRFs after {cmd:`cmd'}"
	exit 198
end

exit
