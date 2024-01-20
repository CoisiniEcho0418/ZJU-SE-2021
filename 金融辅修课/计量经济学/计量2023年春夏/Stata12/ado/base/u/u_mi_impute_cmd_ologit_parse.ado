*! version 1.0.0  02jul2011
program u_mi_impute_cmd_ologit_parse, sclass
	version 12
	// preliminary syntax check
	syntax [anything(equalok)] [if] [fw pw iw],		///
			impobj(string)				/// //internal
		[						/// 
			NOCONStant				///
			OFFset(passthru)			///
			AUGment					///
			BOOTstrap				///
			NOCMDLEGend				/// //undoc.
			NOFVLEGend				/// //undoc.
			AUGNOIsily				/// //undoc.
			NOPPCHECK				/// //undoc.
			nredraws(integer 100)			/// //undoc.
			NOFVREVAR				/// //internal
			*					///
		]
	opts_exclusive "`augment' `bootstrap'"
	if ("`noconstant'"!="") {
		di as err "option `noconstant' not allowed"
		exit 198
	}
	if ("`weight'"=="iweight" & "`augment'"!="") {
		di as err "`weight' not allowed with option {bf:augment}"
		exit 101
	}
	if ("`nocmdlegend'"!="") {
		local nofvlegend nofvlegend
	}
	mata:   `impobj'.augment = ("`augment'"!=""); 	///
		`impobj'.maxredraw = `nredraws'
	u_mi_get_maxopts maxopts uvopts : `"`options'"'
	local cmdopts `offset' `maxopts'
	local uvopts `uvopts' `nocmdlegend' `bootstrap'
	if ("`weight'"!="") { // accommodates default weights
		local wgtexp [`weight' `exp']
	}
	local cmd ologit
	u_mi_impute_cmd_uvmethod_parse `anything' `if' `wgtexp', 	///
		impobj(`impobj') method(ologit) cmdopts(`cmdopts')	///
		`uvopts' cmdname(ologit) cmd(`cmd')

	sret local cmdlineinit `"`s(cmdlineinit)' "`augment'" "`nofvlegend'" "`augnoisily'" "`noppcheck'""'
	if ("`augment'"!="" & "`nofvrevar'"=="") {
		// to handle factor variables during augmented regression
		sret local cmdlineimpute `"`s(cmdlineimpute)' "`s(xlist)'""'
	}
end
