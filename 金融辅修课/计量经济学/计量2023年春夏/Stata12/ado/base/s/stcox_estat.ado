*! version 1.0.1  17jan2005
program stcox_estat, rclass
	version 9

	if "`e(cmd2)'" != "stcox" {
		error 301
	}

	gettoken key rest : 0, parse(", ")
	local lkey = length(`"`key'"')
	if `"`key'"' == substr("phtest",1,max(3,`lkey')) {
		stphtest `rest'
	}
        else if `"`key'"'==substr("concordance",1,max(3, `lkey')) {
		stcstat `rest'
	}
	else {
		estat_default `0'
	}
	return add
end
