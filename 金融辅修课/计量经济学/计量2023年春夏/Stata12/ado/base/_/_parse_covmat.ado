*! version 1.0.2  01apr2009

/* Used by -gmm- to parse wmat() and vce() options */	
program _parse_covmat, sclass

	args cov covtype touse
	
	sret clear
	
	if "`covtype'" != "vce" & "`covtype'" != "wmatrix" {
		di as error "ParseCovMat called improperly"
		exit 2000
	}

	gettoken cov options : cov, parse(",")
	gettoken clustvar options : options, parse(",")
	local options : list clean options	// remove leading space
	if "`options'" != "" {
		local optlen : length local options
		if "`options'" == substr("independent", 1, max(5, `optlen')) {
			sreturn local covopt "independent"
		}
		else {
			di as error	///
				"option {opt `covtype'()} incorrectly specified"
				exit 198
		}
	}
	local lkey : length local cov
	if "`covtype'" == "wmatrix" & "`cov'" == "" {	// default wmat(r)
		sreturn local covtype "robust"
		exit
	}
	if "`cov'" == "" | "`cov'" == substr("unadjusted", 1, max(2, `lkey')) {
		sreturn local covtype "unadj"
		exit
	}
	if `"`cov'"' == substr("robust", 1, max(1,`lkey')) {
		sreturn local covtype "robust"
		exit
	}
	
	// Cluster ?
	local word1 : word 1 of `cov'
	local clustvar : word 2 of `cov'
	local word1len : length local word1
	if `"`word1'"' == substr("cluster",1,max(2,`word1len')) {
		capture noi confirm var `clustvar'
		if _rc {
			di as error ///
				"option {opt `covtype'()} incorrectly specified"
			exit 198
		}
		unab clustvar : `clustvar'
		sreturn local covtype "cluster"
		sreturn local covclustvar "`clustvar'"
		exit
	}
	
	// HAC
	if `"`word1'"' != "hac" {
		di as error "option {opt `covtype'()} incorrectly specified"
		exit 198
	}

	local kernel : word 2 of `cov'
	local kernlen : length local kernel
	local ktype ""
	if `"`kernel'"' == substr("nwest", 1, max(2,`kernlen')) |	///
		`"`kernel'"' == substr("bartlett", 1, max(2,`kernlen')) {
		local ktype "bartlett"
	}
	else if `"`kernel'"' == substr("gallant", 1, max(2,`kernlen')) | ///
		`"`kernel'"' == substr("parzen", 1, max(2,`kernlen')) {
		local ktype "parzen"
	}
	else if `"`kernel'"' == 					///
		substr("quadraticspectral", 1, max(2, `kernlen')) |	///
		`"`kernel'"' == substr("andrews", 1, max(2,`kernlen')) {
		local ktype "quadraticspectral"
	}
	
	if "`ktype'" == "" {
		di as error "invalid kernel in option {opt `covtype'()}"
		exit 198
	}
	sreturn local covtype "hac"
	sreturn local covhac "`ktype'"
	
	local wordcnt : word count `cov'
	if `wordcnt' == 3 {
		local lag : word 3 of `cov'

		if `"`lag'"' == substr("optimal", 1, 			///
					max(3,`:length local lag')) {
			sreturn local covhaclag -1
			exit
		}
		else {		
			if "`ktype'" == "bartlett" | "`ktype'" == "parzen" {
				capture confirm integer number `lag'
				if _rc {
					di in smcl as error ///
"invalid lag specification in {opt `covtype'()}"
					exit 198
				}
				if `lag' < 0 {
					di in smcl as error ///
"number of lags in {opt `covtype'()} cannot be negative"
					exit 198
				}
				qui count if `touse'
				if `lag' >= r(N) {
					di as error	///
"number of lags in {opt `covtype'()} must be less than the sample size"
					exit 198
				}
			}
			else if "`ktype'" == "quadraticspectral" {
				capture confirm number `lag'
				if _rc {
					di as error ///
"invalid lag specification in option {opt `covtype'()}"
					exit 198
				}
				if `lag' < 0 {
					di in smcl as error ///
"number of lags in {opt `covtype'()} cannot be negative"
					exit 198
				}
			}
			sreturn local covhaclag `lag'
			exit
		}
	}
	if `wordcnt' == 2 {
		qui count if `touse'
		sreturn local covhaclag `=`r(N)' - 2'
		exit
	}

	di as error "option {opt `covtype'()} incorrectly specified"
	exit 198

end
