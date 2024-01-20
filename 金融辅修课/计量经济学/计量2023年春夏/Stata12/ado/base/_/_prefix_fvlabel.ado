*! version 1.0.0  17jun2011
program _prefix_fvlabel
	version 12

	args ecmd

	if "`ecmd'" == "sem" {
		local gvar = "`e(groupvar)'"
		capture confirm numeric var `gvar'
		if c(rc) exit
		local glab : value label `gvar'
		if "`glab'" != "" {
			capture label list `glab'
			if c(rc) == 0 {
				label copy `glab' `gvar', eclass
			}
		}
	}
end
