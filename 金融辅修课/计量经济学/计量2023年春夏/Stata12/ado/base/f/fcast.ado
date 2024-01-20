*! version 1.0.0  20may2004
program define fcast, sort 
	version 8.2

	gettoken sub 0 : 0 , parse(" ,")

	local l = length(`"`sub'"')
	if `"`sub'"'==substr("compute",1,max(1,`l')) {		/* Compute */
		fcast_compute `0'
	}
	else if `"`sub'"'==substr("graph",1,max(1,`l')) {	/* Graph */
		fcast_graph `0'
	}
	else {
		di as error "`sub' unknown subcommand"
		exit 198
	}
end

exit

