*! version 1.0.0  13jul2011
program marginsplot
	version 11
	tempname results
	_return hold `results'
	_return restore `results' , hold
	capture nobreak noisily {
		_marginsplot `0'
	}
	local rc = _rc
	_return restore `results'
	if `rc' {
		exit `rc'
	}

end

program _marginsplot

	local maxticks  25			// max default x ticks
	local plotswrap 15			// unique plot definitions

	tempfile filenm					// Save margins file
	capture _marg_save , saving(`filenm')
	if _rc == 301 {
		di as error "previous command was not {cmd:margins}"
		exit 301
	}
	else if _rc {
		capture erase `filenm'
		_marg_save , saving(`filenm')
	}

	preserve					// Use margins file
	qui use `filenm', clear

	if _N == 1 & _margin[1]== 0 & _ci_lb[1]==0 {
		di as text "  No margins, nothing to plot"
		exit
	}

	char _atopt[varname] "_atopt"
	char _term[varname] "_term"
	char _deriv[varname] "_deriv"
	char _margin[varname] "y"

							// Parse
		// Production notes: dimension options allow plurals but are
		// documented as singular.  Same for option recastcis. option
		// byoptions allowed, but undocumented.

	syntax [, Xdimensions(string asis)				///
		  PLOTdimensions(string asis)				///
		  BYdimensions(string asis) 				///
		  GRaphdimensions(string asis)				///
		  ALLXlabels						///
		  NOLABels						///
		  SEParator(string)					///
		  NOSEParator						///
		  ALLSIMplelabels					///
		  NOSIMplelabels					///
		  recast(string)					///
		  RECASTCIs(string)					///
		  NOCI							///
		  BYOPts(string asis)					///
		  BYOPTIONs(string asis)				///
		  HORIZontal						///
		  NAME(string asis)					///
		  UNIQue						///
		  CSORT							///
		  PCYCle(integer -999)					///
		  ADDPLOT(string asis)					///
		  saving(string asis)					///
		  *							///
		]

	local byoptions `"`macval(byoptions)' `macval(byopts)'"'

	if "`allsimplelabels'" != "" & "`nosimplelabels'" != "" {
	   di as error "may not specify both allsimplelabels and nosimplelabels"
	   exit 198
	}
	local simple = 0 + ("`allsimplelabels'" != "") +		///
		       2 * ("`nosimplelabels'" != "")

	if "`noseparator'" != "" {			// Overall separator
		local sep ""
	}
	else {
		local sep = cond(`"`separator'"'=="", ", ", `"`separator'"')
	}

							// Plot style cycling
	if (`pcycle' != -999) {
		if (`pcycle' <= 0)  local pcycle 1
		local plotswrap `pcycle'
	}


	CheckRecast   `recast'
	CheckRecastCI `recastcis'

	local nolabels = "`nolabels'" != ""

	local defaults `"`nolabels' `simple' `"`sep'"'"'

							// drop derivs for bases
	qui drop if _margin==0 & _ci_lb==0 & _ci_ub==0 & _se==0

	if "`_dta[cmd]'" == "pwcompare" {		// manage pwcompare data
		tempvar pwstr vsbeg termstr
		qui decode _pw, gen(`pwstr')

		qui gen int `vsbeg' = strpos(`pwstr', "vs")
		qui gen str _pw1s = substr(`pwstr', 1, `vsbeg'-2)
		qui gen str _pw0s = substr(`pwstr', `vsbeg'+3, .)

		if "`unique'" == "" {
		    tempvar hold
		    qui expand 2
		    sort _term _pw0 _pw1
		    quietly {
			by _term _pw0 _pw1:  replace _margin = -_margin if _n==2
			by _term _pw0 _pw1:  replace _ci_lb  = -_ci_lb  if _n==2
			by _term _pw0 _pw1:  replace _ci_ub  = -_ci_ub  if _n==2
			by _term _pw0   _pw1:  gen str `hold' = _pw0
			by _term _pw0   _pw1:  replace _pw0   = _pw1   if _n==2
			sort _term `hold' _pw1
			by _term `hold' _pw1:  replace _pw1   = `hold' if _n==2
		    }
		}


		qui encode _pw0s, gen(_pw0) label(pw0lbl)
		qui encode _pw1s, gen(_pw1) label(pw1lbl)

		qui decode _term, gen(`termstr')
		drop _pw
		sum _term, meanonly
		if r(min) == r(max) {
		    qui gen str _pws = _pw1s + " vs " + _pw0s
		}
		else {
		    qui gen str _pws = `termstr' + ": " + _pw1s + " vs " + _pw0s
		}
		if "`csort'" == "" {
			sort _term _pw0s _pw1s
		} 
		else {
			sort _term _pw1s _pw0s
		}
		forvalues i = 1/`=_N' {
			local pwlbl `"`pwlbl' `i' `"`=_pws[`i']'"'"'
		}
		label define pwlbl `pwlbl'
		qui encode _pws, gen(_pw) label(pwlbl)
		label var _pw "Comparisons"
		char _pw[varname] "_pw"
		char _pw0[varname] "_pw0"
		char _pw1[varname] "_pw1"
		drop _pws _pw0s _pw1s
	}

	ParseDim x  : `defaults' `xdimensions'		// Parse dimension 
	ParseDim pl : `defaults' `plotdimensions'	// variables and options
	ParseDim by : `defaults' `bydimensions'			
	ParseDim gr : `defaults' `graphdimensions'

						// Find/Report dimensions
	if "`_dta[cmd]'" == "pwcompare" {
		if "`unique'" == "" {
			local dimlist "_pw1 _pw0 _term"
		}
		else {
			local dimlist "_pw _term"
		}
	}
	else	ValuesAtsMsBysRest  dimlist

	local ulist 
	foreach var of local dimlist {
		sum `var', meanonly
		if (r(min) == r(max)) continue
		if "`ulist'" != "" {
			capture by `ulist' (`var'), sort:		///
				assert `var'[1] == `var'[_N]
			if (!_rc) continue
		}
		local ulist `ulist' `var'
		capture by `ulist', sort : assert _N == 1
		if (!_rc) continue, break
	}

	di ""
	ToVarnames ulist : `ulist'
	di in smcl "{text}{p 2 6 2}Variables that uniquely identify "	///
		   "margins: `ulist'{p_end}"
	if "`_dta[cmd]'" == "pwcompare" {
	  di ""
	  di in smcl "{text}{p 6 10 2}_pw enumerates all pairwise "	///
	  	"comparisons; _pw0 enumerates the reference "		///
		"categories; _pw1 enumerates the comparison categories.{p_end}"
	}
	local ats : char _dta[k_at]
	if 0`ats' > 1 {
		di in smcl "{text}  Multiple at() options specified:"
		if `ats' < 10 {
			local fmt "%1.0f"
		}
		else if `ats' < 100 {
			local fmt "%2.0f"
		}
		else {
			local fmt "%4.0f"
		}
		forvalues i = 1/`ats' {
			local is = strofreal(`i', "`fmt'")
			di in smcl "{text}{p 6 10 2}_atoption=`is': "	///
				   "`:char _dta[atopt`i']'{p_end}"
		}
	}


						// Set dimensions
	local speclist
	foreach dim in x pl by gr {
		local speclist `speclist' ``dim'list'
	}
	local trylist : list dimlist - speclist

	local uslist `speclist'
	foreach var of local trylist {
		sum `var', meanonly
		if (r(min) == r(max)) continue
		if "`uslist'" != "" {
			capture by `uslist' (`var'), sort:		///
				assert `var'[1] == `var'[_N]
			if (!_rc) continue
		}
		local uslist `uslist' `var'
		capture by `uslist', sort : assert _N == 1
		if (!_rc) continue, break
	}
	local addlist : list uslist - speclist

	if `:list sizeof uslist' > 0 {
		capture by `uslist', sort : assert _N == 1
		if _rc {
			di `"uslist :`uslist':"'
			di in red "_marg_save has a problem.  Margins "	///
				  "not uniquely identified."
			exit 9999
		}
	}

	if "`_dta[cmd]'" == "pwcompare" {
		if "`speclist'" == "" {
			local t "_term"
			if `:list t in addlist' {
				local grlist "_term"
				local addlist : list addlist - t
			}
		}
	}

	if "`xlist'" == "" {
		gettoken xlist addlist : addlist
	}

	if "`pllist'" == "" {
		local pllist `addlist'
		local addlist ""
	}
	else if "`bylist'" == "" {
		local bylist `addlist'
		local addlist ""
	}
	else if "`grlist'" == "" {
		local grlist `addlist'
		local addlist ""
	}
	else if `:list sizeof addlist' > 0 {
		local pllist `pllist' `addlist'
		di in smcl "{text}{p 2 6 2}Dimension options do not "	///
		           "specify all variables required to "		///
			   "uniquely identify margins.  Variables "	///
			   "`addlist' included in plotdimension()."
	}


							// Better labels
	if "`_dta[cmd]'" == "pwcompare" {
		char _pw[varname]  "Comparisons"
		char _pw0[varname] "Reference category"
		char _pw1[varname] "Comparison category"
	}

							// Make dimensions

	char _atopt[varname] "at()"
	char _term[varname]  "term"
	char _deriv[varname] "Effects with Respect to"
	foreach dim in x pl by gr {
		local ndim : list sizeof `dim'list

		tempvar `dim'var
		tempname `dim'lab
		MakeDim  ``dim'var' ``dim'lab' `dim'contx :		///
			 `dim' `"`macval(`dim'sep)'"' ``dim'simple'	///
			 ``dim'nolabels' `"`macval(`dim'labs)'"'	///
			 `"`macval(`dim'elabs)'"' : ``dim'list'
	}

							// Build graph command

	sum _deriv , meanonly
	local derivs = r(min) < .
	if r(min) < . {
		local is_derivs 1
		if r(min) == r(max) {
			local termnm : label (_deriv) `=_deriv[1]'
		}
	}
	else {
		sum _term , meanonly
		if r(min) == r(max) {
			local termnm : label (_term) `=_term[1]'
		}
	}
	local citype = cond("`recastcis'" == "", "rcap", "`recastcis'")
	local title = proper(`"`: char _dta[title]'"')
	local title : subinstr local title " Of " " of "
	if `"`termnm'"' != `""' & `"`termnm'"' != `"_cons"' {
		local title `"`title' of `termnm'"'
	}
	local ytitle = proper(`"`: char _dta[predict_label]'"')
	if `"`macval(ytitle)'"' == `""' {
		local ytitle : char _dta[expression]
	}
	local pct : word 1 of `:var label _ci_lb'
	if "`_dta[cmd]'" == "pwcompare" {
		local pfx "Comparisons of "
	}
	else if "`_dta[cmd]'" == "contrast" {
		local pfx "Contrasts of "
	}
	else if `derivs' {
		local pfx "Effects on "
	}
	label var _margin `"`pfx'`ytitle'"'
	label var _ci_lb `"`pfx'`ytitle'"'
	label var _ci_ub `"`pfx'`ytitle'"'

	local pltype0 "connected"
	if "`horizontal'" == "" {
		local vlist _margin `xvar'
/*
		local pltype0 = cond("`_dta[cmd]'" == "margins", 	///
				     "connected", "scatter")
*/
		local pltype = cond("`recast'" == "", "`pltype0'", "`recast'")
	}
	else {
		local vlist `xvar' _margin
// 		local pltype0 "scatter"
		local pltype = cond("`recast'" == "", "`pltype0'", "`recast'")
		local angle ", angle(0)"
		if `=inlist("`pltype'",					///
		             "area", "bar", "spike", "dropline", "dot")' {
			local vlist _margin `xvar'
			local horizopt "horizontal"
		}
	}

	if _N == 1 {					// one margin
		label var `xvar' " "
		tempname xvlab
		if `"`termnm'"'==`"_cons"' {
			label define `xvlab' 1 "Overall"
		}
		else {
			label define `xvlab' 1 " "
		}
		label values `xvar' `xvlab'
	}

	local xy = cond("`horizontal'" == "", "x", "y")
//	local xvlab = cond(`xnolabels', "", "`xy'label(, valuelabels)")
	local xvlab "`xy'label(, valuelabels)"
	if "`_dta[cmd]'" == "pwcompare" {
		if "`pllist'" == "_pw1" {
			local legtitle `"title("Comparison category")"'
		}
		else if "`pllist'" == "_pw0" {
			local legtitle `"title("Reference category")"'
		}
	}

	if `"`addplot'"' != `""' {		// addplot() and order()
		local draw "nodraw"		// skip, Must draw to make top
		_parse expand addplot below : addplot , common(BELOW)

		if "`below_op'" == "below" {
			forvalues i = 1/`addplot_n' {
				local order `"`macval(order)' `i'"'
			}
			local addplot_offset = `addplot_n'
		}
	}
	else	local addplot_offset = 0

	capture des , varlist
	local allvars `r(varlist)'

	local 0 `", `options'"'
	syntax [, PLOTOPts(string asis) * ]
	FixPlotOpt plotopts : `macval(plotopts)'
	local 0 `", `options'"'
	syntax [, CIOPts(string asis) * ]
	FixPlotOpt ciopts : `macval(ciopts)'

	local k0 = 0 + 0`addplot_offset'
	local i = 0
	sum `plvar' , meanonly
	local k_pl = r(max)
	local sep ""

	if "`noci'" == "" {				// CI plots
		forvalues i = 1/`k_pl' {
			local pstyle = mod(`i'-1, `plotswrap') + 1
			local plif "if `plvar' == `i'"

			local 0 `", `options'"'
			syntax [, CI`i'opts(string asis) * ]
			FixPlotOpt ci`i'opts : `macval(ci`i'opts)'
			local ci `"`sep'`citype' _ci_lb _ci_ub `xvar' `plif', pstyle(p`pstyle') `horizontal' `ciopts' `ci`i'opts'"'
			local sep "|| "

			local ciplots `"`ciplots' `ci' "'
		}

		local k0 = `k_pl' + 0`addplot_offset'

		local title `"`title' with `pct' CIs"'
	}

	if ("`pltype'" == "area" || "`pltype'" == "bar") {
		local k0 = 0 + 0`addplot_offset'
	}

	local sep ""
	forvalues i = 1/`k_pl' {			// margin plots
		local i1 = `i' - 1
		local pstyle = mod(`i1', `plotswrap') + 1
		if `pcycle' == -999 {
			if floor(`i1' / `plotswrap') == 1 {
				local symopt "symbol(triangle)"
			}
			else if floor(`i1' / `plotswrap') == 2 {
				local symopt "symbol(square)"
			}
			else if floor(`i1' / `plotswrap') == 3 {
				local symopt "symbol(diamond)"
			}
			else if floor(`i1' / `plotswrap') == 4 {
				local symopt "symbol(x)"
			}
			else if floor(`i1' / `plotswrap') == 5 {
				local symopt "symbol(plus)"
			}
		}

		local plif "if `plvar' == `i'"

		local 0 `", `options'"'
		syntax [, PLOT`i'opts(string asis) * ]
		FixPlotOpt plot`i'opts : `macval(plot`i'opts)'
		local plot `"`sep'`pltype' `vlist' `plif', pstyle(p`pstyle') `symopt' `horizopt' `plotopts' `plot`i'opts'"'
		local sep "|| "

		local order `"`macval(order)' `=`k0'+`i'' `"`:label (`plvar') `i''"'"'

		local mplots `"`mplots' `plot'"'
	}

	local sep = cond("`noci'" == "", "||", "")
	if ("`pltype'" == "area" || "`pltype'" == "bar") {
		local graph `"twoway `mplots' `sep' `ciplots'"'
	}
	else {
		local graph `"twoway `ciplots' `sep' `mplots'"'
	}

	if `"`addplot'"' != `""' {
		local ka = `k_pl' + ("`noci'"=="")*`k_pl'
		if "`below_op'" != "below" {
			forvalues i = 1/`addplot_n' {
				local order `"`macval(order)' `=`ka'+`i''"'
			}
		}
	}


	if (`k_pl' < 2 & `"`addplot'"' == `""') {
		local legend "legend(off)"
		local bylegend "legend(off)"
	}
	else {
		local legend `"legend(order(`macval(order)') `legtitle')"'
	}



							// Draw graphs
	sort `xvar'
	sum `grvar' , meanonly
	local n_gr = r(max)
	if `n_gr' > 1 {
		if `"`name'"' == `""' {
			local name "name(_mp_\`i', replace)"
		}
		else {
			local 0 `name'
			syntax [anything] [, replace]
			local name `"name(`anything'\`i', `replace')"'
		}

		if `"`saving'"' != `""' {
			local hold `macval(options)'
			local 0 `macval(saving)'
			syntax [anything] [, *]
			local saving `"saving(`anything'\`i', `options')"'
			local options `macval(hold)'
		}
	}
	else {
		local name `"name(`name')"'
		local saving `"saving(`macval(saving)')"'
	}

	if `"`addplot'"' != `""' {
		local saveadd `macval(saving)'
		local saving ""
	}

	local titleopt `"title(`"`title'"', span size(*.9))"'
	tempfile marginsdata

	forvalues i = 1/`n_gr' {
		qui levelsof `xvar'
		local levs `r(levels)'
		sum `xvar' if `grvar' == `i', meanonly
		if !`xcontx' & (0`r(max)' < `maxticks' | "`allxlabels'" != "") {
			local xlabopt "`xy'label(1(1)0`r(max)' `angle')"
		}
		else if (`:list sizeof levs' < `maxticks') {
			local xlabopt "`xy'label(`levs' `angle')"
		}
		else if `"`angle'"' != `""' {
			local xlabopt "`xy'label(`angle')"
		}
		if `n_gr' > 1 {
		    local subtitleopt `"subtitle(`"`: label (`grvar') `i''"', span)"'
		}
		if ("`bylist'" != "") {
			local by `"by(`byvar' , title(`"`macval(title)'"') `macval(subtitleopt)' note("") `bylegend' `macval(byoptions)')"'
			local titleopt ""
			local subtitleopt ""
		}
		`graph' || if `grvar' == `i' , `titleopt' `subtitleopt'	///
			   `xlabopt' `xvlab' `macval(legend)' 		///
			   /*`draw'*/ `name' `saving' `by' `macval(options)'

		if `"`addplot'"' != `""' {
			qui save `"`marginsdata'"', replace
			restore, preserve
			graph addplot || , `macval(legend)' `saveadd' || ///
				`addplot' 
			qui use `marginsdata', replace
		}
	}


end

program ParseDim
	gettoken pfx      0 : 0
	gettoken colon    0 : 0
	gettoken nolabdef 0 : 0
	gettoken simpdef  0 : 0
	gettoken sepdef   0 : 0

	syntax [anything] [, 						///
		  SEParator(string)					///
		  NOSEParator						///
		  LABels(string asis)					///
		  ELABels(string asis)					///
		  ALLSIMplelabels					///
		  NOSIMplelabels					///
		  NOLABels						///
		]

	if "`allsimplelabels'" != "" & "`nosimplelabels'" != "" {
	   di as error "may nots specify both allsimplelabels and nosimplelabels"
	   exit 198
	}
	local simple = 0 + ("`allsimplelabels'" != "") +		///
		       2 * ("`nosimplelabels'" != "")

						// Make and check varlist
	Ats                atlist
	MsBysValuesAtsRest truelist
	MsBysAtsRest       fulllist
	local vlist ""
	foreach tok of local anything {
		if strpos(`"`tok'"', "at(") {
			local 0 , `tok'
			capture syntax , at(string)
			if _rc {
			    di as error "invalid dimension specification: `tok'
			    exit 198
			}
			FindVar var : `at' 1 `atlist'
		}
		else {
			FindVar var : `tok' 0 `truelist'
			if "`var'" == "" {
				FindVar var : `tok' 1 `fulllist'
			}
		}
		local vlist `vlist' `var'
	}

	c_local `pfx'list `vlist'

							// Save options
	if "`noseparator'" != "" {
	   local sep ""
	}
	else {
	   local sep = cond(`"`separator'"'==`""', `"`sepdef'"',`"`separator'"')
	}

	c_local `pfx'sep   `"`macval(sep)'"'
	c_local `pfx'labs  `"`macval(labels)'"'
	c_local `pfx'elabs `"`macval(elabels)'"'
	c_local `pfx'simple = cond(`simple', `simple', `simpdef')
	c_local `pfx'nolabels = cond("`nolabels'" != "", 1, `nolabdef')
end

program Ats
	args target 

	capture des _at* , varlist
	local list `r(varlist)'
	local list : subinstr local list "_at" ""
	local list : subinstr local list "_atopt" ""

	c_local `target' `list'
end

program ValuesAts			// Keep only ats with multiple values
	args target

	local i = 1
	while 1 {
		local atstats : char _dta[atstats`i++']
		if ("`atstats'" == "") continue, break

		local j 1
		foreach stat of local atstats {
			if "`stat'" == "values" {
				local atlist `atlist' _at`j'
			}
			local ++j
		}
	}
	local atlist : list uniq atlist

					// Put in order specified in at options
	local atorder `_dta[_u_at_vars]'
	foreach tok of local atorder {
		if `: list tok in atlist' {
			local atlistord `atlistord' `tok'
		}
	}

	c_local `target' `atlistord' 
end

program Ms
	args target 

	capture des _m*  , varlist
	local list `list' `r(varlist)'
	local list : subinstr local list "_margin" ""

	c_local `target' `list'
end

program Bys
	args target 

	capture des _by* , varlist

	c_local `target' `r(varlist)'
end

program Rest
	args target

	local list
	foreach v in _atopt _term _deriv _pw _pw0 _pw1 {
		capture confirm variable `v'
		if !_rc {
			local list `list' `v'
		}
	}

	c_local `target' `list'
end

program ValuesAtsMsBysRest
	args target

	ValuesAts atlist
	Ms        mlist
	Bys       bylist
	Rest      restlist

	c_local `target' `atlist' `mlist' `bylist' `restlist'
end

program AtsMsBysRest
	args target 

	Ats  list
	Ms   mlist
	Bys  bylist
	Rest restlist

	c_local `target' `atlist' `mlist' `bylist' `restlist'
end

program MsBysValuesAtsRest 
	args target

	ValuesAts atlist
	Ms        mlist
	Bys       bylist
	Rest      restlist

	c_local `target' `mlist' `bylist' `atlist' `restlist'
end

program	MsBysAtsRest
	args target 

	Ats  list
	Ms   mlist
	Bys  bylist
	Rest restlist

	c_local `target' `mlist' `bylist' `atlist' `restlist'
end

program CheckRecast

	if `:word count `0'' > 1 {
		di as error `"recast(`0') not allowed"'
		exit 198
	}

	local a `"`0'"'
	local 0 `", `0'"'
	capture syntax [, scatter line connected area bar spike dropline dot ]
	if _rc {
		di as error `"recast(`a') not allowed"'
		exit 198
	}
end

program CheckRecastCI

	if `:word count `0'' > 1 {
		di as error `"recast(`0') not allowed"'
		exit 198
	}

	local a `"`0'"'
	local 0 `", `0'"'
	capture syntax [, rscatter rline rconnected rarea rbar rspike	///
			  rcap rcapsymdropline ]
	if _rc {
		di as error `"recast(`a') not allowed"'
		exit 198
	}
end


program FindVar 
	gettoken varmac 0 : 0
	gettoken colon  0 : 0
	gettoken nm     0 : 0
	gettoken report 0 : 0

	local nm : tsnorm `nm' , varname

	foreach var of local 0 {
		if `"`nm'"' == `"`: char `var'[varname]'"' {
			local fvar `var'
			continue, break
		}
	}

	if `"`fvar'"' == `""' {
		if `report' == 1 {
		    di as error "`nm' not a dimension in {cmd:margins} results"
		    exit 322
		}
		else if `report' == 2 {
		    local fvar `nm'
		}
	}

	c_local `varmac' `fvar'
end

program ToVarnames
	gettoken macnm 0 : 0
	gettoken colon 0 : 0

	foreach var of local 0 {				// non ats
		if substr("`var'",1,3) != "_at" {
			local nats `nats' ``var'[varname]'
		}
	}

	foreach var of local 0 {				// map names
		if substr("`var'",1,3) == "_at" {
			local varnm ``var'[varname]'
			if `:list varnm in nats' {
				local list `"`list' at(``var'[varname]')"'
			}
			else {
				local list `list' ``var'[varname]'
			}
		}
		else {
			local list `list' ``var'[varname]'
		}
	}

	c_local `macnm' `list'

end


program MakeDim
	gettoken dimvar  0 : 0
	gettoken dimlab  0 : 0
	gettoken contx   0 : 0
	gettoken colon   0 : 0
	gettoken dim     0 : 0
	gettoken sep     0 : 0
	gettoken simple  0 : 0
	gettoken nolab   0 : 0
	gettoken labels  0 : 0
	gettoken elabels 0 : 0
	gettoken colon   0 : 0

	local 0 `0'
	local k : list sizeof 0

	c_local `contx' 0

	if `k' == 0 {					// No variables
		qui gen byte `dimvar' = 1
		label var `dimvar' "No `dim' dimension"

		exit						// Exit
	}

	tempvar tag revtag
	qui by `0', sort: gen byte `tag' = _n==1
	qui gen byte `revtag' = !`tag'


	sort `revtag' `0'				// Dim variable
	if (`k' == 1 & "`dim'" == "x" & `simple' != 2) {
		qui clonevar `dimvar' = `0'
	}
	else	qui gen long `dimvar' = _n if `tag'

	if ! (`k' == 1 & (						    ///
	   (substr("`0'",1,3) == "_at" & "`0'"!="_at" & "`0'"!="_atopt") |  ///
	   (substr("`0'",1,2) == "_m"  & "`0'"!="_margin") |		    ///
	   (substr("`0'",1,3) == "_by") ) ) {
	     forvalues i=1/`k' {			// variable label
		local msep = cond(`i'==1, "", `"`sep'"')
		local lab `"`lab'`msep'`:char `:word `i' of `0''[varname]'"'
	     }
	     label variable `dimvar' `"`lab'"'
	}

/*
	if `k' == 1 & (							    ///
	   (substr("`0'",1,3) == "_at" & "`0'"!="_at" & "`0'"!="_atopt") |  ///
	   (substr("`0'",1,2) == "_m"  & "`0'"!="_margin") |		    ///
	   (substr("`0'",1,3) == "_by") ) {
		label var `dimvar' `"`:var label `0''"'
	}
*/
	if (`k' == 1 & "`dim'" == "x" & `simple' != 2) {
		if (`nolab')  label values `dimvar'
		c_local `contx' 1
		exit						// Exit
	}

	qui count if `tag'				// value labels
	forvalues i = 1/`=r(N)' {
		local lab ""
		local j 0
		foreach var of local 0 {
			if `++j' > 1 {
				local lab `"`lab'`sep'"'
			}

			local iscontrast = "`:char _dta[cmd]'" == "contrast"
			local ism = substr("`var'",1,2) == "_m"
			local islabeled =				///
			      ("`:value label `var''" != "") &		///
			      !`nolab'
			local olab = `islabeled' & ! (`iscontrast' & `ism')
			if `simple' == 2 | 				///
			   (`simple' == 0 & 				///
			   (!`olab' & (`k' > 1 | "`dim'" != "x"))) {
				if `iscontrast' & `ism' {
				     local lab `"`lab'`:char `var'[varname]': "'
				}
				else local lab `"`lab'`:char `var'[varname]'="'
			}

			if `nolab' {
				local value = 				///
				      strofreal(`var'[`i'], "`:format `var''")
			}
			else if `var'[`i'] >= . {
				local value : label (_atopt) `=_atopt[`i']'
				if `"`value'"' == `"."' {
					local value "asobserved"
				}
				else if `"`value'"' == 			///
					`"(mean) _factor (mean) _continuous"' {
					local value "(mean)"
				}
			}
			else {
				if `islabeled' {
				      local value : label (`var') `=`var'[`i']'
				}
				else {
				      local value = 			///
					strofreal(`var'[`i'], "`:format `var''")
				}
			}
			local lab `"`lab'`value'"'
		}
		label define `dimlab' `i' `"`lab'"' , add
	}

	if `"`labels'"' != `""' {
		label drop `dimlab'
		local i 0
		foreach lab of local labels {
			label define `dimlab' `++i' `"`macval(lab)'"' , add
		}
	}

	if `"`elabels'"' != `""' {
		label define `dimlab' `macval(elabels)' , modify
	}

	label values `dimvar' `dimlab'

	qui by `0' (`tag'), sort:  replace `dimvar' = `dimvar'[_N]


end

program FixPlotOpt 
	gettoken plotopt  0    : 0
	gettoken colon    opts : 0

	local 0 `", `macval(opts)'"'
	syntax [, mlabel(string asis) *]

	if "`mlabel'" == "" {
		c_local `plotopt' `"`macval(opts)'"'
		exit
	}

	capture des , varlist
	local allvars `r(varlist)'
	foreach nm of local mlabel {
		FindVar var : `nm' 2 `allvars'
		local vlist `vlist' `var'
	}

	c_local `plotopt' mlabel(`vlist') `macval(options)'
end

exit

// Order preference:  

	_userlist_ _at#s _m#s _by#s _atopt _term _deriv

