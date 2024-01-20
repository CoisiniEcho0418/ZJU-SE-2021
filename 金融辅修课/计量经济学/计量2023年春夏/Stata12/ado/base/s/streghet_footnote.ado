*! version 1.0.0 04may2006
program streghet_footnote
	version 10
	if "`e(ll_c)'"!="" {
		if ((e(chi2_c) > 0.005) & (e(chi2_c)<1e4)) /*
                            */ | (e(chi2_c)==0) { 
               		local fmt "%8.2f"
		}
		else local fmt "%8.2e"
		di as txt "Likelihood-ratio test of theta=0: " /*
        */ as txt "{help j_chibar:chibar2(01) = }" as res `fmt' /*
       	*/ e(chi2_c) as txt " Prob>=chibar2 = " as res %5.3f /*
       	*/ e(p_c)
	}
	if "`e(sh_warn)'"=="sh_warn" {
		di as txt "Warning: Observations within subject "_c
		di as txt "belong to different frailty groups."
	}
end
exit
