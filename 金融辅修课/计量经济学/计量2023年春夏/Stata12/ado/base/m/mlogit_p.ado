*! version 11.0.0  18jun2009
program define mlogit_p			// predict for mlogit and svy:mlogit
	if `"`e(opt)'"' == "" {
		mlogit_p_10 `0'
		exit
	}
	if "`e(cmd)'" != "mlogit" {
		error 301
	}
	version 11

	// parse

	ParseNewVars `0'
	local varspec `s(varspec)'
	local varlist `s(varlist)'
	local typlist `s(typlist)'
	local nvars : list sizeof varlist
	local if `"`s(if)'"'
	local in `"`s(in)'"'
	local options `"`s(options)'"'

	ParseOptions, `options'
	local outcome `"`s(outcome)'"'
	local hasout : length local outcome
	local type `s(type)'
	if `:length local type' {
		local `type' `type'
	}
	else {
		if `hasout' {
			di in gr "(option pr assumed; predicted probability)"
		}
		else {
			di in gr "(option pr assumed; predicted probabilities)"
		}
		local type pr
	}

	// check syntax

	if `nvars' > 1 {
		if `hasout' {
			if "`type'" == "pr" {
				local tt "pr with outcome()"
			}
			else	local tt `type'
			Onevar "`tt'" `nvars'
		}
		else {
			MultVars `nvars'
		}
		if `hasout' {
			di as err ///
"option outcome() is not allowed when multiple new variables are specified"
			exit 198
		}
		if !inlist("`type'","pr","scores") {
			di as err ///
			"option `type' requires that you specify 1 new variable"
			error 103
		}
	}
	else if !`hasout' {
		if "`type'" == "stddp" {
			di as err ///
			"option `type' requires the outcome() option"
			exit 198
		}
		local outcome "#1"
		local hasout 1
	}

	// process equation/outcome option

	if `hasout' {
		local oout : copy local outcome
		EqNo "`type'" `outcome'
		local outcome `"`s(eqno)'"'
		if "`s(stddp)'" == "stdp" {
			// local stddp is changed to stdp if basecategory
			// selected as one of the equations

			local stddp "stdp"
		}

		local eqopt `"equation(`"`outcome'"')"'
	}

	// scores

	if `"`type'"' == "scores" {
		GenScores `varspec' `if' `in', `eqopt'
		sreturn clear
		exit
	}

	// Index, XB, or STDP

	if inlist("`type'", "index", "xb", "stdp", "stddp") {
		Onevar `type' `nvars'

		// note: `type' may be stddp, but ``type'' may be stdp
		_predict `typlist' `varlist' `if' `in', ``type'' `eqopt' 

		if inlist("`type'", "index", "xb") {
			Outcome `outcome'
			local label ///
			`"Linear prediction, `e(depvar)'==`s(outcome)'"'
		}
		else if "`type'" == "stdp"  {
			Outcome `outcome'
			local label ///
			`"S.E. of linear prediction, `e(depvar)'==`s(outcome)'"'
		}
		else { // "`type'" == "stddp"
			local label `"stddp(`oout')"'
		}
		label var `varlist' `"`label'"'

		sreturn clear
		exit
	}

	// probability with outcome() specified: create one variable

	if "`type'" == "pr" & `hasout' {
		Onevar "pr with outcome()" `nvars'

		OneP `typlist' `varlist' `if' `in', `eqopt' 

		Outcome `outcome'
		label var `varlist' `"Pr(`e(depvar)'==`s(outcome)')"'
		sreturn clear
		exit
	}

	// probabilities without outcome(): create e(k_out) variables

	tempvar touse
	mark `touse' `if' `in'

	AllP "`typlist'" "`varlist'" `touse' 
end

program MultVars
	args nvars
	if `nvars' != e(k_out) {
		local rc = cond(`nvars'<e(k_out), 102, 103)
		capture noisily error `rc'
		di as err "{p}"	///
			"`e(depvar)' has `e(k_out)' outcomes and so you " ///
			"must specify `e(k_out)' new variables, or " ///
			"you can use the outcome() option and specify " ///
			"variables one at a time" ///
			"{p_end}"
		exit `rc'
	}
end

program define Outcome, sclass
	if "`0'"=="" {
		local i = e(ibaseout)
	}
	else	local i = substr("`0'",2,.)
	local eqlist `"`e(eqnames)'"'
	sreturn local outcome : word `i' of `eqlist'
end

program define Onevar
	args option n
	if (`n'==1) exit
	di in red "option `option' requires that you specify 1 new variable"
	error cond(`n'==0,102,103)
end

program define EqNo2, sclass
	sreturn clear
	gettoken type 0 : 0
	if `"`type'"' != "stddp" {
		sreturn local eqno `"`0'"'
		exit
	}

	gettoken eq1 0 : 0, parse(" ,")
	gettoken comma eq2 : 0, parse(",")
	if `"`comma'"' != "," {
		di in red "second outcome not found"
		exit 303
	}
	sreturn local eqno `"`eq1',`eq2'"'
end

program define EqNo, sclass
	sreturn clear
	gettoken type 0 : 0
	if "`type'" != "stddp" {
		Eq `0'
		exit
	}

	gettoken eq1 0 : 0, parse(",")
	gettoken comma eq2 : 0, parse(",")
	if "`comma'" != "," {
		di in red "second outcome not found"
		exit 303
	}

	Eq `eq1'
	local eq1 `"`s(eqno)'"'
	Eq `eq2'
	if `"`eq1'"' != "" & `"`s(eqno)'"' != "" {
		sreturn local eqno `"`eq1',`s(eqno)'"'
	}
	else {
		sreturn local eqno `"`eq1'`s(eqno)'"'
		sreturn local stddp "stdp"
	}
end

program define Eq, sclass
	sreturn clear
	local eqlab = trim(`"`0'"')
	if substr(`"`eqlab'"',1,1)=="#" {
		sreturn local eqno `"`eqlab'"'
		exit
	}
	local kout = e(k_out)
	capture confirm number `eqlab'
	if _rc == 0 {
		forval i = 1/`kout' {
			local match (reldif(el(e(out),1,`i'),`eqlab') < 1e-7)
			if `match' {
				sreturn local eqno "#`i'"
				local exit exit
				break
			}
		}
		`exit'
	}
	else {
		local eqlist `"`e(eqnames)'"'
		if `:list eqlab in eqlist' {
			local i : list posof `"`eqlab'"' in eqlist
			sreturn local eqno "#`i'"
			local exit exit
			break
		}
		`exit'
	}

	di as error `"outcome `eqlab' not found"'
	exit 303
end

program define Zero
	syntax newvarname [if] [in] 
	tempvar xb
	qui _predict double `xb' `if' `in' 
	gen `typlist' `varlist' = 0 if `xb'<.
end

program define OneP
	syntax newvarname [if] [in] [, Equation(string) ]
	tempvar touse den xb
	mark `touse' `if' `in'

	// this command is only called with equation() in #eqno form

	local outcome = substr(`"`equation'"',2,.)

quietly {

	// compute denominator `den' = 1 + Sum(exp(`xb'))

	gen double `den' = 1 if `touse'
	local kout = e(k_out)
	forval i = 1/`kout' {
		if `i' == e(ibaseout) {
			continue
		}
		_predict double `xb' if `touse', eq(#`i') xb 

		// If `den'<0, then `den'==+inf.

		// If `den'==-1, then there is just one +inf: p=0 if
		// exp(`xbsel')<., and p=1 if exp(`xbsel')>=.
		// (i.e., requested category gave the +inf).

		// If `den' < -1, then there are two or more +inf: p=0
		// if exp(`xbsel')<.; and p=. if exp(`xbsel')>=.
		// (since we cannot say what its value should be).

		replace `den' = cond(`xb'<. & exp(`xb')>=.,	///
				cond(`den'<0,`den'-1,-1),	///
					`den'+exp(`xb')) if `touse'

		if "`i'" == "`outcome'" {
			tempvar xbsel
			rename `xb' `xbsel'
		}
		else	drop `xb'

	}

} // quietly


	// noisily compute probability of selected category

	if `outcome' == e(ibaseout) {
		gen `typlist' `varlist' = cond(`den'>0,1/`den',0) if `touse'
	}
	else if "`xbsel'" == "" {	// outcome not found
		di in red `"equation #`outcome' not found"'
		exit 303
	}
	else {
		gen `typlist' `varlist' = cond(`den'>0,exp(`xbsel')/`den', /*
		*/ cond(exp(`xbsel')<.,0,cond(`den'==-1,1,.))) if `touse'
	}
end

program define AllP
	args typlist varlist touse 

quietly {

	tempvar den tmp
	tempname miss cat

	// compute denominator `den' = 1 + Sum(exp(`xb'))

	gen double `den' = 1 if `touse'
	local kout = e(k_out)
	forval i = 1/`kout' {
		tempvar xb
		if `i' == e(ibaseout) {
			continue
		}
		_predict double `xb' if `touse', eq(#`i') xb 
		local p`i' `xb'

		// see comments in OneP

		replace `den' = cond(`xb'<. & exp(`xb')>=.,	///
				cond(`den'<0,`den'-1,-1),	///
					`den'+exp(`xb')) if `touse'
	}

	// compute probabilities

	local same 1
	mat `miss' = J(1,`e(k_out)',0)
	mat `cat' = e(out)
	forval i = 1/`kout' {
		local typ : word `i' of `typlist'

		if `i' == e(ibaseout) {
			tempvar p`i'
			gen `typ' `p`i'' = cond(`den'>0,1/`den',0) if `touse'
			local eqi `"`e(baselab)'"'
		}
		else {
			gen `typ' `tmp' = cond(`den'>0,		///
				exp(`p`i'')/`den',		///
				cond(exp(`p`i'')<.,0,		///
				cond(`den'==-1,1,.))) if `touse'
			drop `p`i''
			rename `tmp' `p`i''
		}
		local eqi : word `i' of `e(eqnames)'

		// count # of missings
		count if `p`i''>=.
		mat `miss'[1,`i'] = r(N)
		if `miss'[1,`i']!=`miss'[1,1] {
			local same 0
		}

		// label variable
		label var `p`i'' `"Pr(`e(depvar)'==`eqi')"'
	}

} // quietly

	tokenize `varlist'
	forval i = 1/`kout' {
		rename `p`i'' ``i''
	}
	ChkMiss `same' `miss' `varlist'
end

program define ChkMiss
	args same miss
	macro shift 2
	if `same' {
		SayMiss `miss'[1,1]
		exit
	}
	forval i = 1/`e(k_out)' {
		SayMiss `miss'[1,`i'] ``i''
	}
end

program define SayMiss
	args nmiss varname
	if (`nmiss' == 0) exit
	if `:length local varname' {
		local varname "`varname': "
	}
	if `nmiss' == 1 {
		di in blu "(`varname'1 missing value generated)"
		exit
	}
	local nmiss = `nmiss'
	di in blu "(`varname'`nmiss' missing values generated)"
end

program ParseNewVars, sclass
	syntax [anything(name=vlist)] [if] [in] [, *]
	local myif `"`if'"'
	local myin `"`in'"'
	local myopts `"`options'"'

	if `"`vlist'"' == "" {
		di as err "varlist required"
		exit 100
	}
	local varspec `"`vlist'"'
	local neq = e(k_out)
	local stub 0
	if index("`vlist'","*") {
		_stubstar2names `vlist', nvars(`neq')
		local varlist `s(varlist)'
		local typlist `s(typlist)'
		confirm new var `varlist'
	}
	else {
		syntax newvarlist [if] [in] [, * ]
	}
	local nvars : word count `varlist'

	sreturn clear
	sreturn local varspec `varspec'
	sreturn local varlist `varlist'
	sreturn local typlist `typlist'
	sreturn local if `"`myif'"'
	sreturn local in `"`myin'"'
	sreturn local options `"`myopts'"'
end

program ParseOptions, sclass
	syntax [,			///
		Equation(string)	///
		Outcome(string)		///
		Index			///
		XB			///
		STDP			///
		STDDP			///
		Pr			///
		SCores			///
	]

	// check options that take arguments
	local rc 0
	if `"`equation'"' != "" & `"`outcome'"' != "" {
		opts_exclusive "equation() outcome()"
	}

	// check switch options
	local type `index' `xb' `stdp' `stddp' `pr' `scores'
	opts_exclusive "`type'"

	// save results
	sreturn clear
	sreturn local type	`type'
	sreturn local outcome	`"`equation'`outcome'"'
end

program GenScores, rclass
	local cmd = cond("`e(prefix)'"=="svy","svy:","")+"`e(cmd)'"
	syntax [anything] [if] [in] [, * ]
	marksample touse
	_score_spec `anything', `options'
	local varlist `s(varlist)'
	local typlist `s(typlist)'
	local nvars : word count `varlist'
	local spec = substr("`s(eqspec)'",2,.)
	if "`spec'" == "" {
		numlist "1/`nvars'"
		local spec `r(numlist)'
	}
	tempvar p d

	local depvar "`e(depvar)'"
	forval i = 1/`nvars' {
		local typ : word `i' of `typlist'
		local var : word `i' of `varlist'
		local eq  : word `i' of `spec'
		if `eq' == e(ibaseout) {
			quietly _predict `typ' `var' if `touse', xb eq(#`eq')
		}
		else {
			quietly OneP `typ' `p' if `touse', eq(#`eq')
			local match (reldif(el(e(out),1,`eq'),`depvar') < 1e-7)
			quietly gen byte `d' = `match' if `touse'
			quietly gen `typ' `var' = (`d'-`p')
			drop `d' `p'
		}

		Outcome #`eq'
		label var `var'	///
		`"equation-level score from `cmd', `depvar'==`s(outcome)'"'
	}
	return local scorevars `varlist'
end

exit
