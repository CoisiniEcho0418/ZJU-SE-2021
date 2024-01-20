*! version 2.3.0  09jun2011
/* Postestimation command of stcox, estat concordance, is called */
/* through stcstat.ado 						 */					
program define stcstat, rclass sort /* [if exp] [in range] */
        version 8
        st_is 2 analysis
        syntax [if] [in] [, ALL noSHow Harrell GHeller SE ]
        marksample touse

	if `"$S_E_cmd2"' != "stcox" {
                error 301                /* last estimates not found        */
        }
        tempvar h
        quietly {
                if "`all'"=="" {
                        local restriction "if e(sample)"
                }
		predict double `h' `restriction'
		if ("`gheller'"!="") {
			tempvar xb
			predict double `xb' `restriction', xb
		}
		markout `touse' `h' `xb'
        }

        if `"`_dta[st_w]'"' != "" {
                di as err /*
		*/ "estat concordance may not be used with weighted data"
                exit 498
        }

        capture assert `_dta[st_t0]'==0 if `touse'
        if _rc {
                di as err /*
	        */ "estat concordance may not be used with late entry or "/*
		*/ "time-varying data"
                exit 498
        }

        if "`e(texp)'" != "" {
               	di as err /*
        	*/ "estat concordance may not be used with option tvc() "/*
		*/ "or time-varying data"
		exit 498
	}
	if ("`se'"!="") {
		local stderr stderr
	}
	if "`gheller'"=="" & "`stderr'"!="" {
		di as err /*
		*/ "option {bf:se} requires specifying option {bf:gheller}"
		exit 198
	}
	if "`e(strata)'"!="" & "`gheller'"!="" {
		di as err /*
		*/ "option {bf:gheller} is not supported for " /// 
			"stratified estimation"
		exit 498
	}
	if "`e(shared)'"!="" & "`gheller'"!="" {
		di as err /*
		*/ "option {bf:gheller} is not supported for " ///
			"shared-frailty models"
		exit 498
        }
	if "`_dta[st_id]'"!="" & "`gheller'"!="" {
		cap isid `_dta[st_id]'
		if _rc {
			di as err /*
			*/ "option {bf:gheller} is not supported for " ///
				"multiple-record data"
			exit 498
		}
        }

        st_show `show'

if ("`gheller'"=="" | "`harrell'"!="") {

	di
        di as txt _col(3) "Harrell's C concordance statistic"

        local t : char _dta[st_t]
        local d : char _dta[st_d]

		local strata = cond("`e(strata)'"=="",0,1)	
		tempvar Dv group group_touse
	
		if `strata' {
			qui egen long `group' = group(`e(strata)') if `touse'
			qui sum `group', meanonly
			local groups = `r(max)'
		}
		else {
			qui gen byte `group' = 1 if `touse'
			local groups 1
		}
        quietly {
                sort `touse' `group' `h'
                count if `touse'
                local totobs = r(N)
                capture assert e(sample)==`touse'
                if _rc { 
                        noi di as txt "{p 2}" /*
                        */  "(note: different samples used to fit" /*
                        */ " model and to calculate C statistic){p_end}"
                }
		local start = _N - `totobs' + 1
		local num 0
		local den 0
		forvalues g = 1/`groups' {
			//gen `group_touse' = `touse' & `group'==`g'
			//sort `group_touse' `h'
			count if `group'==`g' & `touse'
			local L = `start' + `r(N)' - 1

                local D 0
                local N 0   /* N = # as expected; on output we will call
                               N E */
                local T 0
                forvalues i = `start'/`L' {
			local j = min(`i' + 1,`L')
                                                
                        gen byte `Dv' = `d'[`i'] & `d' in `j'/`L'

                        replace `Dv' = 2 /*
                        */ if (!`Dv') & `d'[`i'] & `t'[`i']<=`t' in `j'/`L'
                        replace `Dv' = 3 /* 
                        */ if (!`Dv') & `d' & `t'[`i']>=`t' in `j'/`L'
                        replace `Dv'=0 /*
                        */ if (abs(`t'-`t'[`i'])<1e-12)& (`Dv'==1) in `j'/`L'
                        
                        count if `Dv' in `j'/`L'
                        local D = `D' + r(N)

                        count if `Dv' & `h'[`i']==`h' in `j'/`L'
                        local T = `T' + r(N)

                        count if `Dv'==1 & `h'[`i']!=`h' & `t'[`i']>`t' /*
                                */ in `j'/`L'
                        local N = `N' + r(N)

                        count if `Dv'==3 & `h'[`i']!=`h' & `t'[`i']>=`t' /*
                                */ in `j'/`L'
                        local N = `N' + r(N)
                        
                        drop `Dv'
                }
			local num = `num' + (`N' + `T'/2)
			local den = `den' + `D'	
			local start = `L' + 1
		}
        }

	di
	if !`strata' {	
		ret scalar n_T = `T'
	    	ret scalar n_E = `N'
		ret scalar n_P = `D'      
 		di as txt _col(3) "Number of subjects (N)" _col(38) " = " /*
		*/as res %8.0f `totobs'
	        di as txt _col(3) "Number of comparison pairs (P)" _col(38) /*
		*/ " = " as res %8.0f `D'
        	di as txt _col(3) "Number of orderings as expected (E)" /*
		*/ _col(38) " = " as res %8.0f `N' /* sic */
	        di as txt _col(3) "Number of tied predictions (T)" _col(38) /*
		*/" = " as res %8.0f `T'
        	di
	}
        ret scalar C = `num' / `den'
        tempname SomerD
        scalar `SomerD' = 2*(return(C)-0.5)
	if !`strata' {
        	di as txt _col(11) "Harrell's C = (E + T/2) / P" /*
			*/ _col(38) " = " as res %8.4g return(C)
	}
	else {
	        di as txt _col(27) "Harrell's C" _col(38) " = " /*
			*/ as res %8.4g return(C)
	}
	
	if ("`gheller'"=="") {
        	di as txt _col(29) "Somers' D" _col(38) " = " 	///
			as res %8.4g `SomerD'
	}
	else {
        	di as txt _col(20) "Somers' D = 2C - 1" _col(38) " = " ///
			as res %8.4g `SomerD'
		local col = 38
		local DKlab " = 2K - 1"
	}
	ret scalar D   = `SomerD'
	ret scalar N   = `totobs'


} // end of Harrel's C

	if "`gheller'"!="" {
		di
        	di as txt _col(3) "Gonen and Heller's K concordance statistic"

		/* Extract V without omitted variables */
		tempname V
		_ms_omit_info e(b)
		if `r(k_omit)' {
			tempname tokeep
			mata: st_matrix("`tokeep'", 1:-st_matrix("r(omit)"))
			mata: 	///
		st_matrix("`V'",select( select(st_matrix("e(V)"), 	///
				st_matrix("`tokeep'")), st_matrix("`tokeep'")'))
		}
		else {
			mat `V' = e(V)
		}
		local vars : colnames e(b)
        	local vars : subinstr local vars "_cons" "", all

		qui sort `touse' `xb'
		qui count if `touse'
		local obs = r(N)
		capture assert e(sample)==`touse'
		if _rc {
			di as txt "{p 2}" _n /*
			*/  "(note: different samples used to fit" /*
			*/ " model and to calculate K statistic){p_end}"
		}
		qui sum `xb' if `touse'
		tempname bw
		scalar `bw' = 0.5*(`obs')^(-1/3)*r(sd)
	
		if "`stderr'"!="" {
			mata: 	///
		KnBse("`xb'","`touse'",`=`bw'',"`vars'","`V'","`tokeep'")
			ret scalar K_s_se = r(As_se)
			ret scalar K_s = r(As_KnB)
		}
		else {
			mata: KnB("`xb'","`touse'")
		}

		tempname SomerD
       		scalar `SomerD' = 2*r(KnB)-1
	
		ret scalar D_K = `SomerD'
		ret scalar K = r(KnB)
		ret scalar N = `obs'

		if ("`col'"=="") {
			local col = length("Gonen and Heller's K")+11
		}
		local col1 = `col'-1
		di
		di as txt _col(3) "Number of subjects (N)" _col(`col') " = " /*
			*/ as res %8.0f `obs'
		di
		di as txt "{ralign `col1':Gonen and Heller's K}" /*
			*/ _col(`col') " = " as res %8.4g return(K)
		di as txt "{ralign `col1':Somers' D`DKlab'}" _col(`col') " = " /*
			*/ as res %8.4g `SomerD'
		if "`stderr'"!="" {
di as txt "{ralign `col1':Gonen's smoothed K}" _col(`col') " = " /*
	*/ as res %8.4g return(K_s)
di as txt "{ralign `col1':Asymptotic SE}" _col(`col') " = " /*
	*/ as res %8.4g return(K_s_se)
		}
	} // end -gheller-
end

version 11.0
mata:

void KnB(string scalar xbname, string scalar tousename)
{
	real scalar i, N, temp
	real colvector xb, sum1

	st_view(xb=., ., xbname, tousename)
	N	= rows(xb)
  	temp	= 0
  	for (i=1; i<N; i++) {
		sum1	= runningsum(1:/(1 :+ exp(-abs(xb:-xb[i]))))
		temp	= temp + sum1[N] - sum1[i]
  	}
  	st_numscalar("r(KnB)", 2*temp/(N*(N-1)))
}

void KnBse(string scalar xbname, string scalar tousename, real scalar bw,
	   string scalar vars, string scalar eV, |string scalar tokeep)
{
	real scalar N, i, sum_u, KnB, AKnB, temp1, temp2, d1, se
	real colvector xb, hij, denij, denji, Fij, uij, uji, u, fij
	real colvector rsum_KnB, rsum_AKnB, PD_term1, PD_term2, PD
	real matrix Xall, X

	st_view(xb=., ., xbname, tousename)
	if (tokeep!="") {
		st_view(Xall=., ., vars, tousename)
		st_select(X,Xall,st_matrix(tokeep))
	}
	else st_view(X=., ., vars, tousename)

  	N	= rows(xb)
  	KnB	= 0
  	AKnB	= 0
  	temp1	= 0
  	temp2	= 0
  	PD	= J(cols(X),1,0)
  	for (i=1;i<=N;i++) {
		hij	= xb[i]:-xb
		denij	= 1:+exp(hij)
       		denji	= 1:+exp(-hij)
		Fij	= normal(hij/bw)
		uij	= Fij :/ denji
		uji	= (1:-Fij) :/ denij
		u	= uij + uji
		if (i!=N) {
			rsum_KnB	= runningsum(1:/(1:+exp(-abs(hij))))
  	  		rsum_AKnB	= runningsum(u)
	  		KnB		= KnB + rsum_KnB[N] - rsum_KnB[i]
	  		AKnB		= AKnB + rsum_AKnB[N] - rsum_AKnB[i]
	
			fij = normalden(hij/bw)
			PD_term1 = (fij:/denji)/bw + uij:*exp(-hij):/denji
			PD_term2 = (fij:/denij)/bw + uji:*exp(hij):/denij
			PD = PD + cross(X[i,.]:-X[i+1..N,.], 
					PD_term1[i+1..N]-PD_term2[i+1..N])
			sum_u = rsum_AKnB[N]
		}
		else sum_u = sum(u)
		temp1	= temp1 + sum_u^2 - cross(u,u)
		temp2	= temp2 + 2*sum_u
  	}

  	d1	= N*(N-1)
  	KnB	= KnB*2/d1
  	AKnB	= AKnB*2/d1

  	se = 4*(temp1 + cross(cross(PD,st_matrix(eV))',PD))/(d1*d1) - 
	     4*temp2*AKnB/(d1*N) + 4*AKnB*AKnB/(N-1)
  	se = sqrt(se)

  	st_numscalar("r(KnB)",    KnB)
  	st_numscalar("r(As_KnB)", AKnB)
  	st_numscalar("r(As_se)",  se)

}
end

exit

