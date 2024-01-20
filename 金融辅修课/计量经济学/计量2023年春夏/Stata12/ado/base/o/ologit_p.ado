*! version 1.3.0  19may2009
/* predict for ologit, oprobit, svyologit, and svyoprobit */
program define ologit_p 
	version 9, missing

/* Parse. */

	syntax [anything] [if] [in] [, * ]
	if index(`"`anything'"',"*") {
		ParseNewVars `0'
		local varspec `s(varspec)'
		local varlist `s(varlist)'
		local typlist `s(typlist)'
		local if `"`s(if)'"'
		local in `"`s(in)'"'
		local options `"`s(options)'"'
	}
	else {
		local varspec `anything'
		syntax [newvarlist] [if] [in] [, * ]
	}
	local nvars : word count `varlist'

	ParseOptions, `options'
	local type `s(type)'
	local outcome `s(outcome)'
	if "`type'" != "" {
		local `type' `type'
	}
	else {
		if `"`outcome'"' != "" {
			di in gr "(option pr assumed; predicted probability)"
		}
		else {
			di in gr "(option pr assumed; predicted probabilities)"
		}
	}
	version 6, missing

/* Check syntax. */

	if `nvars' > 1 {
		MultVars `varlist'
		if `"`outcome'"' != "" {
			di as err ///
"option outcome() is not allowed when multiple new variables are specified"
			exit 198
		}
	}
	else if inlist("`type'","","pr","scores") & `"`outcome'"' == "" {
		local outcome "#1"
	}
	else if !inlist("`type'","","pr","scores") & `"`outcome'"' != "" {
		di in smcl as err ///
"{p 0 0 2}option outcome() cannot be specified with option `type'{p_end}"
		exit 198
	}

/* scores */

	if `"`type'"' == "scores" {
		if `"`outcome'"' != "" {
			local type `"equation(`outcome')"'
		}
		GenScores `varspec' `if' `in', `type'
		sret clear
		exit
	}

/* Index, XB, or STDP. */

	if "`type'"=="index" | "`type'"=="xb" | "`type'"=="stdp" {

		Onevar `type' `varlist'

		if e(df_m) != 0 | ("`e(offset)'"!="" & "`offset'"=="") {
			_predict `typlist' `varlist' `if' `in', `type' `offset'
		}
		else	gen `typlist' `varlist' = . `if' `in'

		if "`type'"=="index" | "`type'"=="xb"  {
			label var `varlist' /*
			*/ "Linear prediction (cutpoints excluded)"
		}
		else { /* stdp */
			label var `varlist' /*
			*/ "S.E. of linear prediction (cutpoints excluded)"
		}
		exit
	}

/* If here we compute probabilities.  Do general preliminaries. */

	if inlist("`e(cmd)'", "ologit", "oprobit") & missing(e(version)) {
		local cut "_cut" /* _b[_cut1] */
	}
	else	local cut "/cut" /* _b[/cut1] */

	if "`e(cmd)'"=="ologit" | "`e(cmd)'"=="svyologit" {
		local func  "1/(1+exp("
		local funcn "1-1/(1+exp("
	}
	else {
		local func  "normprob(-("
		local funcn "normprob(("
	}


	tempvar touse
	mark `touse' `if' `in'

	if e(df_m) != 0 {
		tempvar xb
		qui _predict double `xb' if `touse', xb `offset'
	}
	else if "`e(offset)'"!="" & "`offset'"=="" {
		local xb `e(offset)'
	}
	else	local xb 0

/* Probability with outcome() specified: create one variable. */

	if ("`type'"=="pr" | "`type'"=="") & `"`outcome'"'!="" {
		Onevar "p with outcome()" `varlist'

		Eq `outcome'
		local i `s(icat)'
		local im1 = `i' - 1
		sret clear

		if `i' == 1 {
			gen `typlist' `varlist' = /*
			*/ `func'`xb'-_b[`cut'1])) /*
			*/ if `touse'
		}
		else if `i' < e(k_cat) {
			gen `typlist' `varlist' = /*
			*/   `func'`xb'-_b[`cut'`i'])) /*
			*/ - `func'`xb'-_b[`cut'`im1'])) /*
			*/ if `touse'
		}
		else {
			gen `typlist' `varlist' = /*
			*/ `funcn'`xb'-_b[`cut'`im1'])) /*
			*/ if `touse'
		}

		local val = el(e(cat),1,`i')
		label var `varlist' "Pr(`e(depvar)'==`val')"
		exit
	}

/* Probabilities with outcome() not specified: create e(k_cat) variables. */

	tempname miss
	local same 1
	mat `miss' = J(1,`e(k_cat)',0)

	quietly {
		local i 1
		while `i' <= e(k_cat) {
			local typ : word `i' of `typlist'
			tempvar p`i'
			local im1 = `i' - 1

			if `i' == 1 {
				gen `typ' `p`i'' = /*
				*/ `func'`xb'-_b[`cut'1])) /*
				*/ if `touse'
			}
			else if `i' < e(k_cat) {
				gen `typ' `p`i'' = /*
				*/   `func'`xb'-_b[`cut'`i'])) /*
				*/ - `func'`xb'-_b[`cut'`im1'])) /*
				*/ if `touse'
			}
			else {
				gen `typ' `p`i'' = /*
				*/ `funcn'`xb'-_b[`cut'`im1'])) /*
				*/ if `touse'
			}

		/* Count # of missings. */

			count if `p`i''>=.
			mat `miss'[1,`i'] = r(N)
			if `miss'[1,`i']!=`miss'[1,1] {
				local same 0
			}

		/* Label variable. */

			local val = el(e(cat),1,`i')
			label var `p`i'' "Pr(`e(depvar)'==`val')"

			local i = `i' + 1
		}
	}

	tokenize `varlist'
	local i 1
	while `i' <= e(k_cat) {
		rename `p`i'' ``i''
		local i = `i' + 1
	}
	ChkMiss `same' `miss' `varlist'
end

program MultVars
	syntax [newvarlist]
	local nvars : word count `varlist'
	if `nvars' == e(k_eq) {
		exit
	}
	if `nvars' != e(k_cat) {
		capture noisily error cond(`nvars'<e(k_cat), 102, 103)
		di in red /*
		*/ "`e(depvar)' has `e(k_cat)' outcomes and so you " /*
		*/ "must specify `e(k_cat)' new variables, or " _n /*
		*/ "you can use the outcome() option and specify " /*
		*/ "variables one at a time"
		exit cond(`nvars'<e(k_cat), 102, 103)
	}
end

program CompScores, sortpreserve
	version 9, missing
	gettoken doit 0 : 0
	syntax newvarname [, noOFFset score(integer 0) ]

	local depvar `e(depvar)'
	markout `doit' `depvar'

	tempvar cat cutL cutU
	tempname cuts

	mat `cuts' = e(b)
	if colsof(`cuts') >= e(k_cat) {
		tempvar xb
		_predict `typlist' `xb' if `doit', xb `offset'
		local --score
		c_local score `score'
	}
	else if `"`e(offset)'"' != "" & `"`offset'"' == "" {
		local xb `e(offset)'
	}
	else	local xb 0

	if inlist("`e(cmd)'", "ologit", "oprobit") {
		if (missing(e(version))) {
			local cut1 = colnumb(`cuts',"_cut1")
		}
		else {
			local cut1 = colnumb(`cuts',"cut1:")
		}
		local prog `e(cmd)'_scores
	}
	else {
		error 301
	}
	matrix `cuts' = `cuts'[1,`cut1'...]
	local ncut = colsof(`cuts')

	sort `doit' `depvar'
	by `doit' `depvar' : gen double `cat' = _n==1 if `doit'
	replace `cat' = sum(`cat')

	gen double `cutL' = `cuts'[1,`cat'-1]-`xb' if `doit'
	gen double `cutU' = `cuts'[1,`cat']-`xb' if `doit'

	gen `typlist' `varlist' = 0 if `doit'

	`prog' `varlist' `doit' `cat' `cutL' `cutU' `score' `ncut'
end

program ologit_scores
	args varlist doit cat cutL cutU score ncut
	if `score' == 0 | `ncut' == 1 {
		if `score' == 0 {
			local minus0 "-"
			local minus1 "-"
			local minus2 ""
		}
		else {
			local minus0 ""
			local minus1 ""
			local minus2 "-"
		}
		replace `varlist' = `minus0'(			///
			 invlogit(`cutU')*invlogit(-`cutU')	///
			-invlogit(`cutL')*invlogit(-`cutL')	///
			) / (invlogit(`cutU')-invlogit(`cutL'))	///
			if `doit'
		replace `varlist' = `minus1'invlogit(-`cutU')	///
			if `doit' & missing(`cutL')
		replace `varlist' = `minus2'invlogit(`cutL')	///
			if `doit' & missing(`cutU')
	}
	else if `score' == 1 {
		replace `varlist' = invlogit(-`cutU')		///
			if `doit' & `cat' == `score'
		replace `varlist' =				///
			-invlogit(`cutL')*invlogit(-`cutL') /	///
			(invlogit(`cutU')-invlogit(`cutL'))	///
			if `doit' & `cat' == `score'+1
	}
	else if `score' == `ncut' {
		replace `varlist' = -invlogit(`cutL')		///
			if `doit' & `cat' == `score'+1
		replace `varlist' =				///
			 invlogit(`cutU')*invlogit(-`cutU') /	///
			(invlogit(`cutU')-invlogit(`cutL'))	///
			if `doit' & `cat' == `score'
	}
	else {
		replace `varlist' =				///
			 invlogit(`cutU')*invlogit(-`cutU') /	///
			(invlogit(`cutU')-invlogit(`cutL'))	///
			if `doit' & `cat' == `score'
		replace `varlist' =				///
			-invlogit(`cutL')*invlogit(-`cutL') /	///
			(invlogit(`cutU')-invlogit(`cutL'))	///
			if `doit' & `cat' == `score'+1
	}
end

program oprobit_scores
	args varlist doit cat cutL cutU score ncut
	if `score' == 0 | `ncut' == 1 {
		if `score' == 0 {
			local minus0 "-"
			local minus1 "-"
			local minus2 ""
		}
		else {
			local minus0 ""
			local minus1 ""
			local minus2 "-"
		}
		replace `varlist' = `minus0'(			///
			 normden(`cutU') - normden(`cutL')	///
			) / (norm(`cutU')-norm(`cutL'))		///
			if `doit'
		replace `varlist' =				///
			`minus1'normden(`cutU')/norm(`cutU')	///
			if `doit' & missing(`cutL')
		replace `varlist' =				///
			`minus2'normden(`cutL')/norm(-`cutL')	///
			if `doit' & missing(`cutU')
	}
	else if `score' == 1 {
		replace `varlist' =				///
			normden(`cutU')/norm(`cutU')		///
			if `doit' & `cat' == `score'
		replace `varlist' =				///
			-normden(`cutL') /			///
			(norm(`cutU')-norm(`cutL'))		///
			if `doit' & `cat' == `score'+1
	}
	else if `score' == `ncut' {
		replace `varlist' =	 			///
			-normden(`cutL')/norm(-`cutL')		///
			if `doit' & `cat' == `score'+1
		replace `varlist' =				///
			normden(`cutU') /			///
			(norm(`cutU')-norm(`cutL'))		///
			if `doit' & `cat' == `score'
	}
	else {
		replace `varlist' =				///
			normden(`cutU') /			///
			(norm(`cutU')-norm(`cutL'))		///
			if `doit' & `cat' == `score'
		replace `varlist' =				///
			-normden(`cutL') /			///
			(norm(`cutU')-norm(`cutL'))		///
			if `doit' & `cat' == `score'+1
	}
end

program define ChkMiss
	args same miss
	macro shift 2
	if `same' {
		SayMiss `miss'[1,1]
		exit
	}
	local i 1
	while `i' <= e(k_cat) {
		SayMiss `miss'[1,`i'] ``i''
		local i = `i' + 1
	}
end

program define SayMiss
	args nmiss varname
	if `nmiss' == 0 { exit }
	if "`varname'"!="" {
		local varname "`varname': "
	}
	if `nmiss' == 1 {
		di in blu "(`varname'1 missing value generated)"
		exit
	}
	local nmiss = `nmiss'
	di in blu "(`varname'`nmiss' missing values generated)"
end

program define Eq, sclass
	sret clear
	local out = trim(`"`0'"')
	if substr(`"`out'"',1,1)=="#" {
		local out = substr(`"`out'"',2,.)
		Chk confirm integer number `out'
		Chk assert `out' >= 1
		capture assert `out' <= e(k_cat)
		if _rc {
			di in red "there is no outcome #`out'" _n /*
			*/ "there are only `e(k_cat)' categories"
			exit 111
		}
		sret local icat `"`out'"'
		exit
	}

	Chk confirm number `out'
	local i 1
	while `i' <= e(k_cat) {
		if `out' == el(e(cat),1,`i') {
			sret local icat `i'
			exit
		}
		local i = `i' + 1
	}

	di in red `"outcome `out' not found"'
	Chk assert 0 /* return error */
end

program define Chk
	capture `0'
	if _rc {
		di in red "outcome() must either be a value of `e(depvar)'," /*
		*/ _n "or #1, #2, ..."
		exit 111
	}
end

program define Onevar
	gettoken option 0 : 0
	local n : word count `0'
	if `n'==1 { exit }
	di in red "option `option' requires that you specify 1 new variable"
	error cond(`n'==0,102,103)
end

program GenScores, rclass
	version 9, missing
	local cmd = cond("`e(cmd)'"=="svy","svy:","")+"`e(cmd)'"
	syntax [anything] [if] [in] [, * ]
	marksample doit
	if missing(e(version)) {
		local old oldologit
	}
	_score_spec `anything', `options' `old'
	local varlist `s(varlist)'
	local typlist `s(typlist)'
	local nvars : word count `varlist'
	local spec = substr("`s(eqspec)'",2,.)
	if "`spec'" == "" {
		numlist "1/`nvars'"
		local spec `r(numlist)'
	}

	forval i = 1/`nvars' {
		local typ : word `i' of `typlist'
		local var : word `i' of `varlist'
		local eq  : word `i' of `spec'
		local score = `eq'

		quietly CompScores `doit' `typ' `var', score(`score')

		if !`score' {
			local label = "x*b"
		}
		else if e(k_eq) == e(k_cat) {
			local label = cond(`eq'==1,"x*b","_cut`score'")
		}
		else	local label = "_cut`score'"
		local cmd = cond("`e(prefix)'"=="svy","svy:","")+"`e(cmd)'"
		label var `var' "equation-level score for `label' from `cmd'"
	}
	return local scorevars `varlist'
end

program ParseNewVars, sclass
	version 9, missing
	syntax [anything(name=vlist)] [if] [in] [, * ]

	if missing(e(version)) {
		local old oldologit
	}
	_score_spec `vlist', `old'
	sreturn local varspec `vlist'
	sreturn local if	`"`if'"'
	sreturn local in	`"`in'"'
	sreturn local options	`"`options'"'
end

program ParseOptions, sclass
	version 9, missing
	syntax [,			///
		Outcome(string)		///
		EQuation(string)	///
		Index			///
		XB			///
		STDP			///
		Pr			///
		noOFFset		///
		SCores			///
		SCore(string)		///
	]

	// check options that take arguments
	if `"`equation'"' != "" & `"`score'"' != "" {
		di as err ///
		"options score() and equation() may not be combined"
		exit 198
	}
	if `"`score'"' != "" & `"`outcome'"' != "" {
		di as err ///
		"options score() and outcome() may not be combined"
		exit 198
	}
	if `"`equation'"' != "" & `"`outcome'"' != "" {
		di as err ///
		"options equation() and outcome() may not be combined"
		exit 198
	}
	local eq `"`score'`equation'`outcome'"'

	// check switch options
	local type `index' `xb' `stdp' `pr' `scores'
	if `:word count `type'' > 1 {
		local type : list retok type
		di as err "the following options may not be combined: `type'"
		exit 198
	}
	if !inlist("`type'","","scores") & `"`score'"' != "" {
		di as err "options `type' and score() may not be combined"
		exit 198
	}
	if `"`score'"' != "" {
		local scores scores
	}

	// save results
	sreturn clear
	sreturn local type	`type'
	sreturn local outcome	`"`eq'"'
end
