*! version 1.0.3  05jul2011
program bcal, rclass
	version 12

	gettoken subcmd rest : 0 , parse(" ,")

	local l = strlen(`"`subcmd'"')
	if (`l' == 0) {
		error 198
		/*NOTREACHED*/
	}

	if ("`subcmd'"==substr("check", 1, max(1, `l'))) {
		bcal_check `rest'
	}
	else if ("`subcmd'"==substr("describe", 1, max(1,`l'))) {
		bcal_describe `rest'
	}
	else if ("`subcmd'"=="dir") {
		bcal_dir `rest' 
	}
	else if ("`subcmd'"=="load") {
		bcal_load `rest' 
	}
	else {
		di as err "`subcmd' invalid {bf:bcal} subcommand"
		exit 198
		/*NOTREACHED*/
	}
	return add
end

program bcal_check, rclass
	syntax [varlist] [, RC0]
	mata: bcal_check("`rc0'"!="")
	return add
end
	

program bcal_dir, rclass
	gettoken pattern 0 : 0, parse(" ,")
	if ("`pattern'"==",") {
		local 0 `", `0'"'
		local pattern
	}
	syntax [, TESTMODE]

	if (substr("`pattern'", 1, 1)=="%") {
		capture noi error 198
		di as err "{p 4 4 2}"
		di as err "{bf:%} is not allowed."
		di as err "When using {bf:bcal dir}, you must specify"
		di as err "the business calendar's name, not its format."
		di as err "E.g., specify {bf:nyse} or {bf:ny*}, not"
		di as err "{bf:%tbnyse} or {bf:%tbny*}."
		di as err "{p_end}"
		exit 198
	}
	mata: bcal_dir("`pattern'", "`testmode'")
end

program bcal_load, rclass
	gettoken toload 0 : 0 , parse(" ,")
	if ("`toload'"==",") {
		local 0 `", `0'"'
		local toload 
	}
	syntax
	calspec_specified load "`toload'"
	_bcalendar load `toload'

	return local name "`r(name)'"
	return local purpose "`r(purpose)'"
	return scalar min_date_td = r(min_date_td) 
	return scalar max_date_td = r(max_date_td) 
	return scalar ctr_date_td = r(ctr_date_td) 
	return scalar max_date_td = r(max_date_td) 

	return scalar min_date_tb = r(min_date_tb) 
	return scalar max_date_tb = r(max_date_tb) 

	di as txt
	di as txt "(calendar loaded successfully)"
end

program bcal_describe, rclass
	gettoken toload 0 : 0 , parse(" ,")
	if ("`toload'"==",") {
		local 0 `", `0'"'
		local toload 
	}
	syntax
	calspec_specified describe "`toload'"

	qui _bcalendar load `toload'
	return local name "`r(name)'"
	return local purpose "`r(purpose)'"
	return scalar min_date_td = r(min_date_td) 
	return scalar max_date_td = r(max_date_td) 
	return scalar ctr_date_td = r(ctr_date_td) 

	return scalar min_date_tb = r(min_date_tb) 
	return scalar max_date_tb = r(max_date_tb) 

	local ddays = r(max_date_td) - r(min_date_td) + 1
	local bdays = r(max_date_tb) - r(min_date_tb) + 1

	return scalar omitted = `ddays' - `bdays' 
	return scalar included = `bdays'

	local omityear = (return(omitted)/`ddays')*365.25
	local inclyear = (return(included)/`ddays')*365.25


	local bfmt "%tb`return(name)'"

	local intd `"as txt _col(37) "in %td units""'
	local intb `"as txt _col(37) "in `bfmt' units""'

	di as txt
	di as txt "  Business calendar " as res "`return(name)'" ///
	   as txt " (format " as res "`bfmt'" as txt "):"

	di as txt

	di as txt "    purpose:  " ///
	   as res "`return(purpose)'"

	di as txt

	di as txt "      range:  " ///
	   as res %td (`return(min_date_td)') "  " ///
	   as res %td (`return(max_date_td)') 

	di as txt "             " ///
	   as res %9.0f (`return(min_date_td)') "  " ///
	   as res %9.0f (`return(max_date_td)') `intd'

	di as txt "             " ///
	   as res %9.0f (`return(min_date_tb)') "  " ///
	   as res %9.0f (`return(max_date_tb)') `intb'

	di as txt
	di as txt "     center:  " ///
	   as res %td (`return(ctr_date_td)') 

	di as txt "             " ///
	   as res %9.0f (`return(ctr_date_td)') `intd'

	di as txt "             " ///
	   as res %9.0f (0) `intb'

	di as txt
		
	di as txt "    omitted: " ///
	   as res %9.0fc `return(omitted)' as txt _col(37) "days"

	di as txt "             " ///
	   as res %11.1f `omityear' as txt _col(37) "approx. days/year"

	di as txt

	di as txt "   included: " ///
	   as res %9.0fc return(included) as txt _col(37) "days"

	di as txt "             " ///
	   as res %11.1f `inclyear' as txt _col(37) "approx. days/year"
end

program calspec_specified
	args	subcmd calspec

	if (`"`calspec'"' != "") {
		exit
	}
	di as err "syntax error"
	di as err "{p 4 4 2}"
	di as err "Syntax is"
	di as err "{bf:bcal} {bf:`subcmd'}"
	di as err "{it:calname}|{bf:%}{it:tbfmt}.{break}"
	di as err "Nothing was found where a calendar name"
	di as err "or {bf:%}{it:tbfmt} was expected."
	di as err "{p_end}"
	exit 198
end



version 12

local SS	string scalar
local SC	string colvector
local SR	string rowvector
local boolean	real scalar
local RS	real scalar
local RR	real rowvector

mata:

/*
bcal check 

        . bcal check 

        %tblonglong:  [un]defined, used by variables
                      xxx xxx xxx

           %tbxmpl2: [un]defined, used by variables
                     xxx xxx xxx
        
        undefined or defined-with-errors %tb formats
        r(111);

        . bcal check 
        (no variables use %tb formats)

        Returned, 
             r(defined)      list of   defined formats used
             r(undefined)    list of undefined formats used
	     r(error)        list of     error formats used
*/

void bcal_check(`boolean' rc0)
{
	`RS'		i, j, rc, rc_overall, status
	`RR'		vidx
	`SS'		fmtname, undef, error, def
	`SC'		fmtnames, varnames

	/* ------------------------------------------------------------ */
					/* obtain fmtnames[]		*/
	vidx     = st_varindex(tokens(st_local("varlist")))
	fmtnames = J(0, 1, "")
	for (i=1; i<=length(vidx); i++) {
                fmtname = tbfmtname(st_varformat(vidx[i]))
                if (fmtname != "") fmtnames = fmtnames \ fmtname
	}
	if (length(fmtnames)==0) { 
		display("{txt}(no variables use {bf:%tb} formats)")
		return
	}
	fmtnames = uniqrows(fmtnames)

	/* ------------------------------------------------------------ */
	rc_overall = 0 
	undef = error = def = ""
	for (j=1; j<=length(fmtnames); j++) {

		varnames = J(0, 1, "")
		for (i=1; i<=length(vidx); i++) {
			if (tbfmtname(st_varformat(vidx[i])) == fmtnames[j]) {
				varnames = varnames \ st_varname(i)
			}
		}
		rc = _stata("_bcalendar load " + fmtnames[j], 1)
		st_rclear() 

		if (rc==1) {
			exit(1)
		}
		if (rc==601) { 
			status     = 601
			undef      = undef + (" " + fmtnames[j])
			rc_overall = 459
		}
		else if (rc) {
			status     = 198
			error      = error + (" " + fmtnames[j])
			rc_overall = 459
		}
		else {
			status     = 0
			def        = def + (" " + fmtnames[j])
		}

		printf("{txt}\n")
		printf((13-strlen(fmtnames[j]))*" ")
		printf("%s", `"{res}{stata "bcal describe %tb"' + fmtnames[j] + `"":%tb"' + fmtnames[j] + "}:  ")

		if      (status==0)   printf("{txt}defined, ") 
		else if (status==601) printf("{err}undefined, ")
		else                  printf("{txt}defined, {err}has errors, ")

		printf("{txt}used by %s\n", 
			length(varnames)==1 ? "variable" : "variables")

		printf("{p 19 19 2}\n") 
		printf(invtokens(varnames'))
		printf("\n")
		printf("{p_end}\n")
	}

	if (rc_overall) {
		printf(rc0 ? "{txt}\n" : "{err}\n")
		printf("%s\n", 
		       "undefined or defined-with-errors {bf:%tb} formats")
		if (!rc0) exit(rc_overall)
	}

	st_global("r(defined)",   strtrim(def))
	st_global("r(undefined)", strtrim(undef))
	st_global("r(error)",     strtrim(error))
}

`SS' tbfmtname(`SS' fmt)
{
	`RS'	i 
	`SS'	name 

	if (substr(fmt, 1, 3)!="%tb") return("")
	i = strpos(name = substr(fmt, 4, .), ":")
	return(i==0 ? name : substr(name, 1, i-1))
}
	
	

void bcal_dir(`SS' upattern, `SS' utestmode)
{
	`RS'		i
	`SS'		pattern, pathlist
	`SC'		files
	`boolean'	testmode
	`SC'		ffname

	testmode = (utestmode!="")
		

	pattern        = (upattern == "" ? "*" : upattern)
	files          = bcal_dir_files(pattern + ".stbcal") 

	if (testmode) ffname = J(length(files), 1, "")

	if (length(files)==0) { 
		printf("{txt}no calendar files matching {bf:%s} found\n",
					pattern) 
		printf("{p 4 4 2}\n")
		printf("No business calendars matching {bf:%s}\n", pattern)
		printf("were found, which is to say, no files matching\n")
		printf("{bf:%s} were found\n", pattern+".stbcal")
		printf("in any of the directories along the {bf:adopath}.\n")
		printf("{p_end}\n") 
	}
	else {
		printf("{txt}  %g calendar file%s found:\n",
			length(files), 
			length(files)==1 ? "" : "s")


		pathlist = c("adopath")
		for (i=1; i<=length(files); i++) {
			printf("%16s:  %s\n", 
				pathrmsuffix(files[i]), 
				findfile(files[i], pathlist))
			if (testmode) {
				ffname[i] = findfile(files[i], pathlist)
			}
		}
	}

	if (testmode) {
		rmexternal("filelist")
		*(crexternal("filelist")) = ffname
		printf("filelist created (testmode)\n")
	}
}


`SC' bcal_dir_files(`SS' pattern)
{
	`RS'		i, j, a, z ; 
	`SS'		c, ltr, dir
	`SC'		res 
	`SR'		places_to_look
	`boolean'	wildcard

	res            = J(0, 1, "")
	places_to_look = pathlist()
	c              = substr(pattern, 1, 1)
	wildcard       = (c=="*" | c=="?")
	a              = ascii("a")
	z              = ascii("z")


	for (i=1; i<=length(places_to_look); i++) { 
		dir = pathsubsysdir(places_to_look[i])
		res = res \ dir(dir, "files", pattern)
		if (wildcard) {
			for (j=a; j<=z; j++) {
				ltr = char(j)
				res = res \ 
			      	      dir(pathjoin(dir,ltr), "files", pattern)
			}
			res = res \ dir(pathjoin(dir,"_"), "files", pattern)
		}
		else {
			res = res \ dir(pathjoin(dir, c), "files", pattern)
		}
	}
	return(uniqrows(res))
}

end

