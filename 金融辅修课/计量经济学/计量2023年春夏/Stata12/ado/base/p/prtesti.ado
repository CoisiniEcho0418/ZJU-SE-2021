*! version 2.2.4  19mar2011
program define prtesti, rclass
	version 5.0
	global S_6		/* will be z	*/
	parse "`*'", parse(" ,")
	cap confirm number `4'
	if "`4'" != "" & _rc == 0 {
		confirm integer number `1'
		confirm number `2'
		confirm integer number `3'
		confirm number `4'
		local n1 `1'
		local p1 `2'
		local n2 `3'
		local p2 `4'

		mac shift 4

		local options "Yname(string) Xname(string) Count "
		local options "`options' Level(cilevel)"
		parse "`*'"

		if "`count'"~="" {
			confirm integer number `p1'
			confirm integer number `p2'
			if `p1' <= `n1' { local p1 = `p1'/`n1' }
			if `p2' <= `n2' { local p2 = `p2'/`n2' }
		}
		if "`count'"~="" {
			if `p1' > 1 | `p1' < 0 {
				noi di in red "`p1' not less than `n1'"
				exit 198
			}
			if `p2' > 1 | `p2' < 0 {
				noi di in red "`p2' not less than `n2'"
				exit 198
			}
		}	
		else {
			if `p1' > 1 | `p1' < 0 {
				noi di in red "`p1' not in [0,1]"
				exit 198
			}
			if `p2' > 1 | `p2' < 0 {
				noi di in red "`p2' not in [0,1]"
				exit 198
			}
		}
		local n = `n1'+`n2'
		local p = (`n1'*`p1'+`n2'*`p2')/(`n1'+`n2')
		local dp = `p1'-`p2'
		if `n1'<=1 { error 2001 } 

		if `"`xname'"'=="" { local xname "x" }
		else local xname = trim(substr(trim(`"`xname'"'),1,12))
		if `"`yname'"'=="" { local yname "y" }
		else local yname = trim(substr(trim(`"`yname'"'),1,12))
		di

		local c1 = 53 - length(`"`xname'"')
		local c2 = 53 - length(`"`yname'"')

		di in gr "Two-sample test of proportions" _col(`c1') /*
		*/ in ye `"`xname'"' in gr _col(53) ": Number of obs = " /*
		*/ in ye %8.0g `n1'
		di in gr _col(`c2') in ye `"`yname'"' in gr /*
		*/ _col(53) ": Number of obs = " in ye %8.0g `n2'
		local s1 = sqrt(`p1'*(1-`p1')/(`n1'))
		local s2 = sqrt(`p2'*(1-`p2')/(`n2'))
		_ttest1 `"`xname'"' `n1' `p1' `s1' `level' showwald
		_ttest2 `"`yname'"' `n2' `p2' `s2' `level'
		DivLine

		local sp = sqrt(`p1'*(1-`p1')/`n1'+`p2'*(1-`p2')/`n2')
		local spp = sqrt(`p'*(1-`p')/`n1'+`p'*(1-`p')/`n2')

		tnew `level' diff `n' `dp' `spp' `sp'
		BotLine

		ret scalar N_1 = `n1'
		ret scalar P_1 = `p1'
		ret scalar N_2 = `n2'
		ret scalar P_2 = `p2'
		ret scalar z = (`p1'-`p2')/`spp'

		/* Double saves */
		global S_1  "`return(N_1)'"
		global S_2  "`return(P_1)'"
		global S_3  "`return(N_2)'"
		global S_4  "`return(P_2)'"
		global S_6  "`return(z)'"

		di as txt "        diff = prop(" as res `"`xname'"' as txt ///
			") - prop(" as res `"`yname'"' as txt ")" _col(67) ///
			as txt "z = " as res %8.4f return(z)

		di as txt "    Ho: diff = 0"
		di

		_ttest center2 "Ha: diff < 0" ///
			       "Ha: diff != 0" ///
			       "Ha: diff > 0" 

		local p2 = 2*(normprob(-abs(return(z))))
		if return(z) < 0 {
			local p1 = `p2'/2
			local p3 = 1 - `p1'
		}
		else {
			local p3 = `p2'/2
			local p1 = 1 - `p3'
		}

		local p1 : di %6.4f `p1'
		local p2 : di %6.4f `p2'
		local p3 : di %6.4f `p3'
		
		_ttest center2 "Pr(Z < z) = @`p1'@" ///
			       "Pr(|Z| < |z|) = @`p2'@" ///
			       "Pr(Z > z) = @`p3'@" 
 
		exit
	}
	else {
		confirm integer number `1'
		confirm number `2'
		confirm number `3'
		local n1 `1'
		local p1 `2'
		local p2 `3'

		if `p2' > 1 | `p2' < 0 {
			noi di in red "`p2' not in [0,1]"
			exit 198
		}
		mac shift 3

		local options "Yname(string) Xname(string) Count"
		local options "`options' Level(cilevel)"
		parse "`*'"
		if "`count'"~="" {
			confirm integer number `p1'
			if `p1' <= `n1' { local p1 = `p1'/`n1' }
		}
                if "`count'"~="" {
			if `p1' > 1 | `p1' < 0 {
				noi di in red "`p1' not less than `n1'"
				exit 198
			}
		}
		else {
			if `p2' > 1 | `p2' < 0 {
				noi di in red "`p2' not in [0,1]"
				exit 198
			}
			if `p1' > 1 | `p1' < 0 {
				noi di in red "`p1' not in [0,1]"
				exit 198
			}
		}


		local n = `n1'
		local dp = `p1'-`p2'
		if `n1'<=1 { error 2001 } 

		local yname = trim(substr(trim(`"`yname'"'),1,8))
		local xname "x"
		local c1 = 53 - length(`"`xname'"')
		di
		di in gr "One-sample test of proportion" /*
		*/ _col(`c1') in ye `"`xname'"' in gr _col(53) /*
		*/ ": Number of obs = " /*
		*/ in ye %8.0g `n1'

		local varlist `"`xname'"'
		local exp `p2'
		local s = sqrt(`p1'*(1-`p1')/(`n1'))
		_ttest1 `"`xname'"' `n1' `p1' `s' `level'
		BotLine

		return scalar z = (`p1'-`exp')/sqrt(`exp'*(1-`exp')/`n1')

		if `exp' < 1e-6 {
			local m0 : di %8.0g `exp'
		}
		else if `exp' > (1-1e-6) {
			local m0 0.999999
		}
		else {
			local m0 : di %8.6f `exp'
			forvalues i = 0/5 {
				local zz = substr(`"`m0'"',8-`i',8-`i')
				if `"`zz'"' == "0" {
					local m0 = ///
						substr(`"`m0'"',1,7-`i')
				} 
				else {
					continue, break
				}
			}
		}
		local m0 = trim(`"`m0'"')

		local abname=abbrev("`varlist'", 12)
                di as txt "    p = proportion(" as res `"`abname'"' ///
                        as txt ")" ///
                        _col(67) as txt "z = " as res %8.4f return(z)
                di as txt "Ho: p = " as res `"`m0'"'
		di
		_ttest center2 "Ha: p < @`m0'@" ///
                	"Ha: p != @`m0'@" ///
                	"Ha: p > @`m0'@"

		return scalar N_1 = `n1'
		return scalar P_1 = `p1'

		/* Double Saves */
		global S_1  "`return(N_1)'"
		global S_2  "`return(P_1)'"
                global S_6  "`return(z)'"

                local pp2 = 2*normprob(-abs(`return(z)'))
                if `return(z)' < 0 {
                        local pp1 = `pp2'/2
                        local pp3 = 1 - `pp1'
                }
                else {
                        local pp3 = `pp2'/2
                        local pp1 = 1 - `pp3'
                }

		local pp1 : di %6.4f `pp1'
		local pp2 : di %6.4f `pp2'
		local pp3 : di %6.4f `pp3'

		_ttest center2 "Pr(Z < z) = @`pp1'@" ///
                	"Pr(|Z| > |z|) = @`pp2'@" ///
                        "Pr(Z > z) = @`pp3'@"
		
		exit
	}
end


program define tnew
	args level name n mean se cse

	local tval = `mean'/`se'
	*local tval = abs(`tval')
	local pval = 2*(1 - normprob(abs(`tval')))

	local vval = (100 - (100-`level')/2)/100
	noi di in smcl in gr %12s abbrev("`name'",12) " {c |}" in ye /*
		*/ _col(17) %9.0g  `mean'   /*
		*/ _col(28) %9.0g  `cse'     /*
		*/ _col(58) %9.0g  `mean'-invnorm(`vval')/*
		*/ *`cse'   /*
		*/ _col(70) %9.0g  `mean'+invnorm(`vval')*`cse'
	noi di in smcl /*
		*/ in gr _col(14) "{c |}" in ye /*
		*/ in gr _col(17) "under Ho:"   /*
		*/ in ye _col(28) %9.0g  `se'     /*
		*/ _col(38) %8.2f  `tval'   /*
		*/ _col(49) %5.3f  `pval'  
end


program define DivLine
	di in smcl in gr "{hline 13}{c +}{hline 64}
end

program define BotLine
	di in smcl in gr "{hline 13}{c BT}{hline 64}
end

program define _ttest1
	local name = abbrev(`"`1'"', 12)
	local n "`2'"
	local mean "`3'"
	local se "`4'"
	local level "`5'"
	local show = "`6'" 

	if `n' == 1 | `n' == . {
		local se = .
	}
	local beg = 13 - length(`"`name'"')
	if "`show'" != "" {
		local z z
		local zp P>|z| 
	}
	local cil `=string(`level')'
	local cil `=length("`cil'")'
	*noi di 
	noi di in smcl in gr "{hline 13}{c TT}{hline 64}"
	noi di in smcl in gr "    Variable {c |}" /*
	*/ _col(22) "Mean" _col(29) /*
	*/ "Std. Err." _col(44) "`z'" _col(49) /*
	*/ "`zp'" _col(`=61-`cil'') `"[`=strsubdp("`level'")'% Conf. Interval]"'
	noi di in smcl in gr "{hline 13}{c +}{hline 64}"
	
	local tval = abs(`mean'/`se')
	local pval = 2*(1 - normprob(`tval'))

	local vval = (100-(100-`level')/2)/100
	noi di in smcl in gr _col(`beg') `"`name'"' /*
	*/ in gr _col(14) "{c |}" in ye /*
	*/ _col(17) %9.0g  `mean'   /*
	*/ _col(28) %9.0g  `se'     /*
	*/ _col(58) %9.0g  `mean'-invnorm(`vval')*`se'   /*
	*/ _col(70) %9.0g  `mean'+invnorm(`vval')*`se'
end

program define _ttest2
	local name = abbrev(`"`1'"', 12)
	local n "`2'"
	local mean "`3'"
	local se "`4'"
	if `n' == 1 | `n' == . {
		local se = .
	}
	local level "`5'"

	local vval = (100 - (100-`level')/2)/100
	noi di in smcl in gr %12s `"`name'"' " {c |}" in ye /*
 		*/ _col(17) %9.0g  `mean'   /*
		*/ _col(28) %9.0g  `se'     /*
		*/ _col(58) %9.0g  `mean'-invnorm(`vval')/*
		*/ *`se'   /*
		*/ _col(70) %9.0g  `mean'+invnorm(`vval')*`se'
end
exit
----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
-------------+----------------------------------------------------------------
   _cons     |  26165.257  1342.8719                     xxxxxxxxx   xxxxxxxxx 

