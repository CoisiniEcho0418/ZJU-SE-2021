*! version 2.3.0  20jan2009
program define pcorr, byable(recall) rclass
	version 7, missing
	syntax varlist(min=3 ts) [aw fw] [if] [in]
	marksample touse
	local weight "[`weight'`exp']"
	quietly reg `varlist' `weight' if `touse'
	local n = `e(N)'
	if (`n'==0 | `n' >= .) { error 2000 }
	
	di as txt "(obs=" `n'  ")"
	local NmK = e(df_r)
	tsunab vars: `varlist'
	local k: word count `vars'
	tokenize `vars'
	local km1 = `k' - 1
	
	di _n as txt "Partial and semipartial correlations of `1' with" _n
	di as txt _col(16) "Partial" _col(26) "Semipartial" _col(43) /*
	  */ "Partial" _col(53) "Semipartial" _col(67) "Significance" 
	di as txt "   Variable {c |}" _col(18) "Corr." _col(32) "Corr." /*
	  */ _col(43) "Corr.^2" _col(57) "Corr.^2" _col(74) "Value" 
	di as txt "{hline 12}{c +}{hline 65}"
	mac shift
	tempname mp_corr msp_corr
	matrix `mp_corr' = J(`km1',1,.)
	matrix `msp_corr' = J(`km1',1,.)
	local names ""
	local count = 0
	while ("`1'"!="") {
		local count = `count' + 1 
		local names "`names' `1'" 
		quietly test `1'
		if (r(F)>=.) {
			di as txt %11s abbrev("`1'",11) " {c |} (dropped)"
		}
		else {
			local s "1"
			if (_b[`1']<0) { local s "-1" }
			local p = `s'*sqrt(r(F)/(r(F)+`NmK'))
			local sp = `s'*sqrt(r(F)* ((1-e(r2))/`NmK'))
			local p2 = (r(F)/(r(F)+`NmK'))
			local sp2 = (r(F)* ((1-e(r2))/`NmK'))
			di as txt %11s abbrev("`1'",11) " {c |}" as result/* 
			*/ _col(15) %8.4f `p'   /*
			*/ _col(29) %8.4f `sp'  /*
			*/ _col(42) %8.4f `p2'  /*
			*/ _col(56) %8.4f `sp2' /*
			*/ _col(71) %8.4f tprob(`NmK',sqrt(r(F)))
			
			matrix `mp_corr'[`count',1] = `p'
			matrix `msp_corr'[`count',1] = `sp'
		}
		mac shift
	}
	matrix rownames `mp_corr' = `names'
	matrix rownames `msp_corr' = `names'
	matrix colnames `mp_corr' = "Partial Correlation"
	matrix colnames `msp_corr' = "Semipartial Correlation"
	return clear
	return scalar N = `n'
	return scalar df = `NmK'
	return matrix p_corr = `mp_corr'
	return matrix sp_corr = `msp_corr'
end
