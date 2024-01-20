*! version 1.3.0  20jun2011
program _get_diopts, sclass
	/* Syntax:
	 * 	_get_diopts <lmacname> [<lmacname>] [, <options>]
	 *
	 * Examples:
	 * 	_get_diopts diopts, `options'
	 * 	_get_diopts diopts options, `options'
	 */
	version 11

	local DIOPTS	Level(cilevel)		///
			vsquish			///
			NOALLBASElevels		/// [sic]
			ALLBASElevels		///
			NOBASElevels		/// [sic]
			BASElevels		///
			noCNSReport		///
			FULLCNSReport		///
			NOEMPTYcells		///
			EMPTYcells		///
			NOOMITted		///
			OMITted			///
			NOLSTRETCH		///
			LSTRETCH		///
			COEFLegend		///
			SELEGEND		///
			cformat(string)		///
			sformat(string)		///
			pformat(string)		///
			CODING			/// NOT DOCUMENTED
			COMPARE			/// NOT DOCUMENTED
						 // blank

	syntax namelist(max=2) [, `DIOPTS' *]

	opts_exclusive "`allbaselevels' `noallbaselevels'"
	opts_exclusive "`allbaselevels' `nobaselevels'"
	opts_exclusive "`baselevels' `nobaselevels'"
	opts_exclusive "`emptycells' `noemptycells'"
	opts_exclusive "`omitted' `noomitted'"
	opts_exclusive "`lstretch' `nolstretch'"
	opts_exclusive "`cnsreport' `fullcnsreport'"
	opts_exclusive "`coeflegend' `selegend'"
	local K : list sizeof namelist
	gettoken c_diopts c_opts : namelist

	opts_exclusive "`coding' `compare'"

	local allbaselevels `allbaselevels' `noallbaselevels'
	local baselevels `baselevels' `nobaselevels'
	local emptycells `emptycells' `noemptycells'
	local omitted `omitted' `noomitted'
	local lstretch `lstretch' `nolstretch'
	if "`allbaselevels'`baselevels'" == "" {
		if c(showbaselevels) == "all" {
			local allbaselevels allbaselevels
		}
		else if c(showbaselevels) == "on" {
			local baselevels baselevels
		}
	}
	if "`emptycells'" == "" {
		if c(showemptycells) == "off" {
			local emptycells noemptycells
		}
	}
	if "`omitted'" == "" {
		if c(showomitted) == "off" {
			local omitted noomitted
		}
	}
	if "`lstretch'" == "" {
		if c(lstretch) == "off" {
			local lstretch nolstretch
		}
	}

	if `:length local cformat' {
		confirm numeric format `cformat'
		sreturn local cformat `"`cformat'"'
		local cformat `"cformat(`cformat')"'
	}
	if `:length local sformat' {
		confirm numeric format `sformat'
		sreturn local sformat `"`sformat'"'
		local sformat `"sformat(`sformat')"'
	}
	if `:length local pformat' {
		confirm numeric format `pformat'
		sreturn local pformat `"`pformat'"'
		local pformat `"pformat(`pformat')"'
	}

	if `K' == 1 & `:length local options' {
		syntax namelist(max=2) [, `DIOPTS']
	}

	if reldif(`level', c(level)) > 1e-3 {
		local levelopt level(`level')
	}
	c_local `c_diopts'			///
			`levelopt'		///
			`vsquish'		///
			`allbaselevels'		///
			`baselevels'		///
			`cnsreport'		///
			`fullcnsreport'		///
			`emptycells'		///
			`omitted'		///
			`lstretch'		///
			`coeflegend'		///
			`selegend'		///
			`cformat'		///
			`sformat'		///
			`pformat'		///
			`coding'		///
			`compare'		///
						 // blank

	if `K' == 2 {
		c_local `c_opts' `"`options'"'
	}
	sreturn local coding `coding'
	sreturn local compare `compare'
	sreturn local level `level'
end
exit
