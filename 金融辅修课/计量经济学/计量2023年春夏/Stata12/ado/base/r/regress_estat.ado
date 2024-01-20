*! version 1.1.0  05apr2009
program regress_estat, rclass
	version 9

	local ver : di "version " string(_caller()) ", missing :"

	if "`e(cmd)'" != "regress" {
		error 301
	}

	gettoken key rest : 0, parse(", ")
	local lkey = length(`"`key'"')

/* Regular */
	if `"`key'"' == substr("ovtest",1,max(3,`lkey')) {
		`ver' ovtest `rest'
	}
	else if `"`key'"' == substr("hettest",1,max(4,`lkey')) {
		hettest `rest'
	}
	else if `"`key'"' == substr("szroeter",1,max(3,`lkey')) {
		szroeter `rest'
	}
	else if `"`key'"' == substr("vif",1,max(3,`lkey')) {
		`ver' vif `rest'
	}
	else if `"`key'"' == substr("imtest",1,max(3,`lkey')) {
		`ver' imtest `rest'
	}

/* Time series */
	else if `"`key'"' == substr("dwatson",1,max(3,`lkey')) {
		dwstat `rest'
	}
	else if `"`key'"' == substr("durbinalt",1,max(3,`lkey')) {
		durbina `rest'
	}
	else if `"`key'"' == substr("bgodfrey",1,max(3,`lkey')) {
		bgodfrey `rest'
	}
	else if `"`key'"' == substr("archlm",1,max(6,`lkey')) {
		archlm `rest'
	}


/* Default */
	else {
		estat_default `0'
	}
	return add
end
