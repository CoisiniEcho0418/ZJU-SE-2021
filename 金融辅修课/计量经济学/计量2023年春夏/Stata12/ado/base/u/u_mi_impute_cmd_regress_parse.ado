*! version 1.0.0  20feb2011
program u_mi_impute_cmd_regress_parse
	version 12	
	// preliminary syntax check
	syntax [anything(everything equalok)] [aw fw pw iw],	///
			impobj(string)			/// //internal
		[					/// 
			NOCONStant			///
			*				/// //common univ. opts
		]
	if ("`weight'"!="") { // accommodates default weights
		local wgtexp [`weight' `exp']
	}
	u_mi_impute_cmd_uvmethod_parse `anything' `wgtexp',		///
		impobj(`impobj') method(regress) cmd(_regress)		///
		cmdopts(`noconstant') `noconstant' `options'
end
