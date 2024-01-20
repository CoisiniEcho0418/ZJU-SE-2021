*! version 1.1.0  13jan2011
program margins
	version 11
	if replay() {
		if inlist("margins", "`e(cmd)'", "`e(cmd2)'") {
			_marg_report `0'
			exit
		}
	}
	local vv : display "version " string(_caller()) ":"
	tempname m t
	.`m' = ._marg_work.new `t'

nobreak {

	if `"`e(margins_prolog)'"' != "" {
		`e(margins_prolog)'
	}

capture noisily break {

	`vv' .`m'.parse `0'
	.`m'.estimate_and_report

} // capture noisily break
	local rc = c(rc)

	if `"`e(margins_epilog)'"' != "" {
		`e(margins_epilog)'
	}


} // nobreak
	exit `rc'
end

exit
