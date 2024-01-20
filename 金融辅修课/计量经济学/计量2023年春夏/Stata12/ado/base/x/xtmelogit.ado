*! version 1.1.4  22apr2010
program xtmelogit, eclass byable(onecall) prop(or mi)
	global XTM_ver = _caller()
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	version 10
	
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	if replay() {
		if "`e(cmd)'" != "xtmelogit" {
			error 301
		}
		if _by() {
			error 190
		}
		_xtme_display `0'
		exit
	}

	capture noisily `vv' `by' _xtme_estimate "logistic" `0'
	local rc = _rc
	ereturn local cmdline `"xtmelogit `0'"'
	capture mata: _xtgm_cleanup_st()
	capture ml clear
	capture mac drop XTM_ver
	exit `rc'
end

