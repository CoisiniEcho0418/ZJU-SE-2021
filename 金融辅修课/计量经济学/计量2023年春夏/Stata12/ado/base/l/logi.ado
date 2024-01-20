*! version 1.0.1   23oct2004
program logi, eclass byable(onecall) prop(or svyb svyj svyr)
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`by' logit `0'
end
exit
