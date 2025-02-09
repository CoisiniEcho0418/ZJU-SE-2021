*! version 6.3.2  24jun2009
program define ereg_p, sort
	version 7, missing

	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		Getscore `0'
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
	local myopts /*
*/ "Index XB STDP Time LNTime HAzard HR Surv DEViance CSnell MGale CSUrv CCSnell CMgale OOS MEDian MEAN"


		/* Step 2:
			call _propts, exit if done, 
			else collect what was returned.
		*/
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
	if "`median'"~="" & "`mean'"~="" {
		di as err /*
		*/ "options median and mean may not be specified together"
		exit 198
	}
	if "`time'"~="" & "`lntime'"~="" {
		di as err /*
		*/ "options time and lntime may not be specified together"
		exit 198
	}
	local type /*
*/ "`xb'`index'`stdp'`time'`lntime'`hazard'`hr'`surv'`deviance'`csnell'`mgale'`csurv'`ccsnell'`cmgale'"

	local type2 "`type'`median'`mean'"

		/* Step 5:
			quickly process default case if you can 
			Do not forget -nooffset- option.
		*/

		/* Step 6:
			mark sample (this is not e(sample)).
		*/
	marksample touse

	if "`e(cmd2)'"=="stereg" | "`e(cmd2)'"=="streg" { 
		st_is 2 full
		local is_st yes
		local id `_dta[st_id]'
		local t  _t
		local t0 _t0
		local d  _d
		qui replace `touse' = 0 if _st==0
	}
	else {
		local t `e(depvar)'
		local t0 `e(t0)'
		local d `e(dead)'
	}
	
	if _caller() < 7 {
		if "`type'"==""	{
			local type="time"
			local mean="mean"
			local median
			di as txt "(option time assumed; predicted time)"
		}
		if "`type'"=="lntime"	{
			local type="lntime"
			local mean="mean"
			local median
		}
	}
	else {
		local flag 0
		if "`type'"==""         { local flag 1 }
		if "`type2'"=="median"   { local flag 2 }
		else if "`type2'"=="mean"     { local flag 3 }
		else if "`type2'"=="time"     { local flag 4 }
		else if "`type2'"=="lntime"   { local flag 5 }
		if `flag'==1 | 	`flag'==2 | `flag'==4 {
			local type="time"
			local median="median"
			di as txt /*
			*/ "(option median time assumed; predicted median time)"
		}
		else if `flag'==5 {
			local type="lntime"
			local median="median"
			di as txt /*
		*/ "(option log median time assumed; predicted median log time)"
		}
		else if `flag'==3 {
			local type="time"
			local median
			local mean="mean"
			di as txt /*
			*/ "(option mean time assumed; predicted mean time)"
		}
        } 
	local sgn = cond(e(frm2)=="time",1,-1)

	if "`e(prefix)'" == "svy" {
		if inlist("`type'", "csnell", "mgale", "deviance", ///
				    "ccsnell", "cmgale") {
			di as err "{p 0 4 2}option `type' not allowed after "
			di as err " svy estimation{p_end}"
			exit 322
		}
	}

	if "`type'"=="time" & "`median'"=="median" {
		if "`type'"=="" {
		}
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn'=ln(2)*exp(`sgn'*`xb') if `touse'
		label var `varn' "Predicted median `e(depvar)'"
		exit
	}
	if "`type'"=="xb" | "`type'"=="index" | "`type'"=="stdp" {
		_predict `vtyp' `varn' if `touse', `type' `offset'
		exit
	}
	if "`type'"=="time" & "`mean'"=="mean" {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn'=exp(`sgn'*`xb') if `touse'
		label var `varn' "Predicted mean `e(depvar)'"
		exit
	}
        if  "`type'"=="lntime" & "`mean'"~="" {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn'=`sgn'*`xb'  +digamma(1) if `touse'
		label var `varn' "Predicted mean log `e(depvar)'"
		exit
	}
	if "`type'"=="lntime" & "`median'"=="median" {
		tempvar elnt
		qui ereg_p double `elnt' if `touse', time median
		gen `vtyp' `varn'= ln(`elnt') if `touse'
		label var `varn' "Predicted median log `e(depvar)'"
		exit
	}
	if "`type'"=="hazard" {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn'=exp(-`sgn'*`xb') if `touse'
		label var `varn' "Predicted hazard"
		exit
	}

	if "`type'"=="hr" {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn'=exp(-`sgn'*(`xb'-_b[_cons])) if `touse'
		label var `varn' "Hazard ratio"
		exit
	}


	if "`type'" =="surv" {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn' = /*
			*/ exp( -exp(-`sgn'*`xb')*(`t'-`t0') ) /*
			*/ if `touse'
		if "`t0'"=="0" { 
			label var `varn' "S(`t')"
		}
		else	label var `varn' "S(`t'|`t0')"
		exit
	}

	if "`type'"=="csnell" {
		tempvar mg
		qui ereg_p double `mg' if `touse', mgale `offset'
		gen `vtyp' `varn' = (`d'!=0) - `mg' if `touse'
		if "`id'"!="" { local part "partial " }
		label var `varn' "`part'Cox-Snell residual"
		exit
	}

	if "`type'"=="mgale" { 
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		gen `vtyp' `varn' = (`d'!=0) - exp(-`sgn'*`xb')*(`t'-`t0') /*
		*/ if `touse'
		if "`id'"!="" { local part "partial " }
		label var `varn' "`part'Martingale-like resid."
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

	if "`is_st'"=="yes" {
		if "`type'"=="deviance" {
			tempvar cmg 
			qui ereg_p double `cmg' if `touse', cmgale `offset' /*
					*/ `oos'
			gen `vtyp' `varn' = sign(`cmg')*sqrt( /* 
			*/ -2*(`cmg' + (`d'!=0)*(ln((`d'!=0)-`cmg')))) /*
			*/ if `touse' 
			label var `varn' "deviance residual"
			exit
		}

		if "`oos'"=="" {
			tempvar es
			qui gen byte `es' = e(sample)
		}
		else	local es "`touse'"

		if "`type'"=="csurv" {
			if "`_dta[st_id]'" == "" {
				ereg_p `vtyp' `varn' if `touse' & `es', /*
				*/ surv `offset' 
				exit
			}
			tempvar surv
			qui ereg_p double `surv' if `es', surv `offset'
			sort `es' `_dta[st_id]' `t'
			qui by `es' `_dta[st_id]': replace /*
				*/ `surv'=`surv'*`surv'[_n-1] if _n>1 & `es'
			gen `vtyp' `varn' = `surv' if `touse' 
			label var `varn' "S(`t'|earliest `t0' for subj.)"
			exit
		}
		if "`type'"=="ccsnell" {
			if "`_dta[st_id]'" == "" {
				ereg_p `vtyp' `varn' if `touse' & `es', /*
				*/ csnell `offset' 
				exit
			}
			tempvar cs
			qui ereg_p double `cs' if `es', cs `offset'
			sort `es' `_dta[st_id]' `t'
			qui by `es' `_dta[st_id]': replace /*
				*/ `cs'=cond(_n==_N,sum(`cs'),.) if `es'
			gen `vtyp' `varn' = `cs' if `touse' 
			label var `varn' "cum. Cox-Snell residual"
			exit
		}
		if "`type'"=="cmgale" {
			if "`_dta[st_id]'" == "" {
				ereg_p `vtyp' `varn' if `touse' & `es', /*
				*/ mgale `offset' 
				exit
			}
			tempvar mg
			qui ereg_p double `mg' if `es', mg `offset'
			sort `es' `_dta[st_id]' `t'
			qui by `es' `_dta[st_id]': replace /*
				*/ `mg'=cond(_n==_N,sum(`mg'),.) if `es'
			gen `vtyp' `varn' = `mg' if `touse'
			label var `varn' "cum. Martingale-like resid."
			exit
		}
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

program Getscore /* score */
	version 9
	syntax [anything] [if] [in] [, SCores ]
	marksample touse, novarlist
	_score_spec `anything', `options'
	local varlist `s(varlist)'
	local typlist `s(typlist)'
	confirm variable `e(dead)'
	local d `e(dead)'
	if `"`e(t0)'"' != "" {
		tempvar realt
		quietly gen double `realt' = `e(depvar)' - `e(t0)' if `touse'
		capture assert `realt' >= 0 if `touse'
		if c(rc) {
			di as err `"`e(t0)' >= `e(depvar)' in some obs."'
			exit 459
		}
		quietly compress `realt'
		local t `realt'
	}
	else {
		confirm variable `e(depvar)'
		local t `e(depvar)'
	}
	if `"`options'"' != "" {
		local options `", `options'"'
	}
	if "`e(frm2)'" != "hazard" {
		local minus "-"
	}
	tempvar I
	quietly _predict double `I' if `touse'
	gen `typlist' `varlist' = `minus'(`d'-exp(`minus'`I')*`t') if `touse'
end
exit
