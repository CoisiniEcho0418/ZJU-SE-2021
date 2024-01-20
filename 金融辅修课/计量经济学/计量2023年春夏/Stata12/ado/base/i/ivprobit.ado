*! version 1.6.1  25may2011

program define ivprobit, eclass byable(onecall) properties(svyb svyj svyr)
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	`BY' _vce_parserun ivprobit, unparfirsteq equal unequalfirsteq	///
		mark(CLuster) : `0'
	if "`s(exit)'" != "" {
		version 10: ereturn local cmdline `"ivprobit `0'"'
		exit
	}

	version 8.2

	if replay() {
		if "`e(cmd)'" != "ivprobit" {
			error 301
		}
		if _by() {
			error 190
		}
		if "`e(method)'" == "ml" {
			MLDisplay `0'
		}
		else {
			TSDisplay `0' 
		}
		exit
	}
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	`vv' `BY' Estimate `0'
	version 10: ereturn local cmdline `"ivprobit `0'"'
end

program define Estimate, eclass byable(recall) sortpreserve
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	version 8.2
	
	local n 0

	gettoken lhs rest : 0
	_fv_check_depvar `lhs'
	gettoken lhs 0 : 0, parse(" ,[") match(paren)
	IsStop `lhs'
	if `s(stop)' { 
		error 198 
	}  
	while `s(stop)'==0 {
		if "`paren'"=="(" {
			local n = `n' + 1
			if `n'>1 {
				capture noi error 198
di as error `"syntax is "(all instrumented variables = instrument variables)""'
				exit 198
			}
			gettoken p lhs : lhs, parse(" =")
			while "`p'"!="=" {
				if "`p'"=="" {
					capture noi error 198
di as error `"syntax is "(all instrumented variables = instrument variables)""'
di as error `"the equal sign "=" is required"'
					exit 198
				}
				local end`n' `end`n'' `p'
				gettoken p lhs : lhs, parse(" =")
			}
			fvunab end`n' : `end`n''
			fvunab exog`n' : `lhs'
		}
		else {
			local exog `exog' `lhs'
		}
		gettoken lhs 0 : 0, parse(" ,[") match(paren)
		IsStop `lhs'
	}
	local 0 `"`lhs' `0'"'
	local lhs

	// Now parse the remaining syntax
	syntax [if] [in] [fw pw iw / ] , [ Mle TWOstep Robust 	///
		CLuster(varname) SCore(string) FIRST noLOg 	///
		ASIS Level(cilevel) FROM(string)	 	///
		NRTOLerance(string) VCE(passthru) DOOPT * ]

	_get_diopts diopts options, `options'
	if "`twostep'" != "" {
		_vce_parse, optlist(TWOSTEP) :, `vce'
		local vce twostep
	}
	else if `"`vce'"' != "" {
		local options `"`options' `vce'"'
	}
	local mloptions `"`options'"'
	if _by() {
		_byoptnotallowed score() `"`score'"'
	}
	marksample touse
	markout `touse' `exog' `end1' `inst'

	fvexpand `exog' if `touse'
	local exog "`r(varlist)'"
	gettoken lhs exog : exog

	fvexpand `exog1' if `touse'
	local exog1 "`r(varlist)'"

	fvexpand `end1' if `touse'
	local end1 "`r(varlist)'"

	// Eliminate vars from `exog1' that are in `exog'
	Subtract inst : "`exog1'" "`exog'"
	
	// `lhs' contains depvar, 
	// `exog' contains RHS exogenous variables, 
	// `end1' contains RHS endogenous variables, and
	// `inst' contains the additional instruments
	
	// Syntax checking
	if "`mle'" != "" & "`twostep'" != "" {
		di as error "cannot specify both mle and twostep options"
		exit 198
	}
	local estimator "`mle'`twostep'"
	if "`estimator'" == "" {
		local estimator "mle"
	}
	if "`robust'`cluster'" != "" & ///
		`=index("`mloptions'", "vce(")' > 0 {
		if "`cluster'" != "" {
di as error "options vce() and cluster() may not be combined" 
		}
		else {
di as error "options vce() and robust may not be combined"
		}
		exit 198
	}
	if "`estimator'" == "twostep" & ///
"`robust'`cluster'`score'`log'`from'`nrtolerance'`mloptions'" != "" {
di as err "two-step estimator only allows the first, level(), and asis options"
		exit 198
	}
	if "`weight'" != "" { 
		local wgt `"[`weight'=`exp']"' 
	}
	if "`weight'" == "pweight" | "`cluster'" != "" {
		local robust "robust"
	}
	if "`weight'" != "" & "`weight'" != "fweight" & ///
		"`estimator'" == "twostep" {
		di as error "may only use fweights with two-step estimator"
		exit 498
	}
	if "`cluster'" != "" { 
		local clusopt "cluster(`cluster')" 
	} 
	if "`score'" != "" {
		// end1_ct gets redone later after collinearity checking
		local end1_ct : word count `end1'
		local needed = 1 + `end1_ct' + ///
			(`end1_ct'+1)*(`end1_ct'+2)/2 - 1
		local n : word count `score'
		if `n' == 1 & substr("`score'", -1, 1) == "*" {
			local score = substr("`score'",1,length("`score'")-1)
			local scorestr ""
			local scoretmp ""
			forvalues i = 1/`needed' {
				confirm new var `score'`i'
				local scorestr "`scorestr' `score'`i'"
				tempvar score`i'
				local scoretmp "`scoretmp' `score`i''"
			}
			
		}
		else {
			local 0 `score'
			syntax newvarlist
			local score `varlist'
			local n : word count `score'
			if `n' != `needed' {
di as error "number of variables in score() option must be `needed'"
				exit 198
			}
			confirm new var `score'
			local scoretmp ""
			forvalues i = 1/`needed' {
				tempvar score`i'
				local scoretmp "`scoretmp' `score`i''"
			}
			local scorestr "`score'"
		}
		local scoreml "score(`scoretmp')"
	}
	if "`nrtolerance'" == "" {
		local nrtolerance 1e-7
	}

	mlopts mlopts, `mloptions'
	if "`s(collinear)'" != "" {
		local 0 , collinear
		syntax [, OPT]
		error 198	// [sic]
	}
	
	`vv' Check4FVars `lhs',	exog(`exog')	///
				end1(`end1')	///
				inst(`inst')	///
				touse(`touse')
	local fvops = "`s(fvops)'" == "true" | _caller() >= 11
	local tsops = "`s(tsops)'" == "true"
	if `fvops' {
		if _caller() < 11 {
			local vv "version 11:"
		}
	}
	else {
		// Model identification checks
		CheckVars `lhs' "`exog'" "`end1'" "`inst'" `touse' "`wgt'"
        	local exog `s(exog)'
		local inst `s(inst)'
	}

	// Step 2 : call _binperfect and locate perfect predictors
	// This includes exogenous and endogenous vars and insts.
	// Not if asis specified
	tempname rules
	mat `rules' = J(1,4,0)
	if `fvops' {
		`vv' ///
		_rmcoll `lhs' `exog' `end1' if `touse' `wgt',	///
			touse(`touse') logit expand `asis' noskipline
		mat `rules' = r(rules)
		local vlist "`r(varlist)'"
		gettoken lhs vlist : vlist
		local n : list sizeof exog
		local exog
		forval i = 1/`n' {
			gettoken v vlist : vlist
			local exog `exog' `v'
		}
		local end1 : copy local vlist
		// Need to check reduced-form model if two-step est
		if "`twostep'" != "" {
			di as text "Checking reduced-form model..."
			`vv' ///
			_rmcoll `lhs' `inst' `exog' if `touse' `wgt',	///
				touse(`touse') logit expand `asis' noskipline
			mat `rules' = `rules' \ r(rules)
			local vlist "`r(varlist)'"
			gettoken lhs vlist : vlist
		}
		else {
			`vv' ///
			_rmcoll `inst' `exog' if `touse' `wgt', expand
			local vlist "`r(varlist)'"
		}
		local n : list sizeof inst
		local inst
		forval i = 1/`n' {
			gettoken v vlist : vlist
			local inst `inst' `v'
		}
		local exog : copy local vlist
	}
	else if "`asis'" == "" {
		_binperfect `lhs' `exog' `end1' , touse(`touse')
		mat `rules' = r(rules)
		if !(`rules'[1,1] == 0 & `rules'[1,2] == 0 & ///
			`rules'[1,3] == 0 & `rules'[1,4] == 0) {
			noi _binperfout `rules'
			// Remove dropped vars from varlists
			local dropped : rownames(`rules')
			foreach d in `dropped' {
				local exog : subinstr local exog "`d'" ""
				local inst : subinstr local inst "`d'" ""
				local end1 : subinstr ///
					local end1 "`d'" "", count(local c)
				if `c' > 0 {
					di as error ///
					"may not drop an endogenous regressor"
					exit 498
				}
			}
			qui count if `touse'
			if r(N) == 0 {
				exit 2000
			}
			CheckVars `lhs' "`exog'" "`end1'" "`inst'" 	///
				   `touse' "`wgt'"
			local exog `"`s(exog)'"'
			local inst `"`s(inst)'"' 
		}
		// Need to check reduced-form model if two-step est
		if "`twostep'" != "" {
		di as text "Checking reduced-form model..."
			_binperfect `lhs' `inst' `exog', touse(`touse')
			mat `rules' = r(rules)
			if !(`rules'[1,1] == 0 & `rules'[1,2] == 0 & ///
				`rules'[1,3] == 0 & `rules'[1,4] == 0) {
				noi _binperfout `rules'
				// Remove dropped vars from varlists
				local dropped : rownames(`rules')
				foreach d in `dropped' {
					local exog : subinstr local exog "`d'" ""
					local inst : subinstr local inst "`d'" ""
				}
				qui count if `touse'
				if r(N) == 0 {
					exit 2000
				}
			}
		}

	}
	qui count if `touse'
	if r(N) == 0 {
		exit 2000
	}
	
	local lhsname `lhs'
	if _caller() < 11 {
		local lhsstr : subinstr local lhsname "." "_"
	}
	else	local lhsstr : copy local lhs
	local exogname `exog'
	local end1name `end1'
	local instname `inst'

	if `tsops' {
		qui tsset, noquery
		fvrevar `lhs', tsonly
		local lhs `r(varlist)'
		fvrevar `end1', tsonly
		local end1 `r(varlist)'
		fvrevar `exog', tsonly
		local exog `r(varlist)'
		fvrevar `inst', tsonly
		local inst `r(varlist)'
	}
	local exog_ct : word count `exog'
	local end1_ct : word count `end1'
	local inst_ct : word count `inst'
	if `end1_ct' == 0 {
		di as error "no endogenous variables; use {cmd:probit} instead"	
		exit 498
	}
        CheckOrder `end1_ct' `inst_ct'

	tempvar xb	// used later by both estimators
	
	if "`estimator'" == "twostep" {
		// First set up D(Pi)
        	// The selection matrix is just the identity matrix
	        // if we include the exogenous variables after the other insts.
	        local totexog_ct = `exog_ct' + `inst_ct'
        	tempname DPi  
	        mat `DPi' = J(`totexog_ct'+1, `end1_ct'+`exog_ct'+1, 0)
        	mat `DPi'[`inst_ct'+1, `end1_ct'+1] = I(`exog_ct'+1)
	        // Now do the first-stage regressions, fill in DPi and
        	// save fitted values and residuals
	        tempname junk
        	local fitted ""
	        local resids ""
	        local qui "qui"
	        if "`first'" != "" {
	        	local qui ""
	        }
        	local i = 1
        	if `end1_ct' == 1 {
	        	`qui' di "First-stage regression"
	        }
	        else {
	        	`qui' di "First-stage regressions"
	        }
	        foreach y of local end1 {
			`vv' ///
			`qui' _regress `y' `inst' `exog' `wgt' if `touse', ///
        			level(`level')
                	mat `junk' = e(b)
	                mat `DPi'[1, `i'] = `junk' '
        	        tempvar fitted`i' resids`i'
                	qui predict double `fitted`i'' if `touse', xb
	                qui predict double `resids`i'' if `touse', residuals
        	        local fitted "`fitted' `fitted`i''"
                	local resids "`resids' `resids`i''"
	                local i = `i' + 1
        	}
		// 2SIV estimates
        	// We also use these 2SIV estimates for exog. test
		`vv' ///
	        qui probit `lhs' `end1' `exog' `resids' ///
         	       `wgt' if `touse', `doopt'
	        tempname beta2s b2s l2s var2s chi2exog chi2exdf
	        mat `beta2s' = e(b)
	        mat `b2s' = `beta2s'[1, 1..`end1_ct']
	        // Do the exog. test while we're at it.
		qui test `resids'
	        scalar `chi2exog' = r(chi2)
	        scalar `chi2exdf' = r(df)
	        
                // Next, estimate the reduced-form alpha
                // alpha does not contain the params on `resids'
                // Also get lambda
		`vv' ///
                qui probit `lhs' `inst' `exog' `resids' `wgt' ///
			if `touse', `doopt'
                tempname b alpha lambda
                mat `b' = e(b)
                mat `alpha' = J(1, `totexog_ct'+1, 0)
                mat `alpha'[1, 1] = `b'[1, 1..`totexog_ct']
                mat `alpha'[1, `totexog_ct'+1] = ///   
                        `b'[1, `totexog_ct'+`end1_ct'+1]
                mat `lambda' = `b'[1, `totexog_ct'+1..`totexog_ct'+`end1_ct']

                // Build up the omega matrix
                tempname omega var
                mat `var' = e(V)
                mat `omega' = J(`totexog_ct'+1, `totexog_ct'+1, 0)
                // First term is J_aa inverse, which is cov matrix
                // from reduced-form probit
                mat `omega'[1, 1] = `var'[1..`totexog_ct', 1..`totexog_ct']
                local j = `totexog_ct'+`end1_ct'+1 
                mat `omega'[`totexog_ct'+1, `totexog_ct'+1] = `var'[`j',`j']
                forvalues i = 1/`totexog_ct' {
                        mat `omega'[`totexog_ct'+1, `i'] = `var'[`j', `i']
                        mat `omega'[`i', `totexog_ct'+1] = `var'[`i', `j']
                }
                tempvar ylb
                qui gen double `ylb' = 0
                local i = 1
                foreach var of local end1 {
                        qui replace `ylb' = `ylb' + ///
                                    `var'*(`lambda'[1,`i'] - `b2s'[1, `i']) ///
                                    if `touse'
                        local i = `i' + 1
                }
		`vv' ///
		qui _regress `ylb' `inst' `exog' `wgt' if `touse'

                tempname V
                mat `V' = e(V)
                mat `omega' = `omega' + `V'
                tempname omegai
                mat `omegai' = syminv(`omega')
		
                // Newey answer
                tempname finalb finalv
                mat `finalv' = syminv(`DPi'' * `omegai' * `DPi')
                mat `finalb' = `finalv' * `DPi'' * `omegai' * `alpha''
                mat `finalb' = `finalb''
                
       		// Do this here before we restripe e(b)
       		// For count of completely determined outcomes
                loc names `end1' `exog' _cons
		`vv' ///
                mat colnames `finalb' = `names'
	        mat score double `xb' = `finalb' if e(sample)

		// Fill in orig names for end1, exog and inst - timeseries ops.
		foreach x in end1 exog inst {
			local new`x' ``x''
			foreach y of local `x' {
				local j : list posof "`y'" in `x'
				local y2 : word `j' of ``x'name'
				local new`x' : subinstr local new`x' "`y'" "`y2'"
			}
			local `x' `new`x''
		}
                loc names `end1' `exog' _cons
		`vv' ///
                mat colnames `finalb' = `names'
		`vv' ///
                mat colnames `finalv' = `names'
		`vv' ///
                mat rownames `finalv' = `names'
                qui summ `touse' `wgt' , meanonly
                local capn = r(sum)
                eret post `finalb' `finalv' `wgt', ///
			depname(`lhsname') o(`capn') esample(`touse')	///
			buildfvinfo
                eret scalar chi2_exog = `chi2exog'
                eret scalar df_exog = `chi2exdf'
                eret scalar p_exog = chiprob(`chi2exdf', `chi2exog')
                qui test `end1' `exog'
                eret scalar chi2 = r(chi2)
                eret scalar df_m = r(df)
                eret scalar p = chiprob(r(df), r(chi2))
		eret local method "twostep"
		eret local instd `end1'
		local insts `exog' `inst'
		eret local insts "`:list retok insts'"
		eret local depvar "`lhsname' `end1'"
		eret local vce "`vce'"
		_post_vce_rank
		
	}
	else {
		local noi "noi"
		if "`log'" != "" {
			local noi ""
		}
		tempname b0 V0
		if "`from'" == "" {
			// Starting values
			tempname bfrom cholV
			qui `noi' di as text _n "Fitting exogenous probit model"
			`vv' ///
			cap `noi' probit `lhs' `end1' `exog' `wgt' ///
				if `touse', nocoef `doopt'
			if _rc {
				di as error "could not find initial values"
				exit 498
			}
			local probcoef_ct `=`end1_ct' + `exog_ct' + 1'
			mat `b0' = e(b)
			if colsof(`b0') != `probcoef_ct' {
				di as text 	///
"regressor dropped by {cmd:probit}; using 2SLS for initial values instead"
				cap ivregress 2sls `lhs' `exog' 	///
					(`end1' = `inst') `wgt' if `touse'
				local myrc `=_rc'
				mat `b0' = e(b)
				if `myrc' | (colsof(`b0') != `probcoef_ct') {
					di as error	///
					    "could not find initial values"
					exit 498
				}
			}
			`vv' ///
			cap sureg (`end1' = `exog' `inst')
			if _rc {
				di as error "could not find initial values"
				exit 498
			}
			mat `V0' = e(Sigma)
			cap mat `cholV' = cholesky(`V0')
			if _rc {
                                di as error "could not find initial values"
				exit 498
			}
			loc nchol = `end1_ct'*(`end1_ct' + 1) / 2
			mat `V0' = J(1, `nchol', 0)
			loc m = 1
			forv i = 1/`end1_ct' {
				forv j = `i'/`end1_ct' {
					mat `V0'[1, `m'] = `cholV'[`i',`j']
					loc m = `m' + 1
				}
			}
			if `end1_ct' == 1 {
				mat `bfrom' = `b0', e(b), 0, ln(`V0'[1,1])
			}
			else {
				mat `bfrom' = ///
					`b0', e(b), J(1,`end1_ct', 0), `V0'
			}
			local init "`bfrom', copy"
		}
		else {
			local init "`from'"
		}
		loc iveqns ""   // Holds IV equations
		loc covterms ""   // Holds like /s21 /s31 /s32 for cov mat
		loc testcmd ""  // To give to -test- for exog. test
		loc i = 1
		foreach var of varlist `end1' {
			loc iveqns "`iveqns' (`var' : `var' = `exog' `inst')"
			loc ip1 = `i' + 1
			// Only for multiple endog vars:
			loc covterms "`covterms' /s`ip1'1"
			loc testcmd "`testcmd' [s`ip1'1]_b[_cons]"
			loc i = `i' + 1
		}
		if `end1_ct' > 1 {
			forv j = 1/`end1_ct' {
				loc jp1 = `j' + 1
				forv i = `j'/`end1_ct' {
					loc ip1 = `i' + 1
					loc covterms "`covterms' /s`ip1'`jp1'"
				}
			}
		}
		else {  // Fix things up for the one endog var model
			loc covterms "/athrho /lnsigma "
			loc testcmd "[athrho]_b[_cons]"
			loc dip diparm(athrho, tanh label("rho"))	///
				diparm(lnsigma, exp label("sigma"))
		}
		qui `noi' di as text _n "Fitting full model"
		// sort so that we can get the cov terms from the
		// last obs. in dataset in lf
		tempvar currsort
		gen long `currsort' = _n
		sort `touse' `currsort'
		glo IV_NEND = `end1_ct'
		if `end1_ct' == 1 {
			`vv' ///
			ml model lf ivprob_1_lf				///
				(`lhsstr' : `lhs' = `end1' `exog')	///
				`iveqns' `covterms'			///
				`wgt' if `touse' ,			///
			title(Probit model with endogenous regressors)  ///
				maximize `mlopts' `robust' `clusopt' 	///
				search(off) init(`init') `log'		///
				`scoreml' nrtolerance(`nrtolerance') 	///
				collinear `dip'
		}
		else {                                    
			`vv' ///
			ml model lf ivprob_lf				///
				(`lhsstr' : `lhs' = `end1' `exog')	///
				`iveqns' `covterms'			///
				`wgt' if `touse',			///
			title(Probit model with endogenous regressors)	///
				maximize `mlopts' `robust' `clusopt'    ///
				search(off) init(`init') `log'		///
				`scoreml' nrtolerance(`nrtolerance') 	///
				collinear
		}
		qui test `testcmd'
		eret scalar chi2_exog = r(chi2)
		eret scalar endog_ct = `end1_ct'
		eret scalar p_exog = chiprob(1, e(chi2_exog))
		eret local method "ml"
		if e(endog_ct) == 1 {
			eret hidden scalar k_eq_skip = e(endog_ct)
			eret scalar k_aux = e(k_eq) - e(k_eq_skip) - 1
		}
		else {
			eret hidden scalar k_eq_skip = e(k_eq) - 1
		}
		if "`scorestr'" != "" {
			tokenize `scorestr'
			local i = 1
			while "``i''" != "" {
				rename `score`i'' ``i''
				local i = `i' + 1
			}
			eret local scorevars `scorestr'
		}
		// Do this here before we restripe e(b)
		// For count of completely determined outcomes
		tempname outb
		mat `outb' = e(b)
	        mat score double `xb' = `outb' if e(sample)

		// rename b and V -- time-series operators
		mat `b0' = e(b)
		mat `V0' = e(V)
		local names : colfullnames `b0'
		// Need to do end1 separately, because if an eqn name,
		// must replace . with _
		local newend1 `end1'
		foreach y of local end1 {
			local j : list posof "`y'" in end1
			local y2 : word `j' of `end1name'
			local newend1 : subinstr local newend1 "`y'" "`y2'"
			local y2s : subinstr local y2 "." "_"
			local names : ///
				subinstr local names ":`y'" ":`y2'", all
			local names : ///
				subinstr local names "`y':" "`y2s':", all
		}
		local end1 `newend1'
		foreach x in exog inst {
			local new`x' ``x''
			foreach y of local `x' {
				local j : list posof "`y'" in `x'
				local y2 : word `j' of ``x'name'
				local new`x' : ///
					subinstr local new`x' "`y'" "`y2'"
				local names : ///
					subinstr local names "`y'" "`y2'", all
			}
			local `x' `new`x''
		}
		`vv' ///
		mat colnames `b0' = `names'
		`vv' ///
		mat colnames `V0' = `names'
		`vv' ///
		mat rownames `V0' = `names'
		_ms_op_info `b0'
		if r(tsops) {
			quietly tsset, noquery
		}
		eret repost b = `b0' V = `V0' `wgt', rename buildfvinfo
		eret local depvar "`lhsname' `end1'"
		eret local instd `end1'
		local insts `exog' `inst'
		eret local insts "`:list retok insts'"
		// Return Sigma matrix
		tempname sigma
		mat `sigma' = I(`end1_ct'+1)
		if `end1_ct' == 1 {
			mat `sigma'[2,2] = exp([lnsigma]_b[_cons])^2
			mat `sigma'[2,1] = tanh([athrho]_b[_cons])* ///
					   exp([lnsigma]_b[_cons])
			mat `sigma'[1,2] = `sigma'[2,1]
		}
		else {
			loc endp1 = `end1_ct' + 1
			forvalues j = 1/`endp1' {
				forvalues i = `j'/`endp1' {
					if `i'==1 & `j'==1 {
						mat `sigma'[`i',`j']=1
					}
					else {
						mat `sigma'[`i',`j'] = ///
							[s`i'`j']_b[_cons]
					}
				}
			}
			mat `sigma' = `sigma'*`sigma''
		}
		
		eret matrix Sigma = `sigma'
		qui test [#1]
		eret scalar chi2 = r(chi2)
		eret scalar df_m = r(df)
		eret scalar p = r(p)
	}
	macro drop IV_NEND


	// Count number of completely determined outcomes
        // Need to account for fweights if supplied
        tempvar suc fai
        qui gen `suc' = (`xb' > 18)
        if "`weight'" == "fweight" {
           qui replace `suc' = `suc'*`exp'
        }
        qui summ `suc' if e(sample), meanonly
        eret scalar N_cds = r(sum)
        qui gen `fai' = (`xb' < -18)
        if "`weight'" == "fweight" {
           qui replace `fai' = `fai'*`exp'
        }
        qui summ `fai' if e(sample), meanonly
        eret scalar N_cdf = r(sum)

	if "`asis'" != "" {
		eret local asis "asis"
	}
// e(rules) undocumented but needed by predict
	eret matrix rules `rules'
	if "`weight'" != "" {
		eret local wtype "`weight'"
		eret local wexp "= `exp'"
	}
	eret local footnote "ivprobit_footnote"
	eret local estat_cmd "ivprobit_estat"
	eret local predict "ivprobit_p"
	eret local marginsok "Pr XB default"
	eret local cmd "ivprobit"
	if "`e(method)'" == "ml" {
		MLDisplay , level(`level') `first' `diopts'
	}
	else {
		TSDisplay, level(`level') `diopts'
	}
end

program define MLDisplay

	syntax , [ level(cilevel) first * ]
	if "`first'" != "" {
		local noskip noskip
	}
	_get_diopts diopts, `options'
	_coef_table_header
	di
	version 12: ///
	ml display, noheader level(`level') `noskip' nofootnote `diopts'
	_prefix_footnote
end


program define TSDisplay

	syntax , [ level(cilevel) *]
	
	_get_diopts diopts, `options'
	di
	di as text "Two-step probit with endogenous regressors" _c
	di as text _col(51) "Number of obs   = " as res %9.0f e(N)
	di as text _col(51) "Wald chi2(" as res e(df_m) as text ")" _c
	di as text _col(67) "= " as result %9.2f e(chi2)
	di as text _col(51) "Prob > chi2     = " as res %9.4f  ///
		chiprob(e(df_m), e(chi2))
	di
	_coef_table, level(`level') `diopts'
	_prefix_footnote
end

// Borrowed from ivreg.ado	
program define IsStop, sclass

	if `"`0'"' == "[" {
		sret local stop 1
		exit
	}
	if `"`0'"' == "," {
		sret local stop 1
		exit
	}
	if `"`0'"' == "if" {
		sret local stop 1
		exit
	}
	if `"`0'"' == "in" {
		sret local stop 1
		exit
	}
	if `"`0'"' == "" {
		sret local stop 1
		exit
	}
	else {
		sret local stop 0
	}

end

// Borrowed from ivreg.ado	
program define Subtract   /* <cleaned> : <full> <dirt> */

	args        cleaned     /*  macro name to hold cleaned list
		*/  colon       /*  ":"
		*/  full        /*  list to be cleaned
		*/  dirt        /*  tokens to be cleaned from full */

	tokenize `dirt'
	local i 1
	while "``i''" != "" {
		local full : subinstr local full "``i''" "", word all
		local i = `i' + 1
	}

	tokenize `full'                 /* cleans up extra spaces */
	c_local `cleaned' `*'

end


// Borrowed from ivreg.ado
program define Disp
        local first ""
        local piece : piece 1 64 of `"`0'"'
        local i 1
        while "`piece'" != "" {
                di as text "`first'`piece'"
                local first "               "
                local i = `i' + 1
                local piece : piece `i' 64 of `"`0'"'
        }
        if `i'==1 { 
		di 
	}

end

program define Check4FVars, sclass
	version 11
	syntax varlist(ts) ,		///
		touse(varname)		///
	[				///
		exog(varlist ts fv)	///
		end1(varlist ts fv)	///
		inst(varlist ts fv)	///
	]

	// NOTE: -syntax- sets 'e(fvops)'

end


// Collinearity checker 
program define CheckVars, sclass
	args lhs exog end1 inst touse wgt

	/* backups */
	local end1_o `end1'
	local exog_o `exog'
	local inst_o `inst'
	
	/* Let X = [endog exog] and W = [exog inst].  Then
	   X'X and W'W must be of full rank */
	quietly {
		/* X'X */
		_rmcoll `end1' `exog' if `touse' `wgt'
		local noncol `r(varlist)'
		local end1 : list end1 & noncol
		local exog : list exog & noncol
		/* W'W */
		_rmcoll `exog' `inst' if `touse' `wgt'
		local noncol `r(varlist)'
		local exog : list exog & noncol
		local inst : list inst & noncol
	}
	local dropped : list end1_o - end1
	if `:word count `dropped'' > 0 {
		di as error "may not drop an endogenous regressor"
		exit 498
	}
	foreach type in exog inst {
		local dropped : list `type'_o - `type'
		foreach x of local dropped {
			di as text "note: `x' omitted because of collinearity"
		}
	}

	sret local exog `exog'
	sret local inst `inst'
			
end


program define CheckOrder
	
	args end inst

        if `end' > `inst' {
                di as error "equation not identified; must have at " ///
                        "least as many instruments "
                di as error "not in the regression as there are "    ///
                        "instrumented variables"
                exit 481
        }

end

