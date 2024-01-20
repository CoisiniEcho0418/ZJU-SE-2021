*! version 6.0.5  15sep2004
program define stir, byable(recall) sort
	version 7, missing
	if _caller()<6 { 
		if _by() { error 190 }
		ztir_5 `0'
		exit
	}
	st_is 2 analysis
	syntax varname [if] [in] [, STrata(varname) noSHow *]

	if `"`strata'"'!=`""' {
		local by `"by(`strata')"'
	}

	st_show `show'

	tempvar touse 
	st_smpl `touse' `"`if'"' `"`in'"'
	if _by() {
		qui replace `touse'=0 if `_byindex'!=_byindex()
	}

	local id : char _dta[st_id]
	local w  : char _dta[st_w]

	if `"`w'"'!=`""' {
		local wt : char _dta[st_wt]
		if `"`wt'"'!=`"fweight"' {
			di as err `"stir does not allow `wt's"'
			exit 101
		}
	}
	tempvar atrisk
	qui gen double `atrisk' = _t - _t0
	label var `atrisk' `"Time"'
	

	tempname xpos
	local ty : type `varlist'
	if substr(`"`ty'"',1,3)==`"str"' { 
		Unstring `varlist' `touse' -> `xpos'
	}
	else	Uncode `varlist' `touse' -> `xpos'

	local label : var label `varlist'
	if trim(`"`label'"')==`""' {
		local label `"`varlist'"'
	}
	label var `xpos' `"`label'"'

	local lbl : var label _d
	if `"`lbl'"'== "" {
		tempvar d 
		qui gen byte `d' = _d
		label var `d' "Failure"
	}
	else	local d _d

	ir `d' `xpos' `atrisk' `w' if `touse', `by' `options'
end

program define Uncode /* vn touse -> xpos */
	args vn touse junk  xpos

	tempname smin smax
	quietly summ `vn' if `touse'
	scalar `smin' = r(min)
	scalar `smax' = r(max)
	qui gen byte `xpos'=cond(`vn'==`smin',0, /*
			*/ cond(`vn'==`smax',1,.)) if `touse'
	capture assert `vn'>=. if `xpos'>=. & `touse'
	if _rc {
		di as err `"`vn' takes on more than two values"'
		exit 134
	}

	local min=`smin'
	local max=`smax'
	local lbl : value label `vn'
	if `"`lbl'"'!=`""' {
		local min : label `lbl' `min'
		local max : label `lbl' `max'
	}
	di _n as txt `"note:  Exposed <-> "' /* 
		*/ as res `"`vn'==`max'"' /*
		*/ as txt `" and Unexposed <-> "' /*
		*/ as res `"`vn'==`min'"'
end

program define Unstring /* vn touse -> xpos */
	args vn touse junk xpos

	quietly {
		sort `touse' `vn'
		by `touse' `vn': gen long `xpos'=1 if _n==1 & `touse'
		replace `xpos'=sum(`xpos')-1 if `touse'
	}
	capture assert `xpos'==1 in l
	if _rc { 
		di as err `"`vn takes on more than two values"'
		exit 134
	}
	local max = `vn'[_N]
	tempvar j
	quietly {
		gen long `j' = _n if `xpos'==0
		replace `j' = `j'[_n-1] if `j'>=.
	}
	local min = `vn'[`j'[_N]]
	di _n as txt `"note:  Exposed <-> "' /* 
		*/ as res `"`vn'==`max'"' /*
		*/ as txt `" and Unexposed <-> "' /*
		*/ as res `"`vn'==`min'"'
end
