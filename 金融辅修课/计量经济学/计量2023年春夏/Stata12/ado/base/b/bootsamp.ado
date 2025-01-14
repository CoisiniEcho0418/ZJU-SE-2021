*! version 3.0.2  03/22/93
program define bootsamp	/* argument is number to draw, assumed <= _N	*/
	version 3.1
	tempvar t t1 sort
	tempfile BOOTTMP
        quietly {
                gen long `t' = uniform()*_N + 1 if _n <= `*'
                /* t has the indices to replicate (the observations we want) */
                gen long `sort' = _n
                sort `sort'
                save "`BOOTTMP'", replace
                keep `sort' `t'
                drop if `t' == .
                sort `t'
                /* This counts the number with each value of t */
                by `t': gen long `t1' = _N
                by `t': keep if _n==_N
                drop `sort'
                rename `t' `sort'
                sort `sort'
		capture drop _merge
                merge `sort' using "`BOOTTMP'"
                drop if `t1'==.  /* drop the cases that dont show up */
                expand =`t1', replace
                drop _merge
        }
end
