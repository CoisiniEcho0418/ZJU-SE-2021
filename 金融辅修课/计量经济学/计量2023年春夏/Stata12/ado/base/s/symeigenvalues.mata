*! version 1.0.1  03jan2005
version 9.0

mata:

real rowvector symeigenvalues(numeric matrix A)
{
	numeric matrix  Acpy

	if (isfleeting(A)) return(_symeigenvalues(A))
	else  		   return(_symeigenvalues(Acpy=A))

}

end
