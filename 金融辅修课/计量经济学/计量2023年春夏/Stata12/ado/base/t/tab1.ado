*! version 2.2.4  29sep2004
program define tab1, byable(recall)
	version 6, missing
	syntax varlist [if] [in] [fweight] [, *]
	tokenize `varlist'
	local stop : word count `varlist'
	local i 1
	tempvar touse
	mark `touse' `if' `in' [`weight'`exp']

	local weight "[`weight'`exp']"
	capture {	
		while `i' <= `stop' {
			noisily di _n `"-> tabulation of ``i'' `if' `in'"'
			cap noisily tab ``i'' if `touse' `weight' , `options'
			if _rc!=0 & _rc!=1001 { exit _rc } 
			local i = `i' + 1 
		}
	}
	error _rc 
end
