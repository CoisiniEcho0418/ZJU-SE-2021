*! version 11.1.2  16jun2011
program ologit, properties(or svyb svyj svyr swml mi fvaddcons) eclass byable(onecall)
	if replay() {
		version 11
		if "`e(cmd)'" != "ologit" {
			error 301
		}
		if _by() {
			error 190
		}
		if `"`e(opt)'"' == "" {
			ologit_10 `0'
		}
		else	Replay `0'
		exit
	}
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	if _caller() < 11 {
		`BY' ologit_10 `0'
		exit
	}
	version 11
	local version : di "version " string(_caller()) ":"

	`version' `BY' _vce_parserun ologit, mark(OFFset CLuster) : `0'
	if "`s(exit)'" != "" {
		ereturn local cmdline `"ologit `0'"'
		exit
	}

	`version' `BY' Estimate `0'
	ereturn local cmdline `"ologit `0'"'
end

program Estimate, eclass byable(recall)
	local vv : di "version " string(_caller()) ":"
	version 11
	syntax varlist(ts fv) [if] [in]		///
		[fw pw iw aw] [,		///
		FROM(string)			///
		noLOg				///
		OFFset(varname numeric)		/// -ml model- options
		TECHnique(passthru)		///
		VCE(passthru)			///
		LTOLerance(passthru)		///
		TOLerance(passthru)		///
		noWARNing			///
		Robust CLuster(passthru)	/// old options
		CRITtype(passthru)		///
		SCORE(passthru)			///
		DOOPT				/// NOT DOCUMENTED
		notable				/// -Replay- options
		noHeader			///
		NOCOEF				///
		OR				///
		*				/// -mlopts- options
	]

	if "`nocoef'" != "" {
		local table notable
		local header noheader
	}

	if `:length local doopt' {
		opts_exclusive "doopt `robust'"
		opts_exclusive "doopt `cluster'"
		opts_exclusive "doopt `score'"
		opts_exclusive "doopt `technique'"
		if `:length local ltolerance' == 0 {
			local ltolerance ltol(0)
		}
		if `:length local tolerance' == 0 {
			local tolerance tol(1e-4)
		}
		local doopt doopt halfsteponly
	}

	local vceopt =	`:length local vce'		|	///
	   		`:length local weight'		|	///
	   		`:length local cluster'		|	///
	   		`:length local robust'
	if `vceopt' {
		_vce_parse, argopt(CLuster) opt(OIM OPG Robust) old	///
			: [`weight'`exp'], `vce' `robust' `cluster'
		local vce
		if "`r(cluster)'" != "" {
			local clustvar `r(cluster)'
			local vce vce(cluster `r(cluster)')
		}
		else if "`r(robust)'" != "" {
			local vce vce(robust)
		}
		else if "`r(vce)'" != "" {
			local vce vce(`r(vce)')
		}
		if !inlist(`"`vce'"', "", "vce(oim)") {
			opts_exclusive "`doopt' `vce'"
		}
	}

	// check syntax
	_get_diopts diopts options, `options'
	mlopts mlopts, `options' `technique' `vce' `tolerance' `ltolerance'
	local coll `s(collinear)'
	if "`weight'" != "" {
		local wgt "[`weight'`exp']"
	}
	if "`offset'" != "" {
		local offopt "offset(`offset')"
	}

	// mark the estimation sample
	marksample touse
	if `:length local offset' {
		markout `touse' `offset'
	}
	if `:length local clustvar' {
		markout `touse' `clustvar', strok
	}

	if `:length local log' {
		local skipline noskipline
	}
	_rmcoll `varlist' `wgt' if `touse',	///
		`coll'				///
		`skipline'			///
		ologit				///
		`offopt'			///
		expand
	if !`:length local coll' {
		local coll collinear
	}
	local varlist `"`r(varlist)'"'
	tempname cat b0
	matrix `cat' = r(cat)
	matrix `b0' = r(b0)
	local ncat = r(k_cat)
	local lf0 = r(ll_0)
	if (`ncat' == 1) {
		error 148
	}
	local ncut = `ncat' - 1
	forval i = 1/`ncut' {
		local cuteq `cuteq' /cut`i'
	}
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'

	// initial value
	if `"`from'"' == "" {
		tempname bb
		local k :list sizeof rhs
		if `k' {
			matrix `bb' = J(1,`k',0)
			matrix colna `bb' = `rhs'
			matrix coleq `bb' = `lhs'
		}
		matrix `bb' = nullmat(`bb'), `b0'
		local initopt init(`bb')
	}
	else {
		local initopt `"init(`from')"'
	}

	if !missing(`lf0') & "`offset'" == "" {
		local initopt `initopt' lf0(`=`ncat'-1' `lf0')
	}

	if `:length local vce' |	///
	   `:length local technique' |	///
	   `:length local score' {
	 	local evaltype e2
		local myeval mopt__ologit_e2()
	}
	else {
	 	local evaltype d2
		local myeval mopt__ologit_d2()
	}

nobreak {

	// note: `ord' will contain the tempname for a global Mata object
	mata: mopt__ordpl_init("ord")

capture noisily break {

	if `:list sizeof rhs' {
		local xb (`lhs': `lhs' = `rhs', noconstant `offopt' `expopt')
	}
	else {
		local xb (cut1: `lhs' =, `offopt' `expopt')
		gettoken drop cuteq : cuteq
	}

	// fit the full model
	`vv'					///
	ml model `evaltype' `myeval'		///
		`xb'				///
		`cuteq'				///
		`wgt' if `touse',		///
		`doopt'				///
		`initopt'			///
		`log'				///
		`mlopts'			///
		`crittype'			///
		`score'				///
		`warning'			///
		search(off)			///
		userinfo(`ord')			///
		noskipline			///
		`coll'				///
		missing				///
		nopreserve			///
		maximize

} // capture noisily break
	local rc = c(rc)

	if `rc' {
		capture mata: rmexternal("`ord'")
		exit `rc'
	}

} // nobreak

	mata: mopt__ordpl_post("`ord'")
	ereturn repost, buildfvinfo ADDCONS

	// save a title for -Replay- and the name of this command
	ereturn matrix cat `cat'
	if !missing(e(ll_0)) {
		ereturn scalar r2_p = 1 - e(ll)/e(ll_0)
	}
	ereturn local offset `e(offset1)'
	ereturn local offset1
	ereturn local title "Ordered logistic regression"
	ereturn hidden local marginsprop addcons
	ereturn local predict ologit_p
	ereturn hidden scalar version = 3
	ereturn local cmd ologit

	Replay , `table' `header' `or' `diopts'
end

program Replay
	syntax [, notable noHeader NOCOEF OR *]
	if "`nocoef'" != "" {
		local table notable
		local header noheader
	}
	_get_diopts diopts, `options'
	_prefix_display, notest `table' `header' `or' `diopts'
end

exit
