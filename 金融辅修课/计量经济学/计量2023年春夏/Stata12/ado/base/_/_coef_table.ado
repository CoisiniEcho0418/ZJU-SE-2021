*! version 4.0.0  07jul2011
program _coef_table, rclass
	version 11
	if (!c(noisily) & c(coeftabresults) == "off") {
		exit
	}
	_check_eclass
	syntax [, BMATrix(passthru) VMATrix(passthru) * ]
	if "`e(b)'" == "" & "`e(V)'" == "" & "`bmatrix'`vmatrix'"=="" {
		exit
	}
	local mc_cmds contrast margins pwcompare pwmean
	local cmd "`e(cmd)'"
	local keepmc : list cmd in mc_cmds
	if inlist("`cmd'", "pwcompare", "pwmean") {
		local groups GROUPS
	}
	if "`cmd'" == "regress" {
		local beta Beta
	}
	if "`cmd'" == "sem" {
		local standardized STANDARDIZED
		local showginvariant SHOWGINVariant
		local nolabel NOLABel
		local nofootnote NOFOOTnote
		local wrap wrap(numlist max=1)
	}
	if "`e(mi)'"=="mi" {
		local dftable		DFTable
		local dfonly		DFONLY
		local noclustreport	NOCLUSTReport
		local pisematrix	PISEMATrix(string)
	}
	syntax [,				/// computation options
		cmdextras			/// NOT DOCUMENTED
		BMATrix(string)			///
		VMATrix(string)			///
		EMATrix(string)			///
		DFMATrix(string)		///
		ROWMATrix(string)		/// NOT DOCUMENTED 
		ROWCFormat(string)		/// NOT DOCUMENTED
		ROWPFormat(string)		/// NOT DOCUMENTED
		ROWSFormat(string)		/// NOT DOCUMENTED
		NOROWCI				/// NOT DOCUMENTED
		MMATrix(string)			/// NOT DOCUMENTED -pwcompare-
		MVMATrix(string)		/// NOT DOCUMENTED -pwcompare-
		BSTDMATrix(string)		/// NOT DOCUMENTED -sem-
		CNSMATrix(string)		///
		PCLASSMATrix(string)		/// NOT DOCUMENTED -sem-
		Level(cilevel)			///
		prefix(name)			/// NOT DOCUMENTED
		suffix(name)			/// NOT DOCUMENTED
						/// report options
		`beta'				/// table type
		`standardized'			/// table type
		pvonly				/// table type
		cionly				/// table type
		`dftable'			/// table type
		`dfonly'			/// table type
		`groups'			/// table type
		COEFLegend			/// table type
		selegend			/// table type
		`showginvariant'		/// NOT DOCUMENTED -sem-
		`nolabel'			/// NOT DOCUMENTED -sem-
		`nofootnote'			/// NOT DOCUMENTED -sem-
		`wrap'				/// NOT DOCUMENTED -sem-
		sort				///
		`pisematrix'			/// NOT DOCUMENTED -mi-
		depname(string)			/// NOT DOCUMENTED
		COEFTitle(string)		///
		coeftitle2(string)		/// NOT DOCUMENTED
		ptitle(string)			///
		cititle(string)			///
		NOMCLEGend			/// NOT DOCUMENTED
		noCNSReport			///
		FULLCNSReport			///
		`noclustreport'			/// NOT DOCUMENTED -mi-
		cformat(passthru)		///
		sformat(passthru)		///
		pformat(passthru)		///
		NOFirst				///
		First				///
		SHOWEQns			/// IGNORED
		neq(integer -1)			///
		NODIPARM			/// NOT DOCUMENTED
		NOTEST				///
		SEParator(integer 0)		///
		NOSKIP				///
		OFFSETONLY1			///
		PLus				///
		NOEQCHECK			/// used by -mi estimate-
		EFORMALL			/// NOT DOCUMENTED
		*				/// -eform/diparm- options
	]

	local type	`coeflegend'	///
			`selegend'	///
					 // blank
	opts_exclusive "`type' `standardized'"
	if (`"`rowmatrix'"'=="" & "`norowci'"!="") {
		di as err "{bf:norowci} requires {bf:rowmatrix()}"
		exit 198
	}
	if ("`dftable'"!="" & "`norowci'"!="") {
		di as err "{bf:norowci} is not allowed with {bf:`dftable'}"
		exit 198
	}
	if ("`dfonly'"!="" & "`norowci'"!="") {
		di as err "{bf:norowci} is not allowed with {bf:`dfonly'}"
		exit 198
	}
	if ("`pvonly'"!="" & "`norowci'"!="") {
		di as err "{bf:norowci} is not allowed with {bf:`pvonly'}"
		exit 198
	}
	if "`standardized'" != "" & "`bstdmatrix'" != "" {
		local beta beta
		local standardized
	}
	if `:length local type' == 0 {
		local type	`beta'		///
				`pvonly'	///
				`cionly'	///
				`dftable'	///
				`dfonly'	///
				`groups'	///
					 	// blank
	}
	opts_exclusive "`type'"
	opts_exclusive "`first' `nofirst'"
	opts_exclusive "`first' `showeqns'"
	local cnsreport `cnsreport' `fullcnsreport'
	opts_exclusive "`cnsreport'"
	if `"`showeqns'"' != "" {
		local nofirst nofirst
	}

	if `"`ematrix'`noeqcheck'"' == "" {
		if `"`e(error)'"' == "matrix" {
			local ematrix e(error)
		}
	}

	_get_mcompare, `options'
	local method	`"`s(method)'"'
	local all	`"`s(adjustall)'"'
	local options	`"`s(options)'"'
	if "`method'" != "noadjust" {
		local keepmc 1
	}
	opts_exclusive "`all' `groups'"
	if "`method'" == "dunnett" {
		opts_exclusive "`method' `groups'"
	}
	_get_diopts diopts options, `options'
	local legend coeflegend selegend
	local legend : list legend & diopts
	local diopts : list diopts - legend
	local lstretch lstretch nolstretch
	local lstretch : list lstretch & diopts
	local diopts : list diopts - lstretch

	_get_diopts ignore, `diopts' `cformat' `sformat' `pformat'
	local cformat `"`s(cformat)'"'
	local sformat `"`s(sformat)'"'
	local pformat `"`s(pformat)'"'

	// parse `options' for -eform()- and friends
	_get_eformopts , eformopts(`options') allowed(__all__) soptions
	local eform	`"`s(str)'"'
	local coefttl = cond(`"`eform'"'==`""', `"`coeftitle'"', `"`s(str)'"')
	local options	`"`s(options)'"'

	// `options' should only contain -diparm()- options
	_get_diparmopts, diparmopts(`options') level(`level')
	// ignore -diparm()- options; but checked for valid syntax anyway
	local NODIPARM : length local nodiparm
	if `NODIPARM' {
		local options
	}

	local GTOPTS parse(":") bind quotes
	local k 0
	if !`NODIPARM' {
		if `"`e(diparm)'"' != "" {
			local i 0
			local diparm `"`e(diparm)'"'
		}
		else if `"`e(diparm1)'"' != "" {
			local i 1
			local diparm `"`e(diparm1)'"'
		}
		while `:length local diparm' {
			gettoken diparm rest : diparm, `GTOPTS'
			while `:length local rest' {
				local ++k
				local diparm`k' : copy local diparm
				gettoken COLON rest : rest, `GTOPTS'
				gettoken diparm rest : rest, `GTOPTS'
			}
			local ++k
			local diparm`k' : copy local diparm
			local ++i
			local diparm `"`e(diparm`i')'"'
		}
	}
	if `:length local options' {
		local 0 `", `options'"'
		syntax [, diparm(string asis) *]
		if `k' & `:length local diparm' {
			local ++k
			local diparm`k' __sep__
		}
		while `:length local diparm' {
			gettoken diparm rest : diparm, `GTOPTS'
			while `:length local rest' {
				local ++k
				local diparm`k' : copy local diparm
				gettoken COLON rest : rest, `GTOPTS'
				gettoken diparm rest : rest, `GTOPTS'
			}
			local ++k
			local diparm`k' : copy local diparm
			local 0 `", `options'"'
			syntax [, diparm(string asis) *]
		}
	}

	mata: _coef_table()
	return add
	if !`keepmc' {
		return local mcmethod
		return local mctitle
	}
end

exit

NOTES:

Secret options:

	cmdextras	-- specifies that -_coef_table- employ special replay
			   code developed for the command named in -e(cmd)-

-_coef_table- looks at the following scalars to determine which equations are
put in the table of results, and how they are put there:

	e(k_eq)		-- total number of equations, missing value implies 1
	e(k_aux)	-- number of ancillary parameters (each an equation)
	e(k_extra)	-- extra equations
	e(k_eform)	-- the first e(k_eform) equations' coefficients will
			   be exponentiated when an 'eform' type option is
			   specified; default is 1

