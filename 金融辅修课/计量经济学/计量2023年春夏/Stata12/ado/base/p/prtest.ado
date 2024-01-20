*! version 2.1.2  17mar2005
program define prtest, rclass byable(recall)
	version 6, missing
	global S_1			/* will be n1	*/
	global S_2			/* will be p1	*/
	global S_3			/* will be n2	*/
	global S_4			/* will be p2	*/
	global S_6			/* will be z	*/

	/* turn "==" into "=" if needed before calling -syntax- */
	gettoken vn rest : 0, parse(" =")
	gettoken eq rest : rest, parse(" =")
	if "`eq'" == "==" {
		local 0 `vn' = `rest'
	}

	syntax varname [=/exp] [if] [in] [, /*
		*/ BY(varname) Level(cilevel) ]
	tempvar touse
	mark `touse' `if' `in'
	/* do not markout varname */

	if `"`exp'"'!="" { 
		if `"`by'"'!="" { 
			di in red `"may not combine = and by()"'
			exit 198
		}
		capture confirm number `exp'
		if _rc==0 {
			markout `touse' `varlist'
			cap assert `varlist'==1 | `varlist'==0 if `touse'
			if _rc {
				di in red `"`varlist' is not a 0/1 variable"'
				exit 450
			}
			cap assert `exp'<1 & `exp'>0 if `touse'
			if _rc {
				di in red `"`exp' is not in (0,1)"'
				exit 450
			}
			qui summ `varlist' if `touse'
			local n1=r(N)
			local p1=r(mean)
			di 

			local xname = abbrev(`"`varlist'"',12)
			local c1 = 53 - length(`"`xname'"')

			di in gr `"One-sample test of proportion"' /*
			*/ _col(`c1') in ye `"`xname'"' in gr _col(53) /*
			*/ `": Number of obs = "' /*
			*/ in ye %8.0g `n1'

			local s = sqrt(`p1'*(1-`p1')/(`n1'))
			_ttest1 `varlist' `n1' `p1' `s' `level' 

			BotLine

			ret scalar z = (`p1'-`exp')/sqrt(`exp'*(1-`exp')/`n1')

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

			ret scalar N_1 = `n1'
			ret scalar P_1 = `p1'

			/* Double saves */
			global S_1 "`return(N_1)'"
			global S_2 "`return(P_1)'"
			global S_6 "`return(z)'"

			exit
		}
		cap assert `varlist'==1 | `varlist'==0 if `touse' & `varlist'<.
		if _rc {
			di in red `"`varlist' is not a 0/1 variable"'
			exit 450
		}
		cap assert (`exp')==1 | (`exp')==0 if `touse' & (`exp')<.
		if _rc {
			di in red `"`exp' is not a 0/1 variable"'
			exit 450
		}
		unab exp : `exp', max(1)
		quietly sum `varlist' if `touse'
		local n1=r(N)
		local p1=r(mean)
		quietly sum `exp' if `touse'
		local n2=r(N)
		local p2=r(mean)
		* local abnam1 = abbrev("`varlist'",8)
		* local abnam2 = abbrev("`exp'",8)
		prtesti `n1' `p1' `n2' `p2', xname(`varlist') yname(`exp') /*
			*/ level(`level')

		ret add
		exit
	}
	confirm var `by'
	quietly tab `by' if `touse'
	if r(r)!=2 { 
		di in red `"`by' takes on "' r(r) `" values, not 2"'
		exit 450
	}
	qui summ `by' if `touse'
	local g1 = r(min)
	local g2 = r(max)
	
	quietly sum `varlist' if `by'==`g1' & `touse'
	local n1 = r(N)
	local p1 = r(mean)
	quietly sum `varlist' if `by'==`g2' & `touse'
	local n2 = r(N)
	local p2 = r(mean)

        local vlab : value label `by'
        local xname = `g1'
        local yname = `g2'
        if `"`vlab'"' != `""' {
                local xname : label `vlab' `g1'
                if `"`xname'"' == `""' {
                        local xname = `g1'
                }
                local yname : label `vlab' `g2'
                if `"`yname'"' == `""' {
                        local yname = `g2'
                }
        }
	prtesti `n1' `p1' `n2' `p2', /*
				*/ xname(`xname') yname(`yname') level(`level')

	ret add
end

program define BotLine
	di in smcl in gr "{hline 13}{c BT}{hline 64}"
end

program define _ttest1
	local name = abbrev(`"`1'"', 12)
	local n "`2'"
	local mean "`3'"
	local se "`4'"
	local level "`5'"
	local show = "`6'" 

	if `n' == 1 | `n' >= . {
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
	
	local vval = (100-(100-`level')/2)/100
	noi di in smcl in gr _col(`beg') `"`name'"' /*
	*/ in gr _col(14) "{c |}" in ye /*
	*/ _col(17) %9.0g  `mean'   /*
	*/ _col(28) %9.0g  `se'     /*
	*/ _col(58) %9.0g  `mean'-invnorm(`vval')*`se'   /*
	*/ _col(70) %9.0g  `mean'+invnorm(`vval')*`se'
end
exit
----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
------------------------------------------------------------------------------
Variable     |       Mean   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
   _cons     |  26165.257  1342.8719                     xxxxxxxxx   xxxxxxxxx 

