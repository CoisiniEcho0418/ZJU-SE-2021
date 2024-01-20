*! version 1.0.0  21may2011
program _marg_report, rclass
	version 11
	if !inlist("`e(cmd)'", "contrast", "margins", "pwcompare", "pwmean") {
		error 301
	}

	local is_contrast = "`e(cmd)'" == "contrast"
	local is_pwcompare = "`e(cmd)'" == "pwcompare"
	local is_pwmean = "`e(cmd)'" == "pwmean"
	if `is_contrast' {
		local OPTS	noWALD			///
				NOEFFects EFFects	///
				CIeffects		///
				PVeffects		///
				noSVYadjust		///
				noATLEVELS
	}
	else if `is_pwcompare' {
		local OPTS	EFFects			///
				CIeffects		///
				PVeffects		///
				GROUPs			///
				CIMargins		///
				SORT
	}
	else if `is_pwmean' {
		local OPTS	EFFects			///
				CIeffects		///
				PVeffects		///
				GROUPs			///
				CIMeans			///
				SORT
	}

	syntax [,	Level(passthru)		///
			vsquish			///
			NOATLegend		///
			MCOMPare(passthru)	///
			`OPTS'			///
			*			///
	]

	if "`noeffects'" != "" {
		opts_exclusive "`noeffects' `effects'"
		opts_exclusive "`noeffects' `cieffects'"
		opts_exclusive "`noeffects' `pveffects'"
	}

	_get_mcompare, `mcompare'
	local method	`"`s(method)'"'
	local all	`"`s(adjustall)'"'
	opts_exclusive "`all' `groups'"
	local ci : length local cieffects
	local pv : length local pveffects
	local full : length local effects

	_check_eformopt `e(est_cmd)', eformopts(`options') soptions
	local options `"`s(options)'"'
	local eform `"`s(eform)'"'
	_get_diopts diopts, `options' `vsquish' `level'
	local level `"`s(level)'"'

	local dydx  "`e(derivatives)'"

	if `is_contrast' {
		local wald = "`wald'" != "nowald"
		if !`ci'`pv'`full' & "`noeffects'" == "" {
			if `"`method'"' != "noadjust"	|	///
			   `"`e(has_full_coding)'"' == "1" {
				local ci 1
			}
		}
		local coding coding
		local ct1 coeftitle(Contrast)
		local ct2 coeftitle2(`dydx')
		tempname group tinfo
		matrix `group' = e(group)
		matrix `tinfo' = e(test_info)
		local kg = colsof(`group')
		local pos 0
		forval i = 1/`kg' {
			if `group'[1,`i'] < 0 {
				local pos = `tinfo'[2,`i'] - 1
				continue, break
			}
		}
		if `pos' {
			tempname b V err
			matrix `b' = e(b)
			matrix `b' = `b'[1,1..`pos']
			matrix `V' = e(V)
			matrix `V' = `V'[1..`pos',1..`pos']
			matrix `err' = e(error)
			matrix `err' = `err'[1,1..`pos']
			local matopts bmat(`b') vmat(`V') emat(`err')
		}
		local septitle septitle
	}
	else if `is_pwcompare' | `is_pwmean' {
		local wald 0
		local mlist `groups' `cimargins' `cimeans'
		if !`ci'`pv'`full' {
			if "`mlist'" == "" {
				local ci 1
			}
		}
		opts_exclusive "`all' `groups'"
		local gr	: length local groups
		if `is_pwcompare' {
			local cm : length local cimargins
		}
		else {
			local cm : length local cimeans
		}
		local matopts	bmat(e(b_vs))		///
				vmat(e(V_vs))		///
				emat(e(error_vs))	///
				mmat(e(b))		///
				mvmat(e(V))		///
				suffix(_vs)
		local mcnote mcompare(\`return(mcmethod_vs)')
		local compare compare
		local ct1 coeftitle(Contrast)
		local ct2 coeftitle2(`dydx')
	}
	else {
		local wald 0
		local full 1
		if "`dydx'" != "" {
			local ct1 coeftitle(`dydx')
		}
		else {
			local ct1 coeftitle(Margin)
		}
	}

	_coef_table_header, `septitle'
	if "`e(vce)'" == "delta" {
		vceHeader
	}
	local label `"`e(predict_label)'"'
	if `:length local label' {
		local label `"`label', `e(expression)'"'
	}
	else {
		local label `"`e(expression)'"'
	}
	local di di
	if `:length local label' {
		`di'
		local di
		Legend Expression `"`label'"'
	}
	local hasat = "`e(at)'" == "matrix"
	if `:length local dydx' {
		local xvars "`e(xvars)'"
		foreach x of local xvars {
			_ms_parse_parts `x'
			if !r(omit) {
				local XVARS `XVARS' `x'
			}
		}
		`di'
		local di
		Legend "`dydx' w.r.t." "`XVARS'"
	}
	if "`e(over)'" != "" {
		`di'
		local di
		Legend over "`e(over)'"
	}
	if "`e(within)'" != "" {
		`di'
		local di
		Legend within "`e(within)'"
	}
	if "`e(margin_method)'" != "" {
		`di'
		local di
		Legend "Margins" "`e(margin_method)'"
	}
	if !inlist("`e(emptycells)'", "", "strict") {
		`di'
		local di
		Legend "Empty cells" "`e(emptycells)'"
	}
	if `hasat' & "`noatlegend'" == "" {
		`di'
		local di
		AtLegend, `vsquish'
	}

	local radd 1
	if `is_contrast' {
		if `wald' {
			if "`method'" != "noadjust" {
				quietly _coef_table,	cmdextras	///
							`matopts'	///
							`mcompare'
				tempname pvmat
				matrix `pvmat' = r(table)
				local row = rownumb(`pvmat', "pvalue")
				if `row' {
					matrix `pvmat' = `pvmat'[`row',1...]
					local pvopt		///
						pvmat(`pvmat')	///
						mctitle(`r(mctitle)')
				}
				return add
				return local level
				local radd 0
			}
			di
			WaldTable, `pvopt' `svyadjust' `atlevels' `diopts'
		}
	}
	else if `is_pwcompare' | `is_pwmean' {
		local GROUPSOK = "`method'" != "dunnett" & "`all'" == ""
		if `is_pwcompare' {
			local coefttl coeftitle(Margin)
		}
		else {
			local coefttl coeftitle(Mean)
		}
		if `gr' {
			di
			_coef_table,	`sort'				///
					bmat(e(b_vs))			///
					vmat(e(V_vs))			///
					emat(e(error_vs))		///
					mmat(e(b))			///
					mvmat(e(V))			///
					cmdextras			///
					groups				///
					`mcompare'			///
					showeqns			///
					`coefttl'			///
					`diopts'
			return add
			return local level
			Footnotes,	dydx(`dydx')			///
					mcompare(`return(mcmethod)')
			return local mcmethod
		}
		else if `GROUPSOK' {
			quietly						///
			_coef_table,	bmat(e(b_vs))			///
					vmat(e(V_vs))			///
					emat(e(error_vs))		///
					mmat(e(b))			///
					mvmat(e(V))			///
					cmdextras			///
					groups				///
					`mcompare'
			return add
			return local level
			return local mcmethod
		}
		if `cm' {
			di
			_coef_table,	`sort'				///
					cmdextras			///
					cionly				///
					showeqns			///
					`coefttl'			///
					`diopts'
			return add
			return local level
			Footnotes, dydx(`dydx')
		}
		else {
			quietly _coef_table, cmdextras
			return add
			return local level
		}
	}
	if `pv' {
		di
		_coef_table,	`coding'		///
				`compare'		///
				cmdextras		///
				showeqns		///
				pvonly			///
				`ct1'			///
				`ct2'			///
				`mcompare'		///
				`matopts'		///
				`sort'			///
				`eform'			///
				`diopts'
		return add
		return local level
		local radd 0
		Footnotes, dydx(`dydx') pveffects `mcnote'
		local nomclegend nomclegend
	}
	if `ci' {
		di
		_coef_table,	`coding'		///
				`compare'		///
				cmdextras		///
				showeqns		///
				cionly			///
				`ct1'			///
				`ct2'			///
				`mcompare'		///
				`matopts'		///
				`sort'			///
				`eform'			///
				`nomclegend'		///
				`diopts'
		if `radd' {
			return add
			return local level
			local radd 0
		}
		Footnotes, dydx(`dydx') cieffects `mcnote'
		local nomclegend nomclegend
	}
	if `full' {
		di
		_coef_table,	`coding'		///
				`compare'		///
				cmdextras		///
				showeqns		///
				`ct1'			///
				`ct2'			///
				`mcompare'		///
				`matopts'		///
				`sort'			///
				`eform'			///
				`nomclegend'		///
				`diopts'
		if `radd' {
			return add
			return local level
			local radd 0
		}
		Footnotes, dydx(`dydx') cieffects pveffects `mcnote'
		local nomclegend nomclegend
	}
	if `radd' {
		quietly _coef_table, cmdextras `matopts' `mcompare'
		return add
		return local level
	}
	return scalar level = `level'
end

program vceHeader
	local model_vce `"`e(model_vcetype)'"'
	if !`:length local model_vce' {
		local model_vce `"`e(model_vce)'"'
		local proper conventional twostep unadjusted
		if `:list model_vce in proper' {
			local model_vce = strproper(`"`e(model_vce)'"')
		}
		else	local model_vce = strupper(`"`e(model_vce)'"')
	}
	local col 14
	local h1 "Model VCE"
	if `:length local model_vce' {
		di as txt `"`h1'"'  _col(`col') ": " as res `"`model_vce'"'
	}
end

program Legend
	args name value
	local len = strlen("`name'")
	local c2 = 14
	local c3 = 16
	di "{txt}{p2colset 1 `c2' `c3' 2}{...}"
	if `len' {
		di "{p2col:`name'}:{space 1}{res:`value'}{p_end}"
	}
	else {
		di "{p2col: }{space 2}{res:`value'}{p_end}"
	}
	di "{p2colreset}{...}"
end

program AtLegend
	syntax [, vsquish]
	tempname at
	matrix `at'	= e(at)
	local k_by	= e(k_by)
	local hasby	= `k_by' > 1
	local r		= rowsof(`at')
	local c		= colsof(`at')
	if `r' == `k_by' {
		local vsquish vsquish
	}
	local blank = "`vsquish'" == ""
	if `hasby' {
		local within `"`e(within)'"'
		local r	= `r'/`k_by'
		local ind "{space 4}"
	}
	local NLIST : colna `at'
	local row 0
	local oldname
	local flushbal 0
	if `r' == 1 {
		local title at
		local first 1
		local stats `"`e(atstats1)'"'
		local stats : list uniq stats
		local asstats asbalanced asobserved
		local stats : list stats - asstats
		if `:list sizeof stats' == 0 {
			local flushbal 1
		}
	}
	forval i = 1/`r' {
		if `r' > 1 {
			local title `i'._at
			local first 1
		}
		local SLIST `"`e(atstats`i')'"'
		local allasobs : list uniq SLIST
		local allasobs = "`allasobs'" == "asobserved"
		if `blank' {
			di
		}
	forval g = 1/`k_by' {
		if `k_by' > 1 {
			local group `"{txt}`e(by`g')'"'
			if `first' {
				Legend "`title'" "`group'"
			}
			else {
				Legend "" "`group'"
			}
			local first 0
		}
		local ++row
		local nlist : copy local NLIST
		local slist : copy local SLIST
		forval j = 1/`c' {
			gettoken name nlist : nlist
			gettoken spec slist : slist
			local factor 0
			local asbal = "`spec'" == "asbalanced"
			if `asbal' {
				local factor 1
			}
			else if !`allasobs' {
				if missing(`at'[`row',`j']) {
					continue
				}
			}
			_ms_parse_parts `name'
			if r(type) == "factor" {
				if `at'[`row',`j'] == 0 {
					continue
				}
				else if `at'[`row',`j'] == 1 {
					local factor 1
				}
				local name `r(level)'`r(ts_op)'.`r(name)'
			}
			if `factor' {
				_ms_parse_parts `name'
				local op `"`r(ts_op)'"'
				local val = r(level)
				if `:length local op' {
					local name `"`op'.`r(name)'"'
				}
				else	local name `"`r(name)'"'
				if `asbal' {
					if `:list name in within' {
						local olname
						continue
					}
					if `"`name'"' == "`olname'" {
						continue
					}
				}
			}
			else {
				local name = abbrev("`name'", 12)
			}
			local olname : copy local name
			local ss = 16 - strlen("`name'")
			if `ss' > 0 {
				local space "{space `ss'}"
			}
			else	local space
			if !`factor' {
				local val : display %9.0g `at'[`row',`j']
				local val : list retok val
			}
			if `asbal' {
				if `flushbal' {
					local val
				}
				else {
					local val "{space 12}"
				}
			}
			else {
				local len : length local val
				local ss = 11 - `len'
				if `ss' > 0 {
					local val "{space `ss'}`val'"
				}
			}
			if `factor' & !`asbal' {
				local spec
			}
			if !inlist(`"`spec'"',	"",		///
						"asobserved",	///
						"value",	///
						"values",	///
						"zero") {
				if !`hasby' {
				    if substr("`spec'",1,1) == "o" {
					local spec = substr("`spec'",2,.)
				    }
				}
				local val `"`val' {txt:(`spec')}"'
			}
			if `allasobs' {
				local pair `"`ind'{txt:(asobserved)}"'
			}
			else if `asbal' {
				local pair ///
					"`ind'{txt:`name'}`space'  `val'"
			}
			else {
				local pair ///
					"`ind'{txt:`name'}`space'{txt:=} `val'"
			}
			if `first' {
				Legend "`title'" `"`pair'"'
				local first 0
			}
			else {
				Legend "" `"`pair'"'
			}
			if `allasobs' {
				continue, break
			}
		} // j
	} // g
	} // i
end

program WaldTable
	syntax [,		///
		vsquish		///
		noSVYadjust	///
		noATLEVELS	///
		pvmat(name)	///
		mctitle(string)	///
		NOLSTRETCH	///
		*		///
	]
	tempname X df p info Tab

	local noatlevels : length local atlevels

	local has_mcpv = "`pvmat'" != "" & "`mctitle'" != ""

	_get_diopts ignored, `options' `nolstretch'
	local nolstretch : length local nolstretch
	local is_svy = "`e(prefix)'" == "svy"
	local svy_adjust = `is_svy' & "`svyadjust'" == ""
	if missing(e(df_r)) {
		local svy_adjust 0
	}
	local hasdf2	= "`e(df2)'" == "matrix"
	if `hasdf2' {
		local stat F
		tempname df2 group
		matrix `X'	= e(F)
		matrix `df'	= e(df)
		matrix `df2'	= e(df2)
		matrix `p'	= e(p)
		if `svy_adjust' {
			mata: _svy_adjust("`X'", "`df'", "`df2'", "`p'")
		}
		matrix `group'	= e(group)
	}
	else {
		local stat chi2
		matrix `X'	= e(chi2)
		matrix `df'	= e(df)
		matrix `p'	= e(p)
	}
	matrix `info'	= e(test_info)
	local overall	= strlen("`e(overall)'")
	local k		= colsof(`X')

	local mcwaldmsg = `has_mcpv'
	if `has_mcpv' {
		local has1 0
		forval i = 1/`k' {
			if `df'[1,`i'] == 1 {
				local has1 1
				continue, break
			}
		}
		if `has1' == 0 {
			local has_mcpv 0
		}
	}

	if `has_mcpv' {
		local cols 5
	}
	else {
		local cols 4
	}

	if `has_mcpv' {
		local w5 11
		local t5 %11s
		local p5 2
		local n5 %9.4f
		local s5 .
		local b5 `""""'
	}
	if `nolstretch' {
		local w1	13
	}
	else {
		local w1 = c(linesize) - 2 - 11 - 12 - 11
		if `has_mcpv' {
			local w1 = `w1' - `w5'
		}
		CFindMinWidth `w1' `info' joint `noatlevels'
		local w1 = r(width) + 1
	}
	.`Tab'	= ._tab.new, col(`cols') lmargin(0)
	// column	1	2	3	4	5
	.`Tab'.width	`w1'	|11	12	11	`w5'
	local --w1
	.`Tab'.titlefmt	.	%11s	%12s	%11s	`t5'
	.`Tab'.pad	.	2	3	2	`p5'
	.`Tab'.numfmt	.	%9.0g	%9.2f	%9.4f	`n5'
	.`Tab'.strcolor	.       result  .       .	`s5'

	.`Tab'.sep, top
	if `has_mcpv' {
		.`Tab'.titles	"" "" "" "" "`mctitle'"
		.`Tab'.titles	"" "df" "`stat'" "P>`stat'" "P>`stat'"
	}
	else {
		.`Tab'.titles	"" "df" "`stat'" "P>`stat'"
	}
	.`Tab'.sep
	_ms_eq_info
	local k_eq = r(k_eq)
	forval i = 1/`k_eq' {
		local eq`i' `"`r(eq`i')'"'
	}
	local oldeq = 0
	forval i = 1/`k' {
		if `hasdf2' {
			local ig = `group'[1,`i']
			if `ig' < 0 {
				continue
			}
		}
		local el 0
		if `i' == `k' & `overall' {
			.`Tab'.row "" "" "" "" `b5'
			local ttl "Overall"
		}
		else {
			local ttl
			local diopt joint
			if `noatlevels' & `info'[3,`i'] == 2 {
				continue
			}
			if `info'[3,`i'] == 1 {
				local diopt joint nolevel
			}
			else if `info'[3,`i'] == 3 {
				local ttl "Joint "
			}
			else if `info'[3,`i'] == 4 {
				if `noatlevels' {
					local diopt joint nolevel
				}
				else {
					local ttl "Joint "
				}
			}
			local eq = `info'[1,`i']
			if `eq' != `oldeq' {
				if `"`eq`eq''"' != "_" {
					if `eq' > 1 {
						.`Tab'.sep
					}
					_ms_eq_display, eq(`eq') width(`w1')
					di
				}
				local oldeq = `eq'
			}
			local el = `info'[2,`i']
			if `"`ttl'"' == "" {
				_ms_display,	width(`w1')		///
						eq(#`eq')		///
						el(`el')		///
						novbar			///
						`vsquish'		///
						`VSQUISH'		///
						`diopt'
			}
			else {
				local el 0
			}
			local VSQUISH
		}
		if missing(`X'[1,`i']) {
			.`Tab'.row "`ttl'" "  (not testable)" "" "" `b5'
		}
		else if `df'[1,`i'] == 0 {
			.`Tab'.row "`ttl'" "  (omitted)" "" "" `b5'
		}
		else {
			if `has_mcpv' {
				if `el' & `df'[1,`i'] == 1 {
					local mcpv `pvmat'[1,`el']
				}
				else {
					local mcpv `""""'
				}
			}
			.`Tab'.row	"`ttl'"		///
					`df'[1,`i']	///
					`X'[1,`i']	///
					`p'[1,`i']	///
					`mcpv'
		}
		if `hasdf2' & `i' < `k' {
			if `ig' != `group'[1,`i'+1] {
				local eq = `info'[1,`i'+1]
				local el = `info'[2,`i'+1]
				_ms_display,	width(`w1')		///
						eq(#`eq')		///
						el(`el')		///
						nolevel			///
						`vsquish'		///
						novbar			///
						joint
				.`Tab'.row	""			///
						`df2'[1,`i']		///
						"  (denominator)"	///
						""			///
						`b5'
				.`Tab'.sep
				if !`:length local vsquish' {
					local VSQUISH vsquish
				}
			}
		}
	}
	if `hasdf2' {
		local skip 1
		if `is_svy' {
			if `svy_adjust' {
				local skip 0
			}
			local ttl "Design"
		}
		else {
			local ttl "Residual"
		}
		if `skip' {
			.`Tab'.row "" "" "" "" `b5'
		}
		.`Tab'.row "`ttl'" `e(df_r)' "" "" `b5'
	}
	.`Tab'.sep, bottom
	.`Tab'.width_of_table
	if `mcwaldmsg' {
		di as txt "{p 0 6 0 `s(width)'}Note: " ///
		"`mctitle'-adjusted p-values are reported for tests on" ///
		" individual contrasts only.{p_end}"
	}
	if `svy_adjust' {
		di as txt "{p 0 6 0 `s(width)'}Note: " ///
		"F statistics are adjusted for the survey design.{p_end}"
	}
end

program CFindMinWidth, rclass
	args w info joint noatlevels
	if `:length local joint' {
		if "`e(group)'" == "matrix" {
			tempname group
			matrix `group' = e(group)
			local ig = `group'[1,1]
		}
	}
	local has_group : length local group
	local k = colsof(`info')
	local max 0
	forval i = 1/`k' {
		local levels 1
		local eq = `info'[1,`i']
		local el = `info'[2,`i']
		if `el' == 0 {
			continue
		}
		if `:length local joint' {
			if inlist(`info'[3,`i'], 2) & `noatlevels'{
				continue
			}
			if inlist(`info'[3,`i'], 1, 3) {
				local levels 0
			}
			if inlist(`info'[3,`i'], 4) & `noatlevels' {
				local levels 0
			}
			if `has_group' {
				local ig = `group'[1,`i']
				if `ig' < 0 {
					local levels 0
				}
			}
		}
		_ms_element_info, width(`w') eq(#`eq') el(`el') coding `joint'
		local loop = r(k_term)
		if `loop' {
			forval j = 1/`loop' {
				local len = strlen(`"`r(term`j')'"')
				if `max' < `len' {
					local max = `len'
				}
			}
		}
		else {
			local len = strlen(`"`r(term)'"')
			if `max' < `len' {
				local max = `len'
			}
		}
		if !`levels' {
			continue
		}
		local loop = r(k_level)
		if `loop' {
			forval j = 1/`loop' {
				local len = strlen(`"`r(level`j')'"') + 1
				if `max' < `len' {
					local max = `len'
				}
			}
		}
		else {
			local len = strlen(`"`r(level)'"') + 1
			if `max' < `len' {
				local max = `len'
			}
		}
	}
	if `max' < 12 {
		local max 12
	}
	if `max' > `w' {
		local max `w'
	}
	return scalar width = `max'
end

program Footnotes
	syntax [,	dydx(string)		///
			cieffects		///
			pveffects		///
			mcompare(passthru)	///
	]

	if "`s(width)'" != "" {
		local p "{p 0 6 0 `s(width)'}"
	}
	else {
		local p "{p 0 6 0}"
	}

	if `:length local dydx' & "`e(continuous)'" == "" {
		di as txt "`p'Note: " ///
"`dydx' for factor levels is the discrete change from the base level." ///
"{p_end}"
	}

	local ci : length local cieffects
	local pv : length local pveffects
	if "`e(cmd)':`e(group)'" == "contrast:matrix" {
		tempname g
		matrix `g' = e(group)
		matrix `g' = `g'*`g''
		if `g'[1,1] {
			if `ci' & `pv' {
				local msg ", pvalues, and confidence intervals"
			}
			else if `ci' {
				local msg " and confidence intervals"
			}
			else {
				local msg " and pvalues"
			}
			di as txt ///
"`p'Note: Standard errors`msg'"						///
" for individual contrasts are derived from the linear combination"	///
" of covariates."							///
" The '/' operator affects only the table of Wald statistics."		///
"{p_end}"
		}
	}

	if "`e(cmd)'" == "pwcompare" {
		_get_mcompare, `mcompare'
		local method `"`s(method)'"'
		local needbalanced duncan dunnett snk tukey
		if "`e(balanced)'" == "0" & `:list method in needbalanced' {
			if e(k_terms) == 1 {
				local factors "A factor was"
			}
			else {
				local factors "One or more factors were"
			}
			di as txt "`p'Note: " ///
"The `method' method requires balanced data for proper level coverage. " ///
"`factors' found to be unbalanced."
			di as txt "{p_end}"
		}
	}
end

exit
