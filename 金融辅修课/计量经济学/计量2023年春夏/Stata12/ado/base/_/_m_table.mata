*! version 1.0.0  23mar2011
version 12

mata:

class _m_table extends _b_table {

protected:

	// settings
	string	scalar	_mat			// matrix to display
	string	vector	_format

	// work space
	real	vector	mat
	real	scalar	cols
	string	matrix	cstripe

	// private subroutines

	void		init_table()

	void		titles()

	real	scalar	di_eqname()
	void		di_eq_el()
	void		di_eq()
	void		do_equations()
	void		do_equations_sem()

public:

	void		new()

			set_mat()
			set_format()

	void		validate()

	void		report_table()

}

// private subroutines ------------------------------------------------------

void _m_table::init_table()
{
	real	vector	w
	real	vector	vbar
	string	vector	fmt
	real	scalar	k
	real	scalar	i
	real	scalar	sub

	if (_sort) {

		el_info	= st_matrixrowstripe_term_index(_mat), mat[,1]
		sub	= J(2,2,1)
		order	= J(rows(el_info),1,.)
		for (i=1; i<=neq; i++) {
			sub[1,1] = eq_info[i,1]
			sub[2,1] = eq_info[i,2]
			order[|sub|] = order(
				panelsubmatrix(el_info,i,eq_info), (1..3))
		}
		el_info	= st_matrixcolstripe_term_index(_mat)
	}

	fmt	= J(1,cols,"%9.0g")
	k	= min((cols-1,length(_format)))
	for (i=1; i<=k; i++) {
		if (strlen(_format[i])) {
			fmt[i+1] = _format[i]
		}
	}

	// column widths
	w = rowshape(rowmax(strlen(cstripe)),1)
	for (i=2; i<=cols; i++) {
		if (w[i] < fmtwidth(fmt[i])) {
			w[i] = fmtwidth(fmt[i])
		}
	}
	w = w :+ 2
	w[1]	= 0
	w[1]	= _b_linesize() - sum(w) - 2
	_width	= _find_min_width(w[1], _mat, 1, extra_opts)
	w[1]	= _width + 1

	Tab.init(cols)
	Tab.set_width(w)

	Tab.set_format_number(fmt)

	fmt	= "%" :+ strofreal(w) :+ "s"
	fmt[1]	= sprintf("%%%fs", w[1]-1)
	Tab.set_format_title(fmt)

	vbar = J(1,cols+1,0)
	vbar[2] = 1
	Tab.set_vbar(vbar)

	Tab.set_ignore(J(1,cols,".b"))

	Tab.set_lmargin(0)
	_indent = 0

	_ms_di = sprintf("_ms_display, mat(%s)", _mat)
	_ms_di = _ms_di + " indent(%f) w(%f) eq(#%f) el(%f) %s %s %s"

	_eq_di = sprintf("_ms_eq_display, aux width(%f) mat(%s)", _width, _mat)
	_eq_di = _eq_di + " eq(%f)"
}

void _m_table::titles()
{
	Tab.sep("top")
	if (any(strlen(cstripe[,1]))) {
		Tab.titles(cstripe[,1])
	}
	Tab.titles(cstripe[,2])
}

real scalar _m_table::di_eqname(real	scalar	eq,
				real	scalar	width,
				|real	scalar	dosep)
{
	string	scalar	eqname

	if (eq < 1 | eq > rows(eq_info)) {
		exit(error(303))
	}

	eqname	= stripe[eq_info[eq,1],1]

	if (eqname == "_") {
		eqname = ""
	}

	if (dosep) {
		Tab.sep()
	}
	if (strlen(eqname)) {
		stata(sprintf(	"_ms_eq_display, w(%f) eq(%f) mat(%s) row",
				width,
				eq,
				_mat))
		printf("\n")
	}
	return(0)
}

void _m_table::di_eq_el(real	scalar	eq,
			real	scalar	el,
			real	scalar	oldterm,
			string	scalar	first,
			real	scalar	output,
			string	scalar	diopts)
{
	real	scalar	pos
	real	scalar	j
	real	scalar	term
	string	scalar	nameopt
	real	vector	values

	if (_sort) {
		nameopt = "noname"
		pos = sub_order[el]
		term = sub_el_info[pos,2]
		if (term != oldterm) {
			stata(sprintf(	_ms_di,
					_indent,
					_width,
					eq,
					el,
					first,
					diopts,
					"nolev"))
			oldterm = term
			if (st_numscalar("r(output)")) {
				if (st_numscalar("r(k)")) {
					printf("\n")
				}
				first = ""
			}
			else {
				first = "first"
				return
			}
		}
	}
	else {
		pos = el
	}
	stata(sprintf(	_ms_di,
			_indent,
			_width,
			eq,
			pos,
			first,
			diopts,
			(strlen(first) ? "" : nameopt)))
	if (st_numscalar("r(output)")) {
		first = ""
		if (!output) {
			output = 1
			diopts = _diopts
		}
	}
	else {
		if (st_numscalar("r(first)")) {
			first = "first"
		}
		return
	}

	j = eq_info[eq,1] + pos - 1

	values	= .b, mat[j,]
	Tab.row(values)
}

void _m_table::di_eq(real scalar eq, |real scalar dosep)
{
	real	scalar	i0
	real	scalar	k
	real	scalar	output
	string	scalar	first
	string	scalar	diopts
	real	scalar	i

	real	scalar	oldterm

	if (eq < 1 | eq > rows(eq_info)) {
		exit(error(303))
	}

	i0	= eq_info[eq,1]
	k	= eq_info[eq,2] - i0 + 1
	if (di_eqname(eq, _width, dosep)) {
		return
	}

	output	= 0
	first	= ""
	diopts	= _diopts
	if (!strpos(diopts, "vsquish")) {
		diopts = diopts + " vsquish"
	}
	if (_sort) {
		sub_order	= panelsubmatrix(order, eq, eq_info)
		sub_el_info	= panelsubmatrix(el_info, eq, eq_info)
	}
	oldterm	= .
	Tab.set_skip1(1)
	for (i=1; i<=k; i++) {
		di_eq_el(eq, i, oldterm, first, output, diopts)
	}
	Tab.set_skip1(.)
}

void _m_table::do_equations()
{
	real	scalar	i

	titles()

	for (i=1; i<=neq; i++) {
		di_eq(i)
	}

	finish()
}

void _m_table::do_equations_sem()
{
	real	scalar	output
	string	scalar	first
	string	scalar	diopts
	string	scalar	block
	real	scalar	eq
	real	scalar	el1
	real	scalar	el2
	real	scalar	nels
	real	scalar	new_block
	real	vector	widths
	real	scalar	oldterm
	real	scalar	el
	string	scalar	old_name
	string	scalar	name
	real	scalar	pos
		vector	hold

	pragma unset name

	titles()

	output	= 0
	first	= ""
	_diopts	= _diopts + " sem"
	if (_label == 0) {
		_diopts	= _diopts + " nolabel"
	}
	else if (!missing(_wrap)) {
		_diopts	= _diopts + sprintf(" wrap(%f)", _wrap)
	}
	diopts	= _diopts
	if (!strpos(diopts, "vsquish")) {
		diopts = diopts + " vsquish"
	}

	block	= ""
	old_name = ""
	pos	= 1
	for (eq=1; eq<=neq; eq++) {
		el1 = eq_info[eq,1]
		el2 = eq_info[eq,2]
		nels = el2 - el1 + 1
		new_block = _sem_eq_block(	stripe[el1,1],
						pclassmat[el1],
						block,
						name)
		if (new_block) {
			sep()
			comment(strproper(block), .b, "", 1)
		}
		if (!any(block:==tokens("mean variance")) & old_name!=name) {
			hold = Tab.set_width()
			widths = hold
			widths[1] = widths[1] - 2
			_width = widths[1] - 1
			Tab.set_width(widths)
			Tab.set_lmargin(2)
			if (!new_block) {
				Tab.sep()
			}
			old_name = name
			if (any(block :== tokens("structural measurement"))) {
				if (strlen(name) > _width - 3) {
					name = abbrev(name, _width-3) 
				}
				name = name + " <-"
			}
			comment(name, .b, "", 2)
			Tab.set_width(hold)
			_width = hold[1] - 1
			Tab.set_lmargin(0)
		}
		oldterm	= .
		Tab.set_skip1(1)
		_indent = 2
		_width = _width - _indent
		for (el=1; el<=nels; el++) {
			di_eq_el(eq, el, oldterm, first, output, diopts)
			pos++
		}
		_width = _width + _indent
		_indent = 0
		Tab.set_skip1(.)
	}
	finish()
}

// public subroutines -------------------------------------------------------

void _m_table::new()
{
	_sort		= 0

	_cmdextras	= 0

	_label		= 1
	_wrap		= 0
	extra_opts	= "row"
}

function _m_table::set_mat(|string scalar name)
{
	if (args() == 0) {
		return(_mat)
	}
	_mat = name
}

function _m_table::set_format(|string vector fmts)
{
	if (args() == 0) {
		return(_format)
	}
	_format = fmts
}

void _m_table::validate()
{
	if (strlen(_mat)) {
		mat = st_matrix(_mat)
	}
	if (cols(mat) == 0) {
		errprintf("matrix required\n")
		exit(198)
	}

	stripe	= st_matrixrowstripe(_mat)
	eq_info	= panelsetup(stripe, 1)
	neq	= rows(eq_info)
	dim	= rows(mat)
	cols	= cols(mat) + 1
	cstripe	= J(cols, 2, "")
	cstripe[|_2x2(2,1,cols,2)|] = st_matrixcolstripe(_mat)

	if (_cmdextras) {
		_cmd = st_global("e(cmd)")
		if (_cmd == "sem") {
			if (_pclassmat == "") {
				_pclassmat = "e(b_pclass)"
			}
			if (strlen(_pclassmat)) {
				pclassmat = st_matrix(_pclassmat)
			}
			if (cols(pclassmat) == 0) {
				pclassmat = J(1,dim,0)
			}
			else {
				if (cols(pclassmat) == 1) {
					pclassmat = rowshape(pclassmat, 1)
				}
				_b_check_rows(_pclassmat, pclassmat, 1)
				_b_check_cols(_pclassmat, pclassmat, dim)
			}
			extra_opts = extra_opts + " sem"
		}
	}
	_diopts = _diopts + " row"
}

void _m_table::report_table()
{
	if (c("noisily") == 0) {
		return
	}

	init_table()
	if (_cmd == "sem") {
		do_equations_sem()
	}
	else {
		do_equations()
	}
}

end
