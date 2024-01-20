*! version 3.4.4  23dec2004
program define pkequiv, rclass sortpreserve
	version 6, missing
	syntax varlist(numeric min=5) [if] [in] [, COMpare(string) /*
		*/ LImit(real 0.20) LEvel(passthru) SYMmetric FIEller /*
		*/ noBoot TOST ANDERson ]

	marksample touse
	qui count if `touse'
	if r(N)==0 {
		error 2000
	}
	tokenize `varlist'
	if `limit' < .10 | `limit' > .99 {
		di in red `"limit(`limit') invalid"'
		exit 198
	}
	if "`level'" == "" {
		local level 90
	}
	else {
		local zero `0'
		local 0 ", `level'"
		syntax [, level(cilevel)]
		local 0 `zero'
	}

	local outcome  "`1'"
	local vtreat  "`2'"
	local period  "`3'"
	local seq "`4'"
	local id "`5'"
	
	local level = `level' / 100
	tempvar treat
	qui by `vtreat', sort: gen `treat' = 1 if _n == 1
	qui replace `treat' = sum(`treat')	
	su `treat', meanonly
	if r(max) > 2 & "`compare'" == "" {
		di in red "must specify an equivalence comparison /*
			*/ if more than 2 treatments"
		exit 198
	}
	if "`compare'" != "" {
		local cnt : word count `compare'
		if `cnt' > 2  {
			di in red "only 2 treatments can be compared at a time"
			exit 198
		}
		if `cnt' < 2  {
			di in red "must specify 2 treatments to be compared"
			exit 198
		}
		local c1 : word 1 of `compare'
		capture confirm number `c1'
		if _rc {
			di in red "compare must be a number"
			exit 198
		}
		qui count if `treat' == `c1'
		if r(N) == 0 {
			di in red "compare treatment `c1' not in dataset"
			exit 459
		}
		local c1p `"c1(`c1')"'
		local c2 : word 2 of `compare'
		capture confirm number `c2'
		if _rc {
			di in red "compare must be a number"
			exit 198
		}
		qui count if `treat' == `c2'
		if r(N) == 0 {
			di in red "compare treatment `c2' not in dataset"
			exit 459
		}
		local c2p `"c2(`c2')"'
		if `c1' == `c2' {
			di in red "comparison treatments must be different"
			exit 198
		}
	}	
	

	sort `id' `treat'
	classic `id' `seq' `treat' `outcome' `period' , /*
		*/ `c1p' `c2p' level(`level') limit(`limit') `boot' /*
		*/ `symmetric' `fieller' `tost' `anderson'
	return scalar lci = r(lci)
	return scalar uci =r(uci)
	return scalar stddev = r(stddev)
	if "`symmetric'" != "" & "`fieller'" == "" {
		symmetric `outcome' `treat', /*
			*/ `c1p' `c2p' stuff(`r(stuff)') df(`r(df)') level(`level')
		return scalar delta = r(delta)
	}
	if "`fieller'" != "" & "`symmetric'" == "" {
		fieller `id' `seq' `treat' `outcome' `period' , /*
			*/ `c1p' `c2p' level(`level') limit(`limit') df(`r(df)')
		return scalar l3 = r(l3)
		return scalar u3 = r(u3)
	}
	if "`fieller'" != "" & "`symmetric'" != "" {
		di in red /*
*/ "only one method of equivalence test can be done at a time"
		exit 198
	}
	if "`c1'" == "" {
		local c1 1
	}
	noi di _col(7) as txt "note: reference treatment = `c1'"
end

program define fieller, rclass sortpreserve

	syntax varlist(numeric min=5 max=5) [, c1(real 1) c2(real 2) /*
		*/ level(real 0.9) limit(real 0.2) df(integer 0) ]
	tokenize `varlist'
	local id "`1'"
	local seq "`2'"
	local treat "`3'"
	local outcome "`4'"
	local period "`5'"

	tempvar s1p1 s1p2 s2p1 s2p2

        su `outcome' if `treat' == `c1' , meanonly
	local rmean = r(mean)
        su `outcome' if `treat' == `c2', meanonly
	local tmean = r(mean)
	qui count if `treat' == `c1'
	local n1 = r(N)
	qui count if `treat' == `c2'
	local n2 = r(N)

	local omega = (1/2) * ((1/`n1') + (1/`n2'))

        su `outcome' if `seq' == 1 & `period' == 1, meanonly
	qui gen `s1p1' = `outcome' - r(mean) if `seq' == 1 & `period' == 1 	

        su `outcome' if `seq' == 1 & `period' == 2, meanonly
	qui gen `s1p2'= `outcome' - r(mean) if `seq' == 1 & `period' == 2

        su `outcome' if `seq' == 2 & `period' == 1, meanonly
	qui gen `s2p1'= `outcome' - r(mean) if `seq' == 2 & `period' == 1

        su `outcome' if `seq' == 2 & `period' == 2, meanonly
	qui gen `s2p2'= `outcome' - r(mean) if `seq' == 2 & `period' == 2

	sort `id' `period'
	tempvar prods1 prods2

	qui gen `prods1' = `s1p1' * `s1p2'[_n+1]
	qui gen `prods2' = `s2p1' * `s2p2'[_n+1]

	su `prods1', meanonly
	local junk = r(sum)
	su `prods1', meanonly
	local str = 1/`df' * (`junk' + r(mean))

	qui replace `s1p1' = `s1p1' * `s1p1'
	qui replace `s2p1' = `s2p1' * `s2p1'
	qui replace `s1p2' = `s1p2' * `s1p2'
	qui replace `s2p2' = `s2p2' * `s2p2'

	su `s1p1', meanonly
	local junk = r(sum)	
	su `s2p2', meanonly
	local srr = 1/`df' * (`junk' + `r(sum)')
	
	su `s2p1', meanonly
	local junk = r(sum)	
	su `s1p2', meanonly
	local stt = 1/`df' * (`junk' + r(sum))

	local rtest = `rmean' / sqrt(`omega' * `srr')
	local ttest = `tmean' / sqrt(`omega' * `stt')
	if `rtest' <= invttail(`df', (1-`level')/2) | /*
		*/ `ttest' <= invttail(`df', (1-`level')/2) {
		di _n
		di in red "no real solution to quadratic equation for Fieller"
		exit 406
	}

	local g = (1/`rtest'^2) * ((invttail(22,.05))^2)

	local gstar2 = (`tmean'/`rmean')^2 + `stt'/`srr'*(1-`g') +  /*
		*/ `str'/`srr' * (`str'/`srr'*`g' - `tmean'/`rmean'*2)

	return scalar l3 = 1/(1-`g') * ((`tmean'/`rmean' - `str'/`srr'*`g') /*
		*/ - (invttail(`df', (1-`level')/2)*(1/`rtest')*(sqrt(`gstar2'))))
	return scalar u3 = 1/(1-`g') * ((`tmean'/`rmean' - `str'/`srr'*`g') /*
		*/ + (invttail(`df', (1-`level')/2)*(1/`rtest')*(sqrt(`gstar2'))))

#delimit ;
	di _n;
	di in gr _col(7) 
	"Confidence interval for bioequivalence based on Fieller's theorem" ;
	di in smcl in gr _col(7) "{hline 70}" ;
	di in gr _col(25) 
	" [equivalence limits]       [    test mean   ]" ;
	di in smcl in gr _col(7) "{hline 70}" ;
	di in gr _col(7) 
	"Test formulation:  " in ye %9.3f return(l3) " " %9.3f return(u3) 
	"            "  %9.3f `tmean' ;
	di in smcl in gr _col(7) "{hline 70}" ;
#delimit cr
end


program define symmetric, rclass sortpreserve
	syntax varlist(numeric min=1) [, c1(integer 1) c2(integer 2) /*
		*/ stuff(real 0.0) df(integer 1) level(real 0.9) ]

	local outcome "`1'"
	local treat "`2'"
	gettoken treat:treat, parse(,)

	su `outcome' if `treat' == `c1' , meanonly
	local rmean = r(mean)
	su `outcome' if `treat' == `c2' , meanonly
	local tmean = r(mean)
	return scalar cons = (2 * (`rmean' - `tmean')) / `stuff'

/* This is just stuff I need later in the calling program */
	return scalar stuff = `stuff'
	return scalar df = `df'

	tempname inc k1 k2 myp delta
	scalar `k1' = return(cons) / 2
	scalar `k2' = return(cons) / 2
	scalar `inc' = 0.001

	scalar `myp' = 1 - tprob(`df',return(cons) / 2 )
	if "`myp'" < "`level'" {
	/* This means there is no C.I. that satisfies the constraints */
	/* I don't want to crash out, this is rare and should not prevent */
	/* the rest of the program from working	*/
		exit
	}
	scalar `myp' = tprob(`df',`k1')/2 + tprob(`df',`k2')/2
        while `myp'>= 1-`level' {
                scalar `k1'=`k1'+`inc'
                scalar `k2'=`k2'- `inc'
                scalar `myp' = tprob(`df',`k1')/2 + tprob(`df',`k2')/2
        }

	return scalar delta = (`k1' * `stuff') - (`rmean' - `tmean') 

#delimit ;
	di _n;
	di in gr _col(7) 
	"Westlake's symmetric confidence interval for bioequivalence" ;
	di in smcl in gr _col(7) "{hline 70}" ;
	di in smcl in gr _col(25) " [Equivalence limits]       [    Test mean   ]" ;
	di in smcl in gr _col(7) "{hline 70}" ;
	di in smcl in gr _col(7) "Test formulation:  " in ye %9.3f `rmean' - return(delta) " " %9.3f `rmean' + return(delta) "            "  %9.3f `tmean' ;
	di in smcl in gr _col(7) "{hline 70}" ;
#delimit cr
end

program define classic, rclass sortpreserve
	syntax varlist(numeric min=5 max=5) [, c1(real 1) c2(real 2) /*
		*/ level(real 0.9) limit(real 0.2) noBoot symmetric /* 
		*/ fieller tost anderson ]
	tokenize `varlist'
	marksample touse
	local id "`1'"
	local seq "`2'"
	local treat "`3'"
	local outcome "`4'"
	local period "`5'"

	local ru = (1+`limit')*100
	local rl = (1-`limit')*100
				
	tempvar pdiff ddiff
	tempfile bootres
	qui gen `pdiff' = .
	qui by `id': replace `pdiff' = (`outcome'[`c1'] - `outcome'[`c2']) * 0.5
	qui by `id': replace `pdiff' = . if _n != 1
	su `pdiff' if `seq' == 1,meanonly
	qui gen `ddiff' = (`pdiff' - r(mean))^2 if `seq' == 1
	su `pdiff' if `seq' == 2,meanonly
	qui replace `ddiff' = (`pdiff' - r(mean))^2 if `seq' == 2
	su `ddiff', meanonly
	return scalar stddev = sqrt(r(sum) / (_N/2 - 2))
	qui drop `ddiff' `pdiff'
	
	qui su `outcome' if `treat' == 2, meanonly
	local test = r(mean)
	qui su `outcome' if `treat' == 1, meanonly
	local ref = r(mean)
	local diff = `test' - `ref'

	qui count if `seq' == 1
	local cnt1 = r(N)*.5
	qui count if `seq' == 2
	local cnt2 = r(N)*.5
	return scalar df = `cnt1' + `cnt2' - 2

	return scalar stuff = return(stddev) * sqrt(1/`cnt1' + 1/`cnt2')
	
	return scalar uci = `diff' + invt(return(df),`level') * return(stuff)
	return scalar lci = `diff' - invt(return(df),`level') * return(stuff)

	qui su `outcome' if `treat' == `c1'
	local llim = -`limit' * r(mean)
	local ulim = `limit' * r(mean)
	
	if "`boot'" == "" & "`symmetric'" == "" & "`fieller'" == "" {

		qui bstrap _btcmd , args(`seq' `treat' `outcome' /*
			*/ `period', c1(`c1') c2(`c2') level(`level')) /*
			*/ reps(1000) saving(`bootres') cluster(`id') id(__UnIqUe)

		preserve
		qui use `"`bootres'"', clear
		qui count if inrange(`diff', lci, uci)
		local cover = r(N) / _N
		qui count if lci < `llim' | uci > `ulim'
		local wilim = (_N - r(N)) / _N
		if lci >= . & uci >= . {
			local wilim = .
		}
		su lci, meanonly
		local lower = r(mean)
		su uci, meanonly
		local upper = r(mean)	
		restore
	}

	if "`symmetric'" == "" & "`fieller'" == "" {
		su `outcome' if `treat' == `c1', meanonly
#delimit ;
		di ;
		di in gr _col(7) 
		"Classic confidence interval for bioequivalence" ;
		di in smcl in gr _col(7) "{hline 70}" ;
		di in smcl in gr _col(25) 
		" [equivalence limits]        [    test limits   ]" ;
		di in smcl in gr _col(7) "{hline 70}" ;
		di in smcl in gr _col(7) 
		"     difference: " in ye %9.3f `llim' "    " %9.3f `ulim' "      "  %9.3f return(lci) "    "  %9.3f return(uci) ;
		di in smcl in gr _col(7) 
		"          ratio: ""      `rl'%         `ru'%      " in ye %9.3f 
		(return(lci)/r(mean) + 1)*100 "%"   "   "   %9.3f (return(uci)/r(mean) + 1)*100 "%" ;
		di in smcl in gr _col(7) "{hline 70}" ;


		if "`boot'" == "" { ;
*			di in smcl in gr _col(7) "    probability test limits cover the true difference = " in ye %9.4f `cover' ;
			di in smcl in gr _col(7) "probability test limits are within equivalence limits = " in ye %9.4f `wilim' ;
		} ;
#delimit cr
		if "`tost'" != "" {
			di
			di in smcl in gr _col(7) "Schuirmann's two one-sided tests"
			di in smcl in gr _col(7) "{hline 70}"
			di in smcl in gr _col(7) "upper test statistic = " /*
				*/ in ye %9.3f ((`test' - `ref') - .2 * /*
				*/ r(mean))/(return(stddev)*sqrt(1/`cnt1'+1/`cnt2')) /*
				*/  _skip(19) "p-value = " in ye %9.3f /*
				*/ tprob(`cnt1'+`cnt2' - 2, abs(((`test' - `ref') /*
				*/ - .2 * r(mean))/(return(stddev)*sqrt(1/`cnt1' /* 
				*/ + 1/`cnt2'))))
			di in smcl in gr _col(7) "lower test statistic = " /*
				*/ in ye %9.3f ((`test' - `ref') + .2 * /*
				*/ r(mean))/(return(stddev)*sqrt(1/`cnt1' + 1/`cnt2')) /*
				*/ _skip(19) "p-value = " in ye %9.3f /*
				*/ tprob(`cnt1'+`cnt2' - 2, abs(((`test' - `ref') /*
				*/ + .2 * r(mean))/(return(stddev)*sqrt(1/`cnt1' /*
				*/ + 1/`cnt2'))))
		}
		if "`anderson'" != "" {
			di
			di in smcl in gr _col(7) "Anderson and Hauck's test"
			di in smcl in gr _col(7) "{hline 70}"
			local nonpar = (((.2 * r(mean)) - (-.2 * r(mean))) / 2 ) /*
				*/ / (return(stddev)*sqrt(1/`cnt1' + 1/`cnt2'))
			di in smcl in gr _col(7) "noncentrality parameter = " in ye %9.3f `nonpar'
			local stat = ((`test' - `ref') - ((-.2 * r(mean)) + /*
				*/ (.2 * r(mean)))/2)/(return(stddev)*sqrt(1/`cnt1' /* 
				*/ + 1/`cnt2'))
			di in smcl in gr _col(7) "         test statistic = " in ye %9.3f /*
				*/ `stat'  in gr  "      empirical p-value = " /*
				*/ in ye %9.4f tprob(`cnt1'+`cnt2' - 2 , /*
				*/ abs(`stat') - `nonpar') / 2 - tprob(`cnt1'+`cnt2' /*
				*/ - 2 , -abs(`stat') - `nonpar') / 2  
		}			
	}
end
exit


