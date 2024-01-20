*! version 1.0.0  17feb2009

program _xtur_parse_kernel, sclass

	args input
	
	tokenize `input'
	local kernel `1' 
	local bw `2'
	macro shift 2
	if `"`1'"' != "" {
		di in smcl as error `"{cmd:kernel(`input')} invalid"'
		exit 198
	}

	local kernlen : length local kernel
	if `"`kernel'"' == substr("nwest", 1, max(2,`kernlen')) |	///
		`"`kernel'"' == substr("bartlett", 1, max(2,`kernlen')) {
		local hac_kernel "bartlett"
	}
	else if `"`kernel'"' == substr("gallant", 1, max(2,`kernlen')) | ///
		`"`kernel'"' == substr("parzen", 1, max(2,`kernlen')) {
		local hac_kernel "parzen"
	}
	else if `"`kernel'"' == 					///
		substr("quadraticspectral", 1, max(2, `kernlen')) |	///
		`"`kernel'"' == substr("andrews", 1, max(2,`kernlen')) {
		local hac_kernel "quadraticspectral"
	}
	else {
		di in smcl as error "{opt kernel()} kernel invalid"
		exit 198
	}

	capture confirm number `bw'
	if _rc == 0 {
		if `bw' < 0  | (`bw' != int(`bw') & 		///
				   "`hac_kernel'" != "quadraticspectral") {
			di in smcl as error 				///
				"{opt kernel()} lag length invalid"
			exit 198
		}
		sreturn local hac_kernel "`hac_kernel'"
		sreturn local hac_lags = `bw'
		sreturn local hac_bsel ""
		exit
	}
	
	// See which BW selection algorithm user specified
	local bwlen : length local bw
	if `"`bw'"' == substr("nwest", 1, max(2, `bwlen')) {
		local bsel "nwest"
	}
	else if `"`bw'"' == "llc" {
		local bsel "llc"
	}
	else if `"`bw'"' == "" {
		local bsel ""
	}
	else {
		di in smcl as error 	///
			"{opt kernel()} lag selection algorithm invalid"
		exit 198
	}
	sreturn local hac_kernel "`hac_kernel'"
	sreturn local hac_lags = .
	sreturn local hac_bsel "`bsel'"
	
end
