*! version 1.1.0  30oct2008

program define asclogit_p, sortpreserve
	version 10
	if "`e(cmd)'" != "asclogit" {
		di as err "{p}{help asclogit##|_new:asclogit} estimation " ///
		 "results not found{p_end}"
		exit 301
	}
	syntax anything(name=vlist id="varlist") [if] [in] [, SCores ///
		Pr xb stdp noOFFset altwise k(string) force]

	/* undocumented: 						*/
	/*  force - ignore alternative labels in variable e(altvar) 	*/
	/* 	    and relabel values using e(alt_i), i=1,...,e(k_alt) */

	local opt `pr' `pr1' `xb' `stdp' `scores'

	local nopt : word count `opt'
	if `nopt' > 1 {
/*****************************************************************************/
	di as err "only one prediction type allowed; see "                  ///
	 "{help asclogit postestimation##predict:asclogit postestimation} " ///
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
		if "`opt'" != "pr" & "`k'"!="" {
			di as err "{p}option k() may only be used with " ///
			 "option pr{p_end}"
			exit 184
		}
	}
	local type: word 1 of `typlist'
	if "`type'"!="double" & "`type'"!="float" {
		di as err "{p}type must be double or float; the default " ///
		 "is c(type) = `c(type)'{p_end}"
		exit 198
	}
	/* always altwise markout for xb and stdp			*/
	if ("`opt'"=="xb" | "`opt'"=="stdp") local markout altwise
	else local markout `altwise' case 

	/* scores and rank probabilities need the dependent variable	*/
	if ("`opt'"=="scores") local markout `markout' depvar
	else if ("`opt'"=="pr" & "`k'"=="observed") ///
		local markout `markout' depvar
	
	if ("`offset'"=="") local markout `markout' offset

	tempname model

	.`model' = ._asclogitmodel.new
	local vv = cond("`e(opt)'"=="ml", "10.1", "11")
	version `vv': ///
	.`model'.eretget, touse(`touse') markout(`markout') avopts(`force')

	if "`scores'" != "" {
		.`model'.predscores `typlist' `varlist', b(`b') 
	}
	else {
		mat `V' = e(V)
		.`model'.predict `typlist' `varlist', b(`b') v(`V') ///
			opt(`opt') `offset' k(`k') 
	}
end

exit
