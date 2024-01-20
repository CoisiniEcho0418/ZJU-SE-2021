*! version 1.4.1  17jun2009
program define gamhet_gp, sort
	version 7, missing

	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		if "`e(shared)'" != "" {
			di as err ///
"option scores is not allowed with shared frailty"
			exit 322
		}
		marksample touse, novarlist
		confirm variable `e(dead)'
		global EREGd `e(dead)'
		confirm variable `e(depvar)'
		global EREGt `e(depvar)'
		confirm variable `e(t0)'
		global EREGt0 `e(t0)'
		ml score `0'
		macro drop EREG*
		exit
	}

	syntax newvarname [if] [in] [, ALPHA1 UNCONDitional *]
	local 0 `typlist' `varlist' `if' `in', `options'
	if "`alpha1'"!="" & "`unconditional'"!="" {
 		di as error /*
*/ "alpha1 and unconditional cannot be specified at the same time"
		exit 198
	}
	if "`alpha1'`unconditional'"=="" {
		if "`e(shared)'"!="" {local alpha1 alpha1}
		else {local unconditional unconditional}
local disclaim `"di as txt "(option `alpha1'`unconditional' assumed)""'
	}
	tempname theta kappa sigma
	scalar `theta' = exp(_b[/ln_the])
	scalar `kappa' = _b[/kappa]
	scalar `sigma' = exp(_b[/ln_sig])
	if "`alpha1'"!="" | `theta' < exp(-20) {
		`disclaim'
		gamma_p `0'
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
*/ "XB Index STDP Time LNTime HAzard HR Surv DEViance CSnell MGale CSUrv CCSnell CMgale OOS MEDian MEAN"

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
	if "`mean'"~="" {
		di as err /*
*/ "unconditional mean predictions for frailty models currently unavailable"
		exit 198
	}

	local type /*
*/ "`xb'`index'`stdp'`time'`lntime'`hazard'`hr'`surv'`deviance'`csnell'`mgale'`csurv'`ccsnell'`cmgale'"

		/* Step 5:
			quickly process default case if you can 
			Do not forget -nooffset- option.
		*/

		/* Step 6:
			mark sample (this is not e(sample)).
		*/

	marksample touse

	if "`e(cmd2)'"=="streg" { 
		st_is 2 full
		local is_st yes
		local id `_dta[st_id]'
		local t  `_dta[st_t]'
		local t0 `_dta[st_t0]'
		local d  `_dta[st_d]'
		qui replace `touse'=0 if _st==0
	}
	else {
		local t `e(depvar)'
		local t0 `e(t0)'
		local d `e(dead)'
	}

	if "`e(prefix)'" == "svy" {
		if inlist("`type'", "csnell", "mgale", "deviance", ///
				    "ccsnell", "cmgale") {
			di as err "{p 0 4 2}option `type' not allowed after "
			di as err " svy estimation{p_end}"
			exit 322
		}
	}
	`disclaim'

	if "`type'"=="" | "`type'"=="time" {
		if "`type'"=="" | "`median'"=="" {
			di as txt /*
			*/ "(option median time assumed; predicted median time)"
		}
		tempvar xb 
		qui _predict double `xb' if `touse', xb `offset'
		tempname cc ga 
		scalar `ga' = (`kappa')^(-2)
		scalar `cc' = 1-exp((1-(0.5)^(-`theta'))/`theta')
		if (`kappa'<0) {
			scalar `cc' = 1-`cc'
			local sgn "-"
		}
		scalar `cc' = invgammap(`ga',`cc')
		gen `vtyp' `varn'=exp(`sgn'sqrt(`ga')*`sigma'* /*
			*/ ln(`cc'/`ga') + `xb') if `touse'
		label var `varn' "Predicted median `e(depvar)'"
		exit
	}

	if "`type'"=="lntime" {
		if "`median'"=="" {
			di as txt /*
*/ "(option log median time assumed; predicted median log time)"
		}
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
		tempname cc ga 
		scalar `ga' = (`kappa')^(-2)
		scalar `cc' = 1-exp((1-(0.5)^(-`theta'))/`theta')
		if (`kappa'<0) {
			scalar `cc' = 1-`cc'
			local sgn "-"
		}
		scalar `cc' = invgammap(`ga',`cc')
		gen `vtyp' `varn'=(`sgn'sqrt(`ga')*`sigma'* /*
			*/ ln(`cc'/`ga') + `xb') if `touse'
		label var `varn' "Predicted median `e(depvar)'"
		exit
	}

	if "`median'"!="" {                 /* I've gone too far */
		di as err "median invalid"
		exit 198
	}

	if "`type'"=="xb" | "`type'"=="index" | "`type'"=="stdp" {
		_predict `vtyp' `varn' if `touse', `type' `offset'
		exit
	}

	if "`type'"=="hr" {
		di as err /*
*/ "Hazard ratios only available for those models with a natural"
		di as err /*
*/ "proportional-hazards parameterization"
		exit 498
	}

	if "`type'"=="hazard" {
		tempvar xb zz uu ii ff
		tempname ga
		qui _predict double `xb' if `touse', xb `offset'
		scalar `ga' = (`kappa')^(-2)
		qui gen double `zz' = (ln(`t')-`xb')/`sigma' if `touse'
		if (`kappa'<0) {
			qui replace `zz' = -`zz' if `touse'
		}
		qui gen double `uu' = `ga'*exp(`zz'/sqrt(`ga')) if `touse'
		qui gen double `ii' = gammap(`ga',`uu') if `touse'
		if (`kappa'>0) {
			qui replace `ii' = 1 - `ii' if `touse'
		}
		qui gen double `ff'= exp(-`uu')*`uu'^(`ga'-1)* /*
		*/ exp(-lngamma(`ga'))*`uu'/(sqrt(`ga')*`sigma'*`t') /*
		*/ if `touse'
		qui replace `ff'= `ff'/`ii' if `touse'
		qui replace `ff'=`ff'/(1-`theta'*ln(`ii')) if `touse'
		gen `vtyp' `varn'= `ff' if `touse'
		label var `varn' "Predicted hazard"
		exit
	}

	if "`type'" =="surv" {
		tempvar xb zz zz0 ii ii0 ff ff0
		tempname ga
		scalar `ga' = (`kappa')^(-2)
		qui _predict double `xb' if `touse', xb `offset'
		qui gen double `ff'= (ln(`t')-`xb')/`sigma' if `touse'
		qui gen double `ff0'=(ln(`t0')-`xb')/`sigma' /*
			*/ if `t0'>0 & `touse'
		if (`kappa'<0) {
			qui replace `ff' = -`ff' if `touse'
			qui replace `ff0' = -`ff0' if `t0'>0 & `touse'
		}
		qui replace `ff' = `ga'*exp(`ff'/sqrt(`ga')) if `touse'
		qui replace `ff0' = `ga'*exp(`ff0'/sqrt(`ga')) /*
			*/ if `t0'>0 & `touse'
		qui replace `ff' = gammap(`ga',`ff') if `touse'
		qui replace `ff0' = gammap(`ga',`ff0') if `t0'>0 & `touse'
		if (`kappa'>0) {
			qui replace `ff' = 1-`ff' if `touse'
			qui replace `ff0' = 1-`ff0' if `t0'>0 & `touse'
		}
		qui replace `ff' = (1-`theta'*ln(`ff'))^(-1/`theta') /*
			*/ if `touse'
		qui replace `ff0' = (1-`theta'*ln(`ff0'))^(-1/`theta')  /*
			*/ if `t0'>0 & `touse'
		qui replace `ff' = `ff'/`ff0' if `t0'>0 & `touse'
		gen `vtyp' `varn' = `ff' if `touse'
		if "`t0'"=="0" { 
			label var `varn' "S(`t')"
		}
		else	label var `varn' "S(`t'|`t0')"
		exit
	}

	if "`type'"=="csnell" {
		tempvar mg
		qui predict double `mg' if `touse', mgale `offset' uncond
		gen `vtyp' `varn' = (`d'!=0) - `mg' if `touse'
		if "`id'"!="" { local part "partial " }
		label var `varn' "`part'Cox-Snell residual"
		exit
	}

	if "`type'"=="mgale" { 
		tempvar xb ff ii ii0
		tempname ga
		scalar `ga' = (`kappa')^(-2)
		qui _predict double `xb' if `touse', xb `offset'
		qui gen double `ii'= (ln(`t')-`xb')/`sigma' if `touse'
		qui gen double `ii0'=(ln(`t0')-`xb')/`sigma' /*
			*/ if `t0'>0 & `touse'
		if (`kappa'<0) {
			qui replace `ii' = -`ii' if `touse'
			qui replace `ii0' = -`ii0' if `t0'>0 & `touse'
		}
		qui replace `ii' = `ga'*exp(`ii'/sqrt(`ga')) if `touse'
		qui replace `ii0' = `ga'*exp(`ii0'/sqrt(`ga')) /*
			*/ if `t0'>0 & `touse'
		qui replace `ii' = gammap(`ga',`ii') if `touse'
		qui replace `ii0' = gammap(`ga',`ii0') if `t0'>0 & `touse'
		if (`kappa'>0) {
			qui replace `ii' = 1-`ii' if `touse'
			qui replace `ii0' = 1-`ii0' if `t0'>0 & `touse'
		}
		qui gen double `ff'= /*
		*/ (`d'!=0)-(1/`theta')* /*
		*/ ln(1-`theta'*ln(`ii')) if `touse'
		qui replace /*
		*/ `ff'=`ff'+(1/`theta')* /*
		*/ ln(1-`theta'*ln(`ii0')) /*
		*/ if `t0'>0 & `touse'
		gen `vtyp' `varn' = `ff' if `touse' 
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
			qui predict double `cmg' if `touse', cmgale `offset' /*
				*/ `oos' uncond
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
				qui predict `vtyp' `varn' if `touse' & `es', /*
				*/ surv `offset' uncond
				exit
			}
			tempvar surv
			qui predict double `surv' if `es', surv `offset' uncond
			sort `es' `_dta[st_id]' `t'
			qui by `es' `_dta[st_id]': replace /*
				*/ `surv'=`surv'*`surv'[_n-1] if _n>1 & `es'
			gen `vtyp' `varn' = `surv' if `touse'
			label var `varn' "S(`t'|earliest `t0' for subj.)"
			exit
		}
		if "`type'"=="ccsnell" {
			if "`_dta[st_id]'" == "" {
				qui predict `vtyp' `varn' if `touse' & `es', /*
				*/ csnell `offset' uncond
				exit
			}
			tempvar cs
			qui predict double `cs' if `es', cs `offset' uncond
			sort `es' `_dta[st_id]' `t'
			qui by `es' `_dta[st_id]': replace /*
				*/ `cs'=cond(_n==_N,sum(`cs'),.) if `es'
			gen `vtyp' `varn' = `cs' if `touse'
			label var `varn' "cum. Cox-Snell residual"
			exit
		}
		if "`type'"=="cmgale" {
			if "`_dta[st_id]'" == "" {
				qui predict `vtyp' `varn' if `touse' & `es', /*
				*/ mgale `offset' uncond
				exit
			}
			tempvar mg
			qui predict double `mg' if `es', mg `offset' uncond
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
