*! version 1.2.0  06apr2007
program gr
	if      (_caller() < 8.2)  version 8
	else if (_caller() < 10 )  version 8.2
	else			   version 10

	graph `0'
end
