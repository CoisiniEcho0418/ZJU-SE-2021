*! version 1.2.0  28jun2011
program sem_display
	version 12

	if "`e(cmd)'" != "sem" {
		error 301
	}
	if _by() {
		error 190
	}

	if "`e(prefix)'" != "" {
		_prefix_display `0'
	}
	else	Display `0'
end

program Display
	syntax [,	STANDardized		///
		  	SHOWGinvariant		///
			noLABel			///
		  	noHEADer		///
		  	noTABLE			///
		  	noFOOTnote		///
			wrap(numlist max=1)	///
		  	*			///
	]

	_get_diopts diopts, `options'

	local header = "`header'" == ""
	if `header' {
		Header, `standardized'
	}

	if "`wrap'" != "" {
		local wrap wrap(`wrap')
	}

	if ("`table'" == "") {
		if `header' {
			di
		}
		_coef_table,	cmdextras		///
			`standardized'		///
			`showginvariant'	///
			`label'			///
			`footnote'		///
			`wrap'			///
			`diopts'
	}
	
	if "`footnote'"=="" { 
		Footer
	}

end

program Header
	syntax [, STANDardized]
	local c1  _col( 1)
	local c2  _col(20)
	local c3  _col(49)
	local c4  _col(68)

	local ffmt "%9.0f"
	local gfmt "%10.0g"

	di
	di 	 as txt "`e(title)'"					///
	    `c3' as txt "Number of obs" 				///
	    `c4' as txt "= " as res `ffmt' e(N)

	local crtype = upper(substr(`"`e(crittype)'"',1,1)) + 		///
			substr(`"`e(crittype)'"',2,.)

	if e(N_groups) > 1 {
		local gvar `e(groupvar)'
        	di `c1' as txt "Grouping variable"			///
        	   `c2' as txt "= " as res abbrev("`gvar'",16)		///
        	   `c3' as txt "Number of groups"  			///
        	   `c4' as txt "= " as res `ffmt' e(N_groups)
	}

	di `c1' as txt "Estimation method"  				///
	   `c2' as txt "= " as res e(method)

	di `c1' as txt "`crtype'" `c2' "= " as res `gfmt' e(critvalue)

end

program Footer 
	if "`e(chi2type_ms)'"!="" { 
		local df   : display       `e(df_ms)'
		if "`e(chi2type_ms)'" == "Discr." {
			local chi2 : display %8.2f `e(chi2_ms)'
		}
		else {
			local chi2 : display %9.2f `e(chi2_ms)'
		}
		local sk   _skip(`=3-strlen("`df'")')

		dis as txt  "`e(chi2type_ms)' test of model vs. saturated:" ///
 			    " chi2({res:`df'}) " `sk' "= {res:`chi2'}, "    ///
			    "Prob > chi2 = " as res %6.4f e(p_ms)
	}
	ml_footnote
end

exit
