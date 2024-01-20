*! version 1.1.0  17jan2011
program gmm, eclass byable(onecall) sortpreserve
	version 11
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	
	`BY' _vce_parserun gmm, jkopts(eclass) noeqlist: `0'
	if "`s(exit)'" != "" {
		ereturn local cmdline `"gmm `0'"'
		exit
	}
	
	version 10, missing
	
	if replay() {
		if "`e(cmd)'"!="gmm" { 
			exit 301 
		} 
		if _by() { 
			exit 190 
		}
		GMMout `0'
		exit
	}
	// -gmm- uses temporary id and time vars, so we need to
	// be able to restore user's settings if there is a failure
	capture tsset, noquery
	if "`r(panelvar)'`r(timevar)'" != "" {
		local tsspanv  `r(panelvar)'
		local tssvar   `r(timevar)'
		local tssdelt  `r(tdelta)'
		local tssfmt   `r(tsfmt)'
		local istsset "yes"
		if "`BY'" != "" {
			qui sort `_byvars'
		}
	}
	capture noisily `BY' Estimate `0'
	if _rc {
		local myrc = _rc
		// If -tsset-, restore
		if "`istsset'" == "yes" {
			cap tsset `tsspanv' `tssvar', 			///
				delta(`tssdelt') format(`tsfmt') noquery
		}
		exit `myrc'
	}
	ereturn local cmdline `"gmm `:list clean 0'"'

end

program Estimate, eclass byable(recall) sortpreserve

	version 11
	
	local zero `0'		/* Backup copy */

	local type2opts PARAMeters(namelist) NPARAMeters(integer 0)  /*
			*/ EQuations(namelist) NEQuations(integer 0) /*
			*/ HASDerivatives 
	local wtsyntax [aw fw pw]

	// DO NOT CHANGE LOCAL MACRO NAMES UNLESS YOU KNOW WHAT YOU ARE DOING.
	local type
	gettoken eqn 0 : 0 , match(paren)
	if "`paren'" == "(" {
		local type 1
		local eqn1 `eqn'
		// Now loop through and get remaining equations
		local i 1
		local stop 0
		while !`stop' {
			gettoken eqn 0 : 0, match(paren)
			if "`paren'" == "(" {
				local `++i'
				local eqn`i' `eqn'
			}
			else {
				local 0 `eqn'`0'
				local stop 1
			}
		}
		local neqn `i'
		// comma before options may have been stripped off by -gettoken-
		// add if no if, in, or weight expression
		if `"`=substr(`"`0'"', 1, 1)'"' != "," &	///
		   `"`=substr(`"`0'"', 1, 2)'"' != "if" &	///
		   `"`=substr(`"`0'"', 1, 2)'"' != "in" &	///
		   `"`=substr(`"`0'"', 1, 1)'"' != "[" {
			local 0 , `0'
		}
	}
	else {
		local type 2
		local 0 `zero'	// restore what the user typed
		// program version
		syntax anything(name=usrprog id="program name") 	///
			[if] [in] `wtsyntax',				///
			[ `type2opts' * ]
		if "`parameters'" == "" & `nparameters' == 0 {
			di in smcl as error			///
"must specify {opt parameters()} or {opt nparameters()}"
			exit 198
		}
		if "`equations'" == "" & `nequations' == 0 {
			di in smcl as error			///
"must specify {opt equations()} or {opt nequations()}"
			exit 198
		}
		if `nequations' == 0 {
			local neqn : list sizeof equations
		}
		else {
			local neqn = `nequations'
		}
		local 0 `if' `in' [`weight'`exp'], `options'
		capture `usrprog' 
		if _rc == 199 {
			di as error "program `usrprog' not found"
			exit 199
		}
	}

	/* qui to suppress repeated '(... weights assumed)' message */
	qui syntax [if] [in] `wtsyntax' [, /*
		*/   *	/* * for instruments(), derivatives(),
			     xtinstruments(),  and user opts
		*/ WMATrix(string) 					/*
		*/ WINITial(string)					/*
		*/ Center						/*
		*/ ONEstep						/*
		*/ TWOstep						/*
		*/ Igmm							/*
		*/ IGMMITerate(integer -1)				/*
		*/ igmmeps(real -1)					/*
		*/ igmmweps(real -1)					/*
		*/ VAriables(varlist numeric ts)			/*
		*/ FROM(string)						/*
		*/ VCE(string)						/*
		*/ Level(cilevel)					/*
		*/ TItle(string)					/*
		*/ TItle2(string)					/*
		*/ NOCOMMONESAMPLE					/*
		*/ TECHnique(string)					/*
		*/ conv_maxiter(integer -1)				/*
		*/ conv_ptol(real -1)					/*
		*/ conv_vtol(real -1)					/*
		*/ conv_nrtol(real -1)					/*
		*/ tracelevel(string)					/*
		*/ NOLOg						/*
		*/ COEFLegend						/*
		*/ selegend						/*
		*/ *							/*
		*/ ]

	_get_diopts diopts options, ///
		level(`level') `coeflegend' `selegend' `options'
	local weight2 `weight'	// backup, since we call syntax again
	local exp2 `"`exp'"'

	/* Syntax checking */
	if "`type'" == "" {	// couldn't figure out type of function
		di as error "invalid syntax"
		exit 198
	}

	if "`nocommonesample'" != "" {
		if "`weight'" != "" {
			di in smcl as error		///
			    "weights not allowed with {opt nocommonesample}"
			exit 135
		}
	}
	
	marksample touse

	if "`variables'" != "" {
		markout `touse' `variables'
	}

	if `:word count `onestep' `twostep' `igmm'' > 1 {
		di in smcl as error ///
"can specify only one of {opt onestep}, {opt twostep}, or {opt igmm}"
		exit 198
	}
	if "`onestep'`twostep'`igmm'" == "" {
		local twostep twostep		// default is twostep
	}
	if "`igmm'" == "" {
		if `igmmiterate' != -1 {
			di in smcl as error ///
"may only specify {opt igmmiterate()} with iterative GMM estimator"
			exit 198
		}
		if `igmmeps' != -1 {
			di in smcl as error ///
"may only specify {opt igmmeps()} with iterative GMM estimator"
			exit 198
		}
		if `igmmweps' != -1 {
			di in smcl as error ///
"may only specify {opt igmmweps()} with iterative GMM estimator"
			exit 198
		}
	}
	else {
		if `igmmiterate' <= 0 & `igmmiterate' != -1 {
			di in smcl as error 	///
				"{opt igmmiterate()} must be greater than zero"
			exit 198
		}
		if `igmmeps' <= 0 & `igmmeps' != -1 {
			di in smcl as error	///
				"{opt igmmeps()} must be greater than zero"
			exit 198
		}
		if `igmmweps' <= 0 & `igmmweps' != -1 {
			di in smcl as error 	///
				"{opt igmmweps()} must be greater than zero"
			exit 198
		}
		local igmmiterate `=cond(`igmmiterate'>0, `igmmiterate', c(maxiter))'
		local igmmeps `=cond(`igmmeps'>0, `igmmeps', 1e-6)'
		local igmmweps `=cond(`igmmweps'>0, `igmmweps', 1e-6)'
	}

	if `conv_ptol' == -1 {
		local conv_ptol = 1e-6
	}
	else if `conv_ptol' <= 0 {
		di in smcl as error					///
			 "{opt conv_ptol()} must be greater than zero"
		exit 411
	}	
	if `conv_vtol' == -1 {
		local conv_vtol = 1e-7
	}
	else if `conv_vtol' <= 0 {
		di in smcl as error					///
			 "{opt conv_vtol()} must be greater than zero"
		exit 411
	}
	if `conv_nrtol' == -1 {
		local conv_nrtol = 1e-5
	}
	else if `conv_nrtol' <= 0 {
		di in smcl as error					///
			 "{opt conv_nrtol()} must be greater than zero"
		exit 411
	}
	
	local valid "nr dfp bfgs bhhh gn nm"
	if "`technique'" == "" {
		local technique "gn"
	} 
	else if "`:list technique & valid'" == "" {
		di in smcl as error 					///
			"invalid technique in {opt technique()}"
		exit 198
	}
	local allowed "nr dfp bfgs gn"
	if "`:list technique & allowed'" == "" {
		di in smcl as error					///
		"`technique' technique not supported by {cmd:gmm}"
		exit 198
	}
	
	if "`nolog'" != "" {
		local tracelevel "none"
	}
	local allowed "none value tolerance params step gradient hessian"
	if "`tracelevel'" == "" {
		local tracelevel "value"
	}
	else if "`:list tracelevel & allowed'" == "" {
		di in smcl as error					///
			"invalid specification in {opt tracelevel()}"
		exit 198
	}
	if "`technique'" == "gn" & "`tracelevel'" == "hessian" {
		di in smcl as error					///
"cannot specify {cmd:tracelevel(hessian)} with Gauss-Newton optimization"
		exit 198
	}
	if `conv_maxiter' == -1 {
		local conv_maxiter = `c(maxiter)'
	} 
	else if `conv_maxiter' < 0 | `conv_maxiter' > 16000 {
		di in smcl as error					///
			"{opt conv_maxiter()} must be between 0 and 16000"
		exit 198
	}

	if "`onestep'" != "" & "`wmatrix'" != "" {
		di in smcl as error 			///
		    "cannot specify {opt wmatrix()} with one-step estimator"
		exit 198
	}

	// Parse weight matrix and VCE
	if "`wmatrix'" == "" & "`vce'" != "" {
		_parse_covmat `"`vce'"' "vce" `touse'
		local vcetype   `s(covtype)'
		local vceclvar  `s(covclustvar)'
		local vcehac    `s(covhac)'
		local vcehaclag `s(covhaclag)'
		local vceopts	`s(covopt)'
		// set wmat to vce 
		local wmatrixtype   `vcetype'
		local wmatrixclvar  `vceclvar'
		local wmatrixhac    `vcehac'
		local wmatrixhaclag `vcehaclag'
		local wmatrixopts	 `vceopts'
	}
	else if "`wmatrix'" != "" & "`vce'" == "" {
		_parse_covmat `"`wmatrix'"' "wmatrix" `touse'
		local wmatrixtype   `s(covtype)'
		local wmatrixclvar  `s(covclustvar)'
		local wmatrixhac    `s(covhac)'
		local wmatrixhaclag `s(covhaclag)'
		local wmatrixopts   `s(covopt)'
		// set vce to wmat 
		local vcetype   `wmatrixtype'
		local vceclvar  `wmatrixclvar'
		local vcehac    `wmatrixhac'
		local vcehaclag `wmatrixhaclag'
		local vceopts	`wmatrixopts'
	}
	else if "`wmatrix'" != "" & "`vce'" != "" {
		_parse_covmat `"`vce'"' "vce" `touse'
		local vcetype   `s(covtype)'
		local vceclvar  `s(covclustvar)'
		local vcehac    `s(covhac)'
		local vcehaclag `s(covhaclag)'
		local vceopts	`s(covopt)'
		_parse_covmat `"`wmatrix'"' "wmatrix" `touse'
		local wmatrixtype   `s(covtype)'
		local wmatrixclvar  `s(covclustvar)'
		local wmatrixhac    `s(covhac)'
		local wmatrixhaclag `s(covhaclag)'
		local wmatrixopts   `s(covopt)'
	}
	else {
		local vcetype "robust"
		local wmatrixtype "robust"
	}
	
	capture xtset
	tempname usrtdelta usrtmin usrtmax
	local usrpanvar `r(panelvar)'
	local usrtimevar `r(timevar)'
	local usrtsfmt `r(tsfmt)'
	scalar `usrtdelta' = r(tdelta)
	scalar `usrtmin'  = r(tmin)
	scalar `usrtmax'  = r(tmax)
	
	if "`wmatrixclvar'" != "" | "`vceclvar'" != "" {
		if "`wmatrixclvar'" != "" & "`vceclvar'" != "" {
			if "`wmatrixclvar'" != "`vceclvar'" {
				di as error ///
"cannot specify different cluster variables in {opt wmat()} and {opt vce()}"
				exit 498
			}
		}
		if "`wmatrixclvar'" != "" {
			markout `touse' `wmatrixclvar', strok
		}
		else {
			markout `touse' `vceclvar', strok
		}
	}
	if "`weight'" == "pweight" {
		if "`wmatrixtype'" != "cluster" & 			///
			"`wmatrixtype'" != "robust" & "`onestep'" == "" {
			if "`wmatrixtype'" != "unadj" {
				local saywhat `wmatrixtype'
			}
			else {
				local saywhat unadjusted
			}
			di as err ///
			  "cannot use `saywhat' weight matrix with pweights"
			exit 404
		}
		if "`vcetype'" != "cluster" & 				///
			"`vcetype'" != "robust" & "`onestep'" != "" {
			if "`vcetype'" != "unadj" {
				local saywhat `vcetype'
			}
			else {
				local saywhat unadjusted
			}
di as err "cannot use `saywhat' VCE with pweights and one-step estimator"
			exit 404
		}
	}

	if "`wmatrixhac'`vcehac'" != "" {
		if "`weight'" == "fweight" | "`weight'" == "pweight" {
			di in smcl as err			///
"cannot use `weight's with {opt vce(hac ...)} or {opt wmatrix(hac ...)}"
			exit 498
		}
		qui tsset, noquery
	}

	// will be changed by Mata routines if used
	local wmatrixhaclagused 0
	local vcehaclagused 0
	local n_clusters 0
						/* set up expression for
						   evaluation and iteration */
	tempname parmvec parmvecall 
	if `type' == 1 {
	
		tempname parseobj
		.`parseobj' = ._gmm_parse.new
		
		local params
		forvalues i = 1/`neqn' {
			_parmlist2 `parseobj' `"`eqn`i''"'
			local eqn `r(expr)'
			local eqn`i' `:list clean eqn'
			
			// Back up expression to return to user
			local origeqn`i' `"`eqn`i''"'

			local params`i' `r(parmlist)'
			local params : list params | params`i'
			tempname parmvec`i'
			matrix `parmvec`i'' = r(initmat)
			local np`i' : word count `params`i''
			if `np`i'' == 0 { 
				di in red "no parameters in equation `i'"
				exit 198
			}
			mat coleq `parmvec`i'' = eq`i':
			matrix `parmvecall' = 	///
				nullmat(`parmvecall'), `parmvec`i''
		}
		/* At this point, parmvecall may have the same parameter in
		   more than one equation.  We create a new vector that
		   contains just the FIRST initial value for each unique
		   parameter */
		local allparms : colnames `parmvecall'
		foreach param of local params {
			local c : list posof "`param'" in allparms
			mat `parmvec' = nullmat(`parmvec'),	///
				`parmvecall'[1, `c']
		}
		mat colnames `parmvec' = `params'
		foreach parm of local params {
			local j = colnumb(`parmvec', "`parm'")
			forvalues i = 1/`neqn' {
				local eqn`i' : subinstr local eqn`i' /*
					*/ "{`parm'}" "\`parmvec'[1,`j']", all
			}
		}
		// Strip out equation name if present
		forvalues i = 1/`neqn' {
			GetEqName `"`eqn`i'"'
			if "`s(eqname)'" != "" {
				local eqnames `eqnames' `s(eqname)'
			}
			else {
				local eqnames `eqnames' `i'
			}
			local eqn`i' `"`s(eqn)'"'
		}
	}
	else {
		local nparams `nparameters'	// shorter name
		if "`parameters'" != "" {
			local params : list retok parameters
			local np : list sizeof params
			if `nparams' > 0 & `np' != `nparams' {
				di in smcl as error	///
"number of parameters in {opt parameters()} does not match {opt nparameters()}"
				exit 198
			}
			else if `nparameters' <= 0 {
				local nparams `np'
			}
		}
		else {
			if `nparams' <= 0 {
				di as error "no parameters declared"
				exit 198
			}
			local params "b1"
			forvalues i = 2/`nparams' {
				local params "`params' b`i'"
			}
		}
		matrix `parmvec' = J(1, `nparams', 0)
		matrix colnames `parmvec' = `params'
		
		local neqn `nequations'		// shorter name	
		if "`equations'" != "" {
			local eqnames : list retok equations
			local nnames : list sizeof eqnames
			if `neqn' > 0 & `nnames' != `neqn' {
"number of names in {opt equations()} does not match {opt nequations()}"
				exit 198
			}
			else if `neqn' <= 0 {
				local neqn `nnames'
			}
		}
		else {
			if `neqn' <= 0 {
				di as error "no equations declared"
				exit 198
			}
			forvalues i = 1/`neqn' {
				local eqnames `eqnames' `i'
			}
		}
	}	
	// At this point we know how many eqns there are, so mark
	// individual touse vars if requested
	if "`nocommonesample'" != "" {
		if `neqn' == 1 {
			di in smcl as err 			///
"cannot specify {opt nocommonesample} with single-equation models"
			exit 498
		}
		forvalues i = 1 / `neqn' {
			tempvar touse`i'
			qui gen byte `touse`i'' = `touse'
		}
	}
	// parse `options' for instruments
	tempvar one
	gen byte `one' = 1
	local cons_name "`one'"
	if `"`options'"' != "" {
		local zero `0'
		local 0 , `options'
		local stop 0
		while !`stop' {
			syntax [, INSTruments(string) * ]
			if `"`instruments'"' != "" {
				ParseInst `"`instruments'"' `"`eqnames'"'
				local eqn `s(eqn)'
				tsrevar `s(inst)'
				local revarinst `r(varlist)'
				foreach e of local eqn {
					if `e' < 1 | `e' > `neqn' {
						di in smcl as error ///
"invalid equation specified in {opt instruments()}"
						exit 198
					}
					local inst`e' `inst`e'' `revarinst'
					local oinst`e' `oinst`e'' `s(inst)'
					if "`s(nocons)'" == "" {
						local inst`e' `inst`e'' `one'
						local oinst`e' `oinst`e'' _cons
					}
					else {
			// make a note so this eqn's inst list doesnt get 
			// a constant term by default
						local nocons`e' 1
					}
				}
				local 0 , `options'
			}
			else {
				local stop 1
			}
		}
		local 0 `zero'
	}
	forvalues i = 1/`neqn' {
		if `"`inst`i''"' == "" & "`nocons`i''" == "" {
			local inst`i' `one'
			local oinst`i' _cons
		}
		local tmp : list uniq inst`i'
		if "`tmp'" != "`inst`i''" {
			di as err 	///
				"removing redundant instruments in equation `i'"
		}
		local inst`i' `tmp'
		if "`nocommonesample'" != "" {
			markout `touse`i'' `inst`i''
		}
		else {
			markout `touse' `inst`i''
		}
		local tmp : list uniq oinst`i'
		local oinst`i' `tmp'
	}
	// parse `options' for xtinstruments
	if `"`options'"' != "" {
		local zero `0'
		local 0 , `options'
		local stop 0
		while !`stop' {
			syntax [, XTINSTruments(string) *]
			if `"`xtinstruments'"' != "" {
				ParseXTInst `"`xtinstruments'"' `"`eqnames'"'
				local xteqn `s(xteqn)'
				local xtinst `s(xtinst)'
				local xtlags `s(xtlags)'
				foreach e of local xteqn {
					if `e' < 1 | `e' > `neqn' {
						di in smcl as error ///
"invalid equation specified in {opt instruments()}"
						exit 198
					}
					
/* allow up to 8 xtinst() specifications for each equation
*/
					local nxtinst = 0
					forvalues i = 1/8 {
						if "`xtinst`e'_`i''" == "" {
							local nxtinst = `i'
							continue, break
						}
					}
					if `nxtinst' == 0 {
						di in smcl as error ///
"can repeat {opt xtinst()} at most eight times for each equation"
						exit 198
					}
					local xtinst`e'_`nxtinst' `xtinst'
					local xtlags`e'_`nxtinst' `xtlags'
					local xtinst`e'_n = `nxtinst'
					local anyxtinst 1
				}
				local 0, `options'
			}
			else {
				local stop 1
			}
		}
		local 0 `zero'
	}
	
	// parse `options' for derivatives
	if `"`options'"' != "" {
		local subsderiv ""
		local zero `0'
		local 0 , `options'
		local stop 0
		while !`stop' {
			syntax [, DERIVative(string) * ]
			if `"`derivative'"' != "" {
				// function evaluator version doesn't 
				// accept deriv()
				if `type' == 2 {
					di as error 			///
"cannot use {opt derivatives()} with function evaluator program version"
					exit 198
				}
				local subsderiv = 1
				_parmlist_deriv `"`derivative'"' `"`eqnames'"'
				local eq = real("`s(eqn)'")
				if `eq' < 1 | `eq' > `neqn' {
					di as error	///
"error in {opt derivatives()}: equation `s(eqn)' out of range"
					exit 498
				}
				local dp `s(param)'
					// this is needed to convert linear
					// combinations to long form
				_parmlist2 `parseobj' `"`s(deriv)'"'
				local sderiv `r(expr)'
				if `.`parseobj'.isin `dp'' {
					local lcderiv 1
					local vlist `.`parseobj'.lcvarfetch ///
						`dp''
					local dp `.`parseobj'.lcparmfetch `dp''
				}
				else {
					local lcderiv 0
					if !(`:list dp in params`eq'') {
						di as error 	///
"error in {opt derivatives()}: parameter `dp' undeclared in equation `eq'"
						exit 498
					}
				}
				local ppos = 1
				foreach p of local dp {
					local pcnt : list posof "`p'" in params
					if `"`d_`eq'_`pcnt'_e'"' != "" {
						di as error		///
"derivative already defined for parameter `p' in equation `eq'"
						exit 498
					}
					if `lcderiv' {
						local lcvar : word `ppos' of ///
									`vlist'
						local d_`eq'_`pcnt'_e 	///
							(`sderiv')*`lcvar'
					}
					else {
						local d_`eq'_`pcnt'_e `sderiv'
					}
					// replace par names with parmvec elem.
					foreach p2 of local params {
						local j = colnumb(`parmvec', ///
							"`p2'")
						loc d_`eq'_`pcnt'_e : 	     ///
							subinstr local       ///
							d_`eq'_`pcnt'_e      ///
							"{`p2'}"             ///
							"`parmvec'[1,`j']",  ///
							all
					}
					tempname d_`eq'_`pcnt'
					loc d_`eq'_`pcnt'_v 	     ///
						`d_`eq'_`pcnt''
					qui gen double 		     ///
						`d_`eq'_`pcnt'' = .
					local `++ppos'
				}
				local 0 , `options'
			}
			else {
				local stop 1
			}
		}
		// verify that we have a deriv for each param/eq
		if "`subsderiv'" == "1" {
			forvalues i = 1/`neqn' {
				foreach p of local params`i' {
					local pcnt : list posof "`p'" in params
					if "`d_`i'_`pcnt'_e'" == "" {
						di in smcl as error 	///
"no derivative for parameter `p' in equation `i' specified"
						exit 498
					}
				}	
			}
		}
		local 0 `zero'
	}

	// At this point, `options' should be empty if type 1; 
	// also check if type-2 options were specified
	if `type'==1 {
		if "`options'" != "" {
			di in smcl as error		///
`"`options' not allowed with interactive version"'
			exit 198
		}
		syntax [if] [in] `wtsyntax' [, `type2opts' * ]
		if "`equations'" != "" | `nequations' != 0 {
			di in smcl as error		///
"cannot specify {opt equations()} or {opt nequation()} with interactive version"
			exit 198
		}
		if "`parameters'" != "" | `nparameters' != 0 {
			di in smcl as error		///
"cannot specify {opt parameters()} or {opt nparameters()} with interactive version"
			exit 198
		}
		if "`hasderivatives'" != "" {
			di in smcl as error		///
"cannot specify {opt hasderivatives} with interactive version"
			exit 198
		}
	}	
	
	// We've created tempvars for derivatives of type 1 evaluators if
	// needed.  Here we create k*m tempvars for derivatives of type 2
	// evaluators; k=number of params; m=number of equations
	if `type' == 2 & "`hasderivatives'" != "" {
		forvalues i = 1/`neqn' {
			forvalues j = 1/`nparams' {
				tempvar d2_`i'_`j'
				qui gen double `d2_`i'_`j'' = 0 if `touse'
				local d2_`i'_`j'_v `d2_`i'_`j''
			}
		}
	}
	if "`anyxtinst'" != "" {
		local xttype = substr(`"`winitial'"', 1, 3)
		// space intentional -v- there 
		if "`xttype'" != "xt " & "`winitial'" != "user" {
			di in smcl as error	///
"must specify {cmd:winitial(xt }{it:xtspec}{cmd:)} or {cmd:winitial(}" ///
"{it:matname}{cmd:)}{break}with XT-style instruments"
			exit 498
		}
		// can't compute an unadj weight matrix w/ XT instruments
		if "`wmatrixtype'" == "unadj" & "`twostep'`igmm'" != "" {
			di in smcl as error	///
"cannot use unadjusted weight matrix with XT-style instruments"
			exit 498
		}
		if "`weight'" != "" {
			di in smcl as error	///
			   "weights not allowed with {opt xtinstruments()}"
			exit 135
		}
		if "`usrpanvar'" == "" {
			di in smcl as error 	///
				"panel variable not set; use {cmd:xtset}."
			exit 459
		}
		else if "`usrtimevar'" == "" {
			di in smcl as error	///
				"must specify timevar; use {cmd:xtset}."
			exit 459
		}
		tempvar sumtouse pantouse id t
		qui {
			// here we use common touse even if nocommonesample
			// because we want the overall sample
			by `usrpanvar' : gen long `sumtouse' = sum(`touse')
			by `usrpanvar' : replace  `sumtouse' = `sumtouse'[_N]
			by `usrpanvar' : gen `pantouse' = (`sumtouse' > 0)
			gen long `id' = (`pantouse' > 0) in 1
			replace `id' = 1 if 				///
				`usrpanvar' != `usrpanvar'[_n-1] &	///
				`pantouse' == 1 in 2/l
			replace `id' = sum(`id')
			replace `id' = . if `pantouse' == 0
			gen double `t' = (`usrtimevar' - `usrtmin' + 1) / ///
						`usrtdelta'
		}

		local xtcapt `=(`usrtmax' - `usrtmin' + 1) / `usrtdelta''
		local xtpanvar `id'
		local xttimevar `t'
		summ `id', mean
		local xtnpan `=r(max)'
		// Panels must be nested within clusters
		if "`vceclvar'" != "" {
			_xtreg_chk_cl2 `vceclvar' `id'
		}
		else if "`wmatrixclvar'" != "" {
			_xtreg_chk_cl2 `wmatrixclvar' `id'
		}
		qui xtset `id' `t'
		local pantousename `pantouse'
	}
	else {			// no xtinstruments
		local xttype = substr(`"`winitial'"', 1, 3)
		// space intentional -v- there 
		if "`xttype'" == "xt " {
			di in smcl as error 				///
"cannot specify {cmd:wmatrix(xt ...)} without XT-style instruments"
			exit 198
		}
	}
	if "`vceclvar'`wmatrixclvar'" != "" {
		if "`id'" == "" & "`usrpanvar'" != "" {
			local sortid `usrpanvar'
		}
		else if "`id'" != "" {
			local sortid `id'
		}
		if "`t'" == "" & "`usrtimevar'" != "" {
			local sortt `usrtimevar'
			local delta `usrtdelta'		// scalar name, not #
		}
		else if "`t'" != "" {
			local sortt `t'
			local delta 1
		}
		
		if "`vceclvar'" != "" {
			local myclus `vceclvar'
		}
		else {
			local myclus `wmatrixclvar'
		}
		if "`sortid'`sortt'" != "" {
			// this is needed to keep data sorted
			// cluster -> panel -> time but to allow 
			// time-series operators to work
			// we've already ensured panels nested w/in
			// cluster, so new (cluster, panvar) will be
			// okay to use as a panvar as far as TS ops go
			if "`sortid'" != "" {
				tempname cluspanvar
				sort `myclus' `sortid'
				qui by `myclus' `sortid': ///
					gen long `cluspanvar' = 1 	///
						if _n==1
				qui replace `cluspanvar' = sum(`cluspanvar')
				qui xtset `cluspanvar' `sortt', 	///
					delta(`=`delta'')
			}
			else {
				qui tsset `sortt', delta(`=`delta'') noquery
				cap assert `myclus' >= `myclus'[_n-1]	///
					if _n > 1 & `touse'
				if _rc {
					di as error 			///
"clusters contain non-consecutive time spans"
					exit 498
				}
			}
		}
		else {
			sort `myclus'
		}
	}

	if "`winitial'" != "" {
		ParseWinit `"`winitial'"'
		local winitopts `s(winitopts)'
		local winitusr `s(winitusr)'
		local winitial `s(winitial)'
	}
	else {
		local winitial "unadj"
	}
	if "`winitial'" == "unadj" {
		local i 0
		forvalues e = 1/`neqn' {
			if "`oinst`e''" != "" & "`oinst`e''" != "_cons" {
				local `++i'
			}
			else if "`xtinst`e'_n'" != "" {
				if `xtinst`e'_n' > 0 {
					local `++i'
				}
			}
		}
		if `i' < (`neqn' - 1) & "`winitopts'" != "independent" {
			local s `=cond((`neqn'-1)==1, "", "s")'
			di in smcl as error				     ///
"to avoid a singular initial weight matrix in a model with `neqn' moment" _n ///
"equations you must declare instruments for at least `=`neqn'-1' equation`s'" _n ///
"or use {cmd:winitial(unadjusted, independent)} or {cmd:winitial(identity)}"
			exit 498
		}
	}
	
	if "`winitial'" == "xt" {
		local l = length("`winitopts'") 
		if `l' != `neqn' {
			di as error 	///
"{cmd:wmatrix(xt ...)} inconsistent with number of moment equations"
			exit 498
		}
		else if `l' > 2 {
			di as error	///
"can specify at most two moment equations with {cmd:wmatrix(xt ...)}"
			exit 498
		}
		local junk:subinstr local winitopts "D" "D", all count(local nd)
		local junk:subinstr local winitopts "L" "L", all count(local nl)
		if `nl' > 1 | `nd' > 1 {
			di as error			///
"can specify at most one equation in levels and one" _n	///
"equation in differences with {cmd:wmatrix(xt ...)}"
			exit 498
		}
	}
	local np : word count `params'	/* rest of code uses np */
	/* from() option overrides other initial values.  */
	if "`from'" != "" {
		_parmlist_initial `"`from'"' : `parmvec' `"`params'"'
	}

	qui count if `touse'
	local capN = r(N)
	if r(N) < `np' {
		di as err "cannot have fewer observations than parameters"
		exit 2001
	}

	tempname initvec		/* For returning to user */
	matrix `initvec' = `parmvec'

	local tousename `touse'		// to pass to mata
	local parmvecname `parmvec'
	forvalues i = 1/`neqn' {
		tempvar err`i'
		qui gen double `err`i'' = .
		local errnames `errnames' `err`i''
	}
	
	if `type' == 1 {
		forvalues i = 1/`neqn' {
			if "`nocommonesample'" != "" {
				local mytouse `touse`i''
			}
			else {
				local mytouse `touse'
			}
			qui count if `mytouse'
			local n = r(N)
			cap replace `err`i'' = `eqn`i'' if `mytouse'
			if _rc {
				di as error "could not evaluate equation `i'"
				exit 498
			}
		}
	}
	else {
		capture `usrprog' `errnames' if 1 [`weight2' `exp2'],	///
			at(`initvec') `options'
		if _rc {
			// call again to get complete error message
			di as error "error calling `usrprog' at initial values"
			qui `usrprog' `errnames' if `touse' 		///
				[`weight2' `exp2'], 			///
				at(`initvec') `options'
		}
	}
	forvalues i = 1/`neqn' {
		if "`nocommonesample'" != "" {
			local mytouse `touse`i''
		}
		else {
			local mytouse `touse'
		}
		qui count if `err`i'' < . & `mytouse'
		if r(N) == 0 {
			di as error 				///
"no non-missing values returned for equation `i' at initial values"
			exit 498
		}
		else if r(N) < `capN' {
			local dif = `capN' - r(N)
			local s
			if `dif' > 1 {
				local s s
			}
			if "`nocommonesample'" == "" {
				di as text 			///
"warning: `dif' missing value`s' returned for equation `i' at initial values"
			}
			qui replace `mytouse' = 0 if missing(`err`i'')
		}
	}
	// Here we generate weights and sample size that are suitable
	// for use within Mata, since it does not differentiate
	// between fw, aw, pw, or iw
	local weight `weight2'	// restore what first -syntax- parsed
	local exp `"`exp2'"'
	tempvar normwt
	if `"`exp'"' != "" {
		// If there are weights, then there's just one `touse'
		qui gen double `normwt' `exp' if `touse'
		if "`weight'" == "aweight" | "`weight'" == "pweight" {
			summ `normwt' if `touse', mean
			qui replace `normwt' = r(N)*`normwt'/r(sum)
		}
	}
	else {
		qui gen double `normwt' = 1 if `touse'
	}
	summ `normwt' if `touse', mean
	if "`weight'" == "iweight" {
		local normN = trunc(r(sum))
	}
	else {
		local normN = r(sum)
	}

	if `"`exp'"' != "" & "`weight'" != "iweight" {
		qui summ `:subinstr local exp "=" ""' if `touse'
		noi di in gr "(sum of wgt is " r(sum) ")"
	}

	if "`nocommonesample'" != "" {
		tempname normNmat
		matrix `normNmat' = J(1,`neqn',.)
		local normNmatname `normNmat'		// passed to Mata
		forvalues i = 1/`neqn' {
			local eqtousename `eqtousename' `touse`i''
			if "`anyxtinst'" == "" {
				// can't do this here if there are XT
				// instruments, because we haven't
				// sorted out valid obs. due to missing
				// instruments yet -- do so in Mata code
				// get an obs count while we're at it
				qui count if `touse`i''
				mat `normNmat'[1,`i'] = r(N)
			}
		}
		
	}
	
	tempname V Q V_modelbased finalW finalS
	local Vname `V'
	local Qname `Q'
	local V_modelbased `V_modelbased'
	local finalWname `finalW'
	local finalSname `finalS'
	qui count if `touse'
	local nobs = r(N)

	local igmmcnt			// will be filled in with number
					// of iterations, if igmm
	// estimation
	mata:_gmm_wrk()
	

	// postestimaiton
	ereturn clear
	// Each parameter is its own "equation;" rename here
	// Rename a copy, not the param vector we are using,
	// because our code depends on the names of the param 
	// vector.
	tempname b
	tempvar touse2
	mat `b' = `parmvec'

	qui gen byte `touse2' = `touse'
	foreach x of local params {
		local pareqn `"`pareqn' `x':_cons"'
	}
	matrix roweq `V' = `pareqn'
	matrix coleq `V' = `pareqn'
	matrix coleq `b' = `pareqn'
	ereturn post `b' `V', esample(`touse2')
	_post_vce_rank
	// Rename finalW and finalS with eq:var format, where eq is
	// equation number and var is name of instrument; don't bother
	// with user-supplied equation names 
	local stripe 
	forvalues i = 1/`neqn' {
		local iname : word `i' of `eqnames'
		if "`iname'" == "" {		// type-2 eval -> no eq names
			local iname eq`i'
		}
		if "`inst`i''" != "" {
			foreach x of varlist `inst`i'' {
				// `one' is the tempvar for constant term
				if "`x'" == "`one'" {
					local x _cons
				}
				local stripe `stripe' `iname':`x'
			}
		}
	}
	mat colnames `finalW' = `stripe'
	mat rownames `finalW' = `stripe'
	local nmoments = rowsof(`finalW')
	
	ereturn scalar N = `normN'
	ereturn scalar Q = `Q'
	if "`anyxtinst'" != "" {
		ereturn scalar J = `Q'*`xtnpan'
	}
	else {
		ereturn scalar J = `Q'*`normN'
	}
	if "`anyxtinst'" != "" {
		// By construction, the W matrix for DPD models can
		// have less than full rank because of how we handle
		// missing observations
		local zrank = 0
		forvalues i = 1/`nmoments' {
			if (`finalW'[`i',`i'] != 0) {
				local `++zrank'
			}
		}
	}
	else {
		local zrank = `nmoments'
	}
	ereturn scalar J_df = `zrank' - `np'
	ereturn matrix W = `finalW'
	if "`vcetype'" != "unadj" {
		mat colnames `finalS' = `stripe'
		mat rownames `finalS' = `stripe'
		ereturn matrix S = `finalS'
		ereturn matrix V_modelbased = `V_modelbased'
	}

	forvalues i = 1 / `neqn' {
		// Return other eq-level stuff while we're looping
		if `type' == 1 {
			ereturn scalar k_`i' = `np`i''
			// Return expression without equation name: at
			// beginning -- easier to do postestimation stuff
			GetEqName `"`origeqn`i''"'
			ereturn local sexp_`i' `s(eqn)'
		}
		ereturn local params_`i' `params`i''
		ereturn local inst_`i' `oinst`i''
		if "`anyxtinst'" != "" {
			if "`xtinst`i'_n'" != "" {
				ereturn scalar xtinst`i'_n = `xtinst`i'_n'
				forvalues j = 1/`xtinst`i'_n' {
					ereturn local ///
						xtinst`i'_`j' `xtinst`i'_`j''
					ereturn local ///
						xtlags`i'_`j' `xtlags`i'_`j''
				}
			}
		}
	}

	ereturn scalar converged = 1

	if "`anyxtinst'" != "" {
		ereturn scalar has_xtinst = 1
	}
	else {
		ereturn scalar has_xtinst = 0
	}

	ereturn local params `params'
	ereturn scalar type = `type'
	if `type' == 2 {
		ereturn local evalprog = "`usrprog'"
		ereturn local evalopts `"`options'"'
	}
	ereturn matrix init = `initvec'
	ereturn scalar n_eq = `neqn'
	ereturn scalar k = `np'
	ereturn scalar n_moments = `nmoments'
	ereturn scalar k_aux = `np'
	ereturn scalar k_eq_model = 0		// Do not do model test

	if `"`title'"' != "" {
		ereturn local title `"`title'"'	
	}
	if `"`title2'"' != "" {
		ereturn local title_2 `"`title2'"'	
	}
	
	// vcetype controls labeling of std. errs. in output table
	if "`vcetype'" == "robust" | "`vcetype'" == "cluster" {
		eret local vcetype "Robust"
	}
	if "`vceclvar'" != "" {
		eret local clustvar "`vceclvar'"
		eret scalar N_clust = `n_clusters'
		if "`small'" == "small" {
			eret scalar df_r = `=`e(N_clust)' - 1'
		}
	}
	if "`vcetype'" == "hac" {
		eret local vcetype "HAC"
	}
	foreach x in vce wmatrix {
		if "``x'type'" == "robust" {
			ereturn local `x' "robust"
		}
		if "`x'" == "wmatrix" & "``x'type'" == "cluster" {
			ereturn local `x' "cluster ``x'clvar'"
		}
		else if "``x'type'" == "cluster" {	// stata convention is
			ereturn local `x' "cluster"	// e(vce) = "cluster"
		}					// w/out varname
		if "``x'type'" == "hac" {
			if ``x'haclag' == -1 {
				ereturn local `x' "hac ``x'hac' opt"
			}
			else {
				ereturn local `x' "hac ``x'hac' ``x'haclag'"
			}
		}
		if "``x'type'" == "unadj" {
			ereturn local `x' "unadjusted"
		}
		if "``x'type'" == "xt" {
			ereturn local `x' "XT"
		}
	}
	if "`wmatrixhaclag'" == "-1" {	may be undef; treat as string
		ereturn scalar wlagopt = `wmatrixhaclagused'
	}
	else if "`wmatrixhaclag'" != "" {
		ereturn scalar wmatlags = `wmatrixhaclag'
	}
	if "`vcehaclag'" == "-1" {
		ereturn scalar vcelagopt = `vcehaclagused'
	}
	else if "`vcehaclag'" != "" {
		ereturn scalar vcelags = `vcehaclag'
	}
	
	if "`weight'`exp'" != "" {
		ereturn local wtype "`weight'"
		ereturn local wexp  "`exp'"
	}

	if "`variables'" != "" {
		ereturn local rhs `"`variables'"'
	}

	if "`twostep'" != "" {
		ereturn local estimator "twostep"
	}
	else if "`igmm'" != "" {
		ereturn local estimator "igmm"
		ereturn scalar ic = `igmmcnt'
	}
	else {
		ereturn local estimator "onestep"
	}

	if "`winitial'" == "user" {
		tempname Wuser2		// so user's matrix isn't dropped
		mat `Wuser2' = `winitusr'	// when we put in e(Wuser)
		ereturn matrix Wuser = `Wuser2'
		ereturn local winit "user"
		ereturn local winitname "`winitusr'"
	}
	else if "`winitial'" == "identity" {
		ereturn local winit "Identity"
	}
	else if "`winitial'" == "xt" {
		ereturn local winit "XT `winitopts'"
	}
	else {
		ereturn local winit "Unadjusted"
	}

	if "`usrpanvar'" != "" {
		if "`usrtimevar'" != "" {
			qui xtset `usrpanvar' `usrtimevar', 		///
				delta(`=`usrtdelta'') format(`usrtsfmt')
		}
		else {
			qui xtset `usrpanvar'
		}
	}

	if "`nocommonesample'" != "" {
		ereturn local nocommonesample "yes"
		ereturn matrix N_byequation = `normNmat'
	}

	ereturn local technique `technique'
	ereturn local eqnames `eqnames'	
	ereturn local marginsnotok _ALL
	ereturn local predict "gmm_p"
	ereturn local estat_cmd "gmm_estat"
	ereturn local cmd "gmm"

	GMMout, `diopts'

end

program GMMout
	syntax [, level(cilevel) COEFLegend selegend *]

	_get_diopts diopts, `coeflegend' `selegend' `options'

	local robust
	local hac
	local bs
	if substr("`e(vcetype)'", 1, 6) == "Robust" | "`e(clustvar)'" != "" {
		local robust "yes"
	}

	if substr(`"`e(vcetype)'"', 1, 9) == "Bootstrap" | /*
		*/ substr(`"`e(vcetype)'"', 1, 9) == "Jackknife" {
		local bs "yes"
	}

	local anyrobust 0

	di
	di as text "GMM estimation "
	di
	
	tempname left right
	.`left' = {}	
	.`right' = {}
	local C1 "_col(1)"
	local C2 "_col(24)"
	local C3 "_col(55)"
	local C4 "_col(70)"

	.`left'.Arrpush `C1' as text "Number of parameters = "	///
		`C2' as result %3.0f e(k)
	.`left'.Arrpush `C1' as text "Number of moments    = "	///
		`C2' as result %3.0f e(n_moments)
	.`left'.Arrpush `C1' as text "Initial weight matrix: "	///
		`C2' as res "`e(winit)'"
	if "`e(estimator)'" != "onestep" {
		local wstr
		if "`e(wmatrix)'" == "unadjusted" | 			///
			"`e(wmatrix)'" == "robust" {
			local wstr `=proper("`e(wmatrix)'")'
		}
		else if `"`: word 1 of `e(wmatrix)''"' == "cluster" {
			local clv : word 2 of `e(wmatrix)'
			local wstr "Cluster (" abbrev("`clv'",13) ")"
		}
		else {				// must be HAC
			local ktyp : word 2 of `e(wmatrix)'
			if "`ktyp'" == "bartlett" {
				local wstr "HAC Bartlett "
				local wlagfmt -6.0f
			}
			else if "`ktyp'" == "parzen" {
				local wstr "HAC Parzen "
				local wlagfmt -6.0f
			}
			else {
				local wstr "HAC quadratic spectral "
				local wlagfmt -6.3f
			}
			
			if "`e(wlagopt)'" != "" {
				local wstr 			///
				"`wstr'`:di %`wlagfmt' `e(wlagopt)''"
			}
			else {
				local lag `e(wmatlags)'
				local wstr `"`wstr'`lag'"'
			}	
		}
		.`left'.Arrpush `C1' as text "GMM weight matrix: " 	///
			`C2' as res "`wstr'"
		if "`e(wlagopt)'" != "" {
			.`left'.Arrpush `C2' as text			///
				"(lags chosen by Newey-West)"
		}
	}
	.`right'.Arrpush ""
	.`right'.Arrpush ""
	if "`e(nocommonesample)'" == "yes" {
		.`right'.Arrpush `C3' as text "Number of obs" 		///
			`C4' "= " as res "  *"
	}
	else {
		.`right'.Arrpush `C3' as text "Number of obs"		///
			`C4' "= " as res %7.0f e(N)
	}

	local nl = `.`left'.arrnels'
	local nr = `.`right'.arrnels'
	local k = max(`nl', `nr')
	forvalues i = 1/`k' {
		di as text `.`left'[`i']' as text `.`right'[`i']'
	}
	
	di
	if `"`e(title)'"' != "" {
		di as text `"`e(title)'"'
	}
	if `"`e(title_2)'"' != "" { 
		di as text `"`e(title_2)'"'
	}

	// Make it appear to _coef_table that we have # equations = # params
	mata:st_numscalar("e(k_eq)", st_numscalar("e(k)"))
	_coef_table, level(`level') `diopts'

	if "`e(vcetype)'" == "HAC" {
		local ktyp : word 2 of `e(vce)'
		local optbw `="`:word 3 of `e(vce)''" == "opt"'
		di as text "HAC standard errors based on " _c
		if "`ktyp'" == "bartlett" {
			di as res "Bartlett " _c
			local lagfmt
		}
		else if "`ktyp'" == "parzen" {
			di as res "Parzen " _c
			local lagfmt
		}
		else {
			di as res "quadratic spectral " _c
			local lagfmt %6.3f
		}
		di as text "kernel with " _c
		if `optbw' {
			di as res `lagfmt' e(vcelagopt) _c
			di as text " lags."
			di as text "   (Lags chosen by Newey-West method.)"
		}
		else {
			di as res e(vcelags) as text " lags."
		}
	}
	
	if "`e(nocommonesample)'" == "yes" {
		di as res "*" _c
		tempname Nmat
		matrix `Nmat' = e(N_byequation)
		forvalues i = 1/`=e(n_eq)' {
			di in smcl as text _col(3) 			///
"Number of observations for equation " as res `i' as text ": " 		///
as res `Nmat'[1,`i']
		}
		di in smcl as text "{hline 78}"
	}
	forvalues i = 1/`=e(n_eq)' {
		if `e(has_xtinst)' {
			di in smcl as text "Instruments for equation " 	///
				as res "`i'" as text ":"
			if "`e(xtinst`i'_n)'" != "" {
				local n = e(xtinst`i'_n)
				local allxt
				forvalues j = 1/`n' {
					local xtlags `e(xtlags`i'_`j')'
					local a : word 1 of `xtlags'
					local c `e(xtinst`i'_`j')'
					if `:word count `c'' > 1 {
						local c "(`c')"
					}
					local b : word count `xtlags'
					if `b' > 1 {
					    local b : word `b' of `xtlags'
					    local allxt `allxt' L(`a'/`b').`c'
					}
					else {
						if `a' == 1 {
							local a
						}
						local allxt `allxt' L`a'`c'
					}
				}
				di in smcl 				///
			    	"{p 8 18 4}{txt}XT-style: {res}`allxt'{p_end}"
			}
			if "`e(inst_`i')'" != "" & `e(has_xtinst)' {
				di in smcl 	 			///
			    "{p 8 18 4}{txt}Standard: {res}`e(inst_`i')'{p_end}"
			}
			else if "`e(inst_`i')'" != "" {
				di in smcl				///
			    	"{p 4 8 4}{res}`e(inst_`i')'{p_end}
			}
		}
		else {
			di in smcl 					///
"{p 0 4 4}{txt}Instruments for equation {res}`i'{txt}: {res}`e(inst_`i')'{p_end}"
		}
	}
	if e(converged) ~= 1 {
		exit 430
	}

end

program ParseInst, sclass

	args instlist eqnames

	sreturn clear
	if !strmatch(`"`instlist'"', "*:*") {
		// if user doesn't specify eq, apply inst to all eqs.
		local inst `instlist'
		local en : list sizeof eqnames
		forvalues i = 1/`en' {
			local eqn `eqn' `i'
		}
	}
	else {
		gettoken pre inst : instlist, p(":") bind
		gettoken colon inst : inst, p(":") bind
		capture numlist "`pre'"
		if !_rc {
			local pre `r(numlist)'
		}
		foreach x of local pre {
			if substr(`"`x'"',1,1) == "#" {
				local x = substr(`"`x'"',2,.)
			}
			capture confirm integer number `x'
			if !_rc {
				local eqn `eqn' `x'
			}
			else {
				local xeq : list posof "`x'" in eqnames
				if `xeq' == 0 {
					di in smcl as err		///
"invalid equation specified in {cmd:instruments()}"
					exit 498
				}
				local eqn `eqn' `xeq'
			}
		}
	}	
	
	local 0 `inst'

	syntax [varlist(numeric ts default=none)] , [ noCONStant ]
	local inst `varlist'
	if "`constant'" == "noconstant" {
		local nocons nocons
	}
	
	if "`inst'" != "" {
		tsunab inst : `inst'
	}

	sreturn local nocons `nocons'
	sreturn local eqn `eqn'
	sreturn local inst `inst'

end

program ParseXTInst, sclass

	args instlist eqnames
	
	sreturn clear

	if !strmatch(`"`instlist'"', "*:*") {
		// if user doesn't specify eq, apply inst to all eqs.
		local inst `instlist'
		local en : list sizeof eqnames
		forvalues i = 1/`en' {
			local eqn `eqn' `i'
		}
	}
	else {
		gettoken pre inst : instlist, p(":") bind
		gettoken colon inst : inst, p(":") bind
		capture numlist "`pre'"
		if !_rc {
			local pre `r(numlist)'
		}
		foreach x of local pre {
			if substr(`"`x'"',1,1) == "#" {
				local x = substr(`"`x'"',2,.)
			}
			capture confirm integer number `x'
			if !_rc {
				local eqn `eqn' `x'
			}
			else {
				local xeq : list posof "`x'" in eqnames
			if `xeq' == 0 {
				di in smcl as err               ///
"invalid equation specified in {cmd:instruments()}"
				exit 498
			}
			local eqn `eqn' `xeq'
			}
		}
	}
	
	local 0 `inst'
 	cap noi syntax varlist(numeric ts), [Lags(string)]
	if _rc {
		di in smcl as error		///
			"error in {opt xtinstruments()}
		exit 198
	}
	if `"`lags'"' == "" {
		di in smcl as err 		///
		    "option {opt lags()} required in option xtinstruments()"
		exit 198
	}
	
	// See if lags specified as "#/."
	gettoken first second : lags, parse("/")
	gettoken slash second : second, parse("/")
	local first `=trim(`"`first'"')'
	local second `=trim(`"`second'"')'
	
	if "`slash'" == "/" & "`second'" == "." {
		local xtlags "`first' ."
	}
	else {
		capture numlist "`lags'", integer sort
		if _rc {
			di in smcl as error 	///
"invalid numlist in option lags() of option xtinstruments()"
			exit 121
		}
		local xtlags `r(numlist)'
	}

	sreturn local xteqn  `eqn'
	sreturn local xtinst `varlist'
	sreturn local xtlags `xtlags'

end

program GetEqName, sclass

	args fullexpr
	
	gettoken name rest : fullexpr, parse(":") bind

	if `"`rest'"' == "" {		// no colon found --> no name
		sreturn local eqname ""
		sreturn local eqn `fullexpr'
		exit
	}

	gettoken colon rest : rest, parse(":") bind

	confirm name `name'
	if `:list sizeof name' > 1 {
		di as error `"`name' invalid name"'
		exit 7
	}
	sreturn local eqname `name'
	sreturn local eqn `rest'
	
end

program ParseWinit, sclass

	args winitial
	
	local error in smcl as error "option {opt winitial()} invalid"

	gettoken winitial winitopt : winitial, parse(",")
	gettoken junk winitopt : winitopt, parse(",")
	local winitopt : list clean winitopt

	if "`winitopt'" != "" {
		local optlen : length local winitopt
		if "`winitopt'" == substr("independent", 1,     ///
	               	  	max(5, `optlen')) {
			local winitopts "independent"
		}
		else {
			di `error'
			exit 198
		}
	}
	
	local nwords : word count `winitial'
	
	local iwlen = length(`"`winitial'"')
	local iwunadj = substr("unadjusted", 1, max(2, `iwlen'))
	local iwiden = substr("identity", 1, max(1, `iwlen'))
	if `nwords' == 1 & "`winitial'" == "`iwunadj'" {
		local winitial "unadj"
	}
	else if `nwords' == 1 & "`winitial'" == "`iwiden'" {
		local winitial "identity"
	}
	else if `nwords' == 1 {
		capture confirm matrix `winitial'
		if _rc {
			di in smcl as error "matrix `winitial' not found"
			exit 198
		}
		if "`winitopts'" != "" {
			di in smcl as error 		///
"cannot specify {opt independent} with user-supplied initial weight matrix"
			exit 198
		}
		local winitusr `winitial'
		local winitial "user"
	}
	else {					// either XT or an error
		local xt : word 1 of `winitial'
		if "`xt'" != "xt" {
			di `error'
			exit 198
		}
		local spec = trim(substr(`"`winitial'"', 4, .))
		local junk : subinstr local spec "L" "", all
		local junk : subinstr local junk "l" "", all
		local junk : subinstr local junk "D" "", all
		local junk : subinstr local junk "d" "", all
		if `"`junk'"' != "" {
			di `error'
			exit 198
		}
		if "`winitopts'" != "" {		// not allowed w/ XT
			di `error'
			exit 198
		}
		local winitopts = upper("`spec'")
		local winitial "xt"
	
	}
	
	sreturn local winitopts `winitopts'
	sreturn local winitusr  `winitusr'
	sreturn local winitial	`winitial'

end

