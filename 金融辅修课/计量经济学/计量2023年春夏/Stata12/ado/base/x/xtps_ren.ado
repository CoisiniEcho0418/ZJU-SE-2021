*! version 3.4.0  09jun2011
program define xtps_ren, eclass /* old version of xtpoisson for -re normal- */
        version 6.0, missing
        if replay() {
                if "`e(cmd)'" != "xtpoisson" & "`e(cmd2)'" != "xtpoisson" {
                        error 301
                }
                Display `0'
		exit
        }

	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	`vv' Estimate `0'
end

program define Estimate, eclass
        version 6.0, missing
	#delimit ;
	syntax [varlist(fv)] [if] [in] [iweight aweight pweight]
			, call(real) [ I(varname) Exposure(varname num) RE
			IRr EFORM Level(passthru) noCONstant noSKIP noREFINE
			OFFset(varname num) FROM(string) Quad(int 12)
			noLOg GAUSSian NORMAL INTMethod(string) *] ;
	#delimit cr

	local fvops = "`s(fvops)'" == "true" | _caller() >= 11
	local tsops = "`s(tsops)'" == "true"
	if _caller() >= 11 {
		if _caller() < 11 {
			local vv "version 11:"
		}
		else	local vv : di "version " string(_caller()) ":"
		local negh negh
		local fvexp expand
	}
	else {
		local vv "version 8.1:"
	}

	tempvar isort
	qui gen long `isort' = _n

	if `call' < 10.0 {
		if "`intmeth'"=="" {
			local intmeth aghermite
		}
	}
	local madapt madapt
	if "`intmeth'" != "" {
		local len = length("`intmeth'")
		if "`intmeth'" != 				///
			substr("ghermite",1,max(2,`len')) &	///
			"`intmeth'" != 				///
				substr("aghermite",1,max(3,`len')) & ///
			"`intmeth'" !=				///
				substr("mvaghermite",1,max(2,`len')) {
			version 11: ///
			di as err "{cmd:intmethod()} must be ghermite, " ///
				"aghermite, or mvaghermite"
			exit(198)
		}
		if "`intmeth'" == substr("ghermite",1, max(2,`len')) {
			local intmeth ghermite
			local stdquad stdquad
			local madapt
		}
		if "`intmeth'" == substr("aghermite",1, max(2,`len')) {
			local intmeth aghermite
			local madapt
		}
	}
	if "`madapt'" != "" {
		local intmeth mvaghermite
	}

	_get_diopts diopts options, `options'
	mlopts mlopt rest, `options'
	local coll `s(collinear)'
	local constr `s(constraints)'
	if "`rest'"!="" {
		di in red "`rest' invalid"
		exit 198
	}

	if "`skip'" == "" | `"`from'"'!="" | "`constan'"!="" {
		local skip "skip"
	}
	if "`skip'"=="noskip" {
		local skip
	}
        if "`weight'" == "aweight" | "`weight'" == "pweight" {
                noi di in red /*
		*/ "`weight' not allowed for fixed- and random-effects cases"
                exit 101
        }

				/* parsing complete	*/

				/* mark sample		*/

	marksample touse
	markout `touse' `offset' `exposur'
	xt_iis `i'
	local ivar "`s(ivar)'"
	markout `touse' `ivar', strok


        if "`eform'" != "" { local irr "irr" }
        local disparg "`level' `irr'"

	if "`normal'" != "" {
		local gaussia "Gaussian"
	}

	tempvar ovar
	if "`offset'" != "" {
		qui gen double `ovar' = `offset'
		local oarg "offset(`ovar')"
		local offstr "`offset'"
	}
	else    qui gen byte `ovar' = 0

	if "`exposur'"' != "" {
		if "`offset'"!="" {
			version 11: ///
			di in red "may not specify both {cmd:exposure()} " ///
				"and {cmd:offset()}"
			exit 198
		}
		capture drop `ovar'
		qui gen double `ovar' = ln(`exposur')
		local oarg "offset(`ovar')"
		local offstr "ln(`exposur')"
	}

	quietly {
		tokenize `varlist'
		local dep "`1'"
		_fv_check_depvar `dep'
		mac shift
		local ind "`*'"
		count if `dep' < 0 & `touse'
		if r(N) {
			noi di in red _n "`dep'<0 in `r(N)' obs."
			exit 459
		}

		count if `touse'
		local nobs = r(N)
		if `quad' < 4 | `quad' > 195 {
			di in red "number of quadrature points " /*
				*/ "must be between 4 and 195"
			exit 198
		}
		if `quad' > r(N) {
			noi di in red "number of quadrature points " /*
				*/ "must be less than or equal to " /*
				*/ "number of obs"
			exit 198
		}

		`vv' noi _rmcoll `ind' if `touse', `constan' `coll' `fvexp'
		local ind "`r(varlist)'"
		local p : word count `ind'

		if "`ind'" == "" & "`constan'" != "" {
			noi di in red "must have at least one covariate"
			exit 198
		}
		if "`ind'" == "" {
			local skip "skip"
		}

                local k 1
                while `k' <= `p' {
                        local wrd : word `k' of `ind'
                        local names "`names' `dep':`wrd'"
                        local k = `k'+1
                }
		if "`constan'" == "" {
			local names "`names' `dep':_cons lnsig2u:_cons"
		}
		else {
			local names "`names' lnsig2u:_cons"
		}

		if "`constan'" == "" {
			local p = `p' + 1
		}

                if "`from'" != "" {
                        local arg `from'
                        tempname from
			`vv' ///
                        noi _mkvec `from', from(`arg') colnames(`names') /*
                                */ error("from()")
                }

                tempvar T
                sort `touse' `ivar' `isort'
                if "`weight'" != "" {
                        tempvar wv
                        qui gen double `wv' `exp' if `touse'
                        _crcchkw `ivar' `wv' `touse'
                        drop `wv'
                }
                by `touse' `ivar': gen int `T' = _N if `touse'
                summarize `T' if `touse' & `ivar'~=`ivar'[_n-1], meanonly
                local ng = r(N)
                local g1 = r(min)
                local g2 = r(mean)
                local g3 = r(max)

                local lll = cond("`log'"~="", "quietly", "noisily")

		local title "Random-effects Poisson regression"
		if "`gaussia'" == "" {
			local distr "Gamma"
			local theta "/invln_a"
		}
		else {
			local distr "Gaussian"

		}

		tempname beta rho
		if "`from'" == "" {
			`lll' di in gr _n "Fitting comparison Poisson model:"
			`vv' ///
			`lll' poisson `dep' `ind' [`weight'`exp'] /*
				*/ if `touse', constr(`constr') /*
				*/ `oarg' `constan' nodisplay collinear
			local llprob = e(ll)
			mat `beta' = e(b)
			mat `rho' = (0)
			mat `beta' = `beta',`rho'
			local cb = colsof(`beta')
			local nn : word count `ind'
			local nn = `nn' + 1 + ("`constan'" == "")
			if ("`constr'" != "" & "`coll'"!="" & `nn'>`cb') {
				tempname bt Vt T a C
				mat `bt' = J(1,`nn',0)
				local cnms `ind'
				if "`constan'"=="" {
					local cnms `ind' _cons
				}
				local cnms `cnms' _cons2
				mat colnames `bt' = `cnms'
				mat rownames `bt' = `dep'
				mat `Vt' = J(`nn',`nn',0)
				mat colnames `Vt' = `cnms'
				mat rownames `Vt' = `cnms'
				est post `bt' `Vt'
				makecns `constr'
				matcproc `T' `a' `C'
				_b_fill0 `beta' "`cnms'", noeq
				mat `beta' = `beta'*`T'
				mat `beta' = `beta'*`T'' + `a'
			}
			local cb = colsof(`beta')
			forv i = 2/`cb' { /* one less than cb */
				local ceq "`ceq' `dep'"
			}
			mat coleq `beta' = `ceq' lnsig2u:_cons
			mat `beta'[1, `cb'] = -.2
		}
		else {
			mat `beta' = `from'
                        local refine "norefine"
			noi di
			local skip "skip"
		}
		local sna : colnames(`beta')
		local snp : word count `sna'
		local pp1 : word count `names'
		if `pp1' != `snp' {
			* Means that some predictor was dropped
			* because user gave short from vector.
			if "`from'" == "" {
				di in red "unable to identify sample"
			}
			else {
				local nr = rowsof(`from')
				local nc = colsof(`from')
				di in red "`from' (`nr'x`nc') is " _c
				di in red "not correct length " _c
				di in red "-- should be (1x`pp1')"
			}
			exit 198
		}
		if "`log'" == "" { local lll "noisily" }
		else             { local lll "quietly" }

		tempvar o w
		if "`weight'" == "" {
			qui gen double `w' = 1 if `touse'
		}
		else {
			qui gen double `w' `exp' if `touse'
		}

		if "`stdquad'"=="" {
			tempvar shat hh
			qui generate double `shat' = 1
			qui generate double `hh' = 0
			/* set global with shat variable for adapquad */
			global XTP_shat `shat'
			/* set global with hh variable for adapquad */
			global XTP_hh `hh'
			global XTP_noadap
		}
		else {
			global XTP_noadap noadap
		}
		global XTP_quad `quad'
		tempvar qavar qwvar
		qui gen double `qavar' = .
		qui gen double `qwvar' = .
		global XTP_qavar `qavar'
		global XTP_qwvar `qwvar'
		global XTP_madapt `madapt'
		tempname lnf
		scalar `lnf' = .
		global XTP_lnf `lnf'

		sort `touse' `ivar' `isort'
		tempvar pp
		qui gen long `pp' = _n*`touse' /* if `touse' */
		summ `pp' if `touse'
		local j0 = r(min)
		local j1 = r(max)
	}
	_GetQuad, avar(`qavar') wvar(`qwvar') quad(`quad')
	tempname rhov
	if "`skip'" == "" & "`ind'" != "" {
		tempname beta0 rho
		`vv' ///
		qui poisson `dep' in `j0'/`j1' `wtxp', `oarg' iter(1)
		mat `beta0' = get(_b)
		mat `rho' = (-.2)
		mat `beta0' = `beta0',`rho'
		`lll' di _n in gr "Fitting constant-only model:" _n

		/// Calculate logF (by panel) used to prevent underflow
		quietly{
			mat colnames `beta0' = `dep':_cons lnsig2u:_cons
			tempvar xb
			mat score `xb' = `beta0' if `touse', eq(`dep')
			tempvar logFc
			gen double `logFc' = -exp(`xb') +`dep'*`xb' -   ///
				lngamma(`dep'+1) if `touse'
			bys `touse' `ivar': replace `logFc' = `logFc' + ///
				`logFc'[_n-1] if _n>1 & `touse'
			bys `touse' `ivar': replace `logFc' = `logFc'[_N] ///
				if `touse'
			global XTP_logF `logFc'
			if "`stdquad'" != "" {
				drop `xb'
			}
		}
		/// done!

		if `"`refine'"' != "norefine" {
			`lll' _GetRho `dep' in `j0'/`j1', ivar(`ivar') ///
				w(`w') rho(`rhov') b(`beta0') `oarg'   ///
				avar(`qavar') wvar(`qwvar') 	       ///
				quad(`quad') poisson logF(`logFc')
		}
		if "`stdquad'"=="" & "`madapt'"=="" {
			`lll' _GetAdap `dep' in `j0'/`j1', i(`ivar')	///
				w(`w') `oarg' shat(`shat') hh(`hh')	///
				b(`beta0') `oarg' poisson logF(`logFc')
		}
		if "`madapt'" != "" {
			tempvar lnfv
			qui gen double `lnfv' = .
			tempname g negH
			/* Calling the log likelihood calculator will get the
   			   adaptive quadrature parameters shat and hh */
			_XTLLCalc `dep'  in `j0'/`j1', xbeta(`xb') 	///
				w(`w') lnf(`lnfv') b(`beta0') g(`g')	///
				negH(`negH') quad($XTP_quad) 		///
				ivar(`ivar')  todo(0) `madapt' poisson	///
				avar(`qavar') wvar(`qwvar')	 	///
			 	shat(`shat') hh(`hh') logF(`logFc')
		}
		if "`hh'" != "" {
			/// modify logFc for this information
			quietly {
				drop `logFc'
				replace `xb' = `xb' + `hh'
				gen double `logFc' = -exp(`xb') +       ///
					`dep'*`xb' - lngamma(`dep'+1)   ///
					if `touse'
				bys `touse' `ivar': replace `logFc' =   ///
					`logFc' + `logFc'[_n-1]         ///
					if _n>1 & `touse'
				bys `touse' `ivar': replace `logFc' =   ///
					`logFc'[_N] if `touse'
				global XTP_logF `logFc'
				drop `xb'
			}
		}
		/// done
		`vv' ///
		`lll' ml model d2 xtpoisson_d2 (`dep'=, `constan' `oarg')  ///
			/lnsig2u  [iw=`w'] in `j0'/`j1', init(`beta0',copy) ///
			`nolog' max `mlopt' search(off) nopreserve ///
			nocnsnotes `negh'
		`lll' di in green _n "Fitting full model:" _n
		/* continue option added for Likelihood ratio test */
		local mlopt `mlopt' continue
	}
	else if "`llprob'" != "" {
		`lll' di in green _n "Fitting full model:" _n
	}
	global XTP_madapt `madapt' /* could be changed from cons. only model */
	scalar `lnf' = . /* could be changed from cons. only model */
	/// Calculate logF (by panel) used to prevent underflow
	quietly {
		`vv' ///
		mat colnames `beta' = `ind' _cons
		tempvar xb
		mat score `xb' = `beta' if `touse', eq(`dep')
		if "`ovar'"!="" {
			replace `xb' = `xb' + `ovar' if `touse'
		}
		tempvar logF
		gen double `logF' = -exp(`xb') +`dep'*`xb' -    ///
			lngamma(`dep'+1) if `touse'
		bys `touse' `ivar': replace `logF' = `logF' +   ///
			`logF'[_n-1] if _n>1 & `touse'
		bys `touse' `ivar': replace `logF' = `logF'[_N] ///
			if `touse'
		global XTP_logF `logF'
		if "`stdquad'"!="" {
			drop `xb'
		}
	}
	/// done!

	if `"`refine'"' != "norefine" {
		`lll' _GetRho `dep' `ind' in `j0'/`j1', ivar(`ivar') 	///
			w(`w') rho(`rhov') b(`beta') `oarg'		///
			avar(`qavar') wvar(`qwvar') 			///
			quad(`quad') poisson logF(`logF')
	}
	if "`stdquad'"==""  & "`madapt'"==""  {
		`lll' _GetAdap `dep' `ind' in `j0'/`j1', shat(`shat') ///
		hh(`hh') poisson ivar(`ivar') b(`beta') `constan'     ///
		`oarg' logF(`logF')
	}
	if "`madapt'" != "" {
		tempvar lnfv
		qui gen double `lnfv' = .
		tempname g negH
		/* Calling the log likelihood calculator will get the
   		   adaptive quadrature parameters shat and hh */
		_XTLLCalc `dep' `ind' in `j0'/`j1', xbeta(`xb') w(`w') 	///
			lnf(`lnfv') b(`beta') g(`g') negH(`negH')	///
			quad($XTP_quad) ivar(`ivar') `constan' todo(0)	///
			`madapt' poisson avar(`qavar') wvar(`qwvar') ///
			 shat(`shat') hh(`hh') logF(`logF')
	}
	if "`hh'" != "" {
		/// modify logF for this information
		quietly {
			drop `logF'
			replace `xb' = `xb' + `hh' if `touse'
			gen double `logF' = -exp(`xb') +`dep'*`xb' -    ///
				lngamma(`dep'+1) if `touse'
			bys `touse' `ivar': replace `logF' = `logF' +   ///
				`logF'[_n-1] if _n>1 & `touse'
			bys `touse' `ivar': replace `logF' = `logF'[_N] ///
				if `touse'
			global XTP_logF `logF'
			drop `xb'
		}
		/// done
	}
	`vv' ///
	`lll' ml model d2 xtpoisson_d2 (`dep'=`ind', `constan' `oarg') ///
		/lnsig2u [iw=`w'] in `j0'/`j1', init(`beta', copy) ///
		`log' max `mlopt' search(off) nopreserve `negh' ///
		collinear missing

	if !`fvops' {
		tempname cns
		capture mat `cns' = get(Cns)
		if _rc==0 {
			est matrix constraint = `cns'
		}
	}
	est local r2_p
	est local cmd
	est local offset
	est scalar n_quad = `quad'
        est local intmethod "`intmeth'"
	est local distrib "`distr'"
        est local title   "`title'"
        est local wtype  "`weight'"
        est local wexp   "`exp'"
        est scalar N_g    = `ng'
        est scalar g_min  = `g1'
        est scalar g_avg  = `g2'
        est scalar g_max  = `g3'
        tempname b v
        mat `b' = get(_b)
	`vv' ///
        mat colnames `b' = `names'
	if !`fvops' {
        	mat `v' = get(VCE)
		`vv' ///
        	mat colnames `v' = `names'
		`vv' ///
        	mat rownames `v' = `names'
        	mat post `b' `v', depname(`dep') noclear
	}
	else {
		mat repost b=`b', rename buildfvinfo
	}

	if "`llprob'" != "" {
		est scalar ll_c   = `llprob'
		est scalar chi2_c  = cond([lnsig2u]_b[_cons]<=-14, 0, /*
                        */ abs(-2*(e(ll_c)-e(ll))))
		est local chi2_ct "LR"
	}

	est scalar sigma_u = exp(.5*[lnsig2u]_b[_cons])
	*est scalar rho    = e(sigma_u)^2 / (1 + e(sigma_u)^2)

	est scalar k_aux = 1
	est hidden local diparm1 lnsig2u, label("sigma_u") /*
		*/ function(exp(.5*@)) /*
		*/ derivative(.5*exp(.5*@))
	est local ivar "`ivar'"
	est local offset /* undo from xtgee */
	est local offset1 "`offstr'"
	est local predict xtcnt_p
	est local model "re"
	est local cmd "xtpoisson"

        Display, `disparg' `diopts'
        global XTP_madapt
        global XTP_noadap
        global XTP_qavar
        global XTP_qwvar
        global XTP_quad
        global XTP_shat
        global XTP_hh
	global XTP_logF
	global XTP_lnf
end

program define Display
	syntax [, Level(cilevel) IRr *]

	_get_diopts diopts, `options'
        if "`irr'" != "" { local earg "eform(IRR)" }

        _crcphdr
	version 10: ml di, nohead `earg' `diopts'

	if "`e(distrib)'" != "" & "`e(ll_c)'" != "" {
		if "`e(distrib)'" == "Gaussian" {
			di in gr /*
			*/ "Likelihood-ratio test of sigma_u=0: " _c
			local prob Pr
		}
		else {
			di in gr /*
			*/ "Likelihood-ratio test of alpha=0: " _c
			local prob Prob
		}
		tempname pval
                scalar `pval' =  chiprob(1, e(chi2_c))*0.5
                if e(chi2_c)==0 { scalar `pval'= 1 }
		if ((e(chi2_c) > 0.005) & (e(chi2_c)<1e4)) | (e(chi2_c)==0) {
                        local fmt "%8.2f"
                }
                else    local fmt "%8.2e"
                di in green in smcl "{help j_chibar##|_new:chibar2(01) = }" /*
                        */ in ye `fmt' e(chi2_c) _c
                di in green " `prob'>=chibar2 = " in ye %5.3f /*
                        */ `pval'
	}
        if e(N_cd) <. {
		if e(N_cd) > 1 { local s "s" }
                di in bl _n /*
		*/ "Note: `e(N_cd)' completely determined panel`s'"
        }
end

