*! version 1.0.0  19feb2007
program vwls_p

	version 10
	syntax [anything] [if] [in] , [ XB STDP ]

	if "`xb'`stdp'" == "" {
		di as text "(option xb assumed; linear prediction)"
	}
	_predict `anything' `if' `in' , `xb' `stdp'
	
end

