*! version 2.0.0  03jan2005
program levelsof, sortpreserve rclass
        version 9
	syntax varname [if] [in] [, Separate(str) MISSing Local(str) Clean ]

        if "`separate'" == "" local sep " "
	else local sep "`separate'"

	if "`missing'" != "" local novarlist "novarlist"
        marksample touse, strok `novarlist'
	capture confirm numeric variable `varlist'
	local isnum = _rc != 7

	local maclen 0
        if `isnum' { /* numeric variable */
                tempname Vals
                qui capture tab `varlist' if `touse', `missing' matrow(`Vals')
		if !(_rc) {	/* tab worked fine */
                	local nvals = r(r)
                	forval i = 1 / `nvals' {
                	        local val = `Vals'[`i',1]
				if `i' < `nvals' local vals "`vals'`val'`sep'"
				else local vals "`vals'`val'"
                	}
		}
		else {		/* tab failed */
			tempvar select counter
			bysort `touse' `varlist' : ///
				gen byte `select' = (_n == 1) * `touse'
			generate `counter' = sum(`select') * (`select' == 1)
			sort `counter'
			qui count if `counter' == 0
			local j = 1 + r(N)
			local nvals = _N

			forval i = `j' / `nvals' {
                	        local val = `varlist'[`i']
				if (`i' < `nvals') {
				  local cmdlen = ///
				    length(`"local vals "\`vals'\`=\`varlist'[\`i']'\`sep'""')
				  local cmd ///
				    `"local vals "\`vals'\`=\`varlist'[\`i']'\`sep'""'
				}
				else {
				  local cmdlen = ///
				    length(`"local vals "\`vals'\`=\`varlist'[\`i']'""')
				  local cmd ///
				    `"local vals "\`vals'\`=\`varlist'[\`i']'""'
				}
				
				local maclen = `maclen' + ///
					       `:length local val' + ///
					       `:length local sep'
				if ((`maclen' + `cmdlen') > `c(macrolen)') {
					di as err "macro length exceeded"
					exit 1000
				}
				else `cmd'
			}
		}
        }
	else { /* string variable */
                tempvar select counter
                bysort  `touse' `varlist' : ///
                	gen byte `select' = (_n == 1) * `touse'
                generate `counter' = sum(`select') * (`select' == 1)
                sort `counter'
		qui count if `counter' == 0
                local j = 1 + r(N)
		local nvals = _N

		if "`clean'" != "" {
			forval i = `j' / `nvals' {
				if (`i' < `nvals') {
				  local cmdlen = ///
				    length(`"local vals "\`vals'\`=\`varlist'[\`i']'\`sep'""')
				  local cmd ///
				    `"local vals "\`vals'\`=\`varlist'[\`i']'\`sep'""'
				}
				else {
				  local cmdlen = ///
				    length(`"local vals "\`vals'\`=\`varlist'[\`i']'""')
				  local cmd ///
				    `"local vals "\`vals'\`=\`varlist'[\`i']'""'
				}
				local maclen = `maclen' + ///
					length(`"`=`varlist'[`i']'"') + ///
					length(`"`sep'"')
				if ((`maclen' + `cmdlen') > `c(macrolen)') {
					di as err "macro length exceeded"
					exit 1000
				}
				else `cmd'
			}
		}
		else {
			forval i = `j' / `nvals' {
				if (`i' < `nvals') {
				  local cmdlen = ///
				    length(`"local vals `"\`vals'\`"\`=\`varlist'[\`i']'"'\`sep'"'"')
				  local cmd ///
				    `"local vals `"\`vals'\`"\`=\`varlist'[\`i']'"'\`sep'"'"'
				}
				else {
				  local cmdlen = ///
				    length(`"local vals \`"\`vals'\`"\`=\`varlist'[\`i']'"'"'"')
				  local cmd ///
				    `"local vals \`"\`vals'\`"\`=\`varlist'[\`i']'"'"'"'
				}
				
				local maclen = `maclen' + ///
					length(`"`=`varlist'[`i']'"') + ///
					length(`"`sep'"') + ///
					4 /* 4 chars for compound quotes */
				if ((`maclen' + `cmdlen') > `c(macrolen)') {
					di as err "macro length exceeded"
					exit 1000
				}
				else `cmd'
			}
		}
        }

        di as txt `"`vals'"'
	return local levels `"`vals'"'
	if "`local'" != "" {
		c_local `local' `"`vals'"'
	}
end

