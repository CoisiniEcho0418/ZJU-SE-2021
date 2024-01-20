*! version 2.0.0
program define typeof
	version 6.0
	local i 1
	while "``i''" != "" {
		local i = `i' + 1
	}
	local i = `i'-1
	local type "``i''"
	local `i'
	local varlist "req ex"
	parse "`*'"
	parse "`varlist'", parse(" ")

	local i 1
	while "``i''" != "" { 
		local vtyp : type ``i''
		if "`vtyp'" != "`type'" {
			if "`type'"=="str" { 
				if substr("`vtyp'",1,3)!="str" {
					local bad yes
				}
			}
			else	local bad yes
			if "`bad'"=="yes" {
				di in red "typeof:  " /*
				*/ "variable ``i'' is `vtyp', not `type'"
				exit 9
			}
		}
		local i = `i' + 1
	}

end
