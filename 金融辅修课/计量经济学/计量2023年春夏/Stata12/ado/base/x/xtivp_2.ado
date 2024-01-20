*! version 1.0.2  30sep2004
program define xtivp_2, sortpreserve
	version 7.0, missing
        syntax newvarname [if] [in] , [XB  E  U UE XBU]

	tempname touse
	mark `touse' `if' `in'


	sort `e(ivar)' `e(tvar)'

	local others "`u'`ue'`xbu'" 

	if "`others'" != "" {
		di as err "`others' not available from FD model"
		exit 198
	}

	local stat "`xb'`e'"
	
	if "`stat'"=="" {
		local stat "xb"
	}

	if "`stat'"!="xb" & "`stat'"!="e"  {
		di as err "you can only predict one statistic at a time"
		exit 198 
	}


	if "`stat'"=="xb" {
		_predict `typlist' `varlist' if `touse'
	}	

	if "`stat'"=="e" {
		tempname xb
		qui _predict double `xb' if `touse'
		gen `typlist' `varlist'=d.`e(depvar)'-`xb' if `touse'
	}	

end	
