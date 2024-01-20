*! version 1.0.0  04feb2011
program u_mi_impute_check_ivars
	version 12
	args unabivars colon ivars ivarsmax
	local errindent 0 4 2
	if (`"`ivars'"'=="") {
		di as err "{p `errindent'}"	///
			"imputation (left-hand-side) variable required{p_end}"
		exit 100
	}
	_fv_check_depvar `ivars'
	unab ivars : `ivars'
	local p: word count `ivars'
	if ("`ivarsmax'"!="") {
		if (`p'>`ivarsmax') {
			di as err "{p `errindent'}"	///
			  "too many imputation variables specified{p_end}"
			exit 103
		}
	}
	confirm numeric variable `ivars'
	// ivars must be registered as imputed
	local imputed	`_dta[_mi_ivars]'
	local bad `ivars'
	unab  bad: `bad'
	local bad: list bad - imputed
	if ("`bad'"!="") {
		di as err "{p `errindent'}{bf:`bad'}: must be registered " ///
			 "as imputed; see " ///
  			 "{helpb mi register:{bind:mi register}}{p_end}"
		exit 198
	}
	c_local `unabivars' `ivars'
end
