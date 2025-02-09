*! version 7.1.17  17mar2005
program define sts_7, sort
	version 6, missing

	if _caller()<6 {
		zts_5 `0'
		exit
	}

	st_is 2 analysis
	gettoken cmd : 0, parse(" ,")
	if `"`cmd'"'=="," | "`cmd'"=="" {
		local cmd graph
	}
	else	gettoken cmd 0 : 0, parse(" ,")

	local l = length("`cmd'")
	if substr("list",1,`l')==`"`cmd'"' {
		List `0'
	}
	else if substr("graph",1,`l')=="`cmd'" {
		Graph `0'
	}
	else if substr("generate",1,`l')=="`cmd'" {
		Gen `0'
	}
	else if substr("test",1,`l')=="`cmd'" {
		Test `0'
	}
	else if "`cmd'"=="if" | "`cmd'"=="in" {
		Graph `0'
	}
	else {
		di in red "unknown sts subcommand `cmd'"
		exit 198
	}
end

program define Test, rclass
	local wt : char _dta[st_wt]
	if "`wt'"=="pweight" {
		local options "Cox"
	}
	else	local options "Breslow Cox Wilcoxon TWare Peto"
	syntax varlist [if] [in] /*
	*/ [, `options' BY(string) Detail noSHow TRend /*
	*/ Fh(numlist min=2 max=2) * ]

	if "`by'"!="" {
		di in red "by() not allowed"
		exit 198 
	}
	local by "by(`varlist')"

	local n1 = ("`fh'"!="")+ /*
	*/ ("`breslow'"!="")+("`wilcoxo'"!="")+("`tware'"!="")+("`peto'"!="")
	if `n1'+("`cox'"!="")+("`logrank'"!="")>1 {
		di in red /*
	    */ "options logrank, wilcoxon, tware, peto, fh and cox are alternatives"
		di in red "they may not be specified together"
		exit 198
	}
	if "`wilcoxo'"!="" {
		local cmd "wilc_st"
	}
	else if "`cox'"!="" | "`wt'"=="pweight" {
		if "`trend'"~="" {
			di in red "trend() not valid with option cox or pweight"
			exit 198
		}
		local cmd "ctst_st"
	}
	else if "`tware'"~="" {
		local cmd "tware_st"
	}
	else if "`peto'"~="" {
		local cmd "peto_st"
	}
	else if "`fh'"~="" {
		local cmd "fh_st"
		tokenize `fh'
		if `1'<0 | `2'<0 {
			noi di in red "p and q must be nonnegative"
			exit 198	
		}
		local p="p(`1')"
		local q="q(`2')"

	}
	else	local cmd "logrank"

	st_show `show'
	tempvar touse
	st_smpl `touse' `"`if'"' "`in'"

	if "`cmd'"=="ctst_st" {
		tempname oldest 
		capture {
			capture estimate hold `oldest'
			noisily `cmd' `varlist' if `touse', `options'
			ret add
		}
		local rc = _rc
		capture estimate unhold `oldest'
		exit `rc'
	}

	local w  : char _dta[st_w]
	if `"`_dta[st_id]'"' != "" {
		local id `"id(`_dta[st_id]')"'
	}
	`cmd' _t _d `w' if `touse', /*
		*/ t0(_t0) `id' `by' `options' `detail' `trend' `p' `q'
	ret add
	if ("`fh'"!="")+("`tware'"!="")+("`peto'"!="")>0 {
		ret local by
	}
end



/* 
	gen var=thing [var=thing] ...
*/

program define Gen

	local rest `"`0'"'
	gettoken varname rest : rest, parse(" =,")
	gettoken eqsign  rest : rest, parse(" =,")
	gettoken thing   rest : rest, parse(" =,")

	if `"`eqsign'"' != "=" { error 198 }
	while `"`eqsign'"' == "=" {
		confirm new var `varname'
		local thing = lower(`"`thing'"')

		if `"`thing'"' == "s" {
			local Surv `varname'
		}
		else if `"`thing'"' == "ns" {
			local nSurv "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="se(s)" {
			NotPw "se(s)"
			local Se "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="h" | `"`thing'"'=="dchaz" {
			local Haz "`varname'"
		}
		else if `"`thing'"'=="se(lls)" {
			NotPw "se(lls)"
			local sllS "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="ub(s)" | `"`thing'"'=="ub" {
			NotPw "ub(s)"
			local ub "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="lb(s)" | `"`thing'"'=="lb" {
			NotPw "lb(s)"
			local lb "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="n" {
			local Pop "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="na" | `"`thing'"'=="cumrisk" {
			local Aalen "`varname'"
			local notcox `"`varname'=`thing'"'
			local risk "`thing'"
		}
		else if `"`thing'"'=="se(na)" {
			NotPw "se(na)"
			local saalen "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="ub(na)" {
			NotPw "ub(na)"
			local uba "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="lb(na)" {
			NotPw "lb(na)"
			local lba "`varname'"
			local notcox `"`varname'=`thing'"'
		}
		else if `"`thing'"'=="d" { 
			local Die "`varname'"
			local notcox `"`varname'==`thing'"'
		}
		else {
			di in red `"`thing' unknown function"'
			exit 198
		}
		local 0 `"`rest'"'
		gettoken varname rest : rest, parse(" =,")
		gettoken eqsign  rest : rest, parse(" =,")
		gettoken thing   rest : rest, parse(" =,")
	}

	syntax /* ... */ [if] [in] [,  Adjustfor(varlist) BY(varlist) /*
	       */  Level(cilevel) noSHow STrata(varlist)]

	ByStAdj "`by'" "`strata'" "`adjustf'"

	* st_show `show'

	if "`adjustf'" != "" {
		if "`notcox'" != "" {
			di in red "cannot calculate `notcox' with adjustfor()"
			exit 198
		}
		qui DoAdjust "`by'" "`strata'" "`adjustf'" `"`if'"' "`in'" /* 
			*/ -> "`Haz'" "`Surv'"
		if "`Surv'"!="" {
			label var `Surv' "S(t+0), adjusted"
		}
		if "`Haz'"!="" {
			label var `Haz' "Delta_H(t), adjusted"
		}
		exit
	}

	if "`Pop'"=="" { tempvar Pop }
	if "`Die'"=="" { tempvar Die }
	tempvar touse mresult
	st_smpl `touse' `"`if'"' "`in'" "`by'" ""
	preserve 
	quietly {
		keep if `touse'
		st_ct "`by'" -> _t `Pop' `Die' 
		count if `Die'
		if r(N) {		/* keep all obs if no failures */
			keep if `Die'
		}
		AddSurv "`by'" _t `Pop' `Die' `level' -> /* 
		*/ "`Haz'" "`Surv'" "`Se'" "`sllS'" "`lb'" "`ub'" /*
		*/ "`Aalen'" "`saalen'" "`uba'" "`lba'" "`nSurv'"
		if "`Haz'" != "" {
			qui sum `Haz', meanonly
			if r(max)==0 {
				qui replace `Haz'=.
			}
		}

		keep `by' _t `Haz' `Surv' `Se' `sllS' `lb' `ub' /*
			*/ `Pop' `Die' `Aalen' `saalen' `uba' `lba' `nSurv'
		gen byte `touse' = 1
		sort `touse' `by' _t
	
		tempfile one 
		save "`one'"
		restore, preserve
		sort `touse' `by' _t 
		merge `touse' `by' _t using "`one'", _merge(`mresult')
		keep if `mresult'==1 | `mresult'==3
		drop `mresult'
		sort `touse' `by' _t 
		local byp "by `touse' `by':"
		if "`Surv'" != "" {
			`byp' replace `Surv' = cond(_n==1,1,`Surv'[_n-1]) /*
				*/ if `Surv'>=. & `touse'
			replace `Surv' = . if `touse'==0
			label var `Surv' "S(t+0)"
		}
		if "`nSurv'" != "" {
			`byp' replace `nSurv' = cond(_n==1,1,`nSurv'[_n-1]) /*
				*/ if `nSurv'>=. & `touse'
			replace `nSurv' = . if `touse'==0
			label var `nSurv' "Modified K-M
		}
		if "`Se'" != "" {
			`byp' replace `Se' = `Se'[_n-1] if `Se'>=. & `touse'
			label var `Se' "se(S) (Greenwood)"
		}
		if "`sllS'" != "" {
			`byp' replace `sllS' = `sllS'[_n-1] if /* 
				*/ `sllS'>=. & `touse'
			label var `sllS' "se(-ln ln S)"
		}
		if "`lb'" != "" {
			`byp' replace `lb' = `lb'[_n-1] if `lb'>=. & `touse'
label var `lb' `"S() `=strsubdp("`level'")'% lower bound"'
		}
		if "`ub'" != "" {
			`byp' replace `ub' = `ub'[_n-1] if `ub'>=. & `touse'
label var `ub' `"S() `=strsubdp("`level'")'% upper bound"'
		}
		if "`Haz'" != "" {
			label var `Haz' "Delta_H(t)"
		}
		if "`Aalen'"!="" {
			`byp' replace `Aalen' = cond(_n==1,0,`Aalen'[_n-1]) /*
				*/ if `Aalen'>=. & `touse'
			replace `Aalen' = . if `touse'==0
			label var `Aalen' "Nelson-Aalen cumulative hazard"
			if "`risk'" == "cumrisk" {
		       		replace `Aalen'=1-exp(-`Aalen') if `touse'
			       label var `Aalen' "Nelson-Aalen cumulative risk"
			}
		}
		if "`saalen'" != "" {
			`byp' replace `saalen' = sqrt(`saalen') 
			`byp' replace `saalen' = `saalen'[_n-1] /*
			*/ if `saalen'>=. & `touse'
			label var `saalen' "se(Nelson-Aalen)"
		}
		if "`lba'" != "" {
			`byp' replace `lba' = `lba'[_n-1] if `lba'>=. & `touse'
label var `lba' `"Nelson-Aalen `=strsubdp("`level'")'% lower bound"'
		}
		if "`uba'" != "" {
			`byp' replace `uba' = `uba'[_n-1] if `uba'>=. & `touse'
label var `uba' `"Nelson-Aalen `=strsubdp("`level'")'% upper bound"'
		}
		label var `Pop' "N, entering population"
		label var `Die' "d, number of failures"
	}
	restore, not
end

program define NotPw /* text */
	if `"`_dta[st_wt]'"' == "pweight" {
		di in red "`*' not possible with pweighted data"
		exit 404
	}
end
		

program define AddSurv /* by t Pop Die lvl -> Haz Surv Se sllS lb ub */
	args by t N D lvl ARROW h S Se sllS lb ub Aalen saalen uba lba NS
	if "`h'"=="" {
		tempvar h 
	}
	tempvar nh
	gen double `h' = cond(`N'==0,0,`D'/`N')
	gen double `nh' = cond(`N'==0,0,`D'/(`N'+1))
	sort `by' _t
	if "`by'" != "" {
		local byp "by `by':"
	}
	if "`lba'"!="" | "`uba'"!="" { 
		if "`Aalen'"=="" { tempvar Aalen }
		if "`saalen'"=="" { tempvar saalen }
	}
	if "`Aalen'"!="" {
		`byp' gen double `Aalen' = `h'
		`byp' replace `Aalen' = `Aalen'[_n-1]+`h' if _n>1
	}
	if "`saalen'"!="" {
		tempvar sh
		gen double `sh' =  cond(`N'==0,0,`D'/(`N'^2))
		`byp' gen double `saalen' = `sh'
		`byp' replace `saalen' = `saalen'[_n-1]+`sh' if _n>1
	}
	if "`lba'"!="" | "`uba'"!="" {
		
		local z = invnorm(1-(1-`lvl'/100)/2)
		tempvar phi
		gen double `phi'=(sqrt(`saalen')/`Aalen') if `Aalen'!=0
		if "`lba'" != "" {
			gen double `lba'=(`Aalen')*exp(-`z'*`phi')
			replace `lba'=0 if `lba'<0
		}
		if "`uba'"!="" {
			gen double `uba'=(`Aalen')*exp(`z'*`phi')
		}
	}
	if "`Se'"!="" | "`lb'"!="" | "`ub'"!="" { 
		if "`S'"=="" { tempvar S }
		if "`lb'"!="" | "`ub'"!="" {
			if "`sllS'"=="" { tempvar sllS }
		}
	}
	if "`S'" != "" {
		`byp' gen double `S' = 1-`h'
		`byp' replace `S' = `S'[_n-1]*(1-`h') if _n>1
	}
	if "`NS'" != "" {
		`byp' gen double `NS' = 1-`nh'
		`byp' replace `NS' = `NS'[_n-1]*(1-`nh') if _n>1
	}
	if "`Se'" != "" {
		`byp' gen double `Se' = /*
		*/ `S'*sqrt(sum(`D'/(`N'*(`N'-`D')))) if `S'!=0
		replace `Se' = . if `S'==1
	}
	if "`sllS'" != "" {
		`byp' gen double `sllS' = sqrt( /*
		*/ sum(`D'/(`N'*(`N'-`D'))) / (sum(ln((`N'-`D')/`N'))^2) )
	}
	if "`lb'"!="" | "`ub'"!="" {
		local z = invnorm(1-(1-`lvl'/100)/2)
		if "`lb'" != "" {
			gen double `lb'=(`S')^(exp(`z'*`sllS')) if `S'!=0
		}
		if "`ub'"!="" {
			gen double `ub'=(`S')^(exp(-`z'*`sllS')) if `S'!=0
		}
	}
end


program define List
	syntax [if] [in] [, ADjustfor(varlist) AT(numlist sort) NA/*
		*/ BY(varlist) Compare Enter Failure /*
		*/ Level(cilevel) noSHow STrata(varlist) ]

	local w  : char _dta[st_w]
	local wt : char _dta[st_wt]

	if "`na'"!="" & "`adjustf'"!="" {
		di in red "cannot specify adjustfor() with na option"
		exit 198
	}
	if "`na'"!="" & "`failure'"!="" {
		di in red "failure invalid with na option"
		exit 198
	}

	ByStAdj "`by'" "`strata'" "`adjustf'"
	local sb "`s(sb)'"
	if "`compare'" != "" {
		if "`at'" == "" { 
			local at "10"
		}
		if "`sb'"=="" {
			if "`na'"!="" {
				di in red "compare requires by()"
				exit 198
			}
			di in red "compare requires by() or strata()"
			exit 198
		}
	}


	if "`at'" != "" { 
		Procat `at'
		local at `"`s(at)'"'
	}

	st_show `show'


	tempvar touse  mark n d cens ent  s se lb ub aal saalen uba lba
	st_smpl `touse' `"`if'"' "`in'" "`sb'" "`adjustf'"
	preserve
	quietly {
		keep if `touse'
		if "`adjustf'"=="" {
			st_ct "`by'" -> _t `n' _d `cens' `ent'
			if "`enter'"=="" {
				replace `cens' = `cens' - `ent'
				drop if _d==0 & `cens'==0
				replace `ent' = 0 
			}
			AddSurv "`by'" _t `n' _d `level' -> /* 
		       */ "" `s' `se' "" `lb' `ub' `aal' `saalen' `uba' `lba'
		}
		else { 
			DoAdjust "`by'" "`strata'" "`adjustf'" "" "" -> "" `s'
			KeepDead "`sb'"
		}
		if "`failure'" != "" {
			replace `s'=1-`s'
			if "`adjustf'"=="" {
				replace `lb'=1-`lb'
				replace `ub'=1-`ub'
				local hold "`lb'"
				local lb "`ub'"
				local ub "`hold'"
			}
		}
		if "`na'" != "" {
			replace `s'=`aal'
			replace `lb'=`lba'
			replace `ub'=`uba'
			replace `se'=sqrt(`saalen')
			drop `aal' `lba' `uba' `saalen'
		}
	}

	if "`sb'"!="" {
		quietly {
			tempvar grp
			by `sb': gen `grp'=1 if _n==1
			replace `grp' = sum(`grp')
		}
	}


	if "`compare'"!="" { 
		Reat _t `at'
		if "`s(at)'"!="" {
			local at "`s(at)'"
		}
		if "`adjustf'"=="" {
			drop `n' _d `cens' `ent' `se' `lb' `ub'
		}
		if "`na'"!="" {
			local failure "aalen"
		}
		Licomp "" "`sb'" "`grp'" _t `s' "`at'" "`failure'" "`adjustf'"
		exit
	}
	if "`na'"!="" {
		local ttl "Nelson-Aalen"
		local blnk " "
	}	
	else if "`failure'"!="" { 
		local ttl "Failure"
		local blnk " "
		local attl " Adjusted Failure Function"
	}
	else {
		local ttl "Survivor"
		local attl "Adjusted Survivor Function"
	}

	if "`at'"!="" {
		Reat _t `at'
		if "`s(at)'"!="" {
			local at "`s(at)'"
		}
		if "`adjustf'"=="" {
			Listat "`sb'" "`grp'" _t `n' _d `cens' `ent' /*
*/ `s' `se' `lb' `ub' "`at'" `"`=strsubdp("`level'")'"' /*
			*/ "`ttl'" 
		}
		else	Listata "`sb'" "`grp'" _t `s' "`at'" /*
			*/ "`ttl'" "`blnk'" "`adjustf'"
		exit
	}


	if "`adjustf'"=="" {
		if "`enter'"!="" {
			local ettl "Enter"
			local liste 1
		}
		else {
			qui drop if _t==0
			local ettl "     "
			local liste 0
			local net "Net"
		}
		local cil `=string(`level')'
		local cil `=length("`cil'")'
		if `cil' == 2 {
			local spaces "     "
		}
		else if `cil' == 4 {
			local spaces "   "
		}
		else {
			local spaces "  "
		}
		if "`wt'"!="pweight" {
			if "`na'"=="" {
				di in gr _n _col(12) "Beg." _col(26) "`net'" /*
				*/ _col(41) "`ttl'" _col(55) "Std." _n /*
				*/ "  Time    Total   Fail   Lost  `ettl'" /*
				*/ _col(41) /*
*/ `"Function     Error`spaces'[`=strsubdp("`level'")'% Conf. Int.]"'
				local dupcnt 79
			}
			else {
				di in gr _n _col(12) "Beg." _col(26) "`net'" /*
				*/ _col(39) "`ttl'" _col(55) "Std." _n /*
				*/ "  Time    Total   Fail   Lost  `ettl'" /*
				*/ _col(41) /*
*/ `"Cum. Haz.    Error`spaces'[`=strsubdp("`level'")'% Conf. Int.]"'
				local dupcnt 79
			}
		}
		else  {
			di in gr _n _col(12) "Beg." _col(26) "`net'" /*
			*/ _col(39) "`ttl'" _n /*
			*/ "  Time    Total   Fail   Lost  `ettl'" /*
			*/ _col(41) "Function"
			local dupcnt 48
		}
	}
	else { 
		di in gr _n "               Adjusted" /*
		*/ _n "  Time    `blnk'`ttl' Function"
		local dupcnt 27
	}
	di in smcl in gr "{hline `dupcnt'}"

	local i 1
	while `i' <= _N {
		if "`sb'" != "" {
			if `grp'[`i'] != `grp'[`i'-1] {
				sts_sh `grp' "`grp'[`i']" "`sb'"
				di in gr "$S_3"
			}
		}
		if "`adjustf'"=="" {
			di in gr %6.0g _t[`i'] " " in ye /*
			*/ %8.0g `n'[`i'] " " /*
			*/ %6.0g (_d[`i']) " " /*
			*/ %6.0g `cens'[`i'] " "  _c 
			if `liste' {
				di in ye %6.0g `ent'[`i'] _c
			}
			else	di _skip(6) _c
			di in ye " " /*
			*/ %11.4f `s'[`i'] " " _c
			if "`wt'"!="pweight" {
				di in ye /*
				*/ %9.4f  `se'[`i'] /* standard error */ " " /*
				*/ %10.4f `lb'[`i'] /* lower cb */ " " /*
				*/ %9.4f `ub'[`i'] /* upper cb */
			}
			else	di
		}
		else {
			di in gr %6.0g _t[`i'] "     " in ye /* 
			*/ %11.4f `s'[`i']
		}
		local i = `i'+1
	}
	di in smcl in gr "{hline `dupcnt'}"
	if "`adjustf'" != "" {
		di in gr "`ttl' function adjusted for `adjustf'"
	}
end


program define GetVal /* grpvar g# var maxlen */
	args grp g v maxlen


	tempvar obs newv
	quietly {
		gen long `obs' = _n if `grp'==`g'

		summ `obs'
		local j = r(min)

		local typ : type `v'
		local val = `v'[`j']

		global S_2
		if substr("`typ'",1,3)!="str" {
			local lbl : value label `v'
			if "`lbl'" != "" {
				local val : label `lbl' `val'
			}
			else {
				global S_2 "`v'="
				local val=string(`val')
			}
		}
		global S_1 = substr(trim("`val'"),1,`maxlen')
	}
end


program define sts_sh /* grp g# <byvars> */
	args grp g by

	tokenize "`by'"
	global S_3
	while "`1'" != "" {
		GetVal `grp' `g' `1' 20
		global S_3 "$S_3$S_2$S_1 "
		* di in gr "$S_2$S_1 " _c
		mac shift
	}
	* di
end

program define Reat /* t <processed at-list> */, sclass
	sret clear
	if "`2'"!="reat" {
		exit
	}
	quietly { 
		local t "`1'"
		local n = `3'
		local n = cond(`n'-2<1, 1, `n'-2)
		qui summ _t if _t!=0
		local tmin = r(min)
		local tmax = r(max)
		local dt = (`tmax' -`tmin')/`n'
		if `dt'>=1 {
			local dt = int(`dt')
		}
		local v = int(`tmin')
		/* s(at) contains nothing right now */
		while `v' < `tmax' {
			sret local at "`s(at)' `v'"
			local v = `v' + `dt'
		}
		sret local at "`s(at)' `v'"
	}
end
	

program define Procat /* at-list */, sclass
	sret clear
	local i : word count `0'
	if `i'==1 {
		capture confirm integer numb `0'
		if _rc == 0 { 
			capture assert `0' >= 1
		}
		if _rc {
			di in red `"at(`0') invalid"'
			exit 198
		}
		sret local at "reat `0'"
	}
	else	sret local at `"`0'"'
end


program define Listata
	args by grp t s at ttl blnk adjustf

	if "`by'"!="" {
		local byp "by `by':"
	}
	di in gr _n "                  Adjusted"
	di in smcl in gr /*
	*/ "    Time    `blnk'`ttl' Function" _n "{hline 29}"

	if "`grp'"=="" {
		tempvar grp
		qui gen byte `grp' = 1
		local ngrp 1
	}
	else {
		qui summ `grp'
		local ngrp = r(max)
	}

	tokenize "`at'"

	tempvar obs
	local g 1
	while `g' <= `ngrp' {
		/* set i0, i1: bounds of group */
		qui gen long `obs' = _n if `grp'==`g'
		qui summ `obs'
		local i0 = r(min)
		local i1 = r(max)
		drop `obs'

		if "`by'" != "" {
			sts_sh `grp' `g' "`by'"
			di in gr "$S_3"
		}

		local j 1
		while "``j''" != "" {
			qui gen long `obs' = _n if _t>``j'' in `i0'/`i1'
			qui summ `obs'
			local i = cond(r(min)>=.,`i1',r(min)-1)
			drop `obs'
			if `i'<`i0' {
				di in gr %8.0g ``j'' "     " in ye /* 
				*/ %11.4f 1
			}
			else if `i'==`i1' & ``j''>_t[`i1'] {
				di in gr %8.0g ``j'' "     " in ye /*
				*/ %11.4f .
			}
			else {
				di in gr %8.0g ``j'' "     " in ye /*
				*/ %11.4f `s'[`i']
			}
			local j=`j'+1
		}
		local g=`g'+1
	}
	di in smcl in gr "{hline 29}" _n /*
	*/  "`ttl' function adjusted for `adjustf'"
end



program define Listat
	args by grp t n d cens ent s se lb ub at level ttl
	/* ttl is "Survival" "Failure" "Nelson-Aalen" */

	if "`by'"!="" {
		local byp "by `by':"
	}
	quietly {
		`byp' replace _d=sum(_d)
		`byp' replace `cens'=sum(`cens')
		`byp' replace `ent' = sum(`ent')
	}
	if "`ttl'"=="Nelson-Aalen" {
		local pos 39
		local func "Cum. Haz."
	}
	else {  
		local pos 41
		local func "Function "
	}
	local cil `=string(`level')'
	local cil `=length("`cil'")'
	if `cil' == 2 {
		local spaces "     "
	}
	else if `cil' == 4 {
		local spaces "   "
	}
	else {
		local spaces "  "
	}
	di in smcl in gr _n _col(15) "Beg." /*
	*/ _col(`pos') "`ttl'" _col(55) "Std." _n /*
	*/ "    Time     Total     Fail" /*
*/ _col(41) `"`func'    Error`spaces'[`=strsubdp("`level'")'% Conf. Int.]"' _n /* 
	*/ "{hline 79}"

	if "`grp'"=="" {
		tempvar grp
		qui gen byte `grp' = 1
		local ngrp 1
	}
	else {
		qui summ `grp'
		local ngrp = r(max)
	}

	tokenize "`at'"

	tempvar obs
	local g 1
	while `g' <= `ngrp' {
		/* set i0, i1: bounds of group */
		qui gen long `obs' = _n if `grp'==`g'
		qui summ `obs'
		local i0 = r(min)
		local i1 = r(max)
		drop `obs'

		if "`by'" != "" {
			sts_sh `grp' `g' "`by'"
			di in gr "$S_3"
		}

		local lfail 0
		local j 1
		while "``j''" != "" {
			qui gen long `obs' = _n if _t>``j'' in `i0'/`i1'
			qui summ `obs'
			local i = cond(r(min)>=.,`i1',r(min)-1)
			drop `obs'
			if `i'<`i0' {
				di in gr %8.0g ``j'' "  " in ye /*
				*/          /*
				*/ %8.0g 0 " " /*
				*/ %8.0g 0 " " /*
				*/ _skip(8) /* 
				*/ %11.4f 1 " " /*
				*/ %9.4f  . " " /*
				*/ %10.4f . " " /*
				*/ %9.4f .
			}
			else if `i'==`i1' & ``j''>_t[`i1'] {
				local ifail = _d[`i'] - `lfail'
				local lfail = _d[`i'] 
				di in gr %8.0g ``j'' "  " in ye /*
				*/          /*
				*/ %8.0g `n'[`i'] " " /*
				*/ %8.0g `ifail' " " /*
				*/ _skip(8) /*
				*/ %11.4f . " " /*
				*/ %9.4f  . " " /*
				*/ %10.4f . " " /*
				*/ %9.4f .
			}
			else {
				local ifail = _d[`i'] - `lfail'
				local lfail = _d[`i']
				di in gr %8.0g ``j'' "  " in ye /*
				*/          /*
				*/ %8.0g `n'[`i'] " " /*
				*/ %8.0g `ifail' " " /*
				*/ _skip(8) /* 
				*/ %11.4f `s'[`i'] " " /*
				*/ %9.4f  `se'[`i'] " " /*
				*/ %10.4f `lb'[`i'] " " /*
				*/ %9.4f `ub'[`i']
			}
			local j=`j'+1
		}
		local g=`g'+1
	}
	di in smcl in gr "{hline 79}"
	#delimit ;
	di in gr 
"Note:  `ttl' function is calculated over full data and evaluated at" _n
"       indicated times; it is not calculated from aggregates shown at left.";
	#delimit cr
end


program define Licomp 
	args mark by grp t s at failure adjustf
	/* failure contains "failure", "aalen" or "" */

	qui summ `grp'
	local ngrp = r(max)

	local ng 1
	while `ng' <= `ngrp' {
		local nglast=min(`ng'+5,`ngrp')
		Licompu "`mark'" "`by'" "`grp'" _t `s' "`at'" `ng' `nglast' /*
			*/ "`failure'" "`adjustf'"
		local ng=`ng'+6
	}
	if "`adjustf'"!="" {
		if "`failure'"=="" {
			local ttl "Survivor"
		}
		else	local ttl "Failure"
		di in gr "`ttl' function adjusted for `adjustf'"
	}
end

program define Licompu
	args IGNORE by grp t s at g0 g1 failure adjustf
	/* failure contains "failure", "aalen" or "" */
	di
	if "`failure'"=="" {
		local ttl "Survivor"
	}
	else if "`failure'"=="aalen" {
		local ttl "Nelson-Aalen"
	}
	else	local ttl "Failure"
	if "`adjustf'" != "" { 
		local ttl `"Adjusted `ttl'"'
	}
	if "`failure'"=="aalen" {
		local ttl `"`ttl' Cum. Haz."'
	}
	else local ttl `"`ttl' Function"'
	local tl = length(`"`ttl'"')

	local wid = (`g1'-`g0'+1)*11-5
	local ldash = int((`wid' - `tl')/2)
	local rdash = `wid' - `tl' - `ldash' 

	if `ldash'>0 & `rdash'>0 {
		di in smcl in gr /*
		*/ _col(18) "{hline `ldash'}`ttl'{hline `rdash'}"
	}
	else {
		local skip = max(17 + `wid' - `tl', 0)
		di in gr _skip(`skip') "`ttl'"
	}
	tokenize `"`by'"'
	while "`1'" != "" {
		di in gr "`1'" _col(13) _c
		local g `g0'
		while `g' <= `g1' {
			GetVal `grp' `g' `1' 9
			local skip = 11 - length("$S_1")
			di in gr _skip(`skip') "$S_1" _c
			* di in gr "12" %9.0g 1 _c
			local g = `g'+1
		}
		di
		mac shift
	}


	local ndash = 12+(`g1'-`g0'+1)*11
	di in smcl in gr "{hline `ndash'}"

	tempvar obs
	tokenize `"`at'"'
	local j 1 
	local thead "time"
	while "``j''" != "" {
		di in gr "`thead'" %8.0g ``j'' _c
		local thead "    "
		local g `g0'
		while `g'<=`g1' {
			qui gen long `obs' = _n if `grp'==`g'
			qui summ `obs'
			local i0 = r(min)
			local i1 = r(max)
			drop `obs'
			qui gen long `obs' = _n if _t>``j'' in `i0'/`i1'
			qui summ `obs'
			local i = cond(r(min)>=.,`i1',r(min)-1)
			drop `obs'
			if `i'<`i0' {
				local res 1
			}
			else if `i'==`i1' & _t[`i']!=``j'' {
				local res .
			}
			else 	local res = `s'[`i']
			di in ye %11.4f `res' _c
			local g=`g'+1
		}
		di
		local j=`j'+1
	}
	di in smcl in gr "{hline `ndash'}"
end

program define Graph
	syntax [if] [in] [, ADjustfor(varlist) NA noBorder /*
		*/ BY(varlist) CENsored(string) CNA Enter Failure /*
		*/  Gwood noLAbel  L1title(string) /*
		*/ Level(cilevel) LOST noORIgin SEParate /*
		*/ noSHow STrata(varlist) LStyle(string) /*
		*/ T1title(string) T2title(string) /*
		*/ TMIn(real -1) TMAx(real -1) TRim(integer 32) /*
		*/ XASis XLAbel(string) YASis YLAbel(string) YLOg ATRisk * ]

	local w  : char _dta[st_w]
	if "`enter'"!="" & "`lost'"=="" {
		local lost="lost"
	}	
	if "`cna'"!="" {
		local na="na"
	}
	if "`na'"!="" & "`adjustf'"!="" {
		di in red "cannot specify adjustfor() with na or cna options"
		exit 198
	}
	if "`na'"!="" & "`failure'"!="" {
		di in red "failure invalid with na or cna options"
		exit 198
	}
	if "`na'"!="" & "`gwood'"!="" {
		di in red "gwood invalid with na or cna options"
		exit 198
	}

	if "`gwood'"!="" {
		if "`_dta[st_wt]'"=="pweight" { 
			di in red "option gwood not allowed with pweighted data"
			exit 198
		}
	}
	if "`cna'"!="" {
		if "`_dta[st_wt]'"=="pweight" { 
			di in red "option cna not allowed with pweighted data"
			exit 198
		}
	}
	if "`na'"!="" {
		local origin "noorigin"
	}
	local nls 0
	if "`lstyle'"!="" {
  		tokenize `lstyle', parse(" [")
		local i 1
		local j 0
		while `"``i''"'!="" {
			local k = `i' + 1
			if `"``i''"'!="[" | /* 
				*/ substr(`"``k''"',length(`"``k''"'),1)!="]" {
				di in red "invalid lstyle"
				exit 198
			}
			local j = `j'+1
			local ls`j' `"``i''``k''"'	
			local i = `i'+2
		}
		local nls `j'
	}
	ByStAdj "`by'" "`strata'" "`adjustf'"
	local sb "`s(sb)'"

	if "`sb'" == "" { local label "nolabel" }
	else {
		local n : word count `sb'
		if `n'>1 { local label "nolabel" }
		if `n'>1 & ("`separat'"!="" | "`gwood'"!="" | "`cna'"!="" ) {
			di in red "may not specify " _c
			if "`separat'"!="" {
				di in red "separate" _c
			}
			else if "`gwood'"!="" {
					di in red "gwood" _c
			}
			else  di in red "cna" _c
			di in red " with more than one by/strata variable;"
			di in red /* 
*/ "use " _quote "egen ... = group(`strata')" _quote /*
*/ " to make a single variable"
			exit 198
		}
	}

	if  "`censored'"!="" & ("`lost'"!="" | "`enter'"!="" | "`atrisk'"!="") {
		di in red /*
		*/ "censored not possible with lost, enter, or atrisk" 
		exit 198
	}
	if "`censored'"~="" {
		local l = length("`censored'")
		if substr("numbered",1,max(1,`l')) == "`censored'" {
			local censt= "numbered"
		}
		else if substr("single",1,max(1,`l')) == "`censored'" {
			local censt= "single"
		}
		else if substr("multiple",1,max(1,`l')) == "`censored'" {
			local censt= "multiple"
		}
		else {
			di in red "invalid option censored(`censored')"
			exit 198
		}
	}

	if  "`enter'"!="" & "`atrisk'"!="" {
		di in red /*
		*/ "atrisk and enter not possible at the same time"
		exit 198
	}
	if "`adjustf'"!="" {
		if "`gwood'"!="" {
			di in red "gwood not possible with adjustfor()"
			exit 198
		}
		if "`lost'"!="" | "`enter'"!="" | "`atrisk'"!="" /*
		*/ | "`censored'"!="" {
			di in red /*
		*/ "atrisk, censored, lost, or enter not possible with adjustfor()"
			exit 198
		}
	}

	st_show `show'

	tempvar touse  mark n d cens ent  s lb ub aal uba lba
	st_smpl `touse' `"`if'"' "`in'" "`sb'" "`adjustf'"
	preserve
	quietly {
		keep if `touse'
		if "`adjustf'"=="" {
			*	st_ct "`by'" -> _t `n' _d `cens' `ent'
			if "`censored'"~="" {
				tempvar mycens
				st_ct "`by'" -> _t `n' _d "" `ent' `mycens'
				local enter="enter"
				local notreal="notreal"
				gen double `cens'=`mycens'
				drop `mycens'
			}
			else {
				st_ct "`by'" -> _t `n' _d `cens' `ent'
			}
			if "`enter'"=="" & "`atrisk'"=="" {
				replace `cens' = `cens' - `ent' if _t
				drop if _d==0 & `cens'==0
				replace `ent' = 0 
			}
			if "`atrisk'"!="" {
				replace `ent' = `n'[_n+1] if _d
				if "`lost'"=="" { replace `cens'=0 }
			}
			AddSurv "`by'" _t `n' _d `level' -> /* 
			*/ "" `s' "" "" `lb' `ub' `aal' ""  `uba' `lba'

		}
		else { 
			DoAdjust "`by'" "`strata'" "`adjustf'" "" "" -> "" `s'
			KeepDead "`sb'"
		}
		if "`failure'" != "" {
			replace `s'=1-`s'
			if "`adjustf'" == "" {
				replace `lb'=1-`lb'
				replace `ub'=1-`ub'
				local hold "`lb'"
				local lb "`ub'"
				local ub "`hold'"
			}
		}
		if "`na'" != "" {
			replace `s'=`aal'
			replace `lb'=`lba'
			replace `ub'=`uba'
			drop `aal' `lba' `uba' 
		}
	}

	if `tmin' != -1 {
		qui drop if _t<`tmin'
	}
	if `tmax' != -1 { 
		qui drop if _t>`tmax'
	}
	qui count 
	if r(N)<1 { 
		di in red "no observations"
		exit 2000
	}

	quietly {
		if "`lost'"=="" & "`atrisk'"=="" {
			if "`adjustf'"=="" {
/*
				drop if _d==0
*/
				drop _d 
			}
		}
		else {
			summ `s'
			local eps = max( (r(max)-r(min))/50, .0)
			local nps = max( (r(max)-r(min))/25,  0)
			tempvar dj tnext s2 s3 newt
			sort `sb' _t _d
			if "`sb'"!="" {
				local byst "by `sb':"
			}

			`byst' replace _d=1 if _d==0 & (_n==1 | _n==_N)
			`byst' gen long `dj' = _n if _d 
/* above is new */
			`byst' replace `dj'=`dj'[_n-1] if `dj'>=.
			sort `sb' `dj' _d
			by `sb' `dj': replace `cens'=sum(`cens')
			by `sb' `dj': replace `ent' =sum(`ent')
			by `sb' `dj': keep if _n==_N
			drop `dj'
			sort `sb' _t
			`byst' gen `tnext'=_t[_n+1]
			`byst' replace `tnext'=_t if _n==_N
			expand 3 
			sort `sb' _t
			by `sb' _t: gen `newt' = cond(_n==1, _t, /*
					*/ (_t+`tnext')/2)
			drop `tnext'
			by `sb' _t: gen `s2' = `s'+`eps' if _n==2
			by `sb' _t: gen `s3' = `s'-`nps' if _n==3
			by `sb' _t: replace `s'=. if _n>1
			by `sb' _t: replace `cens' = 0 /*
				*/ if _n==1 | _n==3
			by `sb' _t: replace `ent' = 0 /*
				*/ if _n==1 | _n==2
			by `sb' _t: keep if _n==1 | /*
				*/ (_n==2 & `cens') | (_n==3 & `ent')
			label var `s2' " " 
			label var `s3' " "
			local mvars "`s2' `s3'"
			local msym "[`cens'][`ent']"
			local mcon ".."
			local mpen "11"
			local lbl : var label _t
			local vlbl : value label _t
			drop _t 
			rename `newt' _t
			label var _t `"`lbl'"'
			label val _t `vlbl'
			local lbl
			sort `sb' _t
		}
	}

	if "`sb'"=="" | "`gwood'"!="" | "`cna'"!="" {
		local separat "separate"
	}

	if "`separat'"=="separate" {
		local svars "`s'"
		local ssym "i"
		local scon "J`ls1'"
		local spen "2"
		if "`sb'"!="" {
			local byopt "by(`sb')"
		}
		if "`gwood'" != "" | "`cna'"!="" {
			local svars "`svars' `lb' `ub'"
			local ssym "`ssym'ii"
			local scon "`scon'JJ"
			local spen "`spen'11"
		}
	}
	else {
		quietly { 
			tempvar grp
			by `sb': gen int `grp' = 1 if _n==1
			replace `grp' = sum(`grp')
			local ng = `grp'[_N]
			local i 1
			local j 1
			local pen 1
			while `i' <= `ng' {
				if `j'>`nls' {
					local j 1
				}
				tempvar x		
				gen float `x'=`s' if `grp'==`i'
				local svars "`svars' `x'"
				local ssym "`ssym'i"
				local scon "`scon'J`ls`j''"
				local pen=cond(`pen'<=8,`pen'+1,2)
				local spen "`spen'`pen'"
				local i = `i' + 1
				local j = `j' + 1
			}
		}
		if "`label'"=="" {
			tempvar smark sttl
			qui MarkPt _t "`sb'" `s' -> `sttl' `smark'
			local pen 1
			local i 1
			while `i' <= `ng' { 
				tempvar x 
				qui gen float `x'=`smark' if `grp'==`i'
				local pen=cond(`pen'<=8,`pen'+1,2)
				local svars "`svars' `x'"
				local ssym "`ssym'[`sttl']"
				local scon "`scon'."
				local spen "`spen'`pen'"
				local i = `i' + 1
			}
			drop `smark'
		}
	}


	if "`ylabel'"=="" {
		if "`yasis'"=="" {
			if "`na'"=="" {
				if "`ylog'"!="" {
					local ylabel /*
					*/ "ylabel(.01,.05,.10,.25,.50,.75,1)"
				}
				else {
					local ylabel "ylabel(0,.25,.50,.75,1)"
				}
			}
			else  local ylabel "ylabel"
			local fvar : word 1 of `svars'
			format `fvar' %9.2f
		}
		else {
			qui summ `s'
			if "`ylog'"!="" {
				local min = cond(r(min)==0,.001,r(min))
			}
			else {
				local min=r(min)
			}
			local max=cond("`origin'"=="",1,r(max))
			local ylabel "ylabel(`min',`max')"
		}
	}
	else 	local ylabel "ylabel(`ylabel')"

	if "`xlabel'"=="" {
		if "`xasis'"=="" {
			local xlabel "xlabel"
		}
	}
	else	local xlabel "xlabel(`xlabel')"

	if "`border'"=="" { local border "border" }
	else local border

	if `"`t1title'"'=="" {
		if "`na'"!="" {
			local t1title "Nelson-Aalen cumulative hazard estimate"
		}
		else if "`fail'"=="" {
			if "`adjustf'"!="" {
				local t1title "Survivor function"
			}
			else	local t1title "Kaplan-Meier survival estimate"
		}
		else {
			if "`adjustf'"!="" {
				local t1title "Failure function"
			}
			else 	local t1title "Kaplan-Meier failure estimate"
		}
		if "`sb'"!="" {
			local t1title `"`t1title's, by `sb'"'
		}
		local t1title `"t1(`"`t1title'"')"'
	}
	else {
		if `"`t1title'"'=="." { 
			local t1title
		}
		else local t1title `"t1(`"`t1title'"')"'
	}

	if `"`t2title'"'=="" {
		if "`adjustf'"!="" {
			if length("`adjustf'")>50 {
				local adjustf = substr("`adjustf'",1,47)
				local adjustf "`adjustf'..."
			}
			local t2title "t2(adjusted for `adjustf')"
		}
		else if "`gwood'"!="" | "`cna'"!="" {
			local t2title /*
*/ `"t2(`=strsubdp("`level'")'%, pointwise confidence band shown)"'
		}
	}
	else {
		if `"`t2title'"'=="." { 
			local t2title
		}
		else local t2title `"t2(`"`t2title'"')"'
	}

	if "`ylog'" != "" {
       		local varcnt: word count  `svars'
		local i 1
		while `i' <= `varcnt' {
			local varn: word `i' of `svars' 
			qui replace `varn'=.001 if `varn'==0 
			local i=`i'+1
		}
	}
	if `"`l1title'"'=="" {
		local l1title " "
	}
	local l1title `"l1(`"`l1title'"')"'
	
	/*** new by mac *****/
	if "`origin'"=="" {
		tempvar last flg
		local N = _N
		if "`by'"=="" & "`strata'"=="" {
			qui gen `last'=2 if _n==_N
			qui expand `last'
			qui gen `flg'=1 if _n>`N'
			qui replace _t=0 if `flg'==1
			if "`failure'" == "" {
				qui replace `s'=1 if `flg'==1
			}
			else qui replace `s'=0 if `flg'==1
		}
		else {
			sort `by' `strata'
			qui by `by' `strata':  gen `last'=2 if _n==_N
			qui expand `last'
			qui gen `flg'=1 if _n>`N'
			qui replace _t=0 if `flg'==1
			local varcnt: word count  `svars'
			local i 1
			while `i' <= `varcnt' {
				local varn: word `i' of `svars' 
				if "`failure'" == "" {
					qui replace `varn'=1 if _t==0 
				}
				else qui replace `varn'=0 if _t==0
				if substr("`ssym'",-1,1)!="i" &  /* 
					*/ `i'> (`varcnt'/2 ) {
					qui replace `varn'=. if _t==0
				}
				local i=`i'+1
			}
		}
		if "`gwood'"!="" {
			qui replace  `lb'=. if `flg'==1
			qui replace  `ub'=. if `flg'==1
		}
		if "`byopt'"!="" {
			 sort `sb'
		 }
		if "`notreal'"=="" {
			if "`lost'" !="" | "`enter'" !=""  {
				tempvar tempce
				qui gen str8 `tempce' = string(`cens')
				qui replace `tempce'="" if `flg'==1	
				qui drop `cens'
				qui rename `tempce' `cens'
				qui replace `cens'=trim(`cens')
			}
		}
	}
	if "`na'"~="" | "`origin'"~="" { 
		tempvar flg
		qui gen int `flg'=.
	}
	if `"`censt'"'== "numbered" | `"`censt'"'=="single" {
		tempvar tmvars tsym expw tu nextt mins
		qui gen double `mins'=1-`s' 
		sort `mins' _t
		qui gen double `nextt'=_t[_n+1]
		qui by `mins': replace `nextt'=`nextt'[_N]
		qui sum _t, meanonly
		local adjd=(r(max)-r(min))/450
		qui gen int `expw'=2  if `cens'>0 & `cens'<. & `flg'>=.
		local N=_N
		qui expand `expw'
		qui replace `expw'=cond(_n>`N',2,.)
		sort   _t `s' `expw'
		qui by _t: replace _t=_t+`adjd' if `expw'==2 & _n==1 & /*
		*/ _t+`adjd'<`nextt'
		qui gen double `tmvars'=`s' if `expw'==2
		format `tmvars' %9.2f
		if "`na'"=="" & "`cna'"=="" {
			qui gen `tu'=`tmvars'+.02 if `expw'==2
		}
		else {
			noi sum `s', meanonly
			qui gen `tu'=`tmvars'+ (r(max)-r(min))/45 if `expw'==2
		}
		local tmvars="`tmvars' `tu'"
		local tcon ="||"
		local msym ="ii"
		if "`sttl'"!="" {
			qui replace `sttl'="" if `expw'==2
		}
		if  `"`censt'"'=="numbered" {
			local N=_N
			qui expand `expw'
			qui replace `expw'=cond(_n>`N',2,.)
			tempvar sadj
			qui sum `s', meanonly
			if "`na'"=="" & "`cna'"=="" {
				qui gen double `sadj'= /*
				*/ `s'+1/35  if `expw'==2
			}
			else {
				noi sum `s', meanonly
				qui gen `sadj'=`s'+ (r(max)-r(min))/30 if /*
				*/ `expw'==2
			}
			qui replace `s'=.  if `expw'==2
			qui replace `cens'=. if `expw'~=2	
			local msym ="`msym'[`cens']"
			local tmvars="`tmvars' `sadj'"
			if "`sttl'"!="" {
				qui replace `sttl'="" if `expw'==2
			}
		}
			
	}
	else if  `"`censt'"'=="multiple" {
		tempvar tmvars tsym expw tu nextt mins
		qui gen double `mins'=1-`s' 
		sort `mins' _t
		qui gen double `nextt'=_t[_n+1]
		qui by `mins': replace `nextt'=`nextt'[_N]
	

		qui sum _t, meanonly
		local adjd=(r(max)-r(min))/350
		qui gen int `expw'=`cens'+1  if `cens'>0 & `cens'<. & `flg'>=.
		local N=_N
		qui expand `expw'
		qui replace `expw'=cond(_n>`N',2,.)
		qui gen double `tmvars'=`s' if `expw'==2
		sort  _t `s' `expw'
		tempvar move ttime 
		qui by  _t: gen int `move'=1 if _t+`adjd'*_n<=`nextt' /*
		*/ & `expw'==2
		qui by  _t: replace `move'=2 if `move'>=. & /*
		*/ _t-`adjd'*_n>=_t[1] & `expw'==2
		qui by  _t: gen double `ttime'= _t+`adjd'*_n if `move'==1
		qui by  _t: replace `ttime'= _t-`adjd'*_n if `move'==2
		qui replace _t= `ttime' if `ttime'<.
		drop `ttime' `move' 


		sort  `s' _t `expw'
		*qui by `s': replace _t=_t+`adjd' if `expw'==2 & _n==1 & /*
		*/ _t+`adjd'<_t[_N+1]
		format `tmvars' %9.2f
		if "`na'"=="" & "`cna'"=="" {
			qui gen `tu'=`tmvars'+.02 if `expw'==2
		}
		else {
			noi sum `s', meanonly
			qui gen `tu'=`tmvars'+ (r(max)-r(min))/45 if `expw'==2
		}
		local tcon ="||"
		local msym ="ii"
		local tmvars="`tmvars' `tu'"
		if "`sttl'"!="" {
			qui replace `sttl'="" if `expw'==2
		}
	}
	if "`by'"!="" | "`strata'"!="" {
		sort `by' `strata'
	}
	label var _t "analysis time"
	gr7 `svars' `mvars' `tmvars'  _t, c(`scon'`mcon'`tcon') /*
	*/ s(`ssym'`msym') /*
	*/ pen(`spen'`mpen') `byopt' `ylabel' `xlabel' `border' /*
	*/ `l1title' `t1title' `t2title' trim(`trim') `ylog' `options' sort
end


program define DoAdjust /* by strata adjustf if in -> haz s */
	local by     "`1'"		/* optional 	*/
	local strata "`2'"		/* optional 	*/
	local adjustf "`3'"		/* required	*/
	local if      "`4'"		/* optional	*/
	local in      "`5'"		/* optional	*/

/* */
	local haz "`7'"			/* optional 	*/
	local s   "`8'"			/* optional 	*/

	if "`strata'"!="" {
		local stopt "strata(`strata')"
	}

	if "`by'"=="" {
		if "`s'" != "" {
			local sopt "bases(`s')"
		}
		if "`haz'" != "" {
			local hopt "baseh(`haz')"
		}
		stcox `adjustf' `if' `in', /*
			*/ `stopt' `sopt' `hopt' estimate norobust
		exit
	}
	if "`haz'" != "" {
		tempvar hi
		local hopt "baseh(`hi')"
		gen double `haz' = . 
	}
	if "`s'" != "" {
		tempvar si
		local sopt "bases(`si')"
		gen double `s' = .
	}
	if !(`"`if'"'=="" & "`in'"=="") {
		tempvar touse 
		mark `touse' `if' `in'
		local cond "if `touse'"
		local andcond "& `touse'"
	}
	tempvar grp
	sort `touse' `by'
	by `touse' `by': gen int `grp' = 1 if _n==1 `andcond'
	replace `grp'=sum(`grp') `cond'
	local ng = `grp'[_N]
	local i 1
	while `i' <= `ng' { 
		capture stcox `adjustf' if `grp'==`i', /*
			*/ `stopt' `sopt' `hopt' estimate norobust
		if _rc==0 {
			if "`hopt'"!="" {
				replace `haz' = `hi' if `grp'==`i' 
				drop `hi'
			}
			if "`sopt'"!="" {
				replace `s' = `si' if `grp'==`i'
				drop `si'
			}
		}
		local i = `i' + 1
	}
end


program define KeepDead /* strata */
	args strata

	local d : char _dta[st_d]
	if `"`_dta[st_d]'"'!="" {
		/* keep if `_dta[st_d]' */
		drop `_dta[st_d]'
	}
	sort `strata' _t
	by `strata' _t: keep if _n==1
end
	


program define MarkPt /* t strata s -> ttl s2 */
	args t strata s ARROW ttl s2

	tempvar tval mark marksum ls

	summarize _t
	gen float `tval' = r(min) + (r(max)-r(min))*2/3

	gen byte `mark' = cond(_t<`tval', 1, 0)
	by `strata': replace `mark'=0 if `mark'[_n+1]==1
	by `strata': gen byte `marksum' = sum(`mark')
	by `strata': replace `mark'=1 if _n==_N & `marksum'==0
	drop `tval' `marksum'

	summarize `s'
	local eps = max( (r(max)-r(min))/20, .0)
	gen float `ls' = `s'
	by `strata': replace `ls' = `ls'[_n-1] if `ls'>=.
	gen float `s2' = `ls'+`eps' if `mark'
	replace `s2' = `ls'[_n-1]+`eps' if `mark' & `strata'==`strata'[_n-1]

	summarize `s2' 
	replace `s2' = max(`s2'-8*`eps',0) if `s2'==r(min)
	replace `s2' = `s2'+`eps' if `s2'==r(max)

	capture confirm string variable `strata'
	if _rc {
		gen str20 `ttl' = "`strata' " + trim(string(`strata')) if `mark'
		local lab : value label `strata'
		if "`lab'" != "" {
			tempvar delab
			decode `strata', gen(`delab') maxlen(20)
			replace `ttl' = `delab' if `mark'
		}
	}
	else	gen str20 `ttl' = trim(`strata') if `mark'
	compress `ttl'
end


program define ByStAdj, sclass
	args by strata adjustf

	sret clear
	if "`strata'"!="" {
		if "`adjustf'"=="" {
			di in red /*
		*/ "strata() requires adjustfor(); perhaps you mean by()"
			exit 198 
		}
	}

	if !("`by'"=="" & "`strata'"=="") {
		if "`by'"!="" & "`strata'"!="" { 
			sret local sb "`by' `strata'"
		}
		else if "`by'"!="" { 
			sret local sb "`by'" 
		}
		else 	sret local sb "`strata'"
	}
end
exit
