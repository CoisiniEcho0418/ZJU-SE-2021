*! version 1.0.0  09jun2011
program mlexp_p
	version 12
	
	if "`e(cmd)'" != "mlexp" {
		exit 301
	}
	
	syntax anything(name=vlist) [if] [in], [ 		///
			  SCores 				///
			  FORCENUMERIC	/* undocumented */	///
			]
	
	if "`scores'" != "" {
		di as text "(option scores assumed)"
	}
	
	marksample touse
	qui replace `touse' = 0 if !e(sample)	

	_stubstar2names `vlist', nvars(`=e(k)')
	local typlist `s(typlist)'
	local varlist `s(varlist)'
	local i 1
	foreach var of local varlist {
		local typ : word `i' of `typlist'
		capture gen `typ' `var' = .
		if _rc {
			local myrc `=_rc'
			capture drop `varlist'
			exit `myrc'
		}
		local `++i'
	}
	
	local lexp `e(lexp)'
	local params `e(params)'
	
	tempname b_tmp b_act
	mat `b_tmp' = J(1, `=e(k)', 0)	// arbitrary beta used to evaluate
					// log-L as called by deriv()
	mat `b_act' = e(b)		// actual derivs eval at e(b)

	if "`e(hasderiv)'" == "yes" & "`forcenumeric'" == "" {
		local j 1
		foreach p of local params {
			local dexp `e(d_`p')'
			local var : word `j' of `varlist'
			local i 1
			foreach p2 of local params {
				local dexp : subinstr local dexp	///
					"{`p2'}" "`b_act'[1,`i']", all
				local `++i'
			}
			cap replace `var' = `dexp' if `touse'
			if _rc {
				di as error				///
					"could not calculate score for `p'"
				exit _rc
			}
			local `++j'
		}
	}
	else {
		local i 1
		foreach p of local params {
			local lexp : subinstr local lexp 		///
				"{`p'}" "`b_tmp'[1,`i']", all
			local `++i'
		}

		tempvar ll
		qui gen double `ll' = .

		if "`e(wtype)'" != "" {
			tempvar wgtvar
			qui gen double `wgtvar' `e(wexp)' if `touse'
		}

		// put names of stuff into macros to get in mata
		local b_tmp `b_tmp'
		local b_act `b_act'
		local llname `ll'
		local tousename `touse'
		local wgtvarname `wgtvar'
		
		tempname mlexp_e
		_estimates hold `mlexp_e', copy restore	
		mata:mlexp_p_wrk()		
	}

end	


mata:

// stuff that needs to get passed by deriv() to our evaluator
struct mlexp_p_info {

	string scalar	lfvar		// holds obs. level log-L varname
	string scalar	tousevar
	string scalar	b_tmp		// temp b used in subst expr
	string scalar	lexp		// likelihood expr to evaluate

}

void mlexp_p_ll(transmorphic scalar M, real scalar todo,
	real rowvector b, real colvector fv, real matrix S,
	real matrix H)
{

	real scalar			rc
	struct mlexp_p_info scalar	MLI_P
	string scalar			cmd
	pragma unset todo
	pragma unset S
	pragma unset H
	
	MLI_P = moptimize_util_userinfo(M, 1)
	st_matrix(MLI_P.b_tmp, b)
	
	cmd = sprintf("replace %s = %s if %s", MLI_P.lfvar, 
			MLI_P.lexp, MLI_P.tousevar)
	rc = _stata(cmd, 1)
	if (rc) {
		rc = _stata(cmd, 1)
		errprintf("could not evaluate likelihood function\n")
		exit(rc)
	}
	fv = st_data(., MLI_P.lfvar, MLI_P.tousevar)	
}

void mlexp_p_wrk()
{

	real scalar			ec, i, k
	real vector			b
	real matrix			scores
	string vector			varnames
	transmorphic scalar		M
	struct mlexp_p_info scalar	MLI_P

	MLI_P.lfvar = st_local("llname")
	MLI_P.tousevar = st_local("tousename")
	MLI_P.b_tmp = st_local("b_tmp")
	MLI_P.lexp = st_local("lexp")

	k = st_numscalar("e(k)")
	b = st_matrix(st_local("b_act"))

	M = moptimize_init()
	moptimize_init_evaluator(M, &mlexp_p_ll())
	moptimize_init_evaluatortype(M, "gf0")
	moptimize_init_userinfo(M, 1, MLI_P)
	moptimize_init_eq_n(M, k)
	moptimize_init_kaux(M, k)
        for(i=1; i<=k; ++i) {
        	moptimize_init_eq_coefs(M, i, b[i])
        }
	moptimize_init_technique(M, "dfp")
	moptimize_init_search(M, "off")
	moptimize_init_tracelevel(M, "none")
	moptimize_init_conv_maxiter(M, 1)
	moptimize_init_conv_warning(M, "off")
	if (st_global("e(wtype)") != "") {
		moptimize_init_weight(M, 
			st_data(., st_local("wgtvarname"), MLI_P.tousevar))
		moptimize_init_weighttype(M, st_global("e(wtype)"))
	}
	
	ec = _moptimize(M)
	if (ec) {
		exit(moptimize_result_returncode(M))
	}
	       
	scores = moptimize_result_scores(M)

	varnames = tokens(st_local("varlist"))
	for(i=1; i<=cols(scores); ++i) {
		st_store(., varnames[i], MLI_P.tousevar, scores[.,i])
	}

}

end
