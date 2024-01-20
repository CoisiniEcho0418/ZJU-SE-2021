*! version 1.0.1  21aug2002
program define _svar_cnsmac, rclass
	version 8.0

	syntax , mat(string) name(string) neqs(integer) 

	tempname el
	local k 0
	forvalues i = 1/`neqs' {
		forvalues j = 1/`neqs' {
			scalar `el' = `mat'[`i',`j']
			if `el' != int(`el') {
				di as err "non-integer element in "/* 
					*/ "matrix defining constraints /*
					*/ "on `name'"
				exit 198	
			}	

			if `el' < . {
				if `el' == 0 {
local cnsmac "`cnsmac':[`name'_`i'_`j']_cons = 0"				
				}
				else {
local already 0				
forvalues m = 1/`k' {
	if ``m'' == `el' {
		local already 1
		local `m'c ``m'c' `name'_`i'_`j'
	}
}
if `already' == 0 {
	local ++k
	local `k' = `el'
	local `k'c `name'_`i'_`j'
}	

				}
			}
		}
	}

	forvalue m = 1/`k' {
		local cns : word count ``m'c'
		if `cns' < 1 {
			di as err "_svar_cnsmac is broken"
			exit 498
		}	
		if `cns' == 1 {
			di as err "`mc'c' is not constrained to be " /*
				*/ "equal to another element"
			exit 498
		}	
		local left ``m'c'
		gettoken cur left:left
		local first `cur'
		forvalues n = 2/`cns' {
			gettoken cur left:left
			local contr "[`first']_cons = [`cur']_cons"
			local cnsmac "`cnsmac':`contr'"
		}	
	}
	return local cnsmac "`cnsmac'"
end
