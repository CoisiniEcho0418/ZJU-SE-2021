*! version 1.0.1   23oct2004
program mlog, eclass byable(onecall) prop(rrr svyb svyj svyr)
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`by' mlogit `0'
end
exit
