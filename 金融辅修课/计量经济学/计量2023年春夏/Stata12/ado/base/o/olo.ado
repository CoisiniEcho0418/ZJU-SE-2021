*! version 1.0.1   23oct2004
program olo, eclass byable(onecall) prop(or svyb svyj svyr)
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`by' ologit `0'
end
exit
