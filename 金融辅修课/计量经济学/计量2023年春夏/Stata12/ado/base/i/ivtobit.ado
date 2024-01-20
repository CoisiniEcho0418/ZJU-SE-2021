*! version 1.4.18  25may2011

program define ivtobit, eclass byable(onecall) properties(svyb svyj svyr)
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	`BY' _vce_parserun ivtobit, unparfirsteq equal unequalfirsteq	///
		mark(CLuster) : `0'
	if "`s(exit)'" != "" {
		version 10: ereturn local cmdline `"ivtobit `0'"'
		exit
	}

	version 8.2

	if replay() {
		if "`e(cmd)'" != "ivtobit" {
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
	version 10: ereturn local cmdline `"ivtobit `0'"'
end

program define Estimate, eclass byable(recall) sortpreserve
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	version 8.2
	
	// Portions of syntax parsing code are from ivreg.ado
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

	fvunab exog : `exog'
	tokenize `exog'
	local lhs "`1'"
	local 1 " "
	local exog `*'

	// Eliminate vars from `exog1' that are in `exog'
	Subtract inst : "`exog1'" "`exog'"
	
	// `lhs' contains depvar, 
	// `exog' contains RHS exogenous variables, 
	// `end1' contains RHS endogenous variables, and
	// `inst' contains the additional instruments

	// Now parse the remaining syntax
	syntax [if] [in] [fw pw iw / ] , [ Mle TWOstep Robust	///
		CLuster(varname) SCore(string) FIRST noLOg	///
		LL1 LL2(numlist min=1 max=1) UL1 UL2(numlist min=1 max=1) ///
		Level(cilevel) FROM(string) 			///
		NRTOLerance(string) VCE(passthru) * ]
	_get_diopts diopts options, `options'
	if "`twostep'" != "" {
		_vce_parse, optlist(TWOSTEP) :, `vce'
		local vce
	}
	else if `"`vce'"' != "" {
		local options `"`options' `vce'"'
	}
	mlopts mlopts, `options' 
	
	if _by() {
		_byoptnotallowed score() `"`score'"'
	}
	                        
	marksample touse
	markout `touse' `lhs' `exog' `end1' `inst'
	
	// Syntax checking
        if "`ll1'`ll2'`ul1'`ul2'" == "" {
                di as error "must specify censoring point"
                exit 198
        }
        if "`ll1'" != "" & "`ll2'" != "" {
                di as error "options ll and ll(#) may not be combined"
                exit 184
        }
        if "`ul1'" != "" & "`ul2'" != "" {
                di as error "options ul and ul(#) may not be combined"
                exit 184
        }
	if "`mle'" != "" & "`twostep'" != "" {
		di as error "cannot specify both mle and twostep options"
		exit 198
	}
	local estimator "`mle'`twostep'"
	if "`estimator'" == "" {
		local estimator "mle"
	}
	if "`robust'`cluster'" != "" & ///
		`=index("`mlopts'", "vce(")' > 0 {
		if "`cluster'" != "" {
di as error "options vce() and cluster() may not be combined"
		}
		else {
di as error "options vce() and robust may not be combined"
		}
		exit 198
	}
	if "`estimator'" == "twostep" & ///
"`robust'`cluster'`score'`log'`from'`mlopts'`nrtolerance'" != "" {
di as error "two-step estimator only allows the first and level() options"
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
		local needed = 1 + `end1_ct' + (`end1_ct'+1)*(`end1_ct'+2)/2
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

	mlopts mlopts, `mlopts'
	if "`s(collinear)'" != "" {
		local 0 , collinear
		syntax [, OPT]
		error 198	// [sic]
	}
	
	`vv' Check4FVars `lhs', exog(`exog')    ///
                                end1(`end1')    ///
                                inst(`inst')    ///
                                touse(`touse')
        local fvops = "`s(fvops)'" == "true" | _caller() >= 11
        local tsops = "`s(tsops)'" == "true"
        if `fvops' {
                if _caller() < 11 {
                        local vv "version 11:"
                }
		fvexpand `exog' if `touse'
		local exog "`r(varlist)'"
		fvexpand `end1' if `touse'
		local end1 "`r(varlist)'"
		fvexpand `inst' if `touse'
		local inst "`r(varlist)'"
        }

	// Model identification checks
	`vv' ///
	CheckVars ,		///
		lhs(`lhs') 	///
		exog(`exog') 	///
		end1(`end1') 	///
		inst(`inst') 	///
		touse(`touse')  ///
		fvops(`fvops')  ///
		wgt("`wgt'")
	local exog `s(exog)'
	local inst `s(inst)'
        
	qui count if `touse'
	if r(N) == 0 {
		exit 2000
	}
	
	local lhsname `lhs'
	local lhsstr : subinstr local lhsname "." "_"
	local exogname `exog'
	local end1name `end1'
	local instname `inst'
	
	fvexpand `exog' if `touse'
	local exog "`r(varlist)'"
	fvexpand `end1' if `touse'
	local end1 "`r(varlist)'"
	fvexpand `inst' if `touse'
	local inst "`r(varlist)'"
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
		di as error "no endogenous variables; use {cmd:tobit} instead"	
		exit 498
	}
        CheckOrder `end1_ct' `inst_ct'

	// Now figure out what the ll() and ul() opts are
	qui summ `lhs' if `touse', meanonly
        local ulopt ""
        local llopt ""
	local tobitll = `r(min)' - 1
	local tobitul = `r(max)' + 1
        if "`ll1'" != "" {
                local llopt "ll(`r(min)')"
                local tobitll `r(min)'
        }
        else if "`ll2'" != "" {
                local llopt "ll(`ll2')"
                local tobitll `ll2'
        }
        if "`ul1'" != "" {
                local ulopt "ul(`r(max)')"
                local tobitul `r(max)'
        }
        else if "`ul2'" != "" {  
                local ulopt "ul(`ul2')"
                local tobitul `ul2'
	}
	if `tobitul' <= `tobitll' {
		di as error "no uncensored observations"
		exit 2000
	}
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
		qui `vv' ///
		mytobit if `touse' `wgt', lhs(`lhs')     ///
			ind(`end1' `exog' `resids')      ///
			tobitll(`tobitll')               ///
			tobitul(`tobitul')               ///
			ulopt(`ulopt')                   ///
			llopt(`llopt')
	        
		tempname beta2s b2s l2s var2s chi2exog chi2exdf
	        mat `beta2s' = e(b)
	        mat `b2s' = `beta2s'[1, 1..`end1_ct']
	        // Do the exog. test while we're at it.
        	qui  test `resids'
	        scalar `chi2exog' = r(chi2)
	        scalar `chi2exdf' = r(df)

                // Next, estimate the reduced-form alpha
                // alpha does not contain the params on `resids'
                // Also get lambda
		qui `vv' ///
		mytobit if `touse' `wgt', lhs(`lhs')          ///
			ind(`inst' `exog' `resids')           ///
			tobitll(`tobitll') tobitul(`tobitul') ///
			ulopt(`ulopt') llopt(`llopt')
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
                // from reduced-form tobit
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
                foreach var of varlist `end1' {
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
		fvexpand `end1' `exog'
		loc names "`r(varlist)' _cons"
                `vv' mat colnames `finalb' = `names'
                `vv' mat colnames `finalv' = `names'
                `vv' mat rownames `finalv' = `names'
                qui summ `touse' `wgt' , meanonly
                local capn = r(sum)
		_ms_op_info `finalb'
		if r(tsops) {
			quietly tsset, noquery
		}
                eret post `finalb' `finalv' `wgt', ///
			depname(`lhsname') o(`capn') esample(`touse')	///
			buildfvinfo
                eret scalar chi2_exog = `chi2exog'
                eret scalar df_exog = `chi2exdf'
                eret scalar p_exog = chiprob(`chi2exdf', `chi2exog')
		fvexpand `end1' `exog'
		qui test `r(varlist)'
                eret scalar chi2 = r(chi2)
                eret scalar df_m = r(df)
                eret scalar p = chiprob(r(df), r(chi2))
		eret scalar endog_ct = `end1_ct'
		eret local method "twostep"
		eret local instd `end1'
		local insts `exog' `inst'
		eret local insts "`:list retok insts'"
		eret local depvar `lhsname' `end1'
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
			tempname se0 bfrom cholV
			qui `noi' di as text _n "Fitting exogenous tobit model"
			qui `vv' ///
			mytobit if `touse' `wgt', lhs(`lhs')     ///
				ind(`end1' `exog') 	         ///
				tobitll(`tobitll')               ///
				tobitul(`tobitul')               ///
				ulopt(`ulopt')                   ///
				llopt(`llopt')
			mat `b0' = e(b)
			// one 1 for constant, second 1 for std. error
			local tobcoef `=`end1_ct' + `exog_ct' + 1 + 1'
			if colsof(`b0') != `tobcoef' {
				di as error "could not find initial values"
				exit 498
			}
			mat `se0' = exp(`b0'[1, (`end1_ct'+`exog_ct'+2)])
			mat `b0' = `b0'[1, 1..(`end1_ct'+`exog_ct'+1)]
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
				mat `bfrom' = ///
				`b0', e(b), 0, ln(`se0'[1,1]), ln(`V0'[1,1])
			}
			else {
				mat `bfrom' = ///
				`b0', e(b), `se0', J(1,`end1_ct', 0), `V0'
			}
			local init "`bfrom', copy"
		}
		else {
			local init "`from'"
		}
		loc iveqns ""
		loc covterms "/s11 "  
		loc testcmd ""  
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
			loc covterms "/alpha /lns /lnv"
			loc testcmd "[alpha]_b[_cons]"
			loca dip diparm(lns, exp label("s"))	///
				 diparm(lnv, exp label("v"))
		}
		qui `noi' di as text _n "Fitting full model"
		// sort so that we can get the cov terms from the
		// last obs. in dataset in lf
		tempvar currsort
		gen long `currsort' = _n
		sort `touse' `currsort'

		glo IVT_NEND = `end1_ct'
		glo IVT_ll = `tobitll'
		glo IVT_ul = `tobitul'
		if `end1_ct' == 1 {
			`vv' ///
			ml model lf ivtob_1_lf				///
				(`lhsstr' : `lhs' = `end1' `exog')	///
				`iveqns' `covterms'			///
				`wgt' if `touse' ,			///
			title(Tobit model with endogenous regressors)	///
				maximize `mlopts' `robust' `clusopt' 	///
				search(off) init(`init') `log'		///
				`scoreml' `dip' collinear
		}
		else {                                    
			`vv' ///
			ml model lf ivtob_lf				///
				(`lhsstr' : `lhs' = `end1' `exog')	///
				`iveqns' `covterms'			///
				`wgt' if `touse',			///
			title(Tobit model with endogenous regressors)	///
				maximize `mlopts' `robust' `clusopt'    ///
				search(off) init(`init') `log' `scoreml' ///
				nrtolerance(`nrtolerance') collinear
		}
		macro drop IVT_NEND
		macro drop IVT_ll
		macro drop IVT_ul
		
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
		`vv' mat colnames `b0' = `names'
		`vv' mat colnames `V0' = `names'
		`vv' mat rownames `V0' = `names'
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
			tempname s a v
			scalar `s' = exp([lns]_b[_cons])
			scalar `a' = [alpha]_b[_cons]
			scalar `v' = exp([lnv]_b[_cons])
			mat `sigma'[1,1] = `s'^2 + `a'^2 * `v'^2
			mat `sigma'[1,2] = `a'*`v'^2
			mat `sigma'[2,1] = `sigma'[1,2]
			mat `sigma'[2,2] = `v'^2
		}
		else {
			loc endp1 = `end1_ct' + 1
			forvalues j = 1/`endp1' {
				forvalues i = `j'/`endp1' {
					mat `sigma'[`i',`j'] = ///
						[s`i'`j']_b[_cons]
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

	// Count number of censored observations
	// Need to account for fweights if supplied
	tempvar lone
	qui gen double `lone' = (`lhs' <= `tobitll')
	if "`weight'" == "fweight" {
		qui replace `lone' = `lone'*`exp'
	}
	qui summ `lone' if e(sample), meanonly
	local llcens = r(sum)
	qui replace `lone' = (`lhs' >= `tobitul')
	if "`weight'" == "fweight" {
		qui replace `lone' = `lone'*`exp'
	}
	qui summ `lone' if e(sample), meanonly
	loc ulcens = r(sum)
	loc notcens = e(N) - `llcens' - `ulcens'
	eret scalar N_unc = `notcens'
	eret scalar N_lc = `llcens'
	eret scalar N_rc = `ulcens'
	
	if "`weight'" != "" {
		eret local wtype "`weight'"
		eret local wexp "= `exp'"
	}
	if "`llopt'" != "" {
		ereturn scalar llopt = `tobitll'
	}
	if "`ulopt'" != "" {
		ereturn scalar ulopt = `tobitul'
	}
	// Undocumented, but needed for -predict , scores-
	ereturn hidden scalar tobitll = `tobitll'
	ereturn hidden scalar tobitul = `tobitul'
	eret local footnote "ivtobit_footnote"
	eret local predict "ivtobit_p"
	eret local marginsok "XB E(passthru) Pr(passthru) YStar(passthru) default"
	eret local cmd "ivtobit"
	
	if "`e(method)'" == "ml" {
		MLDisplay , level(`level') `first' `diopts'
	}
	else {
		TSDisplay, level(`level') `diopts'
	}

end

program define MLDisplay

	syntax , [ level(cilevel)  first * ]
	if "`first'" != "" {
		local noskip noskip
	}
	_get_diopts diopts, `options'
	_coef_table_header
	di
	version 9.1: ///
	ml display, noheader level(`level') `noskip' nofootnote `diopts'
	_prefix_footnote
end


program define TSDisplay

	syntax , [ level(cilevel) *]
	
	_get_diopts diopts, `options'
	di
	di as text "Two-step tobit with endogenous regressors" _c
	di as text _col(51) "Number of obs   = " as res %9.0f e(N)
	di as text _col(51) "Wald chi2(" as res e(df_m) as text ")    = " _c
	di as result %9.2f e(chi2)
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


// Collinearity checker 
program define CheckVars, sclass
        syntax ,	                ///
                touse(varname)          ///
        [                               ///
		lhs(varlist ts)		///
                exog(varlist ts fv)     ///
                end1(varlist ts fv)     ///
                inst(varlist ts fv)     ///
		fvops(integer 0) 	///
		wgt(string)		///
        ]
	
	if _caller() >= 11 | `fvops' {
		local vv : di "version " string(_caller()) ":"
		local fvexp "expand"
		fvexpand `exog' if `touse'
		local exog "`r(varlist)'"
		fvexpand `end1' if `touse'
		local end1 "`r(varlist)'"
		fvexpand `inst' if `touse'
		local inst "`r(varlist)'"
	}

	/* Let X = [endog exog] and W = [exog inst].  Then
	   X'X and W'W must be of full rank */
	quietly {
		/* X'X */
		`vv' ///
		_rmcoll `end1' `exog' if `touse' `wgt', `coll' `fvexp'
		local list1 `r(varlist)'
		if "`r(k_omitted)'" == "" {
			local omitted 0
		}
		else {
			local omitted `r(k_omitted)'
		}
		if `omitted' {
		  foreach var of local list1 {
		    _ms_parse_parts `var'
		    if "`r(type)'" == "variable" {
		      local name `r(name)'
		      local inend1 : list name in end1
		      if `inend1' {
			if `r(omit)' {
			  local end1_drop `end1_drop' `r(name)'
			}
			local end1_keep `end1_keep' `var'
		      }
		      else {
			if `r(omit)' {
			  local exog_drop `exog_drop' `r(name)'
			}
			else {
			  local exog_noomit `exog_noomit' `var'
			}
			local exog_keep `exog_keep' `var'
		      }
		    }
		    else {
		      local inend1 : list var in end1
			if `inend1' {
			  local end1_keep `end1_keep' `var'
			}
			else {
			  local exog_keep `exog_keep' `var'
			}
		    }
		  }
		}
		else {
		  local exog_keep `exog'
		  local end1_keep `end1'
		  local exog_noomit `exog'
		}
		local end1 `end1_keep'
		local exog `exog_keep'
		/* W'W */
		`vv' ///
		_rmcoll `exog_noomit' `inst' if `touse' `wgt', `coll' `fvexp'
		local list2 `r(varlist)'
		if "`r(k_omitted)'" == "" {
			local omitted 0
		}
		else {
			local omitted `r(k_omitted)'
		}
		if `omitted' {
		  foreach var of local list2 {
		    _ms_parse_parts `var'
		    if "`r(type)'" == "variable" {
		      local name `r(name)'
		      local ininst : list name in inst
		      if `ininst' {
			if `r(omit)' {
			  local inst_drop `inst_drop' `r(name)'
			}
			local inst_keep `inst_keep' `var'
		      }
		      else {
			if `r(omit)' {
			  local exog_drop `exog_drop' `r(name)'
			}
			else {
			  local exog2_noomit `exog2_noomit' `r(name)'
			}
			local exog2_keep `exog2_keep' `var'
		      }
		    }
		    else {
		      local ininst : list var in inst
		      if `ininst' {
			local inst_keep `inst_keep' `var'
		      }
		      else {
			local exog2_keep `exog2_keep' `var'
		      }
		    }
		  }
		}
		else {
		  local exog2_keep `exog'
		  local inst_keep `inst'
		  local exog2_noomit `exog'
		}
		local exog `exog' `exog2_keep'
		local exog : list uniq exog
		local inst `inst_keep'
	}
	if `:word count `end1_dropped'' > 0 {
		di as error "may not drop an endogenous regressor"
		exit 498
	}
	foreach type in exog inst {
		foreach x of local `type'_drop {
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

program define Check4FVars, sclass
        version 11
        syntax varlist(ts) ,            ///
                touse(varname)          ///
        [                               ///
                exog(varlist ts fv)     ///
                end1(varlist ts fv)     ///
                inst(varlist ts fv)     ///
        ]

        // NOTE: -syntax- sets 'e(fvops)'
        
end
        

program define mytobit, eclass
	version 8.2
	syntax  [if] [fw pw iw], 	///
		[lhs(varlist ts) 	///
		ind(varlist fv ts)	///
		tobitll(real 0) 	///
		tobitul(real 0) 	///
		ulopt(string) 		///
		llopt(string)]
	
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	if "`weight'" != "" { 
		local wgt `"[`weight'`exp']"' 
	}	
	// Using intreg since tobit doesn't take pweights
	tempvar intregl intregr 
	qui gen double `intregl' = `lhs'
	qui gen double `intregr' = `lhs'
	qui replace `intregl' = . if `intregl' <= `tobitll'
	qui replace `intregr' = . if `intregr' >= `tobitul'
	if "`llopt'" !="" {
		qui replace `intregr' = `tobitll' if `lhs'<=`tobitll'
	}
	if "`ulopt'" != "" {
		qui replace `intregl' = `tobitul' if `lhs'>=`tobitul'
	}
	capture noi `vv' intreg `intregl' `intregr' `ind' `wgt' `if'
	if _rc {
		di as error "could not find initial values"
		exit 498
	}
end
