*! version 1.0.5 20apr2005
program define pause 
	local vers = string(_caller())
	version 6
	if "`1'"=="on" | "`1'"=="off" {
		if "`2'"=="" {
			if "`1'"=="on" { 
				global PAUSEON "yes"
			}
			else	global PAUSEON
			exit
		}
	}
	if "$PAUSEON"=="" { exit }
	set output proc 			/* overrides quietly 	*/
	di in blue `"pause:  `0'"'
	while 1 { 
		local cmd "*"
		capture {
			set output proc
			while `"`cmd'"'!="end" {
				capture {
					set output proc
					version `vers': `cmd'
				}
				if _rc {
					di in blue "r(" _rc ");"
				}
				di in wh "-> " _request(_cmd)
				capture di `"`cmd'"'
				if `"`cmd'"'=="BREAK" { 
					exit 3000
				}
				if `"`cmd'"'=="q" {
					local cmd "end"
				}
			}
			di in blue "execution resumes..."
			exit
		}
		set output proc
		if _rc==1 {
			di in red "--Break--  " in bl "(Type " in wh /* 
			*/ "BREAK" in blu /*
			*/ " to send real break back to calling program)"
		}
		else if _rc==3000 {
			di in bl "sending Break to calling program..."
			exit 1
		}
		else {
			capture {			/* has double quotes */
				set output proc
				version `vers': `cmd'
			}
			if _rc {
				di in blue "r(" _rc ");"
			}
		}
			
	}
	/*NOTREACHED*/
end
