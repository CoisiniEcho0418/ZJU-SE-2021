*! version 1.7.6  21jun2011
program define xtreg, eclass byable(recall) sort prop(xt mi)
	version 6, missing
	local version : di "version " string(_caller()) ", missing:"

	if replay() {
		if `"`e(cmd)'"'==`"xtreg"' {
			if _by() { error 190 }
			xtreg_`e(model)' `0'
			exit `e(rc)'
		}
		else if `"`e(cmd2)'"' == "xtreg" {
			if _by() { error 190 }
			`e(cmd)' `0'
			exit `e(rc)'
		}
		error 301
		/*NOTREACHED*/
	}
	
	syntax varlist(fv ts) [if] [in] [aw fw pw iw] [,	///
		I(varname) BE FE RE MLE PA GEE		///
		VCE(passthru)				///
		*					///
	]
	
	gettoken depvar rest: varlist
	_fv_check_depvar `depvar'
	
	local cmdline : copy local 0
	if ("`be'"!="") + ("`fe'"!="") + ("`re'"!="") + ("`pa'"!="") + 	///
		("`gee'"!="")>1 { 
		di in red "choose only one of be, fe, re, or pa"
		exit 198 
	}

	if "`be'`re'" != "" & "`weight'" != "" {
		di in red "`weight' not allowed with between-effects and " ///
		   in red "random-effects models"
		exit 101
	}
	if "`fe'" != "" & "`weight'"=="iweight" {
		di in red "`weight' not allowed with fixed-effects models" 
		exit 101
	}
	if "`mle'" != "" & ("`weight'"=="pweight" | ///
	  "`weight'"=="aweight" | "`weight'"=="fweight") {
		di in red "`weight' not allowed with maximum-likelihood " ///
		   in red "random-effects models"
		exit 101
	}
	if "`pa'`gee'" != "" & "`weight'"=="aweight" {
		di in red "`weight' not allowed with population-averaged " ///
		   in red "model"
		exit 101
	}
	
	local fvops = "`s(fvops)'" == "true" | _caller() >= 11

	if _by() & `"`vce'"' != "" {
		di as err "the by prefix may not be used with vce() option"
		exit 198
	}
	if `"`vce'"' != "" {
		local options `"`options' `vce'"'
	}
	marksample touse

	if "`gee'" != "" { local pa "pa " }

	if `"`be'"'!=`""' | `"`fe'"'!=`""' { 
		if `"`mle'"'!=`""' | `"`pa'"'!=`""' { error 198 } 
	}
	else {
		if `"`mle'"'!=`""' & `"`pa'"'!=`""' { error 198 }
	}

	if "`be'"=="" & "`fe'"=="" & "`re'"=="" & "`pa'"=="" ///
		& "`gee'"=="" & "`mle'"=="" {
		local re = "re"
	}
					/* check collinearity */
	_xt, i(`i')
	local ivar "`r(ivar)'"
	if subinword("`varlist'","`ivar'","",.) != "`varlist'" {
			di as err "the panel variable `ivar' may not be " /*
			*/ as err "included as an independent variable"
			exit 198
		}
	if `fvops' {
		local rmcoll "version 11: _rmcoll"
		local fvexp expand
	}
	else	local rmcoll _rmcoll
	qui `rmcoll' `varlist', `fvexp'
	local retlist `"`r(varlist)'"'

	tempvar ivar2
	qui sum `ivar'
	qui gen double `ivar2' = (`ivar'-r(mean))/r(sd)
	local retlist `retlist' `ivar2'
	qui `rmcoll' `retlist', `fvexp'
	if !`fvops' {
		if "`r(varlist)'" ~= "`retlist'" {
			di as err "independent variables " _c
			di as err "are collinear with the panel variable" _c
			di as err " `ivar'"
			exit 198
		}
	}

	local options `options' i(`i')

	if "`weight'" == "aweight" & `"`fe'"' == "" {
		di in red "aweight not allowed"
		exit 101
	}

	if `"`be'"'!=`""' {
		if "`weight'" != "" {
			di in red "`weight' not allowed with be model"
			exit 101
		}
		`version' ///
		xtreg_be `varlist' if `touse' /* [`weight'`exp'] */, ///
			be `options'
	}
	else if `"`fe'"'!=`""' {
		if "`weight'" == "iweight"  {
			di in red "`weight' not allowed with fe model"
			exit 101
		}
		`version' ///
		xtreg_fe `varlist' if `touse' [`weight'`exp'] ,	///
			fe `options'
	}
	else {
		if `"`mle'"' == `""'  & `"`pa'"' == `""' {
			if "`weight'" != "" {
				di in red "`weight' not allowed with re model"
				exit 101
			}
			`version' ///
			xtreg_re `varlist' if `touse' ///
				/* [`weight'`exp']*/ , re `options'
			version 10: ereturn local cmdline `"xtreg `cmdline'"'
			exit
		}
		if `"`mle'"' == `""' {
			`version' ///
			xtgee `varlist' if `touse' [`weight'`exp'], ///
				`options'
			est local predict xtreg_pa_p
			est local estat_cmd ""	// reset from xtgee
			est local cmd2 "xtreg"
			est local model "pa"
			version 10: ereturn local cmdline `"xtreg `cmdline'"'
			exit
		}
		else {
			`version' ///
			xtreg_ml `varlist' if `touse' [`weight'`exp'], ///
				 mle `options'
		}
	}
	version 10: ereturn local cmdline `"xtreg `cmdline'"'
	exit `e(rc)'
end
