*! version 1.0.0  21mar2008
program mvtest_samples
	version 11
	args Obs

	tempname nObs
	scalar `nObs' = 0

	dis as txt _col(5) " sample {c |}     Obs   " 
	dis as txt _col(5) "{hline 8}{c +}{hline 13}"
	forvalues i = 1/`=rowsof(`Obs')' {
		scalar `nObs' = `nObs' + `Obs'[`i',1]
		dis as txt _col(5) %5.0f `i' "   {c |}" as res	///
			 %8.0f `Obs'[`i',1]
	}
	dis as txt _col(5) "{hline 8}{c +}{hline 13}"
	dis as txt _col(5) "  total {c |}" as res %8.0f `nObs' _n
end
exit
