*! version 1.0.1  10jun2011
program sem_estat_eqtest, rclass
	version 12
	
	if "`e(cmd)'" != "sem" { 
		error 301
	}	

	syntax [, 		///
		TOTal 		///
		]

	local ng = `e(N_groups)'	
	if (e(k_ly) + e(k_oy) == 0) {
		di as txt "(model has no endogenous variables)"
		exit 
	}
	if (e(k_lx) + e(k_ox) == 0) {
		di as txt "(model has no exogenous variables)"
		exit 
	}
	if (`ng' == 1) & ("`total'" != "") {
		dis as err "option total only allowed with multiple groups"
		exit 198
	}
	local fmt format(%8.2f %3.0f %8.4f)	

	tempname nobs
	matrix `nobs' = e(nobs)
	
	// display tests
	dis _n as txt "Wald tests for equations"
	 
	forvalues g = 1/`ng' { 
		sem_groupheader `g', nohline
		tempname test_`g'
		mata: st_sem_estat_eqwald(`g', "`test_`g''")
		_matrix_table `test_`g'', `fmt'
	}
	
	if "`total'" != "" { 
		sem_groupheader 0, nohline
		tempname test
		mata: st_sem_estat_eqwald(0, "`test'")  
		_matrix_table `test', `fmt'
	}
	
	// return results
      	return scalar N_groups = `ng'
	return matrix nobs = `nobs'
	forvalues g = 1/`ng' { 
		local gg = cond(`ng'>1, "_`g'", "")
		return matrix test`gg' = `test_`g''
	}	
	if "`total'" != "" {
		return matrix test_total = `test'
	}
end
exit
