*! version 1.0.0  23sep2005
program ivtobit_footnote
	version 9
	ivreg_footnote
	if "`e(prefix)'" == "" & missing(e(df_r)) {
		if "`e(method)'" == "ml" {
			MLfootnote
		}
		else	TSfootnote
	}
	di
	censobs_table e(N_unc) e(N_lc) e(N_rc) "" e(llopt) e(ulopt)
end

program TSfootnote
	di as text "Wald test of exogeneity: " _col(30) as text		///
		"chi2(" as res e(endog_ct)				///
		as text ") = " as res %8.2f e(chi2_exog) as text	///
		_col(59) "Prob > chi2 = " as res %6.4f			///
		chiprob(e(endog_ct), e(chi2_exog))
end

program MLfootnote
	if e(endog_ct) == 1 {
		di as text "Wald test of exogeneity (/alpha = 0): chi2(" ///
			as res e(endog_ct) as text ") = " as res %8.2f    ///
			e(chi2_exog) as text _col(59) "Prob > chi2 = "    ///
			as res %6.4f chiprob(e(endog_ct), e(chi2_exog))
	}
	else {
		di as text "Wald test of exogeneity: " _col(30) as text   ///
			"chi2(" as res e(endog_ct) as text ") = " as res  ///
			%8.2f e(chi2_exog) as text _col(59)               ///
			"Prob > chi2 = " as res %6.4f                     ///
			chiprob(e(endog_ct), e(chi2_exog))
	}
end
