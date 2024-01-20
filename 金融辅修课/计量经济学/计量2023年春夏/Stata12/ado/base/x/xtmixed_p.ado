*! version 3.2.2  17jun2011
program xtmixed_p, eclass
	version 9

	local cmdline `"`e(cmdline)'"'
	cap noi xtmixed_p_u `0'
	local rc = _rc
	cap drop ___uu*
	ereturn local cmdline `"`cmdline'"'
	exit `rc'
end

program xtmixed_p_u
	syntax [anything(name=vlist)] [if] [in] ///
				[, FITted xb stdp Level(string) REFfects ///
			           SCores Residuals RSTAndard RESEs]

	local k = ("`fitted'"!="") + ("`xb'"!="") + ("`stdp'"!="") + ///
		  ("`reffects'"!="") + ("`residuals'"!="") + ///
                  ("`rstandard'"!="") + ("`reses'"!="")
	if `k' > 1 {
		di as err "{p 0 4 2}only one of xb, stdp, fitted, reffects, " 
		di as err "reses, scores, residuals, or rstandard should be "
		di as err "specified{p_end}"
		exit 198
	}

	if `"`scores'"' != "" {
		GenScores `0'
		exit
	}

	local type "`fitted'`xb'`stdp'`reffects'`residuals'`rstandard'`reses'"
	
	if "`type'" == "reses" {
		if "`e(vcetype)'" == "Robust" {
			di as err "{p 0 4 2}reses not available after "
			di as err "robust variance estimation{p_end}"
			exit 498
		}
		local type reffects
		local reffects reffects
		local reise reise
	}

	if `"`level'"' != "" {
		if `"`level'"' != "_all" {
			if `:word count `level'' > 1 {
			    di as err "{p 0 4 2}invalid level() specification"
			    di as err "{p_end}"
			    exit 198
			}
			unab level : `level'
		}
		if "`type'" == "" | "`type'" == "xb" | "`type'" == "stdp" {
			di as err "{p 0 4 2}level() not allowed with `type'"	
			di as err "{p_end}"
			exit 198
		}
		local ivars `e(ivars)'
		if `:list posof `"`level'"' in local ivars' == 0 {
			di as err `"{p 0 4 2}`level' is not a level variable "'
			di as err "in this model{p_end}"
			exit 198
		}
	}

	if "`type'" == "reffects" {
		ParseRE `"`vlist'"' `level'
		local varn `s(varlist)'		
		local vtyp `s(typlist)'
	}
	else {
		local 0 `vlist' `if' `in'
		syntax [newvarname] [if] [in]
		local varn `varlist'
		local vtyp `typlist'
	}

	marksample touse, novarlist
	tempvar t 
	if "`type'" == "" | "`type'" == "xb" {
		if "`type'" == "" {
			di as txt "(option xb assumed)"
		}
		if !`e(k_f)' {
			qui gen double `t' = 0 if `touse' 
		}
		else {
			qui _predict double `t' if `touse'
		}
		gen `vtyp' `varn' = `t' if `touse'
		label var `varn' "Linear prediction, fixed portion"
		exit
	}
	if "`type'" == "stdp" {
		if !`e(k_f)' {
			qui gen double `t' = 0 if `touse' 
		}
		else {
			qui _predict double `t' if `touse', stdp
		}
		gen `vtyp' `varn' = `t' if `touse'
		label var `varn' "S.E. of the linear prediction, fixed portion"
		exit
	}

	// at this point we need blups, and for that we need to 
        // reconstruct the model from e()

	if "`e(ivars)'" != "" {      // no random effects, no blups
		ConstCommand
		local command `s(command)'
		BlupList "`reffects'" "`level'"	
		local blupoption `s(blupoption)' `reise'
	
		tempname ehold
		version 11: _est hold `ehold', copy restore
		qui `command' `blupoption'   // re-run xtmixed to get blups
		version 11: _est unhold `ehold'

		cap assert `touse' == e(sample) 
		if _rc {
			MapBlups `touse'     // map blups to out-of-sample
		}
	}

	cap unab uvars : ___uu*
	if "`reffects'" != "" {		       // done
		if "`reise'" != "" {
			local mult *exp([lnsig_e]_cons)
		}
		foreach v of local varn {
			gettoken typ vtyp : vtyp
			gettoken u uvars : uvars
			gen `typ' `v' = `u'`mult' if `touse'
			label var `v' `"`:var label `u''"'
		}
		exit
	}	

	// Get linear predictor/fixed portion.  You need for the whole
	// sample (plus any out of sample) since we might be standardizing them

	if !`e(k_f)' {
		qui gen double `t' = 0 if `touse' | e(sample)
	}
	else {
		qui _predict double `t' if `touse' | e(sample)
	}

	// take blups and score them with the variables in the data

	if "`uvars'" != "" {
		foreach u of varlist `uvars' {
			local lab : var label `u'
			local z : word 5 of `lab'
			if "`z'" == "_cons" | substr("`z'",1,2) == "R." {
				local z 1	
			}
			qui replace `t' = `t' + `u'*`z' if `touse' | e(sample)
		}
	}

	if "`type'" == "fitted" {
		gen `vtyp' `varn' = `t' if `touse'
		local vlab Fitted values: xb + Zu
		if "`level'" != "" {
			local vlab `vlab', level(`level')
		}
		label var `varn' "`vlab'"
		exit
	}

	if "`type'" == "residuals" | "`type'" == "rstandard" {
		qui replace `t' = `e(depvar)' - `t' if `touse' | e(sample)
		if "`type'" == "rstandard" {
			Standardize `t' 
			qui replace `t' = `t'*exp(-[lnsig_e]_cons) ///
				if `touse' | e(sample)
			local vlab Standardized residuals
			local andesample & e(sample)
		}
		else {
			local vlab Residuals
		}
		gen `vtyp' `varn' = `t' if `touse' `andesample'
		if "`level'" != "" {
			local vlab `vlab', level(`level')
		}
		label var `varn' "`vlab'"
		exit
	}

	di as err "predict type `type' not allowed"
	exit 198
end

program MapBlups, sort
	args touse

	cap unab uvars : ___uu*
	if _rc {			// You have no random effects
		exit
	}
	tempvar id one
	
	qui gen byte `one' = 1 

	local ivars `e(ivars)'
	local ivars : list uniq ivars
	local ivars : subinstr local ivars "_all" "`one'", all
	qui egen long `id' = group(`ivars') 

	foreach v of varlist `uvars' {
		local lab : var label `v'
		local name : word 5 of `lab'
		local fvar
		if substr("`name'",1,2) == "R." { 	// factor variable
			local fvar = substr("`name'",3,length("`name'"))	
		}
		qui sort `id' `fvar' `v'
		qui by `id' `fvar':replace `v' = `v'[1] if `touse'
	}
end

program BlupList, sclass
	args blup level

	local ivars `e(ivars)'	
	local ivars : list uniq ivars
	local k : word count `ivars' 
	if !`k' {			        // model is linear regression
		exit
	}
	if "`level'" == "" {		// wants them all
		forval i = 1/`k' {
			local gr : word `i' of `ivars'
			local opt `opt' `gr' ___uu`i'
		}		
	}
	else {				// specific level
		if "`blup'" != "" {
			local opt `level' ___uu1
		}
		else {
			local i 1
			gettoken gr ivars : ivars
			while "`gr'" != "`level'" {
				local opt `opt' `gr' ___uu`i'
				local ++i
				gettoken gr ivars : ivars
			}	
			local opt `opt' `level' ___uu`i'
		}
	}
	sreturn local blupoption `"getblups(`opt')"'
end

program ConstCommand, sclass
	local command xtmixed `e(depvar)'
	
	// fixed parameters
	
	if "`e(wtype)'" != "" {
		local wtopt `"[`e(wtype)'`e(wexp)']"'
	}

	local colnames : colnames e(b)
	local nf = `e(k_f)'
	if !`nf' {
		local command `"`command' `wtopt', nocons||"'
	}
	else {
		if `"`:word `nf' of `colnames''"' != "_cons" {
			local nocons nocons
		}
		local feq `:subinstr local colnames "_cons" "", all'
		local command `"`command' `feq' `wtopt',`nocons'||"'
	}

	// random equations, one by one

	local revars `e(revars)'
	local nlev : word count `e(ivars)'
	local wtc 0
	local wtinc 0
	forvalues i = 1/`nlev' {
		local level : word `i' of `e(ivars)'
		if "`oldlevel'" != "`level'" {
			local wtinc 1
			local ++wtc
		}
		local command `"`command'`level':"'
		local nz : word `i' of `e(redim)'
		local vars
		forvalues j = 1/`nz' {
			gettoken token revars : revars
			local vars `vars' `token'
		}	
		local nocons
		if `"`vars'"' == "" {
			local nocons nocons
		}
		else {
			if `"`:word `nz' of `vars''"' != "_cons" {
				local nocons nocons
			}
		}
		local req `:subinstr local vars "_cons" "", all'
		local command `"`command'`req',`nocons'"'
		local vtype = lower("`:word `i' of `e(vartypes)''")
		local command `"`command' cov(`vtype') "'
		if `wtinc' {
			local command `"`command' fweight(`e(fweight`wtc')')"'
			local command `"`command' pweight(`e(pweight`wtc')')"'
			local wtinc 0
		}
		local command `"`command'||"'
		local oldlevel `level'
	}
	local method = lower("`e(method)'")
	local command `"`command' if e(sample), `method' `e(optmetric)'"'
	// Residual variance structure
	if "`e(rstructure)'" != "" {
	    local resopt `"residuals(`e(resopt)')"'
	}
	local command `"`command' `resopt'"'
	if "`e(pwscale)'" != "" {
		local command `"`command' pwscale(`e(pwscale)')"'
	}
	sreturn local command `command'
end

program ParseRE, sclass
	args vlist level

	local nvars 0
	local w : word count `e(redim)'
	forvalues i = 1/`w' {
		if "`level'"=="" | "`:word `i' of `e(ivars)''" == "`level'" {
			local nvars = `nvars' + `:word `i' of `e(redim)''
		}
	}
	if !`nvars' {
		di as err "{p 0 4 2}random-effects equation(s) empty; "
		di as err "BLUPs of random effects not available{p_end}"
		exit 459
	}
	
	if substr(`"`vlist'"',-1,1) == "*" {
		local nargs : word count `vlist'
		if `nargs' != 1 {
			if `nargs' == 2 {
				tokenize `vlist'
				args type vlist
			}
			else {
				di as err "too many variables specified"
				exit 103
			}
		}
		else    {
			local type `c(type)'
		}
		local vlist = substr("`vlist'",1,length("`vlist'")-1)
		local varlist
		local typlist
		forvalues i = 1/`nvars' {
			local varlist `varlist' `vlist'`i'
			local typlist `typlist' `type'	
		}
		confirm new variable `varlist'
	}
	else { 			// user specifies his own variables
		local 0 `"`vlist'"'
		cap noi syntax newvarlist(min=`nvars' max=`nvars')
		local rc = c(rc)
		if `rc' {
			if `rc' == 102 | `rc' == 103 {
				di as err "{p 0 4 2}you must specify `nvars' "
				di as err "new variable(s){p_end}"	
			}
			exit `rc'
		}
	}
	sreturn local varlist `varlist'
	sreturn local typlist `typlist'	
end

program Standardize, sortpreserve
	args residual 
	if ("`e(rstructure)'" == "independent") & (`e(nrgroups)'==1) {
		exit
	}
	ConstCommand
	local command `s(command)'
	tempname ehold
	version 11: _est hold `ehold', copy restore
	qui `command' standardize(`residual')
	version 11: _est unhold `ehold'
end

program GenScores
	version 10
	syntax [anything] [if] [in] [, *]
	marksample touse

	tempname b
	mat `b' = e(b) 
	forval i = 1/`=colsof(`b')' {
		local ceq `ceq' `i'
	}
	mat coleq `b' = `ceq'

	_score_spec `anything', b(`b')
	local varn `s(varlist)'
	local vtype `s(typlist)'

	local w : word count `varn'

	if `w' != e(k) {
		local 0 `"`varn'"'
		cap noi syntax newvarlist(min=`e(k)' max=`e(k)')
		local rc = c(rc)
		if `rc' {
			if `rc' == 102 | `rc' == 103 {
				di as err "{p 0 4 2}you must specify `e(k)' "
				di as err "new variable(s){p_end}"
			}
			exit `rc'
		}
	}

	ConstCommand
	local command `s(command)'
	qui `command' getscores(___uu)	
	local w : word count `varn'
	forval i = 1/`w' {
		local vname : word `i' of `varn'
		local vvtype : word `i' of `vtype'
		local label : variable label ___uu`i'
		gen `vvtype' `vname' = ___uu`i' if `touse'
		qui label variable `vname' `"`label'"'
	}
end

