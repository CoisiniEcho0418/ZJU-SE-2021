*! version 2.0.0  16jun2011
version 12

local type_selegend	-2
local type_coeflegend	-1
local type_dflt		0
local type_beta		1
local type_ci		2
local type_pv		3
local type_dftable	4
local type_groups	5
local type_df		6

local vcerep	bootstrap jackknife
local ascmds	asmprobit asroprobit asclogit nlogit

findfile _b_stat_include.mata
include `"`r(fn)'"'

mata:

class _b_table extends _b_stat {

protected:

	// settings
	real	scalar	_type
	real	scalar	_showginv
	real	scalar	_nofoot
	real	scalar	_label
	real	scalar	_wrap
	real	scalar	_sort

	string	vector	_offset

	string	scalar	_pisemat		// mi setting
	string	scalar	_extrarowmat		// mi setting for MCMC error

	string	scalar	_diopts

	real	scalar	_separator

	string	scalar	_depname
	string	vector	_coefttl
	string	scalar	_pttl
	string	scalar	_cittl

	real	scalar	_mclegend
	string	scalar	_cnsreport
	real	scalar	_clreport

	string	scalar	cformat
	string	scalar	sformat
	string	scalar	pformat
	string	scalar	rowcformat
	string	scalar	rowsformat
	string	scalar	rowpformat

		vector	rowmatnfmt

	real	scalar	_plus
	real	scalar	_eq_hide

	real	scalar	_lstretch

	// work space
	real	scalar	k_eq_base		// e(k_eq_base)

	real	scalar	_width
	real	scalar	_indent
	real	scalar	_is_var

	string	scalar	_ms_di
	string	scalar	_eq_di

	real	scalar	is_legend
	real	scalar	is_cpg

	string	scalar	extra_opts

	real	matrix	pisemat
	real	scalar	dfmis
	real	scalar	has_pisemat

	real	matrix	extrarowmat
	real	scalar	has_extrarowmat
	real	scalar	_norowci

	real	matrix	el_info
	real	matrix	order
	real	matrix	sub_el_info
	real	matrix	sub_order

class	_tab	scalar	Tab

	// private subroutines
	real	scalar	_find_min_width()

	void		mclegend()

	void		init_table()

	void		cluster()
	void		titles()

	void		comment()
	void		di_comment()

	real	scalar	di_eqname()
	void		di_offset()
	void		di_eq_el()
	void		di_eq()
	void		do_equations()
	void		do_equations_ascmd()
	void		do_equations_nlogit()
	real	vector	get_sem_ginv_blocks()
	void		do_equations_sem()

	void		di_aux()
	void		do_aux()
	void		do_aux_ascmd1()
	void		do_aux_ascmd2()

	void		show_diparm()
	void		do_diparms()

	void		do_extra()

	void		sep()
	void		finish()
	void		blank()

public:

	void		new()
virtual	void		validate()

			set_type()
			set_showginv()
			set_nofoot()
			set_label()
			set_wrap()
			set_sort()

			set_offset()

			set_pisemat()
			set_extrarowmat()

			set_diopts()

			set_separator()

			set_depname()
			set_coefttl()
			set_pttl()
			set_cittl()

			set_mclegend()
			set_cnsreport()
			set_clreport()

			set_cformat()
			set_sformat()
			set_pformat()
			set_rowcformat()
			set_rowsformat()
			set_rowpformat()

			set_plus()
			set_eq_hide()
			set_lstretch()

	void		report_table()

}

// private subroutines ------------------------------------------------------

real scalar _b_table::_find_min_width(	real	scalar	width,
					string	scalar	matname,
					|real	scalar	dolevels,
					string	scalar	extra)
{
	real	scalar	rc
	real	vector	gib
	real	scalar	gidx
	string	scalar	block
	real	scalar	new_block
	string	scalar	old_name
	string	scalar	name
	real	scalar	pos
	real	scalar	el1
	real	scalar	el2
	real	scalar	nels
	real	scalar	max
	real	scalar	eq
	real	scalar	el
	real	scalar	k
	real	scalar	i
	real	scalar	w
	string	scalar	text
	string	scalar	myextra
	real	scalar	star
	real	scalar	ind
	real	scalar	ind2

	pragma unset name

	if (_lstretch == 0) {
		return(12)
	}

	if (_cmd != "sem") {
		return(_mc_find_min_width(width, matname, dolevels, extra))
	}
	if (width < 12 | missing(width)) {
		return(12)
	}

	if (missing(dolevels)) {
		dolevels = 1
	}
	if (_label == 0) {
		extra	= extra + " nolabel"
	}
	else if (!missing(_wrap)) {
		extra	= extra + sprintf(" wrap(%f)", _wrap)
	}
	myextra	= extra + " star"

	gib	= get_sem_ginv_blocks()

	gidx	= .
	block	= ""
	old_name = ""
	pos	= 1
	max	= 0
	for (eq=1; eq<=neq; eq++) {
		el1 = eq_info[eq,1]
		el2 = eq_info[eq,2]
		nels = el2 - el1 + 1
		new_block = _sem_eq_block(	stripe[el1,1],
						pclassmat[el1],
						block,
						name)
		if (new_block) {
			w = strlen(block)
			if (max < w) {
				max = w
			}
		}
		ind = 2
		if (!anyof(tokens("mean variance"), block) & old_name!=name) {
			ind = 4
			old_name = name
			if (anyof(tokens("structural measurement"), block)) {
				name = name + " <-"
			}
			w = strlen(name) + 2
			if (max < w) {
				max = w
			}
		}
		ind2 = ind + 2
		for (el=1; el<=nels; el++) {
			star = 0
			if (gib[pos]) {
				if (gidx != gib[pos]) {
					gidx = gib[pos]
					star = 1
				}
			}
			rc = _stata(sprintf(
"_ms_element_info, matrix(%s) width(%f) eq(#%f) el(%f) %s",
				matname, width, eq, el,
				(star ? myextra : extra)), 1)
			pos++
			if (rc == 0) {
				k = st_numscalar("r(k_term)")
				if (k == 0) {
					w = strlen(st_global("r(term)")) + ind
					if (max < w) {
						max = w
					}
				}
				for (i=1; i<=k; i++) {
					text = sprintf("r(term%f)", i)
					w = strlen(st_global(text)) + ind
					if (max < w) {
						max = w
					}
				}
				if (dolevels) {
				    k = st_numscalar("r(k_level)")
				    if (k == 0) {
					w = strlen(st_global("r(level)")) + ind2
					if (max < w) {
						max = w
					}
				    }
				    for (i=1; i<=k; i++) {
					text = sprintf("r(level%f)", i)
					w = strlen(st_global(text)) + ind2
					if (max < w) {
						max = w
					}
				    }
				}
			}
		}
	}

	if (max < 12) {
		return(12)
	}
	if (max > width) {
		return(width)
	}
	return(max)
}

void _b_table::mclegend()
{
	real	scalar	width
	real	vector	w
	real	vector	values
	string	vector	text
	string	scalar	ms_di
	string	scalar	first
	string	scalar	diopts
	real	scalar	i_term
	real	scalar	eq
	real	scalar	k
	real	scalar	i

	w	= J(1,2,0)
	w[2]	= 13
	w[1]	= _b_linesize() - sum(w) - 2
	width	= _find_min_width(w[1], _bmat, 0)
	w[1]	= width + 1
	Tab.init(2)
	Tab.set_width(w)
	Tab.set_vbar((0,1,0))
	values	= J(1,2,.b)
	Tab.set_ignore(strofreal(values))
	text	= J(1,2,"")
	if (_mc_all) {
		text[1] = "%1s"
	}
	text[2]	= sprintf("%%%fs", w[2])
	Tab.set_format_title(text)
	Tab.set_format_string(text)
	text[1]	= ""
	text[2]	= ""
	Tab.set_format_number(text)
	Tab.set_lmargin(0)

	Tab.sep("top")
	text[1]	= ""
	text[2]	= "Number of"
	Tab.titles(text)
	text[2]	= "Comparisons"
	Tab.titles(text)

	if (_mc_all) {
		values[2] = info[1,3]
		text[1] = "All"
		text[2] = ""
		Tab.sep()
		Tab.row(values, text)
	}
	else {
		ms_di	= sprintf("_ms_display, w(%f) mat(%s)", width, _bmat)
		ms_di	= ms_di + " eq(#%f) el(%f) %s %s"

		first	= ""
		diopts	= "allbase joint nolevel vsquish"
		i_term	= 1
		Tab.set_skip1(1)
		for (eq=1; eq<=neq; eq++) {
			if (di_eqname(eq,width)) {
				continue
			}

			k = term_index[eq_info[eq,2],2]
			for (i=1; i<=k; i++) {
				stata(sprintf(	ms_di,
						eq,
						info[i_term,2],
						first,
						diopts))
				values[2] = info[i_term,3]
				Tab.row(values)
				i_term++
			}
		}
		Tab.set_skip1(.)
	}

	Tab.sep("bottom")

	printf("\n")
}

void _b_table::init_table()
{
	real	vector	w
	string	vector	fmt
	string	scalar	n6
	string	scalar	n7
	real	scalar	p

	is_legend =	_type == `type_coeflegend' |
			_type == `type_selegend'
	is_cpg = 	_type == `type_ci' |
			_type == `type_df' |
			_type == `type_pv' |
			_type == `type_groups'

	if (strlen(cformat) == 0) {
		cformat = "%9.0g"
	}
	else {
		if (fmtwidth(cformat) > 9) {
			errprintf("invalid cformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(cformat, ".")
		if (p == 0) {
			p = strpos(cformat, ",")
		}
		if (p) {
			if (substr(cformat,1,2) == "%0") {
				cformat = "%09" + substr(cformat, p, .)
			}
			else {
				cformat = "%9" + substr(cformat, p, .)
			}
		}
	}

	if (strlen(sformat) == 0) {
		sformat = "%8.2f"
	}
	else {
		if (fmtwidth(sformat) > 8) {
			errprintf("invalid sformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(sformat, ".")
		if (p == 0) {
			p = strpos(sformat, ",")
		}
		if (p) {
			if (substr(sformat,1,2) == "%0") {
				sformat = "%08" + substr(sformat, p, .)
			}
			else {
				sformat = "%8" + substr(sformat, p, .)
			}
		}
	}

	if (strlen(pformat) == 0) {
		pformat = "%5.3f"
	}
	else {
		if (fmtwidth(pformat) > 5) {
			errprintf("invalid pformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(pformat, ".")
		if (p == 0) {
			p = strpos(pformat, ",")
		}
		if (p) {
			if (substr(pformat,1,2) == "%0") {
				pformat = "%05" + substr(pformat, p, .)
			}
			else {
				pformat = "%5" + substr(pformat, p, .)
			}
		}
	}

	if (strlen(rowcformat) == 0) {
		rowcformat = "%9.0g"
	}
	else {
		if (fmtwidth(rowcformat) > 9) {
			errprintf("invalid rowcformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(rowcformat, ".")
		if (p == 0) {
			p = strpos(rowcformat, ",")
		}
		if (p) {
			if (substr(rowcformat,1,2) == "%0") {
				rowcformat = "%09" + substr(rowcformat, p, .)
			}
			else {
				rowcformat = "%9" + substr(rowcformat, p, .)
			}
		}
	}
	if (strlen(rowsformat) == 0) {
		rowsformat = "%8.2f"
	}
	else {
		if (fmtwidth(rowsformat) > 8) {
			errprintf("invalid rowsformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(rowsformat, ".")
		if (p == 0) {
			p = strpos(rowsformat, ",")
		}
		if (p) {
			if (substr(rowsformat,1,2) == "%0") {
				rowsformat = "%08" + substr(rowsformat, p, .)
			}
			else {
				rowsformat = "%8" + substr(rowsformat, p, .)
			}
		}
	}

	if (strlen(rowpformat) == 0) {
		rowpformat = "%5.3f"
	}
	else {
		if (fmtwidth(rowpformat) > 7) {
			errprintf("invalid rowpformat;\nwidth too large\n")
			exit(198)
		}
		p = strpos(rowpformat, ".")
		if (p == 0) {
			p = strpos(rowpformat, ",")
		}
		if (p) {
			if (substr(rowpformat,1,2) == "%0") {
				rowpformat = "%07" + substr(rowpformat, p, .)
			}
			else {
				rowpformat = "%7" + substr(rowpformat, p, .)
			}
		}
	}

	if (_type == `type_dftable' | _type == `type_df') {
		if (!is_mi) {
errprintf("dftable or dfonly settings require mi estimation results\n")
			exit(322)
		}
		if (_dfmat == "e(df_Q_mi)") {
			dfmis = st_numscalar("e(_dfnote_Q_mi)")
		}
		else {
			dfmis = st_numscalar("e(_dfnote_mi)")
		}
		if (length(dfmis) == 0) {
			dfmis = 0
		}
		if (_pisemat == "") {
			_pisemat = "e(pise_mi)"
		}
		pisemat	= st_matrix(_pisemat)
		n6 = "%9.1f"
		n7 = "%9.2f"
	}
	else {
		n6 = cformat
		n7 = cformat
	}
	has_pisemat = length(pisemat)


	if (_sort) {
		real	scalar	i
		real	scalar	sub

		el_info	= st_matrixcolstripe_term_index(_bmat), bmat'
		neq	= rows(eq_info)
		sub	= J(2,2,1)
		order	= J(rows(el_info),1,.)
		for (i=1; i<=neq; i++) {
			sub[1,1] = eq_info[i,1]
			sub[2,1] = eq_info[i,2]
			order[|sub|] = order(
				panelsubmatrix(el_info,i,eq_info), (1..3))
		}
		el_info	= st_matrixcolstripe_term_index(_bmat)
	}

	if (_type == `type_ci') {
		w	= J(1,5,0)
		w[2]	= 11
		w[3]	= 11
		w[4]	= 14
		w[5]	= 12
		w[1]	= _b_linesize() - sum(w) - 2
		_width	= _find_min_width(w[1], _bmat, 1, extra_opts)
		w[1]	= _width + 1
		Tab.init(5)
		Tab.set_width(w)
		Tab.set_vbar((0,1,0,0,0,0))
		Tab.set_ignore(J(1,5,".b"))
		fmt	= J(1,5,"")
		fmt[2]	= sprintf("%%%fs", w[2])
		fmt[3]	= sprintf("%%%fs", w[3]+1)
		fmt[4]	= sprintf("%%%fs", w[4])
		fmt[5]	= sprintf("%%%fs", w[5])
		Tab.set_format_title(fmt)
		Tab.set_format_string(("","%11s","%1s","",""))
		Tab.set_format_number(("",cformat,cformat,cformat,cformat))
		rowmatnfmt = ("", J(1,4,rowcformat))
	}
	else if (_type == `type_df') {
		w	= J(1,5,0)
		w[2]	= 11
		w[3]	= 11
		w[4]	= 14
		w[5]	= 12
		w[1]	= _b_linesize() - sum(w) - 2
		_width	= _find_min_width(w[1], _bmat, 1, extra_opts)
		w[1]	= _width + 1
		Tab.init(5)
		Tab.set_width(w)
		Tab.set_vbar((0,1,0,0,0,0))
		Tab.set_ignore(J(1,5,".b"))
		fmt	= J(1,5,"")
		fmt[2]	= sprintf("%%%fs", w[2])
		fmt[3]	= sprintf("%%%fs", w[3]+1)
		fmt[4]	= sprintf("%%%fs", w[4])
		fmt[5]	= sprintf("%%%fs", w[5])
		Tab.set_format_title(fmt)
		Tab.set_format_string(("","%11s","%1s","",""))
		Tab.set_format_number(("",cformat,cformat,n6,n7))
		rowmatnfmt = ("", J(1,4,rowcformat))
	}
	else if (_type == `type_pv') {
		w	= J(1,5,0)
		w[2]	= 11
		w[3]	= 11
		w[4]	= 9
		w[5]	= 8
		w[1]	= _b_linesize() - sum(w) - 2
		_width	= _find_min_width(w[1], _bmat, 1, extra_opts)
		w[1]	= _width + 1
		Tab.init(5)
		Tab.set_width(w)
		Tab.set_vbar((0,1,0,0,0,0))
		Tab.set_ignore(J(1,5,".b"))
		fmt	= J(1,5,"")
		fmt[2]	= sprintf("%%%fs", w[2])
		fmt[3]	= sprintf("%%%fs", w[3]+1)
		fmt[4]	= "%7s"
		fmt[5]	= sprintf("%%%fs", w[5])
		Tab.set_format_title(fmt)
		Tab.set_format_string(("","%11s","%1s","",""))
		Tab.set_format_number(("",cformat,cformat,sformat,pformat))
		rowmatnfmt = ("", J(1,2,rowcformat), rowsformat, rowpformat)
	}
	else if (_type == `type_groups') {
		if (!do_groups) {
			return
		}
		w	= J(1,5,0)
		w[2]	= 11
		w[3]	= 11
		w[4]	= 3
		w[5]	= max(strlen(groups))
		w[1]	= max((7, strlen(mctitle)))
		if (w[5] < w[1]) {
			w[5] = w[1]
		}
		w[1]	= 0
		w[1]	= _b_linesize() - sum(w) - 2
		if (w[1] < 12) {
			groups	= subinstr(groups, " ", "")
			w[5]	= max(strlen(groups))
			w[1]	= max((7, strlen(mctitle)))
			if (w[5] < w[1]) {
				w[5] = w[1]
			}
			w[1]	= 0
			w[1]	= _b_linesize() - sum(w) - 2
		}
		_width	= _find_min_width(w[1], _bmat, 1, extra_opts)
		w[1]	= _width + 1
		Tab.init(5)
		Tab.set_width(w)
		Tab.set_vbar((0,1,0,0,0,0))
		Tab.set_ignore(J(1,5,".b"))
		fmt	= J(1,5,"")
		fmt[2]	= sprintf("%%%fs", w[2])
		fmt[3]	= sprintf("%%%fs", w[3]+1)
		fmt[5]	= sprintf("%%%fs", w[5])
		Tab.set_format_title(fmt)
		fmt[3]	= "%1s"
		Tab.set_format_string(fmt)
		Tab.set_format_number(("",cformat,cformat,"",""))
	}
	else {
		Tab.init(7)
		w = J(1,7,0)
		w[2] = 11
		w[3] = 11
		w[4] = 9
		w[5] = 8
		w[6] = 13
		w[7] = 12
		w[1]	= _b_linesize() - sum(w) - 2
		_width	= _find_min_width(w[1], _bmat, 1, extra_opts)
		w[1]	= _width + 1
		Tab.set_width(w)
		Tab.set_vbar((0,1,0,0,0,0,0,0))
		Tab.set_ignore(J(1,7,".b"))
		fmt	= J(1,7,"")
		fmt[1]	= sprintf("%%%fs", w[1]-1)
		fmt[2]	= "%11s"
		fmt[3]	= "%12s"
		fmt[4]	= "%7s"
		fmt[5]	= "%8s"
		fmt[6]	= "%13s"
		fmt[7]	= "%12s"
		Tab.set_format_title(fmt)
		Tab.set_format_string(("","%11s","%1s","","","",""))
		Tab.set_format_number(
			("",cformat,cformat,sformat,pformat,n6,n7))
		rowmatnfmt = ("", J(1,2,rowcformat), rowsformat, rowpformat,
				J(1,2,rowcformat))
	}
	Tab.set_lmargin(0)
	_indent = 0
	_is_var = 0

	_ms_di = sprintf("_ms_display, mat(%s)", _bmat)
	_ms_di = _ms_di + " indent(%f) w(%f) eq(#%f) el(%f) %s %s %s"

	_eq_di = sprintf("_ms_eq_display, aux width(%f) mat(%s)", _width, _bmat)
	_eq_di = _eq_di + " eq(%f)"
}

void _b_table::cluster()
{
	string	scalar	msg
	string	scalar	clustvar
	real	scalar	reps
	string	scalar	nclust
	string	scalar	cmd

	if (_cmdextras) {
		cmd = _cmd
	}
	if (_bmat == "e(b)") {
		cmd = st_global("e(cmd)")
	}
	if (is_mi) {
		msg	= "Within VCE adjusted for"
		reps	= 0
		nclust	= "e(N_clust_mi)"
		cmd	= st_global("e(cmd_mi)")
	}
	else if (anyof(tokens("`vcerep'"), st_global("e(prefix)"))) {
		msg	= "Replications based on"
		reps	= 1
		nclust	= "e(N_clust)"
	}
	else {
		msg	= "Std. Err. adjusted for"
		reps	= 0
		nclust	= "e(N_clust)"
	}
	clustvar = st_global("e(clustvar)")
	if (strlen(clustvar) == 0 & (reps | st_global("e(vce)") == "robust")) {
		if (substr(cmd,1,2) == "xt") {
			stata(sprintf("is_xt %s", cmd))
			if (st_numscalar("r(is_xt)")) {
				clustvar = st_global("e(ivar)")
			}
		}
		else if (anyof(tokens("clogit rologit"), cmd)) {
			clustvar = st_global("e(group)")
		}
		else if (anyof(tokens("`ascmds'"), cmd)) {
			clustvar = st_global("e(case)")
		}
	}
	if (strlen(clustvar)) {
		displayas("txt")
		if (length(st_numscalar(nclust))) {
			printf("{ralign %f:(%s {res:%f} clusters in %s)}\n",
				Tab.width_of_table(),
				msg,
				st_numscalar(nclust),
				clustvar)
		}
		else {
			printf("{ralign %f:(%s clustering on %s)}\n",
				Tab.width_of_table(),
				msg,
				clustvar)
		}
	}
}

void _b_table::titles()
{
	real	scalar	dfpos
	string	scalar	dv
	string	vector	op
	string	scalar	vce
	string	scalar	mse
	string	scalar	vcettl
	real	scalar	vcewd
	string	scalar	vcefmt
	string	scalar	ttl2
	string	scalar	ttl4
	string	scalar	ttl5
	string	scalar	ttl6
	string	scalar	ttl7
	string	scalar	fmt5
	string	scalar	fmt7
	real	scalar	wd
	string	scalar	name
	string	scalar	stat
	real	scalar	p
	real	scalar	plus
	real	scalar	n, i
	real	scalar	rc
	string	vector	text
	real	scalar	has_super_ttl
		vector	hold
		vector	fhold

	if (is_cpg) {
		text = J(1,5,"")
	}
	else {
		text = J(1,7,"")
	}

	if (strlen(_pttl) == 0) {
		_pttl = mctitle
	}
	if (strlen(_cittl) == 0) {
		_cittl = mctitle
	}

	if (strlen(_depname) == 0) {
		dv = st_global("e(depvar)")
	}
	else {
		dv = _depname
	}
	if (cols(tokens(dv)) > 1) {
		dv = ""
	}
	if (strlen(dv)) {
		stata(sprintf("_msparse %s, ivar", dv))
		dv = st_global("r(stripe)")
		p  = strpos(dv, ".")
		if (p & strlen(dv) > _width) {
			op = J(1,0,"")
			_b_compute_multi_line_tsop(op, dv, p, _width)
		}
		else {
			dv = abbrev(dv, _width)
		}
	}

	if (!is_mi & has_vmat) {
		vcettl	= st_global("e(vcetype)")
		vce	= st_global("e(vce)")
	}

	if (_type == `type_selegend') {
		_coefttl[1] = "Std. Err."
	}
	else if (strlen(_coefttl[1]) == 0) {
		_coefttl[1] = "Coef."
	}

	if (vce == "bootstrap") {
		if (strlen(_coefttl[2]) == 0) {
			if (_type != `type_selegend') {
				_coefttl[2] = "Observed"
			}
			else {
				_coefttl[2] = vcettl
			}
		}
		if (vcettl == "Bootstrap") {
			if (strlen(_cittl) == 0) {
				_cittl = "Normal-based"
			}
		}
	}

	if (is_legend) {
		has_super_ttl = strlen(_coefttl[2])
		vcettl = ""
		_cittl = ""
	}
	if (_type == `type_beta') {
		has_super_ttl = strlen(_coefttl[2]) | strlen(vcettl) 
		_pttl = ""
		_cittl = ""
	}
	if (_type == `type_groups') {
		has_super_ttl = strlen(_coefttl[2]) |
				strlen(vcettl) |
				strlen(mctitle)
		_pttl = ""
		_cittl = ""
	}
	else {
		has_super_ttl = strlen(_coefttl[2]) |
				strlen(vcettl) |
				strlen(_pttl) |
				strlen(_cittl)
	}

	if (substr(_cnsreport,1,2) != "no") {
		stata(sprintf("_makecns, displaycns nullok %s", _cnsreport))
	}

	if (_clreport) {
		cluster()
	}

	Tab.sep("top")
	n = length(op)
	if (n) {
		hold = Tab.set_format_title()
		text[1] = sprintf("%%-%fs", _width)
		Tab.set_format_title(text)
		for (i=1; i<n; i++) {
			text[1] = op[1]
			Tab.titles(text)
		}
		if (has_super_ttl) {
			op = op[n]
		}
		else {
			text[1] = op[n]
			Tab.titles(text)
			op = ""
		}
		text[1] = ""
		Tab.reset_format_title(hold)
	}
	else {
		op = ""
	}

	if (_type == `type_dftable' | _type == `type_df' | has_super_ttl) {
		mse	= st_global("e(mse)")
		ttl2	= ""
		ttl4	= ""
		ttl5	= ""
		ttl6	= ""
		ttl7	= ""
		fmt7	= ""
		if (_type == `type_dftable' | _type == `type_df') {
			ttl7 = "% Increase"
			fmt7 = "%12s"
		}
		else if (_type == `type_dflt' | _type == `type_ci') {
			if (vce == "bootstrap") {
				ttl2 = "Observed"
				if (vcettl == "Bootstrap") {
					ttl7 = "Normal-based"
				}
			}
		}
		if (_type == `type_groups') {
			ttl7 = mctitle
		}
		if (strlen(_coefttl[2])) {
			ttl2 = _coefttl[2]
		}
		plus	= 0
		vcewd	= strlen(vcettl)
		if (vcewd & strlen(mse)) {
			name = sprintf("%s_%s", vce, mse)
			stata(sprintf("capture which %s.sthlp", name))
			rc = c("rc")
			if (rc) {
				stata(sprintf("capture which %s.hlp", name))
				rc = c("rc")
			}
			if (!rc) {
				vcettl = sprintf(	"{help %s##|_new:%s}",
							name,
							vcettl)
				plus = strlen(vcettl) - vcewd
			}
			stata("capture")
		}
		if (vcewd) {
			vcewd	= vcewd + plus + ceil((12 - vcewd)/2+1)
			vcefmt	= sprintf("%%%fs", vcewd)
		}
		if (strlen(_pttl)) {
			ttl5 = _pttl
		}
		if (strlen(_cittl)) {
			ttl7 = _cittl
		}
		if (_type != `type_dftable' & _type != `type_groups' &
		    _type != `type_df') {
			wd = strlen(ttl5)
			if (wd > 2) {
				wd = ceil((wd-2)/2) - 1
				ttl4 = substr(ttl5, 1, wd)
				ttl5 = substr(ttl5, wd+1, .)
			}
			fmt5 = "%1s"
			wd = strlen(ttl7)
			if (wd > 2) {
				wd = ceil((wd-2)/2) - 1
				ttl6 = substr(ttl7, 1, wd)
				ttl7 = substr(ttl7, wd+1, .)
			}
			fmt7 = "%1s"
		}
		hold	= Tab.set_format_title()
		fhold	= Tab.set_width()
		text[1] = sprintf("%%-%fs", _width)
		text[3] = vcefmt
		if (_type == `type_ci') {
			if (vcewd > fhold[3]) {
				plus = fhold[4] - (vcewd - fhold[3])
				text[4] = sprintf("%%%fs", plus)
			}
			text[5] = fmt7
			Tab.set_format_title(text)
			text[4] = ""
			text[5] = ""
			Tab.titles((op, ttl2, vcettl, ttl6, ttl7))
		}
		else if (_type == `type_df') {
			if (vcewd > fhold[3]) {
				plus = fhold[4] - (vcewd - fhold[3])
				text[4] = sprintf("%%%fs", plus)
			}
			text[5] = fmt7
			Tab.set_format_title(text)
			text[4] = ""
			text[5] = ""
			Tab.titles((op, ttl2, vcettl, ttl6, ttl7))
		}
		else if (_type == `type_pv') {
			if (vcewd > fhold[3]) {
				plus = fhold[4] - (vcewd - fhold[3])
				text[4] = sprintf("%%%fs", plus)
			}
			else {
				text[4] = sprintf("%%%fs", fhold[4])
			}
			text[5] = fmt5
			Tab.set_format_title(text)
			text[4] = ""
			text[5] = ""
			Tab.titles((op, ttl2, vcettl, ttl4, ttl5))
		}
		else if (_type == `type_groups') {
			Tab.set_format_title(text)
			Tab.titles((op, ttl2, vcettl, "", ttl7))
		}
		else {
			if (vcewd > fhold[3]) {
				plus = fhold[4] - (vcewd - fhold[3])
				text[4] = sprintf("%%%fs", plus)
			}
			else {
				text[4] = sprintf("%%%fs", fhold[4])
			}
			text[5] = fmt5
			text[7] = fmt7
			Tab.set_format_title(text)
			text[4] = ""
			text[5] = ""
			text[7] = ""
			Tab.titles((op, ttl2, vcettl, ttl4, ttl5, ttl6, ttl7))
		}
		Tab.reset_format_title(hold)
		text[1] = ""
		text[3] = ""
		fhold = J(1,0,.)
	}
	if (is_legend) {
		text[3] = "%8s"
		Tab.set_format_title(text)
		text[1] = dv
		text[2] = _coefttl[1]
		text[3] = "Legend"
		Tab.titles(text)
		text[1] = ""
		text[2] = ""
		text[3] = ""
	}
	else if (has_vmat) {
		if (is_mi) {
			stat = "t"
		}
		else {
			stat	= missing(_df) ? "z" : "t"
		}
		if (_type == `type_dftable' | _type == `type_df') {
			if (_type == `type_dftable') dfpos = 6
			else dfpos = 4
			if (dfmis) {
				ttl6	= "{help mi_missingdf##|_new:DF}"
				fhold	= Tab.set_format_title()
				plus	= fmtwidth(fhold[dfpos])+strlen(ttl6)-2
				text[dfpos] = sprintf("%%%fs", plus)
				Tab.set_format_title(text)
				text[dfpos] = ""
			}
			else {
				ttl6	= "DF"
			}
			ttl7	= "Std. Err."
		}
		else if (_type == `type_beta') {
			ttl6	= ""
			if (_cmd == "sem") {
				ttl7	= "Std. Coef."
			}
			else {
				ttl7	= "Beta"
			}
		}
		else if (_type == `type_groups') {
			ttl6	= ""
			ttl7	= ""
		}
		else {
			ttl6	= sprintf("[%g%% Con", _level) 
			ttl7	= "f. Interval]"
		}
		hold	= Tab.set_width()
		if (_type == `type_ci') {
			Tab.set_width(hold + (0,0,1,-1,0))
			fhold	= Tab.set_format_title()
			plus	= fmtwidth(fhold[4]) - 1
			text[4] = sprintf("%%%fs", plus)
			Tab.set_format_title(text)
			text[4] = ""
			Tab.titles((	dv,
					_coefttl[1],
					"Std. Err.",
					ttl6,
					ttl7))
		}
		else if (_type == `type_df') {
			Tab.set_width(hold + (0,0,1,-1,0))
			fhold	= Tab.set_format_title()
			plus	= fmtwidth(fhold[4]) - 1
			text[4] = sprintf("%%%fs", plus)
			Tab.set_format_title(text)
			text[4] = ""
			Tab.titles((	dv,
					_coefttl[1],
					"Std. Err.",
					ttl6,
					ttl7))
		}
		else if (_type == `type_pv') {
			Tab.set_width(hold + (0,0,1,-1,0))
			Tab.titles((	dv,
					_coefttl[1],
					"Std. Err.",
					stat,
					sprintf("P>|%s|", stat)))
		}
		else if (_type == `type_groups') {
			Tab.set_width(hold + (0,0,1,-1,0))
			Tab.titles((	dv,
					_coefttl[1],
					"Std. Err.",
					"",
					"Groups"))
		}
		else {
			Tab.set_width(hold + (0,0,1,-1,0,0,0))
			Tab.titles((	dv,
					_coefttl[1],
					"Std. Err.",
					stat,
					sprintf("P>|%s|", stat),
					ttl6,
					ttl7))
		}
		Tab.set_width(hold)
		if (length(fhold)) {
			Tab.reset_format_title(fhold)
		}
	}
	else {
		text[1] = dv
		text[2] = _coefttl[1]
		Tab.titles(text)
		text[1] = ""
		text[2] = ""
	}
}

void _b_table::comment(	string	scalar	id,
			real	scalar	value,
			string	scalar	comment,
			real	scalar	header,
			|real	scalar	vbar)
{
	real	vector	values
	string	vector	text
		vector	chold
		vector	fhold
		vector	vhold

	chold	= Tab.set_color_string()
	fhold	= Tab.set_format_string()
	values	= J(1,cols(chold),.b)
	text	= J(1,cols(chold),"")
	if (header) {
		text[1] = sprintf("%%-%fs", _width)
	}
	text[2] = "%1s"
	Tab.set_format_string(text)
	text[2] = ""
	if (header == 1) {
		text[1] = "result"
		Tab.set_color_string(text)
	}
	if (vbar == 0) {
		vhold = Tab.set_vbar()
		Tab.set_vbar(0:*vhold)
		text[1] = id
	}
	else {
		text[1] = abbrev(id, _width)
		if (value == .b) {
			text[2] = comment
		}
		else {
			values[2] = value
			text[3] = comment
		}
	}
	Tab.row(values, text)
	Tab.reset_color_string(chold)
	Tab.reset_format_string(fhold)
	if (vbar == 0) {
		Tab.set_vbar(vhold)
	}
}

void _b_table::di_comment(	string	vector	idlist,
				string	scalar	comment)
{
	real	scalar	k
	real	scalar	i

	k = length(idlist)
	if (k==1 & strlen(idlist) == 0) {
		comment("", .b, comment, 1)
	}
	else {
		if (k == 1) {
			comment(idlist[1], .b, comment, 1)
		}
		else {
			comment(idlist[1], .b, "", 0)
		}
		for (i=2; i<=k; i++) {
			comment(idlist[i], .b, comment, 0)
		}
	}
}

real scalar _b_table::di_eqname(real	scalar	eq,
				real	scalar	width,
				|string	scalar	comment,
				real	scalar	dosep)
{
	string	scalar	eqname
	real	scalar	ec

	if (eq < 1 | eq > rows(eq_info)) {
		exit(error(303))
	}

	eqname	= stripe[eq_info[eq,1],1]
	if (strlen(comment)) {
		if (dosep) {
			Tab.sep()
		}
		di_comment(eqname, comment)
		return(1)
	}

	ec = _stata(sprintf("_ms_parse_parts %s", eqname), 1)
	if (ec == 0) {
	    if (	st_numscalar("r(omit)") &
	    		st_global("r(type)") != "interaction") {
		if (length(st_numscalar("r(base)"))) {
			if (!strpos(_diopts, "baselevels")) {
				return(1)
			}
			if (st_numscalar("r(base)")) {
				eqname = sprintf("%f%s.%s",
					st_numscalar("r(level)"),
					st_global("r(ts_op)"),
					st_global("r(name)"))
				comment	= "(base)"
			}
		}
		else if (!strpos(_diopts, "noomitted")) {
			eqname = st_global("r(ts_op)")
			if (strlen(eqname)) {
				eqname = sprintf("%s.%s",
					eqname,
					st_global("r(name)"))
			}
			else {
				eqname = st_global("r(name)")
			}
			comment = "(omitted)"
		}
		else {
			return(1)
		}
		if (strlen(comment)) {
			if (dosep) {
				Tab.sep()
			}
			di_comment(eqname, comment)
			return(1)
		}
	    }
	}

	if (eqname == "_" | _eq_hide == 1) {
		eqname = ""
	}

	if (dosep) {
		Tab.sep()
	}
	if (strlen(eqname)) {
		stata(sprintf(	"_ms_eq_display, w(%f) eq(%f) mat(%s)",
				width,
				eq,
				_bmat))
		printf("\n")
	}
	return(0)
}

void _b_table::di_offset(string scalar offset)
{
	real	scalar	len
	string	scalar	name
	string	scalar	type
	real	vector	values
	string	vector	text
		vector	fhold

	len	= strlen(offset)
	if (len == 0) {
		return
	}
	if (substr(offset,1,3) == "ln(") {
		name = substr(offset,4,len-4)
		if (strlen(offset) > _width) {
			name = abbrev(name, _width-4)
		}
		name = "ln(" + name + ")"
		type = "  (exposure)"
	}
	else {
		name = offset
		type = "  (offset)"
	}

	if (is_cpg) {
		values	= J(1,5,.b)
		text	= J(1,5,"")
	}
	else {
		values	= J(1,7,.b)
		text	= J(1,7,"")
	}
	fhold	= Tab.set_format_string()
	text[3] = "%1s"
	Tab.set_format_string(text)
	text[1]		= name
	values[2]	= 1
	text[3]		= type
	Tab.row(values, text)
	Tab.reset_format_string(fhold)
}

void _b_table::di_eq_el(real	scalar	eq,
			real	scalar	el,
			real	scalar	oldterm,
			string	scalar	first,
			real	scalar	output,
			string	scalar	diopts)
{
	real	scalar	rc
	real	scalar	pos
	real	scalar	j
	real	scalar	term
	real	scalar	b
	real	scalar	beta
	real	scalar	stderr
	real	scalar	ll
	real	scalar	ul
	string	scalar	note
	string	scalar	name
	string	scalar	exp
	string	scalar	nameopt
	string	vector	text
	real	vector	values
	real	scalar	reset_nfmt
		vector	nhold
		vector	nfmt

	if (_sort) {
		nameopt = "noname"
		pos = sub_order[el]
		term = sub_el_info[pos,2]
		if (term != oldterm) {
			rc = _stata(sprintf(	_ms_di,
						_indent,
						_width,
						eq,
						el,
						first,
						diopts,
						"nolev"))
			if (rc) exit(rc)
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
	rc = _stata(sprintf(	_ms_di,
				_indent,
				_width,
				eq,
				pos,
				first,
				diopts,
				(strlen(first) ? "" : nameopt)))
	if (rc) exit(rc)
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

	if (_is_var) {
		stat[j] = .b
		pvalue[j] = .b
	}

	b	= bmat[j]
	if (has_vmat) {
		stderr	= se[j]
		if (!is_groups) {
			ll	= ci[1,j]
			ul	= ci[2,j]
		}
	}
	note	= label[j]

	reset_nfmt = 0
	if (strlen(note)) {
		note = "  " + note
	}
	if (is_legend) {
		if (_type == `type_selegend') {
			b = stderr
			exp = "_se"
		}
		else {
			exp = "_b"
		}
		if (rows(eq_info) > 1 & strlen(stripe[j,1])) {
			name = sprintf(	"  %s[%s:%s]",
					exp,
					stripe[j,1],
					stripe[j,2])
		}
		else {
			name = sprintf(	"  %s[%s]",
					exp,
					stripe[j,2])
		}
		if (is_cpg) {
			values	= J(1,5,.b)
			text	= J(1,5,"")
		}
		else {
			values	= J(1,7,.b)
			text	= J(1,7,"")
		}
		text[3]	= name
		values[2] = b
		Tab.row(values, text)
	}
	else if (strlen(note)) {
		if (is_cpg) {
			values	= J(1,5,.b)
			text	= J(1,5,"")
		}
		else {
			values	= J(1,7,.b)
			text	= J(1,7,"")
			if (_type == `type_beta') {
				if (has_bstdmat) {
					beta = bstdmat[j]
				}
				else {
					beta = _b_get_scalar("r(beta)")
				}
				values[7] = beta
			}
		}
		values[2] = b
		text[3] = note
		Tab.row(values, text)
	}
	else if (_type == `type_groups') {
		values	= J(1,5,.b)
		text	= J(1,5,"")
		values[2] = b
		values[3] = stderr
		text[5]	= groups[j]
		Tab.row(values, text)
	}
	else {
		if (_type != `type_ci') {
			if (!missing(stat[j]) & abs(stat[j]) > 9999) {
				nhold	= Tab.set_format_number()
				nfmt	= nhold
				nfmt[4] = "%8.2e"
				Tab.set_format_number(nfmt)
				reset_nfmt = 1
			}
		}

		if (is_cpg) {
			values	= J(1,5,.b)
			text	= J(1,5,"")
		}
		else {
			values	= J(1,7,.b)
			text	= J(1,7,"")
		}
		values[2] = b
		if (has_vmat) {
			values[3] = stderr
			if (_type == `type_beta') {
				values[4] = stat[j]
				values[5] = pvalue[j]
				if (has_bstdmat) {
					beta = bstdmat[j]
				}
				else {
					beta = _b_get_scalar("r(beta)")
				}
				values[7] = beta
			}
			else if (_type == `type_ci') {
				values[4] = ll
				values[5] = ul
			}
			else if (_type == `type_df') {
				if (j <= cols(dfmat)) {
					values[4] = dfmat[j]
				}
				else {
					values[4] = .
				}
				if (j <= cols(pisemat)) {
					values[5] = pisemat[j]
				}
				else {
					values[5] = .
				}
			}
			else if (_type == `type_pv') {
				values[4] = stat[j]
				values[5] = pvalue[j]
			}
			else if (_type == `type_dftable') {
				values[4] = stat[j]
				values[5] = pvalue[j]
				if (j <= cols(dfmat)) {
					values[6] = dfmat[j]
				}
				else {
					values[6] = .
				}
				if (j <= cols(pisemat)) {
					values[7] = pisemat[j]
				}
				else {
					values[7] = .
				}
			}
			else {
				values[4] = stat[j]
				values[5] = pvalue[j]
				values[6] = ll
				values[7] = ul
			}
		}
		Tab.row(values)
		if (has_extrarowmat) { //display extra row
			values = (.b, extrarowmat[j,.])
			printf("{col %g}{c |}", _width+2)

			if (!reset_nfmt) {	
				nhold = Tab.set_format_number()
				reset_nfmt = 1
			}
			Tab.set_format_number(rowmatnfmt)
			Tab.row(values)

			if (el < eq_info[eq,2]-eq_info[eq,1]+1) blank(0)
		}
		if (reset_nfmt) {
			Tab.set_format_number(nhold)
		}
	}
}

void _b_table::di_eq(	real	scalar	eq,
			string	scalar	comment,
			|real	scalar	dosep)
{
	real	scalar	i0
	real	scalar	k
	real	scalar	output
	string	scalar	first
	string	scalar	diopts
	real	scalar	i
	string	vector	sfmt
		vector	shold

	real	scalar	oldterm

	if (eq < 1 | eq > rows(eq_info)) {
		exit(error(303))
	}

	if (eq == k_eq_base & strlen(comment) == 0) {
		comment = "  (base outcome)"
	}

	i0	= eq_info[eq,1]
	k	= eq_info[eq,2] - i0 + 1
	if (di_eqname(eq, _width, comment, dosep)) {
		return
	}

	output	= 0
	first	= ""
	diopts	= _diopts
	if (!strpos(diopts, "vsquish")) {
		diopts = diopts + " vsquish"
	}
	if (is_cpg) {
		sfmt	= J(1,5,"")
	}
	else {
		sfmt	= J(1,7,"")
	}
	sfmt[2] = "%1s"
	sfmt[3] = "%1s"
	shold = Tab.set_format_string()
	Tab.set_format_string(sfmt)
	Tab.set_skip1(1)
	if (_sort) {
		sub_order	= panelsubmatrix(order, eq, eq_info)
		sub_el_info	= panelsubmatrix(el_info, eq, eq_info)
	}
	oldterm	= .
	for (i=1; i<=k; i++) {
		di_eq_el(eq, i, oldterm, first, output, diopts)
	}
	Tab.set_format_string(shold)
	Tab.set_skip1(.)
	if (eq <= length(_offset)) {
		di_offset(_offset[eq])
	}
}

void _b_table::do_equations()
{
	real	scalar	i
	real	scalar	k

	titles()

	for (i=1; i<=_neq; i++) {
		di_eq(i, "")
	}
	if (_neq == 0) {
		k = length(_offset)
		for (i=1; i<=k; i++) {
			if (strlen(_offset[i])) {
				Tab.sep()
				di_offset(_offset[i])
			}
		}
	}
}

void _b_table::do_equations_ascmd()
{
	real	scalar	i
	real	scalar	j
	real	scalar	k_indvars
	real	scalar	has_const
	real	scalar	k_casevars
	real	scalar	i_base
	real	scalar	k_alt
	string	vector	alteqs

	titles()

	k_indvars = _b_get_scalar("e(k_indvars)")
	if (missing(k_indvars)) {
		k_indvars = 0
	}

	has_const = _b_get_scalar("e(const)")
	if (missing(has_const)) {
		has_const = 0
	}

	k_casevars = _b_get_scalar("e(k_casevars)")
	if (missing(k_casevars)) {
		k_casevars = 0
	}

	i_base = _b_get_scalar("e(i_base)")
	if (missing(i_base)) {
		i_base = 0
	}

	k_alt = _b_get_scalar("e(k_alt)")
	if (missing(k_alt)) {
		k_alt = 0
	}

	alteqs = tokens(st_global("e(alteqs)"))

	j = 1
	if (k_indvars) {
		di_eq(j, "")
		j++
	}
	if (k_indvars == 0) {
		if (strlen(_offset[1])) {
			sep()
			comment(st_global("e(altvar)"), .b, "", 1)
			di_offset(_offset[1])
		}
	}
	_offset = ""

	if (has_const + k_casevars > 0) {
		for (i=1; i<=k_alt; i++) {
			if (i == i_base) {
				sep()
				comment(alteqs[i], .b, "  (base alternative)", 1)
			}
			else {
				di_eq(j, "")
				j++
			}
		}
	}
}

void _b_table::do_equations_nlogit()
{
	real	scalar	i
	real	scalar	ii
	real	scalar	j
	real	scalar	jj
	real	scalar	el
	real	scalar	k_indvars
	real	scalar	has_const
	real	scalar	k_levels
	real	scalar	k_ind2vars
	string	scalar	ename
	real	matrix	altmat
	real	matrix	k_altern
	string	vector	alteqs
	string	vector	ind2vars
	real	scalar	k_alteqs
	real	scalar	i_base
	string	scalar	buf
	real	scalar	inc_j
	string	scalar	diopts
	string	scalar	first
	real	scalar	output

	titles()

	k_indvars	= _b_get_scalar("e(k_indvars)", 0)
	has_const	= _b_get_scalar("e(const)", 0)
	k_levels	= _b_get_scalar("e(levels)", 0)

	diopts	= _diopts
	if (!strpos(diopts, "vsquish")) {
		diopts = diopts + " vsquish"
	}

	j = 1
	if (k_indvars) {
		di_eq(j, "")
		j++
	}
	for (i=1; i<=k_levels; i++) {
		if (i < k_levels) {
			ename = sprintf("e(const%f)", i)
			has_const = _b_get_scalar(ename, 0)
			ename = sprintf("e(ind2vars%f)", i)
			ind2vars = tokens(st_global(ename))
		}
		else {
			has_const = _b_get_scalar("e(const)", 0)
			ind2vars = tokens(st_global("e(ind2vars)"))
		}
		k_ind2vars = length(ind2vars)

		if (k_ind2vars + has_const == 0) {
			continue
		}

		if (i < k_levels) {
			if (k_ind2vars) {
				ename = sprintf("e(alt_ind2vars%f)", i)
				altmat = st_matrix(ename)
			}

			ename = sprintf("e(alteqs%f)", i)
			alteqs = tokens(st_global(ename))

			ename = sprintf("e(i_base%f)", i)
			i_base = _b_get_scalar(ename, 0)

			ename = sprintf("e(altvar%f)", i)
			buf = st_global(ename) + " equations"
		}
		else {
			if (k_ind2vars) {
				altmat = st_matrix("e(alt_ind2vars)")
			}

			alteqs = tokens(st_global("e(alteqs)"))

			i_base = _b_get_scalar("e(i_base)", 0)

			buf = st_global("e(altvar)") + " equations"
		}
		k_alteqs = length(alteqs)
		if (rows(altmat) != k_alteqs) {
			altmat = J(k_alteqs, k_ind2vars, 1)
		}

		sep("bottom")
		comment(buf, .b, "", 1, 0)
		sep("top")

		first = "first"
		output = 0
		for (ii=1; ii<=k_alteqs; ii++) {
			if (ii == i_base) {
				if (ii > 1) {
					sep()
				}
				comment(alteqs[ii], .b, "", 1)
				inc_j = 0
				el = 1
				for (jj=1; jj<=k_ind2vars; jj++) {
					if (altmat[ii,jj]) {
						Tab.set_skip1(1)
						di_eq_el(	j,
								el,
								.,
								first,
								output,
								diopts)
						el++
						Tab.set_skip1(.)
						inc_j = 1
					}
					else {
						comment(ind2vars[jj],
							0,
							"  (base)",
							0)
					}
				}
				if (has_const) {
					comment("_cons", 0, "  (base)", 0)
				}
				if (inc_j) {
					j++
				}
			}
			else {
				di_eq(j, "", ii > 1)
				j++
			}
		}
	}
	if (k_levels > 1) {
		if (_b_get_scalar("e(rum)", 0)) {
			buf = "dissimilarity parameters"
		}
		else {
			buf = "inclusive-value parameters"
		}
		sep("bottom")
		comment(buf, .b, "", 1, 0)
		sep("top")
		k_altern = st_matrix("e(k_altern)")
		for (i=1; i<k_levels; i++) {
			ename = sprintf("e(altvar%f)", i)
			buf = st_global(ename)
			if (i > 1) {
				sep()
			}
			comment(buf, .b, "", 1)
			Tab.set_skip1(1)
			for (ii=1; ii<=k_altern[1,i]; ii++) {
				di_aux(j)
				j++
			}
			Tab.set_skip1(.)
		}
	}

}

real vector _b_table::get_sem_ginv_blocks()
{
	real	scalar	ng
	real	vector	gib
	real	scalar	k_cns
	real	matrix	C
	real	scalar	i
	real	scalar	k
	real	matrix	sub
	real	scalar	i0
	real	scalar	i1
	real	vector	Cg
	real	scalar	gidx
	real	scalar	dp1
	real	scalar	doit
	real	scalar	kg

	gib = J(1,dim,0)
	if (!has_Cnsmat | _showginv) {
		return(gib)
	}
	ng = _b_get_scalar("e(N_groups)", 1)
	if (ng == 1) {
		return(gib)
	}
	k_cns = rows(Cnsmat)
	if (k_cns == 0) {
		return(gib)
	}

	k = dim/ng		// # of parameters within each group
	if (dim != k*ng) {
		return(gib)
	}

	dp1	= dim+1
	i1	= 0
	gidx	= 0
	for (i=1; i<=k; i++) {
		i0 = i1 + 1
		i1 = i*ng
		Cg	= Cnsmat[|_2x2(1,i0,k_cns,i1)|]
		sub	= rowsum(Cg :!= 0) :!= 0
		kg	= sum(sub)
		if (kg != ng & kg != ng-1) {
			// not the correct number of constraints
			continue
		}
		Cg	= select(Cnsmat, sub)
		if (mreldif(Cg[.,dp1], J(kg,1,Cg[1,dp1])) > 1e-13) {
			// 'r' values differ
			continue
		}

		doit	= 0
		if (kg == ng) {
			// constant constraints
			C	= Cg[|_2x2(1,1,kg,dim)|]
			sub	= (rowsum(C :!= 0) :== 1)
			doit	= (sum(sub) == ng)
		}
		else if (Cg[1,dp1] == 0) {
			// equality constraints
			C	= Cg[|_2x2(1,1,kg,dim)|]
			doit	= allof(rowsum(C :!= 0), 2)	&
				  allof(rowsum(C),0)
		}

		if (doit) {
			gidx++
			gib[|_2x2(1,i0,1,i1)|] = J(1,ng,gidx)
		}
	}

	return(gib)
}

void _b_table::do_equations_sem(real scalar has_ginv)
{
	real	vector	gib
	real	scalar	noomit
	real	scalar	gidx
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

	gib	= get_sem_ginv_blocks()
	has_ginv= any(gib)
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
	noomit = 0
	if (strpos(diopts, "noomitted")) {
		noomit = 1
	}

	gidx	= .
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
			if (block == "variance") {
				_is_var = 1
			}
			else {
				_is_var = 0
			}
		}
		if (!anyof(tokens("mean variance"), block) & old_name!=name) {
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
			if (anyof(tokens("structural measurement"), block)) {
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
			if (!(noomit & label[pos] == "(no path)")) {
				if (gib[pos]) {
					if (gidx != gib[pos]) {
						gidx = gib[pos]
						di_eq_el(eq,
							el,
							oldterm,
							first,
							output,
							diopts + " star")
					}
				}
				else {
					di_eq_el(	eq,
							el,
							oldterm,
							first,
							output,
							diopts)
				}
			}
			pos++
		}
		_width = _width + _indent
		_indent = 0
		Tab.set_skip1(.)
	}
}

void _b_table::di_aux(real scalar eq, |real scalar sep, real scalar covsep)
{
	real	scalar	el
	real	scalar	notest
	string	scalar	name
	string	scalar	exp
	string	vector	text
	real	vector	values
		vector	nhold

	if (_type == `type_selegend') {
		exp	= "_se"
	}
	else {
		exp	= "_b"
	}

	if (is_cpg) {
		values	= J(1,5,.b)
		text	= J(1,5,"")
	}
	else {
		values	= J(1,7,.b)
		text	= J(1,7,"")
	}
	stata(sprintf(_eq_di, eq))
	sep	= _b_get_scalar("r(sep)", 0)
	covsep	= _b_get_scalar("r(covsep)", 0)
	el	= eq_info[eq,2]
	if (is_legend) {
		if (strlen(stripe[el,1])) {
			name = sprintf(	"  %s[%s:%s]",
					exp,
					stripe[el,1],
					stripe[el,2])
		}
		else {
			name = sprintf(	"  %s[%s]",
					exp,
					stripe[el,2])
		}
		if (_type == `type_selegend') {
			values[2] = se[el]
		}
		else {
			values[2] = bmat[el]
		}
		text[3] = name
		Tab.row(values, text)
	}
	else if (_type == `type_beta') {
		values[2] = bmat[el]
		values[3] = se[el]
		values[4] = stat[el]
		values[5] = pvalue[el]
		values[7] = .
		Tab.row(values)
	}
	else if (_type == `type_df') {
		values[2] = bmat[el]
		values[3] = se[el]
		if (el <= cols(dfmat)) {
			values[4] = dfmat[el]
		}
		else {
			values[4] = .
		}
		if (el <= cols(pisemat)) {
			values[5] = pisemat[el]
		}
		else {
			values[5] = .
		}
		Tab.row(values)
	}
	else if (_type == `type_dftable') {
		values[2] = bmat[el]
		values[3] = se[el]
		values[4] = stat[el]
		values[5] = pvalue[el]
		if (el <= cols(dfmat)) {
			values[6] = dfmat[el]
		}
		else {
			values[6] = .
		}
		if (el <= cols(pisemat)) {
			values[7] = pisemat[el]
		}
		else {
			values[7] = .
		}
		Tab.row(values)
	}
	else {
		text[3] = label[el]
		values = J(1,cols(values),.b)
		if (strlen(text[3])) {
			text[3] = "  " + text[3]
			values[2] = bmat[el]
		}
		else {
			values[2] = bmat[el]
			values[3] = has_vmat ? se[el] : .
			if (_type == `type_ci') {
				values[4] = ci[1,el]
				values[5] = ci[2,el]
			}
			else if (_type == `type_pv') {
				values[4] = stat[el]
				values[5] = pvalue[el]
			}
			else {
				values[4] = stat[el]
				values[5] = pvalue[el]
				values[6] = ci[1,el]
				values[7] = ci[2,el]
			}
		}
		Tab.row(values, text)
		text[3] = ""
	}
	if (has_extrarowmat) {	// display extra row
		notest = (values[4]==.b)
		values = (.b, extrarowmat[el,.])
		if (notest) values[4] = values[5] = .b

		printf("{col %g}{c |}", _width+2)

		nhold = Tab.set_format_number()
		Tab.set_format_number(rowmatnfmt)
		Tab.row(values)
		Tab.set_format_number(nhold)

		if (el<dim) blank(0)
	}
}

void _b_table::do_aux()
{
	real	scalar	i0
	real	scalar	i1
	real	scalar	isep
	real	scalar	i
	real	scalar	sep
	real	scalar	covsep
	real	vector	widths
		vector	hold

	if (k_aux == 0) {
		return
	}

	sep()
	Tab.set_skip1(1)
	i0	= _neq + k_eq_skip + 1
	i1	= _neq + k_eq_skip + k_aux
	isep	= 0
	sep	= 0
	covsep	= 0
	for (i=i0; i<=i1; i++, isep++) {
		if (isep & mod(isep, _separator) == 0) {
			sep()
		}
		else if (sep) {
			sep()
		}
		else if (covsep) {
			hold = Tab.set_width()
			widths = hold
			widths[1] = widths[1] - 2
			_width = widths[1] - 1
			Tab.set_width(widths)
			Tab.set_lmargin(2)
			sep()
			Tab.set_width(hold)
			_width = hold[1] - 1
			Tab.set_lmargin(0)
		}
		di_aux(i, sep, covsep)
	}
	Tab.set_skip1(.)
}

void _b_table::do_aux_ascmd1()
{
	real	scalar	start
	real	scalar	i
	real	scalar	j
	real	scalar	k_alt
	real	scalar	k_sigma
	real	scalar	k_rho
	real	scalar	k_eq
	real	scalar	k_indvars

	k_alt = _b_get_scalar("e(k_alt)")
	if (missing(k_alt)) {
		k_alt = 0
	}

	k_sigma = _b_get_scalar("e(k_sigma)")
	if (missing(k_sigma)) {
		k_sigma = 0
	}

	k_rho = _b_get_scalar("e(k_rho)")
	if (missing(k_rho)) {
		k_rho = 0
	}
	k_eq	= k_sigma + k_rho
	if (k_eq == 0) {
		return
	}

	k_indvars = _b_get_scalar("e(k_indvars)")
	if (missing(k_indvars)) {
		k_indvars = 0
	}
	start = (k_indvars != 0) + k_alt - 1

	Tab.set_skip1(1)
	j = start
	for (i=1; i<=k_eq; i++) {
		if (i== 1 | i == k_sigma + 1) {
			sep()
		}
	    	j++
		di_aux(j)
	}
	Tab.set_skip1(.)
}

void _b_table::do_aux_ascmd2()
{
	real	scalar	start
	real	scalar	i
	real	scalar	j
	real	scalar	k_alt
	real	scalar	structcov
	real	scalar	k_factors
	real	vector	stdfixed
	real	scalar	k_indvars
	real	scalar	k_eq

	k_factors = _b_get_scalar("e(k_factors)")
	if (missing(k_factors)) {
		return
	}
	if (k_factors == 0) {
		return
	}

	k_alt = _b_get_scalar("e(k_alt)")
	if (missing(k_alt)) {
		return
	}
	if (k_alt == 0) {
		return
	}

	k_indvars = _b_get_scalar("e(k_indvars)")
	if (missing(k_indvars)) {
		k_indvars = 0
	}
	start = (k_indvars != 0) + k_alt - 1

	structcov = _b_get_scalar("e(structcov)")
	if (missing(structcov)) {
		structcov = 0
	}
	if (structcov == 0) {
		k_alt--
	}

	stdfixed = st_matrix("e(stdfixed)")
	if (length(stdfixed) == 0) {
		return
	}

	k_eq = 0
	for (i=1; i<=k_alt; i++) {
		if (missing(stdfixed[i])) {
			k_eq = k_eq + k_factors
		}
	}
	if (k_eq == 0) {
		return
	}

	sep()
	Tab.set_skip1(1)
	j = start
	for (i=1; i<=k_eq; i++) {
	    	j++
		di_aux(j)
	}
	Tab.set_skip1(.)
}

void _b_table::show_diparm(real scalar i)
{
	real	scalar	code
	string	scalar	exp
	real	scalar	el
	real	scalar	j
	real	scalar	ieq
	real	scalar	pise
	real	scalar	df
	string	scalar	note
	real	vector	values
	string	vector	text
		vector	chold
		vector	fhold
		vector	nhold

	if (is_cpg) {
		values = J(1,5,.b)
		text = J(1,5,"")
	}
	else {
		values = J(1,7,.b)
		text = J(1,7,"")
	}

	code	= diparm_info[1,i]
	el	= diparm_info[2,i]
	if (code == `diparm_sep') {
		sep()
	}
	else if (code == `diparm_bot') {
		sep("bottom")
	}
	else if (code == `diparm_label') {
		text[1]	= diparm_label[1,i]
		text[3]	= diparm_label[2,i]
		Tab.row(values, text)
	}
	else if (code == `diparm_eqlab') {
		chold = Tab.set_color_string()
		fhold = Tab.set_format_string()
		text[1] = "result"
		Tab.set_color_string(text)
		text[1] = sprintf("%%-%fs", _width)
		Tab.set_format_string(text)

		text[1]	= diparm_label[1,i]
		text[3]	= diparm_label[2,i]
		Tab.row(values, text)

		Tab.reset_color_string(chold)
		Tab.reset_format_string(fhold)
	}
	else if (code == `diparm_aux') {
		ieq	= 1
		for (j=1; j<=neq; j++) {
			if (el <= eq_info[j,2]) {
				ieq = j
				break
			}
		}
		stata(sprintf("_ms_eq_display, width(%f) mat(%s) eq(%f) aux",
			_width,
			_bmat,
			ieq))

		if (is_legend) {
			if (_type == `type_selegend') {
				values[2] = diparm_table[2,i]
				exp = "_se"
			}
			else {
				values[2] = diparm_table[1,i]
				exp = "_b"
			}
			if (strlen(stripe[el,1])) {
				text[3] = sprintf(	"  %s[%s:%s]",
							exp,
							stripe[el,1],
							stripe[el,2])
			}
			else {
				text[3] = sprintf(	"  %s[%s]",
							exp,
							stripe[el,2])
			}
		}
		else if (_type == `type_beta') {
			values[2] = diparm_table[1,i]
			values[3] = diparm_table[2,i]
			values[4] = diparm_table[3,i]
			values[5] = diparm_table[4,i]
			values[7] = .
			text[1]	= diparm_label[1,i]
		}
		else if (_type == `type_dftable' | _type == `type_df') {
			df	= .b
			pise	= .b
			if (el & !missing(el)) {
				if (el <= cols(dfmat)) {
					df	= dfmat[1,el]
				}
				else {
					df	= .
				}
				if (el <= cols(pisemat)) {
					pise	= pisemat[1,el]
				}
				else {
					pise	= .
				}
			}
			values[2] = diparm_table[1,i]
			values[3] = diparm_table[2,i]
			if (_type == `type_dftable') {
				values[4] = diparm_table[3,i]
				values[5] = diparm_table[4,i]
				values[6] = df
				values[7] = pise
			}
			else if (_type == `type_df') {
				values[4] = df
				values[5] = pise
			}
			text[1]	= diparm_label[1,i]
		}
		else {
			note = diparm_label[2,i]
			if (strlen(note)) {
				values[2] = diparm_table[1,i]
				text[3] = "  " + note
			}
			else if (diparm_Cns[i]) {
				values[2] = diparm_table[1,i]
				text[3] = "  " + notes[9]
			}
			else {
				values[2] = diparm_table[1,i]
				values[3] = diparm_table[2,i]
				if (_type == `type_ci') {
					values[4] = diparm_table[5,i]
					values[5] = diparm_table[6,i]
				}
				else if (_type == `type_pv') {
					values[4] = diparm_table[3,i]
					values[5] = diparm_table[4,i]
				}
				else {
					values[4] = diparm_table[3,i]
					values[5] = diparm_table[4,i]
					values[6] = diparm_table[5,i]
					values[7] = diparm_table[6,i]
				}
			}
		}

		Tab.set_skip1(1)
		Tab.row(values, text)
		Tab.set_skip1(.)
	}
	else if (code == `diparm_trans') {
		if (is_legend) {
			if (_type == `type_selegend') {
				values[2] = diparm_table[2,i]
			}
			else {
				values[2] = diparm_table[1,i]
			}
		}
		else if (_type == `type_beta') {
			values[2] = diparm_table[1,i]
			values[3] = diparm_table[2,i]
			values[4] = diparm_table[3,i]
			values[5] = diparm_table[4,i]
			values[7] = .
			text[1]	= diparm_label[1,i]
		}
		else if (_type == `type_dftable' | _type == `type_df') {
			df	= .b
			pise	= .b
			if (el & !missing(el)) {
				if (el <= cols(dfmat)) {
					df	= dfmat[1,el]
				}
				else {
					df	= .
				}
				if (el <= cols(pisemat)) {
					pise	= pisemat[1,el]
				}
				else {
					pise	= .
				}
			}
			values[2] = diparm_table[1,i]
			values[3] = diparm_table[2,i]
			if (_type == `type_dftable') {
				values[4] = diparm_table[3,i]
				values[5] = diparm_table[4,i]
				values[6] = df
				values[7] = pise
			}
			else if (_type == `type_df') {
				values[4] = df
				values[5] = pise
			}
			text[1]	= diparm_label[1,i]
		}
		else {
			note = diparm_label[2,i]
			if (strlen(note)) {
				values[2] = diparm_table[1,i]
				text[3] = "  " + note
			}
			else if (diparm_Cns[i]) {
				values[2] = diparm_table[1,i]
				text[3] = "  " + notes[9]
			}
			else {
				values[2] = diparm_table[1,i]
				values[3] = diparm_table[2,i]
				if (_type == `type_ci') {
					values[4] = diparm_table[5,i]
					values[5] = diparm_table[6,i]
				}
				else if (_type == `type_pv') {
					values[4] = diparm_table[3,i]
					values[5] = diparm_table[4,i]
				}
				else {
					values[4] = diparm_table[3,i]
					values[5] = diparm_table[4,i]
					values[6] = diparm_table[5,i]
					values[7] = diparm_table[6,i]
				}
			}
		}

		text[1] = diparm_label[1,i]
		Tab.row(values, text)
	}
	else if (code == `diparm_vlabel') {
		fhold = Tab.set_format_string()

		values[2] = diparm_table[1,i]
		text[1]	= diparm_label[1,i]
		text[3]	= diparm_label[2,i]
		Tab.row(values, text)
	}
	else if (code == `diparm_veqlab') {
		chold = Tab.set_color_string()
		fhold = Tab.set_format_string()
		text[1] = "result"
		Tab.set_color_string(text)
		text[1] = sprintf("%%-%fs", _width)
		Tab.set_format_string(text)

		values[2] = diparm_table[1,i]
		text[1]	= diparm_label[1,i]
		text[3]	= diparm_label[2,i]
		Tab.row(values, text)

		Tab.reset_color_string(chold)
		Tab.reset_format_string(fhold)
	}
	else {
		exit(error(198))
	}
}

void _b_table::do_diparms()
{
	if (_ndiparm == 0) {
		return
	}
	real	scalar	i

	sep()
	for (i=1; i<=_ndiparm; i++) {
		show_diparm(i)
	}
}

void _b_table::do_extra()
{
	real	scalar	i0
	real	scalar	i1
	real	scalar	i

	i0	= _neq + k_eq_skip + k_aux + 1
	i1	= i0 + k_extra - 1
	for (i=i0; i<=i1; i++) {
		di_eq(i, "")
	}
}

void _b_table::sep(|string scalar type)
{
	if (args() == 0) {
		type = "middle"
	}
	Tab.sep(type)
}

void _b_table::finish()
{
	if (_plus) {
		Tab.sep()
	}
	else {
		Tab.sep("bottom")
	}
	st_sclear()
	st_global("s(width)", strofreal(Tab.width_of_table()))
	st_global("s(width_col1)", strofreal(Tab.set_width())[1])
}

void _b_table::blank(|real scalar skip1)
{
	real	vector	w
	real	scalar	hold

	hold = Tab.set_skip1()
	if (args()) {
		Tab.set_skip1(skip1)
	}
	w = J(1,length(Tab.set_width()),.b)
	Tab.row(w)
	if (args()) {
		Tab.set_skip1(hold)
	}
}

// public subroutines -------------------------------------------------------

void _b_table::new()
{
	_type		= `type_dflt'
	_label		= 1
	_wrap		= 0
	_sort		= 0

	_separator	= 0
	_coefttl	= J(1,2,"")
	_mclegend	= 1
	_clreport	= 1

	cformat		= c("cformat")
	sformat		= c("sformat")
	pformat		= c("pformat")
	rowcformat	= cformat
	rowsformat	= sformat
	rowpformat	= pformat

	_plus		= 0

	_norowci	= 0
}

void _b_table::validate()
{
	super.validate()

	is_groups = _type == `type_groups'
	if (is_groups) {
		do_groups = 1
	}
	if (_neq == 1 & k_extra == 0) {
		if (_eq_hide != 0) {
			_eq_hide = 1
		}
	}
	if (_eq_check) {
		k_eq_base = _b_get_scalar("e(k_eq_base)")
	}
	if (_neq > neq) {
		_neq = neq
	}
	if (_cmdextras) {
		if (_cmd == "sem") {
			if (_type == `type_beta') {
				if (has_bstdmat == 0) {
					bstdmat = st_matrix("e(b_std)")
				}
				has_bstdmat = cols(bstdmat)
			}
			if (_semstd & strlen(_depname) == 0) {
				_depname = "Standardized"
			}
			extra_opts = extra_opts + " sem"
		}
		if (anyof(tokens("`ascmds'"), _cmd)) {
			_eq_hide = 0
		}
	}
	if (has_bstdmat) {
		if (has_bstdmat != dim) {
			has_bstdmat = 0
		}
	}

	if (_extrarowmat !="") 
		extrarowmat = st_matrix(_extrarowmat)
	has_extrarowmat = length(extrarowmat)
	if (has_extrarowmat) {
		if (_type == `type_coeflegend') {
errprintf("only one of {bf:rowmatrix()} or {bf:coeflegend} is allowed\n")
			exit(198)
		}
		else if (_type == `type_selegend') {
errprintf("only one of {bf:rowmatrix()} or {bf:selegend} is allowed\n")
			exit(198)
		}
		else if (_type == `type_beta') {
errprintf("only one of {bf:rowmatrix()} or {bf:beta} is allowed\n")
			exit(198)
		}
		else if (_type == `type_groups') {
errprintf("only one of {bf:rowmatrix()} or {bf:groups} is allowed\n")
			exit(198)
		}
		_b_check_rows(_extrarowmat, extrarowmat, dim)
		if (_type == `type_dflt' | _type == `type_dftable') 
			_b_check_cols(_extrarowmat, extrarowmat, 6)
		else _b_check_cols(_extrarowmat, extrarowmat, 4)
		if (_norowci) { // for types displaying CIs
			extrarowmat = (extrarowmat[.,1..cols(extrarowmat)-2],
					J(dim,1,.b), J(dim,1,.b))
		}
	}
}

function _b_table::set_type(|string scalar type)
{
	if (args() == 0) {
		if (_type == `type_beta') {
			return("beta")
		}
		if (_type == `type_ci') {
			return("cionly")
		}
		if (_type == `type_df') {
			return("dfonly")
		}
		if (_type == `type_pv') {
			return("pvonly")
		}
		if (_type == `type_groups') {
			return("groups")
		}
		if (_type == `type_dftable') {
			return("dftable")
		}
		if (_type == `type_coeflegend') {
			return("coeflegend")
		}
		if (_type == `type_selegend') {
			return("selegend")
		}
		return("")
	}
	if (type == "beta") {
		_type = `type_beta'
	}
	else if (type == "cionly") {
		_type = `type_ci'
	}
	else if (type == "dfonly") {
		_type = `type_df'
	}
	else if (type == "pvonly") {
		_type = `type_pv'
	}
	else if (type == "dftable") {
		_type = `type_dftable'
	}
	else if (type == "groups") {
		_type = `type_groups'
	}
	else if (type == "selegend") {
		_type = `type_selegend'
	}
	else if (type == "coeflegend") {
		_type = `type_coeflegend'
	}
	else {
		_type = `type_dflt'
	}
}

function _b_table::set_showginv(|string scalar onoff)
{
	if (args() == 0) {
		if (_showginv) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_showginv = 1
	}
	else {
		_showginv = 0
	}
}

function _b_table::set_nofoot(|string scalar onoff)
{
	if (args() == 0) {
		if (_nofoot) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_nofoot = 1
	}
	else {
		_nofoot = 0
	}
}

function _b_table::set_label(|string scalar onoff)
{
	if (args() == 0) {
		if (_label) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_label = 1
	}
	else {
		_label = 0
	}
}

function _b_table::set_wrap(|real scalar wrap)
{
	if (args() == 0) {
		return(_wrap)
	}
	if (wrap > 0) {
		_wrap = wrap
	}
	else {
		_wrap = 0
	}
}

function _b_table::set_sort(|string scalar sort)
{
	if (args() == 0) {
		if (_sort) {
			return("on")
		}
		return("off")
	}
	if (sort == "on") {
		_sort = 1
	}
	else {
		_sort = 0
	}
}

function _b_table::set_offset(real scalar i, |string scalar text)
{
	if (args() == 1) {
		return(_offset[i])
	}
	real	scalar	k
	transmorphic	t
	pragma unset t

	k = length(_offset)
	if (k == 0) {
		_offset = J(1,i,"")
	}
	else if (i > k) {
		swap(t, _offset)
		_offset = J(1,i,"")
		_offset[|1\k|] = t
	}
	_offset[i] = text
}


function _b_table::set_pisemat(|string scalar name)
{
	if (args() == 0) {
		return(_pisemat)
	}
	_pisemat = name
}

function _b_table::set_extrarowmat(|string scalar name, string scalar noci)
{
	if (args() == 0) {
		return(_extrarowmat)
	}
	_extrarowmat = name
	_norowci = (noci != "")
}

function _b_table::set_diopts(|string scalar diopts)
{
	if (args() == 0) {
		return(_diopts)
	}
	string	scalar	t

	t = st_tempname()
	if (_stata(sprintf("_get_diopts %s, %s", t, diopts))) {
		exit(198)
	}
	_diopts = st_local(t)
	extra_opts = sprintf("%s %s",	extra_opts,
			st_global("s(coding)") + st_global("s(compare)"))
}

function _b_table::set_separator(|real scalar n)
{
	if (args() == 0) {
		return(_separator)
	}
	if (n < 1) {
		_separator = 0
	}
	else {
		_separator = floor(n)
	}
}

function _b_table::set_depname(|string scalar text)
{
	if (args() == 0) {
		return(_depname)
	}
	_depname = text
}

function _b_table::set_coefttl(|string vector text)
{
	if (args() == 0) {
		return(_coefttl)
	}
	if (length(text) < 2) {
		_coefttl = text, ""
	}
	else {
		_coefttl = text
	}
}

function _b_table::set_pttl(|string scalar text)
{
	if (args() == 0) {
		return(_pttl)
	}
	_pttl = text
}

function _b_table::set_cittl(|string scalar text)
{
	if (args() == 0) {
		return(_cittl)
	}
	_cittl = text
}

function _b_table::set_mclegend(|string scalar onoff)
{
	if (args() == 0) {
		if (_mclegend) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_mclegend = 1
	}
	else {
		_mclegend = 0
	}
}

function _b_table::set_cnsreport(|string scalar cnsreport)
{
	if (args() == 0) {
		return(_cnsreport)
	}
	_cnsreport = cnsreport
}

function _b_table::set_clreport(|string scalar onoff)
{
	if (args() == 0) {
		if (_clreport) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_clreport = 1
	}
	else {
		_clreport = 0
	}
}

function _b_table::set_cformat(|string scalar fmt)
{
	if (args() == 0) {
		return(cformat)
	}
	if (strlen(fmt)) {
		cformat = fmt
	}
	else {
		cformat = c("cformat")
	}
}

function _b_table::set_sformat(|string scalar fmt)
{
	if (args() == 0) {
		return(sformat)
	}
	if (strlen(fmt)) {
		sformat = fmt
	}
	else {
		sformat = c("sformat")
	}
}

function _b_table::set_pformat(|string scalar fmt)
{
	if (args() == 0) {
		return(pformat)
	}
	if (strlen(fmt)) {
		pformat = fmt
	}
	else {
		pformat = c("pformat")
	}
}

function _b_table::set_rowcformat(|string scalar fmt)
{
	if (args() == 0) {
		return(rowcformat)
	}
	if (strlen(fmt)) {
		rowcformat = fmt
	}
	else {
		rowcformat = c("cformat")
	}
}

function _b_table::set_rowsformat(|string scalar fmt)
{
	if (args() == 0) {
		return(rowsformat)
	}
	if (strlen(fmt)) {
		rowsformat = fmt
	}
	else {
		rowsformat = c("sformat")
	}
}

function _b_table::set_rowpformat(|string scalar fmt)
{
	if (args() == 0) {
		return(rowpformat)
	}
	if (strlen(fmt)) {
		rowpformat = fmt
	}
	else {
		rowpformat = c("pformat")
	}
}

function _b_table::set_plus(|string scalar onoff)
{
	if (args() == 0) {
		if (_plus) {
			return("on")
		}
		return("off")
	}
	if (onoff == "on") {
		_plus = 1
	}
	else {
		_plus = 0
	}
}

function _b_table::set_eq_hide(|string scalar onoff)
{
	if (args() == 0) {
		if (_eq_hide == 1) {
			return("on")
		}
		if (_eq_hide == 0) {
			return("off")
		}
		return("")
	}
	if (onoff == "on") {
		_eq_hide = 1
	}
	else if (onoff == "") {
		_eq_hide = .
	}
	else {
		_eq_hide = 0
	}
}

function _b_table::set_lstretch(|string scalar onoff)
{
	if (args() == 0) {
		if (_lstretch == 1) {
			return("on")
		}
		if (_lstretch == 0) {
			return("off")
		}
		return("")
	}
	if (onoff == "on") {
		_lstretch = 1
	}
	else {
		_lstretch = 0
	}
}

void _b_table::report_table()
{
	real	scalar	has_ginv
	string	scalar	name

	if (c("noisily") == 0) {
		return
	}

	if (is_groups) {
		if (length(groups) == 0) {
			displayas("txt")
printf("{p 0 6 2}Note: Too many groups to be reported in a table.{p_end}\n")
			return
		}
	}
	if (set_mcompare() != "noadjust") {
		if (_mclegend) {
			mclegend()
		}
	}
	init_table()
	has_ginv = 0
	if (anyof(tokens("`ascmds'"), _cmd)) {
		if (_cmd == "nlogit") {
			do_equations_nlogit()
		}
		else {
			do_equations_ascmd()
			if (missing(_b_get_scalar("e(k_factors)"))) {
				do_aux_ascmd1()
			}
			else {
				do_aux_ascmd2()
			}
		}
	}
	else if (_cmd == "sem") {
		do_equations_sem(has_ginv)
	}
	else {
		do_equations()
		do_aux()
	}
	do_diparms()
	do_extra()
	finish()
	if (has_ginv & !_nofoot) {
		displayas("txt")
printf("{p 0 6 0 %s}Note: [*] ", st_global("s(width)"))
printf("identifies parameter estimates constrained to be equal ")
printf("across groups.")
printf("{p_end}\n")
	}
	if (is_groups) {
		if (_cmd == "pwmean") {
			name = "Means"
		}
		else {
			name = "Margins"
		}
		displayas("txt")
printf("{p 0 6 0 %s}Note: ", st_global("s(width)"))
printf("%s sharing a letter in the group label are ", name)
printf("not significantly different at the %g%% level. ", 100-_level)
printf("{p_end}\n")
	}
}

end
