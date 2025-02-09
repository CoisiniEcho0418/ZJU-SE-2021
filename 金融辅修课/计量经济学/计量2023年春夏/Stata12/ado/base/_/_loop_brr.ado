*! version 1.3.1  25jan2010
program _loop_brr
	version 9
	set buildfvinfo off			// auto-reset on exit
	syntax namelist(min=5) ,		///
		command(string asis)		///
		express(string asis)		///
		cmd1(string asis)		///
		wvar(varname)			///
		Hadamard(name)			///
		FAY(numlist >=0 <= 2 max=1)	///
		postid(name)			///
		[				///
			POSTS(varname)		///
			POSTW(varname numeric)	///
			pstrwvar(varname)	///
			cmd2(string asis)	///
			noDOTS			///
			NOIsily			///
			trace			///
			reject(string asis)	///
			stset			///
			checkmat(name max=1)	///
		]
	gettoken cmdname : command
	local is_st = "`stset'" != ""
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
	gettoken psuid  pseudo   : namelist
	if `K' != `: word count `pseudo'' {
		di as err "internal error in brr"
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
	if `fay' == 0 {
		local inwgt "2*`wvar'"
		local outwgt "0"
	}
	else if `fay' == 2 {
		local inwgt "0"
		local outwgt "2*`wvar'"
	}
	else {
		local inwgt "(2-`fay')*`wvar'"
		local outwgt "`fay'*`wvar'"
	}

	tempname h
	local ncols = colsof(`hadamard')
	matrix `h' = (J(`ncols',`ncols',3)-`hadamard')/2
	if "`nodots'" == "" | "`noisily'" != "" {
		di
		_dots 0, title(BRR replications) reps(`ncols') `nodots'
	}
	local omit 0
	local rejected 0
	forval j = 1/`ncols' {
		// adjust weights
		quietly replace `twvar' = ///
		cond(`h'[`j',`strid']==`psuid',`inwgt',`outwgt')
		if "`posts'" != "" {
			capture drop `pstrwvar'
			svygen post double `pstrwvar' [iw=`twvar'] ///
				if `touse' == 1, `pstr'
		}
		`noi' di as inp `". `command'"'
		if `is_st' {
			quietly streset [iw=`uwvar']
		}
		else	local wgt "[iw=`uwvar']"
		`traceon'
		capture `noiqui' `noisily'	///
			`cmd1' `wgt' if `subuse' `cmd2'
		`traceoff'
		if (c(rc) == 1)	error 1
		local bad = c(rc) != 0
		if c(rc) {
			`noi' di in smcl as error ///
`"{p 0 0 2}an error occurred when brr executed `cmdname', "' ///
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
			}
		}
		if inlist(`bad', 1, 3) {
			post `postid' `missing'
		}
		else {
			post `postid' `ppseudo'
		}
		`dots' `j' `bad'
	}
	`dots' `ncols'
end
exit
