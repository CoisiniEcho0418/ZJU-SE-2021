*! version 3.0.8  21sep2004
program define integ, rclass byable(onecall) sort
	version 6.0, missing
	syntax varlist(min=2 max=2) [if] [in], [ Generate(string) /*
		*/ REPLACE BY(varlist) Trapezoid Initial(real 0) ]
	if _by() {
		if "`by'"!="" { 
			di in red "by() option and by prefix may not combined"
			exit 198
		}
		local by "`_byvars'"
	}
	if "`by'"!="" & "`generat'"=="" {
		di in red "must specify option generate() with by"
		exit 198
	}
		

	tokenize `varlist'
	local y `"`1'"'
	local x `"`2'"'
	
	if `"`generat'"'!=`""' {
		if `"`replace'"'!=`""' { capture drop `generat' }
		confirm new variable `generat'
	}  

	tempvar doit ynew integ
	
	mark `doit' `if' `in'
	markout `doit' `y' `x'
	if !_by() {
		markout `doit' `by', strok	/* backwards compatibility */
	}
	
	sort `doit' `by' `x'
	
	Mean `ynew' `y' `x' `doit' `by'
	local y `"`r(mean)'"'

	quietly count if `doit'
	local n = r(N)
	if `n'==0 { error 2000 }
		
	if `"`trapezoid'"'==`""' { /* use spline fit */
		tempvar y2
		
		spline_x `y2' `y' `x' `doit' `by'
		
		local spline /*
		*/ `"-cond(_N>2,(`x'-`x'[_n-1])^2*(`y2'+`y2'[_n-1])/12,0)"'
	}
	
	quietly by `doit' `by': gen float `integ' = `initial' /*
	*/	+ sum((`x'-`x'[_n-1])*(`y'+`y'[_n-1]`spline')/2) if `doit'


	if "`by'"=="" {
		ret scalar N_points = `n'
		ret scalar integral = `integ'[_N]
		global S_1 `n' 		/* double save in S_# and r() */
		global S_2 = `integ'[_N]
		local result : di %10.0g return(integral)
		di _n in gr `"number of points = "' in ye `"`n'"' _n(2) /*
		*/    in gr `"integral         = "' in ye trim(`"`result'"')
	} 
	if `"`generat'"'!=`""' { rename `integ' `generat' }
end

program define Mean, rclass
	args ynew y x doit /* ... */
	macro shift 4
	
	capture by `doit' `*': assert `x'!=`x'[_n-1] if _n>1 & `doit'
	if _rc==0 { /* `x' values are unique. */
		ret local mean `"`y'"'
		exit
	}
	
/* Compute mean of `y' at nonunique `x' values. */

	quietly by `doit' `*' `x': gen double `ynew' /* 
	*/	= cond(_n==_N,sum(`y')/_N,.) if `doit'
	markout `doit' `ynew'
	sort `doit' `*' `x'
	ret local mean `"`ynew'"'
end 
