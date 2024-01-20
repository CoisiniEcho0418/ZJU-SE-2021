*! version 1.1.0  30apr2007
program _score_spec, sclass
	version 9
	syntax [anything(name=vlist)] [if] [in]	///
	[,					///
		b(name)				///
		SCores				/// ignored
		EQuation(string)		///
		SCore(string)			///
		OLDOLOGit			/// do not document
		ignoreeq			/// NOT documented
	]

	if `"`equation'"' != "" & `"`score'"' != "" {
		di as err "options equation() and score() cannot be combined"
		exit 198
	}
	local equation `equation' `score'
	if `:length local ignoreeq' & `:length local equation' {
		di as err "option equation() not allowed"
		exit 198
	}
	if "`b'" == "" {
		local bopt e(b)
	}
	else {
		confirm matrix `b'
		local bopt `b'
	}
	tempname b
	matrix `b' = `bopt'

	// equations in `b' matrix
	if "`oldologit'" != "" {
		local neq = e(k_cat)
		forval i = 1/`=`neq'-1' {
			local coleq `coleq' _cut`i'
		}
		local coleq `e(depvar)' `coleq'
		local zero zero
	}
	else {
		local coleq : coleq `b', quote
		local coleq : list clean coleq
		local coleq : list uniq coleq
		if `:length local ignoreeq' {
			local neq = colsof(`b')
		}
		else	local neq   : list sizeof coleq
		if inlist("`e(cmd)'", "ologit", "oprobit") {
			if `neq' == e(k_cat) {
				local zero zero
			}
		}

	}

	// parse the vlist, allow <newvarlist> and <stub>*
	_stubstar2names `vlist', nvars(`neq') single `zero'
	local varlist	`s(varlist)'
	local typlist	`s(typlist)'
	local stub	`s(stub)'
	confirm new var `varlist'
	local nvars : word count `varlist'

	if `stub' | `nvars' > 1 {
		if `"`equation'"' != "" {
			di as err ///
"option equation() is not allowed when generating multiple scores"
			exit 198
		}
		if `nvars' != `neq' {
			if "`e(cmd)'" != "" {
				local for "for `e(cmd)' "
			}
			di as err ///
"{p}the current estimation results `for'have `neq' equations so you " ///
"must specify `neq' new variables, or you can use the equation() " ///
"option and specify one variable at a time{p_end}"
			if `nvars' < `neq' {
				exit 102
			}
			else	exit 103
		}
	}
	else {
		if `"`equation'"' == "" {
			if (`nvars' == 1) local eqspec #1
		}
		else	local eqspec `equation'
	
		// verify -score()- option
		gettoken POUND eqnum : eqspec, parse("#")
		if "`POUND'" == "#" {
			capture {
				confirm integer number `eqnum'
				assert 0 < `eqnum' & `eqnum' <= `neq'
			}
			if (!c(rc)) local eqname : word `eqnum' of `coleq'
		}
		else if `:list eqspec in coleq' {
			forval i = 1/`neq' {
				local eq : word `i' of `coleq'
				if "`eq'" == "`eqspec'" {
					local eqspec "#`i'"
					local eqname `equation'
					continue, break
				}
			}
		}
		if "`eqname'" == "" {
			InvalidEq `eqspec'
		}
	}

	// save results
	sreturn clear
	sreturn local eqspec	`eqspec'
	if `"`eqname'"' != "_" {
		sreturn local eqname	`eqname'
	}
	if `"`coleq'"' != "_" {
		sreturn local coleq	`"`coleq'"'
	}
	sreturn local varlist	`varlist'
	sreturn local typlist	`typlist'
	sreturn local if `"`if'"'
	sreturn local in `"`in'"'
end

program InvalidEq
	di as err "equation [`0'] not found"
	exit 303
end

exit
