*! version 1.2.1  09apr2011

program asclogit, eclass byable(onecall)
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
	}
	version 10

	if _by() {
		local BY `"by `_byvars'`_byyrc0':"'
	}
	if replay() {
		if ("`BY'" != "") error 190
		if ("`e(cmd)'" != "asclogit") error 301
		Replay `0'
		exit
	}
	local cmdline : copy local 0
	qui syntax [anything] [fw pw iw] [if] [in], case(varname numeric) [ ///
		Cluster(varname) VCE(passthru) OR *]

	if `"`vce'"' != "" {
		tempname id
		local case0 "`case'"
		_vce_cluster asclogit,		///
			groupvar(`case')	///
			newgroupvar(`id')	///
			groptname(case)		///
			`vce'			///
			cluster(`cluster')
		local vce `"`s(vce)'"'
		local idopt `s(idopt)'
		local clopt `s(clopt)'
		local gropt `s(gropt)'
		local bsgropt `s(bsgropt)'
		if "`weight'" != "" {
			local wgt [`weight'`exp']
		}
		local vceopts jkopts(`clopt' notable noheader)               ///
			bootopts(`clopt' `idopt' `bsgropt' notable noheader) ///
			required(BASEalternative) 

		`vv' `BY' _vce_parserun asclogit, `vceopts'	: ///
			`anything' `wgt' `if' `in',       ///
			`gropt' `vce' `options'
		if "`s(exit)'" != "" {
			if ! `:length local level' {
				local level `"`s(level)'"'
			}
			ereturn local cmdline `"asclogit `cmdline'"'
			ereturn local case `case'
			ereturn local clustvar `cluster'
			if "`cluster'" == "" {
				local cmd1 `"`e(command)'"'
				local cmd2 : subinstr local cmd1 "`id'" ///
					"`case'"
				ereturn local command `"`cmd2'"'
			}
			local 0 , `options'
			syntax [, Level(string asis) noHEADer * ]
			if ! `:length local level' {
				local level `"`s(level)'"'
			}

			_get_diopts diopts options, `options'
			Replay, level(`level') `or' `header' `diopts'

			exit
		}
		qui syntax [anything] [fw pw iw] [if] [in], case(varname) ///
			[ * ]

		local 0 `"`anything' [`weight'`exp'] `if' `in',"' 
		local 0 `"`0' case(`case0') `options'"'
	}
	cap noi `vv' `BY' Estimate `0'
	local rc = _rc
	ereturn local cmdline `"asclogit `cmdline'"'
	macro drop CLOGIT_*
	exit `rc'
end
	
program Estimate, eclass byable(recall) sort
	if _caller() >= 11 {
		local vv : di "version " string(_caller()) ":"
		local negh negh
	}
	version 10
	syntax varlist(min=1 numeric) [if] [in] [fw pw iw], ///
		case(varname numeric)			///
		ALTernatives(varname) [ 		///
		CASEVars(varlist numeric)		///
		BASEalternative(string)			///
		CLuster(passthru)			///
		vce(passthru)				///
		Robust					///
		OFFset(varname numeric) 		///
		noCONStant				///
		from(string)				///
		CONSTraints(string)			///
		COLlinear				///
		altwise					///
		Level(cilevel) 				///
		noLOg					///
		noHEADer				///
		OR					///
		trace					///
		* ]

	/* undocumented options						*/
	/* trace - verbose output, also passed thru to -ml-		*/

	_get_diopts diopts options, `options'
	mlopts mlopts rest, `options'
	CheckTech, `s(technique)'
	/* anything left over is an error				*/
	PostError, `rest'

	if ("`level'"!="") local levopt level(`level')

	if "`altwise'"=="" & ("`if'`in'"!="" | _by()) {
		/* marksample using [if] [in] or by: only */
		tempvar uifin
		mark `uifin' `if' `in'
		local ifinopt ifin(`uifin')
	}
	_vce_parse, argopt(CLuster) opt(Robust oim) old: [`weight'`exp'], ///
		`vce' `cluster' `robust'

	local cluster `r(cluster)'
	local robust `r(robust)'
	local vce `r(vce)'

	marksample touse
	if (`"`cluster'"'!="") {
		markout `touse' `cluster', strok
		local clopt cluster(`cluster')
	}
	cap count if `touse'
	if (r(N) == 0) error 2000

	if "`robust'" != "" {
		local crtopt crittype("log pseudolikelihood")
		local vce oim
	}
	if ("`basealternative'"!="") local bopt base(`basealternative')

	if "`weight'" != "" {
		local wopt = `"[`weight'`exp']"'

		if ("`weight'"=="pweight") local woptml [iweight`exp']
		else local woptml `wopt'
	}
	local const = ("`constant'"=="")
	tempname model

	`vv' ///
	.`model' = ._asclogitmodel.new `varlist' `wopt', touse(`touse') ///
		`bopt' altern(`alternatives') case(`case')              ///
		casevars(`casevars') offset(`offset') const(`const')    ///
		`collinear' `ifinopt' `altwise'

	global CLOGIT_model `model'

	if "`cluster'" != "" {
		/* make sure cluster is constant with case		*/
		local type: type `cluster'
		if substr("`type'",1,3) == "str" {
			cap by `case': assert `cluster'==`cluster'[1] ///
				if `touse' 
		}
		else {
			.`model'._assertnovar `cluster', bylist(`case')
		}
		if _rc==9 {
			di as err "{p}cluster must be constant within " ///
			 "case{p_end}"
			exit 407
		}
	}
	if "`constraints'" != "" {
		cap mat li `constraints'
		if _rc {
			cap numlist "`constraints'", sort
			if _rc {
				di as err "constraints must be a numlist, " ///
				 "see {help constraint}, or a constraint "  ///
				 "matrix, see {help makecns}"
				exit 198
			}
			local constraints `r(numlist)'
		}
		local conopt constraints(`constraints')
	}
	if (`"`from'"'!="") local initopt init(`from')
	else {
		tempname b 
		.`model'.initest, b(`b') `trace'

		local initopt init(`b')
	}
	local wldopt waldtest(`.`model'.keq')
	local mlmodel `.`model'.mlmodel'
	if "`trace'" != "" {
		di `"ml model    |`mlmodel'|"'
		di `"ml options  |`mlopts'|"'
	}
	`vv' ///
	ml model d2 asclogit_lf `mlmodel' `woptml' if `touse', max      ///
		`initopt' search(off) collinear nopreserve noscvars     ///
		vce(`vce') `lf0opt' `crtopt' `conopt' `wldopt' `mlopts' ///
		`log' `trace' `negh'

	if "`robust'" != "" {
		tempname b V
		mat `b' = e(b)
		mat `V' = e(V)

		.`model'.robust, b(`b') v(`V') `clopt'
	}
	.`model'.eretpost

	signestimationsample `varlist' `casevars' `case' `alternatives' ///
		`cluster' `offset' 

	ereturn local k_dv
	ereturn hidden scalar k_eform = e(k_eq)

	ereturn local title "Alternative-specific conditional logit"
	ereturn local estat_cmd "asclogit_estat"
	ereturn local predict "asclogit_p"
	ereturn local marginsnotok _ALL
	ereturn local cmd "asclogit"

	Replay, `levopt' `or' `header' `diopts'
end

program Replay
	syntax [, Level(cilevel) OR noHEADer *]
	_get_diopts diopts, `options'
	if ("`header'"=="") Header 
	_coef_table, cmdextras `diopts' level(`level') `or'
	_prefix_footnote
	cap
end

program Header

	local crtype = upper(substr(`"`e(crittype)'"',1,1)) + ///
		substr(`"`e(crittype)'"',2,.)
	di _n in gr `"`e(title)'"' _col(48) "Number of obs" _col(67) "= " ///
	 in ye %10.0g e(N)
	di in gr `"Case variable: `=abbrev("`e(case)'",24)'"' _col(48) ///
	 "Number of cases" _col(67) "= " in ye %10.0g e(N_case) 
	if ("`e(cmd)'"=="asroprobit" & e(ties) > 0)              ///
		di in gr _col(48) "Number of ties" _col(67) "= " ///
		in ye %10.0g e(ties) 
	di
	local altvar `=abbrev("`e(altvar)'",17)'
	di in gr `"Alternative variable: `altvar'"' _col(48)               ///
	 "Alts per case: min = " in ye %10.0g e(alt_min) _n _col(63) in gr ///
	 "avg = " in ye %10.1f e(alt_avg) _n _col(63) in gr "max = "       ///
	 in ye %10.0g e(alt_max) _n
	local lencr = length("`e(crittype)'")
	if "`e(chi2type)'" == "Wald" {
		local stat chi2
        	local cfmt=cond(e(chi2)<1e+7,"%10.2f","%10.3e")
       		if e(chi2) >= . {
			local h help j_robustsingular:
			di in gr _col(51)                            ///
			 "{`h'Wald chi2(`e(df_m)'){col 67}= }" in ye ///
			 `cfmt' e(chi2)
       		}
        	else {
			di in gr _col(51) "`e(chi2type)' chi2(" in ye ///
			 "`e(df_m)'" in gr ")" _col(67) "= " in ye    ///
			 `cfmt' e(chi2)
       		}
	}
	else if "`e(clustvar)'"!="" | "`e(vce)'"=="jackknife" {
		/* F statistic from test after _robust */
		local stat F
		local cfmt=cond(e(F)<1e+7,"%10.2f","%10.3e")
		if e(F) < . {
			di in gr _col(51) "F(" in ye %3.0f e(df_m) in gr ///
			 "," in ye %6.0f e(df_r) in gr ")" _col(67) "= " ///
			 in ye `cfmt' e(F)
		}
		else {
			local dfm = e(df_m)
			local dfr = e(df_r)
			local h help j_robustsingular:

			di in gr _col(51) "{`h'F( `dfm', `dfr')}" _col(67) ///
			 "{`h'=          .}"
		}
	}
	else {
		local stat chi2	
		local cfmt=cond(e(chi2)<1e+7,"%10.2f","%10.3e")
		di in gr _col(51) "LR(" in ye %3.0f e(df_m) in gr ")" ///
		 _col(67) "= " in ye `cfmt' e(chi2)
	}
	di in gr "`crtype' = " in ye %10.0g e(ll) _col(51) in gr ///
	 "Prob > `stat'" _col(67) "= "  in ye %10.4f e(p) _n
end

program CheckTech
        syntax, [ technique(string) ]

        while "`technique'" != "" {
                gettoken tok technique : technique
                if "`tok'" == "bhhh" {
                        di as err "option technique(bhhh) is not allowed"
                        exit 198
                }
        }
end

program PostError
	syntax , [ SCore(string) ]
/*****************************************************************************/ 
if "`score'"!="" {
	di as error "{p}option score() not allowed; see "                   ///
	 "{help asclogit postestimation##predict:asclogit postestimation} " ///
	 "to obtain scores{p_end}"
	exit 198
}
/*****************************************************************************/ 
end

exit
