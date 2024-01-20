*! version 2.3.3  06nov2007
program define destring
	version 7.0
	syntax [varlist], [Generate(string) replace] [force] [float] /*
		*/ [Ignore(string)] [percent] [dpcomma]
		
	if "`percent'" == "percent" {
		if !index(`"`ignore'"', "%") {
			local ignore `"`ignore'%"'
		}
	}

/* Perform user error checks */

	if "`generate'" != "" & "`replace'" != "" {
		di as err "options generate and replace are mutually exclusive"
		exit 198
	}

	if "`generate'" == "" & "`replace'" == "" {
		di as err "must specify either generate or replace option"
		exit 198
	}

	if "`generate'" != "" {
		local ct1: word count `varlist'
		local save "`varlist'" 
		local 0 "`generate'" 
		capture syntax newvarlist 
		if _rc { 
			di as err "generate(newvarlist) invalid" 
			exit _rc 
		}	
		local generate "`varlist'" 
		local varlist "`save'" 
		local ct2: word count `generate'
		if `ct1' != `ct2' {
			di as err "number of variables in varlist must equal" 
			di as err "number of variables in generate(newvarlist)"
			exit 198
		}
	}

/* Place each character from ignore in its own macro */
/* named char1 char2 char3... */

	local m 1
	if `"`ignore'"' == "" {
		local ignore ""
	}
	local l = length(`"`ignore'"')
 	while `m' <= `l' {
		local char`m' = substr(`"`ignore'"', `m', 1)
		if substr(`"`ignore'"', `m', 1) == " " {
			local char`m' " "
		}
		local m = `m' + 1
	}

/* Cycle through varlist creating tempvar for each variable and */
/* remove characters */
	
	if "`generate'" != "" {
		tokenize `varlist'
		local flag 0
		local jj 1
		local yy 1
		local varno 0  
		while "`1'" != "" {
			local varno = `varno' + 1 
			capture confirm string variable `1'
			if _rc != 0 {
				di as txt "`1' already numeric; no " /*
					*/ as res "generate"
				local newvar : word `varno' of `generate'
				mac shift
			}
			else {
				tempvar temp
				qui gen str1 `temp' = ""
				qui replace `temp' = `1'
				qui compress `temp'
				while `"`char`jj''"' != "" {
					local t `"`char`jj''"'
					qui replace `temp' = /*
						*/ subinstr(`temp', `"`t'"', "", .)
					local jj = `jj' + 1
				}
				if ("`dpcomma'" != "") {
                                        qui replace `temp' = /*
 					*/ subinstr(`temp', `","', ".", 1)
				}
				qui replace `temp' = trim(`temp')
				qui count if `temp'=="" | `temp'=="." | /*
				  */ (length(`temp')==2 & inrange(`temp',".a",".z"))
				local r = r(N)
				qui count if real(`temp') >= .
				local s = r(N)
				if `r' != `s' {
					local flag 1
				}

				if `flag' == 1 & "`force'" == "" {
					if `"`ignore'"' != "" {
						di as txt "`1' contains " /*
							*/ "characters not specified in " /*
							*/ as res "ignore()" as txt /*
							*/ "; no " as res "generate"
					}
					else {
						di as txt "`1' contains " /*
							*/ "nonnumeric characters; no " /*
							*/ as res "generate"
					}
					local flag 0
					local jj 1
					mac shift
				}
				else {
					tempvar OLDVAR ind con
					qui gen str1 `OLDVAR' = ""
					qui replace `OLDVAR' = `1'
					qui gen byte `ind' = .
					qui gen byte `con' = 0
					while `"`char`yy''"' != "" {
						local t `"`char`yy''"'
						qui replace `ind' = 1 if /*
							*/ index(`OLDVAR', `"`t'"') != 0
						qui count if `ind' == 1
						if r(N) > 0 {
							if `"`t'"' == " " {
								local b `"`b' space"'
							}
							else {
								local b `"`b' `t'"'
							}
						}
						qui replace `ind' = .
						qui replace `con' = 1 if `"`t'"' == "%" & /*
							*/ index(`OLDVAR', `"`t'"') != 0
						qui replace `OLDVAR' = /*
							*/ subinstr(`OLDVAR', `"`t'"', "", .)
						local yy = `yy' + 1
					}
	                                if ("`dpcomma'" != "") {
						qui replace `OLDVAR' = /*
						*/ subinstr(`OLDVAR', `","', ".", 1)
					}
					local c Characters removed were: `b'
					local newvar : word `varno' of `generate'
					local vl: variable label `1'
					if "`float'" == "" {
						*di as res "newvar is |`newvar'|"
						*di as res "OLDVAR is |`OLDVAR'|"
						qui gen double `newvar' = real(`OLDVAR')
					}
					else {
						qui gen float `newvar' = real(`OLDVAR')
					}
					move `newvar' `1'
					move `1' `newvar'
					Charcopy `1' `newvar'
					label variable `newvar' `"`vl'"'
					char `newvar'[destring] `c'
					qui count if `con' == 1
					if "`percent'" != "" & r(N) > 0 {
						qui replace `newvar' = `newvar'/100
					}
					qui compress `newvar'
					local type : type `newvar'
					if "`force'" != "" {
						di as txt "`1' contains nonnumeric " /*
						*/ "characters; `newvar' " /*
						*/ as res "generated " as txt "as " /*
						*/ as res "`type'"
					}
					if `"`b'"' != "" {
						di as txt "`1': characters" /*
							*/ as res `"`b'"' as txt /*
							*/ " removed; `newvar' " as res /*
							*/ "generated " as txt "as " /*
							*/ as res "`type'"
					}
					else if `"`b'"' == "" & "`force'" == "" {
						di as txt "`1' has all " /*
							*/ "characters numeric; `newvar' " /*
							*/ as res "generated " as txt /*
							*/ "as " as res "`type'"
					}
					if `s' != 0 {
						local valmsg = /*
					   */ cond(`s' > 1, "values", "value")
						di as txt /*
					   */ "(`s' missing `valmsg' generated)"
					}
					local b ""
					local c ""
					drop `ind' `con' `OLDVAR'
					local jj 1
					local yy 1
					mac shift
				}
				drop `temp'
			}
		}
	}
	else if "`replace'" != "" {
		tokenize `varlist'
		tempvar ind con
		qui gen byte `con' = 0
		qui gen byte `ind' = .
		local flag 0
		local yy 1
		local jj 1
		while "`1'" != "" {
			capture confirm string variable `1'
			if _rc != 0 {
				di as txt "`1' already numeric; no " /*
					*/ as res "replace"
				mac shift
			}
			else {
				tempvar temp
				qui gen str1 `temp' = ""
				qui replace `temp' = `1'
				qui compress `temp'
				while `"`char`jj''"' != "" {
					local t `"`char`jj''"'
					qui replace `temp' = /*
						*/ subinstr(`temp', `"`t'"', "", .)
					local jj = `jj' + 1
				}
				if ("`dpcomma'" != "") {
					qui replace `temp' = /*
 					*/ subinstr(`temp', `","', ".", 1)
				}
				qui replace `temp' = trim(`temp')
				qui count if `temp'=="" | `temp'=="." | /*
				    */ (length(`temp')==2 & inrange(`temp',".a",".z"))
				local r = r(N)
				qui count if real(`temp') >= .
				local s = r(N)
				if `r' != `s' {
					local flag 1
				}
				if `flag' == 1 & "`force'" == "" {
					if `"`ignore'"' != "" {
						di as txt "`1' contains " /*
							*/ "characters not specified in " /*
							*/ as res "ignore()" as txt /*
							*/ "; no " as res "replace"
					}
					else {
						di as txt "`1' contains " /*
							*/ "nonnumeric characters; no " /*
							*/ as res "replace"
					}
					local flag 0
					local jj 1
					mac shift
				}
				else {
					while `"`char`yy''"' != "" {
						local t `"`char`yy''"'
						qui replace `ind' = 1 /*
							*/ if index(`1', `"`t'"')!=0
						qui count if `ind' == 1
						if `"`t'"' == " " & r(N) > 0 {
							local b `"`b' space"'
						}
						if r(N) > 0 {
							local b `"`b' `t'"'
						}
						qui replace `ind' = .
						qui replace `con' = 1 if `"`t'"' == "%" & /*
							*/ index(`1', `"`t'"') != 0
						qui replace `1' = /*
							*/ subinstr(`1', `"`t'"', "", .)
						local yy = `yy' + 1
					}
					if ("`dpcomma'" != "") {
						 qui replace `1' = /*
						*/ subinstr(`1', `","', ".", 1)
					}
					local c Characters removed were: `b'
					tempvar switch
					local type = cond("`float'" == "float", "float", "double")
					qui gen `type' `switch' = real(`1')
					char rename `1' `switch'
					move `switch' `1'
					local vl: variable label `1'
					drop `1'
					if "`float'" == "" {
						qui gen double `1' = `switch'
					}
					else {
						qui gen float `1' = `switch'
					}
					move `1' `switch'
					label variable `1' `"`vl'"'
					char rename `switch' `1'
					char `1'[destring] `c'
					qui count if `con' == 1
					if "`percent'" != "" & r(N) != 0 {
						qui replace `1' = `1'/100
					}
					qui replace `con' = 0
					qui compress `1'
					local type : type `1'
					if "`force'" != "" {
						di as txt "`1' contains nonnumeric " /*
						*/ "characters; " as res "replaced "/*
						*/ as txt "as " as res "`type'"
					}
					if `"`b'"' != "" {
						di as txt "`1'"": characters" /*
							*/ as res `"`b'"' as txt /*
							*/ " removed; " as res /*
							*/ "replaced " as txt "as " /*
							*/ as res "`type'"
					}
					else if `"`b'"' == "" & "`force'" == "" {
						di as txt "`1' has all " /*
							*/ "characters numeric; " as res /*
							*/ "replaced " as txt "as " /* 
							*/ as res "`type'"
					}
					if `s' != 0 {
						local valmsg = /*
					  */ cond(`s' > 1, "values", "value")
						di as txt /*
					  */ "(`s' missing `valmsg' generated)"
					}
					local b ""
					local c ""
					local jj 1
					local yy 1
					drop `switch'
					mac shift
				}
				drop `temp'
			}
		}
	}
end


program def Charcopy 
	syntax varlist(min=2 max=2) 
	tokenize `varlist' 
	args from to 

	local chfrom : char `from'[] 
	if "`chfrom'" == "" { 
		exit
	}
	
	tokenize `chfrom'
	while "`1'" != "" {
		local fchar : char `from'[`1']
		char `to'[`1'] `"`fchar'"'
		mac shift
	}
end
