*! version 1.0.1  28aug2007
program ml_p
	version 9
	syntax [anything] [if] [in] [, SCores * ]
	if `"`scores'"' != "" {
		if `"`e(opt)'"' == "ml" {
			ml score `0'
		}
		else {
			mopt score `0'
		}
		exit
	}
	_predict `0'
end
exit
