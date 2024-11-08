*! version 2.6.4  25may2011
program define xtreg_ml, eclass
	_vce_parserun xtreg, panel mark(I) : `0'
	if "`s(exit)'" != "" {
		exit
	}
        version 6, missing
	if replay() {
                if "`e(model)'" != "ml" {
                        noi di in red "results for xtreg not found"
                        exit 301
                }
                Display `0'
                exit
        }
	local vv : display "version " string(_caller()) ", missing: "
        `vv' Estimate `0'
end


program define Estimate, eclass
        version 6, missing
	#delimit ;
	syntax [varlist(ts fv)] [if] [in] [iweight] 
			[, mle I(varname) RE SKIP Level(cilevel) noREFINE
			noCONstant OFFset(string) FROM(string) noLOg noDISP
			VCE(passthru) sortst COLLinear *] ;
	#delimit cr
	local fvops = "`s(fvops)'" == "true" | _caller() >= 11 
	local tsops = "`s(tsops)'" == "true"
	if `fvops' {
		if _caller() < 11 {
			local vv "version 11:"
		}
		else	local vv : di "version " string(_caller()) ":"
		local fvopts findomitted buildfvinfo
	}

	_get_diopts diopts options, `options'
	local diopts level(`level') `diopts'
	_vce_parse, opt(OIM):, `vce'
	local vce = cond("`r(vce)'" != "", "`r(vce)'", "oim")

	mlopts mlopt, `options'
	if "`s(collinear)'" != "" {
		di as err "option collinear not allowed"
		exit 198
	}

	xt_iis `i'
	local ivar "`s(ivar)'"

	if "`offset'" != "" {
		tempvar ovar
		confirm var `offset'
		gen double `ovar' = `offset'
		local oarg "offset(`ovar')"
	}

	quietly {
		tempvar touse
		mark `touse' `if' `in' [`weight'`exp']
		markout `touse' `varlist' `ovar'
		markout `touse' `ivar', strok
		capture tsset, noquery
		if _rc == 0 {
			local ivar `r(panelvar)'
			local tvar `r(timevar)'
		}
		gettoken olddep oldind : varlist
		_fv_check_depvar `olddep'
		tsrevar `olddep'
		local dep `r(varlist)'
		`vv' noi _rmdcoll `olddep' `oldind' if `touse',	///
			`constan' `collinear'
		local oldind "`r(varlist)'"
		fvrevar `oldind', tsonly
		local ind `r(varlist)'
		local p : list sizeof ind

		if "`sortst'" != "" {
			unopvarlist `ind'
	                sort `touse' `ivar' `dep' `r(varlist)'
		}
		else {
			sort `touse' `ivar'
		}
                if "`weight'" != "" {
                        tempvar wv
                        gen double `wv' `exp'
                        _crcchkw `ivar' `wv' `touse'
                        drop `wv'
                }

		`vv' ///
		_regress `dep' `ind' [`weight'`exp'] if `touse', ///
			`oarg' `constan'
		local llprob = e(ll)  
		local s2     = e(rmse)^2
		tempvar z
		predict double `z' if `touse', resid

		local olddepn : subinstr local olddep "." "_"
		local k 1
		while `k' <= `p' {
			local wrd : word `k' of `oldind'
			local names "`names' `olddepn':`wrd'"
			if !strpos("`wrd'", ".") {
				local orig :char `wrd'[tsrevar]
				if `:length local orig' {
					local wrd : copy local orig
				}
			}
                        local NAMES "`NAMES' `olddep':`wrd'"
			local k = `k'+1
		}
                if "`constan'" == "" {
                        local names "`names' `olddepn':_cons sigma_u:_cons"
			local names "`names' sigma_e:_cons"
                        local NAMES "`NAMES' `olddep':_cons sigma_u:_cons"
			local NAMES "`NAMES' sigma_e:_cons"
                        local p = `p' + 1
                }
                else {
			local names "`names' sigma_u:_cons sigma_e:_cons"
			local NAMES "`NAMES' sigma_u:_cons sigma_e:_cons"
			local skip "skip"
		}

		if "`ind'" == "" { local skip "skip" }

		tempvar t T 
		if "`sortst'" != "" {
			unopvarlist `ind'
	                sort `touse' `ivar' `dep' `r(varlist)'
		}
		else {
			sort `touse' `ivar'
		}
		by `touse' `ivar': gen int `t' = _n if `touse'
                by `touse' `ivar': gen int `T' = _N if `touse'
                by `touse' `ivar': replace `z' = cond(_n==_N, sum(`z'), .)
                replace `z' = sum(`z'*`z'/`T') if `touse'

                summarize `T' if `touse' & `ivar'~=`ivar'[_n-1], meanonly
		local ng = r(N)
		local g1 = r(min)
		local g2 = r(mean)
		local g3 = r(max)

                local su2 = max(0, (`z'[_N]/r(N)-`s2')/(r(mean)-1))
		drop `z' `t' 

		local t2 = sqrt(`su2')
		local t1 = sqrt(max(0,`s2'-`su2'))

		tempname beta 
		if "`from'" == "" {
			mat `beta' = get(_b)
			mat coleq `beta' = `dep'
			tempname rho
			mat `rho' = (`t2',`t1')
			mat colnames `rho' = sigma_u:_cons sigma_e:_cons
			mat `beta' = `beta',`rho'
		} 
		else {
			mat `beta' = `from'
                        local skip "skip"
                        local refine "norefine"
		}

		tempvar w
		if "`weight'" == "" {
			gen double `w' = 1 if `touse'
		}
		else {
			gen double `w' `exp' if `touse'
		}
		
		summ `dep' [aw=`w'*`t1'*`t1'/(`T'*`t2'*`t2'+`t1'*`t1')] /*
			*/ if `touse', meanonly
		drop `T'
		tempname beta0
		mat `beta0' = (r(mean),`t2',`t1')
		unopvarlist `ind'
                sort `touse' `ivar' `dep' `r(varlist)'
		tempvar p
		gen long `p' = _n*`touse'
		summ `p' if `touse'
		local j0 = r(min)
		local j1 = r(max)

		if "`log'" == "" { local lll "noisily" }
		else             { local lll "quietly" }
	}
	if "`skip'" == "" {
		`lll' di in green _n "Fitting constant-only model:"
		_XTRENORM `dep' in `j0'/`j1', i(`ivar') w(`w') `oarg' /*
			*/ nodisplay b(`beta0') `options' /*
			*/ `clopt' regress `log' `refine' 
		local ll0 = e(ll)
		local llarg "ll_0(`ll0')"
		`lll' di in green _n "Fitting full model:" 
	}
	_XTRENORM `dep' `ind' in `j0'/`j1', i(`ivar') w(`w') `oarg' /*
		*/ `llarg' b(`beta') `options' `clopt' /*
		*/ regress `log' `constan' `refine'
	est local cmd
	est local distrib "Gaussian"
	est local title   "Random-effects ML regression"
	est local model   ml 
	est local wtype   "`weight'"
	est local wexp    "`exp'"

	est scalar N_g    = `ng'
	est scalar g_min  = `g1'
	est scalar g_avg  = `g2'
	est scalar g_max  = `g3'
	tempname b v bsu
	mat `b' = get(_b)
	mat `v' = get(VCE)
	local nc1 = colsof(`b')
	local nc = `nc1'-1
	local su = `b'[1,`nc']
	if `su' < 0 {
		mat `b'[1,`nc'] = -`su' 
		local i 1
		while `i' < `nc' {
			mat `v'[`i',`nc'] = -`v'[`i',`nc']
			mat `v'[`nc',`i'] = `v'[`i',`nc']
			local i = `i'+1
		}
		mat `v'[`nc',`nc1'] = -`v'[`nc',`nc1']
		mat `v'[`nc1',`nc'] = `v'[`nc',`nc1']
	}
	local nc = `nc1'
	local se = `b'[1,`nc']
	if `se' < 0 {
		mat `b'[1,`nc'] = -`se' 
		local i 1
		while `i' < `nc' {
			mat `v'[`i',`nc'] = -`v'[`i',`nc']
			mat `v'[`nc',`i'] = `v'[`i',`nc']
			local i = `i'+1
		}
	}
	version 11: ///
	mat colnames `b' = `NAMES'
	version 11: ///
	mat colnames `v' = `NAMES'
	version 11: ///
	mat rownames `v' = `NAMES'
	_ms_op_info `b'
	if r(tsops) {
		quietly tsset, noquery
	}
	est post `b' `v' [`weight'`exp'], depname(`olddep') noclear `fvopts'
	_post_vce_rank

        if "`llprob'" != "" {
                est scalar ll_c   = `llprob'
		est scalar chi2_c = cond([sigma_u]_b[_cons]<1e-5, 0, /*
                        */ abs(-2*(e(ll_c)-e(ll))))
                est local chi2_ct "LR"
	}
	else {
                qui test [sigma_u]_cons = 0
                est scalar chi2_c  = r(chi2)
                est local chi2_ct  "Wald"
	}

        est scalar sigma_u = [sigma_u]_b[_cons]
        est scalar sigma_e = [sigma_e]_b[_cons]
        est scalar rho = e(sigma_u)^2/(e(sigma_u)^2+e(sigma_e)^2)

	if (1) /* _caller() < 6 */ { /* Double saves */
		global S_E_cmd	"`e(cmd)'"
		global S_E_cmd2	"`e(cmd2)'"
		global S_E_llp	"`e(ll_c)'"
	}

	est hidden scalar k_eq_skip = 2
	est hidden local diparm1 sigma_u, ci(log) noprob
	est hidden local diparm2 sigma_e, ci(log) noprob
	est hidden local diparm3 sigma_u sigma_e, label(rho) /*
		*/func(@1^2/(@1^2+@2^2)) /*
		*/ der( 2*@1*(@2/(@1^2+@2^2))^2 -2*@2*(@1/(@1^2+@2^2))^2 ) /*
		*/ ci(probit)
	est local vce     "`vce'"
	est local predict xtrefe_p
	est local marginsnotok E U UE SCore STDP XBU
	est local ivar    "`ivar'"
	est local offset1 "`offset1'"
	est local cmd     "xtreg"
	est local depvar  "`olddep'"
	if "`disp'" == "" {
		DispTbl, `diopts'
		DispLR
	}
end


program define DispTbl
	syntax [, Level(cilevel) *]

	_get_diopts diopts, `options'
        tempname b
        local su = [sigma_u]_b[_cons]
        local se = [sigma_e]_b[_cons]
        local bb = `su'^2/(`su'^2+`se'^2)

	_crcphdr
	_coef_table, level(`level') `diopts' notest
end
	
program define Display
	DispTbl `0'
	DispLR
end

program define DispLR
	if "`e(ll_c)'" == "" {
		*di in green "Wald test of sigma_u=0:             " _c
		*di in green "chi2(" in ye "1" in gr ") = " /*
                */ in ye %8.2f e(chi2_c) _c
        	*di in green "    Prob > chi2 = " in ye %6.4f /*
                */ chiprob(1,e(chi2_c))
	}
	else {
		tempname pval
                scalar `pval' =  chiprob(1, e(chi2_c))*0.5
                if e(chi2_c)==0 { scalar `pval'= 1 }
		if ((e(chi2_c) > 0.005) & (e(chi2_c)<1e4)) | (e(chi2_c)==0) {
                        local fmt "%8.2f"
                }
                else    local fmt "%8.2e"
                di in green "Likelihood-ratio test of sigma_u=0: " _c
                di in green in smcl "{help j_chibar##|_new:chibar2(01)=}" /*
                        */ in ye `fmt' e(chi2_c) _c
                di in green " Prob>=chibar2 = " in ye %5.3f /*
                        */ `pval'
	}
end
