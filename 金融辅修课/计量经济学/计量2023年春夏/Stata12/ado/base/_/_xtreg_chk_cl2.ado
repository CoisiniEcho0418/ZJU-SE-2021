*! version 1.0.0  25aug2005
program define _xtreg_chk_cl2, sort
	version 9.0 

/*
        Throw error if the panels are not the same as or not nested within
        panels.  The data have already been restricted to `touse'.

        Panels are nested within clusters if cluster does not vary within
        id.

*/

	args clvar ivar


	if "`clvar'" == "`ivar'" exit

	tempvar Tb2 Tb vary


					/* tempvar will have non-zero obs
					 * if cluster varies within id
					 */
					 
	sort `clvar'
	qui by `clvar': gen long `Tb' = cond(_n==1,1,0) 
	qui replace `Tb' = sum(`Tb')

	sort `ivar' `clvar' 
	qui by `ivar' : gen long `Tb2' = `Tb'[1]-`Tb'[_N]


	qui count if `Tb2' != 0
	scalar `vary' = r(N)

	if `vary' > 0 {
		di as err "panels are not nested within clusters"
		exit 498
	}

end
