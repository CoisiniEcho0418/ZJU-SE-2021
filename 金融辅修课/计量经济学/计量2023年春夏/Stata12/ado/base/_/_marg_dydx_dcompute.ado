*! version 1.0.0  12jun2009
program _marg_dydx_dcompute, rclass
	version 11
	syntax anything(name=o id="name") [fw pw iw aw] [if],	///
		xvar(string)					///
		[	GENerate(name)				///
			replace					///
			next					///
			mult(name)				///
			estimcheck				///
		]

	tempname p0 p1 n0 n1

	_ms_parse_parts `xvar'
	* xvar should NOT have tsops
	assert "`r(ts_op)'" == ""
	local var `r(name)'
	local k = r(level)
	.`o'.get_dx_base `var'
	local base = r(base)

	local next : length local next
	if `next' {
		if !`.`o'.gen' {
			local next 0
		}
	}
	local gen : length local generate
	if `next' & !`gen' {
		tempname generate
		local gen 99
	}
	if `gen' {
		if !`:length local replace' {
			confirm new var `generate'
		}
		tempname g0 g1
		local gen0 gen(`g0')
		local gen1 gen(`g1')
	}
	local BALVARS `"`.`o'.BALVARS'"'
	if `:length local BALVARS' {
		tempname mult0 mult1
		local balopt balvars(`BALVARS')
	}

	Compute1 `o' `if' [`weight'`exp'], xvar(`var') k(`base') `gen0' ///
		`estimcheck' `balopt' mult(`mult0')
	if r(not_estimable) == 1 {
		return add
		exit
	}
	scalar `p0' = r(b)
	scalar `n0' = r(N)

	Compute1 `o' `if' [`weight'`exp'], xvar(`var') k(`k') `gen1' ///
		`estimcheck' `balopt' mult(`mult1')
	if r(not_estimable) == 1 {
		return add
		exit
	}
	if `:length local mult' {
		matrix `mult' = `mult1' - `mult0'
	}
	scalar `p1' = r(b)
	scalar `n1' = r(N)

	if `n0' != `n1' {
		di as err "{p}" ///
"inconsistent estimation sample levels `base' and `k' of factor `var'" ///
		"{p_end}"
		exit 459
	}
	return scalar b = `p1' - `p0'
	return scalar N = `n1'
	return scalar not_estimable = 0
	if `gen' {
		capture drop `generate'
		quietly gen double `generate' = `g1' - `g0'
		if `next' {
			if `gen' == 99 {
				.`o'.copyvar `generate', next rename
			}
			else {
				.`o'.copyvar `generate', next
			}
		}
	}
end

program Balance, eclass
	gettoken o 0 : 0
	gettoken mult balvars : 0
	tempname b
	_ms_balance `balvars', `.`o'.empty'
	matrix `b' = r(b)
	ereturn repost b=`b', rename
	matrix `mult' = r(mult)
end

program Compute1
	syntax anything(name=o id="name") [fw pw iw aw] [if],	///
		xvar(varname)					///
		k(integer)					///
		[	GENerate(passthru)			///
			mult(name)				///
			BALVARS(string)				///
			estimcheck				///
		]
	local wgt [`weight'`exp']

	if `:length local balvars' {
		tempname ehold
		_est hold `ehold', copy restore
		Balance `o' `mult' `balvars' `k'.`xvar'
	}

nobreak {

capture noisily break {

	tempvar hold
	rename `xvar' `hold'
	quietly gen `xvar' = `k'

} // capture noisily break
	local rc = c(rc)

	if !`rc' {

capture noisily quietly break {

		if `: length local estimcheck' {
			.`o'._check_est `if' `wgt', mult(`mult')
			local doit = r(not_estimable) != 1
		}
		else	local doit 1

		if `doit' {
			.`o'.compute `if' `wgt', `generate'
		}

} // capture noisily quietly break
	local rc = c(rc)

	}

	capture confirm var `hold'
	if !c(rc) {
		capture drop `xvar'
		rename `hold' `xvar'
	}

} // nobreak
	exit `rc'
end

exit
