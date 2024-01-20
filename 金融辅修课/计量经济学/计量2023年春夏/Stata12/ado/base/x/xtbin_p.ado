*! version 1.0.4  30sep2004
program define xtbin_p 
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

	local myopts PU0 XB STDP 


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

	local type  `pu0'`xb'`stdp'
	local args


		/* Step 5:
			quickly process default case if you can 
			Do not forget -nooffset- option.
		*/


	local depname `e(depvar)'


	if "`type'"=="" | "`type'" == "xb" {
		if "`type'" == "" {
			di in gr "(option xb assumed; linear prediction)"
		}
		_predict `vtyp' `varn' `if' `in', xb `offset'
		exit
	}

	tempvar xb
	qui _predict double `xb' `if' `in', xb `offset'

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

				/* PU0 */
	if "`type'" == "pu0" {
		if "`e(cmd)'" == "xtprobit" {
			gen `vtyp' `varn' = normprob(`xb') if `touse'
		}
		else if "`e(cmd)'" == "xtlogit" {
			gen `vtyp' `varn' = 1 / (1+exp(-`xb')) if `touse'
		}
		else {	/* xtcloglog */
			gen `vtyp' `varn' = 1-exp(-exp(`xb')) if `touse'
		}
		label var `varn' "Pr(`depname'=1 assuming u_i=0)"
		exit
	}
				/* STDP: index standard error */
	if "`type'" == "stdp" { 
		_predict `vtyp' `varn', stdp `offset' `constan', /*
			*/ if `touse'
		label var `varn' "S.E. of prediction of `depname'"
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

