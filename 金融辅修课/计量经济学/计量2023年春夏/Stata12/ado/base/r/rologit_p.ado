*! version 1.0.1  08nov2002
program define rologit_p
	version 7

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

	local myopts "Pr dpdx(passthru)"

		/* Step 2:
			call _propts, exit if done,
			else collect what was returned.
		*/

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

	syntax [if] [in] [, `myopts' noOFFset]

		/* Step 4:
			Concatenate switch options together
		*/

	local type "`pr'`dpdx'"

		/* Step 5:
			quickly process default case if you can
			Do not forget -nooffset- option.
		*/

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

	if "`type'" == "" | "`type'" == "pr" {
		if "`type'" == "" {
			di as txt "(option pr assumed; conditional probability that alternative is ranked first)"
		}
		tempvar p
		GetP `p' if `touse' , `offset'
		gen `vtyp' `varn' = `p' if `touse'
		label var `varn' "prob that alternative is most attractive"
		exit
	}

	if substr("`type'",1,4) == "dpdx" {
		local 0 `", `dpdx'"'
		syntax , dpdx(varname)

		tempname b p
		capt scalar `b' = _b[`dpdx']
		if _rc {
			di as err "variable `varname' not included in rologit model"
			exit 198
		}
		GetP `p' if `touse' , `offset'
		gen `vtyp' `varn' = `p'*(1-`p')*`b' if `touse'
		label var `varn' "marginal effect of `varname'-self-"
		exit
	}

		/* Step 9:
			handle switch options that can be used in-sample only.
			Same comments as for step 8.
		*/
		* qui replace `touse'=0 if !e(sample)

		/* Step 10.
			Issue r(198), syntax error.
			The user specified more than one option
		*/

	error 198
end

program define GetP
	syntax newvarname if [, offset]

	marksample touse, novarlist
	tempvar xb denom

	qui _predict double `xb'  if `touse' , xb `offset'
	qui bys `touse' `e(group)': gen double `denom'   = sum(exp(`xb'))  if `touse'
	qui bys `touse' `e(group)': gen double `varlist' = exp(`xb')/`denom'[_N]  if `touse'
end

exit
