*! version 1.0.2  15may2006
program estat_vce_only
	version 9

	gettoken sub 0 : 0, parse(" ,")
	local lsub : length local sub
	if "`e(cmd)'" == "" {
		error 301
	}
	if inlist(`"`sub'"', "", ",") {
		di as err "subcommand expected"
		exit 198
	}
	if `"`sub'"' == substr("bootstrap",1,max(4,`lsub')) {
		_bs_display `0'
		exit
	}
	if `"`sub'"' == "sd" {
		svy_estat sd `0'
		exit
	}
	if `"`sub'"' == "vce" {
		estat_default vce `0'
		exit
	}
	di as err "invalid subcommand `sub'"
	exit 321
end
exit
