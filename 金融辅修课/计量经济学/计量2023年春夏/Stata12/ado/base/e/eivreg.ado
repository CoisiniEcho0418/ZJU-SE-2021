*! version 1.3.5  12may2011
program define eivreg, eclass byable(recall)
	version 6, missing
	local options "Level(cilevel)"
	if !replay() {
		local cmdline : copy local 0
		syntax varlist(fv) [if] [in] [aw fw] [,	///
			`options' Reliab(string) *]
		_get_diopts diopts, `options'
		local fvops = "`s(fvops)'" == "true" | _caller() >= 11
		tokenize `varlist'
		local dv `1'
		_fv_check_depvar `dv'
		mac shift
		local ivars "`*'"

		marksample touse

		tempname xpx xx xy xxi b bp ev mm vv ym2 rr i origxx
		qui mat accum `xpx' = `dv' `ivars' if `touse' [`weight'`exp']
		local nobs = r(N)
		if `nobs'<=0 | `nobs'>=. { error 2001 }
		local dim = rowsof(`xpx')
		local NN = `xpx'[`dim',`dim']

		mat `xx' = `xpx'[2..`dim',2..`dim']
		mat `xxi' = syminv(`xx')
		local notcc = diag0cnt(`xxi')
		local nomit 0
		if `fvops' {
			tempname omit
			_ms_omit_info `xx'
			matrix `omit' = r(omit)
			local nomit = r(k_omit)
		}
		if `notcc' & `fvops' {
			local K = colsof(`omit')
			local notcc = 0
			forval k = 1/`K' {
				if `xxi'[`k',`k'] == 0 & `omit'[1,`k'] == 0 {
					local ++notcc
					continue, break
				}
			}
		}
		if `notcc' {
			di in red /*
			*/ "too few observations or collinear variables"
			exit 2001
		}
		mat drop `xxi'
		mat `origxx' = `xx'

		tokenize `"`reliab'"', parse(" ")
		while ("`*'"!="") {
			confirm variable `1'
			unabbrev `1'
			local 1 "`s(varlist)'"
			confirm number `2'
			local rlist "`rlist' `1' `2'"
			local rn = rownumb(`xx',"`1'")
			if `rn'>=. { 
				di in red "`1' not independent variable"
				exit 111
			}
			if `2'<=0 | `2'>1 {
				di in red "0 < r <= 1 required"
				exit 399
			}
			local vvxx = `xx'[`rn',`rn']
			local vm = `xpx'[`dim',`rn'+1]
			mat `xx'[`rn',`rn'] = /*
				*/ `vvxx' - (1-`2')*(`vvxx'-`vm'*`vm'/`NN')
			mac shift 2
		}
		local rlist "`rlist' * 1"
		mat `xy' = `xpx'[1,2..`dim']
		mat `xxi' = syminv(`xx')
		mat `b' = `xy' * `xxi'
		mat `ev' = (`b' * `xx') * `b''
		local Nmk = `NN' - `dim' + `nomit' + 1
		scalar `ym2' = (`xpx'[1,`dim'])^2/`NN'
		scalar `rr' = (`xpx'[1,1] - `ev'[1,1]) /(`Nmk')
					/* could be improved: */
		local r2 = (`ev'[1,1]-`ym2')/(`xpx'[1,1]-`ym2') 
		mat `vv' = ((`xxi' * `rr') * `origxx') * `xxi'
		scalar `i'=1
		while `i' <= rowsof(`vv') {
			local notcc = `vv'[`i',`i']<=0 
			if `notcc' & `fvops' {
				if `omit'[1,`i'] {
					local notcc 0
				}
			}
			if `notcc' {
				di in red "reliability r() too small"
				exit 399
			}
			scalar `i' = `i' + 1
		}
		est post `b' `vv' [`weight'`exp'], ///
			depname(`dv') dof(`Nmk') esample(`touse') buildfvinfo
		local colna : colna e(b)
		local cons _cons
		local colna : list colna - cons
		quietly test `colna'

		/* double save in S_E_<stuff> and e() */
		est scalar rmse = sqrt(`rr')
		est scalar df_m = r(df)
		est scalar df_r = r(df_r)
		est scalar F = r(F)
		est scalar N = `NN'
		est scalar r2 = `r2'
		est local rellist "`rlist'"
		global S_E_rmse `e(rmse)'
		global S_E_mdf `e(df_m)'
		global S_E_tdf `e(df_r)'
		global S_E_f `e(F)'
		global S_E_nobs `NN'
		global S_E_r2 `r2'
		global S_E_rvn "`rlist'"
		if "`weight'`exp'" != "" {
			est local wtype `"`weight'"'
			est local wexp `"`exp'"'
		}
		est local depvar "`dv'"
		est local predict "tobit_p"
		version 10: ereturn local cmdline `"eivreg `cmdline'"'
		est local cmd "eivreg"
		global S_E_cmd "eivreg"
		_post_vce_rank
	}
	else {
		if ("`e(cmd)'"!="eivreg") { error 301 }
		if _by() { error 190 }
		syntax [, `options' *]
		_get_diopts diopts, `options'
	}

	di in gr _n _col(20) "assumed" /*
		*/ _col(49) "Errors-in-variables regression" _n /*
		*/ _col(5) "variable" _col(18) "reliability"  
	di in smcl in gr "{hline 28}" /*
		*/ _col(56) "Number of obs =" in ye %8.0f e(N)

	tokenize "`e(rellist)'", parse(" ")
	local k 1
	while "`1'"!="" {
		di in gr %12s abbrev("`1'",12) _col(16) %10.4f `2' _col(56) _c
		mac shift 2
		if `k'==1 {
			di in gr "F(" %3.0f e(df_m) "," %6.0f e(df_r) ") =" /*
			*/ in ye %8.2f e(F)
		}
		else if `k'==2 {
			di in gr "Prob > F      =" /*
			*/ in ye %8.4f fprob(e(df_m),e(df_r),e(F))
		}
		else if `k'==3 {
			di in gr "R-squared     =" in ye %8.4f e(r2)
		}
		else if `k'==4 { 
			di in gr "Root MSE      =" in ye %8.0g e(rmse)
		}
		else	di
		local k=`k'+1
	}
	while `k'<=4 {
		di _col(56) _c
		if `k'==2 {
			di in gr "Prob > F      =" /*
			*/ in ye %8.4f fprob(e(df_m),e(df_r),e(F))
		}
		else if `k'==3 {
			di in gr "R-squared     =" in ye %8.4f e(r2)
		}
		else if `k'==4 { 
			di in gr "Root MSE      =" in ye %8.0g e(rmse)
		}
		local k=`k'+1
	}
	di
	_coef_table, level(`level') `diopts'
end
