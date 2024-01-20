*! version 1.0.1  04jan2005
version 9.0

mata:

complex vector _eigenvalues(numeric matrix A, |cond, real scalar nobalance)
{
	complex vector evals

	if (args()==1) cond = .

	_eigen_work(0, A, .,  evals, cond, nobalance)
	
	return(evals)
}

end
