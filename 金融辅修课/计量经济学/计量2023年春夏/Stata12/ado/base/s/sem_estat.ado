*! version 1.0.3  22jun2011
program sem_estat
	version 12

	if "`e(cmd)'"!="sem" {
		error 301
	}	
	if _by() {
		error 190
	}	

	local issvy = "`e(prefix)'" == "svy"

	gettoken key args : 0, parse(", ")
	local lkey = length(`"`key'"')

	if `"`key'"'==substr("eqgof",1,max(3,`lkey')) {
		sem_estat_eqgof `args'
		exit
	}
	
	if `"`key'"'==substr("eqtest",1,max(3,`lkey')) {
		sem_estat_eqtest `args'
		exit
	}

	if `"`key'"'==substr("framework",1,max(3,`lkey')) {
		sem_estat_framework `args'
		exit
	}
	
	if `"`key'"'=="gof" { 
		sem_estat_gof `args'
		exit
	}

	if `"`key'"'=="ggof" { 
		sem_estat_ggof `args'
		exit
	}

	if `"`key'"'==substr("mindices",1,max(2,`lkey'))	///
	 | `"`key'"'==substr("mindex",1,max(2,`lkey')) {
		if `issvy' {
		  di as err "estat mindices is not allowed after svy: sem"
		  exit 198
		}
		sem_estat_mindices `args'
		exit
	}
	if `"`key'"'==substr("scoretests",1,max(5,`lkey')) {
		if `issvy' {
		  di as err "estat scoretests is not allowed after svy: sem"
		  exit 198
		}
		sem_estat_scoretests `args'
		exit
	}
	
	if `"`key'"'==substr("residuals",1,max(3,`lkey')) {
		sem_estat_residuals `args'
		exit
	}
	
	if `"`key'"'==substr("ginvariant",1,max(3,`lkey')) {
		if `issvy' {
		  di as err "estat ginvariant is not allowed after svy: sem"
		  exit 198
		}
		sem_estat_ginvariant `args'
		exit
	}
	
	if `"`key'"'==substr("stable",1,max(3,`lkey')) {
		sem_estat_stable `args'
		exit
	}
	
	if `"`key'"'==substr("summarize",1,max(2,`lkey')) { 
		// override default handler
		sem_estat_summ `args'
		exit
	}
	
	if `"`key'"'==substr("teffects",1,max(3,`lkey')) {
		sem_estat_teffects `args'
		exit
	}
	
	if `"`key'"'==substr("stdize:",1,max(3,`lkey')) {
		if `"`key'"' == "stdize:" local col ":"
		sem_estat_stdize `col' `args'
		exit
	}

	if `"`key'"'==substr("ic",1,max(2,`lkey')) {
		if strpos("`0'",",") == 0 {
			local df = ", df(`e(df_m)')"
		}
		else {
			local df = " df(`e(df_m)')"
		}
		estat_default `0' `df'
		exit
	}
	
	estat_default `0'
end
exit
