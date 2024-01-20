*! version 1.0.0  25aug2009
program _ms_unab
	version 11
	gettoken user  0 : 0, parse(" :")
	gettoken colon 0 : 0, parse(" :")
	if (`"`colon'"' != ":") error 198

	syntax [anything] [, MIN(integer 1) MAX(integer 32000) NAME(string)]

	local L : list sizeof anything
	if !inrange(`L', `min', `max') {
		Error `L' `min' `max' `"`name'"' `anything'
	}

	forval c = 1/`L' {
		gettoken el anything : anything
		_ms_parse_parts	`el'
		local isprod = inlist(r(type), "interaction", "product")
		local ch = cond(r(type) == "product", "*", "#")
		if `isprod' {
			local EL
			local K = r(k_names)
			forval i = 1/`K' {
				capture unab name : `r(name`i')', max(1)
				if c(rc) {
					local name `"`r(name`i')'"'
				}
				if `"`r(op`i')'"' != "" {
					local name `r(op`i')'.`name'
				}
				local EL `EL'`prod'`name'
				local prod : copy local ch
			}
		}
		else {
			capture unab EL : `r(name)', max(1)
			if c(rc) {
				local EL `r(name)'
			}
			if "`r(op)'" != "" {
				local EL `r(op)'.`EL'
			}
		}
		local USER `USER' `EL'
	}
	c_local `user' `USER'
end

program Error
	gettoken L    0 : 0
	gettoken min  0 : 0
	gettoken max  0 : 0
	gettoken name 0 : 0

	if `"`name'"' == "" {
		di as err `"`0':"'
		error cond(`n'<`min', 102, 103)
	}
	if `L' < `min' {
		di as err `"`name':  too few variables specified"'
	}
	else	di as err `"`name':  too many variables specified"'
	local l = length(`"`name'"') + 4 
	di as err _col(`l') _c
	if `min'==`max' {
		if `max' > 1 {
			local s s
		}
		di as err "`min' variable`s' required"
	}
	else if `min'<=0 {
		if `max'==1 {
			di as err "0 or 1 variables required"
		}
		else {
			di as err "`max' or fewer variables required"
		}
	}
	else if `max'>=32000 {
		di as err "`min' or more variables required"
	}
	else {
		di as err "`min' - `max' variables required"
	}
	exit cond(`n'<`min', 102, 103)
end
exit
