*! version 1.0.0  20aug2002
program define _svar_eqmac, rclass
	version 8.0

	syntax , mat(string) name(string) neqs(integer) 

	forvalues i = 1/`neqs' {
		forvalues j = 1/`neqs' {
			local el = `mat'[`i',`j']

			if `el' < . {
local cnsmac "`cnsmac':[`name'_`i'_`j']_cons = `el'"				
			}

		}
	}
	return local cnsmac "`cnsmac'"
end
