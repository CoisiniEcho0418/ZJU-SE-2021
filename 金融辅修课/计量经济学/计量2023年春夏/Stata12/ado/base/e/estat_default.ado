*! version 1.0.1  01jun2007
program estat_default
	version 8

	gettoken key rest : 0, parse(", ")
	local lkey = length(`"`key'"')

	if "`e(cmd)'" == "" {
		error 301
	}

	if `"`key'"' == "," { 
		dis as err "subcommand expected" 
		exit 198
	}
	
	if `"`key'"' == "ic" {
		IC `rest'
	}
	else if `"`key'"' == substr("summarize",1,max(2,`lkey')) {
		SUmmarize `rest'
	}
	else if `"`key'"' == "vce" {
		VCE `rest'
	}
	else if `"`key'"' == substr("bootstrap",1,max(4,`lkey')) {
		_bs_display `rest'
	}
	else if `"`key'"' == `""' {
		di as error "subcommand required"
		exit 321
	}
	else {
		dis as err `"invalid subcommand `key'"'
		exit 321
	}
end


// default handlers

program IC
	syntax [, 			///
		df(passthru)		/// undocumented
		n(numlist max=1 >0)	/// substitute for e(N) in BIC
	]
	
	if !inlist("`e(ll)'", ".", "") {
		est stats . , `df' n(`n')
	}
	else {
		dis as err ///
		  "likelihood information not found in last estimation results"
		exit 321
	}
end


program SUmmarize
	estat_summ `0'
end


program VCE
	vce `0'
end

exit
