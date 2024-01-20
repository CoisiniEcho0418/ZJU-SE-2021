*! version 1.1.0  16apr2007
program define two

	if      (_caller() < 8.2)  version 8
	else if (_caller() < 10 )  version 8.2
	else			   version 10

	graph twoway `0'
end
