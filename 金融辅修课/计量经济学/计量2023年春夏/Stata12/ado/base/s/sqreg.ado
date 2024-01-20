*! version 2.4.0  25apr2011
program define sqreg, eclass byable(recall) sort prop(mi)
	version 6.0, missing
	local options "Level(cilevel)"
	if replay() {
		if "`e(cmd)'"!="sqreg" { error 301 } 
		if _by() { error 190 }
		syntax [, `options' *]
		_get_diopts diopts options , `options'
	}
	else {
		local cmdline : copy local 0
		syntax varlist [if] [in] [, `options' Quantiles(string) /*
			*/ WLSiter(integer 1) Reps(integer 20) noLOg noDOts *]

		_get_diopts diopts options , `options'
		marksample touse

		if "`log'"!="" | "`dots'"!="" {
			local log "*"
		}

		SetQ `quantil'
		tokenize "`r(quants)'"
		local nq 1
		while "``nq''" != "" {
			local q`nq' ``nq''
			local nq = `nq' + 1
		}
		local nq = `nq' - 1
			
		if (`reps')<2 { error 198 }

		tempname coefs VCE coefs0 coefs1 handle
		tempvar e bcons bwt
		tempfile BOOTRES

		quietly count if `touse'
		if r(N)<4 { 
			di in red "insufficient observations"
			exit 2001
		}

		local opts "wls(`wlsiter')"
		gettoken depv rhs : varlist
		_rmcoll `rhs' [`weight'`exp'] if `touse'
		local rhs `r(varlist)'
		qui regress `depv' `rhs' if `touse'
		
		tokenize "`rhs'"
		local i 1
		while "``i''" != "" {
			if _se[``i''] == 0 {
				di in blu /*
			*/ "note: ``i'' dropped because of collinearity"
				local `i' " "
			}
			local i = `i' + 1
		}

		local pow = 10
		local done = 0
		while !`done' {
			local pow = `pow'*10
			local done = 1
			forvalues k=1/`nq' {
				local q = (`q`k'')*`pow'
				local done = `done' & /* 
					*/ (reldif(`q',trunc(`q'))<c(epsfloat))
			}
		}
		local f = ceil(log10(`pow'))
		forvalues k=1/`nq' {
			local myeq = "q" + /*
				*/ string(trunc((`q`k'')*`pow'),"%0`f'.0f")
			local eqnames `eqnames' `myeq'
		}
		local eqnames : list uniq eqnames
		local k : word count `eqnames'
		if `k' < `nq' {
			di as err "only `k' out of `nq' quantiles are " /*
			 */ "unique within a relative precision of c(epsfloat)"
			exit 498
		}
		local k 1 
		while `k' <= `nq' {
			tempname coef`k'
			local myeq : word `k' of `eqnames'
			local i 1
			while "``i''" != "" {
				local result "`result' `coef`k''[1,`i']"
				local eqnams "`eqnams' `myeq'"
				local conams "`conams' ``i''"
				tempvar v
				local vl "`vl' `v'"
				local i = `i' + 1
			}
			local result "`result' `coef`k''[1,`i']"
			local eqnams "`eqnams' `myeq'"
			local conams "`conams' _cons"
			tempvar v
			local vl "`vl' `v'"
			local k = `k' + 1
		}

		preserve
		`log' di in gr "(fitting base model)"

		qui {
			keep if `touse'
			keep `depv' `rhs'
			qreg `depv' `rhs', `opts' q(`q1')
		}
		if e(N)==0 | e(N)>=. { error 2001 } 
		local nobs `e(N)'
		local tdf `e(df_r)'
		local rsd1 `e(sum_rdev)'
		local msd1 `e(sum_adev)'

		local vle "_cons"
		local vli "`bcons'"

		mat `coefs' = e(b)

		local k 2
		while `k' <= `nq' {
			qui qreg `depv' `rhs', `opts' q(`q`k'')
			if e(N) != `nobs' {
				di in red /*
	*/ "`q0' quantile:  `nobs' obs. used" _n /*
	*/ "`q`k'' quantile:  `e(N)' obs. used" _n /*
	*/ "Same sample cannot be used to estimate both quantiles." /*
	*/ "Sample size probably too small."
				exit 498
			}
			if e(df_r) != `tdf' {
				di in red /*
	*/ "`q0' quantile:  " `nobs'-`tdf' " coefs estimated" _n /*
	*/ "`q`k'' quantile:  " `e(N)'-`e(df_r)' coefs estimated" _n /*
	*/ "Same model cannot be used to estimate both quantiles." /*
	*/ "Sample size probably too small."
				exit 498
			}
			local msd`k' `e(sum_adev)'
			local rsd`k' `e(sum_rdev)'
			mat `coefs' = `coefs', e(b)

			local k = `k' + 1
		}
		mat colnames `coefs' = `conams'
		mat coleq `coefs' = `eqnams'

		qui gen double `bwt' = .
		`log' di in gr "(bootstrapping " _c
		qui postfile `handle' `vl' using "`BOOTRES'", double
		quietly noisily {
			local j 1
			while `j'<=`reps' {
				bsampl_w `bwt'
				capture noisily {
					local k 1
					while `k'<=`nq' {
						qreg_c `depv' `rhs', /*
						*/ `opts' q(`q`k'') wvar(`bwt')
						mat `coef`k'' = e(b)
						local k =`k' + 1
					}
				}
				local rc = _rc
				if (`rc'==0) {
					post `handle' `result'
					`log' di in gr "." _c
					local j=`j'+1
				}
				else {
					if _rc == 1 { exit 1 }
					`log' di in gr "*" _c
				}
			}
		}
		local rc = _rc 
		postclose `handle'
		if `rc' { 
			exit `rc'
		}

		qui use "`BOOTRES'", clear

		quietly mat accum `VCE' = `vl', dev nocons
		mat rownames `VCE' = `conams'
		mat roweq `VCE' = `eqnams'
		mat colnames `VCE' = `conams'
		mat coleq `VCE' = `eqnams'
		mat `VCE'=`VCE'*(1/(`reps'-1))

		est post `coefs' `VCE', obs(`nobs') dof(`tdf') depn(`depv')

		`log' noi di in gr ")"
		restore
		est repost, esample(`touse')
		capture erase "`BOOTRES'"

		est local depvar "`depv'"
		est scalar reps = `reps'
		est scalar N = `nobs'
		est scalar df_r = `tdf'

		local k 1
		while `k' <= `nq' {
			est scalar q`k' = `q`k''
			est scalar sumrdv`k' = `rsd`k''
			est scalar sumadv`k' = `msd`k''
			local k = `k' + 1
		}
		est scalar n_q = `nq'
		est local eqnames "`eqnames'"
		est local vcetype "Bootstrap"
		est scalar convcode = 0
		est repost, buildfvinfo
		est local marginsnotok stdp stddp Residuals
		est local predict "sqreg_p"
		version 10: ereturn local cmdline `"sqreg `cmdline'"'
		est local cmd "sqreg"
		_post_vce_rank
	}

	di _n in gr "Simultaneous quantile regression" _col(54) _c

	di in gr "Number of obs =" in ye %10.0g e(N)

	PrForm `e(q1)'
        di in gr "  bootstrap(" in ye "`e(reps)'" in gr ") SEs" /* 
	*/ _col(54) "`r(pr)' Pseudo R2 =" in ye %10.4f 1-(e(sumadv1)/e(sumrdv1))

	local k 2
	while `k' <= e(n_q) {
		PrForm `e(q`k')'
		di in gr /*
		*/ _col(54) "`r(pr)' Pseudo R2 =" /*
		*/ in ye %10.4f 1-(e(sumadv`k')/e(sumrdv`k'))
		local k = `k' + 1
	}
	di

	estimates display, level(`level') `diopts'
	error `e(convcode)'
end


program define SetQ /* <nothing> | # [,] # ... */ , rclass
	if "`*'"=="" {
		ret local quants ".5"
		exit
	}
	local orig "`*'"
	tokenize "`*'", parse(" ,")

	while "`1'" != "" {
		FixNumb "`orig'" `1'
		ret local quants "`return(quants)' `r(q)'"
		mac shift 
		if "`1'"=="," {
			mac shift
		}
	}
end


program define FixNumb /* # */ , rclass
	local orig "`1'"
	mac shift
	capture confirm number `1'
	if _rc {
		Invalid "`orig'" "`1' not a number"
	}
	if `1' >= 1 {
		ret local q = `1'/100
	}
	else 	ret local q `1'
	if `return(q)'<=0 | `return(q)'>=1 {
		Invalid "`orig'" "`return(q)' out of range"
	}
end
		

program define Invalid /* "<orig>" "<extra>" */
	di in red "quantiles(`1') invalid"
	if "`2'" != "" {
		di in red "`2'"
	}
	exit 198
end

program define PrForm /* # */ , rclass
	local aa : di %8.2f `1'
	ret local pr `aa'
	if substr("`return(pr)'",1,1)=="0" {
		ret local pr = substr("`return(pr)'",2,.)
	}
end
exit
