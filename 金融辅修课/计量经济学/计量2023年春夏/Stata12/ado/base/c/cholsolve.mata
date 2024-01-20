*! version 1.0.0   08jan2005
version 9.0

mata:

numeric matrix cholsolve(numeric matrix A, numeric matrix B, |real scalar tol)
{
	numeric matrix 	Acopy, X
	numeric scalar 	Afleet, Bfleet

	Afleet = isfleeting(A)
	Bfleet = isfleeting(B)

	if ( Afleet & Bfleet ) {
		_cholsolve(A, B, tol)
		return(B)
	}

	if ( Afleet & (!Bfleet) ) {
		_cholsolve(A, X=B, tol)
		return(X)
	}

	if ( (!Afleet) & Bfleet ) {
		_cholsolve(Acopy=A, B, tol)
		return(B)
	}
	_cholsolve(Acopy=A, X=B, tol)
	return(X)
}

end
