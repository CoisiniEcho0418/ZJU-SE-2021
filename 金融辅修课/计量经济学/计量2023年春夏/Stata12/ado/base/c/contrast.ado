*! version 1.0.0  16may2011
program contrast
	version 12
	if replay() {
		if "`e(cmd)'" != "contrast" {
			error 301
		}
		_marg_report `0'
		exit
	}

	if inlist("`e(cmd)'", "contrast", "pwcompare", "pwmean") {
		di as err ///
`"contrast is not allowed with results from the `e(cmd)' command"'
		exit 322
	}
	_check_eclass
	if (!has_eprop(b) | !has_eprop(V)) {
		error 321
	}

	Contrast `0'
end

program Contrast, rclass
	local cmdline : copy local 0
	local match = "`e(cmd)'" == "margins"
	if `match' {
		local EXTRAOPTS noATLegend
	}
	syntax anything(id="contrast specification") [,		///
		OVERall						///
		EQuation(passthru)				///
		ATEQuations					///
		ASBALanced					/// default
		ASOBServed					///
		lincom						///
		EMPTYCELLs(string)				///
		noestimcheck					///
		Level(cilevel)					/// diopts
		NOWALD						///
		WALD						///
		noATLEVels					///
		noSVYadjust					///
		CIeffects					///
		PVeffects					///
		NOEFFects EFFects				///
		SORT						///
		POST						///
		`EXTRAOPTS'					///
		*						///
	]

	if "`noeffects'" != "" {
		opts_exclusive "`noeffects' `effects'"
		opts_exclusive "`noeffects' `cieffects'"
		opts_exclusive "`noeffects' `pveffects'"
	}

	local equation `equation' `atequations'
	opts_exclusive "`equation'"
	opts_exclusive "`asbalanced' `asobserved'"

	local wald `nowald' `wald'
	opts_exclusive "`wald'"

	_check_eformopt `e(cmd)', eformopts(`options') soptions
	local eform `"`s(eform)'"'
	_get_mcompare, `s(options)'
	local method	`"`s(method)'"'
	local all	`"`s(adjustall)'"'
	_get_diopts diopts, `s(options)'
	local diopts	level(`level')			///
			`wald'				///
			`atlevels'			///
			`svyadjust'			///
			`cieffects'			///
			`pveffects'			///
			`noeffects'			///
			`effects'			///
			mcompare(`method' `all')	///
			`diopts'			///
			`eform'				///
			`atlegend'

	local 0 `", `emptycells'"'
	capture {
		syntax [, REWeight strict]
		opts_exclusive "`reweight' `strict'"
	}
	if c(rc) {
		di as err "invalid emptycells() option;"
		syntax [, REWeight strict]
		opts_exclusive "`reweight' `strict'"
		error 198	// [sic]
	}

	if `match' & `:length local reweight' {
		di as err "{p 0 0 2}" ///
"option emptycells(reweight) is not allowed with results from the " ///
"margins command{p_end}"
		exit 322
	}
	if "`estimcheck'" == "" & !`match' {
		tempname H
		_get_hmat `H'
		if r(rc) {
			local H
		}
	}

	local eqns =	inlist(	`"`e(cmd)'"',	///
				`"manova"',	///
				`"mlogit"',	///
				`"mprobit"',	///
				`"mvreg"')
	local slash = "`e(prefix)'" == "" &	///
			inlist(	`"`e(cmd)'"',	///
				`"anova"',	///
				`"cnsreg"',	///
				`"manova"',	///
				`"mvreg"',	///
				`"regress"')

	local opts `asobserved' `lincom' `reweight' `equation'
	local anything `"`anything', `opts'"'
	mata: _contrast(`=e(df_r)', `eqns', `slash', `match')
	if !`:length local post' {
		tempname ehold
		_est hold `ehold', restore
	}
	PostIt
	return add
	_marg_report, `diopts'
	return add
end

program PostIt, eclass
	tempname b V
	matrix `b'	= r(b)
	matrix `V'	= r(V)
	if !missing(e(df_r)) {
		local dof dof(`e(df_r)')
	}
	ereturn post `b' `V', `dof'
	ereturn hidden local predict	_no_predict
	ereturn local cmd	"contrast"
	_r2e, noclear
	local eq : coleq e(b)
	local eq : list uniq eq
	if "`eq'" != "_" {
		ereturn hidden scalar k_eform = `:list sizeof eq'
	}
end

exit
