*! version 1.0.1  06jun2006
version 9.0
mata:

real rowvector mean(real matrix X, |real colvector w)
{
	real rowvector	CP
	real scalar	n 

	if (args()==1) w = 1

	CP = quadcross(w,0, X,1)
	n  = cols(CP)
	return(CP[|1\n-1|] :/ CP[n])
}

end
