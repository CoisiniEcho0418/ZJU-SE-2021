*! version 1.0.2  16nov2005
program probit_estat, rclass
	version 9

	if "`e(cmd)'" != "probit" & "`e(cmd)'" != "dprobit" &	///
		"`e(cmd)'" != "ivprobit" {
		error 301
	}

	gettoken key rest : 0, parse(", ")
	local lkey = length(`"`key'"')
	if `"`key'"' == substr("classification",1,max(4,`lkey')) {
		CheckForBad `rest'
		lstat `rest'
	}
	else if `"`key'"' == substr("gof",1,max(3,`lkey')) {
		if "`e(cmd)'" == "ivprobit" {
			di as error /*
			*/ "not available after {cmd:ivprobit}"
			exit 321
		}
		CheckForBad `rest'
		lfit `rest'
	}
	else if `"`key'"' == substr("auc",1,max(3,`lkey')) {
		CheckForBad `rest'
		lroc, nograph, `rest'
	}
	else {
		estat_default `0'
	}
	return add
end


program CheckForBad
	capture syntax varlist [fw] [if] [in] [, * ]
	if _rc == 0 {
		// it found a varname
		di as error "varlist not allowed"
		exit 101
	}
	capture syntax [fw] [if] [in] , beta(str) [ * ]
	if _rc == 0 {
		// it found a beta() option
		di as error "option beta() not allowed"
		exit 198
	}
	if "`e(cmd)'" == "ivprobit" {
		if "`e(method)'" == "twostep" {
			di as error /*
				*/ "not available after {cmd:ivprobit, twostep}"
			exit 321
		}
	}
end
