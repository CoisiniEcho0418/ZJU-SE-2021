*! version 1.2.1  25jan2010
program _loop_jknife_iw
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
			nclust(integer 0)	///
			STRata(varname)		///
			FPC(varname numeric)	///
			nfunc(string)		///
			noDOTS			///
			NOIsily			///
			trace			///
			reject(string asis)	///
			stset			///
			checkmat(name max=1)	///
		]

	gettoken cmdname : command
	local is_st = "`stset'" != ""
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

	tempname nobs fpcval
	tempvar twvar
	quietly gen double `twvar' = .

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

	local strj 1
	if "`nodots'" == "" | "`noisily'" != "" {
		di
		_dots 0, title(Jackknife replications) reps(`nclust') `nodots'
	}
	local omit 0
	local rejected 0
	if "`strata'" != "" {
		local pstrid (\`strj')
	}
	if "`fpc'" != "" {
		loca pfpcval (\`fpcval')
	}
	forval j = 1/`nclust' {
		`noi' di as inp `". `command'"'
		// adjust weights
		quietly count if `clid' == `j' & `touse' == 1
		scalar `nobs' = r(N)
		quietly count if `strid' == `strj' & `subuse'
		if `nobs' == 0 | r(N) == 0 {
			`dots' `j' -1
			quietly count if `clid' == `j'+1 & `strid' == `strj'
			if r(N) == 0 {
				local ++strj
			}
			continue
		}
		quietly count if `clid' == `j' & `subuse'
		scalar `nobs' = r(N)
		quietly replace `twvar' = cond(`clid' == `j', 0, `wvar') ///
			if `touse' == 1
		quietly replace `twvar' = `twvar'*`ncl'/(`ncl'-1) ///
			if `strid' == `strj' & `touse' == 1
		if "`posts'" != "" {
			capture drop `pstrwvar'
			svygen post double `pstrwvar' [iw=`twvar'] ///
				if `touse' == 1, `pstr'
		}
		if `is_st' {
			quietly streset [`wtype'=`uwvar']
		}
		else	local wgt "[`wtype'=`uwvar']"
		`traceon'
		capture `noiqui' `noisily'		///
			`cmd1' `wgt'			///
			if `subuse' & `clid' != `j' `cmd2'
		`traceoff'
		if (c(rc) == 1)	error 1
		local bad = c(rc) != 0
		if c(rc) {
			`noi' di in smcl as error ///
`"{p 0 0 2}an error occurred when jackknife executed `cmdname', "' ///
`"posting missing values{p_end}"'
		}
		else {
			if "`checkmat'" != "" {
				_check_omit `checkmat', check result(omit)
			}
			if `"`reject'"' != "" {
				capture local rejected = `reject'
				if c(rc) {
					local rejected 1
				}
			}
			if `omit' {
				local bad 1
				`noi' di as error ///
`"{p 0 0 2}collinearity in replicate sample is "' ///
`"not the same as the full sample, posting missing values{p_end}"'
			}
			else if `rejected' {
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
					// keep the value
					local rd = reldif(`nn', `n0'-`nobs')
					if `rd' > 1e-5 {
						local bad 3
					}
				}
			}
		}
		if "`fpc'" != "" {
			sum `fpc' if `strid' == `strj', meanonly
			scalar `fpcval' = r(min)
		}
		if inlist(`bad', 1, 3) {
			post `postid' `pstrid' (`j') `pfpcval' (.) `missing'
		}
		else {
			sum `ncl' if `strid' == `strj' & `touse' == 1, mean
			post `postid' `pstrid' (`j') `pfpcval'	///
				((r(mean)-1)/r(mean)) `ppseudo'
		}
		`dots' `j' `bad'
		quietly count if `clid' == `j'+1 & `strid' == `strj'
		if r(N) == 0 {
			local ++strj
		}
	}
	`dots' `nclust'
end
exit
