*! version 1.2.0  18jun2009
program define clog_lf
        version 6
	args todo b lnf g H sc

/* Calculate the log-likelihood. */

        tempvar z
	mleval `z' = `b'

	mlsum `lnf' = cond($ML_y1, cond(`z'>100, 0, /*
	*/ cond(`z'<-12, `z'-(exp(`z')/2)*(1-exp(`z')/4), /*
	*/ ln(1-exp(-exp(`z'))))), -exp(`z'))

	if `todo'==0 | `lnf'==. { exit }

/* Calculate the score and gradient. */

	qui replace `sc' = cond($ML_y1,exp(`z'-exp(`z'))/(1-exp(-exp(`z'))), /*
	*/ -exp(`z')) if $ML_samp

$ML_ec	mlvecsum `lnf' `g' = `sc'

	if `todo'==1 | `lnf'==. { exit }

/* Calculate the negative hessian. */

	mlmatsum `lnf' `H' = cond($ML_y1, /*
	*/ -(`sc'/(1-exp(-exp(`z'))))*(1-exp(`z')-exp(-exp(`z'))), /*
	*/ exp(`z'))
end
