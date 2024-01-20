*! version 1.0.1  21may2007
program mds_parse_cdopts, sclass
	version 10
	args opts classical

	local 0, `opts'
	if `"`classical'"' != "" {

		syntax [, ADDconstant NORMalize(passthru) FORCE ///
		          noPLot CONfig NEIGen(passthru) *]
		
		if "`options'" != "" {
			dis as err "options not allowed with classical MDS:"
			dis as err `"`options'"'
			exit 198
		}

		local copts  `addconstant' `normalize' `force'
		local dopts  `plot' `config' `neigen'
	}
	else {
		#del ;	
		syntax [, WEIght(name) INITialize(passthru) NORMalize(passthru)
			  FORCE ITERate(passthru) noLOg TRace GRADient
			  TOLerance(passthru) LTOLerance(passthru)
			  protect(passthru) sdprotect(passthru) noPLot CONfig
			  LOSS(string) TRANSform(string) * ] ;
		#del cr
		
		if "`loss'" != "" {
			di as err "may specify only one loss() criterion"
			exit 198
		}
		if "`transform'" != "" {
			di as err "may specify only one transform() option"
			exit 198
		}
		if "`options'" != "" {
			dis as err "options not allowed with modern MDS:"
			dis as err `"`options'"'
			exit 198
		}

		local copts  `weight' `initialize' `normalize' `force' ///
		             `iterate' `log' `trace' `gradient' `tolerance' ///
		             `ltolerance' `protect' `sdprotect'
		local dopts  `plot' `config'
	}
	#del cr

	sreturn clear
	sreturn local copts `copts' // computation options
	sreturn local dopts `dopts' // display     options
end
exit
