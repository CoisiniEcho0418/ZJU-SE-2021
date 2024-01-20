*! version 1.0.2  12dec2007
program define saveold
	version 10
	local 0 `"using `0'"'
	syntax using/ [, noLabel REPLACE ALL INTERCOOLED ]
	if "`replace'"=="" {
		confirm new file `"`using'"'
	}
	preserve 
	save `"`using'"', oldformat `label' `replace' `all' `intercooled'
end
