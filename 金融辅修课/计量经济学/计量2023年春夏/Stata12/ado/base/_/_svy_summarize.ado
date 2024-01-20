*! version 1.5.0  16may2011
program _svy_summarize, eclass
	version 9

	if (!replay()) local cmdline : copy local 0
	gettoken cmd 0 : 0

	quietly syntax [anything] [if] [in] [fw pw iw aw] [, VCE(passthru) *]
	if `:length local vce' {
		`version' `BY' _vce_parserun `cmd', noeqlist : `0'
		if "`s(exit)'" != "" {
			ereturn local cmdline `"`cmdline'"'
			exit
		}
	}

	if replay() {
		is_svysum `e(cmd)'
		if !r(is_svysum) | `"`e(cmd)'"' != `"`cmd'"' {
			error 301
		}
		_prefix_display `0'
	}
	else {
		Estimate `cmd' `0'
		ereturn local cmdline `"`cmdline'"'
	}
end

program Estimate, eclass
	gettoken cmd 0 : 0

	is_svysum `cmd'
	if !r(is_svysum) {
		di as err "unrecognized command: `cmd'"
		exit 199
	}
	local wt "[fw pw iw aw]"
	if inlist("`cmd'","prop","proportion") {
		local propopts MISSing NOLABel
		local type mean
		local cmd proportion
		local wt "[fw pw iw]"
	}
	else	local type `cmd'
	local typeopt type(`type')

	if "`cmd'" == "ratio" {
		ParseRatio names 0 : `0'
		local wt "[fw pw iw]"
	}
	syntax [varlist(numeric)]		///
		[if] [in] `wt' [,		///
		SVY				///
		`propopts'			/// -proportion- opts
		Level(cilevel)			/// -_prefix_display- opts
		COEFLegend			///
		SELEGEND			///
		cformat(passthru)		///
		NOLSTRETCH			///
		noLegend			///
		noHeader			///
		noTable				///
		over(passthru)			///
		sovar(varname numeric)		/// undocumented
		FIRSTCALL			/// undocumented
		SUBpop(passthru)		///
		STDize(varname)			///
		STDWeight(varname numeric)	///
		noSTDRescale			///
		CLuster(passthru)		///
		VCE(passthru)			///
		NOVARiance			/// undocumented
		ZEROweight			///
		NOIsily				/// ignored
		TRace				/// ignored
		noDOTS				/// ignored
		dof(passthru)			///
	]

	if "`svy'" == "" & `"`subpop'"' != "" {
		di as err "option subpop() not allowed"
		exit 198
	}

	// vce(linearized) is the default for -ratio-
	// vce(analytic) is the default for the others
	if "`type'" == "ratio" {
		local vcespec LINEARized
	}
	else	local vcespec ANALYTIC
	_vce_parse, argopt(CLuster) opt(`vcespec') pw(linearized) old	///
		: [`weight'`exp'], `vce' `cluster'
	local cluster `r(cluster)'
	local vce = cond("`r(vce)'" != "", "`r(vce)'", lower("`vcespec'"))

	if "`svy'" != "" & "`cluster'" != "" {
		di as err "option cluster() is not allowed with svy"
		exit 198
	}

	local subopts `"`over' `subpop'"'

	local wt	// clear -wt- for call to _svy2
	local wtype	`weight'
	local wexp	`"`exp'"'
	if "`weight'" == "fweight" {
		local wt "[iweight`exp']"
	}
	else if "`weight'" == "aweight" {
		tempvar wvar
		quietly gen double `wvar' `exp'
		local wt "[pweight=`wvar']"
	}
	else if "`weight'" != "" {
		local wt "[`weight'`exp']"
	}

	// check syntax
	_get_diopts ignore
	_get_diopts diopts, `coeflegend' `selegend' `cformat' `nolstretch'
	local diopts : list diopts - ignore
	local diopts	level(`level')	///
			`legend'	///
			`header'	///
			`table'		///
			`diopts'

	local uvarlist `varlist'
	if "`cmd'" != "ratio" {
		local names `varlist'
	}
	if "`missing'" != "" {
		local novarlist novarlist
	}

	// temp matrices
	tempname b
	if "`novariance'" == "" {
		tempname V Vsrs
	}

	if "`weight'" == "iweight" | "`svy'`zeroweight'" != "" {
		local zero zeroweight
	}
	if "`stdize'" != "" || "`stdweight'" != "" {
		local stdopts ///
		stdize(`stdize') stdweight(`stdweight') `stdrescale'
	}

	if "`cmd'" == "proportion" {
		marksample touse, novarlist `zero'
		local names
		local i 0
		tempname matrow myerror mycumerr
		local matrowopt matrow(`matrow')
		if "`sovar'" != "" {
			sum `sovar', mean
			local n_over `r(max)'
			if "`over'" != "" {
				local noint noint
			}
		}
		else if "`over'" != "" {
			// make sure column names are valid names, don't even
			// allow nonnegative integers
			local noint noint

			// get the number of over groups
			tempvar subuse
			quietly _svy_subpop `touse' `subuse', ///
				`over' `subpop'
			sum `subuse', mean
			local n_over `r(max)'
			local lab : value label `subuse'
			if "`lab'" != "" {
				label drop `lab'
			}
			drop `subuse'
		}
		else	local n_over 1

		preserve, changed
		local j 1
		foreach y of local varlist {
			local ++i
			tempvar yi
			capture noisily quietly			///
				tabulate `y' `if' `in',		///
				gen(`yi') `missing' `matrowopt'
			if c(rc) {
				di as err "too many categories"
				exit `c(rc)'
			}
			unab yilist : `yi'*
			local n_tvars = `n_tvars' + `: word count `yilist''
			local vlist `vlist' `yilist'
			local n_cat : word count `yilist'
			if `n_cat' > 400 {
				// too many categories
				error 149
			}
			if "`over'" != "" {
				local namelist `plabels'
			}
			_labels2names `y' `if' `in',	///
				index(`j') `nolabel'	///
				stub(_prop_) `missing'	///
				namelist(`namelist')	///
				`noint'			///
				// blank
			local j `s(indexfrom)'
			local names`i' `s(names)'
			local plabels `plabels' `names`i''
			local label`i' `"`s(labels)'"'
			Duplicate dup `n_cat' "`y' "
			local names `names' `dup'
		}
		local rc 0
		if c(k) + (`n_over'-1)*`n_tvars' > c(max_k_current) {
			local rc 900
		}
		if `n_over'*`n_tvars' > c(max_matsize) {
			local rc 902
		}
		if `n_over'*`n_tvars' > c(matsize) {
			local rc 908
		}
		if `rc' != 0 {
			di as err "too many categories"
			exit `rc'
		}
		local varlist `vlist'
	}
	else	tempvar touse

	// WARNING: do not change sort order prior to calling _svy2; the
	// -subpop()- option takes the -in- option.

	if "`svy'" == "" {
		if "`type'" == "total" {
			local typeopt type(mean)
		}
	}

	if "`sovar'" != "" {
		local sovar sovar(`sovar') `firstcall'
	}

	// Point and variance estimation
	_svy2 `varlist' `wt' `if' `in',		///
		`typeopt'			///
		`svy' `zero'			///
		touse(`touse')			///
		b(`b')				///
		`vopt'				///
		v(`V')				///
		cluster(`cluster')		///
		vsrs(`Vsrs')			///
		`subopts'			///
		`sovar'				///
		`stdopts'			///
		`dof'				///
		// blank
	local over_namelist	`"`r(over_namelist)'"'

	tempname osub nsub
	matrix `osub' = r(_N)
	matrix `nsub' = r(_N_subp)
	local over_N `osub' `nsub'
	if "`svy'" != "" & "`novariance'" == "" {
		if "`r(poststrata)'`stdize'" == "" {
			if "`r(fpc1)'" != "" {
				local Vsrswr `Vsrs'_wr
			}
			if `"`subpop'`over'"' != "" {
				local Vsrssub `Vsrs'sub
				if "`r(fpc1)'" != "" {
					local Vsrssubwr `Vsrs'sub_wr
				}
			}
		}
		else {
			local Vsrs
		}
	}
	if "`svy'" == "" {
		if "`type'" == "total" {
			if "`wtype'" == "aweight" {
				srsTotal `b' `osub'
			}
			else {
				srsTotal `b' `nsub'
			}
		}
		if "`novariance'" == "" {
			if "`wtype'" != "pweight" & "`cluster'" == "" {
				matrix drop `V'
				if "`over'" == "" {
					local V `Vsrs'
				}
				else {
					local V `Vsrs'sub
				}
				if "`cmd'" != "mean" & "`wtype'" != "iweight" {
					local Vsrs
				}
			}
			if "`type'" == "total" {
				if "`wtype'" == "aweight" {
					CompTvar `V' `osub'
				}
				else {
					CompTvar `V' `nsub'
				}
			}
			if "`cluster'" == "" ///
			 & inlist("`wtype'","fweight","iweight") {
				AdjV `V' `osub' `nsub'
			}
		}
	}

	if "`cmd'" != "proportion" {
		LabelMatrices ///
			`b' `V' `Vsrs' `Vsrssub' `Vsrswr' `Vsrssubwr' ///
			`over_N' : `names' : `over_namelist'
	}
	else {
		tempname error
		matrix `error' = r(error)
		forval i = 1/`=colsof(`error')' {
			if `error'[1,`i'] != 3 & `b'[1,`i'] == 0 {
				matrix `error'[1,`i'] = 1
			}
		}
		LabelMatrices2 ///
			`b' `V' `Vsrs' `Vsrssub' `Vsrswr' `Vsrssubwr' ///
			`over_N' : `names' : `plabels' : `over_namelist'
	}

	ereturn post `b' `V',		///
		dof(`r(df_r)')		///
		obs(`r(N)')		///
		esample(`touse')	///
		depname(`=proper("`cmd'")')
	_r2e

	ereturn local novariance "`novariance'"
	ereturn local nolabel `"`nolabel'"'
	ereturn local marginsnotok _ALL
	ereturn hidden local predict _no_predict
	ereturn local varlist `uvarlist'
	if "`svy'" != "" {
		ereturn local estat_cmd svy_estat
	}
	else	ereturn local estat_cmd estat_vce_only
	if "`cmd'" == "ratio" {
		ereturn local namelist	`names'
	}
	if "`cmd'" == "proportion" {
		ereturn matrix error	`error'
		ereturn local namelist	`:list retok plabels'
		forval i = 1/`:word count `uvarlist'' {
			ereturn local label`i' `"`label`i''"'
		}
	}

	local k_eq : coleq e(b)
	local k_eq : list uniq k_eq
	local k_eq : word count `k_eq'
	ereturn scalar k_eq = `k_eq'
	ereturn hidden scalar k_eform = 0
	ereturn matrix _N `osub'
	if "`svy'" != "" {
		if "`Vsrs'" != "" {
			ereturn matrix V_srs `Vsrs'
			if "`Vsrssub'" != "" {
				ereturn matrix V_srssub `Vsrssub'
			}
			if "`Vsrswr'" != "" {
				ereturn matrix V_srswr `Vsrswr'
			}
			if "`Vsrssubwr'" != "" {
				ereturn matrix V_srssubwr `Vsrssubwr'
			}
		}
		ereturn matrix _N_subp	`nsub'
		ereturn local vce	linearized
		ereturn local vcetype	Linearized
		ereturn local title = ///
			"Survey: " + proper("`cmd'") + " estimation"
		if "`cmd'" == "ratio" {
			local n_names : word count `names'
			local j 0
			forval i = 1/`n_names' {
				local name : word `i' of `names'
				local num : word `++j' of `uvarlist'
				local den : word `++j' of `uvarlist'
				local myargs ///
					`"`myargs' (`name':`num'/`den')"'
			}
		}
		else	local myargs `uvarlist'
		if "`over'" != "" {
			local oopt `", `over' `missing'"'
		}
		else	local oopt `", `missing'"'
		local command `"`cmd' `myargs'`oopt'"'
		ereturn local command `"`:list retok command'"'
		ereturn local cmdname	`cmd'
		ereturn local prefix	svy
	}
	else {
		if "`cmd'" == "mean" {
			if "`Vsrs'" != "" &	///
			 ( "`wtype'" == "pweight" | "`cluster'" != "" ) {
				ereturn matrix V_srs `Vsrs'
				if "`Vsrssub'" != "" {
					ereturn matrix V_srssub `Vsrssub'
				}
			}
			if inlist("`wtype'", "fweight", "iweight") {
				ereturn matrix _N_subp	`nsub'
			}
			else	ereturn local _N_subp
		}
		else	ereturn local _N_subp
		if "`wtype'" != "" {
			ereturn local wtype `wtype'
			ereturn local wexp `"`wexp'"'
		}
		ereturn local title = proper("`cmd'") + " estimation"
		ereturn local singleton
		ereturn local census
		ereturn local N_strata_omit
		if "`cluster'" != "" {
			ereturn local clustvar `cluster'
			ereturn local vcetype	Robust
		}
		else if "`cmd'" == "ratio" {
			ereturn local vcetype	Linearized
		}
		ereturn local vce "`vce'"
	}
	if "`novariance'"=="" {
		_post_vce_rank
	}
	// post this very last
	ereturn local cmd `cmd'

	_prefix_display, `diopts'
end

program srsTotal
	args b nsub

	matrix `b' = `b'*diag(`nsub')
end

program CompTvar
	args V nsub
	// adjustment for -total- estimator
	tempname c
	local cols = colsof(`nsub')
	matrix `c' = J(1,`cols',0)
	forval i = 1/`cols' {
		matrix `c'[1,`i'] = `nsub'[1,`i']^2
	}
	matrix `V' = diag(`c')*`V'
end

program AdjV
	args V osub nsub

	local dim = colsof(`osub')
	tempname c
	matrix `c' = J(1,`dim',0)
	forval i = 1/`dim' {
		matrix `c'[1,`i'] = (`osub'[1,`i']-1)/(`nsub'[1,`i']-1)
	}
	matrix `V' = `V'*diag(`c')
end

program ParseRatio
	_on_colon_parse `0'
	tokenize `s(before)'
	args c_names c_0

	local 0 `s(after)'
	syntax anything(name=spec id="ratio specification")	///
		[if] [in] [fw pw iw] [, * ]

	local myif `if'
	local myin `in'
	local myoptions `options'

	if "`weight'" != "" {
		local wt [`weight'`exp']
	}

	gettoken speci spec : spec, parse("()") match(par)

	if "`par'" == "" & `"`spec'"' != "" {
		di as err ///
		"parentheses are required for multiple ratio specifications"
		exit 198
	}

	local spec `"(`speci')`spec'"'
	local i 0
	while `"`spec'"' != "" {
		local ++i
		gettoken speci spec : spec, parse(" ()") match(par)
		if "`par'" == "" {
			di as err ///
"parentheses are required for multiple ratio specifications"
			exit 198
		}
		gettoken name speci : speci, parse(":")
		if `"`speci'"' != "" {
			confirm name `name'
			gettoken colon ratio : speci, parse(":")
		}
		else {
			local ratio `name'
			local name _ratio_`i'
		}
		local 0 : subinstr local ratio "/" " ", all count(local c)
		if `c' > 1 {
			di as err "invalid ratio specification: too many '/'"
			exit 198
		}
		if `c' == 1 {
			gettoken var1 ratio : ratio, parse(" /")
			gettoken slash var2 : ratio, parse(" /")
			if "`slash'" != "/" {
				di as err ///
				"invalid ratio specification: '/' misplaced"
				exit 198
			}
			local 0 `var1' `var2'
		}
		syntax varlist(min=2 max=2)
		local vlist `vlist' `varlist'
		local names `names' `name'
	}

	c_local `c_names' `names'
	c_local `c_0' `vlist' `myif' `myin' `wt', `myoptions'
end

program LabelMatrices
	_on_colon_parse `0'
	local mats	`"`s(before)'"'
	_on_colon_parse	`s(after)'
	local names	`s(before)'
	local labels	`s(after)'		// no quotes to trim spaces

	if "`labels'" == "" {
		local labels `names'
		local names _
	}
	local nvars : word count `names'
	local nlabs : word count `labels'
	local nlist
	foreach var of local names {
		Duplicate dup `nlabs' "`var' "
		local nlist `nlist' `dup'
	}
	Duplicate labels `nvars' "`labels' "

	foreach m of local mats {
		matrix coleq	`m' = `nlist'
		matrix colname	`m' = `labels'
		if rowsof(`m') == colsof(`m') {
			matrix roweq	`m' = `nlist'
			matrix rowname	`m' = `labels'
		}
	}
end

program LabelMatrices2
	_on_colon_parse `0'
	local mats	`"`s(before)'"'
	_on_colon_parse	`s(after)'
	local names	`s(before)'
	_on_colon_parse `s(after)'
	local plabels	`s(before)'
	local labels	`"`s(after)'"'

	if trim(`"`labels'"') != "" {
		local n_over : word count `labels'
		local n_cat : word count `names'
		forval i = 1/`n_cat' {
			local uname : word `i' of `plabels'
			Duplicate propi `n_over' `"`uname' "'
			local nlist `nlist' `propi'
		}
		local pnames `names'
		local names `nlist'
		Duplicate labels `n_cat' `"`labels' "'
	}
	else	local labels `plabels'
	foreach m of local mats {
		matrix coleq	`m' = `names'
		matrix colname	`m' = `labels'
		if rowsof(`m') == colsof(`m') {
			matrix roweq	`m' = `names'
			matrix rowname	`m' = `labels'
		}
	}
end

program MakeDeff, eclass
	args Vsrs Vsrswr
	tempname f V deff deft

	if "`e(poststrata)'`e(stdize)'" != "" {
		exit
	}

	matrix `V' = vecdiag(e(V))
	local dim = colsof(`V')
	matrix `deff' = `V'
	matrix `deft' = `V'
	if "`Vsrswr'" != "" {
		local Vdeft `Vsrswr'
	}
	else	local Vdeft `Vsrs'

	forval i = 1/`dim' {
		scalar `f' = `V'[1,`i']/`Vsrs'[`i',`i']
		matrix `deff'[1,`i'] = cond(missing(`f'),0,`f')

		scalar `f' = sqrt(`V'[1,`i']/`Vdeft'[`i',`i'])
		matrix `deft'[1,`i'] = cond(missing(`f'),0,`f')
	}

	ereturn matrix V_srs	= `Vsrs'
	if "`Vsrswr'" != "" {
		ereturn matrix V_srswr	= `Vsrswr'
	}
	ereturn matrix deff	= `deff'
	ereturn matrix deft	= `deft'
end

program Duplicate
	args c_lmac n string
	if `n' > 400 {
		while `n' > 400 {
			local dup2 : di _dup(400) `"`string'"'
			local dup `"`dup' `dup2'"'
			local n = `n' - 400
		}
		if `n' > 0 {
			local dup2 : di _dup(`n') `"`string'"'
			local dup `"`dup' `dup2'"'
		}
		c_local `c_lmac' `"`dup'"'
	}
	else {
		c_local `c_lmac' : di _dup(`n') `"`string'"'
	}
end

exit
