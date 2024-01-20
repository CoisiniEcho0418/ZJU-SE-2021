*! version 1.1.3  24sep2004
program define boxco_p
	version 7.0, missing
	syntax newvarname [if] [in], [ YHAT XBT REsiduals] 

	tempname diff
	local sumt = ("`yhat'"!="") + ("`xbt'"!="") +("`residuals'"!="")

	if `sumt' >1 {
		di as err "only one statistic may be specified"
		exit 198
	}
	else { 
		if `sumt' == 0 {
			local stat "xbt"
			di as txt /*
		*/ "(option xbt assumed; transformed linear predictions)"
		}
		else 	local stat "`yhat'`xbt'`residuals'"
	}

	if "`e(model)'" == "rhsonly" {
		tempname bvec lam1 lam
		tempvar ntrans

		matrix `bvec'=e(b)

		matrix `lam1'=`bvec'[1,"lambda:_cons"]
		scalar `lam'=`lam1'[1,1]

/* 	Get linear part using _predict */

		if "`e(ntrans)'" != "" {
			quietly _predict double `ntrans', xb eq(#1) 
		}
		else 	scalar `ntrans' = 0

		local cnames : colnames `bvec'
		local ceqs : coleq `bvec'

		tokenize `ceqs'
		local i 1
		local rhs
	
		while "`1'" != "" {
			if "`1'" == "Trans" {
				local var : word `i' of `cnames'
				scalar `diff'=reldif(`lam', 0) 
				if `diff'>1e-10 {
				   local rhs /*
*/ "`rhs' + `bvec'[1,`i']*( `var'^`lam' -1 )/`lam' "
				}
				else {
				   local rhs /*
*/ "`rhs' +  `bvec'[1,`i']*ln(`var') "
				}
			}
			local i = `i' + 1
			macro shift
		}

		if "`stat'"=="residuals" {
			gen `typlist' `varlist' = `e(depvar)' /*
				*/  -( `ntrans' `rhs' ) `if' `in'

		}
		else {
			gen `typlist' `varlist'= `ntrans'  `rhs' `if' `in'
			label variable `varlist' "fitted values"
		}
		exit
	}
	if "`e(model)'"=="lhsonly" {

		tempname bvec theta1 theta
		tempvar ntrans

		matrix `bvec'=e(b)
		matrix `theta1'=`bvec'[1,"theta:_cons"]
		scalar `theta'=`theta1'[1,1]

		scalar `diff'=reldif(`theta', 0)


/* 	Get linear part using _predict */
		quietly  _predict double `ntrans', xb eq(#1) 

		if "`stat'"=="xbt" {
			gen `typlist' `varlist'= `ntrans' `if' `in'
			local lab "(Transformed) Linear Prediction"	
			label variable `varlist' "`lab'"
			exit
		}
		if "`stat'" =="yhat" {
			if `diff'>1e-10 {
				gen `typlist' `varlist'= /*
					*/ (`theta'*`ntrans'+1 )^(1/`theta') /*
					*/ `if' `in'
			}
			else 	gen `typlist' `varlist'=/* 
					*/ exp(`ntrans') `if' `in'
			label variable `varlist' "fitted values"
			exit
		}
/* if not xbt nor yhat then must be residuals */
		if `diff'>1e-10 {
			gen `typlist' `varlist'=`e(depvar)'- /*
				*/ (`theta'*`ntrans'+1 )^(1/`theta') `if' `in'
		}
		else 	gen `typlist' `varlist'=`e(depvar)' - /* 
				*/ exp(`ntrans') `if' `in'
		label variable `varlist' "residuals"
		exit
	}

	if "`e(model)'" == "lambda" {
		tempname bvec lam1 lam
		tempvar ntrans

		matrix `bvec'=e(b)

		matrix `lam1'=`bvec'[1,"lambda:_cons"]
		scalar `lam'=`lam1'[1,1]

/* 	Get linear part using _predict */
		
		if "`e(ntrans)'" != "" {
			quietly _predict double `ntrans', xb eq(#1) 
		}
		else 	scalar `ntrans' = 0

		local cnames : colnames `bvec'
		local ceqs : coleq `bvec'

		tokenize `ceqs'
		local i 1
		local rhs 
	
		while "`1'" != "" {
			if "`1'" == "Trans" {
				local var : word `i' of `cnames'
				scalar `diff'=reldif(`lam', 0.0) 
				if `diff'>1e-10 {
					local rhs  /*
*/ "`rhs' + `bvec'[1,`i']*(`var'^`lam' -1 )/`lam' "
				}
				else {
				   local rhs " `rhs'+`bvec'[1,`i']*ln( `var' ) "
				}
			}
			local i = `i' + 1
			macro shift
		}

		if "`stat'"=="xbt" {
			gen `typlist' `varlist' = ( `ntrans' `rhs' ) `if' `in'
		}
		else {
			if "`stat'" =="yhat" {
				gen `typlist' `varlist' = (`lam'*( `ntrans' /*
					*/  `rhs' )+1)^(1/`lam') /*
					*/  `if' `in'
				label variable `varlist' "fitted values"
			}
			else {
				gen `typlist' `varlist' = `e(depvar)' - /* 
					*/ (`lam'*( `ntrans' `rhs' /*
					*/ )+1)^(1/`lam')   `if' `in'
				label variable `varlist' "residuals"
			}
	
		}
		exit
	}

	if "`e(model)'" == "theta" {
		tempname bvec lam1 lam theta1 theta
		tempvar ntrans

		matrix `bvec'=e(b)

		matrix `lam1'=`bvec'[1,"lambda:_cons"]
		scalar `lam'=`lam1'[1,1]

		matrix `theta1'=`bvec'[1,"theta:_cons"]
		scalar `theta'=`theta1'[1,1]


/* 	Get linear part using _predict */
		
		if "`e(ntrans)'" != "" {
			quietly  _predict double `ntrans', xb eq(#1) 
		}
		else 	scalar `ntrans' = 0.0

		local cnames : colnames `bvec'
		local ceqs : coleq `bvec'

		tokenize `ceqs'
		local i 1
		local rhs
	
		while "`1'" != "" {
			if "`1'" == "Trans" {
				local var : word `i' of `cnames'
				scalar `diff'=reldif(`lam', 0.0) 
				if `diff'>1e-10 {
				   local rhs  /*
*/ " `rhs' + `bvec'[1,`i']*( `var'^`lam' -1 )/`lam' "
				}
				else {
				   local rhs /*
*/  " `rhs' + `bvec'[1,`i']*ln( `var' ) "
				}
			}
			local i = `i' + 1
			macro shift
		}

		if "`stat'"=="xbt" {
			gen `typlist' `varlist' = ( `ntrans' `rhs' ) `if' `in'
			local lab "(Transformed) Linear Prediction"	
			label variable `varlist' "`lab'"
		}
		else {
			if "`stat'" =="yhat" {
				gen `typlist' `varlist' = (`theta'*( `ntrans'/*
					*/ `rhs' )+1)^(1/`theta')  `if' `in'
				label variable `varlist' "fitted values"
			}
			else {
				gen `typlist' `varlist' = `e(depvar)' - /*
					*/ (`theta'*( `ntrans' `rhs' /*
					*/ )+1)^(1/`theta')   `if' `in'
				label variable `varlist' "residuals"
			}
	
		}
		exit
	}

end
