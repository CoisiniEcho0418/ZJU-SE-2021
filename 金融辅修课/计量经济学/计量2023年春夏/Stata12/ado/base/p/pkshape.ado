*! version 2.1.4  11dec2000
program define pkshape, rclass
	version 7.0

	syntax varlist(min=4) [, Order(string) OUTcome(string) /*
	*/ TReatment(string) SEQuence(string) PERiod(string) /* 
	*/ CARryover(string) ] 

	local treat_ "`treatment'"
	local treatment
	local carry_ "`carryover'"
	local carryover

	if "`outcome'" == "" {
                local outcome outcome
        }
        else {
                confirm new var `outcome'
        }
        if "`period'" == "" {
                local period period
        }
        else {
                confirm new var `period'
        }
        if "`sequence'" == "" {
                local sequence sequence
        }
        else {
                confirm new var `sequence'
        }
        if "`treat_'" == "" {
                local treat_ treat
        }
        else {
                confirm new var `treat_'
        }
	if "`carry_'" == "" {
                local carry_ carry
        }
        else {
                confirm new var `carry_'
        }
	
	local var_cnt: word count `varlist'
	local nperiod = `var_cnt' - 2
	tokenize `varlist'

	confirm numeric variable `1' `3' `4'
	capture confirm numeric variable `2'
	if _rc {
		confirm string variable `2'
		tempvar seq
		qui encode `2', gen(`seq')
	}
	else {
		local seq = "`2'"
		if "`order'" == "" {
			di as err /*
*/ "option order() must be specified when `seq' is numeric"
			exit 198
		}
	}


	local id = "`1'"
	local period1 = "`3'"
	local period2 = "`4'"
	local i  5
	while `i' < `var_cnt' + 1 {
		local tmp = `i' - 2
		local period`tmp' = "``i''"
		local i = `i' + 1
	}
	capture assert `id' != .
	if _rc {
		di `"missing values for `id' not allowed"'
		exit 459
	}
	sort `id' 
	capture assert id[_n] != id[_n+1]
	if _rc {
		capture by `id' : assert `seq'[_n] != `seq'[_n+1]
		if _rc {
			di `"variables `id' and `seq' takes on repeated measures"'
			exit 459
		}
	}

	tempvar oseq iseq
	qui by `seq', sort: gen `iseq' = 1 if _n == 1
	su `iseq' , meanonly
	local nseq = r(sum)
	qui gen `oseq' = sum(`iseq') /* save iseq for later use */

	if "`order'" != "" {
		local norder : word count `order'
		if `norder' != `nseq' {
			di as err /*
*/ "the number of sequences in the data or the order statement is invalid"
			exit 198
		}
		local i = 1
		while `i' < `norder' + 1 {
			local o`i' : word `i' of `order'
			local i = `i' + 1
		}
		local i = 1
		while `i' < `norder' + 1 {
			if length("`o`i''") != `nperiod' {
				di as err /*
*/ "the number of periods in the data or in the order statement is invalid"
				exit 198
			}
			local i = `i' + 1
		}

	}
	else { /* this is case where the order is string variable */
		sort `iseq' `oseq'
		local i 1
		while `iseq'[`i'] != . {
			local o`i' = substr(`2'[`i'], 1, .)
			local i = `i' + 1
		}
		local i 1
		while `i' < `norder' + 1 {
			if length("`o`i''") != `nperiod' {
				di as err /*
*/ "the number of periods in the data or in the sequence string is invalid"
				exit 198
			}
			local i = `i' + 1
		}
	}


/*
* At this point o1...oN is filled in with the sequence.
* Now I want to figure out the number of treatments
*/
	
	local subval = 1	
	forvalues X = 1/`nseq' {
		local all "`all'`o`X''"
	}
	while "`all'" != "" {
		local char = substr("`all'", 1, 1)
		local all : subinstr local all "`char'" "", all
		if "`char'" != "0" {
			forvalues X = 1/`nseq' {
				local o`X' : subinstr local o`X' "`char'" "`subval'", all
			}
		}
		else {
			forvalues X = 1/`nseq' {
				local o`X' : subinstr local o`X' "`char'" "0", all
			}
		}
			
		local subval = `subval' + 1
	}

	
	tempvar result treat carry Period order
	sort `oseq' `id'
	qui gen `result' = `period1'
	qui gen `treat' = .
	qui gen `carry' = 0
	qui gen `order' = .
	qui gen `Period' = 1

	local len = _N
	local i 1
	while `i' < `nperiod' {
		local tmp = `i' - 1
		qui expand 2 if _n > (`tmp' * `len')
		
		local tmp = `i' + 1
		qui replace `result' = `period`tmp'' if _n > `i' * `len'
		qui replace `Period' = `tmp' if _n > `i' * `len'
		local i = `i' + 1
	}
	
	/* this tells me for which seq's and periods the trt is the same */
	local i 1
	while "`o`i''" != "" { /* these are seq's */
		local j 1
		while `j' < `nperiod' + 1 { /* these are the periods */

			qui replace `treat' = real(substr("`o`i''", `j', 1)) if `oseq' == `i' & `Period' == `j'			
			local j = `j' + 1
		}	
		local i = `i' + 1
	}

	local i 1
	while "`o`i''" != "" { /* these are seq's */
		local j 1
		while `j' < `nperiod' + 1 { /* these are the periods */


			local var = substr("`o`i''", `j'-1, 1)
			if "`var'" != "" {
				qui replace `carry' = real("`var'") if `oseq' == `i' & `Period' == `j'			
			}
			else qui replace `carry' = 0 if `oseq' == `i' & `Period' == `j'	
			local j = `j' + 1
		}	
		local i = `i' + 1
	}

	gettoken drop 0 : 0, parse(",")
	gettoken junk drop : drop
	drop `drop'
	nobreak {
		rename `result' `outcome'
		rename `Period' `period'
		rename `oseq' `sequence'
		rename `treat' `treat_'
		rename `carry' `carry_'
	}

	

end
exit

