*! version 6.0.0 PR 18nov1998 Cribbed from xi_mkun and xi_mkun2 in xi.ado
program define frac_mun, sclass
/* meaning make_unique_name <suggested_name> [<purge>] */
	version 6
	args base purge
	sret clear
	local name = substr("I`base'",1,5)
	if "`purge'"=="purge" {	/* purge existing, crude but necessary */
		cap drop `name'*
	}
	else 	xi_mkun2 `name'_
end

program define xi_mkun2, sclass 
/* meaning make_unique_name <suggested_name> */
	args name

	local totry "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local lentot=length("`totry'")
	local l 0
	local len = length("`name'")
	capture list `name'* in 1		/* try name out */
	while _rc==0 {
		if `l'==`lentot' {
			di in red "too many terms---limit is " `lentot'+1
			exit 499
		}
		local l=`l'+1
		local name = substr("`name'",1,`len'-1)+substr("`totry'",`l',1)
		capture list `name'* in 1
	}
	sret local name "`name'"
end

