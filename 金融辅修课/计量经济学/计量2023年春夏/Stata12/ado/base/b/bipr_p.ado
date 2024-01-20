*! version 1.3.0  09jun2009
program define bipr_p
	version 6, missing

	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		ml score `0'
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

	local myopts P11 P01 P10 P00 PMARG1 PMARG2 XB1 XB2 
	local myopts `myopts' STDP1 STDP2 PCOND1 PCOND2 


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

	syntax [if] [in] [, `myopts' noOFFset]


		/* Step 4:
			Concatenate switch options together
		*/

	local type  `p11'`p01'`p10'`p00'`pmarg1'`pmarg2'`xb1'`xb2'
	local type  `type'`stdp1'`stdp2'`pcond1'`pcond2'`psel1'`psel2'
	local args


		/* Step 5:
			quickly process default case if you can 
			Do not forget -nooffset- option.
		*/


	tokenize `e(depvar)'
	local dep1 `1'
	local dep2 `2'

	tempvar xb zg
	tempname r
	qui _predict double `xb' `if' `in', eq(#1) `offset' 
	qui _predict double `zg' `if' `in', eq(#2) `offset'
	scalar `r' = [athrho]_b[_cons]
	scalar `r' = (exp(2*`r')-1)/(exp(2*`r')+1)
	

				/* P11 */
	if ("`type'"=="" | "`type'" == "p11") & `"`args'"'=="" {
		if "`type'" == "" {
			di in gr "(option p11 assumed; Pr(`dep1'=1,`dep2'=1))"
		}
		gen `vtyp' `varn' = binorm(`xb',`zg',`r')
		label var `varn' "Pr(`dep1'=1,`dep2'=1)"
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



		/* Step 8:
			handle switch options that can be used in-sample or 
			out-of-sample one at a time.
			Be careful in coding that number of missing values
			created is shown.
			Do all intermediate calculations in double.
		*/

				/* pmarg1 */
	if "`type'" == "pmarg1" {
		gen `vtyp' `varn' = normprob(`xb')
		label var `varn' "Pr(`dep1'=1)"
		exit
	}
				/* pmarg2 */
	if "`type'" == "pmarg2" {
		gen `vtyp' `varn' = normprob(`zg')
		label var `varn' "Pr(`dep2'=1)"
		exit
	}
				/* P01 */
	if "`type'"=="p01" {
		gen `vtyp' `varn' = binorm(-`xb',`zg',-`r')
		label var `varn' "Pr(`dep1'=0,`dep2'=1)"
		exit
	}
				/* P10 */
	if "`type'"=="p10" {
		gen `vtyp' `varn' = binorm(`xb',-`zg',-`r')
		label var `varn' "Pr(`dep1'=1,`dep2'=0)"
		exit
	}
				/* P00 */
	if "`type'"=="p00" {
		gen `vtyp' `varn' = binorm(-`xb',-`zg',`r')
		label var `varn' "Pr(`dep1'=0,`dep2'=0)"
		exit
	}
				/* PCOND1 */
	if "`type'"=="pcond1" {
		gen `vtyp' `varn' = binorm(`xb',`zg',`r')/normprob(`zg')
		label var `varn' "Pr(`dep1'=1|`dep2'=1)"
		exit
	}
				/* PCOND2 */
	if "`type'"=="pcond2" {
		gen `vtyp' `varn' = binorm(`xb',`zg',`r')/normprob(`xb')
		label var `varn' "Pr(`dep2'=1|`dep1'=1)"
		exit
	}
				/* linear predictor for equation 1 */
	if "`type'" == "xb1" {	
		gen `vtyp' `varn' = `xb'
		label var `varn' "Linear prediction of `dep1'"
		exit
	}
				/* Probit index standard error */
	if "`type'" == "stdp1" { 
		_predict `vtyp' `varn', stdp eq(#1) `offset', /*
			*/ if `touse'
		label var `varn' "S.E. of prediction of `dep1'"
		exit
	}
				/* Selection index standard error */
	if "`type'" == "stdp2" { 
		_predict `vtyp' `varn', stdp eq(#2) `offset', /*
			*/ if `touse'
		label var `varn' "S.E. of prediction of `dep2'"
		exit
	}

				/* linear prediction for equation 2 */
	if "`type'" == "xb2" { 
		gen `vtyp' `varn' = `zg'
		label var `varn' "Linear prediction of `dep2'"
		exit
	}

		/* Step 9:
			handle switch options that can be used in-sample only.
			Same comments as for step 8.
		*/


			/* Step 10.
				Issue r(198), syntax error.
				The user specified more than one option
			*/
	error 198
end

