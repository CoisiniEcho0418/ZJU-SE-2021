*! version 1.0.1  20feb2007
program scobit_footnote
	version 9.1
	syntax [, NOwarn]

	if "`e(prefix)'" == "svy" {
		exit
	}
	if "`e(chi2_ct)'"=="LR" {
		if e(chi2_c) < 1e5 {
			local fmt "%9.2f"
		}
		else 	local fmt "%9.2e"
		di in gr "Likelihood-ratio test of alpha=1:   " /*
		*/ in gr "chi2(" in ye "1" in gr ") =" in ye `fmt' /*
		*/ e(chi2_c) in gr "    Prob > chi2 = " in ye %6.4f /*
		*/ chiprob(1, e(chi2_c))
	}

	if `"`nowarn'"'=="" {
		di _n in gr /*
		*/ "Note: likelihood-ratio tests are recommended for " /*
		*/ "inference with scobit models."
	}
end
