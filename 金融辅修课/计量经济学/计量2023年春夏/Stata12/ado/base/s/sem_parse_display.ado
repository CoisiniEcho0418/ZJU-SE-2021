*! version 1.1.0  07jun2011
program sem_parse_display
	version 12

	syntax	namelist(max=2)			///
		[,	STANDardized		///
			SHOWGinvariant		///
			noLABel			///
			noHEADer		///
			noTABle			///
			noFOOTnote		///
			wrap(numlist max=1)	///
			*			///
	]
	local K : list sizeof namelist
	gettoken c_diopts c_opts : namelist

	if "`wrap'" != "" {
		local wrap wrap(`wrap')
	}

	if `K' == 2 {
		_get_diopts diopts options, `options'
	}
	else {
		_get_diopts diopts, `options'
	}
	local diopts	`diopts'		///
			`wrap'			///
			`standardized'		///
			`showginvariant'	///
			`label'			///
			`header'		///
			`table'			///
			`footnote'		///
						 // blank

	c_local `c_diopts' `"`diopts'"'
	if `K' == 2 {
		c_local `c_opts' `"`options'"'
	}
end
