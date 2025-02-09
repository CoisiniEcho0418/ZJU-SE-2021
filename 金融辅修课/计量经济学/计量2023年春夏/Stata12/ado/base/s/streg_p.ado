*! version 1.0.0  11dec2008
program streg_p, sort
	version 11

	if `"`e(cmd2)'"' != "streg" {
		error 301
	}

	syntax [anything] [if] [in] [, SCores *]
	if "`scores'" != "" {
		`e(predict_sub)' `0'
		exit
	}

	local csnellopt = cond(_caller() < 11, "CSnell", "CSNell")

	syntax newvarname [if] [in] [, TIME		///
				       LNTime		///
				       HAzard		///
				       HR		///
				       XB		///
				       Index		///
				       STDP		///
				       Surv		///
				       CSUrv		///
				       `csnellopt'	///
				       CCSnell		/// 
				       MGale		///
				       CMGale		///
				       DEViance		///
				       PARTial		///
				       MEDian		///
				       MEAN		///
				       noOFFset		///
				       ALPHA1		///
				       UNCONDitional	///
				       OOS		]

	local type "`time' `lntime' `hazard' `hr' `xb' `index' `stdp'"
	local type "`type' `surv' `csurv' `csnell' `ccsnell'"
	local type "`type' `mgale' `cmgale' `deviance'"

	if `:word count `type'' > 1 {
		di as err "{p 0 4 2}only one of "
		di as inp "`: list uniq type' "
		di as err "may be specified{p_end}"
		exit 198
	}
	local type : word 1 of `type'

	if !inlist("`type'", "", "time", "lntime") {
		if "`mean'`median'" != "" {
			di as err "{p 0 4 2}options mean and median not "
			di as err "allowed for this prediction type{p_end}"
			exit 198
		}
	}

	if "`alpha1'`unconditional'" != "" {
		if "`e(fr_title)'" == "" {
			di as err "{p 0 4 2}options alpha1 and unconditional "
			di as err "are allowed only with frailty models{p_end}"
			exit 198
		}
	}

	if inlist("`type'", "csnell",  ///
			    "mgale",   ///
			    "ccsnell", ///
			    "cmgale",  ///
			    "deviance") & "`e(prefix)'" == "svy" {
		di as err "{p 0 4 2}option `type' not allowed after svy "
		di as err "estimation{p_end}"
		exit 322
	}

	if _caller() < 11 {			// version control
		if inlist("`type'", "mgale", "csnell") {
			local partial partial
		}
	}

	if inlist("`type'", "mgale", "csnell", "deviance") {
		if "`partial'" == "" {
			local type c`type'
		}
	} 
	else if "`partial'" != "" {
		di as err "{p 0 4 2}option partial not allowed{p_end}"
		exit 198
	}

	if "`oos'" != "" {
		if !inlist("`type'", "cdeviance", "csurv", "ccsnell",   ///
		                     "cmgale") {
			di as txt "{p 0 4 2}warning: option oos ignored; "
			di as txt "out-of-sample predictions are always "
			di as txt "allowed for this prediction type{p_end}"
			local oos
		}
	}

	if "`type'" == "deviance" { 		// calculate partial deviances
		FrailtyWarn, `alpha1' `unconditional'
		tempvar mg
		qui predict double `mg' `if' `in', mgale partial `offset' ///
				   `alpha1' `unconditional' 
		gen `typlist' `varlist' = sign(`mg')* 			///
		       sqrt(-2*(`mg' + (_d!=0)*(ln((_d!=0)-`mg')))) `if' `in'
		ReLabel `varlist', type(deviance)
		exit
	}

	if "`type'" == "cdeviance" {
		local ptype deviance		// just use old code
	}
	else {
		local ptype `type'
	}

	// I'll let the old predicts go to work now
	
	local vv : display string(_caller())
	version `vv', missing: `e(predict_sub)' `typlist' `varlist' ///
	                       `if' `in', `ptype' `offset' `alpha1' ///
			       `unconditional' `oos' `median' `mean'

	if inlist("`type'", "mgale", "csnell", "deviance", ///
			    "cmgale", "ccsnell", "cdeviance") {
		ReLabel `varlist', type(`type')
	}
end

program ReLabel
	syntax varname, type(string)

	if inlist("`type'", "mgale", "csnell", "deviance") {
		if "`_dta[st_id]'" != "" {
			local partial "partial "
		}
	}
	if inlist("`type'", "mgale", "cmgale") {
		local lab `partial'martingale-like residual
	}
	if inlist("`type'", "csnell", "ccsnell") {
		local lab `partial'Cox-Snell residual
	}
	if inlist("`type'", "deviance", "cdeviance") {
		local lab `partial'deviance residual
	}
	label var `varlist' "`lab'"
end

program FrailtyWarn
	syntax [, ALPHA1 UNCONDitional]

	if "`e(fr_title)'" == "" {
		exit
	}
        if "`alpha1'`unconditional'"=="" {
		if "`e(shared)'"!="" {
			local alpha1 alpha1
		}
		else {
			local unconditional unconditional
		}
	        di as txt "(option `alpha1'`unconditional' assumed)"
	}
end

exit
