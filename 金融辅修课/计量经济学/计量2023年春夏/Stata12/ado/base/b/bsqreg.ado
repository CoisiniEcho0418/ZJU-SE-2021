*! version 3.6.0  26apr2011
program define bsqreg, eclass byable(recall) sort prop(mi)
	version 6, missing
	local options "Level(cilevel)"
	if substr("`*'",1,1)=="," | "`*'"=="" {
		if "`e(cmd)'"!="bsqreg" { error 301 } 
		if _by() { error 190 }
		syntax [, `options' *]
		_get_diopts diopts options , `options'
	}
	else {
		local cmdline : copy local 0
		syntax varlist [if] [in] [, `options' Quantile(real .5) /*
		*/ WLSiter(integer 1) Reps(integer 20) *]
		if (`quantil'>=1) { local quantil = `quantil'/100 }
		if (`quantil'<=0 | `quantil'>=1) { error 198 }
		if (`reps')<2 { error 198 }

		_get_diopts diopts options , `options'
		marksample touse

		est clear

		tempname coefs VCE adj
		tempvar e bcons
		tempfile BOOTMST BOOTRES

		local opts "quantil(`quantil') wls(`wlsiter') `cons'"
		gettoken depv vl : varlist
		_rmcoll `vl' [`weight'`exp'] if `touse'
		local vl `r(varlist)'
		di in gr "(fitting base model)"
		qui qreg `depv' `vl' if `touse', `opts'
		local nobs `e(N)'
		local tdf `e(df_r)'
		local q `e(q_v)'
		local rsd  `e(sum_rdev)'
		local rq `e(q)'		/* about */
		local msd `e(sum_adev)'
		local frc `e(convcode)'
		if "`cons'"=="" {
			local vle "_cons"
			local vli "`bcons'"
		}
		mat `coefs' = get(_b)

		preserve

		quietly {
			keep if `touse'
			keep `depv' `vl'
			save "`BOOTMST'"
			drop _all
			set obs 1
			gen byte `e'=.
			save "`BOOTRES'"
		}
		di in gr "(bootstrapping " _c
		tokenize `vl'
		local j 1
		while `j'<=`reps' {
			quietly use "`BOOTMST'", clear 
			* bootsamp _N
			bsample
			cap noisily _crcbsqr `depv' `vl', `opts' /*see note 1*/
			local rc = _rc
			drop _all
			if (`rc'==0) {
				quietly set obs 1
				local i 1
				while "``i''"!="" {
					gen ``i''=_b[``i'']
					local i=`i'+1
				}
				if "`cons'"=="" { gen `bcons'=_b[_cons] }
				quietly {
					append using "`BOOTRES'"
					save "`BOOTRES'", replace
				}
				di in gr "." _c
				local j=`j'+1
			}
			else 	di in gr "*" _c
		}
		quietly mat accum `VCE' = `vl' `vli', dev nocons
		mat rownames `VCE' = `vl' `vle'
		mat colnames `VCE' = `vl' `vle'
		scalar `adj' = 1/(`reps'-1)
		mat `VCE'=`VCE'*`adj'
		est post `coefs' `VCE', obs(`nobs') dof(`tdf') depn(`depv')
		noi di in gr ")"
		restore
		est repost, esample(`touse')
		capture erase "`BOOTMST'"
		capture erase "`BOOTRES'"

		/* double save in S_E_ and e() */
		est local depvar "`depv'"
		est scalar reps = `reps'   /* undocumented */
		est hidden local vle "`vle'"      /* undocumented */
		est scalar N = `nobs'
		est scalar df_r = `tdf'
		est scalar q_v = `q'
		est scalar sum_rdev = `rsd'
		est scalar q = `rq'
		est scalar sum_adev = `msd'

		global S_E_depv "`depv'"
		global S_E_reps `reps'
		global S_E_vl "`vl'"
		global S_E_vle "`vle'"
		global S_E_nobs `nobs'
		global S_E_tdf `tdf'
		global S_E_q `q'
		global S_E_rsd `rsd'
		global S_E_rq `rq'
		global S_E_msd `msd'

		global S_E_cmd "bsqreg"
		global S_E_frc 0

		est repost, buildfvinfo
		est local marginsnotok stdp stddp Residuals
		est local predict "qreg_p"
		version 10: ereturn local cmdline `"bsqreg `cmdline'"'
		est local cmd "bsqreg"
		est scalar convcode = 0
		_post_vce_rank
	}
	di
	if (e(q)==0.5) { 
		di in gr "Median regression, bootstrap("  /*
		*/ in ye "`e(reps)'" in gr ") SEs" /*
		*/ _col(54) _c
	}
	else { 
		di in gr e(q) " Quantile regression, bootstrap(" /*
		*/ in ye "`e(reps)'" in gr ") SEs" /*
		*/ _col(54) _c 
	}
	di in gr "Number of obs =" in ye %10.0g e(N)
	di in gr "  Raw sum of deviations" in ye %9.0g e(sum_rdev) /*
		*/ in gr " (about " in ye e(q_v) in gr ")"
	di in gr "  Min sum of deviations" in ye %9.0g e(sum_adev) _col(54) /*
		*/ in gr "Pseudo R2     =" /*
		*/ in ye %10.4f 1 - (e(sum_adev)/e(sum_rdev))
	di
	est di, level(`level') `diopts'
	error e(convcode)
end


program define _crcbsqr
	syntax varlist [, Quantile(real 0.5) WLSiter(integer 1) noLOg ]
	local quant "`quantil'"
	if `wlsiter'<1 { error 198 }
	quietly {
		tempvar r s2 hat
		gen long `s2' = _n

		_qregwls `varlist', quant(`quant') iterate(`wlsiter') r(`r') `log'

		sort `r' `s2'
		drop `r' 

		cap _qreg `varlist', quant(`quant')
		if (r(convcode)!=1 | _rc~=0) {
			if (_rc==1) { exit 1 }
			exit -2000
		}

		_predict `hat'
		tokenize `varlist'
		mac shift
		reg `hat' `*'
	}
end
exit

Notes
-----

Note 1.
You can substitute qreg for _crcbsqr, the result being only to slow the
program down.  _crcbsqr is an alternative that
	1)	does not allow if exp or in range`
	2)	does not allow weights
	3)	produces no output
	4)	produces no estimates of the standard errors
