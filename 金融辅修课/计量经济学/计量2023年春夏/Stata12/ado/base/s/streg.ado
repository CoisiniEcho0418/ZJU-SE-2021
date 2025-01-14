*! version 6.3.8  16mar2011
program define streg, eclass byable(onecall) sort ///
		prop(st swml nohr hr tr svyb svyj svyr mi)
	version 6, missing
	local version : di "version " string(_caller()) ", missing:"

	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	`version' `BY' _vce_parserun streg, stdata noneedvarlist	///
		mark(STrata OFFset SHared ANCillary anc2 CLuster) 	///
		numdepvars(0) : `0'
	if "`s(exit)'" != "" {
		version 10: ereturn local cmdline `"streg `0'"'
		exit
	}
	if replay() {
		if _by() { error 190 }
		syntax [, Distribution(string) *]
		if "`distrib'"=="" {
			if "`e(cmd2)'" != "streg" { error 301 } 
			if "`e(prefix)'" == "svy" {
				_prefix_display `0'
				exit
			}
			Display `0'
			exit 
		}
	}
	`version' `BY' Estimate `0'
	version 10: ereturn local cmdline `"streg `0'"'
end

program Estimate, eclass byable(recall)
	local vv : di "version " string(_caller()) ", missing:"
	version 6, missing
	st_is 2 analysis
	syntax [varlist(default=empty fv)] [fw pw iw aw] [if] [in] /*
		*/ [, CLuster(passthru) CMD Level(cilevel) /*
		*/ Distribution(string) Robust  /* 
		*/ FRailty(string) SHared(varname) noHEADer /*
		*/ TIme TR noHR noSHow SCore(passthru) noCOEF /* 
		*/ STrata(passthru) ANCillary(passthru) /*
		*/ anc2(passthru) noCONstant VCE(passthru) *]

	_get_diopts diopts options, `options'
	_vce_parse, argopt(CLuster) opt(Robust OIM OPG) old	///
		: [`weight'`exp'], `cluster' `robust' `vce'
	local robust `r(robust)'
	local cluster `r(cluster)'
	if "`robust'`cluster'" == "" {
		local options `"`options' `r(vceopt)'"'
	}
	if _by() {
		_byoptnotallowed score() `"`score'"'
	}
	if "`weight'" != "" {
		di as err "weights must be stset"
		exit 101
	}
	GetCmd `"`distrib'"' `"`frailty'"' `"`shared'"'
	local ecmd `s(cmd)'
	local frailty `s(frailty)'
	local shared `s(shared)'

	if "`shared'" != "" {
		if "`cluster'" != "" { 
			di as err "vce(cluster) not allowed with shared()"
			exit 198
		}
		if "`robust'" != "" {
			di as error "vce(robust) not allowed with shared()"
			exit 101
		}
		if "`weight'" == "pweight" {
			di as error "pweights not allowed with shared()"
			exit 101
		}
	}

	GetClass `ecmd'
	local class `s(class)'

	Opt_`class', `time' `tr' `hr'
	local etime `s(etime)'
	local otime `s(otime)'
	local rotime `s(rotime)'

	if `level' != $S_level {
		local otime `"level(`level') `otime'"'
		local rotime `"level(`level') `rotime'"'
	}


					/* obtain info from -st- 	*/
	local t0 "t0(_t0)"
	local d "dead(_d)"
	local id : char _dta[st_id]
	local w  : char _dta[st_w]
	local wt : char _dta[st_wt]

					/* identify estimation subsample */
	tempvar touse 
	st_smpl `touse' `"`if'"' "`in'" "`cluster'"
	markout `touse' `varlist'
	if _by() {
		version 7, missing
		local byind "`_byindex'"
		version 6, missing
		qui replace `touse'=0 if `byind'!=_byindex()
		local byind
	}

					/* shut off eform if appropriate */

	if `"`strata'`ancillary'`anc2'"' != "" {
		local noeform noeform
	}

					/* determine command arguments 	*/

	if `"`wt'"'=="pweight" {
		local robust `"robust"'
	}

	if "`robust'"!="" & "`cluster'"=="" & "`id'"!="" {
		local cluster "`id'"
	}
	if "`cluster'"!="" {
		local cluster "cluster(`cluster')"
	}
	if "`frailty'"!="" {
		local frailty "frailty(`frailty')"
	}
	if "`shared'"!="" {
		local shared "shared(`shared')"
	}
	if "`constant'" != "" {
		local nvar : word count `varlist'
		if `nvar' == 0 {
			di as err "independent variables required " _c
			di as err "with noconstant option"
			exit 100
		}
	}
			
	st_show `show'

	*di

	if "`cmd'"!="" {
		di _n in gr `"-> `ecmd' _t `varlist' `w' `if' `in', "' /*
		*/ `"`etime' `otime' `robust' `cluster' `t0' `d' `score'"' /*
		*/ `"`frailty' `shared' `strata' `ancillary' `constant' `anc2' `options'"'
		exit
	}
	`vv'	`ecmd' _t `varlist' `w' if `touse', `frailty'  /* 
		*/ `shared' nocoef /* 
		*/`etime' `otime' `robust' `cluster' `t0' `d' `score' /*
		*/ `strata' `ancillary' `constant' `anc2' `options'

	SetTitle
	if `class'==2 { 
		est local frm2 "hazard"
	}
	else if `class'==3 { 
		est local frm2 "time"
	}
	st_hc `touse' 
	global S_E_cmd2 streg 		/* Double save */
	est local cmd2 streg 
	est hidden local marginsprop `e(marginsprop)' nochainrule
	if "`noeform'" != "" {          /* eform not appropriate */
		est hidden local noeform noeform
	}
	est local predict_sub `e(predict)'
	est local predict streg_p

	Display, `rotime' `header' `coef' `diopts'
end

program define Display
	syntax [, noHR TR noHEADer noCOEF Level(cilevel) *]
	_get_diopts diopts, `options'
	if "`e(frm2)'" == "hazard" {
		if "`tr'"!="" {
			di in red "tr not allowed" 
			exit 198
		}
		if "`hr'"=="" {
			local hr "hr"
		}
		else	local hr
	}
	else {
		if "`hr'"!="" {
			di in red "nohr not allowed"
			exit 198
		}
	}

	if "`header'"=="" {
		di 
		if "`e(shared)'" == "" {
			di in gr "`e(title)' -- `e(title2)' "
			if `"`e(fr_title)'"' != "" {
				local col = length("`e(title)'") + 5
				di _col(`col') "`e(fr_title)'"
			}
			st_hcd
		}
		else {
			st_hcd_sh
		}
	}

	if "`coef'"=="" {
		di
		if "`e(noeform)'" != "" {
			`e(cmd)', level(`level') nohead `diopts'
			if "`tr'"!="" {
di as txt "note: tr ignored; not appropriate with strata() or ancillary() options"
			}
		}
		else {
			`e(cmd)', `hr' `tr' level(`level') nohead `diopts'
			if "`hr'`tr'"!="" {
				capture di _b[_cons]
				if _rc {
di as txt "note: no constant term was estimated in the main equation" 
				}
			}
		}
	}
end

program SetTitle, eclass
	version 9
	local cmd `e(cmd)'
	local l : length local cmd
	if "`e(frm2)'"=="hazard" {
		ereturn local title2 "log relative-hazard form"
	}
	if "`e(frm2)'"=="time" {
		ereturn local title2 "accelerated failure-time form"
	}
	if "`cmd'"==substr("weibullhet",1,`l') {
		ereturn local title "Weibull regression"
		exit
	}
	if "`cmd'"==substr("ereghet",1,`l') {
		ereturn local title "Exponential regression"
		exit
	}
	if "`cmd'"==substr("lnormalhet",1,`l') {
		ereturn local title "Lognormal regression"
		exit
	}
	if "`cmd'"==substr("llogistichet",1,`l') {
		ereturn local title "Loglogistic regression"
		exit
	}
	if "`cmd'"==substr("gammahet",1,`l') {
		ereturn local title "Gamma regression"
		exit
	}
	if "`cmd'"==substr("gompertzhet",1,`l') {
		ereturn local title "Gompertz regression"
		exit
	}
end

program define GetCmd, sclass
	args dist frailty shared
	if "`dist'"=="" {
		/* default command */ 

		if "`e(cmd2)'"=="streg" & "`e(fr_title)'"~="" {
			if "`frailty'"=="" {
				local frailty=lower(substr("`e(fr_title)'",1,1))
			}
			if "`shared'"=="" {
				local shared "`e(shared)'"
			}
			sret local cmd "`e(cmd)'"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
			exit
		}

		if "`e(cmd2)'"=="streg" {
			if "`frailty'"!="" {local het het}
			sret local cmd "`e(cmd)'`het'"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
			exit
		}
		di as err "must specify " as input "distribution()"
		exit 198
	}
		
	if `"`shared'"' != "" & `"`frailty'"' == "" {
		local frailty "gamma"
		di as txt _n "Note: frailty(gamma) assumed."
	}
	local l = length("`dist'")
	if substr("exponential",1,max(1,`l')) == "`dist'" { 
		if "`frailty'"=="" {
			sret local cmd "ereg"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "ereghet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		exit
	}
	local l = length("`dist'")
	if substr("ereg",1,max(1,`l')) == "`dist'" { 
		if "`frailty'"=="" {
			sret local cmd "ereg"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "ereghet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		exit
	}
	if substr("weibull",1,max(1,`l')) == "`dist'" { 
		if "`frailty'"=="" {
			sret local cmd "weibull"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "weibullhet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		exit
	}
 	if substr("lognormal",1,max(`l',4)) == "`dist'" | /*
 		*/ substr("lnormal",1,max(`l',2)) == "`dist'" {
		if "`frailty'"=="" {
 			sret local cmd "lnormal"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
 			sret local cmd "lnormalhet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
 		exit
 	}
 	if substr("loglogistic",1,max(`l',4))  == "`dist'"  | /*
 		*/ substr("llogistic",1,max(`l',2)) == "`dist'"  {
		if "`frailty'"=="" {
			sret local cmd "llogistic"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "llogistichet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
 		exit
 	}
 	if substr("gompertz",1,max(3,`l')) == "`dist'" {
		if "`frailty'"=="" {
			sret local cmd "gompertz"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "gompertzhet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
 		exit
 	}
 	if substr("gamma",1,max(3,`l')) == "`dist'" {
		if "`frailty'"=="" {
			sret local cmd "gamma"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
		else {
			sret local cmd "gammahet"
			sret local frailty "`frailty'"
			sret local shared "`shared'"
		}
 		exit
 	}
	di in red "unknown distribution: `dist'"
	exit 198 
end


program define GetClass, sclass
	args cmd 
	if "`cmd'"=="ereg" | "`cmd'"=="weibull"  | "`cmd'"=="weibullhet" /*
		*/  | "`cmd'"=="ereghet" {
		sret local class 1
		exit
	}
	if "`cmd'"=="gompertz" | "`cmd'"=="gompertzhet" {
		sret local class 2
		exit
	}
	if "`cmd'"=="lnormal" | "`cmd'"=="llogistic" | "`cmd'"=="gamma" {
		sret local class 3
		exit
	}
	if "`cmd'"=="lnormalhet" | "`cmd'"=="llogistichet" | /*
		*/ "`cmd'"=="gammahet" {
		sret local class 3
		exit
	}

	error 301
end

program define Opt_1, sclass
	syntax [, noHR TIme TR]
	if "`time'"!="" | "`tr'"!="" { 
		sret local etime /*nothing*/
		sret local otime `tr'
		sret local rotime `tr'
	}
	else {
		sret local etime hazard
		if "`hr'"=="" {
			sret local otime hr
			sret local rotime 
		}
		else {
			sret local otime /*nothing*/
			sret local rotime nohr
		}
	}
end

program define Opt_2, sclass
	syntax [, noHR]
	sret local etime /*nothing*/
	if "`hr'"=="" {
		sret local otime hr
		sret local rotime /*nothing*/
	}
	else {
		sret local otime
		sret local rotime nohr
	}
end
		

program define Opt_3, sclass
	syntax [, TIme TR]
	sret local etime /*nothing*/
	sret local otime `tr'
	sret local rotime `tr'
end
	
exit

Concerning GetClass returns 

        s(class)        1 ln time/ln hazard command
			2 ln hazard command 
                        3 ln time command 

A class-1 command: 
     1)  defaults to estimating results in ln time metric;
         a)  reports coefficients by default 
         b)  the -tr- option will report coefficients as ratios
     2)  the -hazard- option will estimate in the ln hazard metric; 
         a)  reports coefficients by default
         b)  the -hr- option will report coefficients as ratios;
     3)  A class-1 command fills in e(frm2) with "hazard" or "time" 
         depending on metric.
     4)  e(t0) contains t0 variable or 0
Examples are -weibull- and -ereg-

A class-2 command:
    1)  estimates in the ln hazard metric 
        a) by default, reports coefficients
        b) the -hr- option will report coefficients as ratios
    2)  A class-2 command does NOT fill in e(frm2)
    3)  e(t0) contains t0 variable or 0
Examples are -gompertz-

A class-3 command:
    1)  estimates in the ln time metric
        a) by default, reports coefficients 
        b) the -tr- option will report coefficients as ratios
    2)  A class-3 command does NOT fill in e(frm2)
    3)  e(t0) contains t0 variable or 0
Examples are -lnormal-.

-streg- works like this:

    1)  Estimates in the ln hazard metric if possible.
        a)  reports coefficients as hazard ratios by default
        b)  the -nohr- option will report coefficients

        c)  estimates in ln time metric if option -time- is specified
        d)  reports coefficients by default
        e)  reports ratios if option -tr-

    2)  If only ln hazard is allowed:
        a)  reports coefficients as hazard ratios by default
        b)  the -nohr- option will report coefficients

    3)  If only ln time is allowed:
        a)  may specify option -time- or not; it makes no difference
        d)  reports coefficients by default
        c)  reports ratios if option -tr-

So, options are -nohr-, -time-, and -tr-.  They map like this:

    Class 1:            Est options            Display options
         <none>         hazard                 hr
         nohr           hazard     
         time      
         tr                                    tr
	 time tr                               tr
    Class 2:
         <none>                                hr
         nohr
    Class 3:
         <none>
         time
         tr                                    tr
         time tr                               tr


