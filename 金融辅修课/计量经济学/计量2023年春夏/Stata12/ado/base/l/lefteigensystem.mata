*! version 1.0.1  04jan2005
version 9.0

mata:

void lefteigensystem(numeric matrix A, V, lambda, |cond, real scalar nobalance)
{
	numeric matrix  Acpy

	if (args()==3) cond = .

	if (isfleeting(A)) _lefteigensystem(A,      V, lambda, cond, nobalance) 
	else 		   _lefteigensystem(Acpy=A, V, lambda, cond, nobalance) 
}

end
