*! version 1.0.0  30mar2011
program _matrix_table
	version 12
	syntax anything(id="matrix name" name=matrix) [, cmdextras *]
	if "`cmdextras'" != "" {
		if "`e(cmd)'" == "sem" {
			local nolabel		NOLABel
			local wrap		wrap(numlist max=1)
			local pclassmatrix	PCLASSMATrix(string)
		}
	}
	syntax anything(id="matrix name" name=matrix)	///
		[,	sort				///
			format(string asis)		///
			cmdextras			/// NOT DOCUMENTED
			`nolabel'			///
			`wrap'				///
			`pclassmatrix'			///
			*				/// diopts
		]

	if inlist("`matrix'", "e(b)", "e(V)", "e(Cns)") {
		di as err "matrix `matrix' not allowed"
		exit 198
	}
	_get_diopts diopts, `options'

	// NOTE: hold/restore the current -r()- results; otherwise,
	// '_matrix_table()' calls to -_ms_display- it will change the
	// contents of -r()-

	tempname hold
	_return hold `hold'

	capture noisily mata: _matrix_table()

	local rc = c(rc)
	_return restore `hold'
	exit `rc'
end

exit
