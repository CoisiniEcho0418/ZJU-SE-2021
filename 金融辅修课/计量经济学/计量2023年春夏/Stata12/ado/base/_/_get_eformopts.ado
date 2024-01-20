*! version 1.1.1  26feb2009
program _get_eformopts, sclass
	version 8.0
	syntax [, eformopts(string asis) soptions ALLOWed(string) ]
	local 0 , `eformopts'

	// hold all other options in `opts'
	// NOTE: additions to 'EFALL' should also be made in
	// _check_eformopts.ado
	local EFALL NOHR hr NOSHR shr or IRr RRr tr
	if "`soptions'" != "" {
		syntax [, EForm1(passthru) EForm `EFALL' * ]
		local opts `"`options'"'
		local 0 , `eform1' `eform' `nohr' `hr' `noshr' `shr' ///
			  `or' `irr' `rrr' `tr'
	}

	if "`allowed'" == "__all__" {
		local allowed `EFALL'
	}
	foreach ef of local allowed {
		capture confirm name `ef'
		if _rc {
			di as err "`ef' is not a valid name"
			exit 198
		}
		local efopts `efopts' `=lower("`ef'")'
	}
	local efopts : list uniq efopts
	syntax [, EForm1(string) EForm `allowed' ]

	foreach ef of local efopts {
		local eform `eform' ``ef''
	}
	local k : list sizeof eform
	if `k' {
		opts_exclusive "`eform'"
		if `:length local eform1' {
			opts_exclusive "eform() `eform'"
		}
	}
	if `k' {
		     if ("`eform'"=="eform") local eform1 = "exp(b)"
		else if ("`eform'"=="hr")    local eform1 = "Haz. Ratio"
		else if ("`eform'"=="shr")   local eform1 = "SHR"
		else if ("`eform'"=="tr")    local eform1 = "Tm. Ratio"
		else if ("`eform'"=="or")    local eform1 = "Odds Ratio"
		else if ("`eform'"!="nohr") & ("`eform'"!="noshr") {
			local eform1 = upper("`eform'")
		}
	}
	sreturn clear
	sreturn local options `"`opts'"'
	sreturn local opt `eform'
	sreturn local str `eform1'
	if `"`eform1'"' != "" {
		sreturn local eform eform(`"`eform1'"')
	}
	else	sreturn local eform ""
end

exit
