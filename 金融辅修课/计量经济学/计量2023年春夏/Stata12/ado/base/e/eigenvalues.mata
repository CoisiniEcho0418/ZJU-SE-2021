*! version 1.0.1  04jan2005
version 9.0

mata:

complex vector eigenvalues(numeric matrix A, |cond, real scalar nobalance)
{
	numeric matrix  Acpy
	complex vector 	evals

	if (args()==1) cond = .

	if (isfleeting(A)) return(_eigenvalues(A,      cond, nobalance))
	else  		   return(_eigenvalues(Acpy=A, cond, nobalance)) 

}

end
