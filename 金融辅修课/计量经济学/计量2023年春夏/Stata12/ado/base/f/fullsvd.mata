*! version 1.0.2  18jan2004
version 9.0

mata:

void fullsvd(numeric matrix A, U, s, VT)
{
	numeric matrix	Acopy

	_fullsvd(Acopy=A, U, s, VT)
}

end
