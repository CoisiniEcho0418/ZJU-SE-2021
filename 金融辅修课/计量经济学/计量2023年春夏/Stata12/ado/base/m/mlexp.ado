*! version 1.0.3  09jun2011
program mlexp,	properties(svyb svyj svyr swml)	///
		eclass byable(onecall) sortpreserve
	version 12
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	
	`BY' _vce_parserun mlexp, jkopts(eclass) noeqlist: `0'
	if "`s(exit)'" != "" {
		ereturn local cmdline `"mlexp `0'"'
		exit
	}
	
	if replay() {
		if "`e(cmd)'"!="mlexp" { 
			exit 301 
		} 
		if _by() { 
			exit 190 
		}
		Display `0'
		exit
	}
	
	`BY' Estimate `0'

	ereturn local cmdline `"mlexp `:list clean 0'"'
end

program Estimate, eclass byable(recall) sortpreserve

	version 12
	
	local zero `0'		/* Backup copy */

	local wtsyntax [aw fw pw iw]

	// DO NOT CHANGE LOCAL MACRO NAMES UNLESS YOU KNOW WHAT YOU ARE DOING.
	local type
	gettoken expr 0 : 0 , match(paren)
	if "`paren'" != "(" {
		// -mlexp- ONLY accepts an expression bound in parens
		// No programmable version -- use -ml- instead
		di as error "invalid syntax"
		exit 198
	}

	local expr `expr'
	// Back up expression to return to user
	local origexpr `"`expr'"'

	/* qui to suppress repeated '(... weights assumed)' message */
	qui syntax [if] [in] `wtsyntax' [, 		/*
		*/ VAriables(varlist numeric fv)	/*
		*/ noLOg				/*
		*/ VCE(passthru)			/*
		*/ FROM(string)				/*
		*/ Level(cilevel)			/*
		*/ title(string)			/*
		*/ title2(string)			/*
		*/ CONSTraints(passthru)		/* disallowed
		*/ NOCNSReport				/* disallowed
		*/ COEFLegend 				/*
		*/ cformat(passthru)			/*
		*/ pformat(passthru)			/*
		*/ sformat(passthru)			/*
		*/ * ]					/* derivative()s
		*/
	_get_diopts diopts options, `options'
	local WEIGHT `weight'	// backup, since we call syntax again
	local EXP    `"`exp'"'	// backup, since we call syntax again

	marksample touse
	if "`variables'" != "" {
		markout `touse' `variables'
	}
	
	// Because we use -mlopts-, we need to trap what we don't want first
	if "`constraints'" != "" {
		di as error "constraints not allowed"
		exit 198
	}
	if "`nocnsreport'" != "" {
		di as error "nocnsreport not allowed"
		exit 198
	}

	_vce_parse, argopt(CLuster) opt(OIM OPG Robust) : 	///
		[`WEIGHT'`EXP'], `vce'
	if "`r(cluster)'" != "" {
		local clustvar `r(cluster)'
		local vce cluster
		markout `touse' `clustvar'
	}
	else if "`r(vce)'" != "" {
		local vce `r(vce)'
	}
	else {
		local vce oim
	}

	// Parse display options
	_get_diopts diopts, `coeflegend' `cformat' `pformat' `sformat'

	// Parse ml options
	mlopts mlopts options, `options'

	tempname parmvec parseobj
	.`parseobj' = ._gmm_parse.new

	local params
	_parmlist2 `parseobj' `"`expr'"'
	local expr `r(expr)'
	local params `r(parmlist)'
	tempname parmvec
	matrix `parmvec' = r(initmat)
	local np : word count `params'
	if `np' == 0 { 
		di in red "no parameters in equation"
		exit 198
	}

	local lexp `expr'			// for return to user
	mat colnames `parmvec' = `params'
	foreach parm of local params {
		local j = colnumb(`parmvec', "`parm'")
		local expr : subinstr local expr /*
			*/ "{`parm'}" "`parmvec'[1,`j']", all
	}
	// from() overrides default initial values of zero
	if "`from'" != "" {
		_parmlist_initial `"`from'"' : `parmvec' `"`params'"'
	}	
	
	// Strip out equation name if present
	GetEqName `"`expr"'
	if "`s(eqname)'" != "" {
		local eqname `s(eqname)'
	}
	else {
		local eqnames
	}
	// Parse derivative() -- in `options'
	if `"`options'"' != "" {
		local subsderiv ""
		local zero `0'
		local 0 , `options'
		local stop 0
		while !`stop' {
			syntax [, DERIVative(string) * ]
			if `"`derivative'"' != "" {
				local hasderiv = 1
				_parmlist_deriv `"`derivative'"' `"`eqnames'"'
				local eq = real("`s(eqn)'")
				if `eq' != 1 {	// only 1 eqn in -mlexp- 
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
					if !(`:list dp in params') {
						di as error 	///
"error in {opt derivatives()}: parameter `dp' undeclared"
						exit 498
					}
				}
				local ppos = 1
				foreach p of local dp {
					local pcnt : list posof "`p'" in params
					if `"`d_`pcnt'_e'"' != "" {
						di as error		///
"derivative already defined for parameter `p'"
						exit 498
					}
					if `lcderiv' {
						local lcvar : word `ppos' of ///
									`vlist'
						local d_`pcnt'_e 	///
							(`sderiv')*`lcvar'
					}
					else {
						local d_`pcnt'_e `sderiv'
					}
					// make backup to return in e() so we
					// can predict scores later
					local d_`pcnt'_e_2 `d_`pcnt'_e'
					// replace par names with parmvec elem.
					foreach p2 of local params {
						local j = colnumb(`parmvec', ///
							"`p2'")
						loc d_`pcnt'_e : 	     ///
							subinstr local       ///
							d_`pcnt'_e           ///
							"{`p2'}"             ///
							"`parmvec'[1,`j']",  ///
							all
					}
					tempname d_`pcnt'
					local d_`pcnt'_v `d_`pcnt''
					qui gen double `d_`pcnt'' = .
					local `++ppos'
				}
				local 0 , `options'
			}
			else {
				local stop 1
			}
		}

		// verify that we have a deriv for each param/eq
		if "`hasderiv'" == "1" {
			foreach p of local params {
				local pcnt : list posof "`p'" in params
				if "`d_`pcnt'_e'" == "" {
					di in smcl as error 	///
"no derivative for parameter `p' specified"
					exit 498
				}
			}
		}
	}
	if `"`options'"' != "" {
		local 0 : subinstr local 0 "," ""
		local 0 `=trim(`"`0'"')'
		di in smcl as error "option `0' not allowed"
		exit 198
	}

	qui count if `touse'
	if r(N) < `np' {
		di as err "cannot have fewer observations than parameters"
		exit 2001
	}

	// weights
	if "`WEIGHT'" != "" {
		// needed in case the user specifies an expression for weights
		tempvar weightvar
		local weightvarname `weightvar'
		qui gen double `weightvar' `EXP' if `touse'
	}
	
	local parmvecname `parmvec'
	tempname initvec
	matrix `initvec' = `parmvec'

	tempvar lf
	qui gen double `lf' = .
	cap replace `lf' = `expr' if `touse'
	if _rc {
		di as error "could not evaluate equation `i'"
		exit 498
	}

	local tousevarname `touse'		// to pass to mata
	local parmvecname `parmvec'
	local lfvarname `lf'
	
	// estimation
	mata:_mlexp_wrk()
	
	ereturn local k_dv = ""		// can't tell -- depends on model
	ereturn local user ""		// hide private Mata function
					// " of no use to end user
	ereturn local k_autoCns ""
	ereturn local which ""
	ereturn scalar df_m = `np'
	ereturn scalar k_eq_model = 0
	if "`WEIGHT'" != "" {
		ereturn local wtype "`WEIGHT'"
		ereturn local wexp  "`EXP'"
		if "`WEIGHT'" == "fweight" {
			qui summ `weightvar' if `touse', mean
			ereturn scalar N = r(sum)
		}
	}

	if "`hasderiv'" == "1" {
		ereturn local hasderiv "yes"
		foreach p of local params {
			local pcnt : list posof "`p'" in params
			ereturn local d_`p' `d_`pcnt'_e_2'
		}
	}
	
	ereturn matrix init = `initvec'
	
	if `"`title'"' != "" {
		ereturn local usrtitle `"`title'"'
	}
	if `"`title2'"' != "" {
		ereturn local usrtitle2 `"`title2'"'
	}
	
	if "`variables'" != "" {
		ereturn local rhs `variables'
	}
	ereturn local params "`params'"
	ereturn local lexp "`lexp'"
	ereturn hidden local covariates "_NONE"	// -margins- not allowed after
	ereturn local marginsprop "noeb"	// -mlexp-; disable
	ereturn local marginsnotok "SCores"
	ereturn local estat_cmd "mlexp_estat"
	ereturn local predict "mlexp_p"
	// For survey data:
	if "`WEIGHT'" == "iweight" {
		ereturn hidden local crittype "log pseudolikelihood"
	}
	ereturn local cmd "mlexp"
	
	Display, level(`level') `diopts'
	
end

program Display

	syntax [, level(cilevel) * ]

	if "`e(usrtitle)'`e(usrtitle2)'" == "" {
		di
		di as text "Maximum likelihood estimation" 
	}
	else {
		if "`e(usrtitle)'" != "" {
			di as text "`e(usrtitle)'" 
		}
		if "`e(usrtitle2)'" != "" { 
			di as text "`e(usrtitle2)'"
		}
	}		

	_prefix_display, level(`level') `options'

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


mata:

struct mlexp_info {

	string scalar	lfvar			// holds obs. level log-L var.
	string scalar	tousevar
	string scalar	parmvecname		// name of Stata param vector
						// used in substitutable expr.
	string scalar	expression		// Holds expression for log-L
						// that can be evaluated by
						// -replace-
	string vector	paramnames		// names of params
	real scalar	nparam
						
	string scalar	vcetype
	string scalar	vceclustvar
	
	string scalar	weightvar
	string scalar   weighttype

	real scalar	hasderiv		// 1 = analyt. derivs; 0 o.w.
	string vector	derivvar		// varnames to store derivs
	string vector	derivexpr		// expressions to evaluate
						// derivatives

}

struct mlexp_info scalar mlexp_setup()
{

	real scalar	i, k
	struct mlexp_info scalar M

	M.parmvecname	= st_local("parmvecname")
	k = cols(st_matrix(M.parmvecname))
	M.nparam 	= k
	M.paramnames	= tokens(st_local("params"))
	M.lfvar		= st_local("lfvarname")
	M.tousevar  	= st_local("tousevarname")
	M.expression	= st_local("expr")
	M.weighttype	= st_local("WEIGHT")
	M.weightvar	= st_local("weightvarname")
	M.vcetype	= st_local("vce")
	M.vceclustvar	= st_local("cluster")
	
	M.hasderiv	= (st_local("hasderiv") == "1")
	if (M.hasderiv == 1) {
		M.derivvar = J(1, k, "")
		M.derivexpr = J(1, k, "")
		for(i=1; i<=k; ++i) {
			M.derivvar[i] = st_local("d_" + strofreal(i) + "_v")
			M.derivexpr[i] = st_local("d_" + strofreal(i) + "_e")
		}
	}
	
	return(M)

}


void mlexp_eval_ll(transmorphic scalar M, real scalar todo, 
	     real rowvector b, real colvector fv,
	     real matrix S, real matrix H)
{

	real scalar 		i, rc
	string scalar 		cmd
	struct mlexp_info scalar 	MLI
	pragma unset H
	
	MLI = moptimize_util_userinfo(M, 1)
	
	st_matrix(MLI.parmvecname, b)

	cmd = sprintf("replace %s = %s if %s", MLI.lfvar, MLI.expression,
					       MLI.tousevar)

	rc = _stata(cmd, 1)
	if (rc) {
		rc = _stata(cmd, 0)
		errprintf("could not evaluate likelihood function\n")
		exit(rc)
	}

	fv = st_data(., MLI.lfvar, MLI.tousevar)

	if (todo == 0) return
	
	for(i=1; i<=MLI.nparam; ++i) {
		cmd = sprintf("replace %s = %s if %s", MLI.derivvar[i],
					MLI.derivexpr[i], MLI.tousevar)
		rc = _stata(cmd, 1)
		if (rc) {
			rc = _stata(cmd, 0)
			errprintf("could not evaluate derivative\n")
			exit(rc)
		}
	}
	S = st_data(., MLI.derivvar, MLI.tousevar)

}

void mlexp_parse_mlopts(transmorphic scalar MO)
{

	real scalar		i
	string scalar	 	usrarg
	string vector		mlopts
	
	mlopts = tokens(st_local("mlopts")) 
	if (cols(mlopts) == 0) return	

	for(i=1; i<=cols(mlopts); ++i) {
		if (mlopts[i] == "trace") {
			moptimize_init_trace_coefs(MO, "on")
			continue
		}
		if (mlopts[i] == "gradient") {
			moptimize_init_trace_gradient(MO, "on")
			continue
		}
		if (mlopts[i] == "hessian") {
			moptimize_init_trace_Hessian(MO, "on")
			continue
		}
		if (mlopts[i] == "showstep") {
			moptimize_init_trace_step(MO, "on")
			continue
		}
		if (mlopts[i] == "nonrtolerance") {
			moptimize_init_conv_ignorenrtol(MO, "on")
			continue
		}
		if (mlopts[i] == "showtolerance") {
			moptimize_init_trace_tol(MO, "on")
			continue
		}
		if (mlopts[i] == "difficult") {
			moptimize_init_singularHmethod(MO, "hybrid")
			continue
		}
		if (substr(mlopts[i], 1, 10) == "technique(") {
			usrarg = tokens(mlopts[i], "()")[3]
			moptimize_init_technique(MO, usrarg)
			continue
		}
		if (substr(mlopts[i], 1, 8) == "iterate(") {
			usrarg = tokens(mlopts[i], "()")[3]
			moptimize_init_conv_maxiter(MO, strtoreal(usrarg))
			continue
		}
		if (substr(mlopts[i], 1, 10) == "tolerance(") {
			usrarg = tokens(mlopts[i], "()")[3]
			moptimize_init_conv_ptol(MO, strtoreal(usrarg))
			continue
		}
		if (substr(mlopts[i], 1, 11) == "ltolerance(") {
			usrarg = tokens(mlopts[i], "()")[3]
			moptimize_init_conv_vtol(MO, strtoreal(usrarg))
			continue
		}
		if (substr(mlopts[i], 1, 12) == "nrtolerance(") {
			usrarg = tokens(mlopts[i], "()")[3]
			moptimize_init_conv_nrtol(MO, strtoreal(usrarg))
			continue
		}

	}

}

void _mlexp_wrk()
{

	real scalar		i, ec
	real vector		iparams
	struct mlexp_info scalar	MLI
	transmorphic scalar	MOPT
	string	scalar		valueid

	MLI = mlexp_setup()
	
	MOPT = moptimize_init()
	
	moptimize_init_touse(MOPT, MLI.tousevar)
	if (MLI.hasderiv) {
		moptimize_init_evaluatortype(MOPT, "gf1")
	}
	else {
		moptimize_init_evaluatortype(MOPT, "gf0")
	}
	moptimize_init_evaluator(MOPT, &mlexp_eval_ll())
	moptimize_init_userinfo(MOPT, 1, MLI)
	moptimize_init_obs(MOPT, sum(st_data(., MLI.tousevar)))

	moptimize_init_eq_n(MOPT, MLI.nparam)
	moptimize_init_kaux(MOPT, MLI.nparam)
	
	iparams = st_matrix(MLI.parmvecname)
	for(i=1; i <= MLI.nparam; ++i) {
		moptimize_init_eq_name(MOPT, i, MLI.paramnames[i])
		moptimize_init_eq_coefs(MOPT, i, iparams[i])
	}

	valueid = "log likelihood"

	if (MLI.weighttype == "pweight") {
		valueid = "log pseudolikelihood"
	}

	if (MLI.weighttype != "") {
		moptimize_init_weighttype(MOPT, MLI.weighttype)
		moptimize_init_weight(MOPT, MLI.weightvar)
	}
	
	if (MLI.vcetype != "") {
		moptimize_init_vcetype(MOPT, MLI.vcetype)
		if (MLI.vceclustvar != "") {
			moptimize_init_cluster(MOPT, MLI.vceclustvar)
			valueid = "log pseudolikelihood"
		}
		if (moptimize_init_vcetype(MOPT) == "robust") {
			valueid = "log pseudolikelihood"
		}
	}
	moptimize_init_valueid(MOPT, valueid)
	
	// Grab user options
	mlexp_parse_mlopts(MOPT)		// that gets the standard 
						// options 
	if (st_local("log") == "nolog") {
		moptimize_init_trace_value(MOPT, "off")
	}
	if (st_local("clustvar") != "" ) {
		moptimize_init_cluster(MOPT, st_local("clustvar"))
	}

	// the big bang
	ec = _moptimize(MOPT)
	if (ec) {
		exit(moptimize_result_returncode(MOPT))
	}
	
	moptimize_result_post(MOPT)
	st_numscalar("e(ll)",   moptimize_result_value(MOPT))

}

end

exit

