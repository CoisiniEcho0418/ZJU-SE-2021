*! version 1.0.0  04jul2011
program u_mi_impute, rclass
	local version : di "version " string(_caller()) ":"
	version 12
	syntax , impobj(string) method(string)	/// 
		[ 				///
			lhs(string asis)	/// //internal
			ADD(string)		///
			REPLACE			///
			RSEED(string)		///
			NOIsily			///
			DOTS			///
			NOLEGend		///
			DOUBLE			///
			FORCE			///
			/* no imp. performed */	///
			dryrun			/// //monotone, chained
			CHAINONLY		/// //chained
			CHAINDOTS		/// //chained
			MCMCONLY		/// //mvn
			MCMCDOTS		/// //mvn
			EMONLY			/// //mvn
			EMONLY1(string)		/// //mvn
			SHOWCOMMAND		/// //undoc., ignored with mvn
			NOBYREPORT		/// //internal
			BYERROROK		/// //internal
			by(varname)		/// //internal
			ngroup(integer 1)	/// //internal
			*			/// //<method> opts.
		]
	local Impobj `impobj'		// main object
	local impobj `impobj'.Imp	// group-specific objects
	if ("`nobyreport'"!="") {
		local diby qui
	}
	if ("`double'"=="") {
		local recasttype float
	}
	else {
		local recasttype double
	}
	if ("`byerrorok'"!="" & "`chaindots'`mcmcdots'"!="") {
		di as txt "note: option {bf:`chaindots'`mcmcdots'} ignored " ///
		          "with {bf:by(, nostop)}"
	}

	// set seed
	if ("`rseed'"=="") { 
		local rseed `c(seed)'
	}
	`version' set seed `rseed'

	//collect <method> opts
	local methodopts
	if ("`method'"=="chained") {
		if ("`chaindots'"!="") {
			local dots
		}
		local methodopts `methodopts' `dots' `chaindots' `chainonly'
		local methodopts `methodopts' `force' `nolegend' `showcommand'
		local methodopts `methodopts' `dryrun' `recasttype'
	}
	else if ("`method'"=="monotone") {
		local methodopts `methodopts' `force' `nolegend' `showcommand'
		local methodopts `methodopts' `dryrun' `recasttype'
	}
	else if ("`method'"=="mvn") {
		if (`"`emonly1'"'!="") {
			local emonly emonly
			local emonly1 emonly1(`emonly1')
		}
		local methodopts `methodopts' `emonly' `mcmconly' `emonly1'
		local methodopts `methodopts' `dots' `force' `recasttype'
		local methodopts `methodopts' `mcmcdots'
	}
	else {
		local methodopts `methodopts' `nolegend' `showcommand'
		if ("`method'"=="intreg") {
			local methodopts `methodopts' `recasttype'
		}
	}
	local methodopts `methodopts' `noisily' `options'

	//check add(), -replace- if imputing missing values
	if "`dryrun'`emonly'`mcmconly'`chainonly'"=="" {
		local toimpute 1
	}
	else {
		local toimpute 0
	}
	if `toimpute' { 
		u_mi_impute_chk_addreplace M_add M_update : "`add'" "`replace'"
	}
	else {
		local M_add 0
		local M_update 0
	}

	// --- parse <method> begin
	local impobjname `impobj'
	local ngrouptotal `ngroup'
	if ("`by'"=="") {
		`version' u_mi_impute_cmd_`method'_parse `lhs', 	///
				impobj(`impobj') `methodopts'
		local cmdlineimpute1 cmdlineimpute(`s(cmdlineimpute)')
		local cmdlineinit1 cmdlineinit(`s(cmdlineinit)')
		local nomiss `s(nomiss)'
		if ("`noisily'`s(noisily)'"!="") {
			local noisily_gl noisily
			local noisily1 noisily
		}
		local ivars1 `s(ivarsinc)'
		local ivarsinc `s(ivarsinc)'
		// all imp. variables in the orig. order
		local ivars	`s(ivars)' 
		// all univ. imp. methods in the orig.
		// order for monotone and chained
		local methods   `s(uvmethods)'	
		local xeqmethod `s(xeqmethod)'
		local addedvars `s(addedvars)'
		local expnames	`s(expnames)'
		if ("`s(dots)'"=="nodots" | "`dots'`s(dots)'"=="") {
			local nodots nodots
		}
		local groupnum 1
	}
	else {
		// store by() labels in Stata macro 'bylabel'
		mata: `Impobj'.storebylabels("bylabel")

		if (`ngrouptotal'==1) {
			di as txt "note: {bf:by()} identifies only one group"
		}
		else {
			`diby' di
			`diby' di as txt ///
				"{bf:Performing setup for each by() group:}"
		}
		local knodots 0
		local knomiss 0
		local ivarsinc
		local addedvars
		local expnames
		local first 1
		forvalues kgroup=1/`ngrouptotal' {
			if (`ngrouptotal'>1) {
				`diby' di
				`diby' di as txt `"-> `bylabel`kgroup''"'
			}
			local impobji `impobjname'[`kgroup']
			local ifgroup `by'==`kgroup'
			cap noi `diby' u_mi_impute_cmd_`method'_parse `lhs', ///
				impobj(`impobji') `methodopts' `ivarexists' ///
				ifgroup(`ifgroup')
			local rc = _rc
			if (`rc') {
				if ("`byerrorok'"=="") {
					exit `rc'
				} 
				di as txt "{p 0 0 2}"
	                        di as txt "error occurred during the setup"
				di as txt "of imputation model in group"
        	                di as txt `"'`bylabel`kgroup'''{p_end}"'
				local ++knomiss
				local ++knodots
				cap drop `s(expnames)' `s(addedvars)'
				continue
			}
			if ("`s(nomiss)'"!="") {
				local ++knomiss
				//drop created expr. vars if no missing
				cap drop `s(expnames)'
			}
			else {
				local groupnum `groupnum' `kgroup'
				local expnames	`expnames' `s(expnames)'
			}
			if (inlist("`method'","intreg","chained","monotone")) {
				local ivarexists ivarexists
			}
			local cmdlineimpute`kgroup' cmdlineimpute(`s(cmdlineimpute)')
			local cmdlineinit`kgroup' cmdlineinit(`s(cmdlineinit)')
			local ivars`kgroup' `s(ivarsinc)'
			local ivarsinc `ivarsinc' `s(ivarsinc)'
			local addedvars `addedvars' `s(addedvars)'
			if (`first') {
				// all imp. variables in the orig. order
				local ivars	`s(ivars)' 
				// all univ. imp. methods in the orig.
				// order for monotone and chained
				local methods   `s(uvmethods)'	
				local xeqmethod `s(xeqmethod)'
				local first 0
			}	
			if ("`s(dots)'"=="nodots" | "`dots'`s(dots)'"=="") {
				local ++knodots
			}
			if ("`noisily'`s(noisily)'"!="") {
				local noisily_gl noisily
				local noisily`kgroup' noisily
			}
		}
		if `knomiss'==`ngrouptotal' {
			local nomiss nomiss
		}
		if `knodots'==`ngrouptotal' {
			local nodots nodots
		}
		local ivarsinc  : list uniq ivarsinc
		local addedvars : list uniq addedvars
		local expnames  : list uniq expnames
	}
	local noisily `noisily_gl'
	local addedvars `addedvars' `expnames' `by' // variables to drop
	local initinaloop `s(initinaloop)'
	// --- parse <method> end

	// no imputation needed, stop
	if ("`nomiss'"!="" | (!`toimpute' & "`chainonly'"=="")) { 
		mata:	`Impobj'.initM(`_dta[_mi_M]', 0, 0); 		///
			`Impobj'.setvariables("`groupnum'", "`ivars'", 	///
				    	      "`methods'");		///
			`Impobj'.rresults("`rseed'")
		ret add
		if ("`emonly'`mcmconly'"!="") {
			di
			di as txt "Note: no imputation performed."
		}
		if ("`nomiss'"!="" & "`method'"=="intreg") {
			di
			di as txt "Note: imputation variable is not created."
		}
		mata: st_global("s(stop)","stop")
		local exitrc 0 
		if ("`_dta[_mi_style]'"=="flongsep") {
			//error out, so that flongsep data are restored
			local exitrc 1 
		}
		exit `exitrc'
	}

cap noi { // begin cap noi block

	// add imputations
	local M `_dta[_mi_M]'
	local m_start = `M'-`M_update'+1
	local M = `M'+`M_add'
	local m_end = `M'
	if (`M_add'>0) {
		qui mi set M += `M_add'
	}
	mata: `Impobj'.initM(`M', `M_add', `M_update')
	if ("`chainonly'"!="") {
		local m_start 0
		local m_end 0
	}

	// prepare data for imputation
	mac drop MI_lstub* MI_dstub*
	u_mi_impute_prepimps MI_lstub MI_dstub : ///
				"`ivarsinc'" "`addedvars'" "`m_start'"

	// --- begin imputation
	if (`ngrouptotal'>1) {
		`diby' di
	}
	if ((("`noisily'`dots'"!="" |"`method'"=="mvn" |  ///
	      "`method'"=="chained") & `ngrouptotal'>1) | "`byerrorok'"!="") {
		`diby' di as txt ///
			"{bf:Performing imputation for each by() group:}"
	}
	if ("`byerrorok'"=="" | "`nodots'"=="") {
		local capnoi capture noisily
	}
	foreach kgroup in `groupnum' { //only on groups with incomplete ivars
		local bylabk		`bylabel`kgroup''
		local noik		`noisily`kgroup''
		local impobjk		`impobjname'[`kgroup']
		local cmdlineinit	`cmdlineinit`kgroup''
		local cmdlineimpute	`cmdlineimpute`kgroup''
		local ivarsk		`ivars`kgroup''
		local methodspec , xeqmethod(`xeqmethod') ivars(`ivarsk') ///
			   mstart(`m_start') mend(`m_end') 		  ///
			   `force' `nodots' `initinaloop'		  ///
			   impobj(`impobjk') `cmdlineinit' `cmdlineimpute'
		if ("`capnoi'"=="") {
			local capnoi capture `noik'
		}
		if (("`noisily'`dots'"!="" | "`method'"=="mvn" | ///
			"`method'"=="chained") /// 
		    & `ngrouptotal'>1) {
			di
			di as txt `"-> `bylabk'"'
		}
		global MI_kgroup `kgroup' // used by chained and monotone
		`capnoi' u_mi_impute_xeq `methodspec'
		global MI_kgroup
		if _rc & "`byerrorok'"=="" {
			if (`"`bylabk'"'!="") {
                                di as err `" -- above applies to `bylabk'"'
                        }
			exit _rc
		}
		else if _rc {
			if (`"`bylabk'"'!="" & "`diby'`noisily'"=="" & ///
				"`nodots'"!="") {
				di
				di as txt "{p 0 0 2}"
	                        di as txt "error occurred during imputation"
        	                di as txt "of {bf:`ivarsk'}{p_end}"
                	        di as txt `" -- above applies to `bylabk'"'
                        }
		}
	}
	// --- end imputation

	if ("`chainonly'"!="") { // stop if no imputation
		mata:	`Impobj'.initM(`_dta[_mi_M]', 0, 0); 		///
			`Impobj'.setvariables("`groupnum'", "`ivars'", 	///
				    	      "`methods'"); 		///
			`Impobj'.rresults("`rseed'")
		ret add
		di
		di as txt "Note: no imputation performed."
		mata: st_global("s(stop)","stop")
		local exitrc 0 
		if ("`_dta[_mi_style]'"=="flongsep") {
			//error out, so that flongsep data are restored
			local exitrc 1 
		}
		exit `exitrc'
	}

	// save and display results
	mata:	`Impobj'.setvariables("`groupnum'", "`ivars'", 	///
				      "`methods'");		///
		`Impobj'.rresults("`rseed'"); 			///
		`Impobj'.print()
	ret add

} // end cap noi block
	local rc = _rc
	u_mi_impute_cleanup "`recasttype'" "`ivarsinc'" "`addedvars'" ///
			    "__mi_fv" "MI_lstub" "MI_dstub" "`m_start'"
	exit `rc'
end

/* checks options -add()- and -replace- 
   Returns:
	 # of added imputations in `M_add'
	 # of updated imputations in `M_update'
*/
program u_mi_impute_chk_addreplace
	args M_add M_update colon add replace

	local M `_dta[_mi_M]'
	if (`M') { // if M>0, -replace- or -add()- must be specified
		if (`"`add'`replace'"'=="") {
			di as err "{bf:mi impute}: imputations exist" 
			di as err "{p 4 4 2}{bf:`M'} " 			///
			   plural(`M',"imputation") 			///
			   " found; use {bf:replace} to replace "	///
			   "existing and/or {bf:add()} "	///
			   "to add new imputations.  Before adding "	///
			   "new imputations, verify that the same "	///
			   "imputation model is specified.{p_end}"
			exit 198
		}
	}
	else if (`"`add'"'=="") {
		di as err "option {bf:add()} is required "	///
			  "when no imputations exist"
		exit 198
	}
	// -add()-
	if (`"`add'"'!="") {
		cap confirm integer number `add'
		if (_rc) {
			di as err "{bf:add()} must be a positive integer"
			exit 198
		}
		if (`add'<=0) {
			di as err "{bf:add()} must be a positive integer"
			exit 198
		}
		local M_total = `M' + `add'
		if (`M_total'>1000) {
			di as err "{bf:add(`add')} results in {it:M} = " ///
		  		  "`M_total' exceeding the limit of 1000"
			di as err "{p 4 2 0}{bf:add()} must be between"
			di as err "1 and `=1000-`M'', inclusive{p_end}"
			exit 198
		}
	}
	if ("`add'"=="") {
		local add = 0
	}
	if ("`replace'"!="") {
		local M_up = `M'
	}
	else {
		local M_up = 0
	}
	c_local `M_add' `add'
	c_local `M_update' `M_up'
end

// recasts imputation variables, sorts data, and populates new variables in
// -flongsep-
program u_mi_impute_prepimps
	args lstub dstub colon ivars addedvars mstart

	local style `_dta[_mi_style]'

	if ("`style'"!="flongsep") {
		if ("`style'"=="wide") {
			u_mi_getwidevars "sysvars" : "`ivars'" "`mstart'"
			local ivars `ivars' `sysvars'
		}
		else {
			sort _mi_m _mi_id
		}
		u_mi_get_longdoublevars longstub dblstub : "`ivars'"
		global `lstub'0 `longstub'
		global `dstub'0 `dblstub'
		qui recast double `ivars'
		exit	
	}

	local fname	"`_dta[_mi_name]'"
	local M		`_dta[_mi_M]'
	qui {
		u_mi_get_longdoublevars longstub dblstub : "`ivars'"
		global `lstub'0 `longstub'
		global `dstub'0 `dblstub'
		qui recast double `ivars'
		sort _mi_id
		save, replace

		if (`mstart'==0) exit

		if ("`addedvars'"!="") {
			tempfile toadd
			keep _mi_id `addedvars'
			save `"`toadd'"'
		}
	}
	qui forvalues i=`mstart'/`M' {
		use _`i'_`fname'
		u_mi_get_longdoublevars longstub dblstub : "`ivars'"
		global `lstub'`i' `longstub'
		global `dstub'`i' `dblstub'
		qui recast double `ivars'
		sort _mi_id
		if ("`addedvars'"!="") {
			merge 1:1 _mi_id using `"`toadd'"', nogen nonotes
		}
		save, replace
	}
	qui use `fname'
end

// compresses imputation variables, removes added variables
program u_mi_impute_cleanup
	args type ivars addedvars fvstub lstub dstub mstart

	local style `_dta[_mi_style]'
	if ("`style'"!="flongsep") {
		if ("`style'"=="wide") {
			u_mi_getwidevars "sysvars" : "`ivars'" "`mstart'"
			local ivars `ivars' `sysvars'
		}
		cap u_mi_recast_vars "`type'" "`ivars'" ///
				     "${`lstub'0}" "${`dstub'0}"
		cap unab fvvars : `fvstub'*
		local addedvars `addedvars' `fvvars'
		if ("`addedvars'"!="") {
			drop `addedvars'
		}
		exit	
	}

	local fname	"`_dta[_mi_name]'"
	local M		`_dta[_mi_M]'
	qui {
		cap u_mi_recast_vars "`type'" "`ivars'" ///
				     "${`lstub'0}" "${`dstub'0}"
		cap unab fvvars : `fvstub'*
		local addedvars `addedvars' `fvvars'
		if ("`addedvars'"!="") {
			drop `addedvars'
		}
		save, replace
	}

	if (`mstart'==0) exit

	qui forvalues i=`mstart'/`M' {
		use _`i'_`fname'
		cap u_mi_recast_vars "`type'" "`ivars'" ///
				     "${`lstub'`i'}" "${`dstub'`i'}"
		cap unab fvvars : `fvstub'*
		local addedvars `addedvars' `fvvars'
		cap drop `addedvars'
		save, replace
	}
	qui use `fname'
end

program u_mi_get_longdoublevars
	args longvars doublevars colon vars

	qui ds `vars', has(type double)
	c_local `doublevars' "`r(varlist)'"
	qui ds `vars', has(type long)
	c_local `longvars' "`r(varlist)'"
end

program u_mi_recast_vars
	args type vars longvars dblvars

	local allivars `vars' `longvars' `doublevars'
	if ("`allivars'"=="") exit

	if ("`type'"=="double") {
		qui compress `allivars'
		exit
	}
	local vars : list vars - longvars
	local vars : list vars - dblvars
	if ("`vars'"!="") {
		qui recast float `vars', force
	}
	qui compress `allivars'
end
