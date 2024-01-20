*! version 1.6.0  10may2011
program estimates
	version 8

	capture noisily nobreak {
		global T_EST_VERSION = string(_caller())
		break Work `0'
	}
	local rc = _rc
	global T_EST_VERSION
	exit `rc'
end


program Work
	gettoken key 0 : 0, parse(" ,:")
	local lkey = length(`"`key'"')

// valid subcommands

	local changeab 6
	local tabab 3
	local forab 3
	local statsab 4
	local dirab 3
	if $T_EST_VERSION < 10 {
		local changeab 2
		local tabab 1
		local forab 1
		local statsab 2
		local dirab 1
	}
/*
	if $T_EST_VERSION < 11 {
*/
		local change change
/*
	}
*/
	// else we will no longer match 'change'

	if `"`key'"' == "" {
		if "`e(cmd)'" != "" {
			Replay "."
		}
	}
	else if `"`key'"' == substr("query", 1, `lkey') {
		Query `0'
	}
	else if `"`key'"' == substr("store", 1, max(3,`lkey')) {
		Store `0'
	}
	else if `"`key'"' == substr("restore", 1, max(3,`lkey')) {
		Restore `0'
	}
	else if `"`key'"' == substr("`change'", 1, max(`changeab',`lkey')) {
		Change `0'
	}
	else if `"`key'"' == substr("for", 1, max(`forab', `lkey')) {
		For `0'
	}
	else if `"`key'"' == substr("dir", 1, max(`dirab', `lkey')) {
		Dir `0'
	}
	else if `"`key'"' == substr("stats",1,max(`statsab',max(2,`lkey'))) {
		Stats `0'
	}
	else if `"`key'"' == substr("table", 1, max(`tabab', `lkey')) {
		// external
		est_table`0'
	}
	else if `"`key'"' == substr("replay", 1, `lkey') {
		Replay `0'
	}
	else if `"`key'"' == "drop" {
		Drop `0'
	}
	else if `"`key'"' == substr("notes", 1, max(4,`lkey')) {
		estimates_notes `0'
	}
	else if `"`key'"' == "title" {
		Title `0'
	}
	else if `"`key'"' == "clear" {
		Clear `0'
	}
	else if `"`key'"' == "esample" {
		estimates_sample `0'
	}
	else if `"`key'"' == substr("describe", 1, max(3,`lkey')) {
		Describe `0'
	}
	else if `"`key'"' == "save" {
		EstSave `0'
	}
	else if `"`key'"' == "use" {
		EstUse `0'
	}

// subcommands of estimation version <= 7

	else if `"`key'"' == substr("local", 1, max(3,`lkey')) {
		SubcmdMoved "local" "ereturn"
	}
	else if `"`key'"' == substr("scalar", 1, max(3,`lkey')) {
		SubcmdMoved "scalar" "ereturn"
	}
	else if `"`key'"' == substr("matrix", 1, max(3,`lkey')) {
		SubcmdMoved "matrix" "ereturn"
	}
	else if `"`key'"' == "post" {
		SubcmdMoved "post" "ereturn"
	}
	else if `"`key'"' == "repost" {
		SubcmdMoved "repost" "ereturn"
	}
	else if `"`key'"' == substr("display", 1, max(2,`lkey')) {
		SubcmdMoved "display" "ereturn"
	}

	else if `"`key'"' == substr("hold", 1, `lkey') {
		SubcmdMoved "hold" " _estimates"
	}
	else if `"`key'"' == substr("unhold", 1, `lkey') {
		SubcmdMoved "unhold" "_estimates"
	}
	else if `"`key'"' == substr("list", 1, max(2,`lkey')) {
		SubcmdMoved "list" "ereturn"
	}

// error

	else {
		dis as err `"estimates: unknown subcommand "`key'""'
		exit 198
	}
end

// ============================================================================
// subcommands ("methods")
// ============================================================================

/*
	subcmd query
*/
program define Query
	syntax

	local cmd `"`e(cmd)'"'
	if ! `:length local cmd' {
		di as txt "(no estimation results)"
	}
	else {
		if `"`e(cmd2)'"' != "" {
			local cmd `"`e(cmd2)'"'
		}
		local msg1 "active results produced by `cmd'"
		local name `e(_estimates_name)'
		if `:length local name' {
			local cl  "{stata estimates replay `name':`name'}"
			local msg2 "; also stored as `cl'"
		}
		else	local msg2 "; not yet stored"
		di as txt `"(`msg1'`msg2')"'
	}
end


/*
	subcmd change name, title() scorevars()
*/
program define Change, eclass
	syntax [anything] [, TItle(passthru) SCorevars(passthru)]

	est_expand `"`anything'"' , max(1) default(.)
	local name `r(names)'

	if `"`title'`scorevars'"' == "" {
		// nothing to do
		exit
	}

	if !inlist(`"`name'"', ".", `"`e(_estimates_name)'"') {
		// change fields in non-active estimation result
		tempname hcurrent esample
		_est hold `hcurrent', restore nullok estsystem
		nobreak {
			est_unhold `name' `esample'

			capture noisily {
				CheckName `name'
				ChangeFields, `title' `scorevars'
			}
			local rc = _rc

			est_hold `name' `esample'
		}
		if `rc' {
			exit `rc'
		}
	}
	else if "`name'" == `"`e(_estimates_name)'"' {
		// current results already saved; resave!
		ChangeFields, `title' `scorevars'
		capt _est drop `name'
		capt _est hold `name' , copy estimates varname(_est_`name')
	}
	else {
		// now name==.
		// not yet saved, just set fields
		ChangeFields, `title' `scorevars'
	}
end


/*
	subcmd restore name [, noheader drop ]
*/
program define Restore
	syntax [anything] [, noHeader DROP ]

	est_expand `"`anything'"' , min(1) max(1)
	local name `r(names)'

	// NOTE: "`name'" == "." means that the user supplied "." and the
	// currently active estimation results are not stored.

	if ! inlist("`name'", ".", `"`e(_estimates_name)'"') {
		// activate -name-
		if "`drop'" != "" {
			_est unhold `name'
			ClearFields
		}
		else {
			nobreak {
				tempvar esample
				est_unhold `name' `esample'
				est_hold `name' `esample' "copy"
			}
		}
	}
	if "`header'" == "" {
		local cl "{stata estimates replay `name':`name'}"
		di as txt "(results `cl' are active now)"
	}
end


/*
	subcmd store name [, title(str) nocopy ]
*/
program define Store, eclass
	if "`e(cmd)'" == "" {
		di as err "last estimation results not found, nothing to store"
		exit 301
	}

	syntax anything(id=name name=name) 	///
		[, 				///
		Title(str) 			///
		noCOpy  			///
		NOVARNAME] 			// undoc

	confirm name `name'
	if `:word count `name'' > 1 {
		di as err "single name expected"
		exit 198
	}
	confirm name _est_`name'

	// save e(_estimates_*) values to reset if storing fails
	local loct  `"`e(estimates_title)'"'
	local locn  `"`e(_estimates_name)'"'

	// _estimates drop does *not* overwrite, -estimates- does..
	capture _est drop `name'
	capture drop _est_`name'

	if `:length local title' {
		TitleUpdate `title'
	}
	ereturn local _estimates_name  `name'

	if "`copy'" == "" {
		local copy_option copy
	}
	capt _est hold `name', estimates `copy_option' varname(_est_`name')
	if (`"`novarname'"' == "novarname") {
		capture drop _est_`name'
	}

	local rc = _rc
	if `rc'==0 {
		exit
	}

	// if we come here, storing has failed
	// undo sets locals and display error message
	TitleUpdate `loct'
	ereturn local  _estimates_name  `"`name'"'
	if `rc' == 1000 {
		TooManyModels
		exit 1000
	}
	error `rc'
end

program Title
	if "`e(cmd)'" == "" {
		di as err "last estimates not found"
		exit 301
	}

	gettoken COLON title : 0, parse(":")
	
	if `"`COLON'"' == ":" {
		TitleUpdate `title'
	}
	else {
		syntax
		local title `"`e(estimates_title)'"'
		if `:length local title' {
			di as txt `"{p 0 7 2}`title'{p_end}"'
		}
	}
end

program TitleUpdate, eclass
	ereturn local estimates_title `"`0'"'
end

program Describe
	syntax [name] [using/] [, *]

	if `:length local namelist' & `:length local using' {
		di as err "name not allowed with using"
		exit 101
	}


	if `"`using'"' != "" {
		DescribeUsing using `"`using'"', `options'
		exit
	}

	if `:length local namelist' {
		est_expand `"`namelist'"' , max(1)
		local name `r(names)'
	}

	nobreak {

		capture noisily break {

		if !inlist("`name'", "", ".") {
			tempname hcurrent
			_est hold `hcurrent', restore nullok estsystem
			tempname esample
			est_unhold `name' `esample'
		}

			DescribeActive "" ""

		} // capture noisily break

		local rc = c(rc)

		if `:length local esample' {
			est_hold `name' `esample'
		}

	} // nobreak

	exit `rc'
end

program DescribeUsing, rclass
	syntax [using/] [, NUMber(numlist integer max=1 >0)]

	if "`number'" == "" {
		local number 1
	}

	mata: _st_estimatesdescusing(`"`using'"', `number')
end

program DescribeActive, rclass
	args who when

	local title `"`e(estimates_title)'"'
	local cmdline `"`e(cmdline)'"'

	if `:length local title' {
		local q1 `" "{res}"'
		local q2 `"{txt}""'
		local c ","
	}

	if `:length local who' {
		local savedby `" saved by `who' on "' %tc "{res}`when'{txt}"
		local c ","
	}
	di
	di as txt "{p 2 2 2}"
	di as txt `"Estimation results`q1'`title'`q2'`savedby'`c' produced by"'
	di as txt "{p_end}"
	di
	di as txt "{p 5 7 2}{res}. `cmdline'{txt}{p_end}"
	if !inlist("`e(estimates_note0)'", "", "0") {
		di _n "  Notes:"
		estimates_notes
	}

	if `:length local who' {
		return local who `"`who'"'
		return scalar datetime = `when'
	}
	return local title `"`title'"'
	return local cmdline `"`cmdline'"'
end

program EstSave
	if "`e(cmd)'" == "" {
		di as err "last estimates not found"
		exit 301
	}
	capture noi EstSave_u `0'
	nobreak {
		local rc = _rc
		if `rc' {
			$estimates_save_cleanup
		}
		global estimates_save_cleanup
	}
	exit `rc'
end

program EstSave_u
	syntax anything(id="filename") [, REPLACE APPEND]

	gettoken filenm nothing : anything

	if `"`nothing'"' != `""' {
		di as error `"invalid syntax, `nothing' not allowed"'
		exit 198
	}

	if "`replace'" == "" {
		local replace 0
	}
	else {
		local replace 1
	}

	if "`append'" != "" {
		local replace 2
	}

	mata: _st_estimatessave(`"`filenm'"', `replace')
end

program EstUse, eclass
	version 10

	capture noi EstUse_u `0'
	nobreak {
		local rc = _rc
		if `rc' {
			$estimates_use_cleanup
		}
		global estimates_use_cleanup
	}
	exit `rc'
end

program EstUse_u, eclass
	syntax anything(id="filename") [, NUMber(numlist integer max=1 >0)]

	gettoken filenm nothing : anything

	if `"`nothing'"' != `""' {
		di as error `"invalid syntax, `nothing' not allowed"'
		exit 198
	}

	if "`number'" == "" {
		local number 1
	}

	ereturn clear
	global estimates_use_cleanup `"ereturn clear"'
	mata: _st_estimatesuse(`"`filenm'"', `number')
	if `"`e(cmd2)'"' != "" {
		local cmd `"`e(cmd2)'"'
	}
	else	local cmd `"`e(cmd)'"'
	local cmdtoxeq = "`cmd'_promote"
	capture which `cmdtoxeq'
	if !_rc {
		`cmdtoxeq'
	}
end

/*
	subcmd for name-list [, nodrop noheader]: any_cmd
*/
program define For

	// parse off the name-list
	gettoken tok 0 : 0 , parse(" ,[:")
	while !inlist(`"`tok'"', "", ",", ":", "[", "in", "if", "using") {
		local names `"`names' `tok'"'
		gettoken tok 0 : 0 , parse(" ,[:")
	}
	if `"`names'"' == "" {
		di as err "name-list expected"
		exit 198
	}
	est_expand `"`names'"'
	local names `r(names)'
	if "`names'" == "" {
		exit
	}

	// parse option specification for -for- subcommand
	// store in pecmd the "postestimation" cmdline to be executed
	if `"`tok'"' == "," {
		gettoken tok 0 : 0 , parse(" :")
		while !inlist(`"`tok'"', "", ":") {
			local foropts `"`foropts' `tok'"'
			gettoken tok 0 : 0 , parse(" :")
		}
		local pecmd `"`0'"'
		local 0 `", `foropts'"'
		syntax [, noStop noHeader]
	}
	else {
		local pecmd `"`0'"'
	}
	local pecmd version $T_EST_VERSION : `pecmd'
	if "`tok'" != ":" {
		di as err "colon expected"
		exit 198
	}
	local Qheader = ("`header'" == "")

// parsing ready

	// get "active only" case out of the way
	if inlist("`names'", ".", "`e(_estimates_name)'") {
		capt noi `pecmd'
		exit _rc
	}

	// save current estimation results, if any
	tempname hcurrent esample
	_est hold `hcurrent', restore nullok estsystem

	foreach name of local names {
		nobreak {
			if "`name'" != "." {
				est_unhold  `name' `esample'
				local errlab `name
			}
			else {
				_est unhold `hcurrent'  '
				local errlab the active results
			}

			capture break noisily {
				if `Qheader' {
					Header
				}
				version $T_EST_VERSION : `pecmd' 
			}
			local rc = _rc

			if "`name'" != "."{
				est_hold `name' `esample'
			}
			else {
				_est hold `hcurrent', restore nullok estsystem
			}
		}

		if `rc' == 1 {
			di as err "--Break--"
		}
		else if `rc'!=0 & !`Qheader' {
			di as err "error executing the post estimation command on `errlab'"
		}
		if "`stop'" == "" {
			exit `rc'
		}
	} /* foreach */
end


/*
	subcmd replay [name-list] [, noheader]
*/
program define Replay
	syntax [anything(id=name)] [, noHeader *]

	local estopt `options'
	local Qheader = ("`header'" == "")

	est_expand `"`anything'"' , default(.)
	local names `r(names)'
	if `"`names'"' == "" {
		exit
	}

//	if inlist("`names'", ".", "`e(_estimates_name)'") {
//		if `Qheader' {
//			Header `names'
//		}
//		Replay_u `estopt'
//		exit
//	}

	tempname hcurrent esample
	_est hold `hcurrent', restore nullok estsystem

	foreach name of local names {
		nobreak {
			if "`name'" != "." {
				est_unhold  `name' `esample'
			}
			else {
				_est unhold `hcurrent'
			}
			capture break nois {
				if `Qheader' {
					Header
				}
				Replay_u `estopt'
			}
			local rc = _rc

			if "`name'" != "." {
				est_hold `name' `esample'
			}
			else {
				_est hold `hcurrent', restore nullok estsystem
			}
		}
		if `rc' {
			exit `rc'
		}
	}
end


/*
	subcmd dir [name-list]
*/
program define Dir, rclass
	syntax [anything] [, Width(int -1) *]

	est_expand `"`anything'"', default(_all)
	local names `r(names)'
	if "`names'" == "" {
		exit
	}

	// store in locals cmd<i>, depvar<i>, title<im>, and npar<i>
	// set lent = max(length(title))

	tempname b hcurrent esample
	_est hold `hcurrent', restore nullok estsystem

	local lent 0
	local im 0
	foreach name of local names {
		local ++im

		nobreak {
			if "`name'" != "." {
				est_unhold  `name' `esample'
			}
			else {
				_est unhold `hcurrent'
			}

			local cmd`im' `e(cmd)'
			if "`e(cmd2)'" != "" {
				local cmd`im' `e(cmd2)'
			}
			local depvar`im' `e(depvar)'
			local title`im'  `"`e(estimates_title)'"'
			matrix `b' = e(b)
			local npar`im' = colsof(`b')

			if "`name'" != "." {
				est_hold `name' `esample'
			}
			else {
				_est hold `hcurrent', restore nullok estsystem
			}
		}
		local lent = max(`lent', length(`"`title`im''"'))
	}
	local lent = max(`lent', 8)


	if `width' == -1 {
		// adjust to linesize and title length
		local lpiece = min(`: set linesize' - 47, `lent')
		local lent = 33 + `lpiece'
	}
	else {
		local width = max(`width', 60)
		// fixed width table
		local lpiece = `width' - 48
		local lent   = 33 + `lpiece'
	}


	di _n as txt "{hline 13}{c TT}{hline `lent'}"
	di as txt "        name {c |} command      depvar       npar  title "
	di as txt "{hline 13}{c +}{hline `lent'}"

	local im 0
	foreach name of local names {
		local ++im

		local ndp  : word count `depvar`im''
		local depn = cond(`ndp' == 0, "no depvar", ///
				  cond(`ndp' == 1, ///
				    abbrev("`depvar`im''",12), "mult. depvar"))
		if "`name'" != "." {
			local abname = abbrev("`name'", 12)
			local clicktxt "{stata estimates replay `name':`abname'}"
		}
		else {
			local clicktxt .
		}
		local ti : piece 1 `lpiece' of `"`title`im''"'

		di as txt   "{ralign 12:`clicktxt'}"             ///
		            _col(14) "{txt:{c |}}"               ///
		   as res   _col(16) "{lalign 12:`cmd`im''}"     ///
		            _col(29) "{lalign 12:`depn'}"        ///
		            _col(42) %4.0f `npar`im''            ///
		            _col(48) `"{it:`ti'}"'

		// remainder of title
		local j 2
		local ti : piece `j' `lpiece' of `"`title`im''"'
		while `"`ti'"' != "" {
			di _col(14) "{txt}{c |}" _col(48) `"{res}{it:`ti'}"'
			local ++j
			local ti : piece `j' `lpiece' of `"`title`im''"'
		}
	}
	di as txt "{hline 13}{c BT}{hline `lent'}"

	return local names `names'
end


/*
	subcmd stats [name-list]
*/
program define Stats, rclass
	syntax [anything] [,		/// 
		df(str)			/// undocumented
		n(numlist max=1 >0)	/// substitute for e(N) in BIC
	] 

	est_expand `"`anything'"', default(.)
	local names `r(names)'
	if `"`names'"' == "" {
		exit
	}

	if `"`df'"' != "" { 
		capture confirm number `df' 
		local df_is_number = _rc==0
	}
	if ! `:length local n' {
		local n e(N)
	}

	tempname hcurrent S esample

	local nnames : word count `names'
	matrix `S' = J(`nnames', 6, .)

	_est hold `hcurrent', restore nullok estsystem
	local is 0
	foreach name of local names {
		nobreak {
			if "`name'" != "." {
				est_unhold  `name' `esample'
			}
			else {
				_est unhold `hcurrent'
			}
			
			local ++is
			if "`n'" != "e(N)" {		// user specified
				matrix `S'[`is',1] = `n'
			}
			else if `"`e(N_ic)'"' != "" {	// use cmd's edict
				matrix `S'[`is',1] = e(N_ic)
			}
			else {				// default - e(N)
				matrix `S'[`is',1] = e(N)
			}
				
			matrix `S'[`is',2] = e(ll_0)
			matrix `S'[`is',3] = e(ll)

			if "`df_is_number'" == "1" { 	// user specified
				matrix `S'[`is',4] = `df' 
			}
			else if `"`df'"' != "" { 
				// user typed e() macro name
				capture confirm number `e(`df')' 
				if _rc==0 { 
					matrix `S'[`is',4] = e(`df')  
				}
			}
			else if `"`df'"' == "" & `"`e(df_ic)'"' != "" {
						// use cmd's edict
				matrix `S'[`is',4] = e(df_ic)
			}
			else {			// default = rank(V)
				GetRankV `name'
				matrix `S'[`is',4] = r(rankV) // == df
			}
			
			if "`name'" != "."{
				est_hold `name' `esample'
			}
			else {
				_est hold `hcurrent', restore nullok estsystem
			}
		}

		// AIC = -2*ll + 2*df
		matrix `S'[`is',5] = -2*`S'[`is',3] + 2*`S'[`is',4]

		// BIC = -2*ll + log(N)*edf
		matrix `S'[`is',6] = -2*`S'[`is',3] + log(`S'[`is',1])*`S'[`is',4]
	}


	di _n as txt "{hline 13}{c TT}{hline 63}"
	di as txt "       Model {c |}    Obs    ll(null)   ll(model) " ///
	          "    df          AIC         BIC"
	di as txt "{hline 13}{c +}{hline 63}"

	local is 0
	foreach name of local names {
		local ++is
		if "`name'" != "." {
			local abname = abbrev("`name'",12)
			local click "{stata estimates replay `name':`abname'}"
		}
		else {
			local click .
		}
		di as txt "{ralign 12:`click'}"         ///
		          _col(14) "{c |}"              ///
		   as res _col(17)  %5.0f  `S'[`is',1]  ///
		          _col(25)  %9.0g  `S'[`is',2]  ///
		          _col(37)  %9.0g  `S'[`is',3]  ///
		          _col(48)  %5.0f  `S'[`is',4]  ///
		          _col(57)  %9.0g  `S'[`is',5]  ///
		          _col(69)  %9.0g  `S'[`is',6]
	}
	di as txt "{hline 13}{c BT}{hline 63}"
	if "`n'" == "e(N)" {
		local n Obs
		local see "; see {helpb bic_note:[R] BIC note}"
	}
	di as txt "{p 15 22 2}"
	di as txt `"Note:  N=`n' used in calculating BIC`see'"'
	di as txt "{p_end}"

	mat colnames `S' = N ll0 ll df AIC BIC
	mat rownames `S' = `names'
	return matrix S `S'
end


/*
	subcmd drop name-list
*/
program define Drop
	syntax anything

	est_expand `"`anything'"'
	local names `r(names)'

	foreach name of local names {
		if `"`name'"' != "." {
			_est drop `name'
		}
		if `"`name'"' == "`e(_estimates_name)'" {
			ClearFields
		}
	}
end


/*
	subcmd clear

	only results that were -estimate store-d are dropped
*/
program define Clear
	* get appropriate err msg if cmdline is specified
	syntax

	Drop _all
end


// ============================================================================
// subroutines
// ============================================================================


program define CheckName
	args name

	if `"`e(_estimates_name)'"' != "`name'" {
		di as err "estimation results for `name'" /*
		*/ " are not stored via {cmd:estimates}"
		exit 198
	}
end


program define ChangeFields, eclass
	syntax [, title(str) scorevars(str) ]

	if `"`scorevars'"' != "" {
		eret local scorevars  `"`scorevars'"'
	}
	if `"`title'"' != "" {
		TitleUpdate `title'
	}
end


program define ClearFields, eclass
	TitleUpdate
	eret local _estimates_name ""
end


/* GetRankV name

   returns in r(rankV) the dimension of a model, determined as the rank of
   the (co)variance matrix of the coefficients.

   rank determination via -syminv-
*/
program define GetRankV, rclass
	args name

	tempname r V

	scalar `r' = e(rank)
	if `r' >= . {
		capt mat `V' = syminv(e(V))
		local rc = _rc
		if `rc' == 111 {
			dis as txt "(`name' does not contain matrix e(V); rank = 0 assumed)"
			scalar `r' = 0
		}
		else if `rc' != 0 {
			// reproduce error message
			mat `V' = syminv(e(V))
		}
		else {
			scalar `r' = colsof(`V') - diag0cnt(`V')
		}
	}
	return scalar rankV = `r'
end


/* Header style

   displays a replay - header for estimation results name (possibly .)
   style = title forces a compact header
*/
program define Header
	args style

	if "`e(_estimates_name)'" != "" {
		local txt "Model {hi:`e(_estimates_name)'}"
		if `"`e(estimates_title)'"' != "" {
			local txt "`txt' ({it:`e(estimates_title)'})"
		}
	}
	else {
		local txt "active results"
	}

	if "`style'" == "title" {
		di _n(2) as txt `"{title:`txt'}"'
	}
	else {
		di _n as txt "{hline}"
		di as txt `"{p 0 8}`txt'{p_end}"'
		di as txt "{hline}"
	}
end


/* Replay_u dopt

   replays the last estimation command, with display options dopt
*/
program define Replay_u

	if "`e(cmd2)'" != "" {
		// try e(cmd2)
		version $T_EST_VERSION:  `e(cmd2)' , `0'
	}
	else if "`e(cmd)'" != "" {
		// try e(cmd)
		version $T_EST_VERSION:  `e(cmd)' , `0'
	}
	else {
		di as err "impossible to replay estimation command"
		exit 198
	}
end


/* SubcmdMoved subcmd cmd

   reports that subcommand subcmd was moved to the command cmd
*/
program define SubcmdMoved
	args subcmd cmd

	di as err "the subcommand {cmd:`subcmd'} has been moved " ///
	          "from {cmd:estimates} to {cmd:`cmd'}"
	exit 198
end


program define TooManyModels
	di _n as err "system limit exceeded"
	di as err "you need to drop one or more models"
	est dir _all
end

exit

