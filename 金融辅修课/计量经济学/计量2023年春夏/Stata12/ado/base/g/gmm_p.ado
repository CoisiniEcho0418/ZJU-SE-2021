*! version 1.0.0  04apr2009

program define gmm_p

	version 11
	/* NB this predictor does not use _predict */
	if "`e(cmd)'" != "gmm" {
		exit 301
	}
	
	syntax anything(name=vlist) [if] [in] , /*
		*/ [ Equation(string) ]
	
	tempvar touse 
	mark `touse' `if' `in'

	if "`equation'" != "" {
		local equation `=trim("`equation'")'
		local myrc = 0
		local eqnames `e(eqnames)'
		local eq : list posof `"`equation'"' in eqnames
		if `eq' == 0 {
			if substr("`equation'", 1, 1) == "#" {
				local equation `=substr("`equation'", 2, .)'
				local pound #
			}
			capture confirm integer number `equation'
			if _rc {
				di as error 		///
					"equation `pound'`equation' not found"
				exit 303
			}
				// next line gets rid of stuff like leading 0
				// from equation number
			local equation = `equation'
		}
		else {
			local equation = `eq'
		}
		if `equation' < 1 | `equation' > `e(n_eq)' {
			di as error "equation number out of range"
			exit 303
		}
		if `:word count `vlist'' > 2 {
			di as error "too many variables specified"
			exit 103
		}
		if `:word count `vlist'' == 2 {
			local typlist `:word 1 of `vlist''
			local varlist `:word 2 of `vlist''
		}
		else {
			local typlist "float"
			local varlist `vlist'
		}
	}
	else {
		_stubstar2names `vlist' , nvars(`=e(n_eq)')
		local typlist `s(typlist)'
		local varlist `s(varlist)'
	}
	
	if "`e(type)'" == "1" & "`options'" != "" {
		di as error "`options' not allowed"
		exit 198
	}
	
	if "`e(type)'" == "1" {
		tempname parmvec	
		matrix `parmvec' = e(b)
		forvalues i = 1/`e(n_eq)' {
			local expr`i' `e(sexp_`i')'
		}
		local params `e(params)'
	
		/* Replace param names with parmvec columns */
		foreach parm of local params {
			local j = colnumb(`parmvec', "`parm':_cons")
			forvalues i = 1/`e(n_eq)' {
				local expr`i' : subinstr local expr`i' /*
					*/ "{`parm'}" "\`parmvec'[1,`j']", all
			}
		}
		if "`equation'" != "" {
			tempvar yh`equation'
			quietly generate `typlist' `varlist' = 		///
				`expr`equation'' if `touse'
			label var `varlist' "Equation `equation' residuals"
		}
		else {
			forvalues i = 1/`e(n_eq)' {
				local vi : word `i' of `varlist'
				local ti : word `i' of `typlist'
				quietly generate `ti' `vi' = 		///
					`expr`i'' if `touse'
				label var `vi' "Equation `i' residuals"
			}
		}
	}
	else {
		tempname parmvec
		matrix `parmvec' = e(b)
		local params `e(params)'
		local rhs `e(rhs)'
		local prog `e(evalprog)'
		local progopts `e(evalopts)'
		local yh
		forvalues i = 1/`e(n_eq)' {
			tempvar yh`i'
			quietly generate double `yh`i'' = .
			local yh `yh' `yh`i''
		}
		capture `prog' `yh' if `touse' , at(`parmvec') `progopts'
		if _rc {
			di as error "`prog' returned " _rc
			exit _rc
		}
		if "`equation'" != "" {
			local which : word `equation' of `yh'
			qui gen `typlist' `varlist' = `which' if `touse'
			label var `varlist' "Equation `equation' residuals"
		}
		else {
			forvalues i = 1/`e(n_eq)' {
				local vi : word `i' of `varlist'
				local ti : word `i' of `typlist'
				local which : word `i' of `yh'
				quietly gen `ti' `vi' = `which' if `touse'
				label var `vi' "Equation `i' residuals"
			}
		}
	}

end

