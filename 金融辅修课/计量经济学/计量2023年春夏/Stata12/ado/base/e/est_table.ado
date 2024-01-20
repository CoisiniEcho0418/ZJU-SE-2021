*! version 1.2.3  14dec2009
program est_table
	version 8

	nobreak {
		macro drop T_ET_*
		capture noisily break {
			EstTable `0'
		}
		local rc = _rc

		macro drop T_ET_*
		exit `rc'
	}
end


program EstTable, rclass
	version 8

	syntax [anything] [, STATS(str) STATistics(str) Keep(str asis) Drop(str asis) ///
	  CODed  EQuations(str) * ]

	local opt `options'

	est_expand `"`anything'"', default(.)
	local names `r(names)'
	local names : list uniq names

	// could not happen, ...
	if "`names'" == "" {
		exit
	}

	if `"`statistics'"' != "" {
		local stats `stats' `statistics'
	}

// combine coefs/stats in models

	Mkemat "`names'" "`stats'" "`equations'"

	tempname b df_r
	mat `b'    = r(coefs)
	mat `df_r' = r(df_r)
	//mat list `b', nodotz
	if "`stats'" != "" {
		tempname st
		mat `st' = r(stats)
		//mat list `st', nodotz
	}

// select equations/coefficients

	if `"`keep'"' != "" {
		Keep `b' `"`keep'"'
		mat `b' = r(result)
	}

	if `"`drop'"' != "" {
		Drop `b' `"`drop'"'
		mat `b' = r(result)
	}

// output

	if "`coded'" == "" {
		Display       `b' `df_r' `st' , `opt'
	}
	else {
		DisplayCodedV `b' `df_r' `st' , `opt'
	}

// return values

	return local names `names'
	return matrix coef = `b'
	if "`stats'" != "" {
		return matrix stats = `st'
	}
end

// ===========================================================================
// subroutines to extract stuff from e()
// ===========================================================================

program Keep, rclass
	args b spec

	tempname bt
	foreach sp of local spec {
		local row =  rownumb(`b', "`sp'")
		if `row' == . {
			dis as err ///
			"coefficient `sp' does not occur in any of the models"
			exit 198
		}
		if index("`sp'",":") > 0 {    // complete equation spec.
			mat `bt' = nullmat(`bt') \ `b'["`sp'",1...]
		}
		else {
			mat `bt' = nullmat(`bt') \ `b'[`row',1...]
		}
	}
	ret mat result `bt'
end


program Drop, rclass
	args b spec

	tempname bt
	mat `bt' = `b'

	foreach sp of local spec {
		local isp = rownumb(`bt', "`sp'")
		if `isp' == . {
			dis as err "coefficient `sp' does not occur in any of the models"
			exit 198
		}
		while `isp' != . {
			local nb = rowsof(`bt')
			if `isp' == 1 {
				mat `bt' = `bt'[2...,1...]
			}
			else if `isp' == `nb' {
				mat `bt' = `bt'[1..`=`nb'-1',1...]
			}
			else {
				local im1 = `isp'-1
				local ip1 = `isp'+1
				mat `bt' = `bt'[1..`im1',1...] \ `bt'[`ip1'...,1...]
			}
			local isp = rownumb(`bt', "`sp'")
		}
	}
	ret mat result `bt'
end


/* GetStats stats bs

   Subroutine for Mkemat

   Creates a column vector of statistics in stats from e(). Statistics
   not found in e() are represtented by .z
*/
program GetStats
	args stats bs

	local stats : list uniq stats

	tempname rank st V
	local escalars : e(scalars)
	local is 1
	foreach stat of local stats {
		if inlist("`stat'", "aic", "bic", "rank") {
			if "`hasrank'" == "" {
				capt mat `V' = syminv(e(V))
				local rc = _rc
				if `rc' == 0 {
					scalar `rank' = colsof(`V') - diag0cnt(`V')
				}
				else if `rc' == 111 {
					scalar `rank' = 0
				}
				else {
					// rc<>0; show error message
					mat `V' = syminv(e(V))
				}
				local hasrank 1
			}
			if "`stat'" == "aic" {
				scalar `st' = -2*e(ll) + 2*`rank'
			}
			else if "`stat'" == "bic" {
				scalar `st' = -2*e(ll) + log(e(N)) * `rank'
			}
			else if "`stat'" == "rank" {
				scalar `st' = `rank'
			}
		}
		else {
			if `:list posof "`stat'" in escalars' > 0 {
				scalar `st' = e(`stat')
			}
			else {
				scalar `st' = .z
			}
		}

		mat `bs'[`is',1] = `st'
		local ++is
	}
end


/*
	Mkemat names stats equations

	names should already be expanded using est_expand
*/
program Mkemat, rclass
	args names stats equations

	tempname bc bbc bs bbs st df_r oc

	local nnames : word count `names'
	mat `df_r' = J(`nnames', 1, .)
	if `"`stats'"' != "" {
		local stats : subinstr local stats "," "", all
		confirm names `stats'
		local stats : list uniq stats
		local nstat : list sizeof stats
		mat `bs' = J(`nstat', 1, .z)
		mat rownames `bs' = `stats'
	}

	if "`equations'" != "" {
		MatchNames "`equations'"
		local eqspec  `r(eqspec)'
		local eqnames `r(eqnames)'
	}

	tempname hcurrent esample
	_est hold `hcurrent', restore nullok estsystem

	local ni 0
	local nf 0
	foreach name of local names {
		local ++ni
		nobreak {
			if "`name'" != "." {
				local eqname `name'
				est_unhold `name' `esample'
			}
			else 	{
				local eqname active
				_est unhold `hcurrent'
			}

			// currently a b or V is required
			if (!(has_eprop(b) | has_eprop(b_nonames)) | ///
			    !(has_eprop(V) | has_eprop(V_nonames))) {
				if "`name'" == "." {
					local diname current
				}
				else {
					local diname {bf:`name'}
				}
				di as err "`diname' estimation results do " ///
						"not have e(b) and e(V)"
				local bV_rc 321
				if "`name'" != "." {
					est_hold `name' `esample'
				}
				else {
					_est hold `hcurrent', restore ///
							nullok estsystem
				}
				continue, break
			}

			// save (b,se_b) in two columns
			capt mat `bc' = ( e(b) \ vecdiag(e(V)) )'
			local found = _rc==0

			if `found' {
				capture noisily break {
					mat `df_r'[`ni',1] = e(df_r)
					if "`stats'" != "" {
						GetStats "`stats'" `bs'
					}
					_ms_omit_info e(b), code
					matrix `oc' = r(omit)
				}
			}
			local rc = _rc

			if "`name'" != "." {
				est_hold `name' `esample'
			}
			else {
				_est hold `hcurrent', restore nullok estsystem
			}
		}

		// there are models without coefficients! (eg., cox without predictors)
		// this is currently not supported.
		if !`found' {
			dis as err "no coefficients found in `name'"
			exit 198
		}
		else if `rc' {
			exit `rc'
		}

		local R = colsof(`oc')
		forval r = 1/`R' {
			local o = `oc'[1,`r']
			if `o' {
				if `o' == 3 {
					local o .e
				}
				else if `o' == 2 {
					local o .b
				}
				else {
					local o .o
				}
				matrix `bc'[`r',1] = `o'
				matrix `bc'[`r',2] = `o'
			}
		}

		mat colnames `bc'  = `eqname':b `eqname':var
		if "`equations'" != "" {
			AdjustRowEq `bc' `ni' `nnames' "`eqspec'" "`eqnames'"
		}

		if `ni' > 1 {
			_ms_omit_unset `bc', row
			if `ni' == 2 {
				_ms_omit_unset `bbc', row
			}
			mat_capp `bbc' : `bbc' `bc', miss(.z) cons ts
		}
		else {
			mat `bbc' = `bc'
		}

		if "`stats'" != "" {
			mat colname `bs' = `eqname'
			mat `bbs' = nullmat(`bbs') , `bs'
		}
	}
	if "`bV_rc'" != "" {
		exit `bV_rc'
	}

	return matrix coefs = `bbc'
	return matrix df_r = `df_r'
	if "`stats'" != "" {
		return matrix stats = `bbs'
	}
end


// Matchnames eqspec
//
// cleans up eqspec :   replaces : by spaces
//                      removes # (undocumented)
//
// returns r(eqspec)    cleaned up version of
//         r(eqnames)   names for matched equations
//
program MatchNames, rclass
	args eqspec

	local eqspec  : subinstr local eqspec ":" " ", all
	local eqspec0 : subinstr local eqspec "#" "" , all

	local iterm 0
	gettoken term eqspec : eqspec0 , parse(",")
	while "`term'" != "" {
		local ++iterm

		// term = [name =] { # | #-list }
		gettoken eqname oprest: term, parse("=")
		gettoken op rest : oprest, parse("=")
		if trim(`"`op'"') == "=" {
			confirm name `eqname'
			local term `rest'
		}
		else {
			local eqname #`iterm'
		}
		local eqnames `eqnames' `eqname'

		if "`eqspec'" == "" {
			continue, break
		}
		gettoken term eqspec: eqspec , parse(",")
		assert "`term'" == ","
		gettoken term eqspec: eqspec , parse(",")
	}

	if `"`:list dups eqnames'"' != "" {
		dis as err "duplicate matched equation names"
		exit 198
	}

	return local eqspec   `eqspec0'
	return local eqnames  `eqnames'
end


// adjusts selected row-equation names of b to #<i> for matching by "relative
// position" rather than by name.
program AdjustRowEq
	args b ni nmodel eqspec eqnames

	local beqn : roweq `b', quote
	local beqn : list clean beqn
	local beq  : list uniq beqn

	if `"`:list beq & eqnames'"' != "" {
		dis as err "option equations() invalid"
		dis as err "specified equation name already occurs in model `ni'"
		exit 198
	}

	local iterm 0
	gettoken term eqspec : eqspec , parse(",")
	while "`term'" != "" {
		// dis as txt "term:|`term'|"
		local ++iterm

		// term = [name =] { # | #-list }
		gettoken eqname oprest: term, parse("=")
		gettoken op rest : oprest, parse("=")
		if trim(`"`op'"') == "=" {
			local term `rest'
		}
		else {
			local eqname #`iterm'
		}

		local nword : list sizeof term
		if !inlist(`nword', 1, `nmodel') {
			dis as err "option equations() invalid"
			dis as err "a term should consist of either 1 or `nmodel' equation numbers"
			exit 198
		}
		if `nword' > 1 {
			local term  : word `ni' of `term'
		}

		if trim("`term'") != "." {
			capt confirm integer number `term'
			if _rc {
				dis as err "option equations() invalid"
				dis as err "`term' was found, while an integer equation number was expected"
				exit 198
			}
			if !inrange(`term',1,`:list sizeof beq') {
				dis as err "option equations() invalid"
				dis as err "equation number `term' for model `ni' out of range"
				exit 198
			}
			if `:list posof "`eqname'" in beq' != 0 {
				dis as err "impossible to name equation `eqname'"
				dis as err "you should provide (another) equation name"
				exit 198
			}

			local beqn : subinstr local beqn  ///
				`"`:word `term'  of `beq''"'    ///
				"`eqname'" , word all
		}

		if "`eqspec'" == "" {
			continue, break
		}
		gettoken term eqspec: eqspec , parse(",")
		assert "`term'" == ","
		gettoken term eqspec: eqspec , parse(",")
	}
	matrix roweq `b' = `beqn'
end

// ===========================================================================
// STANDARD DISPLAY STYLE
// program -Display- and its subroutines
// ===========================================================================

program TopLine
	HLine "$T_ET_t0" "$T_ET_t1" "$T_ET_t2" "$T_ET_t3"
end


program CenterLine
	HLine "$T_ET_c0" "$T_ET_c1" "$T_ET_c2" "$T_ET_c3"
end


program BottomLine
	HLine "$T_ET_b0" "$T_ET_b1" "$T_ET_b2" "$T_ET_b3"
end


program HLine
	args ch0 ch1 ch2 ch3

	local ch `ch1'
	dis as txt "`ch0'{hline $T_ET_vw}" _c
	forvalues i = 1 / $T_ET_ncol {
		dis as txt "{c -}`ch'{c -}{hline $T_ET_cw}" _c
		local ch `ch2'
	}
	dis as txt "{c -}`ch3'"
end


// expects 5 + $S_SC_ncol arguments
program DLine
	args  v alignv tv  alignc tc
	mac shift 5

	if $T_ET_vw > 32 {
		local abv = substr("`v'",1,$T_ET_vw)
	}
	else {
		local abv = abbrev("`v'",$T_ET_vw)
	}
	dis as txt  `"$T_ET_ch0"' ///
	    as `tv' `"{`alignv' $T_ET_vw:`abv'}"' ///
	    as txt  `" $T_ET_ch1"' _c

	forvalues i = 1 / $T_ET_ncol {
		dis as `tc' `" {`alignc' $T_ET_cw:``i''}"' ///
		    as txt " $T_ET_ch2" _c
	}
	dis
end

// expects 3 + $S_SC_ncol arguments
program DLine2
	args bar alignc tc
	mac shift 3

	if `bar' == 2 {
		dis as txt  `"$T_ET_ch0{space $T_ET_vw} $T_ET_ch1"' _c
	}
	else if `bar' == 1 {
		dis as txt  `"$T_ET_ch1"' _c
	}
	forvalues i = 1 / $T_ET_ncol {
		dis as `tc' `" {`alignc' $T_ET_cw:``i''}"' ///
		    as txt " $T_ET_ch2" _c
	}
	dis
end


// expects 5 + 2*$S_SC_ncol arguments in pars (b,symbol)
program StarLine
	args  v alignv tv  alignc tc
	mac shift 5

	if $T_ET_vw > 32 {
		local abv = substr("`v'",1,$T_ET_vw)
	}
	else {
		local abv = abbrev("`v'",$T_ET_vw)
	}
	dis as txt  `"$T_ET_ch0"' ///
	    as `tv' `"{`alignv' $T_ET_vw:`abv'}"' ///
	    as txt  `" $T_ET_ch1"' _c

	local w1 = $T_ET_cw - $T_ET_lsym
	local w2 = $T_ET_lsym
	local ii 1
	forvalues i = 1 / $T_ET_ncol {
		dis as `tc' `" {`alignc' `w1':``ii++''}{lalign `w2':``ii++''}"' ///
		    as txt " $T_ET_ch2" _c
	}
	dis
end


// expects 2 + 2*$S_SC_ncol arguments in pars (b,symbol)
program StarLine2
	args bar alignc tc
	mac shift 3

	if `bar' == 2 {
		dis as txt  `"$T_ET_ch0{space $T_ET_vw} $T_ET_ch1"' _c
	}
	else if `bar' == 1 {
		dis as txt  `"$T_ET_ch1"' _c
	}
	local w1 = $T_ET_cw - $T_ET_lsym
	local w2 = $T_ET_lsym
	local ii 1
	forvalues i = 1 / $T_ET_ncol {
		dis as `tc' `" {`alignc' `w1':``ii++''}{lalign `w2':``ii++''}"' ///
		    as txt " $T_ET_ch2" _c
	}
	dis
end


program Header
	args text models m1 m2

	dis
	TopLine
	forvalues i = `m1' / `m2' {
		local w: word `i' of `models'
		local f = abbrev("`w'", $T_ET_cw)
		local cols  `cols' `f'
	}
	DLine  "`text'" ralign txt  center txt `cols'
	CenterLine
end


program Bvalue
	args f colon fmt b eform

	if `b' == .z {
		local fb
	}
	else if `b' == .b {
		local fb "(base)"
	}
	else if `b' == .e {
		local fb "(empty)"
	}
	else if `b' == .o {
		local fb "(omitted)"
	}
	else if "`eform'" == "" {
		local fb : display `fmt' `b'
	}
	else {
		local fb : display `fmt' exp(`b')
	}

	c_local `f' `fb'
end


program SEvalue
	args f colon fmt var b eform

	if `b' == .z {
		local se
	}
	else if `b' == .b {
		local se
	}
	else if `b' == .e {
		local se
	}
	else if `b' == .o {
		local se
	}
	else if "`eform'" == "" {
		local se : display `fmt' sqrt(`var')
	}
	else {
		local se : display `fmt' sqrt(`var')*exp(`b')
	}

	c_local `f' `se'
end


program Tvalue
	args f colon fmt b var

	if `b' == .z {
		local t
	}
	else if `b' == .b {
		local t
	}
	else if `b' == .e {
		local t
	}
	else if `b' == .o {
		local t
	}
	else {
		local t : display `fmt' (`b'/sqrt(`var'))
	}

	c_local `f' `t'
end


program Pvalue
	args f colon pfmt b var df

	if `b' == .z {
		local p
	}
	else if `b' == .b {
		local p
	}
	else if `b' == .e {
		local p
	}
	else if `b' == .o {
		local p
	}
	else if missing(`df') {
		// normal based
		local p : display `pfmt' 2*(1-norm(abs(`b')/sqrt(`var')))
	}
	else {
		// t-based
		local p : display `pfmt' 2*ttail(`df', abs(`b')/sqrt(`var'))
	}

	c_local `f' `p'
end


program StValue
	args f colon fmt st

	if `st' != .z {
		local pst : dis `fmt' `st'
	}
	c_local `f' `pst'
end


program BSvalue
	args f fs colon fmt b var df eform

	if `b' == .z {
		c_local `f'
		c_local `fs'
	}
	else if `b' == .b {
		c_local `f' "(base)"
		c_local `fs'
	}
	else if `b' == .e {
		c_local `f' "(empty)"
		c_local `fs'
	}
	else if `b' == .o {
		c_local `f' "(omitted)"
		c_local `fs'
	}
	else {
		if "`eform'" == "" {
			local prb : display `fmt' `b'
		}
		else {
			local prb : display `fmt' exp(`b')
		}

		tempname p
		if missing(`df') {
			// normal based
			scalar `p' = 2*(1-norm(abs(`b')/sqrt(`var')))
		}
		else {
			// t-based
			scalar `p' = 2*ttail(`df', abs(`b')/sqrt(`var'))
		}

		if `p' < $T_ET_p3 {
			local sym $T_ET_sym3
		}
		else if `p' < $T_ET_p2 {
			local sym $T_ET_sym2
		}
		else if `p' < $T_ET_p1 {
			local sym $T_ET_sym1
		}

		c_local `f'  `prb'
		c_local `fs' `sym'
	}
end


program Display

	// DON'T CHANGE THE ORDER OF THE OPTIONS
	syntax anything [,	 B  Bfmt(str)		///
				SE SEfmt(str)		///
				 T  Tfmt(str)		///
				 P  Pfmt(str)		///
				STFmt(str)		///
				STAR			///
				STAR2(str)		///
				EFORM			///
				VARwidth(str)		///
				MODELwidth(str)		///
				Label			///
				STYle(str)		///
				TItle(str)		///
				NEWpanel		///
				ALLBASElevels		///
				NOBASElevels		///
				BASElevels		///
				noOMITted		///
				noEMPTYcells		///
				vsquish			///
		]

	_get_diopts diopts,	`allbaselevels'	///
				`nobaselevels'	///
				`baselevels'	///
				`omitted'	///
				`emptycells'	///
				`vsquish'
	local DIOPTS : copy local diopts
	if !`:list posof "vsquish" in diopts' {
		local diopts `diopts' vsquish
	}

	local bc   : word 1 of `anything'
	local df_r : word 2 of `anything'
	local st   : word 3 of `anything'

	confirm matrix `bc'
	confirm matrix `df_r'
	if "`st'" != "" {
		confirm matrix `st'
	}

	if "`modelwidth'" != "" {
		capt confirm integer number `modelwidth'
		if _rc {
			dis as err "option modelwidth() incorrectly specified"
			exit 198
		}
	}

	// width of first column (variables, eqn, statnames)
	if "`varwidth'" == "" {
		local varwidth = cond("`label'"=="",12,24)
	}
	else {
		capt confirm integer number `varwidth'
		if _rc {
			dis as err "option varwidth() incorrectly specified"
			exit 198
		}
	}
	local vw = max(8,`varwidth')

	// width of other columns (b, se, t, p, stats)
	mata: st_local("has_omit", strofreal(any(st_matrix("`bc'") :== .o)))
	if `has_omit' {
		local cw 9
	}
	else {
		local cw 7
	}
	if "`bfmt'" != "" {
		// displays error message if invalid fmt
		ChkFormat `bfmt' 1
		local cw = max(`cw', `r(len)')
	}
	else {
		local cw = 10
		local bfmt %10.0g
	}

	if `"`se'`sefmt'"' != "" {
		local se se
		if `"`sefmt'"' != "" {
			ChkFormat `sefmt' 1
			local cw = max(`cw', `r(len)')
		}
		else {
			local sefmt `bfmt'
		}
	}

	if `"`t'`tfmt'"' != "" {
		local t t
		if `"`tfmt'"' != "" {
			ChkFormat `tfmt' -123.45
			local cw = max(`cw', `r(len)')
		}
		else {
			local tfmt %7.2f
		}
	}

	if `"`p'`pfmt'"' != "" {
		local p p
		if `"`pfmt'"' != "" {
			ChkFormat `pfmt' 1.0
			local cw = max(`cw', `r(len)')
		}
		else {
			local pfmt %7.4f
		}
	}

	if `"`st'"' != "" {
		if `"`stfmt'"' != "" {
			ChkFormat `stfmt' 1.0
			local cw = max(`cw', `r(len)')
		}
		else {
			local stfmt `bfmt'
		}
	}

	// star[()] format
	if `"`star'`star2'"' != "" {
		if `"`se'`sefmt'`t'`tfmt'`p'`pfmt'"' != "" {
			dis as err "option star may not be combined with se, t, or p"
			exit 198
		}
		ChkStar "`star'" "`star2'"
		local star star
	}
	else {
		global T_ET_lsym 0
	}

	ChkStyle `style'
	local style `s(style)'
	if "`style'" == "nolines" {
		local vbar novbar nov1bar v1space
	}
	else if "`style'" == "columns" {
		local vbar v0bar
	}
	else {
		local newline di
	}

	local coefn  : rownames `bc', quote
	local colb   : coleq `bc', quote
	local colb   : list clean colb
	local models : list uniq colb
	local nmodel : list sizeof models

	local eqnames : roweq `bc', quoted
	local eqnames : list clean eqnames
	local uniqeq  : list uniq eqnames
	local numeq   : list sizeof uniqeq

// display the table, wrapping if necessary

	if `"`title'"' != "" {
		dis _n as txt `"{p}`title'"'
	}

	if "`modelwidth'" != "" {
		local cw = max(`cw',`modelwidth')
	}

	global T_ET_vw  = `vw'
	global T_ET_cw  = `cw' + $T_ET_lsym

	local hcol1 = $T_ET_vw + 2*("$T_ET_ch0" != "") + ("$T_ET_ch1" != "")
	local hcolr = $T_ET_cw+2 + ("$T_ET_ch2" != "")
	local nmodblock = int((`:set linesize'-1-`hcol1') / (`hcolr'))

	_ms_eq_info, matrix(`bc') row
	local k_eq = r(k_eq)
	forval ieq = 1/`k_eq' {
		local k_eq`ieq' = r(k`ieq')
		local eq`ieq' = r(eq`ieq')
	}

	local model1 1
	local output 0
	local first	// starts empty
	while `model1' <= `nmodel' {
		local COEFN : copy local coefn
		local model2 = min(`nmodel', `model1'+`nmodblock'-1)
		global T_ET_ncol = `model2' - `model1'+ 1

		if inlist("`style'", "nolines", "columns") {
			local cols
			forvalues j = `model1' / `model2' {
		    		local cols `"`cols' `""'"'
			}
			if "`star'" == "" {
				local newline `"DLine2 0 ralign res `cols'"'
			}
			else {
				local newline `"StarLine2 0 ralign res `cols'"'
			}
			if "`style'" == "columns" {
				local nextra = `model2' - `model1' + 1
				local wextra = $T_ET_cw + 2
				local extraopts	nextra(`nextra')	///
						wextra(`wextra')
			}
		}

		// header

		Header "Variable" `"`models'"' `model1' `model2'

		// coefficients panel

		local i 0
		forval ieq = 1/`k_eq' {
		    if `numeq' > 1 {
			if `ieq' != 1 {
				CenterLine
			}
			_ms_eq_display,	matrix(`bc')	///
					row		///
					eq(`ieq')	///
					width($T_ET_vw)	///
					`vbar'		///
					`extraopts'
		    	`newline'
		    }

		    forval el = 1/`k_eq`ieq'' {
		    	local ++i

			// coefficients (standard and starred-version)
			gettoken cn COEFN : COEFN
			local CN
			if "`label'" != "" {
				_ms_parse_parts `cn'
				if r(type) == "variable" {
					if "`cn'" == "_cons" {
						local CN  Constant
					}
					else if "`r(ts_op)'" == "" {
						local CN : var label `cn'
					}
				}
			}

			Check4Continue `bc' `i', `diopts'
			if `s(continue)' {
				local first first
				continue
			}

			local cols
			if "`star'" == "" {
				forvalues j = `model1' / `model2' {
				    Bvalue f : `bfmt' `bc'[`i',2*`j'-1] `eform'
				    local cols `"`cols' `"`f'"'"'
				}
			}
			else {
				forvalues j = `model1' / `model2' {
					BSvalue f fs : `bfmt' `bc'[`i',2*`j'-1] ///
					   `bc'[`i',2*`j'] `df_r'[`j',1] `eform'
					local cols `"`cols' `"`f'"' `"`fs'"'"'
				}
			}
			if "`CN'" != "" {
				if "`star'" == "" {
				    DLine `"`CN'"' ralign txt ralign res `cols'
				}
				else {
				    StarLine `"`CN'"' ralign txt ralign res `cols'
				}
				    local first first
			}
			else {
				_ms_display,	matrix(`bc')		///
						row			///
						element(`el')		///
						equation(#`ieq')	///
						width($T_ET_vw)		///
						`first'			///
						`diopts'		///
						`vbar'			///
						`extraopts'
				if r(output) {
					local first
					if !`output' {
						local output 1
						local diopts `DIOPTS'
					}
				}
				else {
					if r(first) {
						local first first
					}
					continue
				}
				if "`star'" == "" {
					DLine2 0 ralign res `cols'
				}
				else {
					StarLine2 0 ralign res `cols'
				}
			}

			// standard errors
			if "`se'" != "" {
				local cols
				forvalues j = `model1' / `model2' {
					SEvalue f : `sefmt' `bc'[`i',2*`j'] `bc'[`i',2*`j'-1] "`eform'"
					local cols `"`cols' `"`f'"'"'
				}
				DLine2 2 ralign res `cols'
			}

			// t-values
			if "`t'" != "" {
				local cols
				forvalues j = `model1' / `model2' {
					Tvalue f : `tfmt' `bc'[`i',2*`j'-1] `bc'[`i',2*`j']
					local cols `"`cols' `"`f'"'"'
				}
				DLine2 2 ralign res `cols'
			}

			// p-values
			if "`p'" != "" {
				local cols
				forvalues j = `model1' / `model2' {
					Pvalue f : `pfmt' `bc'[`i',2*`j'-1] `bc'[`i',2*`j'] `df_r'[`j',1]
					local cols `"`cols' `"`f'"'"'
				}
				DLine2 2 ralign res `cols'
			}
		    }
		}

		// statistics panel

		if "`st'" != "" {
			if "`newpanel'" != "" {
				BottomLine
				Header "Statistics" `"`models'"' ///
					`model1' `model2'
			}
			else {
				CenterLine
				if `numeq' > 1  {
					DLine "Statistics" lalign res center txt
				}
			}

			local nst = rowsof(`st')
			local stats : rownames `st'
			forvalues i = 1 / `nst' {
				local sn : word `i' of `stats'
				if "`sn'" == "N" {
					local ufmt %`cw'.0f
				}
				else {
					local ufmt : copy local stfmt
				}
				local cols
				forvalues j = `model1' / `model2' {
					StValue f : `ufmt' `st'[`i',`j']
					local cols `"`cols' `"`f'"'"'
					if "`star'" != "" {
						local cols `"`cols' `""'"'
					}
				}

				if "`star'" == "" {
					DLine    "`sn'" ralign txt ralign res `cols'
				}
				else {
					StarLine "`sn'" ralign txt ralign res `cols'
				}
			}
		}
		BottomLine

		local twidth = 1 + `hcol1' + $T_ET_ncol * `hcolr'
		if "`star'" != "" {
			dis as txt `"{ralign `twidth':legend: $T_ET_legend}"'
		}
		else if `"`se'`t'`p'"' != "" {
			local legend b
			if "`se'" != "" {
				local legend `legend'/se
			}
			if "`t'"  != "" {
				local legend `legend'/t
			}
			if "`p'"  != "" {
				local legend `legend'/p
			}
			dis as txt `"{ralign `twidth':legend: `legend'}"'
		}

		local model1 = `model2' + 1
		if `model1' <= `nmodel' {
			dis
		}
	}
end

program Check4Continue, sclass
	syntax anything [, ALLBASElevels BASElevels noOMITted noEMPTYcells *]
	gettoken bc i : anything
	local nobase	= "`allbaselevels'`baselevels'" == ""
	local noempty	: list sizeof emptycells
	local noomit	: list sizeof omitted

	sreturn clear
	sreturn local continue "0"
	if !(`nobase' | `noempty' | `noomit') {
		exit
	}

	local b	= cond(`nobase',  .b, .z)
	local e	= cond(`noempty', .e, .z)
	local o	= cond(`noomit',  .o, .z)

mata:	st_global("s(continue)",			///
	    strofreal(					///
		all(					///
		    st_matrix("`bc'")[`i',.] :== .z  :|	///
		    st_matrix("`bc'")[`i',.] :== `b' :|	///
		    st_matrix("`bc'")[`i',.] :== `e' :|	///
		    st_matrix("`bc'")[`i',.] :== `o'	///
		)					///
	    )						///
	)
end

// ===========================================================================
// OUTPUT STYLE CODED:
// program DisplayCodedV and its subroutines
// ===========================================================================

program HeaderCodedV
	args text models
	assert `:word count `models'' == $T_ET_ncol

	local ml 0
	foreach m of local models {
		local ml = max(`ml',length("`m'"))
	}
	local ml = min(`ml',$T_ET_mw)
	local i 0
	foreach m of local models {
		local abm`++i' = abbrev("`m'",`ml')
	}

	dis
	TopLineCoded
	forvalues j = `ml'(-1)1 {
		if `j' == 1 {
			dis as txt "$T_ET_ch0{ralign $T_ET_vw:`text'}" _c
		}
		else {
			dis as txt "$T_ET_ch0{space $T_ET_vw}" _c
		}
		dis as txt " $T_ET_ch1" _c

		forvalues i = 1/$T_ET_ncol {
			// should work after bug fix, reported 22aug2002
			// di as res %2s substr("`abm`i''",-`j',1) _c
			if length("`abm`i''") < `j' {
				dis "  " _c
			}
			else {
				dis as txt %2s substr("`abm`i''",-`j',1) _c
			}
		}
		dis as txt " $T_ET_ch2"
	}
	CenterLineCoded
end


program TopLineCoded
	HLineCoded "$T_ET_t0" "$T_ET_t1" "$T_ET_t3"
end


program CenterLineCoded
	HLineCoded "$T_ET_c0" "$T_ET_c1" "$T_ET_c3"
end


program BottomLineCoded
	HLineCoded "$T_ET_b0" "$T_ET_b1" "$T_ET_b3"
end


program HLineCoded
	args ch0 ch1 ch2
	dis as txt "`ch0'{hline $T_ET_vw}{c -}`ch1'{c -}{hline $T_ET_hw}{c -}`ch2'"
end


program DLineEQ
	args txt
	dis as txt "$T_ET_ch0" ///
	    as res "{lalign $T_ET_vw:`txt'} " ///
	    as txt "$T_ET_ch1 {space $T_ET_hw} $T_ET_ch2"
end


program DLineCodedV
	args txt
	mac shift

	if $T_ET_vw > 32 {
		local txt = substr(`"`txt'"',1,$T_ET_vw)
	}
	else {
		local txt = abbrev(`"`txt'"',$T_ET_vw)
	}
	dis as txt "$T_ET_ch0{ralign $T_ET_vw:`txt'} $T_ET_ch1" _c
	forvalues i = 1 / $T_ET_ncol {
		dis as res cond("``i''"=="1"," *","  ") _c
	}
	dis as txt " $T_ET_ch2"
end

program DLineCodedV2
	forvalues i = 1 / $T_ET_ncol {
		dis as res cond("``i''"=="1"," *","  ") _c
	}
	dis as txt " $T_ET_ch2"
end


program DisplayCodedV

	syntax anything [,	VARwidth(str)		///
				MODELwidth(int 12)	///
				Label			///
				STYle(str)		///
				TItle(str)		///
				NEWpanel		///
				ALLBASElevels		///
				NOBASElevels		///
				BASElevels		///
				noOMITted		///
				noEMPTYcells		///
				vsquish			///
		]

	_get_diopts diopts,	`allbaselevels'	///
				`nobaselevels'	///
				`baselevels'	///
				`omitted'	///
				`emptycells'	///
				`vsquish'
	local DIOPTS : copy local diopts
	if !`:list posof "vsquish" in diopts' {
		local diopts `diopts' vsquish
	}

	local bc   : word 1 of `anything'
	local df_r : word 2 of `anything'
	local st   : word 3 of `anything'

	confirm matrix `bc'
	confirm matrix `df_r'
	if "`st'" != "" {
		confirm matrix `st'
	}

	if "`varwidth'" == "" {
		local varwidth = cond("`label'"=="",12,24)
	}
	else {
		capt confirm integer number `varwidth'
		if _rc {
			dis as err "option varwidth() incorrectly specified"
			exit 198
		}
	}

	local coefn  : rownames `bc', quote
	local colb   : coleq `bc', quote
	local colb   : list clean colb
	local models : list uniq colb
	local nmodel : list sizeof models

	local eqnames : roweq `bc', quote
	local eqnames : list clean eqnames
	local uniqeq  : list uniq eqnames
	local numeq   : list sizeof uniqeq

	ChkStyle `style'
	local style `s(style)'
	if "`style'" == "nolines" {
		local vbar novbar nov1bar v1space
	}
	else if "`style'" == "columns" {
		local vbar v0bar
	}
	else {
		local newline di
	}
	if inlist("`style'", "nolines", "columns") {
		local cols
		forvalues j = 1 / `nmodel' {
			local cols `"`cols' `"0"'"'
		}
		local newline `"DLineCodedV2 `cols'"'
		if "`style'" == "columns" {
			local nextra = 1
			local wextra = 2*`nmodel' + 1
			local extraopts	nextra(`nextra')	///
					wextra(`wextra')
		}
	}

	// check if table fit within linesize

	global T_ET_ncol `nmodel'
	if "`label'" != "" {
		global T_ET_vw = max(`varwidth',8) // width for varname labels
	}
	else {
		global T_ET_vw = clip(`varwidth',8,32)   // width for varnames
	}
	global T_ET_mw = clip(`modelwidth',2,32) // width for model names
	global T_ET_hw = 2*`nmodel'-1
	local  twidth  = $T_ET_vw + $T_ET_hw + 2*("$T_ET_ch1"!="")

	if `: set linesize' < `twidth' {
		dis as err "too many models to fit on screen"
		exit 198
	}

	_ms_eq_info, matrix(`bc') row
	local k_eq = r(k_eq)
	forval ieq = 1/`k_eq' {
		local k_eq`ieq' = r(k`ieq')
		local eq`ieq' = r(eq`ieq')
	}

// header

	if `"`title'"' != "" {
		dis _n as txt `"{p}`title'"'
	}
	HeaderCodedV "Variable" `"`models'"'

// coefficients panel

	local holdeq
	local output 0
	local first	// starts empty
	local i 0
	forval ieq = 1/`k_eq' {
	    if `numeq' > 1 {
		if `ieq' != 1 {
			CenterLineCoded
		}
		_ms_eq_display,	matrix(`bc')	///
				row		///
				eq(`ieq')	///
				width($T_ET_vw)	///
				`vbar'		///
				`extraopts'
	    	`newline'
	    }

	    forval el = 1/`k_eq`ieq'' {
	    	local ++i

		gettoken cn coefn : coefn
		local CN
		if "`label'" != "" {
			_ms_parse_parts `cn'
			if r(type) == "variable" {
				if "`cn'" == "_cons" {
					local CN  Constant
				}
				else if "`r(ts_op)'" == "" {
					local CN : var label `cn'
				}
			}
		}

		Check4Continue `bc' `i', `diopts'
		if `s(continue)' {
			quietly					///
			_ms_display,	matrix(`bc')		///
					row			///
					element(`el')		///
					equation(#`ieq')	///
					width($T_ET_vw)		///
					`first'			///
					`diopts'
			if r(first) {
				local first first
			}
			continue
		}

		local cols
		forvalues j = 1 / `nmodel' {
			local f = (`bc'[`i',2*`j'-1] != .z)
			local cols `"`cols' `"`f'"'"'
		}
		if "`CN'" != "" {
			DLineCodedV `"`CN'"' `cols'
			local first first
		}
		else {
			_ms_display,	matrix(`bc')		///
					row			///
					element(`el')		///
					equation(#`ieq')	///
					width($T_ET_vw)		///
					`first'			///
					`diopts'		///
					`vbar'			///
					`extraopts'
			if r(output) {
				local first
				if !`output' {
					local output 1
					local diopts `DIOPTS'
				}
			}
			else {
				if r(first) {
					local first first
				}
				continue
			}
			DLineCodedV2 `cols'
		}
	    }
	}

// statistics panel

	if "`st'" != "" {
		if "`newpanel'" != "" {
			BottomLineCoded
			HeaderCodedV "Statistics" `"`models'"'
		}
		else {
			CenterLineCoded
			if `numeq' > 1  {
				DLineEQ "Statistics"
			}
		}
		local stats : rownames `st'
		forvalues i = 1 / `=rowsof(`st')' {
			local cols
			forvalues j = 1 / `nmodel' {
				local f = (`st'[`i',`j']!=.z)
				local cols `"`cols' `"`f'"'"'
			}
			DLineCodedV "`:word `i' of `stats''" `cols'
		}
	}
	BottomLineCoded
end

// ===========================================================================
// General purpose subroutines
// ===========================================================================

program ChkFormat, rclass
	args fmt value

	capt local junk : display `fmt' `value'
	if _rc {
		dis as err "invalid display format `fmt'"
		exit 120
	}
	return local len = length("`junk'")
end


program ChkStar
	args star stardef

	if "`star'" != "" & "`stardef'" != "" {
		dis as err "options star and star() may not be combined"
		exit 198
	}

	if "`star'" != "" {
		// default stars
		global T_ET_p1  0.05
		global T_ET_p2  0.01
		global T_ET_p3  0.001
	}
	else {
		local stardef : list uniq stardef
		capt noi numlist `"`stardef'"' , min(3) max(3) sort range(>0 <1)
		if _rc {
			dis as err "invalid specification of star()"
			exit 198
		}
		global T_ET_p3 : word 1 of `r(numlist)'
		global T_ET_p2 : word 2 of `r(numlist)'
		global T_ET_p1 : word 3 of `r(numlist)'
	}

	global T_ET_sym1   "*"
	global T_ET_sym2   "**"
	global T_ET_sym3   "***"
	global T_ET_lsym   3       // number of chars in p-symbols

	global T_ET_legend "* p<$T_ET_p1; ** p<$T_ET_p2; *** p<$T_ET_p3"
end


// sets a series of globals with SMCL code separating columns
//
//   T_ET_ch0  at the beginning of a line
//   T_ET_ch1  after the first and second column
//   T_ET_ch2  between any other two columns
//   T_ET_ch3  at the end of a line
//
program ChkStyle, sclass
	args style

	if `"`style'"' == "" {
		local style oneline
	}
	local len = length("`style'")
	if substr("columns",1,`len') == `"`style'"' {

		local style columns
		global T_ET_ch0 "{c |} "
		global T_ET_ch1 "{c |}"
		global T_ET_ch2 "{c |}"

		global T_ET_t0  "{c TLC}{c -}"
		global T_ET_t1  "{c TT}"
		global T_ET_t2  "{c TT}"
		global T_ET_t3  "{c TRC}"

		global T_ET_c0  "{c LT}{c -}"
		global T_ET_c1  "{c +}"
		global T_ET_c2  "{c +}"
		global T_ET_c3  "{c RT}"

		global T_ET_b0  "{c BLC}{c -}"
		global T_ET_b1  "{c BT}"
		global T_ET_b2  "{c BT}"
		global T_ET_b3  "{c BRC}"
	}

	else if substr("oneline",1,`len') == `"`style'"' {

		local style oneline
		global T_ET_ch0
		global T_ET_ch1 "{c |}"
		global T_ET_ch2 "{space 1}"

		global T_ET_t0
		global T_ET_t1  "{c TT}"
		global T_ET_t2  "{c -}"
		global T_ET_t3  "{c -}"

		global T_ET_c0
		global T_ET_c1  "{c +}"
		global T_ET_c2  "{c -}"
		global T_ET_c3  "{c -}"

		global T_ET_b0
		global T_ET_b1  "{c BT}"
		global T_ET_b2  "{c -}"
		global T_ET_b3  "{c -}"
	}

	else if substr("nolines",1,`len') == `"`style'"' {

		local style nolines
		global T_ET_ch0
		global T_ET_ch1 "{space 1}"
		global T_ET_ch2 "{space 1}"

		global T_ET_t0
		global T_ET_t1  "{c -}"
		global T_ET_t2  "{c -}"
		global T_ET_t3  "{c -}"

		global T_ET_c0
		global T_ET_c1  "{c -}"
		global T_ET_c2  "{c -}"
		global T_ET_c3  "{c -}"

		global T_ET_b0
		global T_ET_b1  "{c -}"
		global T_ET_b2  "{c -}"
		global T_ET_b3  "{c -}"
	}

	else {
		dis as err `"`style' is invalid style() specification"'
		exit 198
	}
	sreturn local style `style'
end
exit
