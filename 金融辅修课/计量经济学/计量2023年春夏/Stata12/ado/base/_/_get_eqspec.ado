*! version 1.0.1  21apr2010
program _get_eqspec
	version 9
	args c_eqlist c_stub c_k COLON b
	confirm name `c_eqlist'
	confirm name `c_stub'
	confirm name `c_k'
	confirm matrix `b'
	if "`COLON'" != ":" {
		error 198
	}
	tempname tb

	local cons _cons
	local eqlist : coleq `b'
	c_local `c_eqlist' `"`: list uniq eqlist'"'
	local nlist : colnames `b'

	local i 1
	local names
	local nocons noconstant
	gettoken eq0 : eqlist
	while "`nlist'" != "" {
		gettoken eq eqlist : eqlist
		gettoken name nlist : nlist
		if ("`eq'" != "`eq0'") {
			// post spec for previous equation
			c_local `c_stub'`i'xvars `names'
			c_local `c_stub'`i'nocons `nocons'
			local ++i
			local names
			local nocons noconstant
		}
		if "`name'" == "_cons" | "`name'" == "o._cons" {
			local nocons
		}
		else {
			local names `names' `name'
		}
		local eq0 `"`eq'"'
	}
	// post spec for last equation
	c_local `c_stub'`i'xvars `names'
	c_local `c_stub'`i'nocons `nocons'
	c_local `c_k' `i'
end
exit
