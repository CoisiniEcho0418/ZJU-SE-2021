*! version 1.1.0  17jun2011
program sdr, eclass sortpreserve
	version 11
	local version : di "version " string(_caller()) ":"

	// Stata 8 syntax
	capture _on_colon_parse `0'
	if c(rc) | `"`s(after)'"' == "" {
		if !c(rc) {
			local 0 `"`s(before)'"'
		}

		// replay output
		if replay() {
			if "`e(prefix)'`e(vce)'" != "svysdr" {
				error 301
			}
			svy `0'
			exit
		}
	}

	`version' SDR `0'
	ereturn local cmdline `"svy sdr `0'"'
end

program SDR, eclass
	version 11
	local version : di "version " string(_caller()) ":"

	// <my_stuff> : <command>
	_on_colon_parse `0'
	local command `"`s(after)'"'
	local 0 `"`s(before)'"'

	// quick check for -nodrop- option
	syntax [anything(name=exp_list equalok)]	///
		[fw iw pw aw] [if] [in] [,		///
			COEF				/// for -logistic-
			noDROP				///
			Level(passthru)			///
			FORCE				///
			*				/// other options
		]
	_get_eformopts, soptions eformopts(`options') allowed(__all__)
	local options `"`s(options)'"'
	local efopt = cond(`"`s(opt)'"'=="",`"`s(eform)'"',`"`s(opt)'"')

	if "`weight'" != "" {
		local wgt [`weight'`exp']
	}

	// parse the command and check for conflicts
	`version' _prefix_command sdr `wgt' `if' `in' , ///
		svy checkvce `coef' `efopt' `level': `command'

	if `"`s(vce)'"' != "" {
		di as err "option vce() not allowed"
		exit 198
	}

	while inlist(`"`s(cmdname)'"', "svy", "sdr") {
		if `"`s(cmdname)'"' == "svy" & `"`s(cmdargs)'"' != "" {
			_svy_check_vce `vcetype'
			if `"`s(vce)'"' != "sdr" {
				error 198
			}
		}
		if `"`wgt'"' == "" & `"`s(wgt)'"' != "" {
			local wgt `"[`s(wgt)']"'
		}
		local if	`"`s(if)'"'
		local in	`"`s(in)'"'
		local efopt	`"`s(efopt)'"'
		local options `"`options' `s(cmdopts)'"'
		if `"`s(rest)'"' == "" {
			svy `wgt' `if' `in', ///
				`efopt' `cluster' `level' `options'
			exit
		}
		`version' _prefix_command sdr `wgt' `if' `in' , ///
			svy checkvce `efopt' `cluster' `level' ///
			checkcluster `s(rest)'
	}

	// note: weights are allowed only from -svyset-
	local version	`"`s(version)'"'
	local cmdname	`"`s(cmdname)'"'
	local cmdargs	`"`s(anything)'"'
	local cmdif	`"`s(if)'"'
	local cmdin	`"`s(in)'"'
	local rest	`"`s(rest)'"'
	local efopt	`"`s(efopt)'"'
	local command	`"`s(command)'"'
	local level	`"`s(level)'"'
	local cmdopts	`"`s(options)'"'
	_get_diopts diopts cmdopts, `cmdopts'

	if `"`efopt'"' != "" & !inlist(`"`:list retok exp_list'"', "", "_b") {
		local efopt
	}

	// -_svy_check_cmdopts- resets -s()-
	_svy_check_cmdopts `cmdname', vce(sdr) `cmdopts'
	local first	`"`s(first)'"'
	local chk_group	`"`s(check_group)'"'
	local cmdlog	`"`s(log)'"'

	local exclude brr bootstrap bs bstrap jackknife jknife statsby
	if `:list cmdname in exclude' ///
	 | ("`force'" == "" & substr("`cmdname'",1,3) == "svy") {
		di as err "`cmdname' is not supported by sdr"
		exit 199
	}

	if "`s(replay)'" != "" {
		if "`e(cmdname)'" == "`cmdname'" {
			svy, `options' `cmdopts' `efopt' level(`level') `rest'
			exit
		}
	}

	is_svysum `cmdname'
	local is_sum = r(is_svysum)
	is_st `cmdname'
	local is_st = r(is_st)
	if `is_st' {
		local stset stset
	}

	// now check the rest of the options
	local 0 `", `options'"'
	syntax [,				///
		noDOTS				///
		SAving(string)			///
		DOUBle				/// not documented
		MSE MSE1			///
		NOIsily				/// "prefix" options
		TRace				///
		REJECT(string asis)		///
		noHeader			/// Display options
		noLegend			///
		notable				///
		Verbose				///
		TItle(string asis)		///
		SUBpop(passthru)		/// -svy- options
		noADJust			///
		dof(numlist max=1 >0)		///
		*				///
	]

	_get_diopts diopts, `diopts' `options'

	// MSE1 exists just in case the `mse' option is specified twice due to
	// -svyset-

	if `is_sum' {
		Check4Over, `cmdopts'
		local overopt `"`s(overopt)'"'
	}

	// check expressions
	tempname touseN npop
	tempvar subuse touse wvar

	mark `touse' `cmdif' `cmdin'
	_svy_setup `touse' `subuse',		///
		cmdname(`cmdname')		///
		svy				///
		sdr				///
		`subpop'			///
		`overopt'			///
		`stset'				///
		`chk_group'			///
		// blank
	if `is_sum' {
		local cmdopts `cmdopts' sovar(`subuse')
		local firstcall firstcall
	}
	if "`r(wtype)'" != "" {
		local wtype	`"`r(wtype)'"'
		local wexp	`"`r(wexp)'"'
		local wt	[`wtype'`wexp']
		quietly gen double `wvar' `wexp'
		local wgt	[`wtype'=`wvar']
		local stwgt	`"`r(stwgt)'"'
	}
	else {
		quietly gen double `wvar' = `touse'
		local wgt
	}
	if "`mse'" == "" {
		local mse	`r(mse)'
	}
	if !`:length local dof' {
		local dof `"`r(dof)'"'
	}
	local posts	`"`r(poststrata)'"'
	local postw	`"`r(postweight)'"'
	local subpop	`"`r(subpop)'"'
	local srssub	`r(srssubpop)'
	if "`r(fpc1)'" != "" {
		di as err "FPC is not allowed with SDR"
		exit 459
	}
	local sdrw	`r(sdrweight)'
	if "`sdrw'" == "" {
		di as err "{p}" ///
"svy sdr requires that the replicate weight variables were svyset " ///
"using option sdrweight()" ///
		"{p_end}"
		exit 459
	}
	local creps : word count `sdrw'
	local sdrfpc `r(sdrfpc)'
	if `"`posts'"' != "" {
		tempname postwvar
		svygen post double `postwvar' `wgt'	///
			if `touse' == 1,		///
			posts(`posts') postw(`postw')
		local npost = r(N_poststrata)
		local pstropt pstrwvar(`postwvar') ///
			posts(`posts') postw(`postw')
		local uwvar `postwvar'
		if "`wtype'" == "" {
			local wgt [pw=`uwvar']
		}
		else {
			local wgt [`wtype'=`uwvar']
		}
	}
	else {
		local uwvar `wvar'
	}

	if "`trace'" != "" {
		local noisily	noisily
		local traceon	set trace on
		local traceoff	set trace off
	}
	if "`cmdlog'" != "" {
		local noisily noisily
	}
	if "`noisily'" != "" {
		local dots nodots
	}

	tempvar order
	quietly gen long `order' = _n
	local sortvars : sortedby		// restore sort order later

	// preliminary parse of <exp_list>
	_prefix_explist `exp_list', stub(_sdr_)
	local eqlist	`"`s(eqlist)'"'
	local idlist	`"`s(idlist)'"'
	local explist	`"`s(explist)'"'
	local eexplist	`"`s(eexplist)'"'

	_prefix_note `cmdname', `dots'
	if "`noisily'" != "" {
		di "sdr: First call to `cmdname' with data as is:" _n
		di as inp `". `command'"'
	}

	local props : properties `cmdname'
	local svyr svyr svylb

	// run the command using the entire dataset
	_prefix_clear, e r
	if `"`cmdopts'"' != "" {
		local ccmdopts `", `cmdopts' `firstcall'"'
	}
	if `"`:list svyr & props'"' != "" & inlist(`"`exp_list'"', "", "_b") {
		if `"`subpop'`srssub'"' != "" {
			local subopt subpop(`subpop', `srssub')
		}
		`traceon'
		capture noisily quietly `noisily' `version'	///
			svy, `subopt'				///
			vce(linearized) : `cmdname' `cmdargs'	///
			if `touse', `cmdopts' `firstcall' `rest'
		`traceoff'
		if e(census) == 1 | e(singleton) == 1 {
			// -sdr- can do nothing more, so just
			// report results and exit
			svy
			exit
		}
		quietly replace `touse' = 0 if ! e(sample)
		quietly replace `subuse' = 0 if ! e(sample)
	}
	else if !`is_st' | "`wgt'" == "" {
		`traceon'
		capture noisily quietly `noisily' `version'	///
			`cmdname' `cmdargs'			///
			`wgt' if `subuse' `ccmdopts' `rest'
		`traceoff'
	}
	else {
		quietly streset `wgt'
		`traceon'
		capture noisily quietly `noisily' `version'	///
			`cmdname' `cmdargs'			///
			if `subuse' `ccmdopts' `rest'
		`traceoff'
	}
	local rc = c(rc)
	if `is_st' {
		// restore st weight settings
		if `"`stwgt'"' != "" {
			quietly streset `stwgt'
		}
		else {
			char _dta[st_w]
			char _dta[st_wt]
			char _dta[st_wv]
		}
	}
	// error occurred while running on entire dataset
	if `rc' {
		_prefix_run_error `rc' sdr `cmdname'
	}
	// do a preliminary check (or some other processing) based
	// on first full run
	_prefix_validate sdr `cmdname'
	// check for rejection of results from entire dataset
	if `"`reject'"' != "" {
		_prefix_reject sdr `cmdname' : `reject'
		local reject `"`s(reject)'"'
	}
	capture confirm matrix e(b) e(V)
        if !_rc {
                tempname fullmat
                _check_omit `fullmat',get
                local checkmat "checkmat(`fullmat')"
        }

	tempname rhold
	_return hold `rhold'
	sum `uwvar' if `touse' == 1, mean
	scalar `npop' = r(sum)

	quietly count if `touse' == 1
	scalar `touseN' = r(N)
	_return restore `rhold'

	// check e(sample)
	_prefix_check4esample sdr `cmdname'
	if "`drop'" == "" {
		local keepesample `"`s(keep)'"'
	}
	// ignore s(diwarn)

	// determine default <exp_list>, or generate an error message
	if `"`exp_list'"' == "" {
		_prefix_explist, stub(_sdr_) edefault
		local eqlist	`"`s(eqlist)'"'
		local idlist	`"`s(idlist)'"'
		local explist	`"`s(explist)'"'
		local eexplist	`"`s(eexplist)'"'
	}
	// expand eexp's that may be in eexplist, and build a matrix of the
	// computed values from all expressions
	tempname b
	_prefix_expand `b' `explist',		///
		stub(_sdr_)			///
		eexp(`eexplist')		///
		colna(`idlist')			///
		coleq(`eqlist')			///
		// blank
	local k_eq	`s(k_eq)'
	local k_exp	`s(k_exp)'
	local k_eexp	`s(k_eexp)'
	local K = `k_exp' + `k_eexp'
	local k_extra	`s(k_extra)'
	local names	`"`s(enames)' `s(names)'"'
	local express	`"`s(explist)'"'
	local eexpress	`"`s(eexplist)'"'
	forval i = 1/`K' {
		local exp`i' `"`s(exp`i')'"'
		if missing(`b'[1,`i']) {
			di as err ///
`"statistic `exp`i'' evaluated to missing in full sample"'
			exit 322
		}
	}
	if `is_sum' & `k_exp' == 0 & "`eexpress'" == "(_b)" {
		// speed things up with the -novariance-
		_prefix_checkopt NOVARiance, `cmdopts'
		if `"`noisily'`s(novariance)'"' == "" {
			local novar " novar"
		}
	}

	if `"`reject'"' != "" {
		local reject `"reject(`reject')"'
	}

	// -Display- options
	local diopts	`diopts'	///
			level(`level')	///
			`header'	///
			`legend'	///
			`verbose'	///
			`table'		///
			`efopt'		///
			// blank

	if `"`saving'"'=="" {
		tempfile saving
		local filetmp "yes"
	}
	else {
		_prefix_saving `saving'
		local saving	`"`s(filename)'"'
		if "`double'" == "" {
			local double	`"`s(double)'"'
		}
		local every	`"`s(every)'"'
		local replace	`"`s(replace)'"'
	}

	if `"`keepesample'"' != "" & `"`subpop'"' == "" {
		if "`cmdin'" == "" {
			local preserved preserved
			preserve
			quietly `keepesample'
		}
		else {
			quietly replace `touse' = 0 if ! e(sample)
			quietly replace `subuse' = 0 if ! e(sample)
		}
	}

	if "`:sortedby'" != "`sortvars'" {
		sort `sortvars' `order'
	}

	quietly replace `touse'  = 2 if `touse'  == 0
	quietly count if `touse' == 1
	tempname nobs
	scalar `nobs' = r(N)

	if min(`creps',_N) <= 1 {
		di as err "insufficient observations to perform sdr"
		exit 459
	}

	// SDR temp pseudovalue variables
	forval i = 1/`K' {
		tempvar tv`i'
		local pseudo `pseudo' `tv`i''
	}

nobreak {
capture noisily break {

	if "`eexpress'" == "(_b)" {
		tempname esave
		if "`e(cmd)'" == "" {
			tempname tcmd
			ereturn local cmd `tcmd'
		}
		estimates store `esave'
	}

	if "`sortvars'" != "" {
		sort `sortvars', stable
	}

	if `"`sdrfpc'"' != "" {
		local sdrfpcvar  __sd_fpc
		local postextra `sdrfpcvar'
		local postcons postconstants(`sdrfpc')
	}

	// prepare post
	tempname postid
	postfile `postid' `postextra' `names'	///
		using `"`saving'"', `double' `every' `replace'

	local cmd1 `"cmd1(`version' `cmdname' `cmdargs')"'
	local cmd2 `"cmd2(`cmdopts'`novar'`rest')"'

	_loop_rw `touse' `subuse' `pseudo',	///
		caller(SDR)			///
		command(`command')		///
		express(`express')		///
		`cmd1' `cmd2'			///
		rwvars(`sdrw')			///
		owvar(`wvar')			///
		`pstropt'			///
		postid(`postid')		///
		`postcons'			///
		`dots'				///
		`noisily'			///
		`trace'				///
		`reject'			///
		`stset'				///
		`checkmat'			///
		// blank

} // capture noisily break

	local rc = c(rc)

	if `is_st' {
		// restore st weight settings
		if `"`stwgt'"' != "" {
			quietly streset `stwgt'
		}
		else {
			char _dta[st_w]
			char _dta[st_wt]
			char _dta[st_wv]
			quietly stset
		}
	}

	// cleanup post
	if "`postid'" != "" {
		postclose `postid'
	}

	if "`esave'" != "" {
		if `rc' {
			quietly estimates drop `esave'
		}
		else {
			quietly estimates restore `esave', drop
			if "`tcmd'" != "" {
				ereturn local cmd
			}
		}
	}

} // nobreak

	if (`rc') exit `rc'

	// load/save file with sdr results
	if "`preserved'" != "" {
		restore
	}
	preserve
	capture use `"`saving'"', clear
	if c(rc) {
		if inrange(c(rc),900,903) {
			di as err ///
"insufficient memory to load file with sdr results"
		}
		error c(rc)
	}
	capture confirm var `sdrfpcvar'
	if ! c(rc) {
		char _dta[sdr_fpc] `"`sdrfpcvar'"'
	}
	label data `"sdr: `cmdname'"'
	char _dta[sdr_command]	`"`command'"'
	char _dta[sdr_cmdname]	`"`cmdname'"'
	char _dta[sdr_names]  	`"`names'"'
	char _dta[sdr_strata]	`"`strata'"'
	char _dta[sdr_su1]	`"`psu'"'
	char _dta[sdr_wtype]	`"`wtype'"'
	char _dta[sdr_wexp]	`"`wexp'"'
	char _dta[sdr_rweights]	`"`sdrw'"'
	char _dta[sdr_N_pop]	`"`=`npop''"'

	// fix the column stripes
	if "`eexpress'" == "(_b)" ///
	 & inlist("`cmdname'", "ologit", "oprobit") ///
	 & missing(e(version)) {
		_prefix_relabel_eqns `b'
		local k_eq = s(k_eq)
		local k_aux = `k_eq'-1
	}
	local colna : colna `b'
	local coleq : coleq `b', quote
	local coleq : list clean coleq
	if `"`: list uniq coleq'"' == "_" {
		local coleq
	}
	forvalues i = 1/`K' {
		local name : word `i' of `names'
		char `name'[observed] `= `b'[1,`i'] '
		local label = substr(`"`exp`i''"',1,80)
		label variable `name' `"`label'"'
		char `name'[expression] `"`exp`i''"'
		local na : word `i' of `colna'
		local eq : word `i' of `coleq'
		char `name'[coleq] `eq'
		char `name'[colname] `na'
		if `i' <= `k_eexp' {
			char `name'[is_eexp] 1
		}
	}
	char _dta[sdr_N]	`=`nobs''
	char _dta[sdr_version]	1

	if `"`filetmp'"' == "" {
		quietly save `"`saving'"', replace
	}

	// saved results
	tempname sdr_v
	capture noisily _sdr_sum, `mse'
	if c(rc) {
		ereturn clear
		exit c(rc)
	}
	mat `sdr_v'    = r(V)
	restore

	local buildfv 0
	if "`eexpress'" == "(_b)" {
		// make a copy of what is in -e()-, with some eXclusions
		local xmac cmd _estimates_name chi2type clustvar novariance
		local xsca F chi2 chi2_c p p_c ll ll_c ll0 ll_0 df_m ///
			r2_p r2_a rmse rss mss
		local xmat b V _N_strata _N_strata_single _N_strata_certain
		if "`e(cmd)'" != "`cmdname'" {
			local ecmd `e(cmd)'
		}
		else	local ecmd `cmdname'
		if "`cmdname'" == "heckman" {
			local xsca `xsca' selambda
		}
		if "`cmdname'" == "intreg" {
			local xsca `xsca' se_sigma
		}
		_e2r, xmac(`xmac') xsca(`xsca') xmat(`xmat') add
		if "`e(depvar)'" != "" {
			local depvar `e(depvar)'
			if `:word count `depvar'' == 1 {
				local depname	depname(`depvar')
			}
		}
		if `k_extra' == 0 {
			local buildfv 1
		}
	}
	if "`:word 1 of `eexpress''" == "(_b)" {
		tempname Cns
		capture mat `Cns' = get(Cns)
		if (c(rc)) local Cns
		else {
			// get constraints matrix for post
			local cols = colsof(`Cns')
			// note: if no other expressions were added, then the
			// constraint matrix has 1 more column than the
			// coefficient vector
			if `cols' <= colsof(`b') {
				// add columns of zeros for other statistics
				local colsm1 = `cols'-1
				local rows = rowsof(`Cns')
				local fill = colsof(`b')-`colsm1'
				tempname cns1 cns2
				mat `cns1' = `Cns'[1...,1..`colsm1']
				mat `cns2' = `Cns'[1...,`cols']
				mat `Cns' = `cns1',J(`rows',`fill',0),`cns2'
				matrix drop `cns1' `cns2'
			}
		}
	}

	quietly replace `touse' = (`touse'==1)
	ereturn post `b' `sdr_v' `Cns', esample(`touse') `depname'

	// restore the copied elements back to -e()-
	_r2e, xmat(b V)
	_post_vce_rank
	if `buildfv' {
		_prefix_buildinfo `cmdname'
	}
	_prefix_fvlabel `ecmd'
	if `:length local dof' {
		ereturn scalar df_r = `dof'
	}
	else {
		ereturn local df_r
		local adjust noadjust
	}
	ereturn scalar k_eq	= `k_eq'
	ereturn scalar k_exp	= `k_exp'
	ereturn scalar k_eexp	= `k_eexp'
	ereturn scalar k_extra	= `k_extra'
	if "`k_aux'" != "" {
		ereturn scalar k_aux = `k_aux'
	}

	if `"`subpop'"' != "" {
		local byopt by(`subuse') nby(1)
	}
	_svy `subuse' `wgt'	///
		if e(sample),	///
		`byopt'		///
		novariance	///
		// blank
	ereturn scalar N_pop	= `npop'
	ereturn local N_sub
	ereturn local N_subpop
	ereturn local subpop
	ereturn local srssubpop
	if `"`subpop'"' != "" {
		ereturn scalar N_sub	= r(N_sub)
		ereturn scalar N_subpop	= r(N_subpop)
		ereturn local subpop	`"`subpop'"'
		if "`vsrs'" != "" {
			ereturn local srssubpop	`srssub'
		}
	}
	ereturn local N_strata
	ereturn local N_psu
	ereturn local wtype	`wtype'
	ereturn local wexp	`"`wexp'"'
	ereturn local strata1
	ereturn local sdrweight	`sdrw'
	ereturn local su1
	if "`posts'" != "" {
		ereturn local poststrata	`posts'
		ereturn local postweight	`postw'
		ereturn scalar N_poststrata	= `npost'
	}
	ereturn local adjust 		`adjust'
	ereturn local estat_cmd		svy_estat
	if "`vsrs'" != "" {
		ereturn matrix V_srs = `vsrs'
		// NOTE: V_srswr must be posted before the next line
		_svy_mkdeff
	}

	ereturn scalar N = `touseN'
	if `"`title'"' != "" {
		ereturn local title `"`title'"'
	}
	else {
		_prefix_title `cmdname' "SDR results"
		if "`e(prefix)'" == "svy" {
			ereturn local title `"`r(title)'"'
		}
		else	ereturn local title `"Survey: `r(title)'"'
	}
	forval i = 1/`K' {
		ereturn local exp`i' `"`exp`i''"'
	}
	ereturn local command	`"`:list retok command'"'
	// NOTE: this must be the last thing posted to -e()-
	ereturn local cmdname `cmdname'
	ereturn local prefix	svy
	if "`eexpress'`k_exp'" != "(_b)0" {
		ereturn hidden local predict _no_predict
		ereturn local cmd sdr
	}
	else {
		if !inlist("`e(predict)'", "", "_no_predict") {
			// compute e(F) and e(df_m)
			_prefix_model_test `cmdname', svy `adjust'
		}
		if "`ecmd'" == "" {
			ereturn local cmd sdr
		}
		else	ereturn local cmd `ecmd'
	}
	if "`e(cmd)'`first'" == "ivregfirst" {
		_svy_ivreg_first, `diopts'
	}
	svy, `diopts'
end

program Check4Over, sclass
	syntax [, over(passthru) * ]
	sreturn local overopt `"`over'"'
end

exit
