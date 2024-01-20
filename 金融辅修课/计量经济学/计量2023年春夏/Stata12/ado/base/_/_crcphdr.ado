*! version 1.2.1  27may2010
program define _crcphdr
	version 9
	
	if "`e(crittype)'" != "" {
		local crtyp = e(crittype)
		local first = upper(substr("`crtyp'",1,1))
		local rest = substr("`crtyp'",2,.)
		local crtyp = "`first'`rest'"
	}
	else local crtyp "Log likelihood"
	
	di in gr _n "`e(title)'" _col(49) "Number of obs" _col(68) "=" /*
		*/ _col(70) in ye %9.0g e(N)
	di in gr "Group variable: " in ye abbrev("`e(ivar)'",14) /*
		*/ _col(49) in gr "Number of groups" _col(68) "=" /*
		*/ _col(70) in ye %9.0g e(N_g) _n
/* #if 0
	di in gr /*
		*/ _col(49) in gr "Number of groups" _col(68) "=" /*
		*/ _col(70) in ye %9.0g e(N_g) _n
#endif */

	if "`e(distrib)'" != "" {
		di in gr "Random effects u_i ~ " in ye "`e(distrib)'" in gr /*
			*/ _col(49) "Obs per group: min" /*
			*/ _col(68) "=" _col(70) in ye %9.0g e(g_min)
	}
	else {
		di in gr _col(49) "Obs per group: min" /*
			*/ _col(68) "=" _col(70) in ye %9.0g e(g_min)
	}
	di in gr _col(64) "avg" _col(68) "=" _col(70) in ye %9.1f e(g_avg)
	di in gr _col(64) "max" _col(68) "=" _col(70) in ye %9.0g e(g_max)

	if !missing(e(df_r)) {
        	di in gr _n _col(49) "F(" in ye %6.0f e(df_m) in gr "," /*
			*/ in ye %8.0f e(df_r) in gr ")" _col(68) "=" /*
			*/ _col(70) in ye %9.2f e(F)
		if "`e(ll)'" != "" {
			di in gr "`crtyp'  = " in ye %10.0g e(ll) _c
		}
		di in gr _col(49) "Prob > F" _col(68) "=" /*
			*/ in ye _col(73) %6.4f Ftail(e(df_m),e(df_r),abs(e(F)))
	}
	else {
		di in gr _n _col(49) "`e(chi2type)' chi2(" in ye e(df_m) /*
			*/ in gr ")" _col(68) "=" _col(70) /*
			*/ in ye %9.2f abs(e(chi2))
/* #if 0
	di in gr _n "Group variable i: " in ye "`e(ivar)'" in gr /*
		*/ _col(49) "`e(chi2type)' chi2(" in ye e(df_m) /*
		*/ in gr ")" _col(68) "=" _col(70) in ye %9.2f abs(e(chi2))
*/ 

		if "`e(ll)'" != "" {
			di in gr "`crtyp'  = " in ye %10.0g e(ll) /*
			*/ _col(49) in gr "Prob > chi2" _col(68) "=" /*
			*/ in ye _col(73) %6.4f chiprob(e(df_m),abs(e(chi2)))
		}
		else {
			di in gr _col(49) "Prob > chi2" _col(68) "=" /*
			*/ in ye _col(73) %6.4f chiprob(e(df_m),abs(e(chi2)))
		}
	}
	di
end
exit
