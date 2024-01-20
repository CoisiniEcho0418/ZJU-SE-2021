*! version 2.2.1  18feb2011
program test
	// no version here
	if "`e(cmd)'" == "anova" | "`e(cmd)'" == "manova" {
		// no version here
		AnovaTestChooser `0'
		exit
	}
	else if _caller() < 8 | replay() {
		// no version here
		// get to internal handler for speed
		_test `0'
		exit
	}
	else {
		version 8
		WaldTest `0'
		exit
	}
end


program WaldTest, rclass

// prepare for svy

	is_svy
	local is_svy `r(is_svy)'
	if "`is_svy'" == "1" {
		if "`e(complete)'" == "available" {
			di as err `"must run svy command with "complete" "' ///
			   "option before using this command"
			exit 301
		}
	}


// parse input

	// parse off specifications till comma
	// multiple specs are necessarily parenthesized.
	//
	// -anything- cannot be used due to possible syntax of test
	//   test exp=exp

	gettoken tok : 0, parse(" (,") bind
	local single single
	local zero `"`0'"'
	if `"`tok'"' == "(" {  		/* eqns within parens */
		local single 
		while `"`tok'"' == "(" {
			gettoken tok 0 : 0, parse(" (,") match(paren) bind
			local eqns `"`eqns' `"`tok'"'"'
			gettoken tok : 0, parse(" (,") bind
		}
		if `"`tok'"' != "," & `"`tok'"' != "" {
			local single single
		}
	}
	if "`single'"=="single" {              	/* eqn without parens */
		local eqns
		local 0 `"`zero'"'
		while `"`tok'"' != "" & `"`tok'"' != "," {
			gettoken tok 0 : 0, parse(" ,") bind
			local eqns `"`eqns' `tok'"'
			gettoken tok : 0, parse(" ,") bind
		}
		local eqns `"`"`eqns'"'"'
	}

	syntax [, Accumulate noSVYadjust common CONStant MINimum ///
	   Mtest Mtest2(passthru) noTest COEF matvlc(passthru) ]

	if `"`mtest'`mtest2'"' != "" {
		if inlist("`e(cmd)'", "svymean", "svytotal", "svyratio") {
			di as err `"mtest option not allowed after `e(cmd)'"'
			exit 301
		}
		_mtest syntax, `mtest' `mtest2'
		local mtmethod `r(method)'
	}
	if "`mtmethod'" != "" {
		if "`test'" != "" {
			di as err /*
			*/ "options mtest and notest may not be combined"
			exit 198
		}
		if "`accumulate'" != "" {
			di as err /*
			*/ "options mtest and accumulate may not be combined"
			exit 198
		}
	}

	if `is_svy' & inlist(`"`e(vce)'"', "bootstrap", "sdr") {
		if missing(e(df_r)) {
			local svyadjust nosvyadjust
		}
	}

	if !`is_svy' & "`svyadjust'" != "" {
		di as err "option nosvyadjust is allowed only with svy data"
		exit 198
	}
	local svy_adjust = `is_svy' & "`svyadjust'" == ""
	if `svy_adjust' & missing(e(df_r)) ///
	 & (missing(e(N_psu)) | missing(e(N_strata))) {
		di as err "impossible to adjust p-values"
		exit 198
	}
	if `is_svy' & `"`test'"' == "" {
		if "`svyadjust'" == "" {
			di _n as txt "Adjusted Wald test"
		}
		else	di _n as txt "Unadjusted Wald test"
	}


// bring constraints into expected format

	// check for triple =
	local tmp : subinstr local eqns "===" "", all count(local nch)
	if `nch' > 0 {
		di as err "=== invalid operator"
		exit 198
	}

	// translate == into =
	local eqns : subinstr local eqns "==" "=", all

	// expand multiple-equality constraint (a=b=c) syntax into
	// single equality constraint syntax (a=b) (a=c)
	ExpandExpns `"`eqns'"' "`common'" "`constant'"
	local explist `"`r(explist)'"'
	local nexp `r(nexp)'


// simultaneous test

	local acc `accumulate'
	foreach exp of local explist  {
		quietly _test `exp' , `acc' `common' `constant' notest
		local acc acc
	}

	if "`test'" == "notest" {
		_test , notest
		exit
	}

	quietly _test , `matvlc'


	// save rclass stuff
	if r(df_r) < . {
		local testtype F

		tempname F df df_r p drop
		scalar `F'    = r(F)
		scalar `df'   = r(df)
		scalar `df_r' = r(df_r)
		scalar `p'    = r(p)
		scalar `drop' = r(drop)
	}
	else {
		local testtype chi2

		tempname chi2 df p drop
		scalar `chi2' = r(chi2)
		scalar `df'   = r(df)
		scalar `p'    = r(p)
		scalar `drop' = r(drop)
	}

	// find out which constraints (if any) were dropped
	local i 1
	while "`r(dropped_`i')'" != "" {
		local dropped_`i' `r(dropped_`i')'
		local ++i
	}

	if `svy_adjust' {
		if !missing(e(df_r)) {
			// replication methods post missing values for one or
			// both of e(N_psu), e(N_strata)
			local svy_d = e(df_r)
		}
		else	local svy_d = e(N_psu)-e(N_strata)
		if missing(`svy_d') {
			di as err "internal error in adjustment for svy"
			exit 10001
		}
		if "`testtype'" == "F" {
			scalar `F' = ((`svy_d'-`df'+1)/`svy_d') * `F'
		}
		else {
			tempname F df_r
			scalar `F' = ((`svy_d'-`df'+1)/(`svy_d'*`df')) * `chi2'
		}
		scalar `df_r' = `svy_d' - `df' + 1
		scalar `p'    = Ftail(`df', `df_r', `F')
		local testype F
	}


// multiple testing -- 1 df

	if "`mtmethod'" != "" {

		tempname R r Rr V b VR tm Wald

		mat `V' = e(V)
		mat `b' = e(b)
		mat `Rr' = get(Rr)

		local nb = rowsof(`V')
		local nr = rowsof(`Rr')

		mat `R' = `Rr'[1...,1..`nb']
		mat `VR' = `R'*`V'*`R''
		mat `r' = `R'*`b'' - `Rr'[1...,`=`nb'+1']
		mat `Wald' = `r''*syminv(`VR')*`r'

		mat `tm' = J(`nr', 3, .)
		mat colnames `tm' = `testtype' df p

		forvalues it = 1 / `nr' {
			mat `Wald' = `r'[`it',1]^2 / `VR'[`it',`it']
			mat `tm'[`it',1] = `Wald'[1,1]
			mat `tm'[`it',2] = 1

			if `svy_adjust' {
				mat `tm'[`it',3] = Ftail(1,`svy_d',`tm'[`it',1])
			}
			else if "`testtype'" == "chi2" {
				mat `tm'[`it',3] = chi2tail(1,`tm'[`it',1])
			}
			else {
				mat `tm'[`it',3] = Ftail(1,`df_r',`tm'[`it',1])
			}
		}

		if "`mtmethod'" != "noadjust" {
			_mtest adjust `tm', mtest(`mtmethod') pindex(3) append
			mat `tm' = r(result)
			local pindex 4
		}
		else 	local pindex 3

	}


// Display results


	// invoke _test to display conditions
	// test is displayed later
	_test, notest

	// now display dropped constraints (if any)
	local i 1
	while "`dropped_`i''" != "" {
		di as txt "       Constraint `dropped_`i'' dropped"
		local ++i
	}

	if "`mtmethod'" == "" {

	/*	better looking output

		di
		if "`testtype'" == "chi2" {
			di as txt "{ralign 20:Wald chi2({res:`=`df''})} = " ///
			   as res %8.2f `chi2'
		}
		else {
			di as txt "{ralign 20:Wald F({res:`=`df''}, {res:`=`df_r''})} = " ///
			   as res %8.2f `F'
		}
		di "{txt}{ralign 20:Prob > `testtype'} = {res}" %8.4f `p'
	*/

		di
		if "`testtype'" == "chi2" {
			di as txt _col(12) "chi2(" %3.0f `df' ") =" /*
			*/ as res %8.2f `chi2'
			di as txt _col(10) "Prob > chi2 =  " as res %8.4f `p'
		}
		else {
			di as txt /*
			*/ "       F(" %3.0f `df' "," %6.0f `df_r' ") =" /*
			*/ as res %8.2f `F'
			di as txt _col(13) "Prob > F =" as res %10.4f `p'
		}

	}
	else {
		local nexp = rowsof(`tm')
		local nc   = colsof(`tm')

		if "`testtype'" == "F" {
			local d "F(df,`=`df_r'')"
		}
		else 	local d chi2

		di
		di as txt "{hline 7}{c TT}{hline 31}"
		di as txt "       {c |}{ralign 12:`d'}     df       p"
		di as txt "{hline 7}{c  +}{hline 31}"

		forvalues it = 1 / `nexp' {
			di as txt "  (`it'){col 8}{c |}" as res  ///
			   _col(12)  %9.2f  `tm'[`it',1]  ///
			   _col(22)  %6.0f  `tm'[`it',2]  ///
			   _col(33)  %6.4f  `tm'[`it',`pindex'] ///
			   as txt " #"
		}

		di as txt "{hline 7}{c +}{hline 31}"

		di as txt "  all  {c |}" as res ///
		   _col(12) %9.2f ``testtype''  ///
		   _col(22) %6.0f `df' ///
		   _col(33) %6.4f  `p'

		di as txt  "{hline 7}{c BT}{hline 31}"

		_mtest footer 39 "`mtmethod'" "#"
	}


	if "`coef'" != "" {
		Table
	}

// return results in r()

	return scalar p    = `p'
	return scalar df   = `df'
	if "`testtype'" == "F" {
		return scalar F    = `F'
		return scalar df_r = `df_r'
	}
	else 	return scalar chi2 = `chi2'

	return scalar drop = `drop'
	local i 1
	while "`dropped_`i''" != "" {
		return scalar dropped_`i' = `dropped_`i''
		local ++i
	}

	if "`mtmethod'" != "" {
		return matrix mtest     `tm'
		return local  mtmethod  `mtmethod'
	}
end


program AnovaTestChooser
	// no version here
	if ("`e(cmd)'" == "anova" & 0`e(version)'<2) | ///
		 ("`e(cmd)'" == "manova" & 0`e(version)'<2) {
		// no version here
		OldAnovaTestChooser `0'
		exit
	}
	else if ("`e(cmd)'" == "anova" & 0`e(version)'>1) {
		// no version here
		Anova2TestChooser `0'
		exit
	}
	else if ("`e(cmd)'" == "manova" & 0`e(version)'>1) {
		// no version here
		Mano2TestChooser `0'
		exit
	}
end
 
program Mano2TestChooser
	if replay() { // meaning no arguments before the comma
		capture syntax , SHOWORDer
		if _rc == 0 {	// test , showorder
			anovadef , showorder
			exit
		}
		capture syntax , TEST(passthru) [ * ]
		if _rc == 0 {	// test , test() ...
			version 8
			AnovaTest `0'
			exit
		}
				// replay on a test after manova
		// no version here
		_test `0'
		exit
	}

	version 8
	WaldTest `0'	// Not a special case (like above); treat like mvreg
end

program Anova2TestChooser
	if replay() { // meaning no arguments before the comma
		capture syntax , Symbolic
		if _rc == 0 {	// test , symbolic
			// no version here
			_anovatest `0'
			exit
		}
		capture syntax , SHOWORDer
		if _rc == 0 {	// test , showorder
			version 11
			anovadef , showorder
			exit
		}
		capture syntax , TEST(passthru) [ * ]
		if _rc == 0 {	// test , test() ...
			version 8
			AnovaTest `0'
			exit
		}
				// replay on a test after anova
		if "`r(ss)'" != "" {
			di as err ///
			    "test replay not allowed after testing model term"
			exit 302
		}
		// no version here
		_test `0'
		exit
	}

	CheckWhich1 `0'	// sets `doatest' and `dortest'
	if `dortest' { // Regular test (not specialized anova term tester)
		version 8
		WaldTest `0'	// treat like -test- after regress
		exit
	}
	else if `doatest' {
		// no version here
		_anovatest `0'
		exit
	}
	else {
		// The capture and then redo the command approach below will
		// not work as expected if -accumulate- is specified, but we
		// are okay because that case has already been handled

		// try the anova terms style -test-
		capture _anovatest `0'
		if _rc == 0 {
			// it worked, now run it without the capture
			_anovatest `0'
			exit
		}
		else {
			// try the regress style -test-
			version 8
			WaldTest `0'
			exit
		}
	}
end

/*
   Looking at certain syntactical elements we decide if a regular test
   (`dortest' == 1) or an anova terms test (`doatest' == 1) is being
   asked for.  CheckWhich1 sets the callers locals: dortest and doatest.
*/
program CheckWhich1
	version 11

	syntax anything(equalok everything) [, Symbolic Accumulate NOTest *]
	if "`symbolic'" != "" {
		if `"`options'`accumulate'`notest'"' != "" {
			di as err ///
			    "symbolic may not be combined with other options"
			exit 198
		}
		c_local doatest 1
		c_local dortest 0
		exit
	}

	if "`accumulate'`notest'" != "" {
		c_local doatest 0
		c_local dortest 1
		exit
	}

	// look for expression and coef list syntactical elements (these
	// would not be valid syntax with an anova terms test)
	mata:	st_local("found", strofreal( ///
			any(strpos(`"`anything'"', ///
				tokens(`"[ ] = : - + ( )"') ///
			)) ///
		))
	if `found' {
		c_local doatest 0
		c_local dortest 1
		exit
	}

	// Since we are past the previous check, if we see a "/" it indicates
	// we are doing an anova terms test where the error term is being
	// specified
	mata:	st_local("found", strofreal(strpos(`"`anything'"', "/")))
	if `found' {
		c_local doatest 1
		c_local dortest 0
		exit
	}

	// If we have reached here, we are not sure which kind of test
	c_local doatest 0
	c_local dortest 0
end

program OldAnovaTestChooser
	if replay() {	// meaning no arguments before the comma
		capture syntax , Symbolic
		if _rc == 0 {	// test , symbolic
			// no version here
			_test `0'
			exit
		}
		capture syntax , SHOWORDer
		if _rc == 0 {	// test , showorder
			// born() checks executable is recent enough
			version 8.1 , born(01aug2003)
			anovadef , showorder
			exit
		}
		capture syntax , TEST(passthru) [ * ]
		if _rc == 0 {	// test , test() ...
			version 8
			AnovaTest `0'
			exit
		}
				// replay on a test after [m]anova
		if "`r(ss)'" != "" {
			di as err ///
			    "test replay not allowed after testing model term"
			exit 302
		}
		// no version here
		_test `0'
		exit
	}
	else {
		// no version here
		// get to internal handler for speed
		_test `0'
		exit
	}
end


program AnovaTest, rclass
	// test , test(matname) [ mtest[(method)] matvlc(matname) ]
	syntax , TEST(name) [ Mtest Mtest2(passthru) matvlc(name) ]

	confirm matrix `test'
	
	tempname tmat
	// append column of zeros to matrix in prep for sending to mat_put_rr
	mat `tmat' = `test' , J(rowsof(`test'),1,0)
	mat_put_rr `tmat'

	// handle matvlc()
	if "`matvlc'" != "" {
		// _test currently requires an expression if the matvlc()
		// option is used.  We accumulate a test that is sure to
		// be dropped on to the end of the tests of interest
		qui _test, notest
		qui _test 0=0, accum matvlc(`matvlc')
		// and then delete the last row and column of the matrix
		local nrows = rowsof(`matvlc') - 1
		mat `matvlc' = `matvlc'[1..`nrows',1..`nrows']
		// now put the Rr matrix back how it was before
		mat_put_rr `tmat'
	}

	if `"`mtest'`mtest2'"' == "" {
		// no multiple comparisons to worry about
		// just use replay feature of test
		_test
		ret add
		exit
	}

	// need to handle multiple comparisons testing
	_mtest syntax, `mtest' `mtest2'
	local mtmethod `r(method)'

	// do the simultaneous test
	quietly _test

	// save rclass items for simultaneous test
	local testtype F
	tempname F df df_r p drop
	scalar `F'    = r(F)
	scalar `df'   = r(df)
	scalar `df_r' = r(df_r)
	scalar `p'    = r(p)
	scalar `drop' = r(drop)

	// find out which constraints (if any) were dropped
        local i 1
	while "`r(dropped_`i')'" != "" {
		local dropped_`i' `r(dropped_`i')'
		local ++i
	}


	// now do multiple testing
	tempname R r Rr V b VR tm Wald

	mat `V' = e(V)
	mat `b' = e(b)
	mat `Rr' = get(Rr)

	local nb = rowsof(`V')
	local nr = rowsof(`Rr')

	mat `R' = `Rr'[1...,1..`nb']
	mat `VR' = `R'*`V'*`R''
	mat `r' = `R'*`b'' - `Rr'[1...,`=`nb'+1']
	mat `Wald' = `r''*syminv(`VR')*`r'

	mat `tm' = J(`nr', 3, .)
	mat colnames `tm' = `testtype' df p

	forvalues it = 1 / `nr' {
		mat `Wald' = `r'[`it',1]^2 / `VR'[`it',`it']
		mat `tm'[`it',1] = `Wald'[1,1]
		mat `tm'[`it',2] = 1
		mat `tm'[`it',3] = Ftail(1,`df_r',`tm'[`it',1])
	}

	if "`mtmethod'" != "noadjust" {
		_mtest adjust `tm', mtest(`mtmethod') pindex(3) append
		mat `tm' = r(result)
		local pindex 4
	}
	else 	local pindex 3


	// Display results

	// invoke _test to display conditions
	// test is displayed later
	_test, notest

	// now display dropped constraints (if any)
	local i 1
	while "`dropped_`i''" != "" {
		di as txt "       Constraint `dropped_`i'' dropped"
		local ++i
	}

	if "`mtmethod'" == "" {
		di
		di as txt /*
		*/ "       F(" %3.0f `df' "," %6.0f `df_r' ") =" /*
		*/ as res %8.2f `F'
		di as txt _col(13) "Prob > F =" as res %10.4f `p'

	}
	else {
		local nexp = rowsof(`tm')
		local nc   = colsof(`tm')

		local d "F(df,`=`df_r'')"

		di
		di as txt "{hline 7}{c TT}{hline 31}"
		di as txt "       {c |}{ralign 12:`d'}     df       p"
		di as txt "{hline 7}{c  +}{hline 31}"

		forvalues it = 1 / `nexp' {
			di as txt "  (`it'){col 8}{c |}" as res  ///
			   _col(12)  %9.2f  `tm'[`it',1]  ///
			   _col(22)  %6.0f  `tm'[`it',2]  ///
			   _col(33)  %6.4f  `tm'[`it',`pindex'] ///
			   as txt " #"
		}

		di as txt "{hline 7}{c +}{hline 31}"

		di as txt "  all  {c |}" as res ///
		   _col(12) %9.2f ``testtype''  ///
		   _col(22) %6.0f `df' ///
		   _col(33) %6.4f  `p'

		di as txt  "{hline 7}{c BT}{hline 31}"

		_mtest footer 39 "`mtmethod'" "#"
	}

	// return results in r()

	return scalar p    = `p'
	return scalar df   = `df'
	return scalar F    = `F'
	return scalar df_r = `df_r'
	return scalar drop = `drop'
	local i 1
	while "`dropped_`i''" != "" {
		return scalar dropped_`i' = `dropped_`i''
		local ++i
	}

	if "`mtmethod'" != "" {
		return matrix mtest     `tm'
		return local  mtmethod  `mtmethod'
	}
end


// ===========================================================================
// subroutines
// ===========================================================================


/* ExpandExpns quoted-explist common

   returns in
     r(explist) the lists of quoted-equations,
     r(nexp)    the number of equations
*/
program ExpandExpns, rclass
	args expns common constant

	gettoken exp expns : expns
	while `"`exp'"' != "" {
		Expand `"`exp'"' "`common'" "`constant'"
		local explist `"`explist' `r(explist)'"'
		local nexp = `nexp' + `r(nexp)'

		gettoken exp expns : expns
	}
	return local explist `"`explist'"'
	return local nexp    `nexp'

	// di as err `"Expanded explist: `explist'"'
end


/* Expand multi-condition syntax (e.g., a=b=c)

   syntax 1: coefficient list
             returns unchanged input

   syntax 2: exp1=exp2 [=exp3]
             translated into
                exp1=exp2  exp1=exp3  ...
             beware: expi may be of form [eq]coef

   syntax 3: [eq1=eq2=eq3..] ..
             translated into
               [eq1=eq2] .. [eq1=eq3] .. etc            if common not defined
               [eq1=eq2] .. [eq1=eq3] .. [eq2=eq3] ..       if common defined

   returns in

     r(nexp)     the number of conditions/equations
     r(explist)  list of quoted conditions/expressions

   note: this command does not test that expressions are well-formed, or
   that eq is indeed an equation name.
*/
program define Expand, rclass
	args exp common constant

	// if at most one equal sign, no expansion is necessary
	local junk : subinstr local exp "=" "=", count(local nch) all
	if `nch' <= 1 {
		return local explist `"`"`exp'"'"'
		return local nexp 1
		exit
	}

	// determine syntax type
	tokenize `"`exp'"', parse(" []:=")
	if `"`1'"' == "[" & `"`3'"' == "=" {

		/* syntax should be:
			[eq=eq=..]
		   optionally followed by a : varlist */

		local eqnames `"`2'"'
		local neq 1
		mac shift 2
		while `"`1'"' == "=" {
			local ++neq
			local eqnames `"`eqnames' `2'"'
			mac shift 2
		}
		if "`1'" != "]" {
			di as err `"] expected, `1' found"'
			exit 198
		}
		mac shift
		if "`1'" != "" {
			if `"`1'"' != ":" {
				di as err `": expected, `colon' found"'
				exit 198
			}
			mac shift
			// unab vlist : `*'
			// local vlist `":`vlist'"'
			local vlist `":`*'"'
		}
		if `neq' < 2 {
			/* NOTREACHED */
			di as err "too few equations specified"
			exit 198
		}


		if "`common'" != "" {
			if `"`vlist'"' != "" {
				di as err ///
"option common may not be combined with syntax [eq...]:varlist"
				exit 198
			}

			// cleanup up eqnames names of form #<nnn>
			CleanUp "`eqnames'"
			local eqnames `r(eqnames)'

			CommonVar "`eqnames'" "`constant'"
			if "`r(varlist)'" == "" {
				di as err "no coefficients in common"
				exit 198
			}
			local vlist `":`r(varlist)'"'
		}

		// test all equations against equation 1
		gettoken eq1 eqrest : eqnames
		foreach eq of local eqrest {
			local explist `"`explist' `"[`eq1'=`eq']`vlist'"'"'
		}
		local nexp = `neq'-1
	}

	else {
		// syntax should be exp1=exp2=...=expk
		// we do not check at this point that expi is a valid expression

		tokenize `"`exp'"', parse("=")
		local exp1 `"`1'"'
		mac shift
		local nexp 0
		while "`1'" != "" {
			if "`1'" != "=" {
				di as err `"= expected, `1' found"'
				exit 198
			}
			if "`2'" == "" {
				di as err ///
"nothing found where expression expected"
				exit 198
			}
			local ++nexp
			local explist `"`explist' `"`exp1'=`2'"'"'
			mac shift 2
		}
	}

	return local explist `"`explist'"'
	return local nexp    `nexp'
end


/* CommonVar eqnames constant

   returns the variables common in the equations in eqnames in e(b)
   if "constant" is empty, _cons is removed
*/
program CommonVar, rclass
	args eqnames constant

	tempname b beq
	mat `b' = e(b)

	local neq 0
	foreach eq of local eqnames {
		// triggers error message if -eq- not found
		mat `beq' = `b'[1,"`eq':"]
		local names : colnames `beq'

		local ++neq
		if `neq' == 1 {
			local varlist `names'
			continue
		}

		// remove vars from varlist not found in names
		local myvars `"`varlist'"'
		foreach v of local myvars {
			local tmp : subinstr local names "`v'" "", /*
			  */ word all count(local nch)
			if `nch' == 0 {
				local varlist : subinstr local varlist /*
				*/ "`v'" "", word all
			}
		}
		if "`varlist'" == "" {
			exit
		}
	}

	// remove _cons
	if "`constant'" == "" {
		local varlist : subinstr local varlist "_cons" "", word all
	}

	return local varlist `varlist'
end


/*
	Drop all duplicate tokens from list
*/
program DropDup
	args 	newlist	  ///  name of macro to store new list
	        colon     ///  ":"
	        list       //  list with possible duplicates

	gettoken token list : list
	while "`token'" != "" {
		local fixlist `fixlist' `token'
		local list : subinstr local list "`token'" "", word all
		gettoken token list : list
	}

	c_local `newlist' `fixlist'
end


program CleanUp, rclass
	args eqnames

	assert "`eqnames'" != ""

	local tmp : subinstr local eqnames "#" "", count(local nch)
	if `nch' == 0 {
		// nothing to cleanup
		return local eqnames `eqnames'
		exit
	}

	tempname b
	mat `b' = e(b)
	local coleq : coleq `b'
	DropDup coleq : "`coleq'"

	tokenize `coleq'
	foreach eq of local eqnames {
		if substr("`eq'",1,1) == "#" {
			local eqn = substr("`eq'",2,.)
			capt confirm number `eqn'
			if _rc {
				di as err "equation `eq' not found"
				exit 303
			}
			if "``eqn''" == "" {
				di as err "equation `eq' not found"
				exit 303
			}
			local eq ``eqn''
		}
		local neweq `neweq' `eq'
	}
	return local eqnames `neweq'
end

program Table, eclass
	tempname est R r Rr V b br VR

	mat `V'  = e(V)
	mat `b'  = e(b)
	mat `Rr' = get(Rr)

	loc nb  = rowsof(`V')
	mat `R' = `Rr'[1..., 1..`nb']
	mat `r' = `R'*`b'' - `Rr'[1..., `=`nb'+1']

	mat `VR' = syminv(`R' * `V' * `R'')
	// mat `Wald' = `r'' * `VR' * `r'
	mat `VR' = `VR' * `R' * `V'
	// constrained estimator
	mat `br' = `b' - `r'' * `VR'
	// variance of constrained estimator
	mat `VR' = `V' - `V' * `R'' * `VR'

	local vct `e(vcetype)'
	local cl  `e(clustvar)'
	_estimates hold `est', restore

	ereturn post `br' `VR'
	ereturn local vcetype  `vct'
	ereturn local clustvar `cl'

	di _n(2) as txt "Constrained coefficients" _n
	ereturn display
end

exit
