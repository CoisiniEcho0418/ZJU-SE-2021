*! version 1.4.1  02mar2011
* asroprobit - rank-ordered probit model for alternative specific
* 	       and case specific variables
	
program asroprobit, eclass byable(onecall) 
	version 10

	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	if replay() {
		if `"`BY'"' != "" error 190
		if `"`e(cmd)'"' != "asroprobit" error 301
		if "`e(diparm1)'" == "" {
			_asprobit_diparm
		}
		_asprobit_replay `0'
		exit
	}
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	`vv' ///
        _asprobit_vce_parserun asroprobit, by(`BY'): `0'
        if ("`s(exit)'"!="") {
		ereturn local cmdline `"asroprobit `0'"'
		exit
	}

	`vv' ///
	cap noi `BY' Estimate `0'
	local rc = _rc
	ereturn local cmdline `"asroprobit `0'"'
	cap mata : mata drop _mprobit_panel_info
	if ("$ASPROBIT_seed0"!="") set seed $ASPROBIT_seed0
	macro drop ASPROBIT_*
	exit `rc'
end

program Estimate, eclass byable(recall) sortpreserve
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	version 10
	syntax varlist [if] [in] [fw pw iw], 	///
		case(passthru)			///
		ALTernatives(varname) [ 	///
		CASEVars(passthru)		///
		BASEalternative(string)		///
		SCALEalternative(string)	///
		CORRelation(passthru)		///
		STDdev(passthru)		///
		STRUCtural			///
		FACTor(passthru)		///
		INTMethod(passthru)		///
		INTPoints(passthru)		///
		INTBurn(passthru)		///
		INTSeed(passthru) 		///
		ANTIthetics			///
		noPIVot				///
		favor(passthru)			///
		REVerse 			///
		CLuster(varname)		///
		noCONstant			///
		COLlinear			///
		altwise				///
		Level(cilevel) 			///
		* ]

	_get_diopts diopts options, `options'
	if ("`level'"!="") local levopt level(`level')

	if "`altwise'"=="" & ("`if'`in'"!="" | _by()) {
		/* marksample using [if] [in] or by: only */
		tempvar uifin
		mark `uifin' `if'`in'
		local ifinopt ifin(`uifin')
	}
	marksample touse
	if (`"`cluster'"'!="") {
		markout `touse' `cluster', strok
		local clopt cluster(`cluster')
	}
	cap count if `touse'
	if (r(N) == 0) error 2000

	local const = ("`constant'"=="")
	if ("`basealternative'"!="") local bopt base("`basealternative'")
	if ("`scalealternative'"!="") local sopt scale("`scalealternative'")

	/* save seed incase this is a bootstrap call			*/
	if ("`intseed'"!="") global ASPROBIT_seed0 = c(seed)

	tempname model
	`vv' ///
	.`model' = ._asroprobitmodel.new `varlist' [`weight'`exp'],      ///
		touse(`touse') altern(`alternatives') `case' `casevars'  ///
		const(`const') `bopt' `sopt' `correlation' `stddev'      ///
		`structural' `intmethod' `intpoints' `intburn' `intseed' ///
		`antithetics' `pivot' `favor' `collinear' `ifinopt'      ///
		`altwise' `reverse' `factor'

	`vv' ///
	_asprobit_estimator, model(`model') cluster(`cluster') `options'
	_asprobit_diparm

	ereturn local title  "Alternative-specific rank-ordered probit"
	ereturn local mfx_dlg asroprobit_mfx
	ereturn local predict asroprobit_p
	ereturn local estat_cmd asroprobit_estat
	ereturn local marginsnotok _ALL
	ereturn hidden local cmd2 asroprobit
	ereturn local cmd asroprobit

	_asprobit_replay, level(`level') `diopts'
end

exit
