*! version 1.4.0  23jun2010
program _robust2, rclass
	version 9
	syntax varlist(numeric) [if] [in]	///
		[pw iw fw aw] [,		///
		SVY				///
		CLuster(varname)		///
		PSU(varname)			/// not documented
		STRata(varname)			///
		FPC(varname numeric)		///
		SUBpop(string asis)		///
		SRSsubpop			/// ignored version >= 9
		Variance(name)			///
		VSRS(name)			///
		minus(numlist max=1 int >=0)	///
		ZEROweight			///
		TOUSE1(name)			///
		ALLCONS				///
		GROUP(varname)			///
	]

	local cluster `cluster' `psu'
	if `:list sizeof cluster' > 1 {
		opts_exclusive "cluster() psu()"
	}

	if "`minus'" == "" {
		local minus 1
	}
	if "`svy'" != "" & "`weight'" != "" {
		di as err ///
"weights can only be supplied to {help svyset##|_new:svyset}"
		exit 198
	}
	if "`svy'" != "" & "`fpc'" != "" {
		di as err ///
"option fpc() can only be supplied to {help svyset##|_new:svyset}"
		exit 198
	}
	if "`svy'" != "" | "`weight'" == "iweight" {
		local zeroweight zeroweight
	}
	marksample touse, `zeroweight'

	if "`variance'" != "" {
		confirm matrix `variance'
	}
	else {
		if "`e(V)'" != "matrix" {
			error 301
		}
		tempname variance vcopy
		matrix `variance' = e(V)
		matrix `vcopy' = e(V)
	}

	local k_scores : list sizeof varlist
	// verify # vars in varlist == # equations is `variance'
	CheckMatrixLabels `k_scores' `variance' `allcons'
	local xvarlist	`"`r(varlist)'"'
	local eqnames	`"`r(eqnames)'"'
	forval i = 1/`k_scores' {
		local eq`i' "`r(eq`i')'"
		local cons`i' "`r(cons`i')'"
	}
	local namelist	`"`r(namelist)'"'
	markout `touse' `fpc'

	if ! `:length local svy' {
		local altsvy = `"`strata'`cluster'`fpc'`subpop'"' != ""
	}
	else	local altsvy 0

	if `:length local svy' {
		// poststratification
		_svyset get posts
		if "`r(poststrata)'" != "" {
			local postopts	posts(`r(poststrata)')	///
					postw(`r(postweight)')
			// do not return vsrs() for poststratification
			local vsrs
		}
		_svyset get wvar
		local wvar `r(wvar)'
	}
	else {
		if `:length local weight' {
			tempvar wvar
			quietly gen double `wvar' `exp' `ifin'
			local wexp `"`:list retok exp'"'
		}
		local stages	1
		local wtype	`weight'
		local fpc1	`fpc'
	}

	// NOTE: '_robust2()' will generate the 'subuse' macro

	tempname v
	matrix `v' = `variance'
	mata: _robust2()
	return add

	// saved results
	matrix `variance'[1,1] = `v'
	if _caller() < 9 {
		if "`vsrs'" != "" {
			if "`srssubpop'" != "" {
				matrix `vsrs' = `vsrs'sub
				capture matrix drop `vsrs'sub
			}
			capture matrix drop `vsrs'wr
			capture matrix drop `vsrs'subwr
			local Vlist `vsrs'
		}
	}
	else {
		if "`vsrs'" != "" {
			local Vlist `vsrs' `vsrs'sub
			if "`fpc1'" != "" {
				local Vlist `Vlist' `vsrs'wr `vsrs'subwr
			}
		}
	}
	foreach mat of local Vlist {
		version 11: matrix colna `mat' = `xvarlist'
		version 11: matrix rowna `mat' = `xvarlist'
		matrix coleq `mat' = `eqnames'
		matrix roweq `mat' = `eqnames'
	}
	if "`svy'`group'" != "" | `altsvy' {
		return scalar df_r = return(N_clust) - return(N_strata)
		if `:length local group' {
			if !`:length local wvar' {
				local wvar `touse'
			}
			if `:length local subpop' {
				local subopt subuse(`subuse')
			}
			GroupPop `wvar',	///
				group(`group')	///
				touse(`touse')	///
				`subopt'	///
				`postopts'
			return scalar N_pop = r(N_pop)
			if `:length local subpop' {
				return scalar N_subpop = r(N_subpop)
			}
		}
	}
	else {
		return local _N_strata
		return local _N_strata_single
		return local _N_strata_certain
		if "`wtype'" == "fweight" {
			return scalar N = return(sum_w)
			if "`cluster'" == "" {
				return scalar N_clust = return(sum_w)
			}
			return scalar df_r = return(sum_w) - 1
		}
		else	return scalar df_r = return(N) - 1
		if "`wtype'" != "" {
			return local wtype `wtype'
			return local wexp  `"`wexp'"'
		}
	}
	if "`touse1'" != "" {
		capture confirm new var `touse1'
		if c(rc) {
			quietly replace `touse1' = `touse'
		}
		else	rename `touse' `touse1'
	}
	if `:length local vcopy' {
		Repost `variance' `vcopy' "`cluster'" `return(N_clust)'
	}
end

program GroupPop, rclass sortpreserve
	syntax [varname],			///
		group(varname)			///
		touse(varname)			///
		[				///
			subuse(varname)		///
			POSTStrata(passthru)	///
			POSTWeight(passthru)	///
		]

	if `:length local poststrata' {
		tempvar w
		if `:length local varlist' {
			local wgt [pw=`varlist']
		}
		svygen post double `w' `wgt' if `touse',	///
			`poststrata' `postweight'
	}
	else	local w `varlist'

	sort `group' `touse' `subuse'
	if `:length local w' {
		sum `w' if `touse' & `group' != `group'[_n+1], meanonly
		return scalar N_pop = r(sum)
		if `:length local subuse' {
			sum `w' if `subuse' & `group' != `group'[_n+1], mean
			return scalar N_subpop = r(sum)
		}
	}
	else {
		count if `touse' & `group' != `group'[_n+1]
		return scalar N_pop = r(N)
		if `:length local subuse' {
			count if `subuse' & `group' != `group'[_n+1]
			return scalar N_subpop = r(N)
		}
	}
end

program Repost, eclass
	args v vcopy cluster nclust
	ereturn repost V = `v'
	ereturn matrix V_modelbased `vcopy'
	ereturn local vcetype "Robust"
	if "`cluster'" != "" {
		ereturn local vce cluster
		ereturn local clustvar "`cluster'"
		ereturn scalar N_clust = `nclust'
	}
	else	ereturn local vce robust
end

program CheckMatrixLabels, rclass
	args k v allcons
	local eqnames	: coleq `v', quote
	local ueq	: list uniq eqnames
	local names	: colna `v'
	local fullna	: colfu `v', quote

	if "`allcons'" == "" {
		local k_eq : list sizeof ueq
	}
	else {
		local k_eq : list sizeof names
	}
	if `k' < `k_eq' {
		error 102
	}
	else if `k' > `k_eq' {
		error 103
	}
	local ucons o._cons _cons
	local vlist : list uniq names
	local vlist : list vlist - ucons
	if `:list sizeof vlist' & "`allcons'" == "" {
		ConfirmVars `vlist'
	}

	if "`allcons'" == "" {
		tempname x
		local cnt0 1
		forval i = 1/`k' {
			local eq : word `i' of `ueq'
			if "`eq'" == "_" {
				if `k' != 1 {
					di as err "invalid equation stripe"
					exit 322
				}
				local fullna : list clean fullna
				local cons : list ucons & fullna
				local cons : list sizeof cons
				local xi : list names - ucons
			}
			else {
				local ignored : subinstr local eqnames	///
					`""`eq'""' "",			///
					all word count(local cnt)
				local cnt1 = `cnt0' + `cnt' - 1
				matrix `x' = `v'[1,`cnt0'..`cnt1']
				local xvars : colna `x'
				local cons : list ucons & xvars
				local cons : list sizeof cons
				local xi : list xvars - ucons
				local cnt0  = `cnt0' + `cnt'
			}
			return local eq`i' `"`xi'"'
			if !`cons' {
				return local cons`i' nocons
			}
		}
	}
	else {
		forval i = 1/`k' {
			local conslist `conslist' _cons
		}
	}
	return local varlist	`"`names'"'
	_mat_clean_coleq eqnames : `eqnames'
	return local eqnames	`"`eqnames'"'
	if "`allcons'" != "" {
		return local namelist `"`conslist'"'
	}
	else	return local namelist `"`names'"'
end

program ConfirmVars
	syntax [varlist(fv ts numeric default=none)]
end

exit
