*! version 1.0.0  13jan2005
program rotate
	version 9

	if _caller() < 9 {
		rotate_cmd8 `0'
		exit
	}

	if "`e(cmd)'" == "" {
		error 301
	}
	
	if "`e(rotate_cmd)'" == "" {
		dis as err "no rotation command found in e(rotate_cmd)"
		exit 198
	}

	syntax [, clear * ]
		
	if "`clear'" != "" & `"`options'"' != "" { 
		dis as err "option clear may not be combined with other options" 
		exit 198
	}
	else if "`clear'" != "" { 
		_rotate_clear
	}
	else { 
		`e(rotate_cmd)' `0'
	}
end
