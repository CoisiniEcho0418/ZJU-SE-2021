*! version 1.3.0  07jul2011
program define db
	version 10.0

	/* ------------------------------------------------------- parse */
	if "`c(console)'" != "" {
		error 8005
	}

	gettoken first : 0, parse(" ,")
	if "`first'"=="" | "`first'"=="," {
		di as err "{p 0 4 2}"
		di as err "invalid syntax{break}"
		di as err "db must be followed by a Stata command name."
		di as err "For instance, you might type:"
		di as err "{p_end}"
		di as err _col(8) ". db use"
		di as err _col(8) ". db regress"
		di as err "{p 4 4 2}"
		di as err "Alternatively, use one of the following Stata menus."
		di as err "File, Statistics, Data management, or Graphics."
		di as err "{p_end}"
		exit 198
	}
		
	syntax anything(name=dbname id="command name") [, 	///
				DEBUG DRYRUN 			///
				MESSAGE(string asis) 		///
				NAME(string asis)]  // undocumented
	
	if `"`name'"' != "" {
		local name __NAME(`name')
	}
	
	local svyIndex = strpos(`"`dbname'"', "svy:")
	local dbname : subinstr local dbname "svy:" ""

	if "`dbname'" == "sem" {
		syntax anything(name=dbname id="command name") [, NOOPT]
		sembuilder
		exit
	}

	local n : word count `dbname' 
	forvalues i = 1/`n' {
		local token : word `i' of `dbname'
		if `i' >= 2  {
			local temp "`temp'_"
		}
		local temp "`temp'`token'"
	}
	local dbname "`temp'"
	
	if `"`message'"' != "" {
		local message __MESSAGE(`message')
	}
	else if `svyIndex' != 0 {
		local message __MESSAGE(-svy-)
		local name __NAME(svy_`dbname')
	}

	/* ---------------------------------------------------- preprocess */

	LocalMap dbname isspecial : `dbname' `svyIndex'
	if !`isspecial' {
		capture which `dbname'.dlg
		if _rc & "`dbname'" != "predict" & "`dbname'" != "estat" {
			capture which `dbname'_dlg.sthlp
			local mycrc = _rc
			if `mycrc' {
				capture which `dbname'_dlg.hlp
				local mycrc = _rc
			}
			if `mycrc' {
				capture unabcmd `dbname'
				if _rc==0 { 
					local dbname "`r(cmd)'"
					local iscmd 1
				}
				else {
					local oldname "`dbname'"
					LocalUnabbreviate dbname : `dbname'
					capture unabcmd `dbname'
					local iscmd = (_rc==0)
				}
			}
		}
	}

	/* --------------------------------------------- determine action */

						// case 0:  special
	if `isspecial' {
		if "`dryrun'"=="" {
			`dbname'
		}
		else {
			di as txt `"-> `dbname'"'
		}
		exit
	}
						// case 1:  it's a .dlg 
	capture which `dbname'.dlg
	if _rc ==0 | "`dbname'" == "predict" | "`dbname'" == "estat" { 
		if "`dryrun'"=="" {
			// _dialog create `dbname', `debug'
			// _dialog run `dbname'_dlg
			_dialog show `dbname', `debug' `message' `name'
		}
		else {
			// di as txt "-> _dialog create `dbname'"
			// di as txt "-> _dialog run `dbname'_dlg"
			di as txt "-> _dialog show `dbname'"
		}
		exit
	}

						// case 2:  it's a _dlg.sthlp 
	capture FindHelpFile hname : `dbname'_dlg
	if _rc==0 { 
		if "`dryrun'"=="" {
			view help `hname'##|_new
			exit
		}
		di as txt "-> help `hname'##|_new"
		exit
	}

	/* -------------------------- not found; determine extended action */

	if "`dryrun'" != "" {
		di as err "neither `dbname'.dlg nor `dbname'_dlg.sthlp found"
		exit 111
	}

						// case 3:  .sthlp file exists
	capture FindHelpFile hname : `dbname'
	if _rc==0 {
		window stopbox rusure ///
		"Dialog for `dbname' not found:" ///
		"Either `dbname' is a programming command or a user-written" ///
		"command for which no dialog box has been written." ///
		"Would you like to see the help for `dbname'?"
		view help `hname'
		exit
	}

						// case 4:  not found
	if `iscmd'==0 {
						// case 4.1 & not command 
		di as err "{p 0 4 2}"
		di as err "`dbname' is not a command name"
		di as err  "or an abbreviation of a command name"
		di as err "{p_end}"
		exit 199
	}

						// case 4.2 & is command 
	di as err "{p 0 4 2}"
	di as err "dialog for `dbname' not found{break}"
	di as err "`dbname' is either a programming command or"
	di as err "a user-written command for which there is no dialog."
	di as err "No one has written a help file for it, either."
	di as err "{p_end}"
	exit 111
end

program FindHelpFile
	args d colon name

	capture which `name'.sthlp
	local mycrc = _rc
	if `mycrc' {
		capture which `name'.hlp
		local mycrc = _rc
	}
	if `mycrc'==0 {
		c_local `d' "`name'"
		exit
	}
	capture _findhlpalias `name'
	if _rc==0 {
		local alias "`r(name)'"
		capture which `alias'.sthlp
		local mycrc = _rc
		if `mycrc' {
			capture which `alias'.hlp
			local mycrc = _rc
		}
		if `mycrc'==0 {
			c_local `d' "`alias'"
			exit
		}
	}
	exit 111
end

program LocalUnabbreviate 
	args d colon cmd

	c_local `d' "`cmd'"
	local l = length("`cmd'")

	if "`cmd'" == substr("graph", 1, max(`l',2)) {
		c_local `d' "graph"
		exit
	}
end

program LocalMap
	args d sp colon cmd svyIndex

	c_local `sp' 0

	if "`cmd'" == "avplots" {
		local cmd "avplot"
	}
	else if "`cmd'" == "an" | "`cmd'" == "ano" | "`cmd'" == "anov" {
		local cmd "anova"
	}
	else if "`cmd'" == "ap" | "`cmd'" == "app" 			///
		| "`cmd'" == "appe" | "`cmd'" == "appen" {
		local cmd "append"
	}
	else if "`cmd'" == "biprobit" {
		if `svyIndex' != 0 {
			local cmd "svy_biprobit"
		}
	}
	else if "`cmd'" == "clo" | "`cmd'" == "clog" | "`cmd'" == "clogi" {
		local cmd "clogit"
	}
	else if "`cmd'" == "cnr" | "`cmd'" == "cnre" {
		local cmd "cnreg"
	}
	else if "`cmd'" == "constraint_define" {
		local cmd "cons_define"
	}
	else if "`cmd'" == "constraint_drop" {
		local cmd "cons_drop"
	}
	else if "`cmd'" == "d" | "`cmd'" == "de" | "`cmd'" == "des" 	///
		| "`cmd'" == "desc" | "`cmd'" == "descr" 		///
		| "`cmd'" == "descri" | "`cmd'" == "describ"		///
	{
		local cmd "describe"
	}
	else if "`cmd'" == "discrim_knn" | "`cmd'" == "discrim_lda"	///
		| "`cmd'" == "discrim_logistic" | "`cmd'" == "discrim_qda" {
		local cmd "discrim"
	}
	else if "`cmd'" == "est" {
		local cmd "estimates"
	}
	else if "`cmd'" == "esti" {
		local cmd "estimates"
	}
	else if "`cmd'" == "fac" | "`cmd'" == "fact" | "`cmd'" == "facto" {
		local cmd "factor"
	}
	else if "`cmd'" == "gr" {
		local cmd "graph"
	}
	else if "`cmd'" == "bar" {
		local cmd "graph_bar"
	}
	else if "`cmd'" == "dot" {
		local cmd "graph_dot"
	}
	else if "`cmd'" == "graph_dot_data" {
		local cmd "dot_data"
	}
	else if "`cmd'" == "pie" {
		local cmd "graph_pie"
	}
	else if "`cmd'" == "box" {
		local cmd "graph_box"
	}
	else if "`cmd'" == "graph_twoway" {
		local cmd "twoway"
	}
	else if "`cmd'" == "heckman" {
		if `svyIndex' != 0 {
			local cmd "heckman_ml"
		}
	}
	else if "`cmd'" == "hotel" {
		local cmd "hotelling"
	}
	else if "`cmd'" == "icd9p" {
		local cmd "icd9"
	}
	else if "`cmd'" == "keep" {
		local cmd "drop"
	}
	else if "`cmd'" == "la" | "`cmd'" == "lab" | "`cmd'" == "labe" {
		local cmd "label"
	}	
	else if "`cmd'" == "logi" {
		local cmd "logit"
	}	
	else if "`cmd'" == "note" | "`cmd'" == "notes" {
		/* the internal notes dialog is intentionally intercepted
		   and the smcl router will be used. */
		local cmd "notes"
	}
	else if "`cmd'" == "prtesti" {
		local cmd "prtest"
	}
	else if "`cmd'" == "margin" {
		local cmd "margins"
	}
	else if "`cmd'" == "mer" | "`cmd'" == "merg" {
		local cmd "merge"
	}
	else if "`cmd'" == "mlog" | "`cmd'" == "mlogi" {
		local cmd "mlogit"
	}
	else if "`cmd'" == "move" {
		local cmd "order"
	}
	else if "`cmd'" == "olo" | "`cmd'" == "olog" | "`cmd'" == "ologi" {
		local cmd "ologit"
	}
	else if "`cmd'" == "opr" | "`cmd'" == "opro" | 		///
		"`cmd'" == "oprob"  || "`cmd'" == "oprobi"  {
		local cmd "oprobit"
	}
	else if "`cmd'" == "prob" | "`cmd'" == "probi" {
		local cmd "probit"
	}	
	else if "`cmd'" == "reg" | "`cmd'" == "regr" | 		///
		"`cmd'" == "regre" | "`cmd'" == "regres"	{
		local cmd "regress"
	}
	else if "`cmd'" == "renpfix" {
		local cmd "rename"
	}
	else if "`cmd'" == "rot" | "`cmd'" == "rota" | "`cmd'" == "rotat" {
		local cmd "rotate"
	}
	else if "`cmd'" == "scree" {
		local cmd "screeplot"
	}
	else if "`cmd'" == "svydes" {
		local cmd "svydescribe"
	}
	else if "`cmd'" == "sdtesti" {
		local cmd "sdtest"
	}
	else if "`cmd'" == "stcrr" | "`cmd'" == "stcrre" {
		local cmd "stcrreg"
	}
	else if "`cmd'" == "te" {
		local cmd "test"
	}
	else if "`cmd'" == "tes" {
		local cmd "test"
	}
	else if "`cmd'" == "tsrline" {
		local cmd "tsline"
	}	
	else if "`cmd'" == "tis" {
		local cmd "tsset"
	}
	else if "`cmd'" == "tob" | "`cmd'" == "tobi" {
		local cmd "tobit"
	}
	else if "`cmd'" == "treatreg" {
		if `svyIndex' != 0 {
			local cmd "treatreg_ml"
		}
	}
	else if "`cmd'" == "tset" {
		local cmd "tsset"
	}
	else if "`cmd'" == "ttesti" {
		local cmd "ttest"
	}
	else if "`cmd'" == "tw" {
		local cmd "twoway"
	}
	else if "`cmd'" == "two" {
		local cmd "twoway"
	}
	else if "`cmd'" == "yx" {
		local cmd "twoway"
	}
	else if "`cmd'" == "scatter" {
		local cmd "twoway"
	}
	else if "`cmd'" == "line" {
		local cmd "twoway"
	}
	else if "`cmd'" == "stpow_cox" {
		local cmd "stpower_cox"
	}
	else if "`cmd'" == "stpow_exp" {
		local cmd "stpower_exponential"
	}
	else if "`cmd'" == "stpow_expon" {
		local cmd "stpower_exponential"
	}
	else if "`cmd'" == "stpow_exponential" {
		local cmd "stpower_exponential"
	}
	else if "`cmd'" == "stpower_exp" {
		local cmd "stpower_exponential"
	}
	else if "`cmd'" == "stpower_expon" {
		local cmd "stpower_exponential"
	}
	else if "`cmd'" == "stpow_log" {
		local cmd "stpower_logrank"
	}
	else if "`cmd'" == "stpow_logrank" {
		local cmd "stpower_logrank"
	}
	else if "`cmd'" == "stpower_log" {
		local cmd "stpower_logrank"
	}
	else if "`cmd'" == "ado" {
		local cmd "view help net_mnu"
		c_local `sp' 1
	}
	else if "`cmd'" == "browse" {
		local cmd "browse"
		c_local `sp' 1
	}
	else if "`cmd'" == "doedit" {
		local cmd "doedit"
		c_local `sp' 1
	}
	else if "`cmd'" == "edit" {
		local cmd "edit"
		c_local `sp' 1
	}
	else if "`cmd'" == "findit" {
		local cmd "view search_d"
		c_local `sp' 1
	}
	else if "`cmd'" == "help" {
		local cmd "view help contents"
		c_local `sp' 1
	}
	else if "`cmd'" == "net" {
		local cmd "view help net_mnu"
		c_local `sp' 1
	}
	else if "`cmd'" == "news" {
		local cmd "view news"
		c_local `sp' 1
	}
	else if "`cmd'" == "search" {
		local cmd "view search_d"
		c_local `sp' 1
	}
	else if "`cmd'" == "view" {
		local cmd "view"
		c_local `sp' 1
	}
/* route special internal dailogs which do not match a real command name */
	else if "`cmd'" == "labeldefine" {
		/* deprecated, but still works */
		local cmd "view dialog `cmd'_dlg"
		c_local `sp' 1
	}
	else if "`cmd'" == "label_manage" {
		local cmd "view dialog `cmd'_dlg"
		c_local `sp' 1
	}
	else if "`cmd'" == "import_excel" {
		local cmd "view dialog `cmd'_dlg"
		c_local `sp' 1
	}
/**/
	else {
		local cpy `cmd'
		capture unabcmd `cpy'
		if !_rc {
			capture which `cpy'_dlg
			if !_rc {
				local cmd `cpy'_dlg
				c_local `sp' 1
			}
		}
	}

	c_local `d' "`cmd'"
end
