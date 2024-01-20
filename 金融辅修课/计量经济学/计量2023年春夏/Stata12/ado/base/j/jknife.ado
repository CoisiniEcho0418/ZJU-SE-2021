*! version 9.3.1  03jan2005
program define jknife
	version 9, missing
	local version : di "version " string(_caller()) ", missing:"
	/* version control */
	if _caller() < 9 {
		`version' jknife_8 `0'
		exit
	}
	`version' jackknife `0'
end
exit
