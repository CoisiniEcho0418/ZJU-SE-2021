*! version 10.0.1  08oct2007

program define nlogit_p, sortpreserve
	version 10
	if "`e(cmd)'" != "nlogit" {
		di as error "{p}{help nlogit##|_new:nlogit} estimation " ///
		 "results not found{p_end}"
		exit 301
	}

	syntax anything(name=vlist id="varlist") [if] [in] [, SCores ///
		Pr xb condp iv altwise force hlevel(string) ]

	/* undocumented: 						*/
	/*  force - ignore alternative labels in variable e(altvar) 	*/
	/* 	    and relabel values using e(alt_i), i=1,...,e(k_alt) */

	local star = (strpos(`"`vlist'"',"*")==strlen(`"`vlist'"'))
	local opt `pr' `xb' `condp' `iv' `scores'

	local nopt : word count `opt'
	if `nopt' > 1 {
/*****************************************************************************/
	di as err "only one prediction type allowed; see "             ///
 	 "{help nlogit postestimation##predict:nlogit postestimation} " ///
	 "for the prediction type options"
	exit 198
/*****************************************************************************/
	}
	local opt : list retokenize opt
	if "`opt'" == "" {
		local opt pr
		local default = 1
	}
	else local default = 0

	tempname b
	mat `b' = e(b)

	local nlev = e(levels)
	if "`opt'" == "scores" {
		if "`hlevel'" != "" {
			di as err "{p}hlevel() cannot be specified with " ///
			 "the scores option{p_end}"
			
			exit 184
		}

		local nv = colsof(`b')
		local hlevel = 0
	}
	else {
		local i1 = 1
		if "`opt'" == "iv" {
			if `nlev' == 1 {
				di as err "{p}the model has only one "    ///
				 "level so there are no inclusive values" ///
				 "{p_end}"
				exit 322
			}
			local i1 = 2	
		}
		if "`hlevel'" != "" {
			tempname s
			cap scalar `s' = `hlevel'
			if (_rc) local hlevel = 0
			else if (`s'!=trunc(`s')) local hlevel = 0

			if (`hlevel'<`i1' | `hlevel'>`nlev') {
				di as err "{p}hlevel() must be an integer " ///
				 "greater than or equal to `i1' and less "  ///
				 "than or equal to `nlev'{p_end}"
				exit 198
			}
			local nv = 1
		}
		else {
			local nv = `nlev'
			local hlevel = 0
		}
	}
	_stubstar2names `vlist', nvars(`nv') noverify

	local varlist `"`s(varlist)'"'
	local typlist `"`s(typlist)'"'
	local type: word 1 of `typlist'
	if "`type'"!="double" & "`type'"!="float" {
		di as err "{p}type must be double or float; the default " ///
		 "is c(type) = `c(type)'{p_end}"
		exit 198
	}
	if "`opt'" == "iv" & `hlevel'==0 {
		if `star' {
			/* iv* starts with iv2				*/
			local v1 : word 1 of `varlist' 
			local varlist : list varlist - v1
		}
		local nv = `nv' - 1
	}

	local nvl : word count `varlist'
	if `default' & `hlevel'<=0 & `nvl'==1 {
		/* providing one new variable using default pr implies	*/
		/* base level						*/
		local hlevel = `nlev'
		local nv = 1
	}
	if `nvl' != `nv' {
		di as err "{p}need `nv' new variable name" _c
		if `nv' > 1 {
			di as err "s, or use the {it:stub}{bf:*} wildcard " ///
			 "syntax"
		}
		di "{p_end}"
		exit 198
	}
	if `default' {
		if `hlevel' > 0 {
			if `hlevel' == `nlev' {
				di in gr "(option pr assumed; Pr(`e(altvar)'))"
			}
			else {
				di in gr "(option pr assumed; " ///
				 "Pr(`e(altvar`hlevel')'))" 
			}
		}
		else di in gr "(option pr assumed)" 
	}
	if (`hlevel' > 0) local levopt level(`hlevel')
	/* always altwise markout for xb				*/
	if ("`opt'"=="xb") local markout altwise
	else local markout `altwise' case 
	/* scores need the dependent variable				*/
	if ("`opt'"=="scores") local markout `markout' depvar
	/* markout singletion cases					*/
	if ("`opt'"=="pr") local markout `markout' singleton

	marksample touse, novarlist

	tempname model

	.`model' = ._nlogitmodel.new
	.`model'.eretget, touse(`touse') markout(`markout') ///
		avopts(`force' `altwise')

	if "`scores'" != "" {
		.`model'.predscores `typlist' `varlist', b(`b') 
	}
	else {
		.`model'.predict `typlist' `varlist', b(`b') opt(`opt') ///
			`levopt' 
	}
end 

