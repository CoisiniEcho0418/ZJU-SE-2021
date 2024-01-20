*! version 1.1.0  09feb2009
program ivregress_epilog, eclass

	version 10

	tempname b V
	mat `b' = e(b)
	mat `V' = e(V)

	local vars `e(instd)' `e(exogr)'
	if `"`e(constant)'"' != "noconstant" {
		local vars `vars' _cons
	}

	mat coleq `b' = _:		// Clear out equation names
	mat coleq `V' = _:
	mat roweq `V' = _:

	mat colnames `b' = `vars'
	mat colnames `V' = `vars'
	mat rownames `V' = `vars'
	
	local wgt "[`e(wtype)'`e(wexp)']"
	ereturn repost b=`b' V=`V' `wgt', rename

	global epilog_called "Yes"
	
end

