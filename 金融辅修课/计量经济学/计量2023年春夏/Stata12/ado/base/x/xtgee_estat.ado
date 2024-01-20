*! version 1.0.0  03jan2005
program xtgee_estat, rclass
	version 9

	if "`e(cmd)'" != "xtgee" {
		error 301
	}

	gettoken key rest : 0, parse(", ")
	local lkey = length(`"`key'"')
	if `"`key'"' == substr("wcorrelation",1,max(4,`lkey')) {
		EstatCorr `rest'
	}
	else {
		estat_default `0'
	}
	return add
end

program EstatCorr, rclass
// modeled after xtcorr.ado, but this returns in r() and uses -matlist-
// for displaying (when appropriate) and allows the -format()- option

	syntax [, Compact Format(str) ]

	tempname r
	matrix `r' = e(R)

	if `"`format'"' != "" {
		if substr(`"`format'"',1,1) != "%" {
			local format %`format'
		}
		// triggers error message if invalid numeric format
		local junk : display `format' -1
		local formatopt `"format(`format')"'
	}

	if "`compact'" == "" {
		di _n in gr "Estimated within-`e(ivar)' correlation matrix R:"
		matlist `r', `formatopt' twidth(5)
	}
	else {

		if "`e(corr)'" == "independence" {
			di _n in gr "Error structure: " in ye "`e(corr)'"
			di in gr /*
		*/ "The within-`e(ivar)' correlation R is the Identity matrix"
		}

		else if "`e(corr)'" == "exchangeable" {
			di _n in gr "Error structure: " in ye "`e(corr)'"
			di in gr "Estimated within-`e(ivar)' correlation: " /*
			*/ in ye `format' `r'[2,1]
		}

		else if substr("`e(corr)'",1,2) == "AR" {
			di _n in gr "Error structure: " in ye "`e(corr)'"
			local k = substr("`e(corr)'",4,length("`e(corr)'")-4)
			if `k' == 1 {
				di in gr /*
			*/ "Estimated within-`e(ivar)' autocorrelation: " /*
			*/ in ye `format' `r'[2,1]
			}
			else {
				di in gr /*
				*/ "Estimated within-`e(ivar)' correlations"
				local i 1
				while `i' <= `k' {
					di _col(11) in gr "lag `i' : " /*
					*/ in ye `format' `r'[`i'+1,1]
					local i = `i'+1
				}
				if `k' < colsof(`r')-1 {
					di in gr _col(11) "lag>`k' : " in ye 0
				}
			}
		}

		else if substr("`e(corr)'",1,10) == "stationary" {
			di _n in gr "Error structure: " in ye "`e(corr)'"
			local k = substr("`e(corr)'",12,length("`e(corr)'")-12)
			di in gr "Estimated within-`e(ivar)' correlations "
			local i 1
			while `i' <= `k' {
				di _col(11) in gr "lag `i' : " /*
				*/ in ye `format' `r'[`i'+1,1]
				local i = `i'+1
			}
			if `k' < colsof(`r')-1 {
				di in gr _col(11) "lag>`k' : " in ye 0
			}
		}

		else {
			* no suitable compact format
			di _n in gr ///
			    "Estimated within-`e(ivar)' correlation matrix R:"
			matlist `r', `formatopt' twidth(5)
		}
	}

	ret mat R = `r'

end
