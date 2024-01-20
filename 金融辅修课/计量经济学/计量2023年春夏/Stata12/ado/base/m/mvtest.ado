*! version 1.0.2  13nov2008
program mvtest, byable(onecall)
	version 11

	if _by() {
		local bycmd "by `_byvars' :"
	}

	if `"`0'"'=="" {
		dis as err "subcommand and {it:varlist} required"
		exit 198
	}

	gettoken cmd rest : 0
	local lcmd = length("`cmd'")

	if "`cmd'" == substr("means", 1, max(1,`lcmd')) {
		`bycmd' mvtest_mean `rest'
	}
	else if "`cmd'" == substr("covariances", 1, max(3,`lcmd')) {
		`bycmd' mvtest_cov `rest'
	}
	else if "`cmd'" == substr("correlations", 1, max(4,`lcmd')) {
		`bycmd' mvtest_corr `rest'
	}
/*
	else if "`cmd'" == substr("meancov", 1, max(7,`lcmd')) {
		`bycmd' mvtest_meancov `rest'
	}
*/
	else if "`cmd'" == substr("normality", 1, max(4,`lcmd')) {
		`bycmd' mvtest_norm `rest'
	}
	else {
		dis as err `"unknown subcommand of mvtest: `cmd'"'
		exit 198
	}
end
exit
