*! version 1.1.0  08sep2010
program _prefix_buildinfo, eclass
	syntax name(name=cmdname)
	_ms_op_info e(b)
	if r(tsops) {
		quietly tsset, noquery
	}
	if "`cmdname'" == "cox" {
		local cmdname stcox
	}
	local fvaddcons fvaddcons
	local props : properties `cmdname'
	if `:list fvaddcons in props' {
		local ADDCONS ADDCONS
	}
	if "`cmdname'" == "mlogit" {
		local fveq = e(k_eq) - (e(k_eq) == e(k_eq_base))
		local fveq fvinfoeq(`fveq')
	}
	else if inlist("`cmdname'", "manova", "mvreg") {
		local fveq fvinfoeq(1)
	}
	ereturn repost, buildfvinfo `ADDCONS' `fveq'
end
