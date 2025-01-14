*! version 7.3.2  16jan2007

program define nlogittree
	syntax varlist [fw] [if] [in] [, CHOice(varname numeric) noLABel ///
	 	noBRANCHes] 
	version 9
	marksample touse, strok
	qui count if `touse'
	if (r(N) == 0) error 2000

	local level : word count `varlist'
	tokenize `varlist'
        local i = `level'
        while `i' >= 1 {
		local bylist `bylist' ``i''
                local i = `i' - 1
        }
	local tabr 0
	foreach var of local bylist {
		Tabulate `var' if `touse'
		if r(r) < `tabr' {
			di as err "invalid tree structure; input bottom " ///
			 "level first"
			exit 198
		}
		local tabr = r(r)
	}
	if "`branches'" != "" {
		local VERT "  "
		local LT "  "
		local BLC "  "
		local HL3 "    "
		local TT "    "
	}
	else {
		local VERT "{c |} "
		local LT "{c LT}{c -}"
		local BLC"{c BLC}{c -}"
		local HL3 " {hline 3}"
		local TT " {hline 1}{c TT}{hline 1}"
	}
	preserve
	if "`weight'" != "" { 
		tempvar f
		gen long `f'`exp'
		local wtopt [`weight'=`f']
	}
	keep `varlist' `choice' `touse' `f'
	qui keep if `touse'

	tempvar grp`level' N`level' 
	qui egen `grp`level'' = group(`bylist')
	if "`weight'" != "" {
		qui bysort `grp`level'': egen long `N`level'' = total(`f')
	}
	else {
		qui bysort `grp`level'': gen long `N`level'' = _N 
	}
	if "`choice'" != "" {
		tempvar cho frq
		gen byte `cho' = (`choice' > 0)
		if "`weight'" != "" {
			qui by `grp`level'': gen long `frq' = sum(`cho'*`f')
		}
		else {
			qui by `grp`level'': gen long `frq' = sum(`cho')
		}
		qui by `grp`level'': replace `frq' = `frq'[_N] 
	}
	qui by `grp`level'': keep if _n == 1
	summarize `N`level'', meanonly
	local w`level' = ceil(log10(r(max)+1))+1
		qui sort `bylist' 
	tempvar order
	qui gen `order' = _n
	qui count
	local N = r(N)
	tokenize `bylist'
	forvalues i = 1/`=`level'-1' {
		local levs`i' `levs`=`i'-1'' ``i''
		tempvar N`i' grp`i'
		qui egen `grp`i'' = group(`levs`i'')
		qui bysort `grp`i'': egen long `N`i'' = total(`N`level'')
		qui by `grp`i'': replace `N`i'' = . if _n != 1
		summarize `N`i'', meanonly
		local w`i' = ceil(log10(r(max)+1))+1
		MaxLength ``i'' `label'
		local l`i' = r(mxlen)
		local fmt`i' `r(fmt)'
		local type`i' `r(type)'
	}
	MaxLength ``level'' `label'
	local l`level' = r(mxlen)
	local fmt`level' `r(fmt)'
	local type`level' `r(type)'

	local m = 0
	forvalues i = 1/`=`level'-1' {
		if "`type`i''" == "flt" { 
			qui bysort `grp`i'' (`order'): replace ``i'' = . ///
				if _n != 1
		}
		else {
			qui bysort `grp`i'' (`order'): replace ``i'' = "" ///
				if _n != 1
		}
		if `i' > 1 {
			local i1 = `i'-1
			qui bysort `grp`i'' (`order'): ///
				replace `grp`i1'' = . if _n != 1
		}
		local m = `m' + `w`i'' + `l`i'' + 5
	}
	MaxLength ``level'' `label'
	local l`level' = r(mxlen)
	local fmt`level' = r(fmt)
	local m = `m' + `w`level'' + `l`level'' + 2
	if "`choice'" != "" {
		summarize `frq', meanonly
		local sumf = r(sum)
		local wf = trunc(log10(`sumf'+1))+1
	}

	di as txt _n "tree structure specified for the nested logit model" _n

	if "`branches'"!="" & `level'>1 {
        	dis as txt " " %~`l1's "top" _c
		local m1 = trunc(`m'/2)-1
	        dis as txt _col(`m1') "-->" _c
		local m1 = `m'-`l`level'' - 3
	        dis as txt _col(`m1') %~`l`level''s "bottom" _n
	}
	local m1 = `m' 

	tokenize `bylist'
	local i 1
	forvalues i=1/`level' {
		di as txt " " %-`l`i''s abbrev("``i''", `l`i'') ///
		 %~`w`i''s " N" _c
		if `i' < `level' {
			di "    " _c
		}
	}
	if "`choice'" != "" {
		di " " %~`wf's "k" _c 
		local m = `m' + `wf' + 1
	}
		
	di as txt _n "{hline `m'}"

	qui sort `order'
	qui set obs `=`N'+1'
	forvalues i = 1/`N' {
		forvalues j = 1/`level' {
			local a = ``j''[`i']
			if "`a'"=="." | "`a'"=="" { 
				local sk = `l`j''+3+`w`j''
				dis as res %`sk's " "  _c 
				local a1 = . 
				local optj = `opt`j''
				if `j' < `level' {
					loca j1 = `j'+1
					local a1 = ``j1''[`i']
					NextOut `i' `j' `level' `N' ///
						"`grp`j''" `g`j''
					local opt`j' = `r(opt)'
				}
				if `optj' == 0 {
					if "`a1'"=="." | "`a1'"=="" {
						if (`opt`j''==0) ///
							di as txt "`VERT'" _c
					}
					else {
						if (`opt`j''==0) ///
							di as txt "`LT'" _c
						else di as txt "`BLC'" _c
					}
				}
				else di as txt "  " _c
			}
			else {
				local n = `N`j''[`i']
/*****************************************************************************/
			if "`type`j''" == "flt" { 
				local islab : label (``j'') `a' 
				if "`islab'"!="`a'" & "`label'"=="" {
				   local a abbrev("`islab'", `l`j'') 
				}
				dis as res " " `fmt`j'' `a' %`w`j''.0f `n' _c
			}
			else {
				dis as res " " `fmt`j'' "`a'" %`w`j''.0f `n' _c
			}
/*****************************************************************************/
				local g`j' = `grp`j''[`i']
				if `j' < `level' {
					NextOut `i' `j' `level' `N' ///
						"`grp`j''" `g`j''
					local opt`j' = `r(opt)'

					if (`opt`j'') di as txt "`HL3'" _c
					else di as txt "`TT'" _c
				}
			}
		}
		if ("`choice'"!="") di " " %`wf'.0f `frq'[`i']
		else di
	}	
	di as txt "{hline `m'}"
	summarize `N`level'', meanonly
	local wn = ceil(log10(r(sum)+1))+1
	local m1 = `m1' - `wn' - 6 
	di as txt _col(`m1') "total " as res %`wn'.0f r(sum) _c
	if "`choice'" != "" {
		di as res " " %`wf'.0f `sumf' _n
		di as txt "k = number of times alternative is chosen" _c
	}
	else di as txt 

	di as txt _n "N = number of observations at each level" 
end	

program NextOut, rclass
	args i j level N grpj g1

	if `j' >= `level' {
		return local opt = 1
	}

	local opt = 1
	forvalues k=`i'/`N' {
		local g2 = `grpj'[`k'+1] 
		if `g2' < . {
			local opt = (`g2'!=`g1')
			continue, break
		}
	}
	return local opt = `opt'
end 

program	MaxLength, rclass
	args var label

	local lv = min(strlen("`var'"),12)
	local ty :  type `var'
	if substr("`ty'",1,3) == "str" {
		tempvar s1
		gen `s1' = `var'
		qui compress `s1'
		local n = length("`ty'")
		local mxlen = max(min(real(substr("`ty'",4,`n'-3)),12),`lv')
		local fmt %-`mxlen's
		local type "str"
	}
	else {
		local type "flt"
		local lb :  value label `var'
		if "`lb'" != "" {
			/* a variable can have a label that is bogus */
			cap label list `lb'
			if _rc {
				local lb
			}
		}
		if "`lb'"!="" & "`label'"=="" {
			cap label list `lb'
			local k = r(k)
			tempname vals
			qui tabulate `var', matrow(`vals')
			local k = min(`k',`=rowsof(`vals')')
			local mxlen = 0
			forvalues i=1/`k' {
				local n = `vals'[`i',1]
				local vi : label `lb' `n'
				local mxlen = max(length("`vi'"),`mxlen')
			}
			local mxlen = max(min(`mxlen',12),`lv')
			local fmt %-`mxlen's
		}
		else {
			summarize `var', meanonly
			local mxlen = min(ceil(log10(r(max)))+1,12)
			tempvar tmp
			qui gen `tmp' = trunc(`var')
			if reldif(`tmp',`var') > 1.0e-5 {
				forvalues i=1/3 {
					if `mxlen'+`i' > 12 {
						continue, break
					}
					qui replace `tmp' = ///
						trunc(10^`i'*`var')/10^`i'
					if reldif(`tmp',`var') < 1.0e-5 {
						local mxlen = ///
							max(`mxlen'+`i',`lv')
						local fmt %-`mxlen'.`i'f
						continue, break
					}
					
				}
				if "`fmt'" == "" {
					local fmt %-12.7e
					local mxlen = 12
				}
			}
			else {
				local mxlen = max(`mxlen',`lv')
				local fmt %-`mxlen'.0f
			}
		}
	}
	return local mxlen = `mxlen'
	return local fmt "`fmt'"
	return local type "`type'"
end

program Tabulate, rclass
	syntax varname [if]
	
	cap tab `varlist' `if'
	if _rc == 134 {
		di as err "{p}exceeded the limits of {cmd:tablulate} when " ///
		 "tabulating the number of alternatives in variable "     ///
		 "`varlist'; you probably misspecified the variable; "  ///
		 "see help {help limits}{p_end}"
		exit 134
	}
	else if _rc {
		local rc = _rc
		di as err "{p}tabulate failed when attempting to count " ///
		 "the number of alternatives in variable `varlist'{p_end}"
		exit `rc'
	}
	return add
end

exit
