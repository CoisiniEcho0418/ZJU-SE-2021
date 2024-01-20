*! version 1.0.0  28jan2011
version 11

mata:

real scalar _b_linesize()
{
	return(max((79, c("linesize")))-1)
}

void _b_compute_multi_line_tsop(string	vector	op,
				string	scalar	dv,
				real	scalar	p,
				real	scalar	width)
{
	string	scalar	myop, t
	real	scalar	n, i, j

	myop = substr(dv, 1, p-1)

	if (strlen(myop) < width) {
		op = myop + "."
		dv = abbrev(substr(dv, p+1, .), width)
		return
	}

	n = ceil(strlen(myop)/width)
	op = J(1,n-1,"")
	j = 1
	for (i=1; i<n; i++) {
		op[i] = substr(myop, j, j+11)
		j = j + width
	}
	myop = substr(myop, j, .)
	if (strlen(myop) == 0) {
		dv = abbrev(substr(dv, p+1, .), width)
	}
	else {
		t = myop + "." + substr(dv, p+1, .)
		if (strlen(t) <= width) {
			swap(dv, t)
		}
		else {
			op = op, (myop + ".")
			dv = abbrev(substr(dv, p+1, .), width)
		}
	}
}

real	scalar	_b_get_scalar(string scalar name, |real scalar dflt)
{
	real	scalar	x

	x = st_numscalar(name)
	if (length(x) == 0) {
		x = dflt
		if (strlen(st_global(name))) {
			x = strtoreal(st_global(name))
		}
	}
	return(x)
}

void _b_check_rows(string scalar name, real matrix mat, real scalar r)
{
	real	scalar	cmp

	cmp = rows(mat) - r
	if (cmp != 0) {
		errprintf("conformability error;\n")
		errprintf("matrix %s has too %s rows\n",
			name,
			(cmp > 0 ? "many" : "few"))
		exit(503)
	}
}

void _b_check_cols(string scalar name, real matrix mat, real scalar c)
{
	real	scalar	cmp

	cmp = cols(mat) - c
	if (cmp != 0) {
		errprintf("conformability error;\n")
		errprintf("matrix %s has too %s columns\n",
			name,
			(cmp > 0 ? "many" : "few"))
		exit(503)
	}
}

end
