*! version 1.0.1  20dec2004
program define _btcmd, rclass sortpreserve
        version 6
	if "`1'" == "?" {
		global S_1 "lci uci"
		exit
	}
	gettoken pname 0:0
        syntax varlist(numeric min=4 max=4) [, c1(integer 1) /*
		*/ (c2(integer 2) level(real 0.9) ] /* No hit to level */
	tokenize `varlist'
        marksample touse
        local seq "`1'"
        local treat "`2'"
        local outcome "`3'"
        local period "`4'"

        tempvar pdiff ddiff
        qui gen `pdiff' = .
        qui by __UnIqUe (`period') ,sort: replace `pdiff' = /*
		*/  (`outcome'[`c2'] - `outcome'[`c1']) * 0.5
        qui by __UnIqUe:  replace `pdiff' = . if _n != 1
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

        return scalar uci = `diff' + invttail(return(df),(1-`level')/2) * /*
		*/  return(stuff)
        return scalar lci = `diff' - invttail(return(df),(1-`level')/2) * /*
		*/  return(stuff)

	post `pname' (return(lci)) (return(uci))
end
exit
