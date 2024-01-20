*!version 6.6.0  09may2009
program define _stcurv, rclass
	version 6
	if "`e(cmd2)'" != "streg" & "`e(cmd2)'"!= "stcox" & ///
	   "`e(cmd)'"  != "stcrreg" {
		error 301
	}
	/* save() is not optional */
        syntax , save(string) [		/*
		*/ CUMHaz		/*
		*/ SURvival		/*
		*/ HAZard		/*
		*/ CIF			/*
		*/ noBoundary		/*
		*/ UNCONDitional	/*
		*/ ALPHA1		/*
		*/ Range(numlist	/*
		*/ 	ascending	/*
		*/ 	min=2		/*
		*/ 	max=2		/*
		*/ )			/*
		*/ AT(string)		/*
		*/ Kernel(passthru)	/*
		*/ width(real -1)	/*
		*/ base(varname)	/*
		*/ LEFTBOUNDARY(passthru)	/* undocumented
	*/ ]

	local n = ("`cumhaz'"!="") + ("`surviva'"!="") + /// 
	          ("`hazard'"!="") + ("`cif'"!="")

	if `n'==0 { 
		di in red /*
*/ "must specify one of the options cumhaz, survival, hazard, or cif"
		exit 198
	}
	if `n'>1 { 
		di in red /*
*/ "must specify only one of cumhaz, survival, hazard, and cif"
		exit 198
	}

	if "`e(cmd)'" != "weibull" &  "`e(cmd)'" != "ereg" /*
	*/ & "`e(cmd)'" != "lnormal" & "`e(cmd)'" != "llogistic" /*
	*/ & "`e(cmd)'" != "gompertz" & "`e(cmd)'" != "gamma" & /*
	*/ "`e(cmd)'" != "cox" & /*
	*/ "`e(cmd)'" != "weibullhet" &  "`e(cmd)'" != "ereghet" /*
	*/ & "`e(cmd)'" != "lnormalhet" & "`e(cmd)'" != "llogistichet" /*
	*/ & "`e(cmd)'" != "gompertzhet" & "`e(cmd)'" != "gammahet" /*
	*/ & "`e(cmd)'" != "stcox_fr" & "`e(cmd)'" != "stcrreg" {
		di in red /*
		*/ "stcurve cannot yet graph using the `e(cmd)' distribution"
		exit 301
	}
	if "`e(stcurve)'"=="" & `"`e(frailty)'"'=="" /*
		*/ & "`e(cmd)'" != "cox" & "`e(cmd)'" != "stcox_fr"  & /*
		*/ "`e(cmd)'" != "stcrreg" {
		di in red /*
		*/ "stcurve cannot graph the `e(cmd)' distribution" 
		di in red "when ancillary() or strata() options are specified"
		exit 301
	}
	else local model="`e(cmd)'"
	if "`model'"=="cox" & "`e(strata)'"!="" {
		di in red /*
		*/ "stcurve not allowed after stcox, strata()"
		exit 198
	}
	if "`model'"!="cox" & "`model'"!="stcox_fr" {
		if `"`kernel'"'!="" | `width'!=-1 {
			di in red "smoothing options kernel() and width() " _c
			di in red "only valid after stcox"
			exit 198
		}
	}
	if "`model'" == "stcrreg" & "`surviva'`hazard'" != "" {
		di as err "`surviva'`hazard' not available after stcrreg"
		exit 198
	}
	if "`cif'" != "" & "`model'" != "stcrreg" {
		di as err "cif available only after stcrreg"
		exit 198
	}

	if "`range'"!="" {
		local begin: word 1 of `range'
		local end  : word 2 of `range'
		local bopt="begin(`begin')"
		local eopt="end(`end')"
	}

	tempname B
	preserve
	qui keep if e(sample)
	if "`at'"!="" {
		mat `B'=e(b)
		tokenize "`at'" ,parse(" =,")
		while "`1'"!="" {
			_ms_parse_parts `1'
			if "`r(type)'"!="variable" {
				di in smcl as err /*
				*/ "{p}level indicators of factor" /*
				*/ " variables may not be individually set" /*
				*/ " with the at() option; set one value" /*
				*/ " for the entire factor variable{p_end}"
				exit 198
			}
			confirm var `1'
			confirm number `3'
			CheckVar `1' `B' `3'
			qui replace `1' `2' `3'
			local atlist `atlist' `1'
			if "`4'"=="," {
				mac shift 4
			}
			else { mac shift 3 }
		}
		unab atlist: `atlist'
		CheckInteract `B' "`atlist'"
	}
	tempname nff nt
	if "`model'"== "weibull" | "`model'"== "weibullhet" { 
		WeiPlot `nff' `nt', /* 
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Weibull regression"
	}
	if "`model'"== "ereg"  | "`model'"== "ereghet" { 
		ExpPlot `nff' `nt', /* 
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Exponential regression"
	}
	if "`model'"== "lnormal" | "`model'"=="lnormalhet" { 
		LnoPlot `nff' `nt', /* 
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Lognormal regression"
	}
	if "`model'"== "llogistic" | "`model'"== "llogistichet" { 
		LloPlot `nff' `nt', /*
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Loglogistic regression"
	}
	if "`model'"== "gompertz"  | "`model'"== "gompertzhet" { 
		GomPlot `nff' `nt', /* 
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Gompertz regression"
	}
	if "`model'"== "gamma"  | "`model'"== "gammahet" { 
		GamPlot `nff' `nt', /* 
			*/ `cumhaz' `surviva' `hazard' `bopt' `eopt' /*
			*/ `uncondi' `alpha1' atlist(`atlist')
        	local bb "Generalized gamma regression"
	}
	if "`model'"== "cox" || "`model'" == "stcox_fr"  { 
		if "`surviva'"!="" & "`base'" == "" {
			if "`e(bases)'"==""{
				di in red /* 
				*/"must specify basesurv() option in stcox"
				exit 198
			}
		}
		if "`hazard'"!="" & "`base'" == "" {
			if "`e(basehc)'"==""{
				di in red /* 
				*/"must specify basehc() option in stcox"
				exit 198
			}
		}
		if "`cumhaz'"!="" & "`base'" == "" {        /* cumhaz */
			if "`e(basech)'"=="" {
				di in red /*
				*/"must specify basechazard() option in stcox"
				exit 198
			}
		}
		if "`base'" != "" {
			local baseopt base(`base')
		}
	
		CoxPlot `nff' `nt', `cumhaz' `surviva' `hazard' ///
			`kernel' width(`width') `leftboundary' ///
			`boundary' `bopt' `eopt' `baseopt' atlist(`atlist')
        	local bb "Cox proportional hazards regression"
	}
	if "`model'" == "stcrreg" {
		CrrPlot `nff' `nt', `cumhaz' `cif' `bopt' `eopt' ///
		base(`base') atlist(`atlist')
		local bb "Competing-risks regression"
	}
	label var `nt' "`e(depvar)'"
	qui save `"`save'"', replace
	ret local myvars = "`nff' `nt'"
 	ret local bb=`"`bb'"'
end

prog def CheckVar 
	args varn B level
	unab myvarn: `varn'
	local bnames: colnames `B'
	local bnames: subinstr local bnames "_cons" "", all
	unopvarlist `bnames'
	local bnames2 `r(varlist)'
	local list : list bnames - bnames2
	local bsize: word count `bnames'
	tokenize `bnames'
	local flag 0
	local i 1
	while `i'<=`bsize' {
		_ms_parse_parts `1'
		if "`r(type)'" == "variable" {
			if "`myvarn'"=="`1'" {
				local flag 1
			}
		}
		else if "`r(type)'" == "interaction" {
			forvalues j = 1/`r(k_names)' {
				if "`myvarn'"=="`r(name`j')'" {
				  if "`r(op`j')'" != "c" {
					qui count if `myvarn'==`level'
					if !`r(N)' {
					  di as err "`level' is not a valid" /*
					  */ " level for factor variable" /*
					  */ " `myvarn'"
					  exit 198
					}
					else {
					  local flag 1
					}
				  }
				  else {
				    local flag 1
				  }
				}
			}
			
		}
		else {
			if "`myvarn'"=="`r(name)'" {
				qui count if `myvarn'==`level'
				if !`r(N)' {
				  di as err "`level' is not a valid level" /*
				  */ " for factor `myvarn'"
				  exit 198
				}
				else {
				  local flag 1
				}
			}
		}
		mac shift
		local i=`i'+1		
	}
	if `flag'==0 {
		noi di in red /*
		*/ "at() variable `myvarn' not in the estimated model"
		exit 198
	}
end

prog def CheckInteract 
	args B atlist
	local bnames: colnames `B'
	local bnames: subinstr local bnames "_cons" "", all
	unopvarlist `bnames'
	local varnames `r(varlist)'
	if "`bnames'" == "`varnames'" {
		continue
	}
	local bsize: word count `bnames' 
	tokenize `bnames'
	local i 1
	while `i'<=`bsize' {
		_ms_parse_parts `1'
		local list ""
		if "`r(type)'"=="interaction" {
			forvalues j = 1/`r(k_names)' {
				if "`r(op`j')'" != "c" {
				  local list `list' `r(name`j')'
		}
			}
			local same : list list & atlist
			if "`same'" != "" {
				local inlist : list list in atlist
				if !`inlist' {
				  di in smcl as err /*
				  */ "{p}the model contains an" /*
				  */ " interaction involving factor" /*
				  */ " variables; the level for each" /*
				  */ " variable in the interaction must" /*
				  */ " be set with the at() option{p_end}"
				  exit 198
				}
			}
		}	
		local ++i
		mac shift
	}
end

program define WeiPlot 
	syntax newvarlist(gen min=2 max=2) [, CUMHaz SURvival HAZard /*
		*/ UNCONDitional ALPHA1 /*
		*/ Begin(string) End(string) atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"
	local t:   char _dta[st_t]
       	local wtopt:  char _dta[st_w]  
	tempname b A M
       	tempvar  flag
	mat `b'= get(_b)
	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1'=`M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}

	qui replace _st=1
	qui replace _t0=0

  	if "`cumhaz'"!="" {
		tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-log(`ff')
		label var `ff' "Cumulative Hazard"
		qui drop if `flag'==1
	}
  	if "`hazard'"!="" {
		tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
		label var `ff' "Hazard function"
		qui drop if `flag'==1
		
	}
  	if "`surviva'"!="" {
		tempvar ff
		qui predict double `ff', surv `alpha1' `uncondi'
		label var `ff' "Survival"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold' 
 
end
program define ExpPlot 
	syntax newvarlist(gen min=2 max=2) [, CUMHaz SURvival HAZard /*
		*/ UNCONDitional ALPHA1 /*
		*/ Begin(string) End(string) atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
        local nt "`2'"
	local t:   char _dta[st_t]
       	local wtopt:  char _dta[st_w]  
	tempname b A M
	tempvar flag
	mat `b'= get(_b)
	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
	        qui replace `1'=`M'[1,1]
	        mac shift
	        local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}

	qui replace _st=1
	qui replace _t0=0
	if "`cumhaz'"!="" {
	        tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-log(`ff')
		label var `ff' "Cumulative Hazard"
	        qui drop if `flag'==1
	}
	if "`hazard'"!="" {
	        tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
	        label var `ff' "Hazard function"
	        qui drop if `flag'==1
	}
	if "`surviva'"!="" {
	        tempvar ff
		qui predict double `ff', surv `alpha1' `uncondi'
		label var `ff' "Survival"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'
end


program define LnoPlot
	syntax newvarlist(gen min=2 max=2) [, CUMHaz SURvival HAZard /*
		*/ UNCONDitional ALPHA1 /*
		*/ Begin(string) End(string) atlist(varlist) ]
	tokenize `varlist'
        local nff "`1'"
        local nt "`2'"

        local t:   char _dta[st_t]
        local wtopt:  char _dta[st_w]

	tempname b A M
	tempvar  flag
	mat `b'= get(_b)
	local N=_N+1
	qui gen `flag'=1 if _n==_N
	qui set obs `N'
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
	        qui replace `1'=`M'[1,1]
	        mac shift
	        local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}
	qui replace _st=1
	qui replace _t0=0
	if "`cumhaz'"!="" {
	        tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-ln(`ff')
	        label var `ff' "Cumulative Hazard"
	        qui drop if `flag'==1
	}

	 if "`hazard'"!="" {
	        tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
	        label var `ff' "Hazard function"
	        qui drop if `flag'==1
	}
	if "`surviva'"!="" {
	        tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
	        label var `ff' "Survival"
	        qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'
end

program define LloPlot
	syntax newvarlist(gen min=2 max=2) [, /*
		*/ UNCONDitional ALPHA1 /*
		*/ CUMHaz SURvival HAZard Begin(string) End(string) /*
			*/ atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"

	local t:   char _dta[st_t]
	local wtopt:  char _dta[st_w]

	tempname b A M
	tempvar  flag
	mat `b'= get(_b)
	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1'=`M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}
	qui replace _st=1
	qui replace _t0=0

	if "`cumhaz'"!="" {
		tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-ln(`ff')
		label var `ff' "Cumulative Hazard"
		qui drop if `flag'==1
	}
	if "`hazard'"!="" {
		tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
		label var `ff' "Hazard function"
		qui drop if `flag'==1
	}
	if "`surviva'"!="" {
		tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		label var `ff' "Survival"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'

end


program define GomPlot
	syntax newvarlist(gen min=2 max=2) [, /*
		*/ UNCONDitional ALPHA1 /*
		*/ CUMHaz SURvival HAZard Begin(string) /*
		*/ End(string) atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"

	local t:   char _dta[st_t]
	local wtopt:  char _dta[st_w]

	tempname b A M
	tempvar  flag
	mat `b'= get(_b)
	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1'=`M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}
	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}
	qui replace _st=1
	qui replace _t0=0

	if "`cumhaz'"!="" {
	        tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-ln(`ff')
	        label var `ff' "Cumulative Hazard"
	        qui drop if `flag'==1
	}
	if "`hazard'"!="" {
       		tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
        	label var `ff' "Hazard function"
		qui drop if `flag'==1
	}
	if "`surviva'"!="" {
        	tempvar ff
		qui predict double `ff', surv `alpha1' `uncondi'
	        label var `ff' "Survival"
	        qui drop if `flag'==1
	}

	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'

end

program define GamPlot
	syntax newvarlist(gen min=2 max=2) [, /*
		*/ UNCONDitional ALPHA1 /*
		*/ CUMHaz SURvival HAZard Begin(string) End(string) /*
		*/ atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"

	local t:   char _dta[st_t]
	local wtopt:  char _dta[st_w]


	tempname b A M
	tempvar flag
	mat `b'= get(_b)
	local bb "Gamma regression"
	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1'=`M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	if "`end'"!="" {
		qui keep if `flag'==1
		qui expand 102
		qui replace `t'=`begin' in 1
		local int=(`end'-`begin')/100
		qui replace `t'=`t'[_n-1]+`int' if _n>1
		qui replace `flag'=0 if _n!=_N
	}
	qui replace _st=1
	qui replace _t0=0

	if "`cumhaz'"!="" {
	        tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		qui replace `ff'=-ln(`ff')
		label var `ff' "Cumulative Hazard"
		qui drop if `flag'==1
	}
	if "`hazard'"!="" {
		tempvar ff
		qui predict double `ff', haz `alpha1' `uncondi'
		label var `ff' "Hazard function"
		qui drop if `flag'==1
	}
	if "`surviva'"!="" {
		tempvar  ff
		qui predict double `ff', surv `alpha1' `uncondi'
		label var `ff' "Survival"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'
end

program define CoxPlot
	syntax newvarlist(gen min=2 max=2) [, /*
		*/ HAZard CUMHaz SURvival /*
		*/ Kernel(string) width(real -1) noBoundary /*
		*/ begin(real -1) end(real -1) LEFTBOUNDARY(real -1) /* 
		*/ base(varname) atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"

	local t:   char _dta[st_t]
	local wtopt:  char _dta[st_w]
	
	tempname b A M
	tempvar flag t2
	mat `b'= get(_b)
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1' =`M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', copy restore
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}
	local bb "Cox regression"
	if "`hazard'"=="" {
		if "`kernel'" != "" {
			di in red "kernel() allowed only with hazard"
			exit 198
		}
		if `width'!=-1 {
			di in red "width() allowed only with hazard"
			exit 198
		}
		local N=_N+1
		qui set obs `N'
		qui gen `flag'=1 if _n==_N
		if `begin'!=-1 {
			qui drop if `t'<`begin'
		}
		if `end'!=-1 {
			qui drop if `t'>`end'
		}
	}
	else {
		if "`base'" == "" { local base `e(basehc)' }
		qui drop if `base'==. 
		sort `t'
		qui by `t': keep if _n==1
		// hazard support: [L,R]
		// L - minimum time among uncensored obs
		// R - maximum time among uncensored obs
		summ `t', meanonly
		local R = r(max)
		if `leftboundary' == -1 {
			local L = r(min)
		}
		else {
			local L = `leftboundary'
		}
		local tmin = r(min)
		local tmax = r(max)
		if `begin'!=-1 {
			local tmin `begin'
		}
		else if `leftboundary' != -1 {
			local tmin `leftboundary'
		}
		if `end'!=-1 {
			local tmax `end'
		}
		local N = _N
		local N1 = `N' + 1
		local obs = `N'+101
		qui set obs `obs'
		qui replace `t' = `tmin' + (`tmax'-`tmin')*(_n-`N1')/100 ///
			in `N1'/l
		qui gen `flag'=1 in `N1'/l
		qui gen `t2' = `t' in `N1'/l
	}
	qui replace _st=1
	qui replace _t0=0

	if "`cumhaz'"!="" {
		if "`base'" == "" { local base `e(basech)' }
	        tempvar  ff
		qui predict double `ff', xb
                qui replace `ff'=`base'*exp(`ff')
		label var `ff' "Cumulative Hazard"
		qui drop if `flag'==1
	}
	if "`hazard'"!="" {
		tempvar ff smooth newh
		qui predict double `ff', xb
		if `width'!=-1 {
			local wopt width(`width')
		}
		qui gen double `newh' = (1-(1-`base')^exp(`ff'))
		version 8: kdensity `t' [iw=`newh'], ///
			nograph at(`t2') gen(`smooth') `kernel' `wopt'
		if `"`boundary'"' == "" {
			// correct for boundary effects
			tempvar bnd
			local wwidth = r(width)
			local lbnd = `L' + `wwidth'
			local rbnd = `R' - `wwidth'
			if `lbnd' >= `rbnd' {
di as err "left and right boundary regions overlap;"
di as err "specify a smaller bandwidth in width()"
exit 198
}
			qui gen `bnd' = ((`t2'<`lbnd')|(`t2'>`rbnd'))&(`t2'<.)
			// use boundary kernels or restrict range to [h, R-h]
			if `"`kernel'"'=="epan2" | ///
			   substr(`"`kernel'"',1,2) == "bi" | ///
			   substr(`"`kernel'"',1,3) == "rec" {
				if  substr(`"`kernel'"',1,2) == "bi" {
					local kernel biweight
				}
				if  substr(`"`kernel'"',1,3) == "rec" {
					local kernel rectangle
				}
				// do not recompute at interior points
				tempvar atbnd bndkern touse
				qui gen `touse' = (`t'<.)*(`newh'<.)
				qui gen `bndkern' = .
				qui gen `atbnd' = `t2' if `bnd' == 1
				qui count if `t2'<=`rbnd' | `t2'==.
				local indrb = r(N) + 1
				mata: _sts_bndkdensity(			     ///
					    "`t'", "`atbnd'", "`newh'",      ///
					    "`bndkern'", "`touse'", "`bnd'", ///
					    `N1', `indrb', `wwidth', `lbnd', ///
					    `rbnd', &`kernel'(), 0)
				qui replace `smooth' = `bndkern' if `bnd'==1
			}
			else {
				qui replace `flag' = 0 if `bnd' == 1
			}
		}
		qui replace `ff'=`smooth'
		qui replace `ff' = 0 if `ff' < 0
		label var `ff' "Smoothed hazard function"
		qui keep if `flag'==1
	}
	if "`surviva'"!="" {
		if "`base'" == "" { local base `e(bases)' }
		tempvar  ff
		qui predict double `ff', xb
		qui replace `ff'=`base'^exp(`ff')
		label var `ff' "Survival"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'
end

program define CrrPlot
	syntax newvarlist(gen min=2 max=2) [, CUMHaz 		///
					      CIF    		///
					      begin(real -1) 	///
					      end(real -1)	///
					      base(varname) 	///
					      atlist(varlist) ]
	tokenize `varlist'
	local nff "`1'"
	local nt "`2'"

	local t:   char _dta[st_t]
	local wtopt:  char _dta[st_w]
	
	tempname b A M
	tempvar flag t2
	mat `b' = e(b)
	local rhsorig: colnames(`b')
	local rhsorig: subinstr local rhsorig "_cons" "", all
	foreach var of local rhsorig {
		_ms_parse_parts `var'
		if !`r(omit)' {
			if "`r(type)'" != "variable" {
				if "`r(type)'" == "interaction" {
				  forvalues j = 1/`r(k_names)' {
				     if "`r(op`j')'" != "c" {
				       local fac_list `fac_list' `r(name`j')'
				     }
				     else {
				       local clist `clist' `r(name`j')'
				     }
				   }
				   local inlist : list fac_list in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				   local inlist : list clist in atlist
				   if !`inlist' {
				     local rhs_new `rhs_new' `clist'
				   }
				 }
				 else {
				   local name `r(name)'
				   local inlist : list name in atlist
				   if !`inlist' {
				     local fv_list `fv_list' `var'
				   }
				 }
			}
			else {
				local rhs_new `rhs_new' `var'
			}
		}
	}
	local rhs : list uniq rhs_new
	local fv_list: list uniq fv_list
	local b0: word count `rhs'
	tokenize "`rhs'"
	local i 1
	while `i'<=`b0' {
		qui mat acc `A' = `1' `wtopt', means(`M')
		qui replace `1' = `M'[1,1]
		mac shift
		local i=`i'+1
	}
	foreach var of local atlist {
		qui replace `var' = `var'[1]
	}
	tempname ehold
	version 11: _est hold `ehold', restore copy
	if "`fv_list'" != "" {
		_fv_term_info `fv_list' `wtopt', individuals fvrestripe
		local rhs2 `r(individuals)'
		local i = `b0'
		foreach var of local rhs2 {
			if substr("`var'",1,2)=="__" {
				local ++i
				qui mat acc `A'=`var' `wtopt',  means(`M')
				qui replace `var' = `M'[1,1]
			}
		}
		local b0 = `i'
	}

	local bb "Competing-risks regression"

	local N=_N+1
	qui set obs `N'
	qui gen `flag'=1 if _n==_N
	if `begin' != -1 {
		qui drop if `t'<`begin'
	}
	if `end' != -1 {
		qui drop if `t'>`end'
	}

	qui replace _st=1
	qui replace _t0=0

	if "`cumhaz'" != "" {
	        tempvar ff
		qui predict double `ff', xb
                qui replace `ff'=`base'*exp(`ff')
		label var `ff' "Cumulative Subhazard"
		qui drop if `flag'==1
	}
	if "`cif'"!="" {
		tempvar  ff
		qui predict double `ff', xb
		qui replace `ff'= 1-exp(-`base'*exp(`ff'))
		label var `ff' "Cumulative Incidence"
		qui drop if `flag'==1
	}
	qui replace `nff'= `ff'
	qui replace `nt'= `t'
	local ffl: variable label `ff'
	local ntl: variable label `t'
	label var `nff' "`ffl'"
	label var `nt' "`ntl'"
	version 11: _est unhold `ehold'
end
