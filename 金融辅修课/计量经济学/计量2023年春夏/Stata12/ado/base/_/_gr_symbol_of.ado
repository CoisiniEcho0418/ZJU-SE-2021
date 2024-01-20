*! version 1.0.0  05jun2002
program define _gr_symbol_of , rclass
	args symmac colon symchar quietly

	if "`symchar'" == "O" {
		c_local `symmac' circle
		exit
	}
	if "`symchar'" == "S" {
		c_local `symmac' square
		exit
	}
	if "`symchar'" == "T" {
		c_local `symmac' triangle
		exit
	}
	if "`symchar'" == "o" {
		c_local `symmac' smcircle
		exit
	}
	if "`symchar'" == "d" {
		c_local `symmac' diamond
		exit
	}
	if "`symchar'" == "+" {
		c_local `symmac' plus
		exit
	}
	if "`symchar'" == "x" {
		c_local `symmac' x
		exit
	}
	if "`symchar'" == "p" {
		c_local `symmac' point
		exit
	}
	if "`symchar'" == "i" {
		c_local `symmac' none
		exit
	}

	di in white "`symchar' is not a valid symbol"
end
