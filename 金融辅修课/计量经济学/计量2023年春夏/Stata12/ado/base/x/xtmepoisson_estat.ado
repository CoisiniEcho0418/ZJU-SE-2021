*! version 1.0.0  01jun2007
program xtmepoisson_estat
	version 10

	if "`e(cmd)'" != "xtmepoisson" {
		error 301
	}

	_xtme_estat `0'
	exit
end

exit
