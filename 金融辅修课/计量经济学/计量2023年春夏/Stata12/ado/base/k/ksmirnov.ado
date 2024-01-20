*! version 3.2.2  29oct2008
program define ksmirnov, rclass sortpreserve
	version 6, missing
	syntax varname [=/exp] [if] [in] [, /*
		*/ BY(varname) Onesamp Exact ] 	/* onesamp ignored */
	marksample touse
	markout `touse' `by', strok

	// varname string not allowed
	confirm numeric variable `varlist'
	

	if `"`exp'"' != "" { 
		tempvar eval
		qui gen double `eval' = `exp' if `touse' 
		local o_exp `"`exp'"'
		local exp `eval'
	}


	if "`by'"!="" {
		if `"`exp'"'!="" { error 198 }
		qui tab `by' if `touse'
		if r(r) != 2 {
			di in red "`by' takes on " r(r) " values, not 2"
			exit 450
		}
		tempvar M V1 V2
		sort `touse' `by'
		qui by `touse' `by': gen byte `M' = cond(_n==1,1,.) if `touse'
		sort `M' `by'
		qui gen double `V1' = `varlist' if `by'==`by'[1] & `touse'
		qui gen double `V2' = `varlist' if `by'==`by'[2] & `touse'
		local vn `V1'
		local exp `V2'

		local typ : type `by'
		if substr("`typ'",1,3)=="str" { 
			local name1 = substr(`by'[1],1,16)
			local name2 = substr(`by'[2],1,16)
		}
		else {
			local junk = `by'[1]
			local name1 : label (`by') `junk' 16
			local junk = `by'[2]
			local name2 : label (`by') `junk' 16
		}
		di _n in gr "Two-sample Kolmogorov-Smirnov test " /* 
			*/ "for equality of distribution functions" _n 
	}
	else {
		/* exp contains evaluation of expression */
		if "`exact'"!="" { error 198 } 
		capture assert (`exp')< . if `touse'
		if _rc {
			di in red "=exp evaluate to missing in " /*
			*/ "some or all observations"
			di in red "=exp should evaluate to cumulative " /*
			*/ "density evaluated at `varlist'"
			exit 450
		}
		tempvar vn 
		qui gen double `vn' = `varlist' if `touse'
		local name1 = abbrev("`varlist'", 12)
		local name2 "Cumulative"
		di _n in gr "One-sample Kolmogorov-Smirnov test " /*
			*/ "against theoretical distribution" _n  /*
			*/ _col(12) "`o_exp'" _n
	}

	tempvar G1 G2 V
	quietly {
		gen double `G1' = (`vn'< .) if `touse'
		replace `G1' = (`G1'==1)
		gen double `V' = `exp' if `touse'
		if "`by'"!="" {
			gen double `G2' = 1 if `V'< .
			replace `V' = `vn' if `V'>=.
			sort `V'
			replace `G1' = sum(`G1')
			local m = `G1'[_N]
			replace `G1' = `G1' / `m'
			replace `G2' = sum(`G2')
			local k = `G2'[_N]
			replace `G2' = `G2' / `k'
			replace `G1' = `G1' - `G2'
			by `V': replace `G1' = `G1'[_N]
		}
		else {
			sort `vn'
			replace `G1' = sum(`G1')
			local m = `G1'[_N]
			replace `G1' = `G1' / `m' - `V'
			local k = 10e6
		}
		summarize `G1', meanonly
		local Dm = r(min)
		local Dp = r(max)
		if "`by'"=="" { local Dm = `Dm' - 1/`m' }
		local D = max(-`Dm',`Dp')
		local A = `m'*`k'/(`m'+`k')
		local Pm = exp(-2*`A'*((`Dm')^2))
		local Pp = exp(-2*`A'*((`Dp')^2))
		local Z2 = `A'*((`D')^2)
		local P = exp(-2*`Z2') - exp(-8*`Z2') + exp(-18*`Z2') /*
				*/ - exp(-32*`Z2') + exp(-50*`Z2')
		local P = min(2*`P', 1)
		local Pc = `P'
		if `P'<1 {
			if ("`exact'"!="") {
				local mk = `m'+`k'
				local den = /*
				*/ lngamma(`mk'+1)-lngamma(`m'+1)-lngamma(`k'+1)
				local i 0
				replace `G1' = 1 if _n==1
				while (`i'<`mk') {
					replace `G2' = `G1'[_n-1]+`G1'[_n]
					local i = `i' + 1
					replace `G2' = 1 if _n==1 | _n==`i'+1
					replace `G2' = 0 if abs((_n-1)/`m'-(`i'-_n+1)/`k')>=`D' | _n>`i'+1
					replace `G1' = `G2'
				}
				local Pc = log(`G1'[`m'+1]) - `den'
				local Pc = 1 - exp(`Pc')
			}
			else if `P' ~= 0 {
				local Pz = invnorm(`P')+1.04/min(`m',`k') /*
					*/ +2.09/max(`m',`k')-1.35/sqrt(`A')
				local Pc = normprob(`Pz')
			}
		}
	}
	if "`exact'"=="" { local lbl "Corrected" }
	else local lbl "    Exact"
	di in gr " Smaller group       D       P-value  `lbl'"
	di in smcl in gr " {hline 46}"
	di in gr " `name1':" _col(20) in ye %8.4f `Dp' %9.3f `Pp'
	di in gr " `name2':" _col(20) in ye %8.4f `Dm' %9.3f `Pm'
	di in gr " Combined K-S:" _col(20) in ye %8.4f `D' %9.3f `P' %11.3f `Pc'
	/* double save in S_# and r() */
	ret local group1 "`name1'"
	ret local group2 "`name2'"
	ret scalar D_1 = `Dp'
	ret scalar D_2 = `Dm'
	ret scalar p_1 = `Pp'
	ret scalar p_2 = `Pm'
	ret scalar D   = `D'
	ret scalar p   = `P'
	if "`exact'"=="" { ret scalar p_cor   = `Pc' }
	else               ret scalar p_exact = `Pc' 
	global S_1 "`name1'"
	global S_2 `Dp'
	global S_3 `Pp'
	global S_4 "`name2'"
	global S_5 `Dm'
	global S_6 `Pm'
	global S_8 `D'
	global S_9 `P'
	global S_10 `Pc'

        qui count if `touse'
        local total = r(N)

        tempvar tag
        qui bys `touse' `varlist': gen byte `tag'= 1 if _n==1 & `touse'

        qui count if `tag'==1 & !missing(`v') & `touse'
        local unique = r(N)

        if `total' != `unique'{
		di
                if "`by'" == "" {
                        di as txt "Note: ties exist in dataset; " _n ///
                        _col(7) "there are " string(`unique', "%9.0g") ///
			" unique values out of " string(`total', "%9.0g") ///
			" observations."
                }
                else {
                        di as txt "Note: ties exist in combined " ///
			"dataset;" _n ///
                        _col(7) "there are " string(`unique', "%9.0g") ///
			" unique values out of " /// 
                        string(`total', "%9.0g") " observations."
                }
        }
end
