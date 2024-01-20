*! version 1.0.0  18dec2004
version 9.0

mata:

void symeigensystem(numeric matrix A, V, lambda)
{
	numeric matrix Acpy

	if(isfleeting(A)) _symeigensystem(A,      V, lambda)
	else              _symeigensystem(Acpy=A, V, lambda)
}

end
