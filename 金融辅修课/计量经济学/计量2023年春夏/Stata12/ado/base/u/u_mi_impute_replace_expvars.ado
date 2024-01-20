*! version 1.0.0  19jan2011
program u_mi_impute_replace_expvars
	version 12
	syntax [anything(name=vars)] [if]

	if ("`vars'"=="") exit

	tempvar touse
	mark `touse' `if'

	local p : word count `vars'
	tokenize `vars'
	forvalues i=1/`p' {
		local exp : variable label ``i''
		qui replace ``i'' = `exp' if `touse'
	}
end
