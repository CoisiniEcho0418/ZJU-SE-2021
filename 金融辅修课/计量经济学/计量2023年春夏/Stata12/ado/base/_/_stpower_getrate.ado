*! version 1.0.1  30mar2007
program _stpower_getrate
	version 10
	args fncval colon currate
	scalar `fncval' = -($GR_Pr - (1-exp(-`currate'*$GR_Z))/	///
				   (1-exp(-`currate'*$GR_R)))^2
end
