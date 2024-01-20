*! version 3.6.0  25apr2011
program qreg, eclass byable(recall) sort prop(sw mi)
	version 6, missing
	local options "Level(cilevel)"
	if !replay() {
		local cmdline : copy local 0
		syntax varlist [aw fw] [if] [in] [, `options' /*
			*/ noConstant Quantile(real 0.5) /*
			*/ WLSiter(integer 1) noLOg * ]
		_get_diopts diopts options , `options'
		if "`constan'"!="" {
			di in red "nocons invalid"
			exit 198
		}
		if `quantil' >= 1 {
			local quant = `quantil'/100
		}
		else	local quant "`quantil'"
		if `quant' <= 0 | `quant' >= 1 {
			di in red "quantiles(`quantil') out of range"
			exit 198
		}
		if `wlsiter'<1 { error 198 }
		marksample touse
		qui count if `touse'
		if r(N)<2 { error cond(_n,2001,2000) }
		gettoken dep indep : varlist
		_rmcoll `indep' [`weight'`exp'] if `touse'
		local varlist `dep' `r(varlist)'
		tempvar r s2 p
		gen long `s2' = _n

		/* initial estimates via weighted least squares 	*/
		_qregwls `varlist' [`weight' `exp'] if `touse',	///
			iterate(`wlsiter') quant(`quant') r(`r') `log'

		quietly {
			if "`log'"=="" { local log "noisily" }
			else 	local log

			sort `r' `s2'
			drop `r'

			`log' _qreg `varlist' if `touse' [`weight'`exp'], /*
				*/ quant(`quant') `options'
			if (r(convcode)!=1) { 
				di in re "Convergence not achieved." 
				local frc 430
			}
			else	local frc 0
			local rd = r(f_r)
			local nobs = r(N)
			local rq = r(q_v)
			local rsd = r(sum_rdev)
			local msd = r(sum_adev)
			sort `s2'
			drop `s2'
			_predict `r' if `touse', resid
			gen `s2' = abs(`r')
			summ `s2', meanonly
			replace `r' = 0 if abs(`r')<10e-10*r(mean)
			drop `s2'
			_predict `p' if `touse'
			replace `r' = `quant' if `r'>0 & `r'<.
			replace `r' = (`quant' - 1) if `r'<0
			replace `r' = `r' / `rd'
			gen byte `s2' = 1 if `touse'
			tokenize `varlist'
			local dv "`1'"
			mac shift
			reg `p' `*' if `touse' [`weight'`exp'], dep(`dv')
			local df_m = e(df_m)
			local df_r = e(df_r)
			capture assert `touse'
			if _rc { 
				preserve
				qui keep if `touse'
			}
			_huber `r' `s2' [`weight'`exp']

			/* Double saves */
			est scalar df_m = `df_m'
			est scalar df_r = `df_r'
			est scalar f_r = `rd'
			est scalar N = `nobs'
			est scalar q_v = `rq'
			est scalar q = `quant'
			est scalar sum_rdev = `rsd'
			est scalar sum_adev = `msd'
			est scalar convcode = `frc'

			global S_E_mdf `df_m'
			global S_E_tdf `df_r'
			global S_E_rd `rd'
			global S_E_nobs `nobs'
			global S_E_q `quant'
			global S_E_rq `rq'
			global S_E_rsd `rsd'
			global S_E_msd `msd'
			global S_E_vl "`varlist'"
			global S_E_frc `frc'

			if "`weight'" != "" {
				est local wexp = "`exp'"
				est local wtype = "`weight'" 
			}
			est local properties "b V"

			global S_E_cmd "qreg"
			est repost, buildfvinfo
			est local marginsnotok stdp stddp Residuals
			est local predict "qreg_p"
			version 10: ereturn local cmdline `"qreg `cmdline'"'
			est local cmd "qreg"
			_post_vce_rank
		}
	}
	else {
		if "`e(cmd)'"!="qreg" { error 301 }
		if _by() { error 190 }
		syntax [, `options' *]
		_get_diopts diopts , `options'
	}

	di
	* di "  Residual density = `e(f_r)'"
	if (e(q)==0.5) { di in gr "Median regression"  /*
		*/ _col(54) "Number of obs =" in ye %10.0g e(N) }
	else { di in gr e(q) " Quantile regression" /*
		*/ _col(54) "Number of obs =" in ye %10.0g e(N) }
	di in gr "  Raw sum of deviations" in ye %9.0g e(sum_rdev) /*
		*/ in gr " (about " in ye e(q_v) in gr ")"
	di in gr "  Min sum of deviations" in ye %9.0g e(sum_adev) _col(54) /*
		*/ in gr "Pseudo R2     =" /*
		*/ in ye %10.4f 1 - (e(sum_adev)/e(sum_rdev))
	di
	* _huber, level(`level')
	_coef_table, level(`level') `diopts'
	error e(convcode)
end
