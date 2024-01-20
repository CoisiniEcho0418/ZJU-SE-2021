*! version 1.0.1  20jan2005
version 9.0
mata:

/*
	uniqrows(transmorphic matrix x)

	return sorted, unique list. 
*/

transmorphic matrix uniqrows(transmorphic matrix x)
{
	real scalar		i, j, n, ns 
	transmorphic matrix 	sortx, res

	if (rows(x)==0) return(J(0,cols(x), missingof(x)))
	if (cols(x)==0) return(J(1,0, missingof(x)))

	sortx = sort(x, 1..cols(x))
	ns = 1 
	n = rows(x)
	for (i=2;i<=n;i++) { 
		if (sum(sortx[i-1,]:!=sortx[i,])) ns++
	}
	res = J(ns, cols(x), sortx[1,1])
	res[1,] = sortx[1,]
	for (i=j=2;i<=n;i++) { 
		if (sum(sortx[i-1,] :!= sortx[i,])) res[j++,] = sortx[i,]
	}
	return(res)
}

end
