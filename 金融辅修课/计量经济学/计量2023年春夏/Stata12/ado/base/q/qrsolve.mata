*! version 1.0.0  27nov2004
version 9.0

mata:

numeric matrix qrsolve(numeric matrix A, numeric matrix B, | rank, real scalar tol)
{
	real scalar    ifa, ifb
	numeric matrix Acpy, X

	ifa = isfleeting(A)
	ifb = isfleeting(B)

	if (ifa & ifb) {
		rank = _qrsolve(A, B, tol)
		return(B)
	}

	if (ifa & !ifb) {
		rank = _qrsolve(A, X=B, tol)
		return(X)
	}
	
	if (!ifa & ifb) {
		rank = _qrsolve(Acpy=A, B, tol)
		return(B)
	}

					/* last case of !ifa & !ifb */
	rank = _qrsolve(Acpy=A, X=B, tol)
	return(X)

}

end
