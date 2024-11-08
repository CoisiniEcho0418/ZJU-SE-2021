*! version 1.0.4  18may2010
/* updates file trnb_cons.ado */
program define tnbreg_cons
	version 11.0
	args todo b lnf g H g1 g2

	local tp $ZTNB_tp_
	if "`tp'" == "" {
		local ll `e(llopt)'
		local tp = 0
		if ("`ll'" != ""){
			cap confirm names `ll'
			if _rc {
			/* it is not a name, should be a number */
				cap confirm number `ll'
				if _rc{
					di as error
					"{cmd:ll(`ll')} must specify " ///
					"a nonnegative value"
					exit 200
				}
				else{
					local tp = `ll'
					capture noisily
				}
			}
			else{
			/* ll() does not contain a number */
				cap confirm variable `ll'
				if _rc!=0 {
				/* ll() contains a name that is not a */
				/* variable.  possibly it is a scalar */
					local tp = `ll'
					cap confirm number `tp'
					if _rc!=0{
						di as error ///
						"{cmd:ll(`ll')} must " ///
						"specify a nonnegative value"
						exit 200
					}
				}
				else {
				/* ll() contains the name of a variable */
					qui summarize `ll'
					if r(min) < 0 {
						di as error ///
						"{cmd:ll(`ll')} must  " ///
						" contain all " ///
						"nonnegative values"
							exit 200
					}
					tempvar tp
					gen double `tp' = `ll'
				}
			}
		}

	}
/* Calculate the log-likelihood. */
	tempvar m
	tempname lndelta delta lnoned

	mleval `m' = `b', eq(1)
	mleval `lndelta' = `b', eq(2) scalar

	scalar `delta' = exp(`lndelta')
	/* lnoned = -ln(p) */
	scalar `lnoned' = ln(1+`delta')

	tempvar m1
	qui gen double `m1' = `m'

	tempvar xb mu
	qui gen double `xb' = `m' if $ML_samp
	qui gen double `mu' = exp(`xb') if $ML_samp
	/* m = mu(j)/delta */
	qui replace `m' = exp(`m'-`lndelta')  if $ML_samp

	local y "$ML_y1"

	if `lndelta' < -20 {
		mlsum `lnf' = -lngamma(`y'+1) - `mu' /*
		*/	+`y'*`xb'-ln(1-exp(-exp(`xb')))
	}
	else {
	    mlsum `lnf' = lngamma(`y'+`m') - lngamma(`y'+1) - lngamma(`m') /*
		*/ + `lndelta'*`y' - (`y'+`m')*`lnoned' /*
		*/ - ln(nbinomialtail(`m', `tp'+1, 1/(1+`delta')) )

	}

	if (`todo' == 0 | `lnf'>=.)  exit

/* Calculate the scores and gradient. */
	tempvar z1 z2 z3 f1 f2 w1 x1

	if `lndelta' < -20 {
		qui gen double `z1'= exp(-`mu') if $ML_samp
		qui replace `g1' = `y' - `mu'- `z1'*`mu'/(1-`z1') if $ML_samp
		qui replace `g2' = 0 if $ML_samp
	}
	else{

		qui gen double `z2'= `m'*(digamma(`y'+`m') - 		///
			digamma(`m') - `lnoned') if $ML_samp

		qui gen double `z3' = cond($ML_samp&`tp'==0, 	///
			1-(1+`delta')^(-`m'), 				///
			cond($ML_samp&`tp'>0,			///
			nbinomialtail(`m', `tp'+1, 1/(1+`delta')),.))

		qui gen double `f1' = `m'*(digamma(`y'+`m') - 		///
				digamma(`m') -  `lnoned') if $ML_samp
		qui gen double `f2' = `y' -(`y'+`m')*`delta'/ 		///
				(1+`delta') - `z2' if $ML_samp

		tempvar hm lowm
		tempname h htemp
		/* The following value for h is used for calculating
		 * numerical derivatives
		*/
		scalar `htemp' = 1
		scalar `h' = `htemp' + epsdouble()
		scalar `h' = `h' - `htemp'
		qui sum `m1'
		scalar `htemp' = 1
		if r(mean)>1 {
			scalar `htemp' = r(mean)
		}
		scalar `h' = sqrt(`h')*`htemp'

		qui gen double `lowm' = `m1' - `h' if $ML_samp & `tp'>0
		qui gen double `hm'   = `m1' + `h' if $ML_samp & `tp'>0
		tempvar lxb lmu hxb hmu
		qui replace  `lowm' = exp(`lowm' - `lndelta') ///
			if $ML_samp & `tp'>0
		qui replace  `hm'   = exp(`hm'   - `lndelta') ///
			if $ML_samp & `tp'>0

		tempvar w2 w3 x2 x3
		qui gen double `w2' = ///
			ln(nbinomialtail(`lowm', `tp'+1, ///
				1/(1+`delta')) ) ///
				if $ML_samp & `tp'>0
		qui gen double `w3' = ///
			ln(nbinomialtail(`hm', `tp'+1, ///
			1/(1+`delta')) ) if $ML_samp & `tp'>0

		tempname ldelta hdelta
		scalar `ldelta' = exp(`lndelta' - `h')
		scalar `hdelta' = exp(`lndelta' + `h')
		qui replace `lowm' = exp(`m1' - (`lndelta' - `h')) ///
			if $ML_samp & `tp'>0
		qui replace `hm'   = exp(`m1' - (`lndelta' + `h')) ///
			if $ML_samp & `tp'>0
		qui gen double `x2' = ///
			ln(nbinomialtail(`lowm', `tp'+1, ///
			1/(1+`ldelta')) ) if $ML_samp & `tp'>0
		qui gen double `x3' = ///
			ln(nbinomialtail(`hm', `tp'+1, ///
			1/(1+`hdelta')) ) if $ML_samp & `tp'>0

		qui gen double `w1' = cond($ML_samp & `tp'>0, 	///
			-(`w3'-`w2')/(2*`h'),				///
			cond($ML_samp & `tp'==0,			///
			-(1+`delta')^(-`m')* `lnoned'*`m'/`z3',.))

		qui gen double `x1' = cond($ML_samp & `tp'>0, 	///
			-(`x3'-`x2')/(2*`h'),				///
			cond($ML_samp & `tp'==0,			///
			(1+ `delta')^(-`m')*(`m'*ln(1+`delta') 		///
			-`mu'/(1+`delta') ) / `z3',.))

		qui replace `g1' = `f1'+`w1' if $ML_samp
		qui replace `g2' = `f2'+`x1' if $ML_samp
	}
	$ML_ec	tempname d1 d2
	$ML_ec	mlvecsum `lnf' `d1' = `g1', eq(1)
	$ML_ec	mlvecsum `lnf' `d2' = `g2', eq(2)
	$ML_ec	matrix `g' = (`d1',`d2')
	if (`todo' == 1 | `lnf'>=.)  exit
	/* Calculate negative hessian. */
	tempname d11 d12 d22
	tempvar dd
	tempvar z4 z5

	qui gen double `z4'=(1+`delta')^(-`m')*ln(1+`delta')*(-`m') 	///
				if $ML_samp
	qui gen double `z5'=(1+`delta')^(-`m')*(-ln(1+`delta')*(`m')	///
				+`mu'/(1+`delta')) if $ML_samp

	if `lndelta' < -20 {"
		mlmatsum `lnf' `d11' = `mu'- 				///
			(`mu'^2* `z1'+ `z1'^2 * `mu'-`z1'*`mu')/	///
			((1-`z1')^2) , eq(1)
		mlmatsum `lnf' `d12' = 0, eq(1,2)
		mlmatsum `lnf' `d22' = 0, eq(2)
	}
	else {
		qui gen double `dd' = -`m'*(digamma(`y'+`m') - digamma(`m') /*
			*/ - `lnoned' + `m'*(trigamma(`y'+`m') - /*
			*/ trigamma(`m'))) if $ML_samp

		mlmatsum `lnf' `d11' = `dd'+ (`z4'*(`lnoned'*`m'-1)*`z3'- /*
			*/ (`z4')^2)/(`z3')^2, eq(1)

		mlmatsum `lnf' `d12' = `m'*`delta'/(1+`delta') - `dd' /*
			*/ -((1-`z3')*(`lnoned'*`m'-`mu'/(1+`delta'))* /*
			*/ (-`lnoned'*`m'+1)*`z3'+ /*
			*/ `z4'*(1-`z3')*(`m'*`lnoned'-`mu'/(1+`delta'))) /*
			*/ /(`z3')^2, eq(1,2)

		mlmatsum `lnf' `d22' = `delta'*(`y'-`m'*(1+2*`delta')) /*
			*/ /(1+`delta')^2 + `dd'- /*
			*/ ((1-`z3')*((-`mu'/(1+`delta')+`m'*`lnoned')^2+ /*
			*/ `mu'*`delta'/((1+`delta')^2)-`m'*`lnoned'+ /*
			*/ `mu'/(1+`delta'))*`z3'+ /*
			*/ `z5'^2)/(`z3')^2, eq(2)
	}
	matrix `H' = (`d11',`d12' \ `d12'',`d22')
end

