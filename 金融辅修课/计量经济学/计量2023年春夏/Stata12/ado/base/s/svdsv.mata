*! version 1.0.1  05nov2004
version 9.0

mata:

real colvector svdsv(numeric matrix A) 
{
	numeric matrix	Acopy

	return(_svdsv(Acopy=A))
}

end
