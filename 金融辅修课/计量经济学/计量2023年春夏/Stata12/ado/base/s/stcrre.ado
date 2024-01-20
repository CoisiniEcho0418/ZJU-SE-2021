*! version 1.0.1  24mar2009
program stcrre, eclass byable(onecall) prop(st sw hr nohr shr noshr)
	if _by() {
		local by "by `_byvars'`_byrc0':"
	}
	`by' stcrreg `0'
end
exit
