*! version 1.1.0  02feb2009
	
program _asprobit_vce_parserun, eclass 
	version 10

	_on_colon_parse `0'

	local 0 `s(after)'

	ParseWhichBy `s(before)'
	local which `s(which)'
	local by `s(by)'

	qui syntax [anything] [fw pw iw] [if] [in], case(varname) [ ///
		Cluster(varname) VCE(passthru) *]

	local call `0'
	sreturn clear
	if  ("`vce'"=="") exit 

	local case0 "`case'"
	tempname id
	_vce_cluster `which',		///
		groupvar(`case')	///
		newgroupvar(`id')	///
		groptname(case)		///
		`vce'			///
		cluster(`cluster')
	local vce `"`s(vce)'"'
	local idopt `s(idopt)'
	local clopt `s(clopt)'
	local gropt `s(gropt)'
	local bsgropt `s(bsgropt)'
	if "`weight'" != "" {
		local wgt [`weight'`exp']
	}
	local vceopts jkopts(`clopt' notable noheader)               ///
		bootopts(`clopt' `idopt' `bsgropt' notable noheader) ///
		required(BASEalternative SCALEalternative)     

	`by' _vce_parserun `which', `vceopts'	: ///
		`anything' `wgt' `if' `in',       ///
		`gropt' `vce' `options'
	if "`s(exit)'" != "" {
		ereturn local case `case'
		ereturn local clustvar `cluster'
		if "`cluster'" == "" {
			local cmd1 `"`e(command)'"'
			local cmd2 : subinstr local cmd1 "`id'" ///
				"`case'"
			ereturn local command `"`cmd2'"'
		}
		local 0 , `options'
		syntax [, Level(string asis) * ]
		if ! `:length local level' {
			local level `"`s(level)'"'
		}

		_get_diopts diopts options, `options'
		_asprobit_replay, level(`level') `diopts'
		Exit0
		exit
	}
end

program Exit0, sclass

	sreturn local exit = 1
end

program ParseWhichBy, sclass
	syntax name(name=which id="program name") [, by(string) ]

	sreturn local which `which'
	sreturn local by `by'
end

exit	

