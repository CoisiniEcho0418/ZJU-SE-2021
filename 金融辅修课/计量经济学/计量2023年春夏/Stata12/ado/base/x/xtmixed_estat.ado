*! version 1.2.0  01may2007
program xtmixed_estat
	version 9

	if "`e(cmd)'" != "xtmixed" {
		error 301
	}

	_xtme_estat `0'
	exit
end

exit
