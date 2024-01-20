*! version 1.0.0  28jan2011
* changes to this file may imply updates to _marg_dims.ado
program _marg_save, rclass
	syntax [, eclass *]

	local eclass : length local eclass

	if !`eclass' {
		if !inlist("margins", "`r(cmd)'", "`r(cmd2)'") {
			error 301
		}
		tempname ehold
		_est hold `ehold', restore nullok
		Post
		return add
	}
	else {
		if !inlist("margins", "`e(cmd)'", "`e(cmd2)'") {
			error 301
		}
	}

	Save, `options'
end

program Post, eclass
	tempname b
	matrix `b' = r(b)
	if `"`r(V)'"' == "matrix" {
		tempname V
		matrix `V' = r(V)
	}
	ereturn post `b' `V'
	_r2e, noclear
end

program Save
	syntax, SAVing(string) [Level(cilevel)]

	_prefix_saving `saving'
	local saving	`"`s(filename)'"'
	local dbl	`"`s(double)'"'
	local replace	`"`s(replace)'"'

	tempname PP z _deriv _term _at _atopt _margin _se _stat _p _lb _ub

	if missing(e(df_r)) {
		local df = 0
	}
	else	local df = e(df_r)
	if `df' {
		scalar `z' = invttail(`df', (100-`level')/200)
	}
	else	scalar `z' = invnormal((100+`level')/200)

	local xvars `"`e(xvars)'"'
	if `:length local xvars' {
		scalar `_deriv'	= 0
	}
	else	scalar `_deriv'	= .
	scalar `_term'	= .
	scalar `_at'	= .
	scalar `_atopt'	= .

	if "`e(cmd)'" == "pwcompare" {
		local matrix matrix(e(b_vs))
	}

	_ms_eq_info, `matrix'
	local keq = r(k_eq)
	forval i = 1/`keq' {
		local k`i' = r(k`i')
		local eq`i' = r(eq`i')
	}
	if `keq' == 1 {
		if `"`eq1'"' == "_" {
			local eq1
		}
	}

	local vlist0	_deriv			///
			_term			///
			_at			///
			_atopt			///
			`dbl'	_margin		///
			`dbl'	_se		///
			`dbl'	_statistic	///
			`dbl'	_pvalue		///
			`dbl'	_ci_lb		///
			`dbl'	_ci_ub
	local plist0	(`_deriv')		///
			(`_term')		///
			(`_at')			///
			(`_atopt')		///
			(`_margin')		///
			(`_se')			///
			(`_stat')		///
			(`_p')			///
			(`_lb')			///
			(`_ub')

	local _CONS _cons

	local klabs 0

	local vnames

	// build the list of margin variables
	local mlist `"`e(margins)'"'
	if `:length local mlist' {
		_fv_term_info `e(margins)', noc
		local k = r(k_terms)
	}
	else	local k 0
	local mlist
	forval i = 1/`k' {
		local colna : colna r(level`i')
		local mlist : list mlist | colna
	}
	local mlist : list uniq mlist
	local mlist : list mlist - _CONS
	local MLIST : copy local mlist
	local km : list sizeof MLIST
	forval i = 1/`km' {
		local vname _m`i'
		gettoken m MLIST : MLIST
		_ms_parse_parts `m'
		local hasrcp = "`r(ts_op)'" != ""
		local m`i'name : copy local m
		if `hasrcp' {
			local type double
		}
		else {
			local m`i'lab : var label `m'
			local m`i'fmt : format `m'
			local type : type `m'
			local lab : value label `m'
		}
		local vnames `vnames' `vname'
		local vlist `vlist' `type' `vname'
		tempname m`i'
		scalar `m`i'' = .
		local plist `plist' (`m`i'')
		if `:length local lab' {
			local ++klabs
			local vllist `vllist' `vname'
			local lllist `lllist' `lab'
		}
	}

	// build the list of at() variables
	if "`e(at)'" == "matrix" {
		local rat = rowsof(e(at))
		local cat = colsof(e(at))
		local ATCOLNA : colna e(at)
		local atcolna : copy local ATCOLNA
		tempname atdim
		matrix `atdim' = e(atdims)
		local catdim = colsof(`atdim')
		local sum = `atdim'[1,1]
		forval i = 2/`catdim' {
			local sum = `sum' + `atdim'[1,`i']
			matrix `atdim'[1,`i'] = `sum'
		}
	}
	else {
		local rat 0
		local cat 0
	}
	local i 0
	forval j = 1/`cat' {
		gettoken at ATCOLNA : ATCOLNA
		_ms_parse_parts `at'
		local hasrcp = "`r(ts_op)'" != ""
		local fmt : format `r(name)'
		if `hasrcp' {
			local name `r(ts_op)'.`r(name)'
		}
		else {
			local name `r(name)'
		}
		if !`:list name in atlist' {
			local atlist `atlist' `name'
			local ++i
			local vname _at`i'
			local at`i'name : copy local name
			local at`i'vname : copy local vname
			if `hasrcp' {
				local type double
			}
			else {
				local at`i'lab : var label `name'
				local type : type `name'
				local lab : value label `name'
			}
			local at`i'fmt : copy local fmt
			local vnames `vnames' `vname'
			local vlist `vlist' `type' `vname'
			tempname at`i'
			scalar `at`i'' = .
			local plist `plist' (`at`i'')
			if `:length local lab' {
				local ++klabs
				local vllist `vllist' `vname'
				local lllist `lllist' `lab'
			}
		}
	}
	local kat = `i'

	// build the list of by variables
	local hasby = `"`e(by)'"' != ""
	if `hasby' {
		local bylist `"`e(by)'"'
		local BYLIST : copy local bylist
		local kby : list sizeof BYLIST
		forval i = 1/`kby' {
			local vname _by`i'
			gettoken by BYLIST : BYLIST
			local by`i'name : copy local by
			local by`i'lab : var label `by'
			local by`i'fmt : format `by'
			local type : type `by'
			local vnames `vnames' `vname'
			local vlist `vlist' `type' `vname'
			tempname by`i'
			scalar `by`i'' = .
			local plist `plist' (`by`i'')
			local lab : value label `by'
			if `:length local lab' {
				local ++klabs
				local vllist `vllist' `vname'
				local lllist `lllist' `lab'
			}
		}
		local rby = e(k_by)
	}
	else {
		local rby = 1
	}

	local vlist `vlist0' `vlist'
	local plist `plist0' `plist'

	postfile `PP' `vlist' using `"`saving'"', `replace'
	local bpos 0
	local atbarpos 0
	forval i = 1/`keq' {
		if !missing(`_deriv') {
			scalar `_deriv' = `i'
			local derivlab `"`derivlab' `i' "`eq`i''""'
		}
		local oldterm	"_"
		scalar `_term'	= 0
		local oldbylevs	""
		forval j = 1/`k`i'' {
			local ++bpos
			local k 0
			foreach m of local mlist {
				local ++k
				scalar `m`k'' = .
			}
			local k 0
			foreach at of local atlist {
				local ++k
				scalar `at`k'' = .
			}
			local k 0
			foreach by of local bylist {
				local ++k
				scalar `by`k'' = .
			}

			_ms_element_info, element(`j') eq(#`i') `matrix'
			local term `"`r(term)'"'
			local type `"`r(type)'"'
			if "`e(cmd)'" == "pwcompare" {
				scalar `_margin' = el(e(b_vs), 1, `bpos')
				scalar `_se' = sqrt(el(e(V_vs), `bpos', `bpos'))
			}
			else {
				scalar `_margin' = r(b)
				scalar `_se' = r(se)
			}

			local MTERM

	if "`type'" == "variable" {
		local pos : list posof "`term'" in xvars
		if `pos' {
			scalar `_deriv' = `pos'
			local derivlab `"`derivlab' `pos' "`term'""'
		}
	}
	else {
		if `keq' == 1 {
			if "`type'" == "factor" {
				local op "`r(level)'"
				if "`r(note)'" == "(base)" {
					local op "`op'b"
				}
				if "`r(operator)'" != "" {
					local op "`op'`r(operator)'"
				}
				local name `op'.`term'
			}
			local pos : list posof "`name'" in xvars
			if `pos' {
				scalar `_deriv' = `pos'
				local derivlab `"`derivlab' `pos' "`name'""'
			}
		}

		local LEVEL `"`r(level)'"'
	if `i' == 1 {
		local atbarpos 0
		gettoken pre post : term, parse("@|")
		if `:length local post' {
			gettoken atbar post : post, parse("@|")
			local pre : subinstr local pre "#" " ",	///
				all count(local atbarpos)
			local ++atbarpos
		}
	}
		_at_strip_contrast `term'
		local TLIST `"`r(varlist)'"'
		local TLIST : subinstr local TLIST "#" " ", all

		local k 0
		foreach m of local mlist {
			local ++k
			if strpos("`m'", ".") {
				local pos : list posof "i`m'" in TLIST
			}
			else {
				local pos : list posof "i.`m'" in TLIST
			}
			if `pos' {
				local MTERM `MTERM' `m'
				scalar `m`k'' = `:word `pos' of `LEVEL''
			}
			else {
				scalar `m`k'' = .
			}
		}

		local atterm
		local atsharp
		local k 0
		foreach by of local bylist {
			local ++k
			local pos : list posof "i.`by'" in TLIST
			if `pos' {
				local bylev : word `pos' of `LEVEL'
				scalar `by`k'' = `bylev'
				local bylevs `bylevs' `bylev'
				local atterm `atterm'`atsharp'`bylev'.`by'
				local atsharp "#"
			}
		}

		if `rat' {
			local pos : list posof "i._at" in TLIST
			if `pos' {
				local atlev : word `pos' of `LEVEL'
				local jat = rownumb(e(at), ///
						"`atlev'._at`atsharp'`atterm'")
			}
			else { 
				if `:length local atterm' {
					local jat = rownumb(e(at), "`atterm'")
				}
				else {
					local jat 1
				}
				local atlev 1
			}
			local atspec `"`e(atstats`atlev')'"'
			scalar `_at' = `atlev'
			local jatopt 1
			while `_at' > `atdim'[1,`jatopt'] {
				local ++jatopt
			}
			scalar `_atopt' = `jatopt'
			local k 0
			foreach at of local atcolna {
				gettoken spec atspec : atspec
				local ++k
				_ms_parse_parts `at'
				local hasrcp = "`r(ts_op)'" != ""
				if `hasrcp' {
					local name `r(ts_op)'.`r(name)'
				}
				else {
					local name `r(name)'
				}
				local pos : list posof "`name'" in atlist
				if r(type) == "variable" {
					if "`spec'" == "asobserved" {
						scalar `at`pos'' = .o
					}
					else {
						scalar `at`pos'' = ///
							el(e(at),`jat',`k')
					}
				}
				else {
					if "`spec'" == "asbalanced" {
						scalar `at`pos'' = .b
					}
					else if "`spec'" == "asobserved" {
						scalar `at`pos'' = .o
					}
					else if el(e(at),`jat',`k') == 1 {
						scalar `at`pos'' = r(level)
					}
				}
			}
		}

	}

			if !`:list MTERM == oldterm' {
				scalar `_term' = `_term' + 1
				local oldterm : copy local MTERM 
			}

	if `i' == 1 {
			local k = `_term'
			RebuildMTERM MTERM : `atbarpos' "`atbar'" `MTERM'
			local mVlab `"`mVlab' `k' "`MTERM'""'
	}

			scalar `_stat' = `_margin'/`_se'
			if `df' {
				scalar `_p' = 2*ttail(`df',abs(`_stat'))
			}
			else	scalar `_p' = 2*normal(-abs(`_stat'))
			scalar `_lb' = `_margin' - `_se'*`z'
			scalar `_ub' = `_margin' + `_se'*`z'
			post `PP' `plist'
		}
	}
	postclose `PP'

	if `klabs' {
		tempfile labfile
		quietly label save `lllist' using `"`labfile'"'
	}

	preserve
	quietly use `"`saving'"', clear

	// variable labels and characteristics
	label var _deriv	"Derivatives w.r.t."
	label var _term		"Margin term index"
	label var _at		"Covariates fixed values index"
	label var _atopt	"at() option index"

	// margining variable characteristics
	if `:length local mVlab' {
		label define _term `mVlab'
		label values _term _term
	}
	local i 0
	foreach m of local mlist {
		local ++i
		if `:length local m`i'lab' {
			label var _m`i' `"`m`i'lab'"'
		}
		else {
			label var _m`i' `"`m`i'name'"'
		}
		char _m`i'[varname] `"`m`i'name'"'
		format _m`i' `m`i'fmt'
	}
	char _dta[margin_vars] `"`mlist'"'
	char _dta[cmd] `"`e(cmd)'"'

	// at() variable characteristics
	local k_at = e(k_at)
	forval i = 1/`k_at' {
		local speclist
		local atspec `"`e(atspec`i')'"'
		local oldname
		foreach at of local atcolna {
			gettoken spec atspec : atspec
			_ms_parse_parts `at'
			local hasrcp = "`r(ts_op)'" != ""
			if `hasrcp' {
				local name `r(ts_op)'.`r(name)'
			}
			else {
				local name `r(name)'
			}
			if r(type) == "factor" {
				if `"`name'"' != `"`oldname'"' {
					local speclist `speclist' `spec'
				}
				local oldname : copy local name
			}
			else {
				local speclist `speclist' `spec'
				local oldname
			}
		}
		local atspec`i' : copy local speclist
		char _dta[atopt`i'] `"`e(atopt`i')'"'
		char _dta[atstats`i'] `"`speclist'"'
		local atoptVlab `"`atoptVlab' `i' `"`e(atopt`i')'"'"'
	}
	if `:length local atoptVlab' {
		label define _atopt `atoptVlab'
		label values _atopt _atopt
	}
	char _dta[k_at] `"`k_at'"'
	local i 0
	foreach at of local atlist {
		local speclist
		forval j = 1/`k_at' {
			gettoken spec atspec`i' : atspec`i'
			local speclist `speclist' `spec'
		}
		local ++i
		if `:length local at`i'lab' {
			label var _at`i' `"`at`i'lab'"'
		}
		else {
			label var _at`i' `"`at`i'name'"'
		}
		char _at`i'[varname] `"`at`i'name'"'
		char _at`i'[stats] `"`speclist'"'
		format _at`i' `at`i'fmt'
	}
	char _dta[at_vars] `"`atlist'"'
	local uatvars `"`e(u_at_vars)'"'
	foreach var of local uatvars {
		local pos : list posof "`var'" in atlist
		local _u_at_vars `"`_u_at_vars' _at`pos'"'
	}
	char _dta[u_at_vars] `"`e(u_at_vars)'"'
	char _dta[_u_at_vars] `"`:list retok _u_at_vars'"'

	// over() and within() variable characteristics
	local i 0
	foreach by of local bylist {
		local ++i
		if `:length local by`i'lab' {
			label var _by`i' `"`by`i'lab'"'
		}
		else {
			label var _by`i' `"`by`i'name'"'
		}
		local BYLIST `BYLIST' _by`i'
		char _by`i'[varname] `"`by`i'name'"'
		format _by`i' `by`i'fmt'
	}
	char _dta[over]			`"`e(over)'"'
	char _dta[within]		`"`e(within)'"'
	char _dta[by_vars]		`"`bylist'"'
	char _dta[title]		`"`e(title)'"'
	char _dta[predict_label]	`"`e(predict_label)'"'
	char _dta[expression]		`"`e(expression)'"'

	local label `"`e(predict_label)'"'
	if `:length local label' {
		local comma ", "
	}
	label var _margin	`"`label'`comma'`e(expression)'"'
	label var _se		"Standard error"
	if "`e(df_r)'" == "" {
		local z z
	}
	else	local z t
	label var _statistic	"`z'-statistic"
	label var _pvalue	"P>|`z'|"
	label var _ci_lb	"`level'% Confidence interval, LB"
	label var _ci_ub	"`level'% Confidence interval, UB"
	label data "Created by command margins; also see char list"

	// add value labels
	if `:length local derivlab' {
		label define _deriv `derivlab'
		label values _deriv _deriv
	}

	if `klabs' {
		// add value labels from the original dataset
		run `"`labfile'"'
		forval i = 1/`klabs' {
			gettoken var vllist : vllist
			gettoken lab lllist : lllist
			label values `var' `lab'
		}
	}
	if "`e(cmd)'" == "contrast" {
		tempname t
		_ms_to_vl, prefix(`t')
		local k = r(k_names)
		forval i = 1/`k' {
			local name = r(name`i')
			local vl = r(vl`i')
			local pos : list posof "`name'" in mlist
			if `pos' {
				label copy `vl' _m`pos'
				label values _m`pos' _m`pos'
			}
			local pos : list posof "`name'" in atlist
			if `pos' {
				label copy `vl' _at`pos'
				label values _at`pos' _at`pos'
			}
			local pos : list posof "`name'" in bylist
			if `pos' {
				label copy `vl' _by`pos'
				label values _by`pos' _by`pos'
			}
			label drop `vl'
		}
	}
	else if "`e(cmd)'" == "pwcompare" {
		CMP2VL
	}

	// characteristics from the scalars and macros in 'e()'
	quietly compress
	quietly save `"`saving'"', replace
end

program RebuildMTERM
	gettoken c_mterm	0 : 0
	gettoken COLON		0 : 0
	gettoken atbarpos	0 : 0
	gettoken atbar		MTERM : 0

	local dim : list sizeof MTERM
	if `atbarpos' < `dim' {
		local mterm : copy local MTERM
		local MTERM
		forval i = 1/`atbarpos' {
			gettoken term mterm : mterm
			local MTERM `MTERM' `term'
		}
		local MTERM `MTERM'`atbar'`:list retok mterm'
	}
	else if `dim' == 0 {
		local MTERM _cons
	}
	local MTERM : list retok MTERM
	local MTERM : subinstr local MTERM " " "#", all
	c_local `c_mterm' `"`MTERM'"'
end

program CMP2VL
	_ms_eq_info, matrix(e(b_vs))
	local keq = r(k_eq)
	forval eq = 1/`keq' {
		local k`eq' = r(k`eq')
	}
	gen _pw = _n
	local j 0
	forval eq = 1/`keq' {
		forval el = 1/`k`eq'' {
			local ++j
			_ms_element_info,	el(`el')	///
						eq(#`eq')	///
						width(900)	///
						matrix(e(b_vs))	///
						compare		///
								 // blank
			label define _pw `j' `"`r(level)'"', add
		}
	}
	label values _pw _pw
end

exit
