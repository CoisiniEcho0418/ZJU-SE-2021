*! version 1.0.3  22jan2002
program define isid
	version 7

	foreach word of local 0 {
		if `"`word'"' == "using" {
			Isid_using `0'
			local break break
			continue, break
		}
	}
	if "`break'" != "" {
		exit
	}

	syntax varlist [, Sort Missok ]
	CheckId "`varlist'" "`missok'"
	if "`sort'" != "" {
		CheckAlreadySorted "`varlist'"
		if r(sorted) {
			di as txt `"(data already sorted by `varlist')"'
		}
		else {
			sort `varlist'
			di as txt `"(data now sorted by `varlist')"'
		}
	}

	CheckStrings "`varlist'"
end


program define CheckId, sortpreserve
	args varlist missok

	CheckUniq "`varlist'" "`missok'"
end


program define CheckUniq
	args varlist missok

	if "`missok'" == "" {
		tempvar touse
		gen byte `touse' = 1
		markout `touse' `varlist', strok
		qui count if `touse'
		if r(N) < _N {
			local n : word count `varlist'
			local var = cond(`n'==1, "variable", "variables")
			di as err "`var' `varlist' should never be missing"
			exit 459
		}
	}

	sort `varlist'
	capture by `varlist' : assert _N==1
	if _rc {
		if _rc == 1 { exit 1 }
		local n : word count `varlist'
		local var  = cond(`n'==1, "variable", "variables")
		local does = cond(`n'==1, "does", "do")
		di as err /*
		   */ "`var' `varlist' `does' not uniquely identify the observations"
		exit 459
	}
end


program define Isid_using
	version 7

	gettoken name rest : 0
	while `"`name'"' != "using" {
		gettoken name 0 : 0
		local vars `vars' `name'
		gettoken name rest : 0
		local hasname TRUE
	}
	if "`hasname'" == "" {
		di as err "varlist required"
		exit 100
	}
	syntax using/ [, Sort Missok]
	local myusing `"`using'"'

	preserve
	quietly use `"`myusing'"', clear
	local 0 `"`vars'"'
	syntax varlist

	CheckAlreadySorted "`varlist'"
	local sorted = r(sorted)
	if !(`sorted') {
		sort `varlist'
	}

	CheckUniq "`varlist'" "`missok'"
	if "`sort'" != "" {
		if !(`sorted') {
			qui save, replace
			di as txt `"($S_FN now sorted by `varlist')"'
		}
		else	di as txt `"($S_FN already sorted by `varlist')"'
	}
end


program define CheckAlreadySorted, rclass
	args varlist

	local list : sortedby
	local i 1
	local sorted 1
	foreach name of local varlist {
		local sname : word `i' of `list'
		if "`name'" != "`sname'" {
			local sorted 0
			continue, break
		}
		local i = `i' + 1
	}
	return scalar sorted = `sorted'
end


program define CheckStrings, rclass
	args varlist

	foreach name of local varlist {
		local vtype : type `name'
		if substr("`vtype'",1,3) == "str" {
			capt assert `name' == trim("`name'")
			if !_rc {
				di as txt "variable `name' has leading/trailing blanks"
				di as txt "you are advised to strip them off, e.g.,"
				di as inp "  . replace `name' = trim(`name')"
			}
		}
	}
end
exit
