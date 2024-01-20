*! version 2.0.1  26nov2002
program define varfcast
	version 8.0

	syntax [anything(id="varfcast command" name =cmd)] [if] [in] [, *]

	if "`cmd'" != "" {
		gettoken sub 0:0 , parse(" ,")
		local l = length(`"`sub'"')

		if `"`sub'"'==substr("graph",1,max(1,`l')) {	/* Graph */
			_varfcast_graph `0'	
			exit
		}
		if `"`sub'"'==substr("compute",1,max(1,`l')) {	/* Compute */
			_varfcast `0'	
			exit
		}
		if `"`sub'"'==substr("clear",1,max(2,`l')) { 	/* CLear */
			_varfcast_clear `0'
			exit
		}
		else {
			di as err "`sub' is not a valid subcommand"
			exit 198
		}

	}
	else {
		di as err "no subcommand specified"
		exit 198
	}

end	

