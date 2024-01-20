*! version 1.0.0  26mar2009
program _marg_dydx_ccompute_cr, rclass
	version 11
	syntax anything(name=o id="name") [fw pw iw aw] [if],	///
		xvar(varname) [NOSE next]

	tempname b dzb dp_db dzb_dx dzb_dx dp_dx d2p_dbdx mult

	local nose : length local nose

	if `:length local weight' {
		local wgt [`weight'`exp']
	}

	matrix `b' = e(b)
	local colna0 : colna e(b)
	_ms_dzb_dx `xvar', matrix(b) eclass
	matrix `dzb' = r(b)
	local colna1 : colna `dzb'
	local n = colsof(`dzb')
	matrix `dp_db' = J(1,`n',0)

	qui gen double `dzb_dx' = . in 1
	qui gen double `dp_dx' = 0 `if'
	qui gen double `d2p_dbdx' = . in 1

	local chainrule `.`o'.t_cr'
	local tvar `.`o'.t_dzb'
	local neq = rowsof(`chainrule')
	forval eq1 = 1/`neq' {
		local dp_dzb `tvar'_`eq1'
		matrix score `dzb_dx' = `dzb' `if', equation(#`eq1') replace
		qui replace `dp_dx' = `dp_dx' + `dp_dzb'*`dzb_dx'

		if `nose' {
			continue
		}

	forval eq2 = 1/`neq' {

		if `eq2' < `eq1' {
			local d2p_dzbdzb `tvar'_`eq1'_`eq2'
		}
		else {
			local d2p_dzbdzb `tvar'_`eq2'_`eq1'
		}

		local i1 = `chainrule'[`eq2',1]
		local i2 = `chainrule'[`eq2',2]
		forval i = `i1'/`i2' {

			local coef : word `i' of `colna0'
			if inlist("`coef'", "_cons", "o._cons") {
				local dzb_db
			}
			else	local dzb_db "*`coef'"

			qui replace `d2p_dbdx' = `d2p_dzbdzb'*`dzb_dx'`dzb_db'
			if `.`o'.ex' {
				qui replace `d2p_dbdx' = `xvar'*`d2p_dbdx'
			}
			sum `d2p_dbdx' `if' `wgt', mean
			matrix `dp_db'[1,`i'] = `dp_db'[1,`i'] + r(mean)

		} // i

	} // eq2

		local i1 = `chainrule'[`eq1',1]
		local i2 = `chainrule'[`eq1',2]
		forval i = `i1'/`i2' {

if `dzb'[1,`i'] {

			scalar `mult' = `dzb'[1,`i']/`b'[1,`i']
			local d2zb_dbdx : word `i' of `colna1'
			if inlist("`d2zb_dbdx'", "_cons", "o._cons") {
				local d2zb_dbdx
			}
			else	local d2zb_dbdx "*`d2zb_dbdx'"
			qui replace `d2p_dbdx' = `dp_dzb'*`mult'`d2zb_dbdx'
			if `.`o'.ex' {
				qui replace `d2p_dbdx' = `xvar'*`d2p_dbdx'
			}
			sum `d2p_dbdx' `if' `wgt', mean
			matrix `dp_db'[1,`i'] = `dp_db'[1,`i'] + r(mean)

} // dzb

		} // i


	} // eq1

	if `.`o'.ex' {
		qui replace `dp_dx' = `xvar'*`dp_dx'
	}
	sum `dp_dx' `if' `wgt', mean
	return scalar N = r(N)
	return scalar b = r(mean)
	return matrix db `dp_db'

	.`o'.copyvar `dp_dx', `next' rename

end
