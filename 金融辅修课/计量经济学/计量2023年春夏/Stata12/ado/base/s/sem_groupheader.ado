*! version 1.0.1  31jul2010
program sem_groupheader
	version 12

	syntax anything(name=g) [, ///
		noBEFore 	/// skip blank line before header
		noAFTer 	/// skip blank line after header
		noHLINE		/// skip {hline} after text
	]

	if "`e(cmd)'"!="sem" {
		error 301
	}
	if `e(N_groups)'==1 {
		exit
	}

	confirm integer number `g'
	assert `g'>=0 & `g'<=`e(N_groups)'

	if `g'==0 {
		local gtxt `"All groups "'
	}
	else {
		if "`e(groupvar)'"!="" {
			local gval   = el(e(groupvalue), 1, `g')
			local dgroup `"`e(groupvar)'=`gval'; "'
		}
		local n    = el(e(nobs), 1, `g')
		local glab : word `g' of `e(grouplabel)'
		if `"`glab'"'!="" {
			local gtxt `"Group #`g': `glab' (`dgroup'N=`n') "'
		}
		else {
			local gtxt `"Group #`g' (`dgroup'N=`n') "'
		}
	}

	if ("`before'"=="") {
		dis
	}

	dis as txt `"`gtxt'"' _c

	if "`hline'"=="" {
		local len  = length("`gtxt'")
		dis "{hline `=78-`len''}"
	}
	else {
		dis
	}

	if ("`after'"=="") {
		dis
	}
end
exit
