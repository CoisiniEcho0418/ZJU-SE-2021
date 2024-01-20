*! version 1.1.1  17may2007
program ivprobit_footnote
	version 9
	ivreg_footnote
	if !missing(e(df_r)) {
		exit
	}
	if "`e(prefix)'" == "" {
		if "`e(method)'" == "ml" {
			MLfootnote
		}
		else	TSfootnote
	}
	ComDetDisp
end

program TSfootnote
 	local endog_ct : word count `e(instd)'
	di as text "Wald test of exogeneity: " _col(30) as text		///
		"chi2(" as res `endog_ct'				///
		as text ") = " as res %8.2f e(chi2_exog) as text	///
		_col(59) "Prob > chi2 = " as res %6.4f			///
		chiprob(`endog_ct', e(chi2_exog))
end

program MLfootnote
	if e(endog_ct) == 1 {
		di as text "Wald test of exogeneity (/athrho = 0): chi2(" ///
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

program define ComDetDisp

        local successes = e(N_cds)
        local failures = e(N_cdf)
        if (`successes' > 0 | `failures' > 0) {
	        di
                // Make sure failure and success singular if appropo
                if (`successes'==1 & `failures'==1) {
                        di as text ///
"note: 1 failure and 1 success completely determined."
                }
                else if (`successes'==1) {   
                        di as text ///
"note: `failures' failures and 1 success completely determined."
                }
                else if (`failures'==1) {
                        di as text ///
"note: 1 failure and `success' successes completely determined."
                }
                else {
                        di as text ///
"note: `failures' failures and `successes' successes completely determined."
                }
        }


end

