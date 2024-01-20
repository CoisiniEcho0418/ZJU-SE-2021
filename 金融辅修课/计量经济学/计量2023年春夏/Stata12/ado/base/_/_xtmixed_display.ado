*! version 1.1.4  22jun2011
program _xtmixed_display
	version 11.1

	if ("`e(cmd)'"=="mi estimate") {
		local sfx _mi
	}
	if ("`e(cmd`sfx')'"!="xtmixed"|"`e(b`sfx')'"==""|"`e(V`sfx')'"=="") {
		error 301
	}

	syntax [, Level(cilevel) VARiance noLRtest ///
		  noGRoup noHEADer noFETable noRETable ESTMetric grouponly ///
		  *]

	_get_diopts diopts, `options'
	ParseForCformat `"`diopts'"'

	// Leaves cformat() in local macro cf 
	
	local k = ("`fetable'"!="") + ("`retable'"!="") + ("`variance'"!="")
	if `k' {
		if "`estmetric'" != "" {
di as err "{p 0 4 4}option estmetric not allowed with options nofetable, noretable, and variance{p_end}"
			exit 198
		}
	}
	if "`header'" == "" {
		DiHeader, `group' `grouponly'
		if "`grouponly'" != "" {
			exit
		}
	}
	if "`estmetric'" != "" {
		di
		_coef_table, level(`level') `diopts'
		exit
	}
	if "`fetable'" == "" & e(k_f) > 0 {
		DiEstTable, level(`level') `diopts'
	}
	if "`retable'" == "" {
		DiVarComp, level(`level') `variance' `lrtest' cformat(`cf')
		local note `r(note)'
	}
	if !`e(converged)' {
		if "`note'" == "" {
			di
		}
		if "`e(emonly)'" != "" {
di as txt "{p 0 6 4}Note: EM algorithm failed to converge{p_end}"
		}
		else {
di as txt "{p 0 9 4}Warning: " ///
"convergence not achieved; estimates are based on iterated EM{p_end}" 
		}
	}
end

program DiHeader
	syntax [, noGRoup grouponly]
	if "`grouponly'" != "" {
		if "`e(ivars)'" == "" {
			di as err "{p 0 4 2}model is linear regression; "
			di as err "no group information available{p_end}"
			exit 459
		}
		DiGroupTable, table
		exit
	}
	di
	local crtype = upper(substr(`"`e(crittype)'"',1,1)) + /*
                */ substr(`"`e(crittype)'"',2,.)
	
	di as txt "`e(title)'" _c
	di _col(49) as txt "Number of obs" _col(68) "=" _col(70) as res ///
		%9.0g e(N)

	if "`group'" == "" {
 		DiGroupTable
		di
	}
        di _col(49) as txt "`e(chi2type)' chi2(" as res e(df_m) as txt ")" ///
                _col(68) "=" _col(70) as res %9.2f e(chi2)
	di as txt "`crtype'" " = " as res %10.0g e(ll) /*
                */ _col(49) as txt "Prob > chi2" _col(68) "=" _col(73) /*
                */ as res %6.4f chiprob(e(df_m), e(chi2))
end

program DiGroupTable
	syntax [, table]
	local ivars `e(ivars)'
	local levels : list uniq ivars
	tempname Ng min avg max
	if ("`e(cmd)'"=="mi estimate") {
		local sfx _mi
	}
	mat `Ng' = e(N_g`sfx')
	mat `min' = e(g_min`sfx')
	mat `avg' = e(g_avg`sfx')
	mat `max' = e(g_max`sfx')
	local w : word count `levels'
	if `w' == 0 {
		exit
	}
	if `w' == 1 & "`table'" == "" {
		di as txt "Group variable: " as res abbrev("`levels'",14) ///
		     _col(49) as txt "Number of groups" _col(68) "=" ///
		     _col(70) as res %9.0g `Ng'[1,1] _n
		di as txt _col(49) "Obs per group: min" _col(68) "=" ///
		     _col(70) as res %9.0g `min'[1,1]
		di as txt _col(64) "avg" _col(68) "=" ///
		     _col(70) as res %9.1f `avg'[1,1]
		di as txt _col(64) "max" _col(68) "=" ///
		     _col(70) as res %9.0g `max'[1,1] _n
	}
	//         1         2         3         4         5         6
	//123456789012345678901234567890123456789012345678901234567890
	//                    No. of       Observations per Group
	// Group Variable |   Groups    Minimum    Average    Maximum
	//        level1  | ########  #########  #########  #########
	else {
		di
		di as txt "{hline 16}{c TT}{hline 42}
		di as txt _col(17) "{c |}" _col(21) "No. of" ///
	          _col(34) "Observations per Group"
		di as txt _col(2) "Group Variable" _col(17) "{c |}" ///
		  _col(21) "Groups" _col(31) "Minimum" ///
		  _col(42) "Average" _col(53) "Maximum" 
		di as txt "{hline 16}{c +}{hline 42}"
		local i 1
		foreach k of local levels {
			local lev = abbrev("`k'",12)
			local p = 16 - length("`lev'")
			di as res _col(`p') "`lev'" /// 
			  as txt _col(17) "{c |}" ///
			  as res _col(19) %8.0g `Ng'[1,`i'] ///
                          _col(29) %9.0g `min'[1,`i'] ///
                          _col(40) %9.1f `avg'[1,`i'] ///
                          _col(51) %9.0g `max'[1,`i'] 
			local ++i	
		}
		di as txt "{hline 16}{c BT}{hline 42}" 
	}
end

program DiEstTable
	syntax [, level(cilevel) *]

	di
	_coef_table, first level(`level') `options'
end

program DiLRTest, rclass

	// We have already established that e(chi2_c) exists
	if ((e(chi2_c) > 0.005) & (e(chi2_c)<1e5)) | (e(chi2_c)==0) {
  		local fmt "%8.2f"
        }
        else    local fmt "%8.2e"

	local allempty 1
	foreach d in `e(redim)' {
		if `d' {
			local allempty 0
		}
	}

	di as txt "LR test vs. linear regression:" _c
	if `e(df_c)' == 1 & `e(k_rs)' == 2 & !`allempty' {	// chibar2(01)
		di as txt _col(32) "{help j_chibar##|_new:chibar2(01) =}" ///
                   _col(46) as res `fmt' e(chi2_c) ///
		   _col(55) as txt "Prob >= chibar2 = " ///
		   _col(73) as res %6.4f e(p_c)
	}		
	else {
		local k = length("`e(df_c)'")
		di as txt _col(`=39-`k'') "chi2(" as res e(df_c) ///
		   as txt ") =" _col(48) as res `fmt' e(chi2_c) ///
		   _col(59) as txt "Prob > chi2 =" ///
		   _col(73) as res %6.4f e(p_c)
		if `e(k_rs)' > 1 {
			return local conserve conserve
		}
		if `allempty' {
			return local conserve
			return local undetermined undetermined
		}
	}
end

program DiVarComp, rclass
	syntax [, level(cilevel) VARiance noLRtest cformat(string)]

	if ("`e(cmd)'"=="mi estimate") {
		local bmatrix e(b_mi)
	}
	else {
		local bmatrix e(b)
	}
	local depvar `e(depvar)'
	if strpos("`depvar'",".") {
		gettoken ts rest : depvar, parse(".")
		gettoken dot depvar : rest, parse(".")
	}
	
	local dimx `e(k_f)'

	// display header 

	di
	di as txt "{hline 29}{c TT}{hline 48}
	if "`e(vcetype)'" == "Bootstrap" || ///
	   "`e(vcetype)'" == "Bstrap *" {
		local obs "Observed"
		local citype "Normal-based"
	}
	if "`e(mi)'"=="" &		       ///
	   (`"`e(vcetype)'"' == "Bootstrap" || ///
	   `"`e(vcetype)'"' == "Bstrap *"  ||  ///
	   `"`e(vcetype)'"' == "Jackknife" ||  ///
	   `"`e(vcetype)'"' == "Jknife *"  ||  ///
	   `"`e(vcetype)'"' == "Robust") {
		local vcetype `e(vcetype)'
		if `"`e(mse)'"' != "" {
			capture which `e(vce)'_`e(mse)'.sthlp
			local mycrc = c(rc)
			if `mycrc' {
				capture which `e(vce)'_`e(mse)'.hlp
				local mycrc = c(rc)
			}
			if !`mycrc' {
				local vcetype ///
				"{help `e(vce)'_`e(mse)'##|_new:`vcetype'}"
                        }
		}
		local c1 = cond(`"`vcetype'"' == "Robust", 46, 45)
		di as txt _col(30) "{c |}" _col(34) `"`obs'"' ///
			  _col(`c1') `"`vcetype'"' ///
			  _col(63) `"`citype'"'
	}
	local k = length("`level'")
	di as txt _col(3) "Random-effects Parameters" _col(30) "{c |}" ///
		_col(34) "Estimate" _col(45) "Std. Err." _col(`=61-`k'') ///
		`"[`=strsubdp("`level'")'% Conf. Interval]"'
	di as txt "{hline 29}{c +}{hline 48}

	local zvars `e(revars)'
	local dimz `e(redim)'

	// loop over levels

	local foot = 1
	local pos `dimx'
	local levs : word count `e(ivars)'
	forvalues k = 1/`levs' {
		local lev : word `k' of `e(ivars)'
		local vartype : word `k' of `e(vartypes)'

		GetNames "`vartype'" "`zvars'" "`dimz'" `foot'
		local zvars `s(zvars)'     // collapsed lists
		local dimz `s(dimz)'
		local names `"`s(names)'"'
		if `"`s(footnote)'"' != "" {
			local footnotes `"`footnotes' `s(footnote)'"'
			local ++foot
		}
		if `"`names'"' != `""()""' {
			di as res abbrev("`lev'",12) as txt ": `vartype'" ///
				_col(30) "{c |}"

			local nbeta : word count `names'
			DiParms `pos' `nbeta' `"`names'"' "`level'" 	///
					"`variance'" "`bmatrix'" "`cformat'"
			local pos = `pos' + `nbeta'
		}
		else {		// empty
			di as res abbrev("`lev'",12) as txt ":" ///
				_col(22) "(empty)" _col(30) "{c |}"
		}
		di as txt "{hline 29}{c +}{hline 48}
	}

	// Residual Variance 
	
	DiResidual, `variance' level(`level') cformat(`cformat')

	// Footnotes
	if "`e(chi2_c)'" != "" & "`lrtest'" == "" {
		DiLRTest
		local conserve `r(conserve)'
		local undetermined `r(undetermined)'
	}
	
	forvalues k = 1/`=`foot'-1' {
		local note: word `k' of `footnotes'
		local indent = 3 + length("`k'")
		di as txt `"{p 0 `indent' 4} `note'{p_end}"'
	}
	if "`conserve'" != "" {
		di as txt _n "{p 0 6 4}Note: {help j_xtmixedlr##|_new:LR test is conservative} and provided only for reference.{p_end}"
		return local note note
	}
	if "`undetermined'" != "" {
		di as txt _n "{p 0 6 2}Note: The reported degrees of freedom "
		di as txt "assumes the null hypothesis is not on the "
		di as txt "boundary of the parameter space.  If this is not "
		di as txt "true, then the reported test is "
		di as txt "{help j_xtmixedlr##|_new:conservative}.{p_end}"
	}
	if "`e(pw_warn)'" != "" {
		di as txt _n "{p 0 9 2}Warning: Sampling weights were "
		di as txt "specified only at the first level "
		di as txt "in a multilevel model. If these weights are "
		di as txt "indicative of overall and not conditional "
		di as txt "inclusion probabilities, then "
		di as txt "{help xtmixed##sampling:results may be biased}."
		di as txt "{p_end}"
	}
end

program DiResidual
	syntax , level(cilevel) cformat(string) [variance]

	DiResidualHeader

	DiRes`=proper("`e(rstructure)'")', `variance' level(`level') ///
					   cformat(`cformat')

	di as txt "{hline 29}{c BT}{hline 48}
end

program DiResidualHeader
	if `e(nrgroups)' > 1 {
		local comma ,
	}
	if "`e(rstructure)'" != "independent" | `e(nrgroups)' > 1 {
		di as txt "Residual: `e(rstructlab)'`comma'" _col(30) "{c |}" 
	}
	if `e(nrgroups)' > 1 {
		di as txt "    by " as res abbrev("`e(rbyvar)'", 21) ///
			as txt _col(30) "{c |}"
	}
end

program DiResIndependent
	syntax , level(cilevel) cformat(string) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	if `e(nrgroups)' == 1 {
		DiLogRatioE "" `type' "`type'(Residual)", level(`level') ///
			cformat(`cformat')
	}
	else {
		forval i = 1/`e(nrgroups)' {
			local w : word `i' of `e(rglabels)'
			local w = abbrev(`"`w'"', cond("`type'"=="sd", 21, 20))
			local label `"`w': `type'(e)"'
			local eq = cond(`i'==1, "", "r_lns`i'ose")
			DiLogRatioE "`eq'" `type' `"`label'"',  ///
				 level(`level') cformat(`cformat')
		}
	}
end

program DiResAr
	syntax , level(cilevel) cformat(string) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxl = max(length("phi`e(ar_p)'"), length("`type'(e)"))
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		if `e(ar_p)' == 1 {
			qui _diparm r_atr`j', tanh level(`level') notab
			DiVarCompEst "rho" "`cformat'"
		}
		else {
			forval i = 1 / `e(ar_p)' {
				qui _diparm r_phi`j'_`i', level(`level') notab
				DiVarCompEst "phi`i'" "`cformat'"
			}
		}
		local eq = cond(`j'==1, "", "r_lns`j'ose")
		DiLogRatioE "`eq'" `type' "`type'(e)", level(`level') ///
				cformat(`cformat')
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiResMa
	syntax , level(cilevel) cformat(string) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxl = max(length("theta`e(ma_q)'"), length("`type'(e)"))
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		if `e(ma_q)' == 1 {
			qui _diparm r_att`j', tanh level(`level') notab
			DiVarCompEst "theta1" "`cformat'"
		}
		else {
			forval i = 1 / `e(ma_q)' {
				qui _diparm r_theta`j'_`i', level(`level') notab
				DiVarCompEst "theta`i'" "`cformat'"
			}
		}
		local eq = cond(`j'==1, "", "r_lns`j'ose")
		DiLogRatioE "`eq'" `type' "`type'(e)", level(`level') ///
				cformat(`cformat')
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiResBanded
	syntax, level(cilevel) cformat(string) [variance]

	DiResUnstructured, level(`level') `variance' banded cformat(`cformat')
end

program DiResUnstructured
	syntax , level(cilevel) cformat(string) [variance banded]
	local type = cond("`variance'" == "", "sd", "var")
	local ctype = cond("`variance'" == "", "corr", "cov")
	if "`banded'" != "" {
		local order `e(res_order)'
	}
	else {
		local order 0
	}
	
	tempname tmap
	mat `tmap' = e(tmap)
	local nt = colsof(`tmap')
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxT  : di `tmap'[1,`nt']
		local maxT1 : di `tmap'[1,`=`nt'-1']
		local maxl = length("`ctype'(e`maxT1',e`maxT')")
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		forval i = 1/`nt' {
			local elab : di "e"`tmap'[1,`i']
			local eq r_lns`j'_`i'ose
			if (`i'==1) & (`j'==1) {
				local eq 
			}
			DiLogRatioE "`eq'" `type' "`type'(`elab')", ///
				level(`level') cformat(`cformat')
		}
		forval i = 1/`nt' {
			forval k = `=`i'+1'/`nt' {
				if (`k' > `i'+`order') & "`banded'"!="" {
					continue, break
				}
				local e1 : di "e"`tmap'[1,`i']
				local e2 : di "e"`tmap'[1,`k']
				if "`ctype'" == "corr" {
					qui _diparm r_atr`j'_`i'_`k', /// 
					       tanh level(`level') notab
				}
				else {
					qui DiparmCovarianceUn `j' `i' ///
						`k' , level(`level') 
				}
				DiVarCompEst "`ctype'(`e1',`e2')" ///
						"`cformat'"
			}
		}
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiResExchangeable
	syntax , cformat(string) level(cilevel) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	local ctype = cond("`variance'" == "", "corr", "cov")
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxl = max(length("`ctype'(e)"), length("`type'(e)"))
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		local eq = cond(`j'==1, "", "r_lns`j'ose")
		DiLogRatioE "`eq'" `type' "`type'(e)", level(`level') ///
			cformat(`cformat')
		if "`ctype'" == "corr" {
			qui _diparm r_atr`j', tanh level(`level') notab
		}
		else {
			DiparmCovarianceEx r_atr `j' , level(`level')
		}
		DiVarCompEst "`ctype'(e)" "`cformat'"
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiResToeplitz
	syntax , cformat(string) level(cilevel) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	local ctype = cond("`variance'" == "", "corr", "cov")
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxl = max(length("`ctype'(e)"), length("`type'(e)"))
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		local eq = cond(`j'==1, "", "r_lns`j'ose")
		forval k = 1 / `e(res_order)' {
			if "`ctype'" == "corr" {
				qui _diparm r_atr`j'_`k', /// 
				    tanh level(`level') notab
			}
			else {
				DiparmCovarianceToep r_atr `j' `k' /// 
				, level(`level') 
			}
			if "`ctype'" == "corr" {
				DiVarCompEst "rho`k'" "`cformat'"
			}
			else {
				DiVarCompEst "cov`k'" "`cformat'"
			}
		}
		DiLogRatioE "`eq'" `type' "`type'(e)", level(`level')  ///
			cformat(`cformat')
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiResExponential
	syntax , cformat(string) level(cilevel) [variance]
	local type = cond("`variance'" == "", "sd", "var")
	local ctype = cond("`variance'" == "", "corr", "cov")
	local needglab = `e(nrgroups)' > 1
	if `needglab' {
		local maxl = max(length("`ctype'(e)"), length("`type'(e)"))
	}
	forval j = 1 / `e(nrgroups)' {
		if `needglab' {
			local lab : word `j' of `e(rglabels)'
			local lab = abbrev("`lab'", `=26-`maxl'')
			local pos = 27 - length("`lab'") - `maxl'
			di as txt _col(`pos') "`lab':" _c
		}
		local eq = cond(`j'==1, "", "r_lns`j'ose")
		qui _diparm r_logitr`j', invlogit level(`level') notab
		DiVarCompEst "rho" "`cformat'"
		DiLogRatioE "`eq'" `type' "`type'(e)", level(`level') ///
			cformat(`cformat')
		if `j' < `e(nrgroups)' {
			di as txt _col(30) "{c |}"
		}
	}
end

program DiparmCovarianceUn
	args gr i j  
	syntax anything, level(cilevel) 
	if (`gr'==1) & (`i'==1) {
		local fun exp(2*@2+@3)
		qui _diparm r_atr1_1_`j' lnsig_e r_lns1_`j'ose,  ///
			level(`level') notab 			 ///
		        function(tanh(@1)*`fun')                 ///
		        deriv((1-tanh(@1)^2)*`fun'               ///
			      2*tanh(@1)*`fun'                   ///
			      tanh(@1)*`fun')
	}
	else {
		local fun exp(2*@2+@3+@4)
		qui _diparm r_atr`gr'_`i'_`j' lnsig_e 		 ///
		            r_lns`gr'_`i'ose r_lns`gr'_`j'ose,   /// 
			    level(`level') notab		 ///
			    function(tanh(@1)*`fun') 	  	 ///
			    deriv((1-tanh(@1)^2)*`fun' 	         ///
				  2*tanh(@1)*`fun'         	 ///
				  tanh(@1)*`fun'		 ///
				  tanh(@1)*`fun')
	}
end

program DiparmCovarianceToep
	args stub j k
	syntax anything, level(cilevel)
	if (`j'==1) {
		qui _diparm `stub'1_`k' lnsig_e, level(`level') notab ///
		        function(tanh(@1)*exp(2*@2))                  ///
		        deriv((1-tanh(@1)^2)*exp(2*@2)                ///
			      2*tanh(@1)*exp(2*@2))
	}
	else {
		local fun exp(2*(@2+@3))
		qui _diparm `stub'`j'_`k' r_lns`j'ose lnsig_e,    /// 
			   level(`level') 			  ///
			   notab function(tanh(@1)*`fun') 	  ///
			         deriv((1-tanh(@1)^2)*`fun' 	  ///
				       (2*tanh(@1)*`fun')         ///
				       (2*tanh(@1)*`fun'))
	}
end

program DiparmCovarianceEx
	args stub j
	syntax anything, level(cilevel)
	if (`j'==1) {
		qui _diparm `stub'1 lnsig_e, level(`level') notab ///
		        function(tanh(@1)*exp(2*@2))              ///
		        deriv((1-tanh(@1)^2)*exp(2*@2)            ///
			      2*tanh(@1)*exp(2*@2))
	}
	else {
		local fun exp(2*(@2+@3))
		qui _diparm `stub'`j' r_lns`j'ose lnsig_e, level(`level') ///
			   notab function(tanh(@1)*`fun') 	  ///
			         deriv((1-tanh(@1)^2)*`fun' 	  ///
				       (2*tanh(@1)*`fun')         ///
				       (2*tanh(@1)*`fun'))
	}
end

program DiLogRatioE
	args eq type label cformat
	syntax anything, level(cilevel) cformat(string)
	local c = cond("`type'"=="sd", 1, 2)
	if "`eq'" == "" {
		qui _diparm lnsig_e, function(exp(`c'*@)) /// 
				     deriv(`c'*exp(`c'*@)) notab level(`level') 
	}
	else {
		qui _diparm lnsig_e `eq', ///
					 function(exp(`c'*@1+`c'*@2)) ///
				         deriv(`c'*exp(`c'*@1+`c'*@2) ///
				         `c'*exp(`c'*@1+`c'*@2))      ///
					 notab level(`level') ci(log)
	}
	DiVarCompEst `"`label'"' "`cformat'"
end

program DiVarCompEst
	// to be executed immediately after qui _diparm, notab
	args label cf
	local k = length("`label'")
	local p = 29 - `k'
	local rest : display `cf' r(est)
	local rse  : display `cf' r(se)
	local lrest = length("`rest'")
	local lrse  = length("`rse'")
	if ("`r(lb)'"==".b" | "`r(ub)'"==".b") {
		di as txt _col(`p') "`label'" _col(30) "{c |}" ///
			as res _col(`=33+9-`lrest'') `cf' r(est) ///
			as res _col(`=44+9-`lrse'')  `cf' r(se)
		exit 
	}
	local rcil : display `cf' cond(missing(r(se)),.,r(lb))
	local rciu : display `cf' cond(missing(r(se)),.,r(ub))
	local lrcil = length("`rcil'")
	local lrciu = length("`rciu'")
	di as txt _col(`p') "`label'" _col(30) "{c |}" ///
   		as res _col(`=33+9-`lrest'') `cf' r(est) ///
   		as res _col(`=44+9-`lrse'')  `cf' r(se)  ///
   		as res _col(`=58+9-`lrcil'') `cf' /// 
		cond(missing(r(se)),.,r(lb))  ///
   		as res _col(`=70+9-`lrciu'') `cf' cond(missing(r(se)),.,r(ub))
end

program DiParms
	args pos nb names cilev var bmatrix cformat

	local stripes : coleq `bmatrix', quoted
	forvalues k = 1/`nb' {
		local label : word `k' of `names'	
		local eq : word `=`pos'+`k'' of `stripes'
		GetParmEqType `eq' `var'
		local parm `s(parm)'
		local label `"`s(type)'`label'"'	
		local diparmeq `"`s(diparmeq)'"'

		local p = 29 - length("`label'")
		qui _diparm `diparmeq', `parm' level(`cilev') notab
		DiVarCompEst "`label'" "`cformat'"
	}
end

program GetNames, sclass
	args type zvars dimz foot

	gettoken dim dimz : dimz
	forvalues k = 1/`dim' {
		gettoken tok1 zvars : zvars
		local fullvarnames `fullvarnames' `tok1'
		local len = length("`tok1'")
		if substr("`tok1'",1,2) == "R." {
			local w = substr("`tok1'",3,`len') 
			local tok1 = "R." + abbrev("`w'",8)
		}
		else {
			local tok1 = abbrev("`tok1'",8)
		}
		local varnames `varnames' `tok1'
	}
	if ("`type'" == "Unstructured") {
		forvalues j = 1/`dim' {
			local w : word `j' of `varnames'
			local names `"`names' "(`w')""'
		}
		forvalues j = 1/`dim' {
			forvalues k = `=`j'+1'/`dim' {
				local w1 : word `j' of `varnames'
				local w2 : word `k' of `varnames'
				local names `"`names' "(`w1',`w2')""'	
			}
		}
	}
	else if ("`type'" == "Independent") {    
		forvalues j = 1/`dim' {
			local w : word `j' of `varnames'
			local names `"`names' "(`w')""'
		}
	}
	else {    // Identity or Exchangeable
		local ex = ("`type'" == "Exchangeable")
		if (`dim' == 1) {		// check for factor variable
			local w `varnames'
			local names `""(`w')""'
			if `ex' {
				local names `"`names' "(`w')""'
			}
		}
		else if (`dim' == 2) {
			local w1 : word 1 of `varnames'
			local w2 : word 2 of `varnames'
			local names `""(`w1' `w2')""'
			if `ex' {
local names `"`names' "(`w1',`w2')""'
			}
		}
		else {
			local k : length local varnames
			if `k' > 20 {		// too long
				local w1 : word 1 of `varnames'	
				local w2 : word `dim' of `varnames'
				local names `""(`w1'..`w2')(`foot')""'
				if `ex' {
local names `"`names' "(`w1'..`w2')(`foot')""'
				}
				local footnote `""(`foot') `fullvarnames'""'
			}
			else {
				local names `""(`varnames')""'
				if `ex' {
local names `"`names' "(`varnames')""'
				}
			}
		}
	}

	sreturn local zvars "`zvars'"
	sreturn local dimz "`dimz'"
	sreturn local names `"`names'"'
	sreturn local footnote `"`footnote'"'
end

program GetParmEqType, sclass
	args eq var
	
	if substr("`eq'",1,1) == "l" {	  // log standard deviation
		if "`var'" == "" {	  // se/corr metric
			local parm exp
			local type sd
		}			
		else {			  // var/cov metric
			local parm f(exp(2*@)) d(2*exp(2*@))
			local type var
		}
		local deq `eq'
	}
	else { // substr("`eq'",1,1) == "a"  atanh correlation
		if "`var'" == "" {        // se/corr metric
			local parm tanh
			local type corr
			local deq `eq'
		}
		else {			  // var/cov metric
			ParseEq `eq'
			local eq2 lns`r(n1)'_`r(n2)'_`r(n3)'
			local eq3 lns`r(n1)'_`r(n2)'_`r(n4)'
			local deq `eq' `eq2' `eq3'	
			local parm f(tanh(@1)*exp(@2+@3))
			local parm `parm' d((1-(tanh(@1)^2))*exp(@2+@3)
			local parm `parm' tanh(@1)*exp(@2+@3)
			local parm `parm' tanh(@1)*exp(@2+@3)) 
			local type cov
		}
	}

	sreturn local parm `"`parm'"'
	sreturn local type `"`type'"'
	sreturn local diparmeq `"`deq'"'
end

program ParseEq, rclass
	args eq

	// I've got "eq" == "atr#_#_#_#", and I need the four #'s
	// returned as r(n1), r(n2), r(n3), and r(n4)

	local len = length("`eq'")
	local eq = substr("`eq'",4,`len')
	forvalues k = 1/4 {
		gettoken n`k' eq : eq, parse(" _")
		return local n`k' `n`k''
		gettoken unscore eq : eq, parse(" _")
	}
end

program ParseForCformat
	args diopts
	local 0 , `diopts'
	syntax [, cformat(string) *]
	
	if `"`cformat'"' == "" {
		local cformat `c(cformat)'
	}
	if `"`cformat'"' == "" {
		local cformat %9.0g
	}
	c_local cf `cformat'
end
