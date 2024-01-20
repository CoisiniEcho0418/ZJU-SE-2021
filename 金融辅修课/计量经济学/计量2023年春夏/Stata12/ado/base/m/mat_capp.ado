*! version 1.1.0  06jun2009
program mat_capp
	version 8

	syntax anything [, miss(str) cons ts]

	local b12   : word 1 of `anything'
	local colon : word 2 of `anything'
	local b1    : word 3 of `anything'
	local b2    : word 4 of `anything'

	if `"`colon'"' != ":" {
		di as err `"colon expected, `colon' found"'
		exit 198
	}
	confirm matrix `b1'
	confirm matrix `b2'

	local Qmatch = ("`miss'" == "")
	if `Qmatch' {
		local miss .
	}
	if `Qmatch' & rowsof(`b1') != rowsof(`b2') {
		error 503
	}

// if same names and same ordering, then do it fast !

	mata: st_local("rnameseq", strofreal(	///
		st_matrixrowstripe("`b1'") == st_matrixrowstripe("`b2'") ))
	if `rnameseq' {
		mat `b12' = `b1', `b2'
		exit
	}

// check whether time-series insertion is requested and needed

	if "`ts'" != "" {
		local rfullb1 : rowfullnames `b1'
		local rfullb2 : rowfullnames `b2'
		local tmp : subinstr local rfullb1 "." "", count(local n1)
		local tmp : subinstr local rfullb2 "." "", count(local n2)
		if `n1'==0 & `n2'==0 {
			local ts
		}
	}

// match

	tempname bb12 bb bb2 bbtemp newrow

	local eq1 : roweq `b1', quoted
	local eq2 : roweq `b2', quoted
	local eq1 : list uniq eq1
	local eq2 : list uniq eq2

	foreach eq of local eq1 {
		mat `bb' = `b1'["`eq':",1...]
		mat `bb' = `bb' , J(rowsof(`bb'), colsof(`b2'), `miss')

		// eq is removed from eq2 if it exists
		local eq2 : subinstr local eq2 `""`eq'""' "", ///
						word count(local eqinb2)

		if `eqinb2' == 1 {

			// eq occurs also in b2
			mat `bb2' = `b2'["`eq':", 1...]
			local nbb2 = rowsof(`bb2')
			local namesbb2 : rownames `bb2'
			tokenize `namesbb2'

			forvalues j = 1 / `nbb2' {
				_ms_parse_parts `"``j''"'
				local isvar = r(type) == "variable"
				local ii = rownumb(`bb',"``j''")
				if `ii' != . {
					// found
					mat subst `bb'[`ii',colsof(`b1')+1] ///
							= `bb2'[`j',1...]
				}
				else {
					// append a row to bb
					if `Qmatch' {
						di as err "rowname mismatch"
						exit 503
					}
					mat `newrow' = ///
						J(1,colsof(`b1'),`miss') , ///
						`bb2'[`j',1...]
					version 11: ///
					mat rownames `newrow' = `"`eq':``j''"'
					if "`ts'" != "" & `isvar' {
						TS_Insert `bb' `newrow'
					}
					else {
						mat `bb' = `bb' \ `newrow'
					}
				}
			}

			if "`cons'" != "" {
				ConsLast `bb'
			}
		}

		mat `bb12' = nullmat(`bb12') \ `bb'
	}

	// all equations now left in eq2 cannot exist in eq1/b1

	if `Qmatch' & `"`eq2'"' != "" {
		di as err "rowname mismatch"
		exit 503
	}

	// append remaining equations in eq2

	foreach eq of local eq2 {
		mat `bbtemp' = `b2'["`eq':",1...]
		mat `bb' = J(rowsof(`bbtemp'),colsof(`b1'),`miss') , `bbtemp'
		mata : st_matrixrowstripe("`bb'",		///
			(J(rows(st_matrix("`bb'")),1,"`eq'"),	///
			 (st_matrixrowstripe("`bbtemp'")[.,2])	///
			))
		mat `bb12' = `bb12' \ `bb'
	}

	mata : st_matrixcolstripe("`bb12'", ///
		st_matrixcolstripe("`b1'") \ st_matrixcolstripe("`b2'"))

	mat `b12' = `bb12'
end


/* ConsLast b

   Moves the row with name _cons to the bottom
*/
program ConsLast
	args b

	local i = rownumb(`b',"_cons")
	local n = rowsof(`b')
	if inlist(`i',.,`n') {
		exit
	}

	if `i' == 1 {
		mat `b' = `b'[2...,1...] \ `b'[1,1...]
		exit
	}

	local im1 = `i'-1
	local ip1 = `i'+1
	mat `b' = `b'[1..`im1',1...] \ (`b'[`ip1'..`n',1...] \ `b'[`i',1...])
end


/* TS_Insert b newrow

   Inserts newrow in b directly after all rows of b with matching varname
   (i.e., with different ts operators), or at the bottom of b if no such
   row is found.
*/
program TS_Insert
	args b newrow

	local vname : rownames `newrow'
	local ip = index("`vname'", ".")
	if `ip' > 0 {
		local vname = substr("`vname'", `ip'+1, .)
	}

	local bnames : rownames `b'
	local nb = rowsof(`b')
	tokenize `"`bnames'"'
	forvalues i = `nb'(-1)1 {
		if index("``i'' ",".`vname' ") > 0 {
			// row should be inserted directly after i
			local ii = `i'
			continue, break
		}
	}

	if "`ii'" == "" | "`ii'" == "`nb'" {
		matrix `b' = `b' \ `newrow'
	}
	else {
		local ip1 = `ii'+1
		matrix `b' = `b'[1..`ii',1...] \ (`newrow' \ `b'[`ip1'...,1...])
	}
end
exit
