*! version 3.1.0  30oct2008

program define asprobit_p, sortpreserve
	version 10

	if "`e(cmd)'"!="asmprobit" & "`e(cmd)'"!="asroprobit" {
		di as error "{p}{help asmprobit##|_new:asmprobit} or "    ///
		"{help asroprobit##|_new:asroprobit} estimation results " ///
		"not found{p_end}"
		exit 301
	}
	syntax anything(name=vlist id="varlist") [if] [in] [, SCores ///
		Pr pr1 xb stdp altwise force ]

	/* undocumented: 						*/
	/*  force - ignore alternative labels in variable e(altvar) 	*/
	/* 	    and relabel values using e(alt_i), i=1,...,e(k_alt) */
	/*  pr1   - synonymous to pr for asmprobit			*/

	local opt `pr' `pr1' `xb' `stdp' `scores'

	local nopt : word count `opt'
	if `nopt' > 1 {
/*****************************************************************************/
	di as err "only one prediction type allowed; see "                  ///
	 "{help `e(cmd)' postestimation##predict:`e(cmd)' postestimation} " ///
	 "for the prediction type options"
	exit 198
/*****************************************************************************/
	}
	marksample touse, novarlist

	tempname b V
	mat `b' = e(b)

	if "`opt'" == "scores" {
		local nb = colsof(`b')

		_stubstar2names `vlist', nvars(`nb') singleok noverify

		local varlist `"`s(varlist)'"'
		local typlist `"`s(typlist)'"'

		local nsc: word count `varlist'

		if `nsc' != `nb' {
			di as err "{p}need `nb' new variable names, or " ///
			 "use the {it:stub}{bf:*} wildcard syntax{p_end}"
			exit 198
		}
	}
	else {
		local 0 `vlist'
		syntax newvarlist(min=1 max=1)
		if "`opt'" == "" {
			local opt pr
			di as gr "(option pr assumed; Pr(`e(altvar)'))"
		}

	}
	local type: word 1 of `typlist'
	if "`type'"!="double" & "`type'"!="float" {
		di as err "{p}type must be double or float; the default " ///
		 "is c(type) = `c(type)'{p_end}"
		exit 198
	}
	local ranked = ("`e(cmd)'"=="asroprobit")

	/* always altwise markout for xb and stdp			*/
	if ("`opt'"=="xb" | "`opt'"=="stdp") local markout altwise
	else local markout `altwise' case 

	/* scores and rank probabilities need the dependent variable	*/
	if ("`opt'"=="scores") local markout `markout' depvar
	else if (`ranked' & "`opt'"=="pr") local markout `markout' depvar
	
	/* markout singletion cases					*/
	if (substr("`opt'",1,2)=="pr") local markout `markout' singleton

	tempname model

	.`model' = ._`e(cmd)'model.new
	local vv = cond("`e(opt)'"=="ml", "10.1", "11")
	version `vv': ///
	.`model'.eretget, touse(`touse') markout(`markout') avopts(`force')

	if "`scores'" != "" {
		.`model'.predscores `typlist' `varlist', b(`b') 
	}
	else {
		mat `V' = e(V)
		.`model'.predict `typlist' `varlist', b(`b') v(`V') opt(`opt') 
	}
end

exit
