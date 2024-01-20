*! version 1.5.2  22jun2011
program define xtreg_re, eclass
	local version = string(_caller())
	_vce_parserun xtreg, panel mark(I CLuster) : `0'
	if "`s(exit)'" != "" {
		exit
	}
	version 6, missing
	local options "Level(cilevel) OLD THeta SA SAF"
	local options "`options' Robust CLuster(passthru) NONEST"
/* NOte SAF is an undocumented option to force Swamy-Arora exact calculation
  for balanced panels.  Used in test scripts.  dmd  */
  
	if replay() {
		if "`e(model)'" ~= "re" { 
			error 301 
		}
		syntax [, `options' *]
		_get_diopts diopts, `options'
		local cfmt `"`s(cformat)'"'
	}
	else { 
		syntax varlist(fv ts) [if] [, `options' VCE(passthru) ///
			I(varname) RE *]

		_get_diopts diopts, `options'
		local fvops = "`s(fvops)'" == "true" | _caller() >= 11
		local cfmt `"`s(cformat)'"'


		xt_iis `i'
		local ivar "`s(ivar)'"
		capture tsset, noquery
		if _rc == 0 {
			local ivar `r(panelvar)'
			local tvar `r(timevar)'
		}

		_vce_parse, argopt(CLuster) opt(CONVENTIONAL Robust) old ///
			: , `vce' `robust' `cluster'
		local robust `r(robust)'
		local cluster `r(cluster)'
		if `version' >= 11 & "`robust'" != "" & "`cluster'" == "" {
			local robust 
			local cluster `ivar'
		}	
		
		local vce = cond("`r(vce)'" != "", "`r(vce)'", "conventional")

/*
		xt_iis `i'
		local ivar "`s(ivar)'"
		capture tsset, noquery
		if _rc == 0 {
			local ivar `r(panelvar)'
			local tvar `r(timevar)'
		}
*/		

		tempname T Tbar s_e s_u thetav Bf VCEf n T_new N_clust rmse
		tempvar touse dup T_i XB U tmp tv
		mark `touse' `if'
		markout `touse' `varlist' `ivar'
		qui count if `touse'
		if r(N)<3 { 
			error cond(r(N)==0,2000,2001)
			/*NOTREACHED*/
		}

/* Next two lines added to check for collinearity 13oct2003 bpp */
		if `fvops' {
			local rmcoll "version 11: _rmcoll"
			local fvexp expand
		}
		else	local rmcoll _rmcoll
		noi `rmcoll' `varlist', `fvexp'
		local varlist "`r(varlist)'"
		local oldvars : copy local varlist
		gettoken y xvars : varlist
		_fv_check_depvar `y'

		if `fvops' {
			fvrevar `varlist'
			local varlist `r(varlist)'
			local fvopts findomitted buildfvinfo
		}
		else {
			tsrevar `varlist'
			local varlist `r(varlist)'
		}
		gettoken tmpdep xvars : varlist

		sort `ivar' `tvar' `touse'
		preserve
		quietly  {
			tempname sa_N sa_n sa_K
					/* obtain fixed-effects estimates */
			keep if `touse'
			keep `varlist' `ivar' `cluster'
			ffxreg2 `varlist', i(`ivar') 
			scalar `sa_N'=e(N)
			scalar `s_e' = sqrt(e(sse)/e(df_t))
			matrix `Bf' = get(_b)
			matrix `VCEf' = get(VCE)
			restore, preserve
			keep if `touse'
			keep `varlist' `ivar' `touse' `cluster'

						/* count T_i		*/
			by `ivar': gen long `T_i'=_N if _n==_N
			summ `T_i' 
			scalar `T' = r(max)

			local g1 = r(min)
			local g2 = r(mean)
			local g3 = r(max)

			if "`old'"!="" { 
				scalar `Tbar' = r(mean) 
			}

			if `T'==r(min) {		/* min=max, constant */
				local T_cons 1
				local consopt "hascons"
				drop `T_i'
			}
			else {
				local T_cons 0
				local consopt "nocons"
				by `ivar': replace `T_i'=_N
			}

			if "`old'"=="" {
				by `ivar' : gen double `T_new' = 1/_N if _n==_N
				summ `T_new'
				scalar `Tbar' = 1/r(mean)
				drop `T_new'
			}

						/* create averages 	*/
			by `ivar': gen byte `dup' = cond(_n==_N,2,1)
			expand `dup'
			sort `ivar' `dup' 
			by `ivar': replace `dup'=cond(_n<_N,0,1)
						/* dup=0,1; 1->mean obs */

						/* here is where varlist
						   is converted to double */
			tokenize `varlist'
			local i 1
			while "``i''"!="" {
				by `ivar': gen double `tv' = /*
				*/ cond(`dup',sum(``i''[_n-1])/(_n-1),``i'')
				drop ``i''
				rename `tv' ``i''
				local i=`i'+1
			}

					/* obtain between-effects estimates */
			_regress `varlist' if `dup'
			scalar `sa_K'=e(df_m)+1
			scalar `n' = e(N)
			if ( "`sa'" != ""  & `T_cons'==0 ) | /* 
				*/ "`saf'" != "" {

				tempvar res_b2
				
				predict double `res_b2' if !`dup' , res 
				
				tempvar i_obs i_obs2
				tempname ti_max ti_min ti_ave Zi tr trmat
				tempname ubPub_m ubPub xpx xzx

				gen `i_obs'=1 if !`dup'

				by `ivar':  gen `i_obs2' = sum(`i_obs') 
	
				replace `i_obs'=`i_obs2'
	
				by `ivar': replace `i_obs2'= /* 
					*/ cond(_n==_N,`i_obs2', .)

				sum `i_obs2'
		
				scalar `ti_max'=r(max)
				scalar `ti_min'=r(min)
				scalar `ti_ave'=r(mean)

				by `ivar': replace `i_obs2'=`i_obs2'[_N] /*
					*/ if !`dup'

				mat `Zi'=J(`ti_max',`ti_max',1)

				mat glsaccum `ubPub_m' = /* 
					*/ `res_b2' [iweight = 1/`i_obs2'] /*
					*/ if ~`dup' , /*
					*/ group(`ivar') glsmat(`Zi') /*
					*/ row(`i_obs')
	
				di "scalar `ubPub' = `ubPub_m'[1,1]"
				scalar `ubPub' = `ubPub_m'[1,1]

				mat glsaccum `xpx' = `xvars' /*
					*/ [iweight = 1/`i_obs2'] /* 
					*/ if !`dup', /*
					*/ group(`ivar') glsmat(`Zi') /* 
					*/ row(`i_obs')

				mat glsaccum `xzx' = `xvars' if !`dup', /*
					*/ group(`ivar') glsmat(`Zi') /* 
					*/ row(`i_obs')
	
				mat `trmat'=syminv(`xpx')
	
				mat `trmat'=`trmat'*`xzx'
	
				scalar `tr' = trace(`trmat')

				scalar `s_u'= sqrt( /* 
					*/ (`ubPub'- (`n'-`sa_K')*`s_e'^2) /*
					*/ / ( `sa_N'-`tr')  )

			}
			else {
				scalar `s_u' = sqrt((e(rmse)^2) -`s_e'^2/`Tbar')
			}	

					/* obtain theta			  */
			if `s_u'>=. { 
				scalar `s_u' = 0 
				if `T_cons' {
					scalar `thetav' = 0
				}
				else	gen byte `thetav' = 0
			}
			else {
				if `T_cons' {
					scalar `thetav' = /*
					*/ 1-`s_e'/sqrt(`T'*`s_u'^2+`s_e'^2)
				}
				else {
					by `ivar': gen double `thetav' = /*
					*/ 1-`s_e'/sqrt(`T_i'*`s_u'^2+`s_e'^2)/*
					*/ if !`dup'
				}
			}

				/* obtain random-effects estimates	*/
				/* now that varlist is already double	*/
			local i 1
			while "``i''"!="" {
				by `ivar': replace ``i''= /*
					*/ ``i''-`thetav'*``i''[_N] if !`dup'
				local i=`i'+1
			}
			drop if `dup'
			tempvar cons
			gen double `cons' = 1-`thetav'

			if "`cluster'" != "" {
				if "`nonest'" == "" {
					if _caller() < 9.1 {
						_xtreg_chk_cl `cluster' `ivar'
					}
					else {
						_xtreg_chk_cl2 `cluster' `ivar'
					}
				}	
				local clopt "cluster(`cluster')"
			}

			_regress `varlist' `cons', `consopt' `robust' `clopt'
			scalar `rmse' = e(rmse)
			scalar `N_clust' = e(N_clust)
		}

		tempname B V
		local   depv  = "`1'"
		local   nobs  = e(N)

		mat `B' = get(_b)
		mat `V' = get(VCE)
		if `T_cons'==1 {
			local cols = colsof(`B') - 1
			mat `B' = `B'[1,1..`cols']
			mat `V' = `V'[1..`cols',1..`cols']
		}
		else	local cols = colsof(`B')
		loc depname : word 1 of `oldvars'
		loc rhsname : subinstr local oldvars "`depname'" ""
		version 11: mat colnames `B' = `rhsname' _cons
		version 11: mat rownames `V' = `rhsname' _cons
		version 11: mat colnames `V' = `rhsname' _cons
		est post `B' `V', depname(`depname') obs(`nobs')
		_post_vce_rank

		_prefix_model_test xtreg

		est mat bf `Bf'
		est mat VCEf `VCEf'

		local `cols'
		global S_E_vl `*'  /* double save */
		local names

		est local depvar `depname'

		global S_E_depv "`depname'"   /* double save */
		global S_E_if `"`if'"'

		est scalar sigma_u = `s_u'
		est scalar sigma_e = `s_e'
		est scalar sigma   = sqrt(`s_u'^2+`s_e'^2)
		est scalar rho     = `s_u'^2/(`s_u'^2+`s_e'^2)
		est scalar rmse    = `rmse'
		est local ivar `ivar'

		scalar S_E_ui = `s_u'        /* double save */
		scalar S_E_eit = `s_e'
		global S_E_ivar "`ivar'"

		est scalar N = `nobs'
		*est scalar T = `T'
		est scalar Tbar = `Tbar'
		est scalar Tcon = `T_cons'
		est scalar N_g = `n'
		est local sa "`sa'`saf'"

		est scalar g_min = `g1'
		est scalar g_avg = `g2'
		est scalar g_max = `g3'

		scalar S_E_nobs = `nobs'     /* double save */
		scalar S_E_T = `T'
		scalar S_E_Tbar = `Tbar'
		global S_E_Tcon   `T_cons'
		scalar S_E_n = `n'
		scalar S_E_mdf = e(df_m)
		scalar S_E_chi2 = e(chi2)


		if e(Tcon) { 
			est scalar theta = `thetav'
			scalar S_E_thta = `thetav'   /* double save */
		}
		else quietly {
			by `ivar': replace `thetav'=. if _n!=_N
			summ `thetav', d
			est scalar thta_min = r(min)
			est scalar thta_5   = r(p5)
			est scalar thta_50  = r(p50)
			est scalar thta_95  = r(p95)
			est scalar thta_max = r(max)
			tempname myth
			mat `myth' = (r(min), r(p5), r(p50), r(p95), r(max))
			est mat theta `myth'
		}
		restore
		quietly {
			tempvar mysamp sumxb sumtdep last
			gen byte `mysamp' = `touse'
			est repost, esample(`mysamp') `fvopts'

			local ncnsmod = 1

					/* obtain R^2 overall	*/
			_predict double `XB' if `touse', xb
			quietly sum `XB'
			if (r(sd)<1e-8) {
				est scalar r2_o = 0
				local ncnsmod = 0
			}
			else {
				corr `XB' `tmpdep'
				est scalar r2_o = r(rho)^2
			}
			scalar S_E_r2o = e(r2_o)      /* double save */
			sort `ivar' `touse'
					/* obtain R^2 between */

			by `ivar' `touse': gen `last' = 		/*
				*/ cond(_n==_N & `touse',1,0) 

			by `ivar' `touse': gen double `sumxb' = 	/*
				*/ sum(`XB'/_N)

			sum `sumxb' if `last'

			if (r(sd)<1e-8) {
				local ncnsmod = 0
			}	


			by `ivar' `touse': gen double `sumtdep' = 	/*
				*/ sum(`tmpdep'/_N) 

			sum `sumtdep' if `last'
			if (r(sd)<1e-8) {
				local ncnsmod = 0
			}	

			by `ivar' `touse': gen double `U' = /*
				*/ cond(_n==_N & `touse', /*
				*/ `sumxb', . )

			by `ivar' `touse': gen double `tmp' = /* 
				*/ cond(_n==_N & `touse', /*
				*/ `sumtdep', .)

			if (`ncnsmod') {
				corr `U' `tmp'
				est scalar r2_b = r(rho)^2
			}
			else {
				est scalar r2_b = 0
			}

			scalar S_E_r2b = e(r2_b)     /* double save */

				/* obtain R^2 within */
			by `ivar' `touse': replace `U' = `XB'-`U'[_N]
			by `ivar' `touse': replace `tmp'=`tmpdep'-`tmp'[_N]
			if (`ncnsmod') {
				corr `U' `tmp'
				est scalar r2_w = r(rho)^2
			}
			else {
				est scalar r2_w = 0
			}
			scalar S_E_r2w = e(r2_w)    /* double save */

			drop `U' `tmp'
			

		}
		
		if "`robust'" != "" | "`cluster'" != "" {
			est local vcetype "Robust"
		}
		est local vce "`vce'"
		if "`cluster'" != "" {
			est local clustvar "`cluster'"
			est scalar N_clust = `N_clust'
		}

		est local ivar "`ivar'"
		est local model re
		est local predict "xtrere_p"
		est local marginsnotok E U UE SCore STDP XBU
		est local cmd "xtreg"
		global S_E_cmd2 "xtreg_re"    /* double save */
		global S_E_cmd "xtreg"
	}

	if e(Tcon) {
		local Twrd "    T"
	}
	else	local Twrd "T-bar"

	#delimit ;
	di _n in gr "Random-effects GLS regression" 
		_col(49) in gr "Number of obs" _col(68) "=" 
		_col(70) in ye %9.0f e(N) ;
	di in gr "Group variable: " in ye abbrev("`e(ivar)'",12) in gr
		_col(49) "Number of groups" _col(68) "="
		_col(70) in ye %9.0g e(N_g) _n ;
	di in gr "R-sq:  within  = " in ye %6.4f e(r2_w)
		_col(49) in gr "Obs per group: min" _col(68) "="
		_col(70) in ye %9.0g e(g_min) ;
	di in gr "       between = " in ye %6.4f e(r2_b)
		_col(64) in gr "avg" _col(68) "="
		_col(70) in ye %9.1f e(g_avg) ;
	di in gr "       overall = " in ye %6.4f e(r2_o)
		_col(64) in gr "max" _col(68) "="
		_col(70) in ye %9.0g e(g_max) _n ;

	if !missing(e(chi2)) { ;
		di in gr _col(49) "`e(chi2type)' chi2("
				in ye e(df_m) in gr ")" _col(68) "="
			_col(70) in ye %9.2f e(chi2) ;
		di in gr "corr(u_i, X)" _col(16) "= " in ye "0"
			in gr " (assumed)" _col(49) "Prob > chi2" _col(68) "="
			_col(73) in ye %6.4f chiprob(e(df_m),e(chi2)) ;
	} ;
	else { ;
                di in gr _col(49) in smcl
		"{help j_robustsingular##|_new:`e(chi2type)' chi2(`e(df_m)')}" 
			_col(68) "=" _col(70) in ye %9.2f e(chi2) ;
                di in gr "corr(u_i, X)" _col(16) "= " in ye "0"
                        in gr " (assumed)" _col(49) "Prob > chi2" _col(68) "="
                        _col(73) in ye %6.4f chiprob(e(df_m),e(chi2)) ;
	} ;
	#delimit cr

	if "`theta'" != "" {
		if e(Tcon) {
			di in gr "theta" _col(16) "= " in ye e(theta)
		}
		else {
			di as smcl in gr _n "{hline 19} theta {hline 20}"
			di in gr "  min      5%       median        95%" /*
				*/ "      max" 
			di in ye %6.4f e(thta_min) %9.4f e(thta_5) /*
				*/ %11.4f e(thta_50) %11.4f e(thta_95) /*
				*/ %9.4f e(thta_max) 

		}
	}
	display

	_coef_table, level(`level') plus `diopts'
	local c1 = `"`s(width_col1)'"'
	local w = `"`s(width)'"'
	capture {
		confirm integer number `c1'
		confirm integer number `w'
	}
	if c(rc) {
		local c1 13
		local w 78
	}
	local c = `c1' - 1
	local rest = `w' - `c1' - 1
	if `"`cfmt'"' != "" {
		local rho	: display `cfmt' e(rho)
		local sigma_u	: display `cfmt' e(sigma_u)
		local sigma_e	: display `cfmt' e(sigma_e)
	}
	else {
		local rho	: display %10.0g e(rho)
		local sigma_u	: display %10.0g e(sigma_u)
		local sigma_e	: display %10.0g e(sigma_e)
	}
	di in smcl in gr %`c's "sigma_u" " {c |} " in ye %10s "`sigma_u'"
	di in smcl in gr %`c's "sigma_e" " {c |} " in ye %10s "`sigma_e'"
	di in smcl in gr %`c's "rho" " {c |} " in ye %10s "`rho'" /*
		*/ in gr "   (fraction of variance due to u_i)"
	di in smcl in gr "{hline `c1'}{c BT}{hline `rest'}"
end


/*
	ffxreg2:
		ffxreg2 varlist, i(ivar)
		defines mse, b and covariance matrix
		no syntax checking
		may corrupt data in memory.
*/
program define ffxreg2, eclass
	syntax varlist [, I(varname)]
	tokenize `varlist'
	local ivar `i'

	tempvar x tmp
	tempname sst sse

	quietly  {
		sort `ivar'

		summ `1'
		scalar `sst' = (r(N)-1)*r(Var)

		while ("`1'"!="") {
			by `ivar': gen double `x' = sum(`1')/_n
			summ `1'
			by `ivar': replace `x' = `1' - `x'[_N] + r(mean)
			drop `1'
			rename `x' `1'
			mac shift
		}

		count if `ivar'!=`ivar'[_n-1]
		local dfa = r(N)-1

		est clear
		_regress `varlist'
		local nobs = e(N)
		local dfb = e(df_m)
		scalar `sse' = e(rss)
		local dfe = e(df_r) - `dfa'
		if `dfe'<=0 | `dfe'>=. { noi error 2001 } 

		* we could avoid this if only we knew dfe in advance
		_regress `varlist', dof(`dfe')
		est scalar sse = `sse'
		est scalar df_m = `dfa' + `dfb'
		est scalar df_t = `nobs' - 1 - e(df_m)
		est scalar N = e(N)
	}
end
