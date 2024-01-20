*! version 1.0.0  16feb2011
/*
	u_mi_impute_check_method <mac> : <method> <errout> <uvonly>

	checks <method> and returns unabbreviated name in <mac>
	The allowed methods are
		reg:ress
		pmm
		logi:t
		olog:it
		mlog:it
		poisson
		nbreg
		intreg
		truncreg
	and when <uvonly> is empty
		mon:otone
		chain:ed
		mvn

*/
program u_mi_impute_check_method
	version 12
	args mac colon method errout uvonly

	local l = strlen("`method'")

	if ("`method'"==substr("regress",1,max(3,`l'))) {
		c_local `mac' "regress"
		exit
	}
	if ("`method'"=="pmm") {
		c_local `mac' "pmm"
		exit
	}
	if ("`method'"==substr("logit",1,max(4,`l'))) {
		c_local `mac' "logit"
		exit
	}
	if ("`method'"==substr("mlogit",1,max(4,`l'))) {
		c_local `mac' "mlogit"
		exit
	}
	if ("`method'"==substr("ologit",1,max(4,`l'))) {
		c_local `mac' "ologit"
		exit
	}
	if ("`method'"=="poisson") {
		c_local `mac' "poisson"
		exit
	}
	if ("`method'"=="nbreg") {
		c_local `mac' "nbreg"
		exit
	}
	if ("`method'"=="intreg") {
		c_local `mac' "intreg"
		exit
	}
	if ("`method'"=="truncreg") {
		c_local `mac' "truncreg"
		exit
	}
	if ("`uvonly'"=="" & "`method'"==substr("monotone",1,max(3,`l'))) {
		c_local `mac' "monotone"
		exit
	}
	if ("`uvonly'"=="" & "`method'"==substr("chained",1,max(5,`l'))) {
		c_local `mac' "chained"
		exit
	}
	if ("`uvonly'"=="" & "`method'"=="mvn") {
		c_local `mac' "mvn"
		exit
	}
	if ("`errout'"=="") {
		local errout "{bf:mi impute}: "
	}
	else if ("`errout'"=="nothing") {
		local errout
	}
	else {
		local errout "{bf:`errout'}: "
	}
	if ("`method'"=="") {
		di as err `"`errout'imputation method must be specified"'
	}
	else {
		di as err `"`errout'invalid imputation method {bf:`method'}"'
	}
	exit 198
end
