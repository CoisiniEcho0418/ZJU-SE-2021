*! version 2.0.0  01jul2008
* ghkfastsetup - generate halton/uniform sequences for ghkfast
* dependencies: ghkfast.mata

version 10.1
mata:
mata set matastrict on

struct ghkfastspoints scalar ghkfastsetup(real scalar n, real scalar npts, 
		real scalar dim, string scalar method) 
{
	real scalar imethod, i, j, k, k1, l, d1, pr, pj, xj, b, d, nn, m
	real rowvector primes, u
	real matrix U
	struct ghkfastpoints scalar S

	primes = (2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71)

	d = trunc(dim)
	if (d<=0 || d>length(primes)) {
		errprintf("dimension must be a positve integer less than ") 
		errprintf("or equal to %g\n", length(primes))
		exit(3300)
	}
	nn = trunc(n)
	if (nn<=0 || missing(nn)) {
		errprintf("number of observations must be a postitive ")
		errprintf("integer\n") 
		exit(3300)
	}
	S.dim = d
	S.n = nn

	S.param = ghk_init(npts)
	m = S.param.npts
	/* ghk() does not have the ghalton option			*/
	/* do not call ghk_init_method() but keep indices consistant	*/
	l = strlen(method)
	if (method==substr("halton",1,max((3,min((l,6)))))) {
		imethod = 1
		S.param.method = imethod = 1
	}
	else if (method==substr("hammersley",1,max((3,min((l,10)))))) {
		imethod = 2
		S.param.method = imethod = 2
	}
	else if (method==substr("random",1,max((4,min((l,6)))))) {
		imethod = 3
		S.param.method = imethod = 3
	}
	else if (method==substr("ghalton",1,max((4,min((l,7)))))) {
		imethod = 4
		S.param.method = imethod = 4
	}
	else {
		errprintf("method must be one of halton, hammersley, random, ")
		errprintf("or ghalton\n")
		exit(3300)
	}

	d1 = d-1
	S.U = J(n,1,NULL)
	if (imethod == 3) {
		S.param.seed = uniformseed()

		for (i=1; i<=n; i++) S.U[i] = &uniform(m,d1)
	}
	else {
		U = J(m,d1,.)
		k1 = 0
		if (imethod == 2) {
			U[,1] = (2:*range(1,m,1):-1):/(2*m)
			--d1
			++k1
		}
		if (imethod == 4) {
			S.param.seed = uniformseed()
			u = uniform(1,d)
		}
		else u = J(1,d,0)

		for (i=1; i<=n; i++) {
			for (k=1; k<=d1; k++) {
				pr = primes[k]
				U[,k+k1] = ghalton(m,pr,u[k+k1])
				if (imethod < 3) {
					/* regenerate the last point	*/
					/* to prevent accumulated error	*/
					pj = 1
					xj = 0
					j = i*m
					while (j>0) {
						pj = pj/pr
						b = mod(j,pr)
						xj = xj + pj*b
						j = trunc((j-b)/pr)
					}
					u[k+k1] = xj
				}

			}
			/* ghalton could accumulate error for large n	*/
			if (imethod==4) u = U[m,]

			S.U[i] = &J(1,1,U)
		}
	}
	return(S)
} 

end
exit
