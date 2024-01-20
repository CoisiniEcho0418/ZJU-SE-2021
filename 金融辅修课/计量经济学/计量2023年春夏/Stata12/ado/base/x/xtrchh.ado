*! version 1.5.1  30sep2004
program define xtrchh, eclass byable(onecall)

	version 8, missing
	if _by() {
		by `_byvars'`_byrc0': xtrc `0'
	}
	else {
		xtrc `0'
	}

end
