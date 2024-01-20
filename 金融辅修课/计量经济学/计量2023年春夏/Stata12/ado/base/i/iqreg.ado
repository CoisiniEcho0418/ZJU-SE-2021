*! version 2.2.0  25apr2011
program define iqreg, eclass byable(recall) sort prop(mi)
	version 6.0, missing
	local options "Level(cilevel)"
	if replay() {
		if "`e(cmd)'"!="iqreg" { error 301 } 
		if _by() { error 190 }
		syntax , [`options' *]
		_get_diopts diopts , `options'
	}
	else {
		local cmdline : copy local 0
		syntax varlist [if] [in] [, `options' Quantiles(string) /*
			*/ WLSiter(integer 1) Reps(integer 20) noLOg noDOts *]

		_get_diopts diopts , `options'
		marksample touse

		if "`log'"!="" | "`dots'"!="" {
			local log "*"
		}

		SetQ `quantil'
		local q0 = r(q0)
		local q1 = r(q1)

		if (`reps')<2 { error 198 }

		tempname coefs VCE coefs0 coefs1 handle
		tempvar bcons bwt
		tempfile BOOTRES

		quietly count if `touse'
		if r(N)<4 { 
			di in red "insufficient observations"
			exit 2001
		}

		local opts "wls(`wlsiter')"
		gettoken depv vl : varlist

		_rmcoll `vl' [`weight'`exp'] if `touse'
		local vl `r(varlist)'

		qui regress `depv' `vl' if `touse'
		local i 1
		local j 1
		tokenize `"`vl'"'
		while "``i''" != "" {
			if _se[``i''] == 0 {
				di in blu /*
				*/ "note: ``i'' dropped because of collinearity"
				local `i' " "
			}
			else {
				local result "`result' `coefs1'[1,`j']"
				local j = `j' + 1
			}
			local i = `i' + 1
		}
		local result "`result' `coefs1'[1,`j']"

		preserve
		`log' di in gr "(fitting base model)"

		qui {
			keep if `touse'
			keep `depv' `vl'
			qreg `depv' `vl', `opts' q(`q0')
		}
		if e(N)==0 | e(N)>=. { error 2001 } 
		local nobs `e(N)'
		local tdf `e(df_r)'
		local q `e(q)'
		local rsd1 `e(sum_rdev)'
		local msd1 `e(sum_adev)'
		if "`cons'"=="" {
			local vle "_cons"
			local vli "`bcons'"
		}
		mat `coefs0' = e(b)

		qui qreg `depv' `vl', `opts' q(`q1')
		if e(N) != `nobs' {
			di in red /*
	*/ "`q0' quantile:  `nobs' obs. used" _n /*
	*/ "`q1' quantile:  `e(N)' obs. used" _n /*
	*/ "Same sample cannot be used to estimate both quantiles." /*
	*/ "Sample size probably too small."
			exit 498
		}
		if e(df_r) != `tdf' {
			di in red /*
	*/ "`q0' quantile:  " `nobs'-`tdf' " coefs estimated" _n /*
	*/ "`q1' quantile:  " `e(N)'-`e(df_r)' coefs estimated" _n /*
	*/ "Same model cannot be used to estimate both quantiles." /*
	*/ "Sample size probably too small."
			exit 498
		}
		local msd0 `e(sum_adev)'
		local rsd0 `e(sum_rdev)'
		mat `coefs' = e(b) - `coefs0'

		qui gen double `bwt' = .
		`log' di in gr "(bootstrapping " _c
		qui postfile `handle' `vl' `vli' using "`BOOTRES'", double
		capture noisily {
			local j 1
			while `j'<=`reps' {
				bsampl_w `bwt' /* `recnum' */
				capture noisily {
					qreg_c `depv' `vl', /*
						*/ `opts' q(`q0') wvar(`bwt')
					mat `coefs0' = e(b)
					qreg_c `depv' `vl', /*
						*/ `opts' q(`q1') wvar(`bwt')
					mat `coefs1' = e(b) - `coefs0'
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
		quietly mat accum `VCE' = `vl' `vli', dev nocons
		mat rownames `VCE' = `vl' `vle'
		mat colnames `VCE' = `vl' `vle'
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
		est scalar q0 = `q0'
		est scalar q1 = `q1'
		est scalar sumrdev0 = `rsd0'
		est scalar sumrdev1 = `rsd1'
		est scalar sumadev0 = `msd0'
		est scalar sumadev1 = `msd1'
		est local vcetype "Bootstrap"
		est scalar convcode = 0
		est repost, buildfvinfo
		est local marginsnotok stdp stddp Residuals
		est local predict "qreg_p"
		version 10: ereturn local cmdline `"iqreg `cmdline'"'
		est local cmd "iqreg"
		_post_vce_rank
	}

	PrForm `e(q0)'
	local q0 `r(pr)'
	PrForm `e(q1)'
	local q1 `r(pr)'

	di _n in gr "`e(q1)'-`e(q0)' Interquantile regression" _col(54) _c

	di in gr "Number of obs =" in ye %10.0g e(N)

        di in gr "  bootstrap(" in ye "`e(reps)'" in gr ") SEs" /* 
	*/ _col(54) "`q1' Pseudo R2 =" in ye %10.4f /*
	*/ 1-(`e(sumadev0)'/`e(sumrdev0)')
	di in gr _col(54) "`q0' Pseudo R2 =" in ye %10.4f /*
	*/ 1-(`e(sumadev1)'/`e(sumrdev1)')
	di

	estimates display, level(`level') `diopts'
	error `e(convcode)'
end


program define SetQ /* <nothing> | # [,] # */ , rclass
	if "`*'"=="" {
		ret scalar q0 = .25
		ret scalar q1 = .75
		exit
	}
	local orig "`*'"
	tokenize "`*'", parse(" ,")
	FixNumb "`orig'" `1'
	ret scalar q0 = r(qval)

	mac shift 
	if "`1'"=="," {
		mac shift
	}
	FixNumb "`orig'" `1'
	ret scalar q1 = r(qval)

	mac shift
	if "`*'"!="" { 
		Invalid "`orig'"
	}
	if `return(q0)' >= `return(q1)' {
		Invalid "`orig'" "`return(q0)' >= `return(q1)'"
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
		ret scalar qval = `1'/100
	}
	else 	ret scalar qval = `1'
	if `return(qval)'<=0 | `return(qval)'>=1 {
		Invalid "`orig'" "`return(qval)' out of range"
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
