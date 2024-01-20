*! version 1.0.1  21feb2009

program xtunitroot

	local alltests ht llc ips fisher hadri breitung

	local test : word 1 of `0'
	
	local 0 : subinstr local 0 "`test'" ""
	
	// if user specifies test but no variable, the comma stays with
	// test, issuing wrong error message
	local test : subinstr local test "," "" , count(local comma)
	if `comma' {
		local 0 , `0'
	}
	
	local valid : list posof "`test'" in alltests
	if !`valid' {
		// remove comma before options
		local test : subinstr local test "," ""
		di as error "test `test' not allowed"
		exit 198
	}
	
	// so we can say 'varname required' instead of 'varlist required'
	capture syntax varname [if] [in], [*]
	if _rc == 100 {
		di as error "varname required"
		exit 100
	}
	else if _rc {
		// get error message -- if we just -error _rc-, we
		// get generic message, not always the one 
		// syntax produces
		syntax varname [if] [in], [*]
	}
	
	_xtur`test' `varlist' `if' `in', `options'

end
