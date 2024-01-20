*! version 1.1.1  25jan2010
program _loop_jknife2
	version 9
	set buildfvinfo off			// auto-reset on exit
	syntax namelist(min=6) ,		///
		command(string asis)		///
		express(string asis)		///
		cmd1(string asis)		///
		wvar(varname)			///
		n0(string)			///
		postid(name)			///
		[				///
			svy			///
			IWeight			///
			PWeight			///
			POSTS(varname)		///
			POSTW(varname numeric)	///
			pstrwvar(varname)	///
			cmd2(string asis)	///
			nclust(integer 0)	/// [ignored]
			STRata(varname)		///
			nfunc(string)		///
			noDOTS			///
			NOIsily			///
			trace			///
			reject(string asis)	///
		]

	gettoken cmdname : command
	if "`iweight'`pweight'" != "" {
		local wtype `iweight'`pweight'
	}
	else	local wtype pweight
	if `"`cmd2'"' != "" {
		local cmd2 `", `cmd2'"'
	}
	if "`trace'" != "" {
		local noisily	noisily
		local traceon	set trace on
		local traceoff	set trace off
	}
	if "`noisily'" != "" {
		local dots nodots
	}
	local nodots `dots'
	if "`dots'" != "" {
		local dots "*"
		local noiqui noisily quietly
	}
	else	local dots _dots
	local K 0
	while `"`express'"' != "" {
		gettoken exp`++K' express : express,	///
			parse("()") bind match(par)
	}
	gettoken touse  namelist : namelist
	gettoken subuse namelist : namelist
	gettoken strid  namelist : namelist
	gettoken clid   namelist : namelist
	gettoken ncl    pseudo   : namelist
	if `K' != `: word count `pseudo'' {
		di as err "internal error in jackknife"
		exit 9		// [sic] this should never happen
	}
	forval j = 1/`K' {
		local tv`j' : word `j' of `pseudo'
		local ppseudo `ppseudo' (`tv`j'')
		local missing `missing' (.)
	}
	local noi = cond("`noisily'"=="","*","noisily")

	tempname nobs
	tempvar twvar
	quietly gen double `twvar' = `wvar'

	if "`posts'" != "" {
		if "`pstrwvar'" == "" {
			tempname pstrwvar
		}
		if "`postw'" == "" {
			di as err "option posts() requires the postw() option"
			exit 198
		}
		local pstr posts(`posts') postw(`postw')
		local uwvar `pstrwvar'
	}
	else	local uwvar `twvar'


	quietly tab `strid'
	local nstrata = r(r)
	if "`nodots'" == "" | "`noisily'" != "" {
		di
		_dots 0, title(Jackknife replications) reps(`nstrata') `nodots'
	}
	local rejected 0
	if "`strata'" != "" {
		local pstrid (\`j')
	}
	forval j = 1/`nstrata' {
		`noi' di as inp `". `command'"'
		// adjust weights
		local clj = 2*`j'-1
		quietly count if `clid' == `clj'+1 & `touse' == 1
		scalar `nobs' = r(N)
		quietly count if `strid' == `j' & `subuse'
		if `nobs' == 0 | r(N) == 0 {
			`dots' `j' -1
			continue
		}
		quietly count if `clid' == `clj'+1 & `subuse'
		scalar `nobs' = r(N)
		quietly replace `twvar' = cond(`clid' == `clj'+1, 0, `wvar') ///
			if `touse' == 1
		quietly replace `twvar' = 2*`twvar' ///
			if `clid' == `clj' & `touse' == 1
		if "`posts'" != "" {
			capture drop `pstrwvar'
			svygen post double `pstrwvar' [iw=`twvar'] ///
				if `touse' == 1, `pstr'
		}
		`traceon'
		capture `noiqui' `noisily'		///
			`cmd1' [`wtype'=`uwvar']	///
			if `subuse' & `clid' != `clj'+1 `cmd2'
		`traceoff'
		if (c(rc) == 1)	error 1
		local bad = c(rc) != 0
		if c(rc) {
			`noi' di in smcl as error ///
`"{p 0 0 2}an error occurred when jackknife executed `cmdname', "' ///
`"posting missing values{p_end}"'
		}
		else {
			if `"`reject'"' != "" {
				capture local rejected = `reject'
				if c(rc) {
					local rejected 1
				}
			}
			if `rejected' {
				local bad 1
				`noi' di as error ///
`"{p 0 0 2}`caller' rejected results from `cmdname', "' ///
`"posting missing values{p_end}"'
			}
			else {
				forval i = 1/`K' {
					capture scalar `tv`i'' = `exp`i''
					if (c(rc) == 1)	error 1
					if c(rc) {
						scalar `tv`i'' = .
					}
					if missing(`tv`i'') {
						local bad 2
						`noi' di as error ///
`"{p 0 0 2}captured error in `exp`i'', posting missing value{p_end}"'
					}
				}
				if `"`nfunc'"' != "" {
					if "`svy'" == "" {
						local nn = int(`nfunc')
					}
					else {
						quietly count if e(sample)
						local nn = r(N)
					}
					local nn = int(`nfunc')
					// keep the value
					local rd = reldif(`nn', `n0'-`nobs')
					if `rd' > 1e-5 {
						local bad 3
					}
				}
			}
		}
		if inlist(`bad', 1, 3) {
			post `postid' `pstrid' (`j') (.) `missing'
		}
		else {
			sum `ncl' if `strid' == `j' & `touse' == 1, mean
			post `postid' `pstrid' (`j') (1) `ppseudo'
		}
		`dots' `j' `bad'
	}
	`dots' `nclust'
end
exit
