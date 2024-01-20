*! version 1.0.0  25aug2010
program define _parmlist_initial
	version 12

	/*
	   Parses the initial values specified in the from() option
	   for commands that use substitutable expressions, such as -nl-,
	   -gmm-, and -mlexp-.

	   Syntax of from() is

	      parmname [=] # parmname [=] # ...

	   The equals sign is optional.

	   You use this routine AFTER you have parsed the substitutable
	   expression(s) and have created the default initial value
	   vector (of zeros) and set the column names to be the
	   parameter names.

		initial -- whatever the user specified in the
		           initial() option
		parmvec -- the default initial value vector
		params  -- string containing the names of the
		           parameters

	   EG    args `"`initial'"' : `parmvec' `"`params'"'

	   This routine modifies the matrix `parmvec' as appropriate.

	*/

	args initial COLON parmvec params

	local np = colsof(`parmvec')
	if `:word count `initial'' == 1 {	/* matrix */
		capture confirm matrix `initial'
		if _rc {
			di as error "matrix `initial' not found"
			exit 480
		}
		if `=colsof(`initial')' != `np' {
			di as error /*
*/ "initial matrix must have as many columns as parameters in model"
			exit 480
		}
		matrix `parmvec' = `initial'
		matrix colnames `parmvec' = `params'
	}
	else {				/* Must be <parm> [=] # ... */
/*

		if mod(`:word count `initial'', 2) != 0 {
			di as error "invalid from() option"
			exit 480
		}
*/

		tokenize `initial', parse(" =")
		while "`*'" != "" {
			capture local col = colnumb(`parmvec', "`1'")
			if _rc | `col' == . {
	di as error "invalid parameter `1' in from()"
				exit 480
			}
			if "`2'" == "=" {
				matrix `parmvec'[1, `col'] = `3'
				local shift 3
			}
			else {
				matrix `parmvec'[1, `col'] = `2'
				local shift 2
			}
			mac shift `shift'
		}
	}
end
