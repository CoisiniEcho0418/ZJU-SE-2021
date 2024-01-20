*! version 1.1.0  07jan2011
program areg_footnote
	version 12

	local c1 = `"`s(width_col1)'"'
	capture confirm integer number `c1'
	if c(rc) {
		local c1 12
	}
	else {
		local c1 = `c1' - 1
	}
	if `"`e(prefix)'"' != "" | `"`e(vcetype)'"' == "Robust" { 
		FooterR `c1'
	}
	else {
		Footer `c1'
	}
end

program Footer
	args c1
	local dfa1  = e(df_a) + 1
	local skip2 = max(14-length(`"`dfa1'"')-2,0)
	local todisp `"F(`e(df_a)', `e(df_r)') = "'
	local skip3 = max(23-length(`"`todisp'"')-2,0)

	di in smcl in gr %`c1's  abbrev(`"`e(absvar)'"',`c1') " {c |}" /*
	*/ _skip(`skip3') `"`todisp'"' /*
	*/ in ye %10.3f e(F_absorb) %8.3f fprob(e(df_a),e(df_r),e(F_absorb)) /*
	*/ in gr _skip(`skip2') `"(`dfa1' categories)"'
end

program FooterR
	args c1
	local skip  = 8 - length(`"`e(absvar)'"')
	local dfa1  = e(df_a) + 1
        local skip2 = max(44 - length(`"`dfa1'"')-4, 0)

        di in smcl in gr %`c1's abbrev(`"`e(absvar)'"',`c1') /*
	*/ " {c |}   absorbed" /*
        */ _skip(`skip2') `"(`dfa1' categories)"'
end
exit
