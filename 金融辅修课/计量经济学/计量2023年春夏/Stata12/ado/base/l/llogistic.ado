*! version 1.7.3  02feb2009
program define llogistic, eclass byable(recall) prop(ml_score)
	version 7
	if replay() {
		if `"`e(cmd)'"' != "llogistic" { error 301 } 
		if _by() { error 190 }
		syntax [, Level(cilevel) noCOEF noHEADer TR *]
                if "`e(gamma)'"=="" {
                        local ancilla = "anc"
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
			*/ MLOpt(string) noCONstant STrata(varname) /*
			*/ Level(cilevel) noLOg /*
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
		if "`from'"!="" { local iniopt init(`from') }
		if "`mlmethod'" == "" { local mlmetho = "`mm'" }
		if "`offset'" !="" { local offopt = "offset(`offset')" }	
		_get_diopts diopts options, `options'
		mlopts options, `options'
		local coll `s(collinear)'

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

		tempvar touse 
		mark `touse' `w' `if' `in'
		markout `touse' `t' `rhs' `dead' `t0' `offset'
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

		global EREGd `dead'
		* global EREGt `t'
		global EREGt0 `t0'

		if "`log'"!="" { local nlog="*" }
		tempvar mysamp num den
		tempname b f V  g b0 bc0
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
			drop `num' 
			if "`wvngen'"!=""  { drop `wvn' }
		}
		local search search(off)
		if "`constant'"!="" {
			local skip = "skip"
			local search search(quietly)
			`nlog' di as txt "Fitting full model:"
		}
		if "`rhs'" != "" & "`skip'"=="" { 
			`nlog' di ""
			`nlog' di as txt "Fitting constant-only model:"
			`vv' ///
			ml model `mlmetho' logis_lf (`t': `t'=, `offopt') /*
				*/ (ln_gam: `ancillary') `w' if `touse', /*
				*/ init(_cons=1) /*
				*/ missing collin nopreserve wald(0) `mlopt' /*
				*/ max search(quietly) noout `log' `options' /*
				*/ `robust' nocnsnotes `negh'
			local cont continue
			`nlog' di ""
			`nlog' di as txt "Fitting full model:"
		}
		else {
			 local cont wald(1)
		}
		if "`ancillary'" == "" {
			local dip diparm(ln_gam, exp label(gamma))
		}
		`vv' ///
		ml model `mlmetho' logis_lf /*
			*/ (`t': `t'=`rhs', `offopt' `constant' ) /*
			*/ (ln_gam: `ancillary') `w' if `touse', `cont' noout /*
			*/ `robust' `cluopt' `scopt' `iniopt' `mlopt' /*
			*/ missing collin nopreserve /*
			*/ max `search' `log' `dip' `options' `negh'
		if "`e(wtype)'" != "" {
			est local wexp `"`exp'"'
		}
		est local title2 "accelerated failure-time form"
		est local predict llogis_p
		est local t0 `t0'
		est local dead `sdead'
		if "`ancillary'" == "" {
			est local k_aux = 1
		}
		est local cmd llogistic 
		global S_E_cmd llogistic
	}
	global EREGw
	global EREGd
	global EREGt
	global EREGt0
	global EREGa
	if "`ancillary'" =="" & "`ancilla'"=="" {
		local bg "[ln_gam]_b[_cons]"
		est scalar gamma = exp(`bg')
		est local stcurve="stcurve"
	}

	if "`coef'"=="" {
		if `"`tr'"'!=`""' {
			local hr `"eform(Tm. Ratio)"'
		}
		if "`header'" == "" {
			di _n as txt /*
		      */ "Log-logistic regression -- entry time `e(t0)'"
		}
		version 9: ///
		ml di, `header' `hr' level(`level') title(`e(title2)') ///
			`diopts'
	}
end

exit
