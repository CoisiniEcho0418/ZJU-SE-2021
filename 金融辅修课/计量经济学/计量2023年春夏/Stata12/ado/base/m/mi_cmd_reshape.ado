*! version 1.0.2  22jun2009

/*
	mi reshape long <stubnames>, i(varlist) j(newvarname) [<options>]

	mi reshape wide <varnames> , i(varlist) j(varname)   [<options>]
*/

program mi_cmd_reshape
	version 11.0

	/* ------------------------------------------------------------ */
						/* parse		*/
	u_mi_assert_set
	local reshapecmd `"reshape `0'"'
	capture noi parse_reshape type stubs iv jv : `"`0'"'
	if (_rc) {
		local rc = _rc
		if (`rc'!=1) {
			parse_reshape_msg
		}
		exit `rc'
	}
	u_mi_certify_data, acceptable
	checkiv "i()" "`iv'"
	checkiv "j()" "`jv'"
	checkstubs "`stubs'"
	/* ------------------------------------------------------------ */
	u_mi_xeq_on_tmp_flongsep:				///
		novarabbrev nobreak  mi_sub_reshape 		///
			`type' "`stubs'" "`iv'" "`jv'" ///
			`"`reshapecmd'"'
	u_mi_fixchars, proper
end


program parse_reshape
	args usertype userstubs useriv userjv colon  orig

	gettoken type rest : orig, parse(" ,")
	if (!("`type'"=="wide" | "`type'"=="long")) {
		di as err "invalid syntax"
		exit 198
	}

	local stubs
	gettoken token rest : rest, parse(" ,")
	while ("`token'"!=",") { 
		if (`"`token'"'=="") {
			parse_ij_msg "" ""
/*
			di as err "option i() required"
			exit 198
*/
		}
		local stubs `stubs' `token'
		gettoken token rest : rest, parse(" ,")
	}
	local 0 `", `rest'"'
	syntax , i(varlist) j(string) [*]
	parse_ij_msg "`i'" `"`j'"'
/*
	if ("`i'"=="") | `"`j'"'=="") {
		if ("`i'"=="" & "`j'"=="") {
			di as err "options {bf:i()} and {bf:j()} required"
		}
		else if ("`i'"=="") {
			di as err "option {bf:i()} required"
		}
		else {
			di as err "option {bf:j()} required"
		}
		di as err  "{p 4 4 2}"
		di as err  "Unlike {bf:reshape}, {bf:mi reshape} requires"
		di as err  ///
		"that {bf:i()} and {bf:j()} be specified; {bf: mi reshape}"
		di as err  ///
		"does not remember settings from previous {bf:mi reshape}"
		di as err  "commands."
		di as err  "{p_end}"
		exit 198
	}
*/

	gettoken jname : j 
	capture confirm name `jname'
	if (_rc) {
		di as err "option j() improperly specified"
		exit 198
	}
	if ("`type'"=="wide") { 
		novarabbrev confirm var `jname'
	}
	else {
		capture confirm new var `jname'
		if (_rc) { 
			di as err "variable `jname' already exists"
			exit 110
		}
	}

	c_local `usertype' `type'
	c_local `userstubs' `stubs'
	c_local `useriv'   `i'
	c_local `userjv'   `jname'
end

program parse_ij_msg
	args i j 
	if ("`i'" != "") {
		if (`"`j'"' != "") {
			exit
		}
	}

	if ("`i'"=="" & "`j'"=="") {
		di as err "  options {bf:i()} and {bf:j()} required"
	}
	else if ("`i'"=="") {
		di as err "  option {bf:i()} required"
	}
	else {
		di as err "  option {bf:j()} required"
	}
	di as err  "{p 6 6 2}"
	di as err  "Unlike {bf:reshape}, {bf:mi reshape} requires"
	di as err  ///
	"that {bf:i()} and {bf:j()} be specified; {bf: mi reshape}"
	di as err  ///
	"does not remember settings from previous {bf:mi reshape}"
	di as err  "commands."
	di as err  "{p_end}"
	exit 198
end



program parse_reshape_msg
	di as smcl as err "   {bf:mi reshape} syntax is"

	di as smcl as err ///
"       {bf:mi reshape wide} {it:varname(s)}{bf:,  i}({it:varlist}{bf:) j(}{it:varname}{bf:)} ..."

	di as smcl as err ///
	"       {bf:mi reshape long} {it:stubname(s)}{bf:, i(}{it:varlist}{bf:) j(}{it:newvarname}{bf:)} ..."

end

program checkiv
	args opid iv
						/* i() not ivar or pvar */
	local vars `_dta[_mi_ivars]' `_dta[_mi_pvars]'
	local bad : list iv & vars
	if ("`bad'" != "") {
		local n : word count "`bad'"
		local variables = cond(`n'==1, "variable", "variables")
		di as smcl as err "{p}"
		di as smcl as err "`variables' `bad'"
		di as smcl as err "registered as imputed or passive; option"
		di as smcl as err ///
		"{bf:`opid'} may not contain imputed or passive variables"
		di as smcl as err "{p_end}"
		exit 198
	}

						/* i() may not be sysvars */
	local sys "_mi_m _mi_id _mi_miss"
	local bad : list iv & sys
	if ("`bad'" != "") {
		di as smcl as err "{p}"
		di as smcl as err ///
		"{bf:`opid'} may not contain system variables such as"
		di as smcl as err "{bf:_mi_m}, {bf:_mi_id}, or {bf:_mi_miss}"
		di as smcl as err "{p_end}"
		exit 198
	}
						/* i() not _#_...	*/
	capture has_n_ "`iv'"
	if (_rc) { 
		di as smcl as err ///
		"`opid' may not contain _{it:#}_{it:name} variables"
		exit 198
	}
end

program checkstubs 
	args stubs

	capture has_n_ `stubs'
	if (_rc) { 
		di as smcl as err ///
			"{it:stubs} may not be of the form _{it:#}_{it:name}"
		di as smcl as err ///
			"   specify the names without the _{it:#}_ prefix"
		exit 198
	}
end

program has_n_ 
	args list 

	foreach name of local list {
		if (substr("`name'", 1, 1)=="_") {
			local subname = substr("`name'", 2, .)
			local i = strpos("`subname'", "_")
			if (`i'>1) {
				local prob = substr("`subname'", 1, `i'-1)
				capture confirm integer number `prob'
				if (_rc==0) {
					exit 198
				}
			}
		}
	}
end
