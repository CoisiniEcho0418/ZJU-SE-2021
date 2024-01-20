*! version 1.1.0  17mar2009
program _prefix_varblocklist
	// Syntax:  <c_vblist> <c_vlist> <c_k> <c_stub> : <varblocklist>
	//
	// the <c_*> are names for local macros to create for the caller:
	//
	// <c_vblist>	- the parsed <varblocklist>
	// <c_vlist>	- the corresponding varlist
	// <c_k>	- the number of blocks
	// <c_stub>	- stub to use to return the individual blocks
	version 9.1
	_on_colon_parse `0'
	local after `"`s(after)'"'
	tokenize `s(before)'
	args c_vblist c_vlist c_k c_stub 
	confirm name `c_vblist'
	confirm name `c_vlist'
	confirm name `c_k'
	confirm name `c_stub'
	local 0 `"`after'"'
	syntax anything(id="varblocklist" name=varblocklist)

	local k 0
	while `"`:list retok varblocklist'"' != "" {
		local ++k
		gettoken varblock varblocklist : varblocklist, bind match(par)
		if "`par'" == "" {
			// `varblock' is not a block of variable names
			fvunab varblock : `varblock'
			// check for expanded wildcard
			if `:word count `varblock'' != 1 {
				gettoken varblock rest : varblock
				local varblocklist `"`rest' `varblocklist'"'
			}
			local vblist `vblist' `varblock'
		}
		else {
			// `varblock' is a block of variable names
			if "`varblock'" != "" {
				fvunab varblock : `varblock'
				local vblist `vblist' (`varblock')
			}
		}
		c_local `c_stub'`k' `varblock'
		local vlist `vlist' `varblock'
	}
	c_local `c_vlist' `vlist'
	c_local `c_vblist' `vblist'
	c_local `c_k' `k'
end
exit
