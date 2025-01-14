*! version 1.0.2  01apr2005
program st_hcd_sh
	version 8

	local crtype = upper(substr(`"`e(crittype)'"',1,1)) + /*
		*/ substr(`"`e(crittype)'"',2,.)
	local crlen = max(15,length(`"`crtype'"'))

	di as txt "`e(title)' --"
	di _col(10) as txt "`e(title2)'" _col(49) as txt /*
		*/ "Number of obs" _col(68) "=" _col(70) as res /*
		*/ %9.0g e(N)
	di _col(10) as txt "`e(fr_title)'" _col(49) as txt /*
		*/ "Number of groups" _col(68) "=" _col(70) as res /*
		*/ %9.0g e(N_g)
	di as txt "Group variable: " as res abbrev("`e(shared)'",12)	

	di _n as txt %-`crlen's "No. of subjects" " = " as res %12.0g /*
		*/ e(N_sub) _col(49) /*
		*/ as txt "Obs per group: min = " as res %9.0g e(g_min)

	di as txt %-`crlen's "No. of failures" " = " as res %12.0g `e(N_fail)'/*
		*/ _col(64) as txt "avg" " = " as res %9.0g e(g_avg)
	di as txt %-`crlen's "Time at risk" " = " as res %12.0g e(risk) /*
		*/ _col(64) as txt "max" " = " as res %9.0g e(g_max)
	di
	if !missing(e(chi2)) {
		di _col(49) as txt ///
			"`e(chi2type)' chi2(" as res e(df_m) as txt ")" ///
			_col(68) "=" _col(70) as res %9.2f e(chi2)

		di as txt %-`crlen's "`crtype'" " =   " as res %10.0g e(ll) ///
			_col(49) as txt "Prob > chi2" _col(68) "=" _col(73) ///
			as res %6.4f chiprob(e(df_m), e(chi2))
	}
	else if !missing(e(F)) {
		di _col(49) as txt ///
			"F(" as res %4.0f e(df_m) ///
			as txt "," ///
			as res %7.0f e(df_r) as txt ")" ///
			_col(68) "=" as res %10.2f e(F)

		di as txt %-`crlen's "`crtype'" " =   " as res %10.0g e(ll) ///
			_col(49) as txt "Prob > F" _col(68) "=" ///
			as res %10.4f Ftail(e(df_m), e(df_r), e(F))
	}
	else {
		local dfm_l : di %4.0f e(df_m)
		local dfm_l2: di %7.0f e(df_r)
		di in smcl _col(49) ///
			"{help j_robustsingular##|_new:F(`dfm_l',`dfm_l2')}" ///
			as txt _col(68) "=" as res %10.2f e(F)

		di as txt %-`crlen's "`crtype'" " =   " as res %10.0g e(ll) ///
			_col(49) as txt "Prob > F" _col(68) "=" ///
			as res %10.4f .
	}
end

exit

----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
Weibull regression --
         log relative-hazard form		Number of obs      = 123456789  
	 Inverse-Gaussian frailty		Number of groups   = 123456789
Group variable: idcode				

No. of subjects = 123456789012                  Obs per group: min = 123456789
No. of failures =           23                                 avg = 123456789
Time at risk    =        15737                                 max = 123456789

						LR chi2(2)	   = 000000.00
Log likelihood  =   1234567890			Prob > chi2	   =    0.0000
