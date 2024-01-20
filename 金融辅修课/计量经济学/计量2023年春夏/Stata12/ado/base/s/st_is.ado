*! version 6.0.2  16aug1998
program define st_is
	version 6
	if "`1'"=="2" & `"`_dta[_dta]'"'=="st" & `"`_dta[st_ver]'"'=="2" /*
	*/ & _caller()>5 {
		if "`2'"=="analysis" & `"`_dta[st_full]'"'=="" | /*
		*/ "`2'"=="full" {
			exit
		}
		if "`2'"!="analysis" & "`2'"!="full" { 
			_callerr st_is `0'
		}
		di in red `"you last "streset, `_dta[st_full]'""'
		di in red /*
		*/ `"you must type "streset" to restore the analysis sample"'
		exit 119
	}
	if `"`_dta[_dta]'"'!="st" & _caller()>5 {
		di in red "data not st " _c
		if `"`_dta[_dta]'"'!="" {
			di in red /*
			*/ `"(data are marked as being `_dta[_dta]' data)"'
		}
		else	di
		exit 119
	}

	if _caller()<=5 { 
		zt_is_5 `0'
		exit
	}
		
	if "`1'"!="2" {
		_callerr st_is `0'
	}
	st_promo
end
