*! version 1.2.0  22jun2009

program define ivtobit_p
	version 8

	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		if `"`e(method)'"' == "twostep" {
			di as err ///
			"option scores is not allowed with twostep results"
			exit 322
		}
		global IVT_NEND `e(endog_ct)'
		global IVT_ll `e(tobitll)'
		global IVT_ul `e(tobitul)'
		ml score `0'
		macro drop IVT_*
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

	local myopts "STDF E(string) Pr(string) YStar(string)"

		/* Step 2:
			call _pred_se, exit if done,
			else collect what was returned.
		*/

	_pred_se "`myopts'" `0'
	if `s(done)' { 
		exit 
	}
	
	local vtyp `s(typ)'
	local varn `s(varn)'
	local 0 `"`s(rest)'"'

		/* Step 3:
			Parse your syntax.
		*/

	syntax [if] [in] [, `myopts' ]

	if "`e(prefix)'" == "svy" {
		_prefix_nonoption after svy estimation, `stdf'
	}

		/* Step 4:
			Concatenate switch options together
		*/

	local type "`stdf'"
	local args `"`pr'`e'`ystar'"'

		/* Step 5:
			quickly process default case if you can
		*/

	if "`type'"=="" & `"`args'"'=="" {
		di in gr "(option xb assumed; fitted values)"
		_predict `vtyp' `varn' `if' `in'
		exit
	}
	
		/* If we've gotten this far, it's not xb or stdp. */
		/* b0rk if twostep estimator was used.		  */
	if "`e(method)'" == "twostep" {
		if `"`pr'"' != "" {
			local type "pr()"
		}
		else if `"`e'"' != "" {
			local type "e()"
		}
		else if `"`ystar'"' != "" {
			local type "ystar()"
		}
di as error "`type' not available with two-step estimator"
		exit 198
	}
	
		/* Step 6:
			mark sample (this is not e(sample)).
		*/

	marksample touse

		/* Step 7:
			handle options that take argument one at a time.
			Comment if restricted to e(sample).
			Be careful in coding that number of missing values
			created is shown.
			Do all intermediate calculations in double.
		*/

	if `"`args'"'!="" {
		if "`type'"!="" { 
			error 198 
		}
		GetRMSE
		regre_p2 "`vtyp'" "`varn'" "`touse'" ""	/* 
			*/ `"`pr'"' `"`e'"' `"`ystar'"' /*
			*/ "`s(rmse)'"
		exit
	}

		/* Step 8:
			handle switch options that can be used in-sample or
			out-of-sample one at a time.
			Be careful in coding that number of missing values
			created is shown.
			Do all intermediate calculations in double.
		*/

	if "`type'"=="stdf" {
		tempvar stdp
		qui _predict double `stdp' if `touse', stdp 
		GetRMSE
		gen `vtyp' `varn' = sqrt(`stdp'^2 + `s(rmse)'^2) if `touse'
		label var `varn' "S.E. of the forecast"
		exit
	}

		/* Step 9:
			handle switch options that can be used in-sample only.
			Same comments as for step 8.
		*/

	/*qui replace `touse'=0 if !e(sample)*/

		/* Step 10.
			Issue r(198), syntax error.
			The user specified more than one option
		*/

	error 198
end

program define GetRMSE, sclass

	sret clear
	tempname mat se
	mat `mat' = e(Sigma)
	mat `se' = `mat'[1,1]
	scalar `se' = sqrt(trace(`se'))
	sret local rmse = `se'
	
end		
