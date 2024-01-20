*! version 1.0.2  07/18/93
program define ml_nb0
	version 3.1
	tempvar ba alpha
	qui gen double `alpha' = exp(`3')
	if ("$S_mloff"=="") { qui gen double `ba' = exp(`2')*`alpha' }
	else qui gen double `ba' = exp(`2'+$S_mloff)*`alpha' 
	qui replace `1' = lngamma($S_mldepn+1/`alpha')-lngamma($S_mldepn+1) /*
	 */ -lngamma(1/`alpha')+$S_mldepn*log(`ba'/(1+`ba'))-log(1+`ba')/`alpha'
end
