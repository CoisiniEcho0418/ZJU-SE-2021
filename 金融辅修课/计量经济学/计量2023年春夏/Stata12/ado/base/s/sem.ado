*! version 1.0.1  07jul2011
program sem, eclass byable(onecall) properties(svyb svyj svylb)
	version 12

	if replay() {
		if ("`e(cmd)'"!="sem") {
			error 301 
		}
		if (_by()) {
			error 190
		}
		
		sem_display `0'
		exit
	}
	quietly ssd query
	local is_ssd = r(isSSD)
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
		if `is_ssd' {
			`BY' ssd query
			error 190	// [sic]
		}
	} 
	local 0 : list retok 0
	`BY' _vce_parserun sem, noeqlist : `0'
	if "`s(exit)'" != "" {
		ereturn scalar df_m = `e(rank)'
		ereturn local cmdline `"sem `0'"'
		exit
	}
	if `is_ssd' {
		Estimate `is_ssd' `0'
	}
	else {
		`BY' EstimateSP 0 `0'
	}
	ereturn local cmdline `"sem `0'"'
end

program EstimateSP, byable(onecall) sortpreserve
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	`BY' Estimate `0'
end

program Estimate, byable(recall)

	gettoken is_ssd 0 : 0

nobreak {
capture noisily break {

	// bytouse will only have by var marked out
	if _by() {
		tempname bytouse
		mark `bytouse'
	}
	tempname SEM 
	if `is_ssd' == 0 {
		tempname touse
	}
	sem_parse_spec `SEM', bytouse(`bytouse') touse(`touse') : `0'
	local display_opts `s(display_opts)'

	// sem_fit() returns in e()			
	mata: st_sem_fit()

} // nobreak 

	local rc = c(rc)

} // capture noisily break

	if "`SEM'" != "" {
		capture mata: rmexternal("`SEM'")
	}
	if `rc' {
		exit `rc'
	}

	if inlist("`e(vce)'", "robust", "cluster", "opg") {
		signestimationsample	`e(oyvars)'	///
					`e(oxvars)'	///
					`e(clustvar)'	///
					`e(groupvar)'
	}

	sem_display, `display_opts'
end

exit
