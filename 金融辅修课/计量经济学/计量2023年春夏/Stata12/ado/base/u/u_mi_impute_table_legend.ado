*! version 1.0.0  24feb2011
program u_mi_impute_table_legend
	version 12
	args name legend colonpos font

	if ("`name'"=="") exit

	if ("`colonpos'"=="") {
		local colonpos 15
	}
	if ("`font'"=="") {
		local font txt
	}
	local name = abbrev("`name'", `colonpos'-1)
	local pos = `colonpos'-1-strlen("`name'")
	di as txt `"{p `pos' `colonpos' 2}{`font':`name'}: `legend'{p_end}"'
end
