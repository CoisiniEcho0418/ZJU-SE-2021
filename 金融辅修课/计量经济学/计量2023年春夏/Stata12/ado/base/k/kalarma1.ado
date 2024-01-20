*! version 6.5.1  06jun2011
program define kalarma1
	version 8
	args F v1 Q Ap H XI R w colon bARMA sigma2
					/* all but bARMA and sigma2 are just 
					   names for matrices, See note at 
					   bottom and Hamilton for meanings */
	if "`colon'" != ":" {
		di in red "kalama1 syntax is F v1 Ap x H w : beta_arma sigma
		exit 198
	}

	/* AR_#terms */			/* names used by convention */
	/* MA_#terms */			/* for the eqns of the B matrix */
	local coleqs : coleq `bARMA'		/* Fetch Xb part of B */
	gettoken xeqnam : coleqs
	if ! ("`xeqnam'" == "$Tdepvar" | "`xeqnam'" == "eq1") {
		local hasX = 0
		mat `Ap' = ( 0 )
		mat colnames `Ap' = _cons
	}
	else { 
		local hasX = 1 
		mat `Ap' = `bARMA'[1, "`xeqnam':"]
	}
 					/* Build transition matrices */
	tempname bAR bMA F0 H0
 	foreach s in $Tseasons {
					/* Handle AR# and MA# parts of B */
		cap mat `bAR' = `bARMA'[1, "AR`s'_terms:"]
		if _rc == 0 {
			MatMultARMA `F0' `bAR' 1 `s' -
		}
		cap mat `bMA' = `bARMA'[1, "MA`s'_terms:"]
		if _rc == 0 {
			MatMultARMA `H0' `bMA' 1 `s' +
		}
	}
	capture di `F0'[1,1] 
	if ! _rc {
		local r = colsof(`F0')
		local has_ar = 1
	}
	else	local r = 1
	capture di `H0'[1,1]
	if ! _rc { 
		local r = max(`r', colsof(`H0')+1)
		local has_ma = 1
	}

	mat `F' = J(1,`r', 0)
	if 0`has_ar' { 
		mat `F'[1,1] = `F0' 
	}

	mat `H' = J(`r', 1, 0)
	mat `H'[1,1] = 1
	if 0`has_ma' { 
		mat `H'[2,1] = `H0'' 
	}

	if `r' > 1 { 
		mat `F' = `F' \ I(`r'-1), J(`r'-1, 1, 0) 
	}

					/* Initial state vector */
	mat `XI' = J(`r', 1, 0)

					/* Expected state 
					   distubances v_t+1 ?? */
	mat `v1' = J(`r', 1, 0)

					/* Covariance matrix of state
					   disturbances */
	mat `Q' = J(`r', `r', 0)
	mat `Q'[1,1] = `sigma2'

					/* Observation distubance vector */
	mat `w' = J(1, 1, 0)

					/* Observation disturbance
					   covariance matrix */
	mat `R' = J(1, 1, 0)

end

program define LagsOfB
	args lagsmac maxlagmac colon b

	capture di `b'[1,1]
	if _rc {					/* no matrix */
		c_local `maxlagmac' 0
		c_local `lagsmac'
		exit
	}

	local names : colnames `b'
	local names : subinstr local names "L." "L1.", all

	gettoken tname : names
	local lead_char = substr("`tname'", 1, 1)	/* allow L or c */
	gettoken unused tname : tname, parse(.)

	if "`tname'" != "" {
		local names : subinstr local names "`tname'" "", all
	}
	local names : subinstr local names "`lead_char'" "", all

	c_local `maxlagmac' : word `:word count `names'' of `names'
	c_local `lagsmac' `names'
end

/*
	Return result of seaonally multiplying two AR (or MA) parameter
	vectors.

	                same as L1.n12 L2.n24 with season = 12
			        |
			+-------+-------+
	                |               |
	(L1.n1 L2.n2) * (L12.n12 L24.n24) = L1.n1 L2.n2 L12.n12 L13.n1*n12
					    L14.n1*n24  L24.n24 L25.n1*n24
					    L26.n2*n24
*/

program define MatMultARMA
	args 	   a		/* 1st source and target matrix (may not exist)
		*/ b		/* 2nd source matrix (may not exist)
		*/ delta_a	/* seasonal delta for matrix a
		*/ delta_b	/* seasonal delta for matrix b 
		*/ sign		/* sign for multiplied terms, only - reqd */

	tempname a0

	if "`sign'" == "" { 
		local sign + 
	}

	LagsOfB lags_a maxlag_a : `a'
	LagsOfB lags_b maxlag_b : `b'

	if ! (`maxlag_a' | `maxlag_b') { 
		exit					/* nothing to do */
	}

	if `maxlag_a' {
		mat `a0' = `a'
	}

	mat `a' = J(1, `maxlag_a'*`delta_a' + `maxlag_b'*`delta_b', 0)

					/* add all a and b coefs directly into 
					 * new matrix */
	local c 1
	foreach l of local lags_a {
		mat `a'[1,`l'*`delta_a'] = `a0'[1, `c++']
	}

	local c 1
	foreach l of local lags_b {
		mat `a'[1,`l'*`delta_b'] = `a'[1,`l'*`delta_b'] + `b'[1, `c++']
	}

					/* add all multiplicative coefs into
					 * new matrix 			*/

	local c_a 1
	foreach l_a of local lags_a {
		local c_b 1
		foreach l_b of local lags_b {
			local delta = `l_a'*`delta_a' + `l_b'*`delta_b'
			mat `a'[1,`delta'] = `a'[1,`delta'] `sign'	/*
			    */ `a0'[1,`c_a'] * `b'[1,`c_b++']

		}
		local ++c_a
	}

end

exit

	local k_a 0`rowsof(`a')
	local k_b 0`rowsof(`b')

	if `k_a' { 
		mat `a0' = `a' 
		mat `t' = `a'[1,`k_a']
		local name : rownames `t'
		local a_l = `adelta' * `substr(
	}

Uses the Notation from: 
Hamilton, Time Series Analysis, 1994, Princeton University Press, Ch. 13.

Here are the basic Kalman filter relations:

	XI_(t+1) = F*XI + v_(t+1)

	y = A'*x + H'*XI + w


	E(v_t*v_tt) =  Q for t = tt, 
	               0 otherwise

	E(w_t*w_tt) =  R for t = tt, 
	               0 otherwise


Assumes some global macros have been set:
	Tseason -- a list of all the multiplicative delta's by equation
	Tdepvar -- the dependent variable for the model

Assumes the AR and MA equations have been stripped
		"L#.name L#.name ..." 
	where name is constant for the equation. #'s assumed to be in 
	ascending order.

Note:
        The transition matrix F will be dimensioned by the largest AR or MA
        lag.  This could cause problems with matrix size if the problem is
        sparse and has just a few very long seasonal lags (say a 365 for
        annual/daily).  


Usage:  
	kalarma1 F v1 Q Ap H XI R w : bARMA sigma2

	where all items to the left of the : are names used to receive
		the matrices built by kalarma1

