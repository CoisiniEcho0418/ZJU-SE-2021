*! version 1.0.1  06apr2009

program define _parmlist2 , rclass

	version 11

	/* 
	parses an expression that contains parameters, where parameters can
	   be {parmname} or {parmname=initializer}.  Spaces before or after
	   parmname, "=", or intializer are tolerated and removed from the
	   returned expression.

	   Returns:
	   	r(expr)      the expression with initializers removed and all
		             parameters cleaned up to be {parmname}.

		r(parmlist)  a list of the parameters with each parameter
			     listed only once.
			     
		r(initmat)   a matrix of initializers that may NOT be aligned
			     with parmlist (access be name) parmlist and 
			     which contains 0 for parameter that have not 
			     been assigned initializers. 

		r(k)	     number of parameters

	   example:

		_parmlist {a=5} * mpg / price { b=4}*{ a = 7 }*{ c }

	   returns:
		r(k)	    = 3
		r(expr)     : "{a} * mpg / price {b} * {a} * {c}"
		r(parmlist) : "a b c"
		r(inttmat)  = 7 , 4 , 0

	   You must pass an instance of class _gmm_parse.
	
	*/

	args parseobj expression
	
	local 0 `expression'
					/* get rid of possible spaces 
					   in { parmname }	*/
	local ct 1
	while `ct' > 0 {
		local 0 : subinstr local 0 "{ " "{", all count(local ct)
	}
	local ct 1
	while `ct' > 0 {
		local 0 : subinstr local 0 " }" "}", all count(local ct)
	}
					/* Pick off parameters -- {parmname} */
	local parmlist
	tempname initmat mat1 ival
	gettoken pre rest : 0 , parse("{")
	while "`rest'" != "" {
		local pre : subinstr local pre "{" ""
		local expr `expr' `pre'

					/* find end of {parmname [=init]} */
		gettoken parminit rest : rest , parse("}")
		if substr("`rest'",1,1) != "}" {
			di as error "invalid moment equation"
			di as error "`0'"
			exit 198
		}

		local parminit : subinstr local parminit "{" ""
		local rest : subinstr local rest "}" ""

		local lcreuse 0
				/* Is parminit a linear combination? */
		local parminit : subinstr local parminit " :" ":", all
		local parminit : subinstr local parminit ": " ":", all
		gettoken eqname vars : parminit , parse(":")
		/* See if eqname has already been used for a parameter name */
		local unused : subinstr local parmlist 		/*
			*/ "`eqname'" "`eqname'" , 		/*
			*/ count(local ct) word
		if `ct' > 0 & substr("`vars'",1,1)==":" {
			di as err "`eqname' already defined as a parameter"
			exit 198
		}
		if `"`=trim("`vars'")'"' == ":" {
			if !`.`parseobj'.isin `eqname'' {
				di as error		///
"you must define {opt `eqname'} before recalling it"
				exit 198
			}
			else {
				local vars `.`parseobj'.lcvarfetch `eqname''
			}		
			local lcreuse 1		// so we don't add to the list
						// of parameters and search for
						// a new parameter name below
		}
		else {
			// see if this name for a new linear combination has
			// already been used -- error out
			local lcnames `.`parseobj'.lcnamesfetch'
			local unused : subinstr local lcnames 	///
				"`eqname'" "`eqname'", count(local ct) word
			if `ct' {
				di as error 			///
"`eqname' already declared a linear combination
				exit 198
			}
		}
		if "`vars'" != "" {
			local vars : subinstr local vars ":" "", all
			tsunab vars : `vars'
			if !`lcreuse' {
				.`parseobj'.lcadd "`eqname'" "`vars'"
			}
			tsunab vars  : `vars'
			local varcnt 1
			foreach var of varlist `vars' {
				tsrevar `var', list
				confirm numeric variable `r(varlist)'
				local varn : subinstr local var "." "_", all
				local varpar = substr("`eqname'_`varn'", 1, 25)
				local unused : subinstr local parmlist 	/*
					*/ "`varpar'" "`varpar'", 	/*
					*/ count(local j) word
				if `j' > 0 & !`lcreuse' {
					local i = 0
					while `j' > 0 & `i' < 99999 {
						local nicei : di %05.0f `i'
						local unused : subinstr   /*
							*/ local parmlist /*
							*/ "`varpar'`nicei'"  /*
							*/ "`varpar'`nicei'", /*
							*/ count(local j) /*
							*/ word
						local i = `i' + 1
					}
					if `j' != 0 {
						exit 103
					}
					local varpar "`varpar'`nicei'"
				}
				if !`lcreuse' {
					matrix `mat1' = 0
					UpdateInitVals 		///
						`initmat' "`varpar'" `mat1'
					local parmlist `parmlist' `varpar'
.`parseobj'.lcparmadd "`eqname'" "`var'" "`varpar'"
				}
				if `varcnt' == 1 {
					local expr "`expr' ({`varpar'} *`var'"
				}
				else {
					local expr "`expr' {`varpar'} *`var'"
				}
				if "`ferest()'" != "" {
					local expr "`expr' +"
				}
				else {
					local expr "`expr')"
				}
				local `++varcnt'
			}
		}	
		else { 		/* Just a single parameter */
						/* evaluate or create initial
						   value */
			gettoken parm init : parminit, parse("=")
			local parm `parm'	/* sic, trimblanks */
			/* See if this name has already been used for
			   a linear combination
			*/
			if `.`parseobj'.isin `parm'' {
				di as err 		///
				"`parm' already defined as a linear combination"
				exit 198
			}
			if "`init'" != "" {
				scalar `ival' `init'
			}
			else	scalar `ival' = .

						/* maintain initial values
						   matrix */
			matrix `mat1' = `ival'
			UpdateInitVals `initmat' "`parm'" `mat1'

						/* maintain parmlist */

			local unused : subinstr local parmlist 		/*
					*/ "`parm'" "`parm'" , 		/*
					*/ count(local ct) word
			if `ct'==0 { 
				local parmlist `parmlist' `parm' 
			}
						/* put {parmname} into expr */
			local expr "`expr' {`parm'}"
		}
		gettoken pre rest : rest , parse("{")
	}
	
	local expr `expr' `pre'

					/* Return results */
	// if we call _parmlist2 after the initial parse, the subst.
	// expressions will have initial values removed, so `initmat'
	// may not have been created/updated.
	capture confirm matrix `initmat'
	if !_rc {
		return matrix initmat 	`initmat'
	}
	return scalar k		= `:word count `parmlist''
	return local  parmlist	`parmlist'
	return local  expr	`expr'

end


program UpdateInitVals

	version 8
	args initmat parm ivalmat 
	local col "."
	capture local col = colnumb(`initmat', "`parm'")
	if _rc | `col' == . {
		if `:word count `parm'' > 1 {
			di as error "`parm' is an invalid name"
			exit 7
		}
		confirm names `parm'
		/* If no initial value, set to zero */
		if `ivalmat'[1,1] >= . {
			mat `ivalmat'[1,1] = 0
		}
		mat colnames `ivalmat' = `parm'
		mat `initmat' = nullmat(`initmat') , `ivalmat'
	}
	else if `ivalmat'[1,1] < . {
		mat `initmat'[1, `col'] = `ivalmat'[1,1]
	}
	
end

