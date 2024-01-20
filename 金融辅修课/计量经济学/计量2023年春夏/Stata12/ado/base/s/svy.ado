*! version 1.7.0  17jun2011
program svy
	version 9
	local version : di "version " string(_caller()) ":"

	capture _on_colon_parse `0'
	if c(rc) | `"`s(after)'"' == "" {
		if !c(rc) {
			local 0 `"`s(before)'"'
		}
		if replay() {
			if "`e(prefix)'" != "svy" {
				error 301
			}
			`version' Display `0'
			exit
		}
	}
	quietly ssd query
	if (r(isSSD)) {
		di as err "svy not possible with summary statistc data"
		exit 111
	}
	`version' SvyEst `0'
end

program SvyEst, eclass
	version 9
	local version : di "version " string(_caller()) ":"
	local cmdline : copy local 0

	// <my_stuff> : <command>
	_on_colon_parse `0'
	local command `"`s(after)'"'
	local 0 `"`s(before)'"'

	syntax [anything(name=vcetype equalok)]	///
		[if] [in] [,			///
		Level(passthru)			///
		COEF				/// for -logistic-
		VCE(string)			/// VCE type
		STRata(passthru)		/// see _svy_newrule.ado
		PSU(passthru)			/// see _svy_newrule.ado
		FPC(passthru)			/// see _svy_newrule.ado
		*				/// other options
	]
	_get_eformopts, soptions eformopts(`options') allowed(__all__)
	local options `"`s(options)'"'
	local efopt = cond(`"`s(opt)'"'=="",`"`s(eform)'"',`"`s(opt)'"')

	// check that vcetype and vce() option do not conflict
	if `"`vcetype'"' != "" & `"`vce'"' != "" {
		gettoken vcetype vcerest : vcetype
		_svy_check_vce `vcetype'
		local vcetype `s(vce)'
		_svy_check_vce `vce'
		local vce `s(vce)'
		if !`:list vce === vcetype' {
			di as err ///
`"option vce(`vce') is not valid with svy `vcetype'"'
			exit 198
		}
	}
	else if `"`vcetype'"' != "" {
		gettoken vcetype vcerest : vcetype
		local vce `"`vcetype'"'
	}
	if `"`vce'"' != "" {
		local vceopt vce(`vce')
	}

	if `"`strata'`psu'`fpc'"' != "" {
		// error message for illegal options
		_svy_newrule , `strata' `psu' `fpc'
	}

	// parse the command and check for conflicts
	`version' _prefix_command svy `if' `in' , ///
		svy checkvce `coef' `efopt' `level': `command'
	if `"`s(vce)'"' != "" {
		di as err	///
`"option vce() of `r(cmdname)' is not allowed with the svy prefix"'
		exit 198
	}

	local command	`"`s(command)'"'
	local version	`"`s(version)'"'
	local cmdname	`"`s(cmdname)'"'
	local cmdargs	`"`s(anything)'"'
	local wgt	`"`s(wgt)'"'
	local wtype	`"`s(wtype)'"'
	local wexp	`"`s(wexp)'"'
	local cmdif	`"`s(if)'"'
	local cmdin	`"`s(in)'"'
	local cmdopts	`"`s(options)'"'
	local rest	`"`s(rest)'"'
	local efopt	`"`s(efopt)'"'
	local level	`"`s(level)'"'

	local cmdmeff	`"`cmdname' `cmdargs'"'
	is_st `cmdname'
	local is_st = r(is_st)
	if `is_st' {
		local cmd	`"`cmdname' `cmdargs' \`cmdif'"'
		local stset	stset
	}
	else {
		local cmd	`"`cmdname' `cmdargs' \`cmdif' \`wgt'"'
	}

	// Check if -ivregress-
	if "`cmdname'" == "ivregress" {
		gettoken estimator : cmdargs
		// Bail if GMM estimator
		if "`estimator'" == "gmm" {
			di as err 	///
"the GMM estimator is not available with {cmd:svy}"
			exit 322
		}
		// See if first-stage regression requested
		local ivfirst : list posof "first" in cmdopts
	}

	// svy:tabulate handles the vce() option itself
	if "`cmdname'" == "tabulate" {
		if `"`vceopt'"' != "" {
			local vceopt vce(`vce', `mse')
		}
		if `"`vcerest'"' != "" {
			di as err ///
		"{it:exp_list} is not allowed with svy: tabulate"
			exit 198
		}

		// NOTE: `rest' should be empty, but pass it along for an
		// error message

		`version'		///
		_svy_tabulate		///
			`cmdargs'	///
			`cmdif'		///
			`cmdin',	///
			`cmdopts'	///
			level(`level')	///
			`vceopt'	///
			`options'	///
			`rest'
		_post_vce_rank
		ereturn local cmdline `"svy `cmdline'"'
		exit
	}

	// cmdname is a svy replication VCE type
	// Called with:
	// .  svy [, <options>] : <vcetype> <exp_list> [, <options>] : ...
	capture _svy_check_vce `cmdname'
	if !c(rc) {
		local cmdname `s(vce)'
		if inlist("`cmdname'", "bootstrap", "jackknife") {
			local jkopts svy
		}
		`version'			///
		`cmdname' `vcerest' `cmdargs'	///
			`cmdif' `cmdin',	///
			`options'		///
			`cmdopts'		///
			`mse'			///
			`jkopts'		///
			level(`level')		///
			`rest'
		ereturn local cmdline `"svy `cmdline'"'
		exit
	}

	if "`s(replay)'" != "" {
		if "`e(cmdname)'" != "`cmdname'" {
			error 301
		}
		`version' Display, `options' `cmdopts' level(`level') `rest'
		exit
	}

	// VCE -- variance covariance estimation type
	if "`vce'" == "" {
		quietly svyset
		if "`r(vce)'" != "" {
			local vce `r(vce)'
		}
		else	local vce linearized
	}
	_svy_check_vce `vce'
	if "`s(vce)'" != "" {
		local vce `s(vce)'
		// this will only be used by replication VCE type
		local mse `s(mse)'
	}
	local cmdprops : properties `cmdname'
	if `"`vcerest'"' == "" {
		// check for unsupported commands
		if inlist("`vce'", "brr", "bootstrap", "sdr") {
			local prop svyb
		}
		else if "`vce'" == "jackknife" {
			local prop svyj
		}
		else	local prop svyr svylb
		local andprops : list cmdprops & prop
		if `:list sizeof andprops' == 0 {
			di as err "{p}" ///
"`cmdname' is not supported by {cmd:svy} with {cmd:vce(`vce')}; " ///
"see help {help svy estimation##|_new:svy estimation} for a " ///
"list of Stata estimation commands that are supported by {cmd:svy}{p_end}"
			exit 322
		}
	}

	// check that the data is -svyset-
	_svy_newrule

	if "`vce'" != "linearized" {

		// This command only computes linearized VCE, so call another
		// prefix command for the other vcetypes.

		if inlist("`vce'", "bootstrap", "jackknife") {
			local jkopts svy
		}
		`version'			///
		`vce' `vcerest'			///
			`cmdif' `cmdin',	///
			`options'		///
			`mse'			///
			`jkopts'		///
			level(`level')		///
			: `cmdname'		///
				`cmdargs',	///
				`cmdopts'	///
				`rest'
		ereturn local cmdline `"svy `cmdline'"'
		exit
	}

	if `"`vcerest'"' != "" {
		di as err "{it:exp_list} is not allowed with svy linearize"
		exit 198
	}

	// The -_svy2- routines get special treatment.
	is_svysum `cmdname'
	if r(is_svysum) {
		_prefix_note `cmdname'
		`version'		///
		_svy_summarize		///
			`cmdname'	///
			`cmdargs'	///
			`cmdif'		///
			`cmdin',	///
			`cmdopts'	///
			level(`level')	///
			svy		/// -svy- switch
			`options'	/// -svy- options
			// blank
		ereturn local cmdline `"svy `cmdline'"'
		exit
	}

	// -_svy_check_cmdopts- resets -s()-
	_svy_check_cmdopts `cmdname', `vceopt' `cmdopts'
	local cmdlog	`s(log)'
	local cmdopts1	`"`s(cmdopts1)'"'
	local cmdopts2	`"`s(cmdopts2)'"'
	local first	`"`s(first)'"'
	local chk_group	`"`s(check_group)'"'
	local group	`"`s(group)'"'

	local 0 `", `options'"'
	syntax [,				///
		NOIsily				///
		TRace				///
		SUBpop(passthru)		///
		noHeader			/// -Display- options
		notable				///
		noLegend			/// ignored
		noADJust			///
		dof(numlist max=1 >0)		///
		*				///
	]

	// -Display- options
	_get_diopts diopts, `options' level(`level')
	_get_diopts cmddiopts cmdopts, `cmdopts' `options' level(`level')
	local diopts `cmddiopts' `header' `table' `legend' `efopt'
	local diopts : list uniq diopts

	// debug options
	if "`trace'" != "" {
		local noisily	noisily
		local traceon	set trace on
		local traceoff	set trace off
	}
	if "`cmdlog'" != "" {
		local noisily noisily
	}
	local qui = cond("`noisily'"=="", "*", "noisily")
	if "`noisily'" != "" {
		local dots nodots
	}

	// identify estimation sample
	tempname touse
	mark `touse' `wgt' `cmdif' `cmdin', zeroweight

	// check/get svy settings
	tempvar subuse wvar
	_svy_setup `touse' `subuse',		///
		cmdname(`cmdname')		///
		svy				///
		`subpop'			///
		`stset'				///
		`chk_group'			///
		// blank
	if `"`subpop'"' != "" {
		local subopt	subpop(`subuse')
		local subpop	`"`r(subpop)'"'
	}
	if "`r(wtype)'" != "" {
		local wtype	`"`r(wtype)'"'
		local wexp	`"`r(wexp)'"'
		local wvname	= strtrim(substr(strtrim(`"`wexp'"'),2,.))
		local stwgt	`"`r(stwgt)'"'
	}
	if !`:length local dof' {
		local dof `"`r(dof)'"'
	}
	if "`r(poststrata)'" != "" {
		local posts `r(poststrata)'
		svygen post double `wvar'		///
			[`wtype'`wexp']			///
			if `touse',			///
			posts(`r(poststrata)')		///
			postw(`r(postweight)')		///
			// blank
	}
	else if "`wtype'" != "" {
		quietly gen double `wvar' `wexp'
	}
	else {
		quietly gen double `wvar' = `touse'
	}
	local wgt	[iw=`wvar']
	local cmdif	"if `subuse'"
	if `is_st' & `"`subpop'"' == "" {
		quietly count if `touse'
		local N = r(N)
		quietly count if `subuse'
		if r(N) < `N' {
			local subopt	subpop(`subuse')
		}
	}

	// Execute command to get "observed" values

	tempname b V Vmodel cns Vsrs n_strata n_single n_certain

	ClearE

	// Compute point estimates
	_prefix_note `cmdname', `dots'

nobreak {

	if `is_st' {
		// temporarily reset st weight settings
		quietly streset `wgt'
	}

	`traceon'
	capture noisily quietly break `noisily'	///
		`version' `cmd' `cmdopts1' `cmdopts2' `cmdopts3' `rest'
	`traceoff'
	local rc = c(rc)
	if `is_st' {
		// restore st weight settings
		char _dta[st_w]
		char _dta[st_wt]
		char _dta[st_wv]
		quietly streset `stwgt'
	}

}

	if `rc' {
		ClearAndExit `c(rc)' `cmdname'
	}

	// one-time estimation notes
	Notes

	// -markout- observations that were dropped from within the subpop
	quietly replace `touse' = 0 if !e(sample) & `subuse' & `wvar'
	quietly replace `subuse' = 0 if `touse' == 0

	// Estimation results
	matrix `b' = e(b)
	local svylb svylb
	if `:list svylb in cmdprops' {
		local allcons allcons
	}
	`qui' di _n as txt "Computing scores..."
	tempname x
	capture noisily quietly ///
		predict double `x'* if e(sample), scores
	if c(rc) {
		di as err ///
		"an error occurred while attempting to compute scores"
		exit 322
	}
	unab scvars : `x'*
	foreach sc of local scvars {
		quietly replace `sc' = 0 if missing(`sc')
	}

nobreak {

	local epilog "*"
	local hasprolog 0
	if `"`e(robust_prolog)'"' != "" {
		`e(robust_prolog)'
		local epilog `"`e(robust_epilog)'"'
		local hasprolog 1
	}

capture noisily break {

	// Model based variance
	matrix `V' = e(V)
	if inlist("`cmdname'", "ologit", "oprobit") & missing(e(version)) {
		_prefix_relabel_eqns `b' `V'
	}
	// get constraints if present
	capture mat `cns' = get(Cns)
	if (c(rc)) local cns

	if "`cmdname'" == "ivreg" {
		preserve
		quietly _ivreg_project `wgt' `cmdif'
	}
	matrix `Vmodel' = `V'

	quietly _robust2 `scvars' if `touse',		///
		svy `subopt' v(`V') vsrs(`Vsrs')	///
		`allcons' touse(`touse') group(`group')
	drop `scvars'

} // capture noisily break

	local rc = c(rc)
	`epilog'

} // nobreak

	if (`rc') exit `rc'

	if `hasprolog' {
		local coln : colf e(b), quote
		local allVs `V' `Vsrs' `Vsrs'sub `Vsrs'wr `Vsrs'subwr `Vmodel'
		foreach Vtmp of local allVs {
			capture matrix list `Vtmp'	// to see if exists
			if !_rc {
				// Clear out eqn names; needed if original
				// model's b does not have them
				matrix coleq `Vtmp' = _:
				matrix roweq `Vtmp' = _:
				version 11: matrix coln `Vtmp' = `coln'
				version 11: matrix rown `Vtmp' = `coln'
			}
		}
	}
	local wtype	`"`r(wtype)'"'
	local wexp	`"`r(wexp)'"'
	if "`cmdname'" == "ivreg" {
		restore
	}
	tempname nobs nstr npsu npop
	if `:length local dof' {
		local   df     = `dof'
	}
	else	local   df     = r(df_r)
	scalar `nobs'  = r(N)
	if !missing(r(N_pop)) {
		scalar `npop' = r(N_pop)
	}
	else	scalar `npop' = r(sum_w)
	scalar `nstr'  = r(N_strata)
	scalar `npsu'  = r(N_clust)
	local	nomit  = r(N_strata_omit)
	local   census = r(census)
	local   single = r(singleton)
	if "`subopt'" != "" {
		tempname nsub nsubpop
		scalar `nsub' = r(N_sub)
		if !missing(r(N_subpop)) {
			scalar `nsubpop' = r(N_subpop)
		}
		else	scalar `nsubpop' = r(sum_wsub)
	}
	if "`posts'" != "" {
		tempname npost
		scalar `npost' = r(N_poststrata)
	}
	matrix `n_strata' = r(_N_strata)
	matrix `n_single' = r(_N_strata_single)
	matrix `n_certain' = r(_N_strata_certain)

	local cmdname	`"`e(cmd)'"'
	_prefix_title	`"`e(cmd)'"' ""
	if `"`r(title)'"' != "" {
		local title `"Survey: `r(title)'"'
	}
	else {
		if "`e(cmd2)'" == "stcox" {
			local title "Survey: Cox regression"
		}
		else if "`e(cmd)'" == "nl" {
			local title "Survey: Nonlinear regression"
		}
		else	local title "Survey data analysis"
	}

	// Get information from estimation command.
	// At the very least, the following should be defined:
	// 	e(depvar)
	// 	e(predict)
	// Some of the following may be defined when certain options are
	// supplied to `cmdname':
	// 	e(offset)

	// make a copy of what is in -e()-, with some eXclusions
	local xmac cmd _estimates_name chi2type
	local xsca F chi2 chi2_c p p_c ll ll_c ll0 ll_0 df_m ///
		r2_p r2_a rmse rss mss
	local xmat b V
	if "`cmdname'" == "heckman" {
		local xsca `xsca' selambda
	}
	if "`cmdname'" == "intreg" {
		local xsca `xsca' se_sigma
	}
	if `is_st' {
		local xsca `xsca' N_sub N_fail risk se_theta
		if "`tempesr'" != "" {
			local xmac `xmac' vl_esr
		}
	}
	_e2r, xmac(`xmac') xsca(`xsca') xmat(`xmat')

	if `"`e(depvar)'"' != "" {
		local depvar	`e(depvar)'
		if `:word count `depvar'' == 1 {
			local depname	depname(`depvar')
		}
	}

	local ncols = colsof(`b')
	local cons _cons
	local k_eq : coleq `b', quote
	local k_eq : list uniq k_eq
	local k_eq : word count `k_eq'

	// Post -svy- results
	ereturn post `b' `V' `cns' [`wtype'`wexp'], ///
		dof(`df') esample(`subuse') `depname'

	// restore the copied elements back to -e()-
	_r2e
	quietly svyset
	_r2e
	ereturn local settings
	ereturn local brrweight
	ereturn local fay
	ereturn local bsrweight
	ereturn local bsn
	ereturn local jkrweight
	ereturn local sdrweight

	// Summary information
	if "`nsub'`nsubpop'" != "" {
		ereturn scalar N_sub = `nsub'
		ereturn scalar N_subpop = `nsubpop'
	}
	ereturn scalar N	= `nobs'
	ereturn scalar N_pop	= `npop'
	ereturn scalar N_strata	= `nstr'
	ereturn scalar N_psu	= `npsu'
	if `:length local dof' {
		ereturn scalar df_r = `dof'
	}
	else {
		ereturn scalar df_r = `npsu' - `nstr'
	}
	ereturn scalar N_strata_omit = `nomit'
	if "`npost'" != "" {
		ereturn scalar N_poststrata = `npost'
	}
	ereturn scalar singleton = `single'
	ereturn scalar census	= `census'
	ereturn matrix _N_strata `n_strata'
	ereturn matrix _N_strata_single `n_single'
	ereturn matrix _N_strata_certain `n_certain'

	// number of equations
	ereturn scalar k_eq	= `k_eq'

	// svy characteristics
	ereturn local wtype	`"`wtype'"'
	ereturn local wexp	`"`wexp'"'
	ereturn local subpop	`"`subpop'"'
	ereturn local adjust 	`adjust'
	ereturn local title	`"`title'"'
	ereturn local vcetype	Linearized
	ereturn local vce	linearized
	ereturn local estat_cmd	svy_estat

	// the model test should be one of the last things performed; it
	// depends upon some things in -e()-
	_prefix_model_test `cmdname', svy `adjust'

	// design & misspecification effects
	if "`e(poststrata)'" == "" {
		ereturn matrix V_srs `Vsrs'
		if `"`subpop'"' != "" {
			ereturn matrix V_srssub `Vsrs'sub
		}
		if `"`e(fpc1)'"' != "" {
			ereturn matrix V_srswr `Vsrs'wr
			if `"`subpop'"' != "" {
				ereturn matrix V_srssubwr `Vsrs'subwr
			}
		}
	}
	ereturn matrix V_modelbased `Vmodel'
	_post_vce_rank	
	_prefix_buildinfo `cmdname'
	_prefix_fvlabel `cmdname'
	ereturn repost, esample(`touse')

	// NOTE: this must be the last thing posted to -e()-
	ereturn local command	`"`command'"'
	ereturn local cmdname	`cmdname'
	ereturn local prefix	svy
	ereturn local cmdline	`"svy `cmdline'"'
	ereturn local cmd	`cmdname'

	`qui' di _n as txt "Survey results:"
	if "`e(cmd)'`first'" == "ivregfirst" | `ivfirst' {
		_svy_ivreg_first, `diopts'
	}
	`version' Display, `diopts'
end

program Notes
	if "`e(cmd)'" == "clogit" {
		if "`e(multiple)'" != "" {
			di as txt "note: multiple positive outcomes within " _c
			di as txt "groups encountered."
		}
		if !missing(e(N_drop)) {
			if (e(N_group_drop) > 1) local s s
			di as txt "note: `e(N_group_drop)' group`s' (" _c
			di as txt e(N_drop) _c
			di as txt " obs) dropped because of all positive or"
			di as txt "      all negative outcomes."
		}
	}
end

program Display
	version 9
	local version : di "version " string(_caller()) ":"
	// forward to display routines for special cases
	is_svysum `e(cmd)'
	if  r(is_svysum) {
		_svy_summarize `e(cmd)' `0'
		exit
	}
	if "`e(cmdname)'" == "tabulate" {
		_svy_tabulate `0'
		exit
	}
	if "`e(cmdname)'" == "mlogit" {
		mlogit `0'
		exit
	}
	if "`e(cmdname)'" == "mprobit" {
		mprobit `0'
		exit
	}

	// general purpose -svy- results displayer
	_prefix_display `0'
end

program ClearAndExit	// rc cmdname
	ClearE
	_prefix_run_error `1' svy `2'
end

program ClearE, eclass
	ereturn clear
end

exit

NOTES:

All updates to this file may require similar changes to the following files as
well; they perform -svy- compatible estimation on their own.

	brr.ado
	_svy_bs.ado
	jackknife.ado
	_jk_sum.ado			-- uses _svy
	ml_max.ado			-- uses _robust2
	_svy_summarize.ado		-- uses _svy2
	_svy_tabulate.ado		-- uses _svy2
	suest.ado			-- uses _robust2

<end>
