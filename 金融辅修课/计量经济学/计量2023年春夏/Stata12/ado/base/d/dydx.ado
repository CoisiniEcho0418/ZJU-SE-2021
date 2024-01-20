*! version 2.1.1  17sep2004
program define dydx, byable(onecall) sort
	version 6, missing
	syntax varlist(min=2 max=2) [if] [in], Generate(string) /*
		*/ [ REPLACE BY(varlist) ]
	if _by() {
		if "`by'" != "" { 
			di in red /*
			*/ "by() option and by prefix may not be combined"
			exit 198
		}
		local by "`_byvars'"
	}

	tokenize `varlist'
	local y `"`1'"'
	local x `"`2'"'
	
	if `"`replace'"'!=`""' { capture drop `generat' }
	confirm new variable `generat'

	tempvar doit ynew y2 dy
	
	mark `doit' `if' `in'
	markout `doit' `y' `x'
	if !_by() {		/* by() option marked out, by prefix not */
		markout `doit' `by', strok
	}
	
	quietly count if `doit'
	local n = r(N)
	if `n'==0 { error 2000 }
	if `n'==1 { error 2001 }
	
	sort `doit' `by' `x'
	
	Mean `ynew' `y' `x' `doit' `by'
	local y `"`r(y)'"'

	spline_x `y2' `y' `x' `doit' `by'
		
	quietly {
		#delimit ;
		by `doit' `by': gen float `dy' = 
			cond(_n==1,
			(`y'[2]-`y'[1])/(`x'[2]-`x'[1])
			- cond(_N>2,(`x'[2]-`x'[1])*(2*`y2'[1]+`y2'[2])/6,0),
			(`y'-`y'[_n-1])/(`x'-`x'[_n-1])
			+ cond(_N>2,(`x'-`x'[_n-1])*(2*`y2'+`y2'[_n-1])/6,0))
			if `doit' ;
		#delimit cr
	}

	rename `dy' `generat'
end

program define Mean, rclass
	args ynew y x doit
	macro shift 4
	
	capture by `doit' `*': assert `x'!=`x'[_n-1] if _n>1 & `doit'
	if _rc==0 { /* `x' values are unique. */
		ret local y `"`y'"'
		exit
	}
	
/* Compute mean of `y' at nonunique `x' values. */

	quietly by `doit' `*' `x': gen double `ynew' /* 
	*/	= cond(_n==_N,sum(`y')/_N,.) if `doit'
	markout `doit' `ynew'
	sort `doit' `*' `x'
	ret local y `"`ynew'"'
end 
