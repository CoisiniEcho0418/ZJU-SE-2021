*! version 1.0.0  03jan2005
program help
	version 9

	if "`c(console)'" == "console" {
		chelp `0'
	}
	else {
		whelp `0'
	}
end
