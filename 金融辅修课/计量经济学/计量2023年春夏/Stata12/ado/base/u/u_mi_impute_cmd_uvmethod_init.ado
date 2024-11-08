*! version 1.0.0  07jul2011
program u_mi_impute_cmd_uvmethod_init, eclass
	version 12
	args impobj method cmdname
	local catcmd = inlist("`cmdname'","logit","ologit","mlogit")
	if (`catcmd') {
		local ADDITIONAL augment nofvlegend augnoisily noppcheck
	}
	args impobj method cmdname cmd ivars depvars xspec 	///
	     ifspec ifcond conditional ifgroup wtype wexp	///
	     expnames expnamesmon noconstant bootstrap noisily showcommand ///
	     cmdopts nocmdlegend `ADDITIONAL'			///
	     peqspec peqspecmon monotone iteration currm setuponly ///
	     nocondchk setstripe omitchk
 
	if (!`c(noisily)') {
		local noisily
	}
	if ("`setstripe'"=="") {
		if ($MI_IMPUTE_setstripe==0) { 
			local setstripe 1
		}
		else {
			local setstripe 0
		}
	}
	if ($MI_IMPUTE_setstripe==0 & `setstripe'==1) {
		global MI_IMPUTE_setstripe 1
	}
	if ("`omitchk'"=="") {
		local omitchk 1
	}
	if ("`monotone'"!="") {
		local monotone mon
	}
	local indepspec `peqspec`monotone'' `xspec'
	local expnames `expnames`monotone''
	// reset missing values
	mata: `impobj'.fillmis()
	  
	// -- setup begin
	// 'touse' marks imputation sample
	tempvar touse tousecond
	mark `touse' `ifspec'
	markout `touse' `ivars', sysmissok
	if (`"`conditional'"'!="") {
		mark `tousecond' `ifcond'
		markout `tousecond' `ivars', sysmissok
	}
	else {
		qui gen byte `tousecond' = `touse'
	}
	if ("`ifgroup'"!="") {
		qui replace `touse' = 0 if !(`ifgroup') & `touse'==1
		qui replace `tousecond' = 0 if !(`ifgroup') & `tousecond'==1
	}
	// replace expressions
	u_mi_impute_replace_expvars `expnames' if `touse'
	qui if ("`wtype'"!= "" & "`wtype'"!="pweight")  {
		// pweights are not used at the imputation step
		tempvar impwgt
		gen double `impwgt' `wexp' if `tousecond'
	}
	mata: `impobj'.setup("`tousecond'","`impwgt'") 
	// -- setup end

	if ("`conditional'"=="" & "`setuponly'"!="") exit

	// proceed to estimation only if have misvals to impute
	local initcap
	if ("`nocondchk'"=="") {
	        qui count if `ivars'==. & `tousecond'
        	if (`r(N)'==0) {
			di as txt "{p 0 6 2}note: variable {bf:`ivars'} contain"
			di as txt "no soft missing (.) values in conditional"
			di as txt "sample{p_end}"
			ereturn post
			eret local cmd "`cmd'"
        	        exit 0
        	}
		else if "`e(b)'"=="matrix" & "`monotone'"!="" & "`currm'"=="" { 
			// used by -monotone-'s impute;
			// appropriate estimation results already in memory;
			// init() is used to display 'VCE not positive definite'
			// error (if arises) provided 'ivars' contains missing
			// values in current conditional sample (CS)
			mata: `impobj'.init(`omitchk')
		}

	}
	else if (`"`conditional'"'!="") {
		// used by -monotone-'s init;
		// suppresses 'VCE not positive definite' error from init()
		// (if arises) before 'ivars' is known to contain some 
		// missing values in CS;
		// for -monotone- and -chained-, CS is determined not at 
		// estimation step but at imputation step.  Unlike -chained-,
		// -monotone- estimates only once on the original data so
		// checks for conditional variables performed later
		// on each imputation
		local initcap capture
	}

	if ("`setuponly'"!="") exit

	// -- estimation begin
	if ("`wtype'"!="") {
		local wgtexp [`wtype'`wexp']
	}
	if ("`bootstrap'"!="") {
		tempvar bootwgt sortid
		qui gen byte `bootwgt' = .
		qui gen long `sortid' = _n
		// sample from the observed data within conditional sample
		qui bsample if `tousecond' & `ivars'<., weight(`bootwgt')
		qui sort `sortid'
		local bootwgtexp [fw=`bootwgt']
		local nochol ", 1"
	}
	else {
		local nochol ", 0"
	}
	set buildfvinfo off	//turns off computation of H matrix, for speed
	local command `cmd' `depvars' `indepspec' ///
				if `tousecond' `wgtexp'`bootwgtexp', `cmdopts'
	if ("`augnoisily'"!="") {
		local augnoisily noisily
	}
	if ("`currm'"!="") {
		local dicurrm ", {it:m}={bf:`currm'}"
	}
	if ("`iteration'"=="") {
		if ("`bootstrap'"=="") {
			local didata "observed data`dicurrm'"
		}
		else {
			local didata "bootstrap sample`dicurrm'"
		}
	}
	else {
		if ("`bootstrap'"=="") {
			local didata ///
		"data from iteration {bf:`iteration'}`dicurrm'"
		}
		else {
			local didata ///
		"bootstrap sample from iteration {bf:`iteration'}`dicurrm'"
		}
	}
	if ("`noisily'"!="") {
		di
		di as txt `"Running {bf:`cmdname'} on `didata':"'
		if ("`showcommand'"!="") {
			local cmdline `cmd' `depvars' `indepspec' ///
						`ifcond' `wgtexp'
			if (`"`cmdopts'"'!="") {
				local cmdline `cmdline', `cmdopts'
			}
			di as txt "{p 0 2 2}-> `cmdline'{p_end}"
		}
		local augnoisily noisily
	}
	if ("`noisily'"!="" & "`nocmdlegend'"=="") {
		u_mi_impute_diexpheader "`expnames'"
		di
	}
	// run <command>
	cap noi qui `noisily' `command'
	local cmdrc = _rc
	if ("`method'"=="logit" & (`cmdrc'==2000 | `cmdrc'==2001)) {
		if ("`noisily'"=="" & `c(noisily)') {
			// to display notes about perfect prediction on error
			cap noi _rmcoll `depvars' `indepspec'  		///
				if `tousecond' `wgtexp'`bootwgtexp',	///
						`noconstant' logit
		}
		exit `cmdrc'
	}
	else if `cmdrc' {
		exit `cmdrc'
	}
	if (e(converged)==0) {
		di as err "{bf:`cmdname'} failed to converge on observed data"
		exit 430
	}
	if "`wtype'" == "aweight" { // need this to adjust variance estimate
		summ `impwgt' if e(sample), meanonly
		tempname awgtmean
		scalar `awgtmean' = r(mean)
		local wgtadj `", "`awgtmean'""'
	}
	if ("`noisily'"=="" & `c(noisily)') {
		// to display notes about omitted variables
		tempname ehold //_rmcoll may clear out -e()-
		_estimates hold `ehold', copy
		_rmcoll `indepspec' if e(sample) `wgtexp'`bootwgtexp',	///
								`noconstant'
		_estimates unhold `ehold'
	}
	if !(`catcmd') {
		`initcap' mata: `impobj'.setcolstripe(`setstripe'); ///
				`impobj'.init(`omitchk' `nochol' `wgtadj')
		exit
	}
	if ("`noppcheck'"=="") {
		chk_pp_`cmdname' pp
		local ppinit `pp'
	}
	else {
		local pp 0
		local ppinit .
	}
	if (!`pp' | "`bootstrap'"!="") {
		`initcap' mata: `impobj'.ispp=`ppinit';			///
				`impobj'.setcolstripe(`setstripe');	///
				`impobj'.init(`omitchk' `nochol')
		exit
	}

	if ("`augment'"=="") {
		di as err "{bf:mi impute `method'}: perfect predictor(s) " ///
			  "detected"
		di as err "{p 4 4 2}Variables that perfectly predict an"
		di as err "outcome were detected when {bf:`cmdname'} executed"
		di as err "on the observed data.  First, specify"
		di as err "{bf:mi impute}'s option {bf:noisily} to identify"
		di as err "the problem covariates.  Then either remove"
		di as err "perfect predictors from the model or specify"
		di as err "{bf:mi impute `method'}'s option {bf:augment}"
		di as err "to perform augmented regression; see"
		di as err "{mansection MI miimputeRemarksImputationmodelingTheissueofperfectpredictionduringimputationofcategoricaldata:{it:The issue of perfect prediction during imputation of categorical data}}"
		di as err "in {bf:[MI] mi impute} for details.{p_end}"
		exit 498
	}
	if ("`nocmdlegend'"=="") {
		local diexpnames `expnames'
	}
	local didata "on augmented `didata'"
	qui `augnoisily' u_mi_impute_augreg `command' 	///
			fvstub("__mi_fv") `nofvlegend' 	///
			didata(`didata') expnames(`diexpnames') dropfvvars
	if (e(converged)==0) { 
		di as err "{bf:`cmdname'} regression failed to converge on augmented data"
		exit 430
	}
	`initcap' mata: `impobj'.ispp = 1; ///
			`impobj'.setcolstripe(`setstripe'); ///
			`impobj'.init(`omitchk' `nochol')
end

program chk_pp_logit
	args pp
	if ("`e(rules)'"=="matrix") { 
		//see definitions of rules in _binperfect.ado
		tempname omt
		mata: st_numscalar("`omt'",allof(st_matrix("e(rules)")[.,1],4))
		if el(e(rules),1,1)!=0 & !`omt' {
			c_local `pp' 1
			exit
		}
	}
	c_local `pp' 0
end

program chk_pp_ologit
	args pp
	if (e(N_cd)>0) {
		c_local `pp' 1
		exit
	}
	c_local `pp' 0
end

program chk_pp_mlogit
	args pp
	c_local `pp' 0
	mata: st_local("prnames", invtokens(st_tempname(`e(k_out)')))
	qui predict double `prnames', pr
	forvalues i = 1/`e(k_out)' {
		gettoken pr prnames : prnames
		summ `pr', meanonly
		if (r(min)<1e-7 | (1-r(max))<1e-6) {
			c_local `pp' 1
			continue, break
		}
	}
end

