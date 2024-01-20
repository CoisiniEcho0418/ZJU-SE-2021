*! version 2.0.1  28sep2004
*  (see documentation below)
program define qreg_c, eclass
	version 6.0, missing
	syntax varlist [if] [in] [, Quantile(real 0.5) WLSiter(integer 1) /*
		*/ WVAR(string) *]

	local quant "`quantil'"
	if `wlsiter'<1 { error 198 }
	quietly {
		tempvar r s2 p wt touse
		gen long `s2' = _n
		mark `touse' [fweight=`wvar'] `if' `in'
		reg `varlist' if `touse' [fweight=`wvar']
		if e(N)==0 | e(N)>=. { 
			noisily error 2000
		}
		predict `r' if `touse', resid
		replace `touse'=0 if `r'>=.
		drop `r'
		local i 0
		while (`i'<`wlsiter') {
			capture drop `r'
			capture drop `wt'
			predict `r' if `touse', resid
			gen `wt' = cond(`r'>=0,`quant',1-`quant')
			reg `varlist' if `touse' [aw=`wt'*`wvar']
			drop `r'
			predict `r' if `touse', resid
			replace `r'=cond(`r'>=0,`quant',`quant'-1)*`r'
			local i = `i'+1
		}
		sort `r' `s2'
		drop `r' `s2'

		_qreg `varlist' if `touse' [fweight=`wvar'], /*
			*/ quant(`quant') `options'
		if (r(convcode)!=1) { error 430 } /* convergence not achived */

		predict `p' if `touse'
		tokenize "`varlist'"
		local dv "`1'"
		mac shift
		reg `p' `*' if `touse' [fweight=`wvar'], dep(`dv')
	}
end
exit

DOCUMENTATION:


	qreg_c depvar [varlist] [if exp] [in range], wvar(varname|#)
						     ----
		[ quantile(#) wlsiter(#) _qreg-options ]
                  -           ---

	Defaults:	quantile(.5)
			wlsiter(1)


Description
-----------

qreg_c provides a fast way to estimate quantile regressions when all that 
is desired is the coefficient vector.

qreg_c is intended for use in bootstrapping situations.

Note that wvar is required and assumed to be a frequency weight.  wvar=0 is
allowable in some observations.  This allows bootstrap estimation to proceed
quickly.


Also see
--------

comments following bsamplew.ado.

<end>
