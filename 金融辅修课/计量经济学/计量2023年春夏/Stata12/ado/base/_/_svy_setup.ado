*! version 1.4.1  15jul2010
program _svy_setup, rclass
	version 9
	syntax [anything] [pw iw] [, SVY * ]
	if "`svy'" == "" {
		syntax [anything] [pw iw] [,		///
			cmdname(name)			///
			over(passthru)			///
			SUBpop(passthru)		///
			SRSsubpop			///
			STRata(varname)			///
			CLuster(varname)		///
			FPC(varname)			///
			RESAMPLING			/// undocumented
		]
	}
	else {
		syntax [anything] [pw iw] [,		///
			cmdname(name)			///
			SVY				///
			BRR				///
			BStrap BOOTstrap		///
			JACKknife JKNIFE		///
			SDR				///
			hasover				///
			over(passthru)			///
			SUBpop(passthru)		///
			SRSsubpop			///
			VCE(string)			///
			STSET				///
			group(passthru)			/// _svy_check_group
			groupoptname(passthru)		/// _svy_check_group
			RESAMPLING			/// undocumented
		]
	}

	if "`bstrap'" != "" {
		local bootstrap bootstrap
	}
	if "`jknife'" != "" {
		local jackknife jackknife
	}

	local kex : word count `brr' `bootstrap' `jackknife' `sdr'
	if `"`vce'"' != "" {
		local ++kex
	}
	if `kex' > 1 {
		opts_exclusive "brr bootstrap jackknife sdr vce()" vce
	}

	local nvars : word count `anything'
	if `nvars' != 2 {
		local 0 `anything'
		syntax namelist(min=2 max=2)
	}
	confirm name `anything'
	tokenize `anything'
	args	touse		/// already exists
		subuse		// new variable

	if "`svy'" != "" {
		if `"`weight'"' != "" {
			di as err ///
		"weights can only be supplied to {help svyset##|_new:svyset}"
			exit 198
		}
		quietly svyset
		if "`r(settings)'" == ", clear" {
			di as err ///
		"data not set up for svy, use {help svyset##|_new:svyset}"
			exit 119
		}
		if "`r(wtype)'" != "" {
			local wvar `"`r(wexp)'"'
			gettoken equal wvar : wvar, parse(" =")
			if "`equal'" != "=" {
				di as err "invalid svyset"
				exit 459
			}
		}
		local numvars `wvar' `r(postweight)'
		local strvars `r(poststrata)'
		local stages = cond(missing(r(stages)), 0, r(stages))
		forval i = 1/`stages' {
			if "`r(su`i')'" != "_n" {
				local su `r(su`i')'
			}
			else	local su
			local strvars	`strvars' `r(strata`i')' `su'
			local numvars	`numvars' `r(fpc`i')'
		}
		local su_last `"`r(su`stages')'"'
		return add
		return local settings
		local strata `return(strata1)'
	}
	else {
		if `"`weight'"' != "" {
			tempvar wvar
			quietly gen `wvar'`exp' if `touse'
		}
		local numvars `wvar' `fpc'
		local strvars `strata' `cluster'
	}
	markout `touse' `numvars'
	markout `touse' `strvars', strok

	// identify subpopulation observations
	_svy_subpop `touse' `subuse',		///
		`over'				///
		`hasover'			///
		`subpop'			///
		wvar(`wvar')			///
		strata(`strata')		///
		`resampling'			///
		// blank
	return add

	if "`cmdname'" != "tabulate" {
		// only -svy:tabulate- cares about the -srssubpop- option
		return local srssubpop
	}

	if "`return(wtype)'" == "pweight" {
		quietly count if `wvar' < 0 & `touse'
		if r(N) {
			error 402
		}
	}
	// check st settings
	if "`stset'" != "" {
		st_is 2 analysis
		_svy_check_stset `"`wvar'"' `"`su_last'"'
		local stid	`"`r(stid)'"'
		local stwgt	`"`r(stwgt)'"'
		local wexp	`"`r(wexp)'"'
		markout `touse' `r(stmarkout)', strok
		if "`return(wtype)'" == "" {
			return local wtype	`"`r(stwt)'"'
			quietly svyset `stwgt', noclear
		}
		return local stid	`"`stid'"'
		return local stwgt	`"`stwgt'"'
		return local wexp	`"`wexp'"'

		// drop observations which are outside the -stset- -if()-,
		// -ever()-, -never()-, -after()-, and -before()- conditions

	    if "`resampling'" == "" {
		quietly replace `subuse' = 0 if _st == 0 | `touse' != 1
		quietly count if `subuse'
		if r(N) == 0 {
			di as err "no observations;" _n ///
"stset and subpop() option identify disjoint subsets of the data"
			exit 2000
		}
	    }
	}
	if `:length local group' {
		_svy_check_group, `group' `groupoptname' lastunit(`su_last')
	}

end
exit
