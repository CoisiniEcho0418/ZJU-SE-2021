*! version 3.3.4  13jun2000 updated 17sep2004
program define dotplot_7, rclass sort
	version 6.0, missing
	syntax varlist(numeric) [if] [in] [, /*
		*/ BY(varname) NX(int -1) NY(int 35) EXact_y /*
		*/ BOunded YLOg XLOg Incr(int 1) CEntre CEnter /*
		*/ AVerage(string) Bar Vert Symbol(string) Pen(string) /*
		*/ T1title(string) L1title(string) B2title(string) /*
		*/ Connect(string) MEAN MEDian noGRoup SHOWGR * ]

	if `"`center'"'!=`""' & `"`centre'"'==`""' {
		local centre `"`center'"'
	}
	local centre = (`"`centre'"'!=`""')

	if `"`mean'"'!="" { 
		if `"`average'"'!="" { error 198 } 
		local average `"mean"'
	}
	if `"`median'"'!="" {
		if `"`average'"'!="" { error 198 } 
		local average `"median"'
	}
	if `"`group'"'!="" {		/* if nogroup */
		local exact_y `"exact_y"'
	}
	if `"`by'"'!="" {
		local wcnt : word count `varlist'
		if `wcnt' > 1 {
			di in red `"only 1 variable may be plotted with by()"'
			exit 198
		}
	}
	if `incr' <= 0 {
		di in red `"incr() must be greater than 0"'
		exit 198
	}

	tempvar touse x y xc yc 
	tempname xlbl

/* mark/markout. */

	mark `touse' `if' `in'

/* Look for XLAbel or XLAbel() in `options'. */

	ChkXlab, `options'
	local XLAB `r(is_xlab)'

/* Put names of y-variables and integers 1, 2, ... into xdef. */

	tokenize `varlist'
	local nyvars 1
	while `"``nyvars''"'!="" {
		local yname : var lab ``nyvars''
		if `"`yname'"'==`""' { local yname `"``nyvars''"' }

		local xdef `"`xdef' `nyvars' `"`yname'"'"'

		if `"`xunique'"'==`""' { local xunique `"`nyvars'"' }
		else local xunique `"`xunique',`nyvars'"'
	
		local nyvars = `nyvars' + 1
	}
	local nyvars = `nyvars' - 1

	quietly { 
		if `"`by'"'!=`""' {
			capture confirm string variable `by'
			if !_rc { 
				tempvar by2
				encode `by', gen(`by2')
				_crcslbl `by2' `by' 
				local by `by2' 
			}	
			markout `touse' `varlist' `by'

			count if `touse'
			if r(N)==0 { noisily error 2000 }

			gen `y' = `varlist' if `touse'
			local ylbl : value label `varlist'
			gen `x' = `by' if `touse'

			sort `x'
			gen byte `xc'= -(`x'!=`x'[_n-1]) if `touse'
			count if `xc'==-1
			local cols = r(N)
			if `cols'/`incr' > 25 {
				local incr = int(`cols'/25) + 1
			}
			if `XLAB' == 0 {
				sort `xc' `x'
				local xunique
				local j 1
				local xj = .
				while `j' > 0 & `j' < `cols'+1 {
					local xj1 = round(`x'[`j'],.01)
					if `xj1'!=`xj' {
						local xj = `xj1'
						if `"`xunique'"'==`""' {
							local xunique `"`xj'"'
						}
						else local xunique /*
						*/         `"`xunique',`xj'"'
					}
					local j	= `j'+`incr'
					if `xc'[`j']==0 {local j 0}
			   	}
				if `"`xunique'"'==`"`xj'"' {
					local xj1 = `x'[1]
					local xj = `x'[`cols']
					local xunique `"`xj1',`xj'"'
				}
			}
			if `cols' > 1 | `centre' {
				_crcslbl `xc' `by'
				local xlbl : value label `by'
			}
		}
		else { /* no by() */
			if `nyvars' > 1 {
				if substr(`"`symbol'"',1,1)=="[" {
					di in red `"symbol([varname]) not "' /*
					*/ `"allowed with varlist"'
				}
				preserve
				keep if `touse'
				keep `varlist' 

				stack `varlist', into(`y') clear
				local ylbl : value label `y'

				drop if `y'>=.
				local touse 1

				if _N == 0 { noisily error 2000 }

				local x `"_stack"'
			}
			else {
				markout `touse' `varlist'

				count if `touse'
				if r(N)==0 { noisily error 2000 }

				gen `y' = `varlist' if `touse'
				local ylbl : value label `varlist'

				gen byte `x' = 1 if `touse'
			}

			gen `xc' = .
			label var `xc' " " /* ??? */
			label define `xlbl' `xdef'
			local cols `nyvars' /* no. of columns to be plotted */

			if `cols'/`incr' > 25 {
				local incr = int(`cols'/25) + 1
			}
			if `incr' > 1 {
				local j 1
				local xunique `"1"'
				while `j' < `cols'+1-`incr' {
				    local j = `j'+`incr'
				    local xunique `"`xunique',`j'"'
				}
			}
		}

		label values `xc' `xlbl'

	/*
	   Xoffset expands the plotting range for the x-axis
	   by .5 of an x unit.
	*/
		Xoffset `x' `cols' `centre' `"`xlog'"' 
		local x0 = r(xlower)
		local x1 = r(xupper)
		local xrange = r(xrange)

	/* Create `yc' plotting variable for y-axis. */

		if `"`exact_y'"'!="" { gen `yc' = `y' if `touse' }
		else { /* group `y' */
			Group_y `y' `yc' `ny' `"`ylog'"' `"`bounded'"'
		}
		lab val `yc' `ylbl'

		if `"`average'"'!="" {
			tempvar me
			capture egen `me' = `average'(`y'), by(`x')
			if _rc {
				noisily di /*
				*/ `"`average' not valid with average()"' 
				exit 198
			}

			local ym `"`me'"'
			local st p
			local pa 4
		}

		if `"`bar'"'!="" {
			tempvar yb1 yb2 dash 
			if substr(`"`average'"',1,3)=="mea" {
				egen `yb1' = sd(`y'), by(`x')
				gen `yb2' = `ym'+`yb1'
				replace `yb1' = `ym'-`yb1'
			}
			else {
				egen `yb1' = pctile(`y'), p(25) by(`x')
				egen `yb2' = pctile(`y'), p(75) by(`x')
			}
			gen byte `dash' = 1
			lab def `dash' 1 `"_"'
			lab val `dash' `dash'
			local yb `"`yb1' `yb2'"'
			local da `"[`dash'][`dash']"'
			local pb 44
		}

		sort `x' `yc'

		if `centre' {
			by `x' `yc': replace `xc' = _n - (_N+1)/2

			if `"`vert'"'!="" {
		      		cap replace `me' =. if (`xc'>.5)|(`xc'< -.5)
		      		cap replace `yb1'=. if (`xc'>.5)|(`xc'< -.5)
		      		cap replace `yb2'=. if (`xc'>.5)|(`xc'< -.5)
		  	}
		}
		else {
			by `x' `yc': replace `xc' = (_n-1)

			if `"`vert'"'!="" & `cols'>1 {
		      		cap replace `me'=. if `xc'!=0
		      		cap replace `yb1'=. if `xc'!=0
		      		cap replace `yb2'=. if `xc'!=0
		   	}
		}

		if `nx'==-1 {
			summarize `xc' if  `x'< . & `yc'< .
			local nx = int(`cols'* /*
			*/	((1+`centre')*r(max)+(`cols')^.3))
		}

		ret scalar nx = `nx'
		local nx = `nx'/`xrange'

		if `"`xlog'"'== "" {
			replace `xc' = `x'+`xc'/`nx'
		}
		else	replace `xc' = exp(log(`x')+`xc'/`nx')

		local xlab1 `"xlab(`xunique')"'

		if  !`centre' & `cols'==1 {
			local xlab1 `"xlab"'
			label values `xc'
			by `x' `yc': replace `xc' = _n
			local b2t `"Frequency"'
			local x0 0
			local x1 `nx'
			if `"`vert'"'!="" {
				count if `x'< .
				if r(N)==_N { 
					preserve 
					local NN = _N + 1
					set obs `NN'
			   	}

				replace `xc' = 0 if `x'>=.
				cap summarize `me'
		      		cap replace `me' = r(mean)
		      		cap replace `me' = . if `x'< .
				cap summarize `yb1'
		      		cap replace `yb1' = r(mean)
		      		cap replace `yb1' = . if `x'< .
				cap summarize `yb2'
		      		cap replace `yb2' = r(mean)
		      		cap replace `yb2' = . if `x'< .
			}
		}

		if `"`by'"'!="" | `cols'==1 { local l1t `"`yname'"' }
		else			      local l1t `" "'

		if `"`t1title'"'=="" { local t1title `" "' }
		if `"`l1title'"'=="" { local l1title `"`l1t'"' }
		if `"`b2title'"'=="" { local b2title `"`b2t'"' }
		if `"`symbol'"' =="" { local symbol  `"o"' }

		if `"`vert'"'!="" { local cv `"||"' }
		else		    local cv `".."'

		if `"`connect'"'=="" {
			local connect `".`cv'"'
			if `"`average'"'!="" { local connect `"..`cv'"' }
		}

		local symbol `"`symbol'`st'`da'"'

		if `"`pen'"'=="" { local pen `"2`pa'`pb'"' }

		if `XLAB' { local xlab1 }
		else if `"`xlab1'"'!="xlab" {
			local setgr : set graphics
			set graph off
			capture gr7 `yc' `xc', s(i) `xlab1'
			if _rc { local xlab1 `"xlab"' }
			set graph `setgr'
		}
	}

	ret scalar ny = `ny'

	if `"`showgr'"'!="" {
		di _n `"gr7 `yc' `ym' `yb' `xc', s(`symbol') pen(`pen')"'
		di `"      c(`connect') `xlab1' xscale(`x0',`x1') `ylog' `xlog'"'
		di `"      l1(`l1title') t1(`t1title') b2(`b2title') `options'"'
	}

	gr7 `yc' `ym' `yb' `xc', s(`symbol') pen(`pen') /*
    	*/	c(`connect') `xlab1' xscale(`x0',`x1') `ylog' `xlog' /*
  	*/	l1(`"`l1title'"') t1(`"`t1title'"') b2(`"`b2title'"') `options'

	/* double save in S_# and r()  */
	global S_1 `return(nx)'
	global S_2 `return(ny)'
end

program define ChkXlab, rclass
	/* Returns r(is_xlab)==1 if xlabel or xlabel() specified in options */
	capture syntax [, XLAbel *]
	if _rc==0 & `"`xlabel'"'!="" {
		ret scalar is_xlab = 1
		exit
	}

	capture syntax [, XLAbel(string) *]
	if _rc==0 & `"`xlabel'"'!="" {
		ret scalar is_xlab = 1
		exit
	}
	ret scalar is_xlab = 0
end

program define Xoffset, rclass
	/*
	xoffset expands the plotting range for the x-axis by .5 of an x unit.

	Plotting range returned in r(xlower) and r(xupper).  
	xrange returned in r(xrange).
	*/
	args x cols centre xlog 
	local small  1e-6

	quietly summarize `x', meanonly
	local min = r(min)
	local max = r(max)

	if `"`xlog'"'=="" {
		local xrange = `max'-`min'
		if abs(`xrange') < `small' { local xrange 1 }
		local xoffset =0.5*(`xrange'/`cols')
		ret scalar xlower = `min'-`xoffset'*(1+`centre')
		ret scalar xupper = `max'+`xoffset'*2
		ret scalar xrange = `xrange'
		exit
	}

	/* Here if xlog. */

	if `min'<= 0 { error 411 }

	local xrange = log(`max')-log(`min')
	if abs(`xrange') < `small' { local xrange 1 }
	local xoffset =0.5*(`xrange'/`cols')
	ret scalar xlower = exp(log(`min')-`xoffset'*(1+`centre'))
	ret scalar xupper = exp(log(`max')+`xoffset'*2)
	ret scalar xrange = `xrange'
end

program define Group_y
	/*
	Create grouped `yc' variable from `y'.
	*/
	args y yc ny ylog bounded

	quietly {
		sort `y'
		summarize `y', meanonly
		local min = r(min)
		local max = r(max)
		local yprec 0
	
		if `"`ylog'"'=="" {
			gen `yc' = `y'-`y'[_n-1]
			summarize `yc' if `yc'>0
	
			if r(min)< . { local yprec = r(min) }

			if (`max'-`min')/`ny' < `yprec' { local yprec 0 }
			else local yprec = round((`max'-`min')/`ny',`yprec')

	  		if `"`bounded'"'!="" & `yprec'>0 {
				replace `yc' = /*
				*/ autocode(`y',`ny',`min',`max') /*
				*/ -(`max'-`min')/(2*`ny')
			}
			else replace `yc' = round(`y',`yprec')
	
			exit
		}

	/* Here if ylog. */

		if `min' <= 0 { error 411 }

		gen `yc' = log(`y')-log(`y'[_n-1])
		summarize `yc' if `yc'>0
	
		if r(min)< . { local yprec = r(min) }

		local yr = (log(`max')-log(`min'))/`ny'
	
		if `yr' < `yprec' { local yprec 0 }
		else local yprec = round(`yr',`yprec')

		if `"`bounded'"'!="" & `yprec'>0 {
			replace `yc' = exp( /*
			*/ autocode(log(`y'),`ny',log(`min'),log(`max')) /*
			*/ - `yr'/2 )
		}
		else replace `yc' = exp(round(log(`y'),`yprec'))
	}
end
