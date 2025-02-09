*! version 1.0.0  02jul2011
program u_mi_impute_cmd_monotone_init
	version 12
	args keq estfile
	local k $MI_kgroup
	if ("`k'"=="") {
		local k 1
	}
	local append replace	
	forvalues i=1/`keq' {
		//-nocondchk-: do not perform checks on conditional
		// sample (CS) because conditioning variables defining CS 
		// may not have been imputed yet
		u_mi_impute_cmd_uvmethod_init ${MI_IMPUTE_UVINIT`k'_`i'} ///
						"monotone" "" "" "" "nocondchk"
		qui estimates save `estfile', `append'
		local append append
	}
end
