*! version 1.1.2  25apr2006
program define censobs_table
	version 7
				    /* interval ll ul -- optional */
	args uncens leftcens rightcens interval	ll ul
	local dep : word 1 of `e(depvar)'
	local dep = abbrev("`dep'", 12)
	if `"`ll'`ul'"' != "" {
		local C1 _col(18)
		local C2 _col(28)
		local obs "Obs."
	}
	else {
		local C1 _col(24)
		local C2 _col(34)
		local obs "Observation"
	}

	di as txt "  `obs' summary:" _c
	if missing("`ll'") | `leftcens' == 0 {
		local s = cond(`leftcens'==1,"","s")
		di as txt  `C1' as res %9.0g `leftcens' /*
			*/ `C2' as txt " left-censored observation`s'"
	}
	else {
		local s `"`= cond(`leftcens'==1," ","s")'"'
		di as txt  `C1' as res %9.0g `leftcens' /*
			*/ `C2' as txt " left-censored observation`s'" /*
			*/ " at `dep'<=" as res `ll'
	}

	local s = cond(`uncens'==1,"","s")
	di as txt  `C1' as res %9.0g `uncens' /*
		*/ `C2' as txt "    uncensored observation`s'"

	if missing("`ul'") | `rightcens' == 0 {
		local s = cond(`rightcens'==1,"","s")
		di as txt  `C1' as res %9.0g `rightcens' /*
			*/ `C2' as txt "right-censored observation`s'"
	}
	else {
		local s `"`= cond(`rightcens'==1," ","s")'"'
		di as txt  `C1' as res %9.0g `rightcens' /*
			*/ `C2' as txt "right-censored observation`s'" /*
			*/ " at `dep'>=" as res `ul'
	}

	if "`interval'" != "" {
		local s = cond(`interval'==1,"","s")
		di as txt `C1' as res %9.0g `interval' /*
			*/ `C2' as txt "      interval observation`s'"
	}
end
exit

----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
  Observation summary: 123456789     uncensored observations
                       123456789  left-censored observations
                       123456789 right-censored observations
                       123456789       interval observations

