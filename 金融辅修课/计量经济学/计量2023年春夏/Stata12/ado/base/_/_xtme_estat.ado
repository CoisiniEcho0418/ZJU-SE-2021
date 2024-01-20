*! version 1.1.0  04jul2009
program _xtme_estat
	version 9

	gettoken sub rest: 0, parse(" ,")
	local lsub = length(`"`sub'"')
	if `"`sub'"' == substr("group",1,max(2,`lsub')) {
		local type group
	}
	else if `"`sub'"' != substr("recovariance",1,max(5,`lsub')) {
		estat_default `0'
		exit
	}

	if "`type'" == "group" {
		gettoken comma rest : rest, parse(",")
		if `"`comma'"' != "" {
			if `"`rest'"' != "" | `"`comma'"' != "," {
di as err "{p 0 4 2}options not allowed with subcommand group{p_end}"
			  exit 198
		 	}
		}
		`e(cmd)', grouponly
		exit
	}
	Covariance `rest' 
end

program Covariance, rclass
        syntax [, CORRelation Level(string) TITle(string) *]

	if "`correlation'" != "" {
		local ctype correlation
	}
	else {
		local ctype covariance
	}
	tempname v

	if `"`title'"' == "" {
		local mytitle mytitle
		local t1 Random-effects `ctype' matrix for level 
	}

	local ivars `e(ivars)'
	local ivars : list uniq ivars
	if "`ivars'" == "" {
		if "`e(cmd)'" == "xtmixed" {
			local rrtype linear
		}
		else {
			local rrtype `e(model)'
		}
		di as err `"{p 0 4 2}model is `rrtype' regression;"'
		di as err " no random effects{p_end}"
		exit 459
	}
	if `"`level'"' != "" {
                if `"`level'"' != "_all" {
                        if `:word count `level'' != 1 {
                            di as err "{p 0 4 2}invalid level() specification"
                            di as err "{p_end}"
                            exit 198
                        }
                        unab level : `level'
                }
                if `:list posof `"`level'"' in local ivars' == 0 {
                        di as err `"{p 0 4 2}`level' is not a level variable "'
                        di as err "in this model{p_end}"
                        exit 198
                }
		GetLevelMat `level' `v' `ctype'
		if `"`mytitle'"' != "" {
			local title `t1' {res:`level'}
		}
		if(colsof(`v') > 1 | rowsof(`v') > 1 | !missing(`v'[1,1])) {
			matlist `v', `options' title(`"`title'"')
		}
        }
	else {
		foreach lev of local ivars {
			GetLevelMat `lev' `v' `ctype'
			if `"`mytitle'"' != "" {
				local title `t1' {res:`lev'}
			}
			if(colsof(`v') > 1 | rowsof(`v') > 1 | ///
			    !missing(`v'[1,1])) {
				matlist `v', `options' title(`"`title'"')
			}
		}
	}
	local c cov
	if "`ctype'" == "correlation" {
		local c corr
	}
	return matrix `c' = `v'
end

program GetLevelMat
	args level v ctype

	local ivars `e(ivars)'
	local uivars : list uniq ivars
	local eqnum : list posof "`level'" in uivars
	local revars `e(revars)'
	local w : word count `ivars'
	local subeq 0
	local sdim 0
	forval i = 1/`w' {
		local lev : word `i' of `ivars'
		local dim : word `i' of `e(redim)'
		local type : word `i' of `e(vartypes)'
		if "`lev'" == "`level'" {
			local ++subeq	
			local dims `dims' `dim'
			local sdim = `sdim' + `dim'
			local types `types' `type'
			forval j = 1/`dim' {
				gettoken token revars : revars
				local cnames `cnames' `token'
			}
		}
		else {
			forval j = 1/`dim' {
				gettoken token revars : revars    //consume	
			}
		}	
	}
	if `sdim' {
		mat `v' = I(`sdim')
		local start 1
		forval i = 1/`subeq' {
			tempname v1 
			gettoken type types : types
			gettoken dim dims : dims
			GetSubLevelMat `eqnum' `i' `dim' `type' `v' `start'
			local start = `start' + `dim'
		}
		local cnames : subinstr local cnames "." "_", all
		mat colnames `v' = `cnames'
		mat rownames `v' = `cnames'
		if "`ctype'" == "correlation" {
			mat `v' = corr(`v')
		}
	}
	else {
		mat `v' = J(1,1,.)
	}
end

program GetSubLevelMat
	args lev sub dim type v start

	local lns lns`lev'_`sub'
	local atr atr`lev'_`sub'
	if "`type'" == "Identity" {
		forval i = `start'/`=`start'+`dim'-1' {
			mat `v'[`i',`i'] = exp(2*[`lns'_1]_cons)
		}	
		exit
	}
	else if "`type'" == "Exchangeable" {
		forval i = `start'/`=`start'+`dim'-1' {
			mat `v'[`i',`i'] = exp(2*[`lns'_1]_cons)
			forval j = `=`i'+1'/`=`start'+`dim'-1' {
				mat `v'[`i',`j'] = ///
				  tanh([`atr'_1_1]_cons)*exp(2*[`lns'_1]_cons)
				mat `v'[`j',`i'] = `v'[`i',`j']
			}
		}
		exit
	}
	else if "`type'" == "Independent" {
		local k 1
		forval i = `start'/`=`start'+`dim'-1' {
			mat `v'[`i',`i'] = exp(2*[`lns'_`k']_cons)
			local ++k
		}
		exit
	}
	else {			// Unstructured
		local k 1
		forval i = `start'/`=`start'+`dim'-1' {
			mat `v'[`i',`i'] = exp(2*[`lns'_`k']_cons)
			local m = `k' + 1
			forval j = `=`i'+1'/`=`start'+`dim'-1' {
				mat `v'[`i',`j'] = ///
				       tanh([`atr'_`k'_`m']_cons)* ///
				       exp([`lns'_`k']_cons + ///
					   [`lns'_`m']_cons)
				mat `v'[`j',`i'] = `v'[`i',`j']
				local ++m
			}
			local ++k
		}
		exit
	}
end

exit
