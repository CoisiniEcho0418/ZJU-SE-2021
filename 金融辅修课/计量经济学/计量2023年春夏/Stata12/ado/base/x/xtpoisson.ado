*! version 3.4.17  16mar2011
program define xtpoisson, eclass byable(onecall) prop(irr xt mi)
        local vv : display "version " string(_caller()) ", missing:"
	global XT_CL : di string(_caller())
	version 6, missing
	if replay() {
		if "`e(cmd)'"!="xtpoisson" & "`e(cmd2)'"!="xtpoisson" {
			error 301
		}
		if _by() {
			error 190
		}
		if "`e(distrib)'"=="Gaussian" {
			xtps_ren `0'
			macro drop XT_CL
			exit
		}
		if "`e(cmd)'" == "xtgee" {
			syntax [, IRr EForm Level(cilevel) *]
			if "`irr'"!="" {
				local eform "eform"
			}
			xtgee , `eform' level(`level') `options'
			macro drop XT_CL
			exit
		}
		Display `0'
		error `e(rc)'
		macro drop XT_CL
		exit
	}

	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`vv' `by' _vce_parserun xtpoisson, panel mark(I Exposure OFFset) : `0'
	if "`s(exit)'" != "" {
		version 10: ereturn local cmdline `"xtpoisson `0'"'
		macro drop XT_CL
		exit
	}
	nobreak {
		capture noisily break {
			`vv' `by' Estimate `0'
		}
		macro drop S_XT*
		macro drop XT_CL
		version 10: ereturn local cmdline `"xtpoisson `0'"'
		exit _rc
	}
end

program define Estimate, eclass byable(recall) sort
	version 6, missing
	syntax varlist(numeric ts fv) [if] [in] [iweight fweight pweight] /*
	*/ [, I(varname num) RE FE PA IRr EForm noCONstant noSKIP /*
	*/ noDIFficult Exposure(varname num) OFFset(varname num) /*
	*/ vce(passthru) Robust CLuster(passthru) /*
	*/ FROM(string) Level(cilevel) noLOg GAUSSian NORMAL * ]

	local fvops = "`s(fvops)'" == "true" | _caller() >= 11
	local tsops = "`s(tsops)'" == "true"
	if `fvops' {
		if _caller() < 11 {
			local vv "version 11:"
		}
		else {
			local vv : di "version " string(_caller()) ":"
		}
		local negh negh
		local fvexp expand
	}
	else {
		local vv "version 8.1:"
	}

	if length("`fe'`re'`pa'") > 2 {
		di in red "choose one of re, fe, or pa"
		macro drop XT_CL
		exit 198
	}

/* Mark sample except for offset/exposure. */

	marksample touse
	_xt, i(`i')
	local ivar "`r(ivar)'"
	markout `touse' `ivar' /* iis does not allow string */


	if "`normal'"!="" | "`gaussia'"!="" {
		syntax varlist(fv) [if] [in] [iweight fweight pweight] [, ///
		INTPoints(int 12) Quad(int 12) *]
		if "`weight'"!="" {
			local weight "[`weight'`exp']"
		}

		/* version 6 so local macros restricted to 7 characters */
		if `intpoin' != 12 {
			if `quad' != 12 {
				di as err "intpoints() and quad() may not be specified together."
				macro drop XT_CL
				exit(198)
			}
			local options `options' quad(`intpoin')
		}
		else {
			local options `options' quad(`quad')
		}
		if $XT_CL < 9 {
			xtps_ren_8 `varlist' `weight' if `touse', 	///
			`options'
			macro drop XT_CL
			exit
		}
		`vv' ///
		xtps_ren `varlist' `weight' if `touse', `options' call($XT_CL)
		macro drop XT_CL
		exit
	}

	if "`pa'"!="" {
		if "`i'"!="" {
			local iarg "i(`i')"
		}
		if "`offset'"!="" {
			local offset "offset(`offset')"
		}
		if "`exposur'"!="" {
			local exposur "exposure(`exposur')"
		}
		if `"`from'"' != "" {
			local farg "from(`from')"
		}
		if "`irr'"!="" {
			local eform "eform"
		}
		xtgee `varlist' if `touse' [`weight'`exp'], /*
		*/ fam(poisson) link(log) rc0 level(`level') /*
		*/ `farg' `iarg' `constan' `offset' `exposur' /*
		*/ `eform' `options' `log' `vce' `robust' `cluster'
		est local predict xtpoisson_pa_p
		if e(rc) == 0 | e(rc) == 430 {
			est local estat_cmd ""	// reset from xtgee
			est local cmd2 "xtpoisson"
		}
		error `e(rc)'
		macro drop XT_CL
		exit
	}

	if `"`vce'`robust'`cluster'"' != "" {
		if "`fe'"=="fe" {
			_vce_parse, opt(OIM Robust) old			///
				: [`weight'`exp'], `vce' `robust' `cluster'
			local robust `r(robust)'
		}
		else {  // "re"
			_vce_parse, opt(OIM) old			///
			: [`weight'`exp'], `vce' `robust' `cluster'
		}
	}

/* If here, we are doing re (default) or fe. */

	if "`fe'`re'"=="" { local re "re" }

/* Check syntax and set options. */

	_get_diopts diopts options, `options'
	mlopts mlopts, `options'
	local coll `s(collinear)'

	local nvar : word count `varlist'"

	if "`weight'"=="fweight" | "`weight'"=="pweight" {
		di in red /*
		*/ "`weight' not allowed with fixed- and random-effects models"
		macro drop XT_CL
		exit 101
	}
	if "`offset'"!="" & "`exposur'"!="" {
		di in red "only one of offset() or exposure() can be specified"
		macro drop XT_CL
		exit 198
	}
	if "`fe'"!="" {
		if `nvar' == 1 {
			di in red "independent variables required with " /*
			*/ "fixed-effects model"
			macro drop XT_CL
			exit 102
		}
		if "`constan'"!="" {
			di in gr "note: noconstant option ignored"
			local constan /* erase macro (for _rmcoll) */
		}
		if "`skip'"!="" {
			di in gr /*
			*/ "note: noskip option ignored;" _n /*
			*/ "      cannot estimate a fixed-effects " /*
			*/ "constant-only model"
			local skip /* erase macro */
		}

		local title "Conditional fixed-effects Poisson regression"
		local prog  "xtps_fe"
	}
	else { /* re */
		if "`constan'"!="" & `nvar' == 1 {
			di in red "independent variables required with " /*
			*/ "noconstant option"
			macro drop XT_CL
			exit 102
		}

		local title "Random-effects Poisson regression"
		local prog  "xtps_lf"
		local distr "Gamma"
		local eqaux "/lnalpha"
	}
	if "`skip'"=="" | `"`from'"'!="" | "`constan'"!="" {
		local skip "skip"
	}
	else {
		local skip /* erase macro */
	}

	local difficu = cond("`difficu'"=="", "difficult", "")


/* Process offset/exposure. */

	if "`exposur'"!="" {
		capture assert `exposur' > 0 if `touse'
		if _rc {
			di in red "exposure() must be greater than zero"
			macro drop XT_CL
			exit 459
		}
		tempvar offset
		qui gen double `offset' = ln(`exposur')
		local offvar "ln(`exposur')"
	}

	if "`offset'"!="" {
		markout `touse' `offset'
		local offopt "offset(`offset')"
		if "`offvar'"=="" {
			local offvar "`offset'"
		}
	}

/* Count obs, check for negative values of `y', and compute mean. */

	gettoken y xvars : varlist
	_fv_check_depvar `y'

	local yname `y'
	local ystr : subinstr local yname "." "_"

	if `tsops' {
		tsrevar `y'
		local y `r(varlist)'
	}

	summarize `y' if `touse', meanonly

	if r(N) == 0 { error 2000 }
	if r(N) == 1 { error 2001 }

	if r(min) < 0 {
		di in red "`y' must be greater than or equal to zero"
		macro drop XT_CL
		exit 459
	}

	tempname mean
	scalar `mean' = r(mean)

/* Issue warning if `y' is not an integer. */

	capture assert `y' == int(`y') if `touse'
	if _rc {
		di in gr "note: you are responsible for " /*
		*/ "interpretation of non-count dep. variable"
	}

/* Sort. */

	tempvar nn
	qui gen long `nn' = _n
	sort `touse' `ivar' `nn' /* deterministic sort */

/* Check weights. */

	if "`weight'"!="" {
		tempvar w
		qui gen double `w' `exp'
		_crcchkw `ivar' `w' `touse'
		drop `w'
	}

/* For fe model, drop any groups with `y' all zeros or those of size 1. */

	if "`fe'"!="" {
		DropOne  `touse' `ivar' `nn' `y' `mean'
		DropZero `touse' `ivar' `nn' `y' `mean'
	}

/* Remove collinearity. */

	if `tsops' {
		qui tsset, noquery
	}
	`vv' _rmcoll `xvars' [`weight'`exp'] if `touse', ///
		`constan' `coll' `fvexp'
	local xvars `r(varlist)'
	local xvarsnm `xvars'

/* Drop any variables that are constant within group. */

	if "`fe'"!="" {
		DropVars `touse' `ivar' `xvars'
		local xvars `r(varlist)'
	}

	if "`fe'"!="" {
		local nvar : word count `xvars'
		if `nvar' == 0 {
			di in red "independent variables required with " /*
			*/ "fixed-effects model"
			macro drop XT_CL
			exit 102
		}
	}

	local oxvars : copy local xvars
	if `tsops' {
		fvrevar `xvars', tsonly
		local xvars `r(varlist)'
	}
	local p : list sizeof oxvars
	forval i = 1/`p' {
		gettoken x oxvars : oxvars
		local NAMES `NAMES' `yname':`x'
	}
	if "`re'" != "" {
		if "`constan'" == "" {
			local NAMES `NAMES' `yname':_cons
		}
		local NAMES `NAMES' lnalpha:_cons
	}

/* Get number of groups and group size min, mean, and max. */

	if `tsops' {
		sort `touse' `ivar' `nn'
	}
	drop `nn'
	tempvar T
	qui by `touse' `ivar': gen long `T' = _N if _n==1 & `touse'
	summarize `T' if `touse', meanonly
	local ng = r(N)
	local g1 = r(min)
	local g2 = r(mean)
	local g3 = r(max)

/* Fit comparison Poisson model for re model. */

	if "`log'"!="" { local qui "quietly" }

	if "`re'"!="" & `"`from'"'=="" {
		`qui' di in gr _n "Fitting Poisson model:"
		`vv' ///
		`qui' poisson `y' `xvars' if `touse' [`weight'`exp'], /*
		*/ `constan' `offopt' `mlopts' nodisplay
		tempname llp b0
		scalar `llp'  = e(ll)
		mat `b0' = e(b)
		local b0n : colfullnames `b0'
		local b0n : subinstr local b0n "`y'" "`ystr'", all
		local init0 "init(`b0', skip)"
	}

/* Set up global for use by likelihood program. */

	global S_XTby "`touse' `ivar'"

/* Fit constant-only model. */

	if "`re'"!="" & "`skip'"=="" {

	/* Get starting values for constant-only model. */

		if "`offset'"!="" {
			SolveC `y' `offset' [`weight'`exp'] if `touse', /*
			*/ mean(`mean')
			local c = r(_cons)
		}
		else	local c = ln(`mean')

		if `c'>=. { local c 0 }

		tempname b00
		mat `b00' = (`c', 0)
		mat colnames `b00' = `y':_cons lnalpha:_cons

		`qui' di _n in gr "Fitting constant-only model:"
		`vv' ///
		ml model d2 `prog' (`ystr': `y' = , `offopt') `eqaux' /*
		*/ if `touse' [`weight'`exp'], /*
		*/ collinear missing max nooutput nopreserve wald(0) /*
		*/ init(`b00') search(off) `mlopts' `log' `difficu' /*
		*/ nocnsnotes `negh'

		if "`xvars'"=="" { local init0 /* erase macro */ }

		local continu "continue"

		`qui' di in gr _n "Fitting full model:"
	}
	else if "`re'"!="" & `"`from'"'=="" {
		`qui' di in gr _n "Fitting full model:"
	}

/* Fit full model. */

	if `"`from'"'!="" { local init0 `"init(`from')"' }
	
	if "`fe'"!="" { 
		local constan "noconstant" 
		if "`robust'"=="robust" {
			local crtyp "log pseudolikelihood"
		}
	}

	`vv' ///
	ml model d2 `prog' (`ystr': `y' = `xvars', `constan' `offopt') `eqaux'/*
	*/ if `touse' [`weight'`exp'], /*
	*/ collinear missing max nooutput nopreserve `init0' search(off) /*
	*/ `mlopts' `log' `difficu' `continu' title(`title') `negh' /*
	*/ crittype(`crtyp')

/* get b and V */
	tempname b V
	matrix `b' = e(b)
	matrix `V' = e(V)

/* Robust var-cov matrix for fixed effects */

	if "`fe'"=="fe" & "`robust'"=="robust" {
		XTPOISSON_FE_ROBUST `y' if `touse' [`weight'`exp'], ivar(`ivar')
		est scalar chi2 = r(chi2)
		est scalar p = chi2tail(`e(df_m)',`r(chi2)')
		est hidden local crittype "log pseudolikelihood"
		est local vce "robust"
		est local vcetype "Robust"
		matrix `V' = r(V)
	}

/* Redi matrix strips on b and V, removing names of tempvars due to TS ops */
	`vv' mat colnames `b' = `NAMES'
	`vv' mat colnames `V' = `NAMES'
	`vv' mat rownames `V' = `NAMES'
	_ms_op_info `b'
	if r(tsops) {
		quietly tsset, noquery
	}
	est repost b = `b' V = `V', rename buildfvinfo
	est local depvar "`yname'"

	est local cmd

	if "`llp'"!="" {
		est local chi2_ct "LR"
		est scalar ll_c = `llp'
		if e(ll) < e(ll_c) {
			est scalar chi2_c = 0
		}
		else	est scalar chi2_c = 2*(e(ll)-e(ll_c))
	}

	est scalar N_g    = `ng'
	est scalar g_min  = `g1'
	est scalar g_avg  = `g2'
	est scalar g_max  = `g3'

	if "`re'"!="" {
		est scalar alpha = exp(_b[/lnalpha])
	}

	est local method  "ml"
	est local distrib "`distr'"
	est local ivar    "`ivar'"
	est local offset1 /* erase from ml */
	est local offset  "`offvar'"
	est local predict "xtpoisson_refe_p"
	if "`distr'" == "Gamma" {
		est scalar k_aux = 1
		est hidden local diparm1 lnalpha, exp label("alpha")
	}
	est local model "`fe'`pa'`re'"
	est local cmd	  "xtpoisson"

	Display , level(`level') `irr' `eform' `diopts'
	error `e(rc)'
	macro drop XT_CL
end

program define Display
	syntax [, Level(cilevel) IRr EForm *]
	if "`eform'"!="" { local irr "irr" }

	if "`irr'"!="" { local irr "eform(IRR)" }

	_get_diopts diopts, `options'
	_crcphdr
	if "`e(distrib)'"=="Gamma" { local plus "plus" }

	version 10: ///
	ml di, level(`level') `irr' nohead nofootnote `diopts' notest

	if "`e(distrib)'"=="Gamma" {
		Footnote
	}
	_prefix_footnote
end

program Footnote
	if e(chi2_c)>=. {
		macro drop XT_CL
		exit
	}
	tempname pval
	scalar `pval' =  chiprob(1, e(chi2_c))*0.5
	if e(chi2_c)==0 { scalar `pval'= 1 }
	if ((e(chi2_c) > 0.005) & (e(chi2_c)<1e4)) | (e(chi2_c)==0) {
		local fmt "%8.2f"
	}
	else    local fmt "%8.2e"
	di in green "Likelihood-ratio test of alpha=0: " _c
	di in green in smcl "{help j_chibar##|_new:chibar2(01) = }" /*
		*/ in ye `fmt' e(chi2_c) _c
	di in green " Prob>=chibar2 = " in ye %5.3f `pval'
end

program define NonNeg, rclass /* checks whether `y' >= 0 */
	args y touse

	summarize `y' if `touse', meanonly

	if r(N) == 0 { error 2000 }
	if r(N) == 1 { error 2001 }

	if r(min) < 0 {
		di in red "`y' must be greater than or equal to zero"
		macro drop XT_CL
		exit 459
	}

	ret scalar mean = r(mean)
end

program define DropOne /* drop groups of size one */
	args touse ivar nn y mean

	tempvar one
	qui by `touse' `ivar': gen byte `one' = (_N==1) if `touse'

	qui count if `one' & `touse'
	local ndrop `r(N)'

	if `ndrop' == 0 {
		macro drop XT_CL
		exit
	} /* no groups with all zeros */

	if `ndrop' > 1 { local s "s" }
	di in gr "note: `ndrop' group`s' " /*
	*/ "(`ndrop' obs) dropped because of only one obs per group"

	qui replace `touse' = 0 if `one' & `touse'

	sort `touse' `ivar' `nn' /* redo sort */

	summarize `y' if `touse', meanonly
	if r(N) == 0 { error 2000 }
	if r(N) == 1 { error 2001 }
	scalar `mean' = r(mean)
end

program define DropZero /* drop groups with all zero counts */
	args touse ivar nn y mean

	tempvar sumy
	qui by `touse' `ivar': gen double `sumy' = /*
	*/ cond(_n==_N, sum(`y'), .) if `touse'

	qui count if `sumy'==0
	local ngrp `r(N)'

	if `ngrp' == 0 {
		macro drop XT_CL
		exit
	} /* no groups with all zeros */

	qui by `touse' `ivar': replace `sumy' = `sumy'[_N] if `touse'

	qui count if `sumy'==0
	local ndrop `r(N)'

	if `ngrp' > 1 { local s "s" }
	di in gr "note: `ngrp' group`s' " /*
	*/ "(`ndrop' obs) dropped because of all zero outcomes"

	qui replace `touse' = 0 if `sumy'==0 & `touse'

	sort `touse' `ivar' `nn' /* redo sort */

	summarize `y' if `touse', meanonly
	if r(N) == 0 { error 2000 }
	if r(N) == 1 { error 2001 }
	scalar `mean' = r(mean)
end

program define DropVars, rclass
	args touse ivar
	local i 3
	while "``i''"!="" {
		_ms_parse_parts ``i''
		if r(type) == "variable" {
			if r(omit) {
				local `i'
				capture assert 0
			}
			else if "`r(ts_op)'" != "" {
				tsrevar ``i''
				local x = r(varlist)
				capture by `touse' `ivar': ///
					assert `x'==`x'[1] if `touse'
			}
			else {
				capture by `touse' `ivar': ///
					assert ``i''==``i''[1] if `touse'
			}
			if _rc == 0 {
				di in gr "note: ``i'' dropped " /*
				*/ "because it is constant within group"
				local `i'
			}
		}
		local varlist `varlist' ``i''

		local i = `i' + 1
	}

	ret local varlist `varlist'
end

program define SolveC, rclass /* modified from poisson.ado */
	gettoken y  0 : 0
	gettoken xb 0 : 0
	syntax [fw aw pw iw] [if] , Mean(string)
	if "`weight'"=="pweight" | "`weight'"=="iweight" {
		local weight "aweight"
	}
	summarize `xb' `if', meanonly
	if r(max) - r(min) > 2*709 { /* unavoidable exp() over/underflow */
		macro drop XT_CL
		exit /* r(_cons) >=. */
	}
	if r(max) > 709 | r(min) < -709  {
		tempname shift
		if r(max) > 709 { scalar `shift' =  709 - r(max) }
		else		  scalar `shift' = -709 - r(min)
		local shift "+`shift'"
	}
	tempvar expoff
	qui gen double `expoff' = exp(`xb'`shift') `if'
	summarize `expoff' [`weight'`exp'], meanonly
	return scalar _cons = ln(`mean')-ln(r(mean))`shift'
end

program define XTPOISSON_FE_ROBUST, rclass

	syntax name(name=y) 					///
		if [iweight],		 			///
		ivar(varname)

	tempvar mu mubar ybar score
	tempname V chi2

	mat `V' = e(V)

	sort `ivar'

	qui predict double `mu' `if', xb
	qui replace `mu' = exp(`mu') `if'
	qui egen double `mubar' = mean(`mu') `if', by(`ivar')
	qui egen double `ybar' = mean(`y') `if', by(`ivar')
	qui gen double `score' = `y' - `mu'*`ybar'/`mubar' `if'
	
	_robust `score' `if', v(`V') cluster(`ivar') minus(0)
	
	mat `chi2' = e(b)*syminv(`V')*e(b)'
	
	return scalar chi2 = trace(`chi2')
	return matrix V `V'
end

exit

Notes:

1.  Uses -difficult- optimizer by default.  Specify -nodifficult- to get
    standard optimizer.

2.  Skips the constant-only model by default.  Specify -noskip- to estimate
    constant-only model.

3.            Model                Starting values
    --------------------------     ----------------
    xtpoisson, fe (full model)     (0)
    xtpoisson, re (full model)     poisson and lnalpha = 0
    xtpoisson, re (constant only)  ln(mean) or SolveC with lnalpha = 0

<end of file>


