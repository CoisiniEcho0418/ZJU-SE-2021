*! version 2.0.0  05mar2008
version 9.0
mata:

transmorphic colvector vech(transmorphic matrix x)
{
	transmorphic matrix	res
	real scalar		n, k, j

	if ((n=rows(x)) != cols(x)) _error(3205) // not square

	res = J((n*(n+1))/2, 1, missingof(x))
	if (n>0) {

		if (eltype(x)=="real" | eltype(x)=="complex") {
			_vech_u(x, res)
		}
		else {
			for (k=j=1; j<=n; j++) {
				res[|k\(k+n-j)|] = x[|(j,j)\(n,j)|]
				k = k + n-j + 1
			}
		}
	}
	return(res)
}

end

