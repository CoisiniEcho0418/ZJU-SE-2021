*! version 1.0.3  25may2010
program define tpoisson_p
	version 11.0

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
	local myopts "N IR CM Pr(string) CPr(string) "

		/* Step 2:
			call _propts, exit if done,
			else collect what was returned.
		*/
	_pred_se "`myopts'" `0'
	if `s(done)'  exit
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
	local type "`n'`ir'`cm'"
	local args `"`pr'`cpr'"'
	if "`pr'" != "" {
		local propt pr(`pr')
	}

		/* Step 5:
			mark sample (this is not e(sample)).
		*/
	marksample touse

		/* Step 6:
			quickly process default case if you can
			Do not forget -nooffset- option.
		*/
	if ("`type'"=="" & `"`args'"'=="") | "`type'"=="n" {
		if "`type'"=="" {
			di in gr /*
			*/ "(option n assumed; predicted number of events)"
		}
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		qui gen `vtyp' `varn' = exp(`xb') if `touse'
		label var `varn' "Predicted number of events"
		exit
	}
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

	if "`type'"=="ir" {
		tempvar xb
		qui _predict double `xb' if `touse', xb nooffset
		qui gen `vtyp' `varn' =exp(`xb')  if `touse'
		label var `varn' "Predicted incidence rate"
		exit
	}

	if "`type'"=="cm" {
		tempvar xb d1 x m
		local ll `e(llopt)'
		local tp = e(llopt)
		if ("`ll'" != ""){
			cap confirm names `ll'
			if _rc {
			/* it is not a name, should be a number */
				cap confirm number `ll'
				if _rc{
					di as error
					"{cmd:ll(`ll')} must specify " ///
					"a nonnegative value"
					exit 200
				}
				else{
					local tp = `ll' + 1
					capture noisily
				}
			}
			else{
			/* ll() does not contain a number */
				cap confirm variable `ll'
				if _rc!=0 {
				/* ll() contains a name that is not a */
				/* variable.  possibly it is a scalar */
					local tp = `ll'
					cap confirm number `tp'
					if _rc!=0{
						di as error ///
						"{cmd:ll(`ll')} must " ///
						"specify a nonnegative value"
						exit 200
					}
				}
				else {
				/* ll() contains the name of a variable */
					qui summarize `ll' if `touse'
					if r(min) < 0 {
						di as error ///
						"{cmd:ll(`ll')} must " ///
						"contain all " ///
						"nonnegative values"
						exit 200
					}
					tempvar tp
					gen double `tp' = `ll' + 1
				}
			}
		}
		qui _predict double `xb' if `touse', xb `offset'
		qui gen double `d1'=poissontail(exp(`xb'), `tp') if `touse'
		qui gen `vtyp' `varn' = exp(`xb')/(`d1') if `touse'
		label var `varn' "Conditional mean of n > ll(`ll')"
		exit
	}
	local type `type'
	if `"`args'"'!="" {
		if "`type'" != "" {
			error 198
		}
		tpredict_p2 "`vtyp'" "`varn'" "`touse'" "`offset'" /*
			*/ "`pr'" "`cpr'"
		exit
	}
	error 198
end
