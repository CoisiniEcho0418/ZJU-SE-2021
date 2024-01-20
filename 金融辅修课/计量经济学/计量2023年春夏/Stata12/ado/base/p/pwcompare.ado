*! version 1.0.0  16may2011
program pwcompare
	version 12
	if replay() {
		if "`e(cmd)'" != "pwcompare" {
			error 301
		}
		syntax [, *]
		_get_mcompare pwcompare, `options'
		local mop	`"`s(method)'"'
		local all	`"`s(adjustall)'"'
		local options	`"`s(options)'"'
		local mvs	`"`e(mcmethod_vs)'"'
		if inlist("dunnett", "`mop'", "`mvs'") & "`mop'" != "`mvs'" {
			tempname ehold
			_est hold `ehold', restore copy
			REcompare `mop' `all'
		}
		_marg_report, mcompare(`mop' `all') `options'
		exit
	}

	if "`e(cmd)'" == "contrast" {
		di as err ///
`"pwcompare is not allowed with results from the `e(cmd)' command"'
		exit 322
	}
	_check_eclass
	if (!has_eprop(b) | !has_eprop(V)) {
		error 321
	}

	PWCompare `0'
end

program PWCompare, rclass
	local cmdline : copy local 0
	local match 0
	if "`e(cmd)'" == "margins" {
		local match 1
	}
	else if inlist("`e(cmd)'", "pwcompare", "pwmean") {
		local match 2
	}
	if `match' == 1 {
		local EXTRAOPTS noATLegend
	}
	syntax anything(id="margin specification") [,	///
		EQuation(passthru)			///
		ATEQuations				///
		ASBALanced				/// default
		ASOBServed				///
		EMPTYCELLs(string)			///
		noestimcheck				///
		Level(cilevel)				/// diopts
		CIeffects				///
		PVeffects				///
		EFFects					///
		CIMargins				///
		GROUPs					///
		SORT					///
		POST					///
		POSTTABLE				/// NODOC
		`EXTRAOPTS'				///
		*					/// method/diopts
	]

	local equation `equation' `atequations'
	opts_exclusive "`equation'"
	opts_exclusive "`asbalanced' `asobserved'"

	local ditype	`groups'	///
			`cimargins'	///
			`effects'	///
			`pveffects'	///
			`cieffects'

	_check_eformopt `e(cmd)', eformopts(`options') soptions
	local eform `"`s(eform)'"'
	_get_mcompare pwcompare, `s(options)'
	local method	`"`s(method)'"'
	local all	`"`s(adjustall)'"'
	local options	`"`s(options)'"'

	_get_diopts diopts, `options'
	local diopts	`diopts'	///
			`ditype'	///
			`sort'		///
			`atlegend'	///
			`eform'		///
			level(`level')

	local 0 `", `emptycells'"'
	capture {
		syntax [, REWeight strict]
		opts_exclusive "`reweight' `strict'"
	}
	if c(rc) {
		di as err "invalid emptycells() option;"
		syntax [, REWeight strict]
		opts_exclusive "`reweight' `strict'"
		exit 198	// [sic]
	}

	if `match' & `:length local reweight' {
		di as err "{p 0 0 2}" ///
"option emptycells(reweight) is not allowed with results from the " ///
"`e(cmd)' command{p_end}"
		exit 322
	}
	if "`estimcheck'" == "" & !`match' {
		tempname H
		_get_hmat `H'
		if r(rc) {
			local H
		}
	}

	if "`method'" == "dunnett" {
		opts_exclusive "`method' `groups'"
		local dunnett dunnett
	}
	opts_exclusive "`all' `groups'"

	local eqns =	inlist( `"`e(cmd)'"',	///
				`"manova"',	///
				`"mlogit"',	///
				`"mprobit"',	///
				`"mvreg"')

	local NOEQNS duncan dunnett snk tukey
	if `:list method in NOEQNS' & `eqns' {
		local junk : subinstr local anything "_eqns" "", ///
			word count(local haseqns)
		if `haseqns' {
			di as err ///
"method `method' is not allowed with system factor '_eqns'"
			exit 198
		}
	}

	local opts `asobserved' `lincom' `reweight' `equation' `dunnett'
	local anything `"`anything', `opts'"'
	mata: _pwcompare(`=e(df_r)', `eqns', `match')
	if !`:length local post' {
		tempname ehold
		_est hold `ehold', restore
	}
	if !missing(`df_r') {
		local dfopt dof(`df_r')
	}
	PostIt
	return add
	return local level
	_marg_report, `diopts' mcompare(`method' `all')
	if "`posttable'" != "" {
		_r2e, noclear
	}
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
	ereturn local cmd	"pwcompare"
	_r2e, noclear
	local eq : coleq e(b)
	local eq : list uniq eq
	if "`eq'" != "_" {
		ereturn hidden scalar k_eform = `:list sizeof eq'
	}
end

program REcompare, eclass
	args mcompare all

	local 0 `"`e(cmdline)'"'
	gettoken cmd 0 : 0
	syntax anything(id="margin specification") [,	///
		ATEQuations				///
		*					///
	]

	local mmethod	`"`e(margin_method)'"'
	local empty	`"`e(emptycells)'"'
	quietly	pwcompare `anything',	`atequations'	///
					`mcompare'	///
					`all'		///
					post
	ereturn local margin_method	`"`mmethod'"'
	ereturn local emptycells	`"`empty'"'
end

exit
