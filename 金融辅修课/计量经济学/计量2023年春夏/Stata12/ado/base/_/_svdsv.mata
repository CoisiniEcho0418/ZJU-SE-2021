*! version 1.1.1  20jan2005
version 9.0

mata:

real colvector _svdsv(numeric matrix A) 
{
	real scalar	m, n
	real colvector  s

	m = rows(A)
	n = cols(A)
	(void) _svd_la(A, s)
	return(s)
}

end
