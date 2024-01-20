*! version 1.2.0  22jun2009

program define ivprobit_p
	version 8

	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		if `"`e(method)'"' == "twostep" {
			di as err ///
			"option scores is not allowed with twostep results"
			exit 322
		}
		global IV_NEND `e(endog_ct)'
		ml score `0'
		macro drop IV_*
		exit
	}

		/* Step 1:
			place command-unique options in local myopts
			Note that standard options are
			LR:
				Index XB Cooksd Hat 
				REsiduals RSTAndard RSTUdent
				STDF STDP STDR noOFFset
			SE:
				Index XB STDP noOFFset
		*/

	local myopts Pr ASIF RULEs XB

		/* Step 2:
			call _propts, exit if done, 
			else collect what was returned.
		*/
			/* takes advantage that -myopts- produces error
			 * if -eq()- specified w/ other that xb and stdp */
	_pred_se "`myopts'" `0'
	if `s(done)' { 
		exit 
	}
	local vtyp  `s(typ)'
	local varn `s(varn)'
	local 0 `"`s(rest)'"'


		/* Step 3:
			Parse your syntax.
		*/

	syntax [if] [in] [, `myopts' ]
	
		/* Step 4 not needed here */

		/* Step 5:
			quickly process default case if you can 
		*/

	if "`pr'`asif'`rules'`xb'"=="" {
		di as text "(option xb assumed; fitted values)"
		local xb "xb"
	}
	if "`e(method)'" == "twostep"  & "`xb'" == "" {
di as error "probabilities not available with two-step estimator"
		exit 198
	}	

	if "`xb'" != "" {
		_predict `vtyp' `varn' `if' `in' 
		label var `varn' "Fitted values"
		exit
	}
	
		/* Step 6:
			mark sample (this is not e(sample)).
		*/
	marksample touse



		/* Step 8:
			handle switch options that can be used in-sample or 
			out-of-sample one at a time.
			Be careful in coding that number of missing values
			created is shown.
			Do all intermediate calculations in double.
		*/

				/* Get the model index (Xb), 
				 * required for all remaining options */
				 
	local depname `e(depvar)'
	tempvar Xb
	qui _predict double `Xb' if `touse' ,xb
	
	if `: word count `asif' `pr' `rules'' > 1 {
di as error "only one of {cmd:pr}, {cmd:rules}, or {cmd:asif} may be specified"
		exit 198
	}
	
	if "`asif'" != "" {		/* Just return norm(xb), no rules */
		gen `vtyp' `varn' =  norm(`Xb')
                label var `varn' "Probability of positive outcome"   
		exit
	}
	
        tempname rulmat j
        mat `rulmat' = e(rules)
	local names : rownames(`rulmat')
	local rows = rowsof(`rulmat')
	gen `vtyp' `varn' = norm(`Xb') if `touse'
	label var `varn' "Probability of positive outcome"
	if (`rulmat'[1,1] == 0 & `rulmat'[1,2] == 0 & ///
		`rulmat'[1,3] == 0 & `rulmat'[1,4] == 0) {
		/* No rules to apply; exit */
		exit
	}

	if "`rules'" != "" {
		forvalues i = 1/`rows' {
			if `rulmat'[`i',1] == 4 {
				continue
			}
			local v : word `i' of `names'
			sca `j' = `rulmat'[`i', 2]
			if `rulmat'[`i', 3] == 0 {
				qui replace `varn' = 0 if `v' != `j' & `touse'
			}
			if `rulmat'[`i', 3] == 1 {
				qui replace `varn' = 1 if `v' != `j' & `touse'
			}
			if `rulmat'[`i', 3] == -1 {
				if `rulmat'[`i', 1] == 2 {
					qui replace `varn' = 1 ///
						if `v' > `j' & `touse'
					qui replace `varn' = 0 ///
						if `v' < `j' & `touse'
				}
				else {
					qui replace `varn' = 1 ///
						if `v' < `j' & `touse'
					qui replace `varn' = 0 ///
						if `v' > `j' & `touse'
				}
			}
		}
		exit
	}
	
	if "`pr'" != "" {
		/* Go through and set to missing if rules omitted obs.*/
		forvalues i = 1/`rows' {
			if `rulmat'[`i',1] == 4 {
				continue
			}	
			local v : word `i' of `names'
			sca `j' = `rulmat'[`i', 2]
			if `rulmat'[`i', 3] == 0 | `rulmat'[`i', 3] == 1 | /*
				*/ `rulmat'[`i', 3] == -1 {
				qui count if `v' != `j' & `touse'
				loc n = r(N)
				loc s "s"
				if `n' == 1 {
					loc s ""
				}
				qui replace `varn' = . if `v' != `j' & `touse'
				di "(`n' missing value`s' generated)"
			}
		}
		exit
	}

			/* Step 10.
				Issue r(198), syntax error.
				The user specified more than one option
			*/
	error 198
end

