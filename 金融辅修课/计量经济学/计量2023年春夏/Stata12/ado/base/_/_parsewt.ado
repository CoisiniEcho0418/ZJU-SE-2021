*! version 2.0.3  23sep2004
program define _parsewt, sclass
/*
   This program parses out [weight=exp] from a command.
   Syntax
		_parsewt "allowed_weight_types" `0'
   Example
		_parsewt "fw aw" `0'
   Returns
		s(newcmd) = command with [weight=exp] removed
		s(weight) = [<weight>= <exp>]    or   nothing

   Notes:
        1.  Program looks for weights in usual places.  In particular, it
            does not look inside expressions or options.
	2.  Program will use message (frequency weights assumed)", etc.
	3.  <weight> in s(weight) is spelled out, equal sign hard against,
	    one blank, followed by expression.
        4.  _parsewt returns s(newcmd) AS IS (`0') if no weights.
        5.  _parsewt returns s(newcmd) with all quotes changed to
            compound quotes if weights were specified.
*/
	version 6.0, missing
	sret clear

	gettoken wtypes 0 : 0
	sret local newcmd `"`0'"'
	
	local np 0
	local inopt 0
	while 1 {
		gettoken first 0 : 0, parse(`""[](),"') quotes
		if `"`first'"'=="" {
			exit
		}
		if `np'==0 & `inopt'==0 & `"`first'"'=="[" {
			Parse "`wtypes'" `0'
			if "`s(done)'"=="1" {
				sret local done
				sret local newcmd `"`lhs'`s(rest)'"'
				sret local rest
				exit
			}
			local np = `np' + 1
			local lhs `"`lhs'`first'"'
		}
		else {
			if `"`first'"'=="(" {
				local np = `np' + 1
			}
			else if `"`first'"'==")" { 
				local np = `np' - 1 
			}
			else if `"`first'"'=="," { 
				local inopt  = ~`inopt'
			}
			local lhs `"`lhs'`first'"'
		}
	}
	/*NOTREACHED*/
end

program define Parse, sclass
	sret local done 
	gettoken types 0 : 0
	gettoken type 0 : 0, parse("=")
	gettoken eqsign 0 : 0, parse("=")
	if `"`eqsign'"' != "=" { 
		exit
	}

	local chk = trim(`"`type'"')
	local l = length(`"`chk'"')

	if substr("weight",1,`l')==`"`chk'"' {
		local valid 1
	}
	else if substr("fweight",1,max(2,`l'))==`"`chk'"' {
		local valid 1
	}
	else if substr("aweight",1,max(2,`l'))==`"`chk'"' {
		local valid 1
	}
	else if substr("pweight",1,max(2,`l'))==`"`chk'"' {
		local valid 1
	}
	else if substr("iweight",1,max(2,`l'))==`"`chk'"' {
		local valid 1
	}
	else if substr("frequency",1,max(4,`l'))==`"`chk'"' {
		local valid 1
	}
	else if substr("cellsize",1,max(4,`l'))==`"`chk'"' {
		local valid 1
	}

	if "`valid'"=="" { exit }

	local nb 1
	while `nb' {
		gettoken subexp 0 : 0, parse(`""[]"') quotes
		if `"`subexp'"'=="]" {
			local nb = `nb' - 1
		}
		if `nb' {
			if `"`subexp'"'=="[" {
				local nb = `nb' + 1
			}
			local wexp `"`wexp'`subexp'"'
		}
	}
	sret local rest `"`0'"'
	local 0 `"[`type'=`wexp']"'
	syntax [`types']
	sret local weight `"[`weight'`exp']"'
	sret local done 1
end
exit

This is the previous code:

*  version 1.1.0  12nov1997
program define _parsewt, sclass
* touched by kth
/*
   This program parses out [weight=exp] from a command.
   Syntax
		_parsewt "allowed_weight_types" command_stuff
   Example
		_parsewt "fweight aweight" `*'
   Returns
		s(newcmd) = command with [weight=exp] removed
		s(weight) = "[weight=exp]"

   Note: If there are weights, command must be less than 80 characters.
         If there are no weights, this limit does not apply.

   Note: Program will issue the message "(frequency weights assumed)", etc.,
   if appropriate.
*/
	version 6.0
	sret clear
	local wtypes "`1'"
	macro shift
	sret local newcmd "`*'"

	parse "`*'", parse("[]")
	local nbrack 0
	local i 2
	while "``i''"!="" {
		if "``i''"=="[" {
			local nbrack = `nbrack' + 1
			local i = `i' + 1
			local weight "`wtypes'"
			local exp
			capture parse "[``i'']"
			if _rc == 0 {
				local weight "`wtypes'"
				local exp
				parse "[``i'']"  /* we do this only to issue
						    "(... weights assumed)"
						    message
						 */
				sret local weight "[`weight'`exp']"
				StripWgt `nbrack' `s(newcmd)'
				exit
			}
		}
		local i = `i' + 1
	}
end

program define StripWgt, sclass /* noclear  */
	version 6.0
	local nbrack "`1'"
	macro shift
	local cmdin "`*'"
	local i 1 
	while `i' < `nbrack' {
		local j = index("`cmdin'","[")
		local piece = substr("`cmdin'",1,`j')
		local cmdout "`cmdout'`piece'"
		local cmdin = substr("`cmdin'",`j'+1,.)
		local i = `i' + 1
	}
	local j = index("`cmdin'","[")
	local piece = substr("`cmdin'",1,`j'-1)
	local cmdout "`cmdout'`piece'"
	local cmdin = substr("`cmdin'",`j'+1,.)
	local j = index("`cmdin'","]")
	local piece = substr("`cmdin'",`j'+1,.)
	sret local newcmd "`cmdout'`piece'"
end
