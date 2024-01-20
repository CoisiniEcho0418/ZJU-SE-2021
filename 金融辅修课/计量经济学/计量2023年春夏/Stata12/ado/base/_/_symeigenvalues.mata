*! version 1.0.0  18dec2004
version 9.0

mata:

real rowvector _symeigenvalues(numeric matrix A)
{
	real rowvector lambda

	_symeigen_work(A, lambda)

	return(lambda)
}

end
