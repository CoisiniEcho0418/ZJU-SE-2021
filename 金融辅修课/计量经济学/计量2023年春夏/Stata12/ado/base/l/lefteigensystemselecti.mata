*! version 1.0.0  24feb2009
version 11.0

mata:

void lefteigensystemselecti(numeric matrix A, real vector index,
		 numeric matrix X, L)
{
	numeric matrix ka

	ka = .

	if(rows(A) != cols(A)) {
		_error(3200)
		return
	}	
	
	index = floor(index)

	if((rows(index) == 2) && (cols(index) == 1)) {
		index = index'
	}
	
	if((rows(index) == 1) && (cols(index) == 2)) {
		if((index[1, 1] < 1) || (index[1, 1] > rows(A)) || 
		   (index[1, 2] < 1) || (index[1, 2] > rows(A))) {
			
			_error(3300)	
			return
		}
	}
	else {
		_error(3200)
		return
	}
	
	if(hasmissing(A)) {
		X = J(rows(A), cols(A), .)
		L = J(1, rows(A), .)
		return
	}
	
	if(rows(A) == 0) {
		L = J(1, 0, 0)
		if(isreal(A)) X=J(0, 0, 0)
		else X=J(0, 0, 0i)
		return
	}

	if(isfleeting(A)) {
		_eigenselecti_la(A, X, ., L, "L", index) 
	}
	else {
		_eigenselecti_la(ka=A, X, ., L, "L", index)
	}
}

end
