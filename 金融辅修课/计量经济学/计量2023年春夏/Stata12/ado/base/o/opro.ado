*! version 1.0.1   23oct2004
program opro, eclass byable(onecall) prop(svyb svyj svyr)
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`by' oprobit `0'
end
exit
