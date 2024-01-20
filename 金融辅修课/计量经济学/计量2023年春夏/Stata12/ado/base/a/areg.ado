*! version 2.0.0  04nov2010
program areg, eclass byable(onecall) prop(mi)
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	if _caller() < 12 {
		`BY' areg_11 `0'
		exit
	}
	version 12

	if !replay() {
		local cmdline : copy local 0
	}
	syntax [anything] [aw fw pw] [if] [in],	[	///
		Absorb(varname)				///
		CLuster(varname)			///
		VCE(passthru)				///
		Level(string asis)			///
		*					///
	]
	if `"`vce'"' != "" {
		local absopt absorb(`absorb')
		tempname id
		_vce_cluster areg,		///
			groupvar(`absorb')	///
			newgroupvar(`id')	///
			groptname(absorb)	///
			`vce'			///
			cluster(`cluster')
		local vce `"`s(vce)'"'
		local idopt `s(idopt)'
		local clopt `s(clopt)'
		local gropt `s(gropt)'
		local bsgropt `s(bsgropt)'
		if `"`level'"' != "" {
			local options `"level(`level') `options'"'
		}

		if "`weight'" != "" {
			local wgt [`weight'`exp']
		}
		local vceopts	jkopts(`clopt' notable noheader)	///
				bootopts(	`clopt'			///
						`idopt'			///
						`bsgropt'		///
						notable			///
						noheader)		///
				mark(Absorb CLuster)
		`BY' _vce_parserun areg, `vceopts' :	///
			`anything' `wgt' `if' `in', `gropt' `vce' `options'
		if "`s(exit)'" != "" {
			if ! `:length local level' {
				local level `"`s(level)'"'
			}
			ereturn local absvar `absorb'
			ereturn local cluster `cluster'
			if "`cluster'" == "" {
				local cmd1 `"`e(command)'"'
				local cmd2 : ///
					subinstr local cmd1 "`id'" "`absorb'"
				ereturn local command `"`cmd2'"'
			}
			local dsvars `"`e(datasignaturevars)'"'
			local dsvars : subinstr local dsvars "`id'" "`absorb'"
			ereturn local datasignaturevars `"`dsvars'"'
			ereturn local cmdline `"areg `cmdline'"'
			_get_diopts diopts options, `options'
			Replay, level(`level') `diopts'
			exit
		}
	}
	quietly syntax [anything] [aw fw pw] [if] [in] [, Absorb(varname) *]
	_get_diopts diopts options, `options'
	_vce_parse, argopt(CLuster) opt(OLS Robust) old	///
		: [`weight'`exp'], `options'
	if `"`r(robust)'"' != "" {
		`BY' areg_11 `0'
		ereturn local cmdline `"areg `cmdline'"'
		exit
	}

	if replay() {
		if `"`e(cmd)'"' != "areg" {
			error 301
		}
		if _by() { 
			error 190 
		}
		Replay `0'
		exit
	}

	`BY' Estimate `0'
	ereturn local cmdline `"areg `cmdline'"'
end

program Estimate, eclass byable(recall)
	version 12
	syntax varlist(ts fv) [aw fw pw] [if] [in], Absorb(varname) [*]

	_fv_check_depvar `varlist', k(1)
	_get_diopts diopts, `options'

	marksample touse
	markout `touse' `absorb' `cluster', strok
	quietly count if `touse'
	if      r(N) == 0 { 
		error 2000 
	}
	else if r(N) == 1 { 
		error 2001 
	}

	_regress `varlist' [`weight'`exp'] if `touse',	///
		absorb(`absorb')			///
		noheader				///
		notable					///
		`mse1'

	// comparison model
	local y `e(depvar)'
	local xvars : colna e(b)
	local cons _cons
	local xvars : list xvars - cons
	tempname hold
	set buildfvinfo off
	_est hold `hold'
	quietly _regress `y' `xvars' [`weight'`exp'] if `touse'
	local r2c = e(r2)
	_est unhold `hold'

	ereturn scalar F_absorb = ((e(r2)-`r2c')/e(df_a))/((1-e(r2))/e(df_r))
	_post_vce_rank

	ereturn local vce ols
	ereturn historical(9.2) scalar ar2 = e(r2_a)

	if e(F) == 0 {
		ereturn scalar df_m = 0
		ereturn scalar F = .
	}

	unopvarlist `varlist'
	local varlist `r(varlist)'
	signestimationsample `varlist' `absorb' `e(clustvar)' 

	ereturn local marginsnotok Residuals SCore
	ereturn local predict areg_p
	ereturn local title "Linear regression, absorbing indicators"
	ereturn local footnote areg_footnote
	ereturn local estat_cmd
	ereturn local cmd  "areg"

	// duplicates for old results
	global S_E_mdf	= e(df_m)
	global S_E_f	= e(F)
	global S_E_f2	= e(F_absorb)

	global S_E_nobs	= e(N)
	global S_E_sse	= e(rss)
	global S_E_sst	= e(tss)
	global S_E_r2	= e(r2)
	global S_E_tdf	= e(df_r)
	global S_E_abs	`"`absorb'"'
	global S_E_dfa	= e(df_a)
	global S_E_depv `"`e(depvar)'"'
	global S_E_cmd	`"`e(cmd)'"'

	Replay, `diopts'
end

program Replay
	syntax [, *]

	_get_diopts diopts, `options'
	if "`e(prefix)'" != "" {
		_prefix_display, `diopts'
		exit
	}
	_coef_table_header
	di
	_coef_table, plus `diopts'
	_prefix_footnote
end
exit
