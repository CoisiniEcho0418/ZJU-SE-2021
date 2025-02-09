*! version 2.2.8  28sep2004
program define signrank, rclass byable(recall)
	version 6, missing
	syntax varname [=/exp] [if] [in] 
	tempname tp tn v unv z adj0
	tempvar touse diff ranks t

	quietly {
		mark `touse' `if' `in'
		gen double `diff' = `varlist'-(`exp') if `touse'
		markout `touse' `diff'

		egen double `ranks' = rank(abs(`diff')) if `touse'
		
/* We do want to OMIT the ranks corresponding to `diff'==0 in the sums.  */

		gen double `t' = sum(cond(`diff'>0,`ranks',0))
		scalar `tp' = `t'[_N]

		replace `t' = sum(cond(`diff'<0,`ranks',0))
		scalar `tn' = `t'[_N]

		replace `t' = sum(cond(`diff'~=0,`ranks'*`ranks',0))
		scalar `v' = `t'[_N]/4
		scalar `z' = (`tp'-`tn')/(2*sqrt(`v'))

		count if `touse'
		local n = r(N)
		scalar `unv' = `n'*(`n'+1)*(2*`n'+1)/24

		count if `diff' == 0 & `touse'
		local n0 = r(N)
		scalar `adj0' = -`n0'*(`n0'+1)*(2*`n0'+1)/24

		count if `diff' > 0 & `touse'
		local np = r(N)
		local nn = `n' - `np' - `n0'
	}

	di _n in gr `"Wilcoxon signed-rank test"' _n
	di in smcl in gr `"        sign {c |}      obs   sum ranks    expected"'
	di in smcl in gr "{hline 13}{c +}{hline 33}"
	ditablin positive `np' `tp' (`tp'+`tn')/2
	ditablin negative `nn' `tn' (`tp'+`tn')/2
	ditablin zero     `n0' `n0'*(`n0'+1)/2 `n0'*(`n0'+1)/2 
	di in smcl in gr "{hline 13}{c +}{hline 33}"
	ditablin all `n' `n'*(`n'+1)/2 `n'*(`n'+1)/2 

	if `unv' < 1e7 { local vfmt `"%10.2f"' }
	else             local vfmt `"%10.0g"'

	#delimit ;
	di in smcl in gr _n `"unadjusted variance"' _col(22)
	   in ye `vfmt' `unv' _n
	   in gr `"adjustment for ties"' _col(22)
	   in ye `vfmt' `v'-`unv'-`adj0' _n
	   in gr `"adjustment for zeros"' _col(22)
	   in ye `vfmt' `adj0' _n
	   in gr _col(22) "{hline 10}" _n
	   in gr `"adjusted variance"' _col(22)
	   in ye `vfmt' `v' _n(2)
	   in gr `"Ho: `varlist' = `exp'"' _n
	   in gr _col(14) `"z = "'
	   in ye %7.3f `z' _n
	   in gr _col(5) `"Prob > |z| = "'
	   in ye %8.4f 2*normprob(-abs(`z')) ;
	#delimit cr


	ret scalar sum_pos = `tp'
	ret scalar sum_neg = `tn'
	ret scalar z = `z'
	ret scalar Var_a = `v'
	ret scalar N_pos = `np'
	ret scalar N_neg = `nn'
	ret scalar N_tie = `n0'

	/* Double saves */
	global S_1 = `return(sum_pos)'
	global S_2 = `return(sum_neg)'
	global S_3 = `return(z)'
	global S_4 = `return(Var_a)'
	global S_5 = `return(N_pos)'
	global S_6 = `return(N_neg)'
	global S_7 = `return(N_tie)'
end

program define ditablin
        #delimit ;
        di in smcl in gr %12s `"`1'"' `" {c |}"' in ye
                _col(17) %7.0g `2'
                _col(26) %10.0g `3'
                _col(38) %10.0g `4' ;
end  ;
