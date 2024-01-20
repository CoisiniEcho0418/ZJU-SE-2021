*! version 1.0.0  27nov2004
version 9.0

mata:

numeric matrix svsolve(numeric matrix A, numeric matrix B, 
						|rank, real scalar tol)
{
	real scalar    ifa, ifb
	numeric matrix Acpy, X

	ifa = isfleeting(A)
	ifb = isfleeting(B)

	if (ifa & ifb) {
		rank = _svsolve(A, B, tol)
		return(B)
	}

	if (ifa & !ifb) {
		rank = _svsolve(A, X=B, tol)
		return(X)
	}
	
	if (!ifa & ifb) {
		rank = _svsolve(Acpy=A, B, tol)
		return(B)
	}

					/* last case of !ifa & !ifb */
	rank = _svsolve(Acpy=A, X=B, tol)
	return(X)
}

end
