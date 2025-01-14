*! version 1.6.4  16mar2011
program define weibull_c, eclass byable(recall)
	version 7
	if replay() {
		if `"`e(cmd)'"' != "weibull" { error 301 } 
		if _by() { error 190 }
		syntax [, Level(cilevel) noCOEF noHEADer TR HR *]
		if "`e(aux_p)'"=="" {
			local ancillary 1
		}
		_get_diopts diopts, `options'
	}
	else {
		if _caller() >= 11 {
			local vv : di "version " string(_caller()) ":"
			local mm e2
			local negh negh
		}
		else {
			local vv "version 8.1:"
			local mm d2
		}
		syntax [varlist(fv)] [if] [in] [fweight pweight iweight] /*
			*/ [, noCOEF CLuster(varname) Dead(varname numeric)/*
			*/ DEBUG FROM(string) noHEADer MLMethod(string) /*
			*/ MLOpt(string) noCONstant HAzard HR STrata(varname) /*
			*/ Level(cilevel) noLOg TRANS /*
			*/ OFFset(varname numeric) ANCillary(varlist fv) /*
			*/ Robust SCore(string) T0(varname numeric) SKIP TR *]
		if _by() {
			_byoptnotallowed score() `"`score'"'
		}
		local fvops = "`s(fvops)'" == "true" | _caller() >= 11
		tokenize `varlist'
		local t `1'
		mac shift 
		local rhs `*'
		if "`strata'"~="" {
                        if "`ancillary'"~="" {
                                noi di as err /*
                                */ "options strata() and ancillary()" /*
                                */ " may not be specified together"
                                exit 198
                        }
                        qui xi, prefix(_S) i.`strata'
                        local rhs `rhs' _S*
                        local ancillary _S*
                }

		if "`cluster'"!="" {
			local cluopt cluster(`cluster')
		}
		if "`weight'" == "pweight" | "`robust'`cluster'" != "" {
			local robust robust
		}

		if "`mlmethod'" == "" { local mlmetho = "`mm'" }
		if "`offset'" !="" { local offopt = "offset(`offset')" }
		_get_diopts diopts options, `options'
		mlopts mloptions, `options'
		local coll `s(collinear)'
		if "`hazard'"!="" {
			if "`tr'"!="" {
				di as err "tr invalid with hazard option"
				exit 198
			}
		}
		else if "`hr'"!="" {
			local hazard "hazard"
		}
		
		if "`score'" != "" {
			local n : word count `score'
			if `n'==1 & substr("`score'",-1,1)=="*" { 
				local score = /*
				*/ substr("`score'",1,length("`score'")-1)
				local score `score'1 `score'2 
				local n 2
			}
			if `n' != 2 { 
				di as err /*
			*/ "score() invalid:  two new variable names required"
				exit 198 
			}
			confirm new var `score'
			local scopt "score(`score')"
		}

		if "`weight'" != "" { 
			tempvar wv
			qui gen double `wv' `exp'
			local w [`weight'=`wv']
		}
		/* Mark sample. */
		marksample touse
		markout `touse' `t0' `dead' `offset'
		markout `touse' `cluster', strok

		if "`dead'" != "" {
			local sdead "`dead'"
			capture assert `dead'==0 | `dead'==1 if `touse'
			if _rc { 
				tempvar mydead 
				qui gen byte `mydead' = `dead'!=0 if `touse'
				local dead "`mydead'"
			}
		}
		else {
			tempvar dead 
			qui gen byte `dead'=1
			local sdead 1
		}
		if "`t0'" == "" {
			local t0 0
		}
		else {
			local t0opt="t0(`t0')"
		}
		capture assert `t0' < `t' if `touse'
		if _rc {
			di as err "`t0' >= `t' in some obs."
			exit 498
		}

		if `fvops' {
			local rmcoll "version 11: _rmcoll"
		}
		else	local rmcoll _rmcoll
		`rmcoll' `rhs' `w' if `touse', `constant' `coll'
		local rhs "`r(varlist)'"
		global S_1

		if "`from'" != "" { 
				local iniopt init(`from') 
		}
		tempname b0 
		if "`constant'"=="" {
			qui weibull_s `t' `w' if `touse', /*
				*/ dead(`dead') `t0opt' `hazard'
			matrix `b0' = e(b)
		}

		global EREGd `dead'
		global EREGt `t'
		global EREGt0 `t0'

		local maxlf weib2_lf 
		if "`hazard'"=="" {
			local maxlf weib1_lf 
		}
		if "`log'"!="" { local nlog="*" }
		tempvar mysamp num den
		tempname b f V  g bc0
		quietly { 
			if "`weight'"=="aweight" | "`weight'"=="pweight" {
				tempvar wvn
				summ `wv' if `touse', meanonly 
				gen double `wvn' = `wv'/r(mean)
				local wvngen 1
			}
			else if "`weight'"!="" {
				local wvn `wv'
			}
			else {
				local wvn 1
			}
			gen double `num' = `wvn'*ln(`t') if `touse' & `dead'
			replace `num' = sum(`num') 
			global EREGa = `num'[_N]
			if "`trans'" ~="" {
				global EREGa = 0
			}	
			drop `num' 
			if "`wvngen'"!=""  { drop `wvn' }
		}
		local search search(off)
		if "`constant'"!="" {
			local skip skip
			local search search(quietly)
			`nlog' di as txt "Fitting full model:"
		}
		if "`rhs'" != "" & "`skip'"=="" { 
			`nlog' di ""
			`nlog' di as txt "Fitting constant-only model:"
			`vv' ///
			ml model `mlmetho' `maxlf' (`t': `t'=, `offopt') /*
				*/ (ln_p: `ancillary') `w' if `touse', /*
				*/ init(`b0') /*
				*/ missing collin nopreserve wald(0) `mlopt' /*
				*/ max search(quietly) noout `log' /*
				*/ `mloptions' `robust' nocnsnotes `negh'
			local cont continue
			`nlog' di ""
			`nlog' di as txt "Fitting full model:"
		}
		else {
			local cont wald(1)
		}
		if "`ancillary'" == "" {
			local dip diparm(ln_p, exp label(p))	///
				diparm(ln_p, f(exp(-@)) d(exp(-@)) label("1/p"))
		}
		`vv' ///
		ml model `mlmetho' `maxlf' /*
			*/ (`t': `t'=`rhs' , `offopt' `constant') /*
			*/ (ln_p: `ancillary') `w' if `touse', `cont'/*
			*/ `robust' `cluopt' `scopt' `mlopt' /*
			*/ missing collin nopreserve `iniopt' /*
			*/ max `search' `log' `mloptions' `dip' `negh'
		if "`e(wtype)'" != "" {
			est local wexp `"`exp'"'
		}
		est local title2 "log relative-hazard form"
		if "`hazard'"=="" {
			est local title2 "accelerated failure-time form"
			est local frm2 "time"
		}
		else    est local frm2 "hazard"
		est local predict weibul_p
		est hidden local by_weibull_c by_weibull_c
		est local t0 "`t0'"
        	est local dead `sdead'
		if "`ancillary'" == "" {
			est scalar k_aux = 1
		}
		est local cmd weibull 
	}
	global EREGw
	global EREGd
	global EREGt
	global EREGt0
	global EREGa

	if "`ancillary'" =="" {
		local bg "[ln_p]_b[_cons]"
		est scalar aux_p = exp(`bg')        
		est local stcurve="stcurve"
	}
	if "`coef'"=="" {
		if "`hr'"!="" {
			local eform "eform(Haz. Ratio)"
		}
		else if "`tr'"!="" {
			local eform "eform(Tm. Ratio)"
		}

		if `"`tr'"'!=`""' {
			local hr `"eform(Tm. Ratio)"'
                }
		if "`header'" == "" {
			di _n as txt /*
			*/ "Weibull regression -- entry time `e(t0)'"
		}
		version 9: ///
		ml di, `header' `eform' level(`level') title(`e(title2)') ///
			`diopts'
	}
end
