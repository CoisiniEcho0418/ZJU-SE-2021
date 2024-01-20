*! version 3.3.0  02jun2009
program define heckma_p
	version 8.0, missing

	syntax [anything] [if] [in] [, SCores SCORESEL * ]
	if `"`scores'`scoresel'"' != "" {
		if "`e(method)'" != "ml" {
			local scores : word 1 of `scores' `scoresel'
			di as err ///
"option `scores' is not allowed with `e(method)' results"
			exit 198
		}
		if "`scoresel'" != "" {
			local scores scores
			local eq eq(#2)
		}
		marksample touse
		marksample touse2
		local xvars : colna e(b)
		local cons _cons _cons _cons _cons
		local xvars : list xvars - cons
		local depvar = e(depvar)
		gettoken dep1 dep2 : depvar
		if `:length local dep2' {
			local if if `dep2'
		}
		else {
			local if if !missing(`dep1')
		}
		markout `touse2' `xvars'
		quietly replace `touse' = 0 `if' & !`touse2'
		ml score `anything' if `touse', `scores' `eq' missing	///
			`options'
		exit
	}

	version 6, missing

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

	local myopts YCond E(string) YExpected Mills NShazard Pr(string) /*
		*/ SELconst(varname numeric) PSel STDPSel XBSel  /*
		*/ STDF YStar(string)


		/* Step 2:
			call _propts, exit if done, 
			else collect what was returned.
		*/
			/* takes advantage that -myopts- produces error
			 * if -eq()- specified w/ other that xb and stdp */

	_pred_se "`myopts'" `0'
	if `s(done)' { exit }
	local vtyp  `s(typ)'
	local varn `s(varn)'
	local 0 `"`s(rest)'"'


		/* Step 3:
			Parse your syntax.
		*/

	syntax [if] [in] [, `myopts' CONstant(varname numeric) noOFFset]

	if "`e(prefix)'" == "svy" {
		_prefix_nonoption after svy estimation, `stdf'
	}

	if "`nshazard'" != "" & "`mills'" != "" {
		local mills
		di in blue "options nshazard and mills are synonyms, " /*
			*/ "mills ignored."
	}


		/* Step 4:
			Concatenate switch options together
		*/

	local type  `ycond'`yexpect'`mills'`nshazard'`psel'/*
		*/`xbsel'`stdpsel'`stdf'
	local args `"`pr'`e'`ystar'"'


		/* Step 5:
			quickly process default case if you can 
			Do not forget -nooffset- option.
		*/

	if "`constan'" != "" { local constan "constant(`constan')" }

	if "`type'"=="" & `"`args'"'=="" {
		di in gr "(option xb assumed; fitted values)"
		_predict `vtyp' `varn' `if' `in', `offset' `constan'
		exit
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

	tempname sigma rho lambda
	if "`e(method)'"=="ml" | substr("`e(cmd)'",1,3) == "svy" ///
	 | `"`e(prefix)'"' == "svy" {
		local tau [athrho]_b[_cons]
		scalar `rho' = (exp(2*`tau')-1) / (exp(2*`tau')+1)
		scalar `sigma' = exp([lnsigma]_b[_cons])
		scalar `lambda' = `rho'*`sigma'
	}
	else {
		scalar `rho' = e(rho)
		scalar `sigma' = e(sigma)
		scalar `lambda' = e(lambda)
	}
	
	if `"`args'"'!="" {
		if "`type'"!="" { error 198 }
		regre_p2 "`vtyp'" "`varn'" "`touse'" "`offset'" `"`pr'"'  /*
			*/ `"`e'"' `"`ystar'"' "`sigma'" "`constan'"
		exit
	}


		/* Step 8:
			handle switch options that can be used in-sample or 
			out-of-sample one at a time.
			Be careful in coding that number of missing values
			created is shown.
			Do all intermediate calculations in double.
		*/



				/* Set up varnames and select constant
				 * option. */
	tokenize `e(depvar)'
	local depname `1'
	local selname = cond("`2'"=="", "select", "`2'")
	if "`selcons'" != "" { local selcons "constant(`selcons')" }

				/* Selection index standard error */
	if "`type'" == "stdpsel" { 
		_predict `vtyp' `varn', stdp eq(#2) `offset' `selcons', /*
			*/ if `touse'
		label var `varn' "S.E. of prediction of `selname'"
		exit
	}

				/* Get selection model index, required 
				 * for all remaining options */

	tempvar Xbprb Xb 
	qui _predict double `Xbprb', xb eq(#2) `offset' `selcons', if `touse'  

				/* Selection index */
	if "`type'" == "xbsel" { 
		gen `vtyp' `varn' = `Xbprb'
		label var `varn' "Linear prediction of `selname'"
		exit
	}


				/* Probability observed, from selection 
				 * equation */
	if "`type'" == "psel" {
		gen `vtyp' `varn' = normprob(`Xbprb')
		label var `varn' "Pr(`selname')"
		exit
	}

				/* Get the model index (Xb), 
				 * required for all remaining options */

	qui _predict double `Xb', xb `offset' `constan', if `touse'

				/* E(y)|observed */
	if "`type'" == "ycond" {
		gen `vtyp' `varn' =  `Xb' + (normd(`Xbprb') / /*
			*/ normprob(`Xbprb')) * `sigma' * `rho'
		label var `varn' "E(`depname'|Zg>0)"
		exit
	}

				/* E(y) if unobserved y_i taken to be 0 */
	if "`type'" == "yexpected" {
		gen `vtyp' `varn' = normprob(`Xbprb') *  /*
			*/ (`Xb' + (normd(`Xbprb') /     /*
			*/ normprob(`Xbprb')) * `sigma' * `rho')
		label var `varn' "E(`depname'*|Pr(`selname'))"
		exit
	}

				/* Mills' ratio */
	if "`type'" == "mills" | "`type'" == "nshazard" {
		gen `vtyp' `varn' = normd(`Xbprb') / normprob(`Xbprb')
		label var `varn' "Mills' ratio"
		exit
	}


	if "`type'"=="stdf" {
		tempvar stdp
		qui _predict double `stdp' if `touse', stdp `offset' `constan'
		gen `vtyp' `varn' = sqrt(`stdp'^2 + `sigma'^2) if `touse'
		label var `varn' "S.E. of the forecast"
		exit
	}


		/* Step 9:
			handle switch options that can be used in-sample only.
			Same comments as for step 8.
		*/
	*qui replace `touse'=0 if !e(sample)


			/* Step 10.
				Issue r(198), syntax error.
				The user specified more than one option
			*/
	error 198
end

