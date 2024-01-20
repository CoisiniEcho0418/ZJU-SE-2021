*! version 1.0.0  04mar2011
version 12

local sumcmds mean proportion ratio total

mata:

void _matrix_table()
{
	class _m_table scalar T
	string	scalar	s

	T = _m_table()
	T.set_mat(st_local("matrix"))
	T.set_sort(strlen(st_local("sort")) ? "on" : "off")
	s = st_local("format")
	if (strlen(s)) {
		T.set_format(tokens(s))
	}

	T.set_cmdextras(strlen(st_local("cmdextras")) ? "on" : "off")
	T.set_pclassmat(st_local("pclassmatrix"))
	T.set_label(strlen(st_local("nolabel")) ? "off" : "on")
	if (strlen(st_local("wrap"))) {
		T.set_wrap(strtoreal(st_local("wrap")))
	}

	T.set_diopts(st_local("diopts"))

	T.validate()
	T.report_table()
}

end
