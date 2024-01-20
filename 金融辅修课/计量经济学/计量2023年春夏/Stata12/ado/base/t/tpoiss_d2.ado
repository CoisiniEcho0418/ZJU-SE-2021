*! version 1.0.3  21may2010
program tpoiss_d2
	args todo b lnf g negH score
	version 11.0
	local tp $ZTP_tp_
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
						"{cmd:ll(`ll')} must " ///
						"contain all " ///
						"nonnegative values"
							exit 200
					}
					tempvar tp
					gen double `tp' = `ll'
				}
			}
		}

	}
	tempvar xb
	mleval `xb' = `b'
	mlsum `lnf' = -exp(`xb') + `xb'*$ML_y1 - lngamma($ML_y1+1) /*
		*/ -ln(poissontail(exp(`xb'),`tp'+1))

	if (`todo' == 0 | `lnf'>=.) exit

	tempvar z1 z2
	qui gen double `z1'= exp(`xb')
	qui gen double `z2' = poissonp(`z1',`tp')/ ///
		poissontail(`z1', `tp'+1)
	qui replace `score' = $ML_y1 - `z1'- `z1'*`z2' if $ML_samp
	$ML_ec mlvecsum `lnf' `g' = `score'

	if (`todo' == 1 | `lnf'>=.)   exit

	mlmatsum `lnf' `negH' =`z1' - ///
		(`z1'^2* `z2'+ `z2'^2 * `z1'^2 - (`tp'+1)* `z2'*`z1')


 end
