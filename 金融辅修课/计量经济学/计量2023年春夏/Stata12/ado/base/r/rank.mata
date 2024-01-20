*! version 3.0.0  20jan2005
version 9.0
mata:

real scalar rank(numeric matrix X, |real scalar tol) 
{
	numeric matrix Xcpy

	return(rank_from_singular_values(_svdsv(isfleeting(X) ? X : (Xcpy=X)),
					tol))
}

end
