*! version 1.0.0  25aug2010
* This is used by commands that allow substitutable expressions and
* derivatives --- -gmm- and -mlexp-.
program _parmlist_deriv, sclass
	version 12
	args derivative eqnames

	sreturn clear
	// separate [<eq>]/param = deriv
	gettoken first deriv : derivative, p("=") bind
	gettoken equal deriv : deriv, p("=") bind

	// deriv has expression; first has [<eq>]/param
	gettoken eqn param : first, p("/") bind
	gettoken slash param : param, p("/") bind

	// If user just types /param, eqn has "/" and slash has parameter
	if "`eqn'" == "/" {
		local param `slash'
		local slash "/"
		local eqn 1
	}

	if "`slash'" != "/" | "`equal'" != "=" {
		di in smcl as error "{cmd:derivative(`derivative')} invalid"
		exit 498
	}
	if "`eqn'" == "" {
		local eqn 1
	}
	else {
		// undocumented: can specify deriv(#1/b0=...) -- #sign
		if substr(`"`eqn'"',1,1) == "#" {
			local eqn `=substr(`"`eqn'"',2,.)'
		}
		capture confirm integer number `eqn'
		if _rc {
			local 0 , equation(`eqn')
			syntax , [EQuation(string)]
			local eqn : list posof "`equation'" in eqnames
			if `eqn' == 0 {
				di in smcl as error 			///
"{cmd:derivative(`derivative')} invalid: equation `equation' not found"
			}
		}
	}
	sreturn local param "`param'"
	sreturn local eqn "`eqn'"
	sreturn local deriv `"`deriv'"'
end
