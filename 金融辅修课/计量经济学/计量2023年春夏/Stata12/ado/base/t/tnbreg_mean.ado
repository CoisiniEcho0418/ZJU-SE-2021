*! version 1.0.5  18may2010
program define tnbreg_mean
	version 11.0
	args todo b lnf g H sc1 sc2

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
	tempvar xb
	tempname lnalpha m
	mleval `xb' = `b', eq(1)
	mleval `lnalpha' = `b', eq(2) scalar

	local y "$ML_y1"
	scalar `m' = exp(-`lnalpha')

	if `lnalpha' < -20 {
		mlsum `lnf' = -lngamma(`y'+1) - exp(`xb') 		///
		 	+ `y'*`xb' -ln(poissontail(exp(`xb'),`tp' + 1))
 	}
	else {
		mlsum `lnf' = lngamma(`m'+`y') - lngamma(`y'+1) 	///
				- lngamma(`m') - 			///
				`m'*ln(1+exp(`xb'+`lnalpha')) 		///
				- `y'*ln(1+exp(-`xb'-`lnalpha')) 	///
				- ln(nbinomialtail(`m', `tp' + 1, 	///
						1/(1+(exp(`xb'+`lnalpha')))))

	}
	if (`todo' == 0 | `lnf'>=.)  exit

/* Calculate the scores and gradient. */
	tempname alpha
	tempvar mu p z1
	qui gen double `mu' = exp(`xb') if $ML_samp
	qui gen double `p'  = 1/(1+exp(`xb'+`lnalpha')) if $ML_samp


	tempvar t1 lp0 hp0 lp1 hp1

	tempvar w2 w3 x2 x3

	if `lnalpha'<-20 {
		qui gen double `z1' = exp(-`mu') if $ML_samp
		qui replace `sc1' = `y'-`mu'- `z1'*`mu'/(1-`z1') if $ML_samp
		qui replace `sc2' = 0 if $ML_samp
	}
	else {
		tempvar t1 lp0 hp0 lp1 hp1
		tempvar w2 w3 x2 x3 z2 z3 z4
		tempvar hm lowm lalpha halpha
		/* The following values for h and h2 are used for calculating
		 * numberical derivatives
		*/
		tempname h h2 htemp
		scalar `htemp' = 1
		scalar `h'  = `htemp' + epsdouble()
		scalar `h'  = `h' - `htemp'
		scalar `h2' = `htemp' + epsdouble()
		scalar `h2' = `h2' - `htemp'
		scalar `htemp' = 1
		if `lnalpha' != 0 {
			scalar `htemp' = `lnalpha'
		}
		scalar `h' = sqrt(`h')*`htemp'
		qui gen double `lalpha' = `lnalpha' - `h' 		///
				if $ML_samp & `tp'>0
		qui gen double `halpha' = `lnalpha' + `h' 		///
				if $ML_samp & `tp'>0
		qui gen double `lowm'   = exp(-`lalpha')  		///
				if $ML_samp & `tp'>0
		qui gen double `hm'     = exp(-`halpha')  		///
				if $ML_samp & `tp'>0

		qui gen double `t1' = `xb' + `lnalpha'
		qui sum `t1'
		scalar `htemp' = 1
		if r(mean) !=0 {
			scalar `htemp' = r(mean)
		}
		scalar `h2' = sqrt(`h2')*`htemp'
		qui gen double `lp0' = 1/(1+exp(`t1' -`h2') )  		///
				if $ML_samp & `tp'>0
		qui gen double `hp0' = 1/(1+exp(`t1' +`h2') )  		///
				if $ML_samp & `tp'>0
		qui gen double `lp1' = 1/(1+exp(`xb' + `lalpha') ) 	///
				if $ML_samp & `tp'>0
		qui gen double `hp1' = 1/(1+exp(`xb' + `halpha') ) 	///
				if $ML_samp & `tp'>0
		qui gen double `w2' = 					///
			ln(nbinomialtail(`lowm', `tp'+1, `lp1')) 	///
					if $ML_samp & `tp'>0
		qui gen double `w3' = 					///
			ln(nbinomialtail(`hm',   `tp'+1, `hp1')) 	///
					if $ML_samp & `tp'>0

		qui gen double `x2' = 					///
			ln(nbinomialtail(`m', `tp'+1, `lp0'))  	///
					if $ML_samp & `tp'>0
		qui gen double `x3' = 					///
			ln(nbinomialtail(`m', `tp'+1, `hp0')) 	///
				if $ML_samp & `tp'>0

		qui gen double `z2' = cond($ML_samp & `tp'==0,	///
			1- `p'^`m', 					///
			cond($ML_samp & `tp'>0, 			///
			nbinomialtail(`m', `tp' + 1,		///
			1/(1+(exp(`xb'+`lnalpha')))), . ))

		qui gen double `z3' = cond($ML_samp & `tp'==0, 	///
				-`p'^(`m'+1)*`mu'/ `z2',		///
				cond($ML_samp & `tp'>0,		///
				-(`x3'-`x2')/(2*`h2'), .))

		qui gen double `z4' = cond($ML_samp & `tp'==0, 	///
				`p'^`m'*(-`m'^2*ln(`p') - 		///
					`m'*`mu'*`p')/`z2'/ `m', 	///
				cond($ML_samp & `tp'>0,		///
				-(`w3'-`w2')/(2*`h'), .))

		qui replace `sc1' = `p'*(`y'-`mu') + `z3' if $ML_samp
		qui replace `sc2' = `m'*(digamma(`m') - 	///
			digamma(`y'+`m')  - ln(`p')) +  	///
			`p'*(`y'-`mu') + `z4' if $ML_samp
	}

	$ML_ec	tempname g1 g2
	$ML_ec	mlvecsum `lnf' `g1' = `sc1', eq(1)
	$ML_ec	mlvecsum `lnf' `g2' = `sc2', eq(2)
	$ML_ec	matrix `g' = (`g1',`g2')

	if (`todo' == 1 | `lnf'>=. ) exit

/* Calculate negative hessian. */

	tempname alpha d11 d12 d22
	tempvar  z3
	qui gen double `z3'= - `m'^2*ln(`p')-`m'*`mu'*`p' if $ML_samp
	scalar `alpha' = exp(`lnalpha')

	if `lnalpha' < -20 {
		mlmatsum `lnf' `d11' = `mu'- /*
		*/ (`mu'^2* `z1'+ `z1'^2 * `mu'-`z1'*`mu')/((1-`z1')^2) /*
		*/ , eq(1)
		mlmatsum `lnf' `d12' = 0, eq(1,2)
		mlmatsum `lnf' `d22' = 0, eq(2)
	}
	else {
		//mlmatsum `lnf' `d11' = `mu'*`p'*(`alpha'*`p'*(`y'-`mu')+1)- /*
                //    */ `p'^(`m'+2)*(`mu'^2-`mu')/(`z2'^2) - /*
                //    */ `p'^(2*(`m'+1))*`mu'/(`z2'^2), eq(1)
		//mlmatsum `lnf' `d12' = `alpha'*`mu'*`p'^2*(`y'-`mu')-/*
                //    */ `p'^(`m'+1)*(-`mu'*`z3'/`m'+`mu'-`mu'*`p')/(`z2'^2)+ /*
                //    */ `p'^(2*`m'+1)*(`mu'-`mu'*`p')/(`z2'^2), eq(1,2)
		//mlmatsum `lnf' `d22' = `m'*(digamma(`m') - digamma(`y'+`m') /*
                //    */ - ln(`p') /*
	        //    */ - `m'*(trigamma(`y'+`m') - trigamma(`m'))) /*
		//    */ + `mu'*`p'*(`alpha'*`p'*(`y'-`mu')- 1)- /*
                //    */ `p'^`m'*(`z3'^2/`m' - `z3'+(`mu'*`p')^2)/`m'/(`z2'^2) /*
                //    */ +`p'^(2*`m')*(-`z3'+(`mu'*`p')^2)/`m'/(`z2'^2)  , eq(2)

		mlmatsum `lnf' `d11' = `mu'*`p'*(`alpha'*`p'*(`y'-`mu')+1)- /*
			*/ `p'^(`m'+2)*(`mu'^2-`mu')/(`z2'^2) - /*
			*/ `p'^(2*(`m'+1))*`mu'/(`z2'^2), eq(1)
		mlmatsum `lnf' `d12' = `alpha'*`mu'*`p'^2*(`y'-`mu')-/*
			*/ `p'^(`m'+1)*(-`mu'*`z3'/`m'+`mu'-`mu'*`p') /*
			*/ /(`z2'^2) + `p'^(2*`m'+1)*(`mu'-`mu'*`p') /*
			*/ /(`z2'^2), eq(1,2)
		mlmatsum `lnf' `d22' = `m'*(digamma(`m') - digamma(`y'+`m') /*
			*/ - ln(`p') /*
			*/ - `m'*(trigamma(`y'+`m') - trigamma(`m'))) /*
			*/ + `mu'*`p'*(`alpha'*`p'*(`y'-`mu')- 1)- /*
			*/ `p'^`m'*(`z3'^2/`m' - `z3'+(`mu'*`p')^2) /*
			*/ /`m'/(`z2'^2) +`p'^(2*`m')*(-`z3'+ /*
			*/ (`mu'*`p')^2)/`m'/(`z2'^2)  , eq(2)
	}

	matrix `H' = (`d11',`d12' \ `d12'',`d22')
end

