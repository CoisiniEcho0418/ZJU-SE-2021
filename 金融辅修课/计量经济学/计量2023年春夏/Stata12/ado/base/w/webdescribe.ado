*! version 1.1.0  28jun2011
program webdescribe
	version 9
	if `"`0'"' == "" {
		error 198
	}
	gettoken sub : 0, parse(" ,") quotes

	if `"`sub'"'=="set" | `"`sub'"'=="query" {
		gettoken sub 0 : 0, parse(" ,")
		if "`sub'"=="set" {
			Set `0'
		}
		else	Query `0'
		exit
	}

	local 0 `"using `0'"'
	syntax using/ [, Short Detail VARList ]

	GetDefault prefix

	describe using `"`prefix'/`using'"', `short' `detail' `varlist'
end

program GetDefault
	args d
	if `"$S_WEB"'=="" {
		c_local `d' "http://www.stata-press.com/data/r12"
	}
	else	c_local `d' `"$S_WEB"'
end


program Set
	gettoken prefix 0 : 0, parse(" ")
	if `"`0'"' != "" {
		error 198
	}
	if `"`prefix'"'=="" {
		global S_WEB
		Query
		exit
	}
	if substr(`"`prefix'"',-1,1)=="/" {
		local prefix = substr(`"`prefix'"',1,length(`"`prefix'"')-1)
	}
	if "`prefix'"=="" {
		error 198
	}
	if substr(`"`prefix'"',1,7)!="http://" {
		local prefix `"http://`prefix'"'
	}
	global S_WEB `"`prefix'"'
	Query
end

program Query
	syntax
	GetDefault prefix
	di as txt `"(prefix now ""' as res `"`prefix'"' as txt `"")"'
end
