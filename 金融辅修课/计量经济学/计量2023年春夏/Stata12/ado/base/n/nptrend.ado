*! version 1.1.9  15dec2004
program define nptrend, rclass sortpreserve
	version 6, missing
	syntax varname [if] [in], BY(varlist) [ noDetail Score(varname) ]
    
       
	marksample usable
	markout `usable' `score'
	markout `usable' `by', strok

/*
	keep if `usable'
*/

	quietly {
/*
	Is the grouping variable a string variable?
*/
		cap conf string var `by'
		if _rc == 0 { 
			tempvar byvar
			local string 1
			sort `usable' `by'
			qui by `usable' `by': /*
				*/ gen long `byvar' = 1 if `usable' & _n==1
			replace `byvar' = sum(`byvar') if `usable'
		}
		else {	
		 	local byvar "`by'"
			local string 0
		}
/*
	Create score.
*/
		local sc "`score'"
		tempvar score
		if "`sc'"=="" {
			gen `score' = `byvar' if `usable'
		}
		else 	gen `score' = `sc' if `usable'
/*
	Generate the rank sums.
*/
		tempvar ranksum obs tie
		egen `ranksum' = rank(`varlist') if `usable'
		gen long `obs' = 1 if `ranksum'<.
		sort `usable' `ranksum'
		by `usable' `ranksum': /*
			*/ gen `tie' = cond(_n==_N,sum(`obs'),.) if `usable'
		replace `tie' = sum(`tie'*(`tie'*`tie'-1))
		local ties = `tie'[_N]
		sort `usable' `byvar'
		by `usable' `byvar': /*
		*/ replace `ranksum'=cond(_n==_N,sum(`ranksum'),.) if `usable'
		by `usable' `byvar': /*
		*/replace `obs'=cond(_n==_N,sum(`obs'),.) if `usable'
/*
	Display the rank sums for each group.
*/
		noi di
		if "`detail'"=="" {
			local scol = 11 - length("`by'")
			noi di in gr _col(`scol') "`by'" _col(16) "score" /*
				*/ _col(28) "obs" _col(37) "sum of ranks"
			local i=0
			local j=0
			while `i'<_N {
				local i = `i'+1
				if (`obs'[`i']<. & `obs'[`i']!=0) {
					if `string' {
						local jby = rtrim(`by'[`i'])
						local scol = 11 - length("`jby'")
						noi di in ye _col(`scol') "`jby'" %10.0g `score'[`i'] %10.0g `obs'[`i'] "    " %10.0g `ranksum'[`i']
					}
					else noi di in ye %10.0g = `by'[`i'] %10.0g `score'[`i'] %10.0g `obs'[`i'] "    " %10.0g `ranksum'[`i']
				}
			}
			noi di
		}
/*
	Calculate the test statistic and p-value.
*/
		tempvar T L L2
		gen `T'=sum(`ranksum'*`score')
		gen `L'=sum(`score'*`obs')
		gen `L2'=sum(`score'*`score'*`obs')
		replace `obs'=sum(`obs')
		local T = `T' in l
		local L = `L' in l
		local L2 = `L2' in l
		local N = `obs' in l
		local ET = (`N'+1)*`L'/2
		local a=`ties'/(`N'*(`N'*`N'-1))        /* adj for ties */
		local VT = (1-`a')*(`N'*`L2'-`L'*`L')*(`N'+1)/12
		local z = (`T'-`ET')/sqrt(`VT')
		local pval = 2*( 1-normprob(abs(`z')))
	}
	di in gr "          z  = " in ye %5.2f `z'
	di in gr "  Prob > |z| = " in ye %5.3f `pval'
        
        
	return scalar N = `N'
	return scalar T = `T'
	return scalar z = `z'
	return scalar p = `pval'

	/* Double saves */
	global S_1  "`return(N)'"
	global S_2  "`return(T)'"
	global S_3  "`return(z)'"
	global S_4  "`return(p)'"
end
