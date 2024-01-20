*! version 1.4.1  29mar2011
program _coef_table_header
	version 9
	if !c(noisily) {
		exit
	}
	syntax [,			///
		rclass			///
		noHeader		///
		noMODELtest		///
		TItle(string asis)	///
		nocluster		///
		noRULES			///
		noTVAR			///
		SEPTITLE		///
	]

	if ("`header'" != "") exit

	tempname left right
	.`left' = {}
	.`right' = {}

	local is_svy = "`e(prefix)'" == "svy"
	local is_margins = "`e(cmd)'" == "margins"
	if `is_margins' {
		local is_svy 0
	}
	local is_prefix = "`e(prefix)'" != "" 
	if `is_svy' {
		if "`rclass'" != "" {
			local 0 ", rclass"
			syntax [, NONOPTION ]
			exit 198
		}
		local e e
	}
	else {
		if "`rclass'" == "" {
			local e e
		}
		else	local e r
	}
	if "`e'" == "e" {
		is_svysum `e(cmd)'
		local is_sum `r(is_svysum)'
	}
	else {
		local is_sum 0
	}
	if `is_svy' {
		local is_tab = "`e(cmd)'" == "tabulate"
	}
	else	local is_tab 0

	if `is_sum' {
		local width 62
		local C1 _col(1)
		local c2 18
		local c3 37
		local c4 54
		local c2wfmt 7
		local c4wfmt 7
		local scheme compact
	}
	else if `is_prefix' {
		local width 78
		local C1 _col(1)
		local c2 20
		local c3 49
		local c4 68
		local c2wfmt 9
		local c4wfmt 9
		local scheme svy
	}
	else {
		local width 78
		local C1 _col(1)
		local c2 18
		local c3 51
		local c4 67
		local c2wfmt 10
		local c4wfmt 10
		local scheme ml
	}

	if `is_svy' {
		local maxlen = `width'-`c2'-(`c2wfmt'+2)-2-(`c4'-`c3')-2
		if `maxlen' > 19 {
			local maxlen 19
		}
		local len : display %`maxlen'.0f e(N_pop)
		local len : list retok len
		local len : length local len
		local ++maxlen
		local ++len
		if `c4wfmt' <= `len' & `len' <= `maxlen' {
			local c3 = `c3' + `c4wfmt' - `len'
			local c4 = `c4' + `c4wfmt' - `len'
			local c4wfmt = `len'
		}
	}

	local C2 _col(`c2')
	local C3 _col(`c3')
	local C4 _col(`c4')
	if "`septitle'" == "" {
		local max_len_title = `c3' - 2
	}
	else {
		local max_len_title = 0
	}
	local sfmt %13s
	local ablen 14

	local c4wfmt1 = `c4wfmt' + 1
	if "`e'" == "r" & "`r(cmd)'" == "permute" {
		local is_prefix 1
	}

	if "`rules'" == "" & "`e(rules)'" == "matrix" ///
	 & inlist("`e(cmd)'","logistic","logit","probit") {
		if el(e(rules),1,1) != 0 {
			tempname rules
			matrix `rules' = e(rules)
			di
			_binperfout `rules'
		}
	}

	// display title
	if `"`title'"' == "" {
		local title  `"``e'(title)'"'
		local title2 `"``e'(title2)'"'
	}

	// Left hand header *************************************************

	// display N strata
	if `is_prefix' & !`is_margins' & !missing(`e'(N_strata)) {
		.`left'.Arrpush					///
			`C1' "Number of strata" `C2' "= "	///
			as res %`c2wfmt'.0f `e'(N_strata)
	}

	// display number of PSU/clusters
	if `is_svy' & !missing(`e'(N_psu)) {
		.`left'.Arrpush					///
			`C1' "Number of PSUs" `C2' "= "		///
			as res %`c2wfmt'.0f `e'(N_psu)
	}

	// display N of poststrata
	if `is_svy' & !missing(`e'(N_poststrata)) {
		.`left'.Arrpush					///
			`C1' "N. of poststrata" `C2' "= "	///
			as res %`c2wfmt'.0f `e'(N_poststrata)
	}

	// display N of stdize strata
	if (`is_tab' | `is_sum') & !missing(`e'(N_stdize)) {
		.`left'.Arrpush					///
			`C1' "N. of std strata" `C2' "= "	///
			as res %`c2wfmt'.0f `e'(N_stdize)
	}

	if ("`e(N_gaps)'" != "") {
		if (`e(N_gaps)'==1) local gaps_msg ", but with a gap"
		if (`e(N_gaps)'>1) local gaps_msg ", but with gaps"
	}

	if "`tvar'"=="" & "`e(tvar)'"!="" & "`e(tmins)'"!="" & ///
	   "`e(tmaxs)'"!="" {
		.`left'.Arrpush					///
			`C1' `"Sample: `e(tmins)' - `e(tmaxs)'`gaps_msg'"'
	}

	// Right hand header ************************************************

	// display N obs
	if !missing(`e'(N)) {
		.`right'.Arrpush				///
			`C3' "Number of obs" `C4' "= "		///
			as res %`c4wfmt'.0f `e'(N)
	}

	if !`is_svy' & !missing(`e'(N_clust)) ///
	 & "`cluster'``e'(clustvar)'" == "" {
		if "`scheme'" != "svy" {
			local NumClust "N. of clusters"
		}
		else {
			local NumClust "Number of clusters"
		}
		.`right'.Arrpush				///
			`C3' "`NumClust'" `C4' "= "		///
			as res %`c4wfmt'.0f `e'(N_clust)
	}

	// display Pop size
	if `is_svy' & !missing(e(N_pop)) {
		.`right'.Arrpush				///
			`C3' "Population size" `C4' "="		///
			as res %`c4wfmt1'.0g e(N_pop)
	}

	// display subpop N obs and subpop size
	if (`is_svy' | `is_margins') & !missing(`e'(N_sub)) {
		if "`scheme'" == "svy" {
			local SubNobs "Subpop. no. of obs"
		}
		else	local SubNobs "Subpop. no. obs"
		.`right'.Arrpush				///
			`C3' "`SubNobs'" `C4' "="		///
			as res %`c4wfmt1'.0f `e'(N_sub)
		if `is_svy' {
			.`right'.Arrpush				///
				`C3' "Subpop. size" `C4' "="		///
				as res %`c4wfmt1'.0g `e'(N_subpop)
		}
	}

	// display N of replications
	if !missing(`e'(N_reps)) {
		.`right'.Arrpush				///
			`C3' "Replications" `C4' "= "		///
			as res %`c4wfmt'.0f `e'(N_reps)
	}

	if `is_svy' & !missing(`e'(df_r)) {
		.`right'.Arrpush `C3' "Design df" `C4' "= "	///
			as res %`c4wfmt'.0f `e'(df_r)
	}

	if `"`e(k_eq_model)'"' == "0" {
		local modeltest nomodeltest
	}
	if "`modeltest'" == "" & "`e'" == "e" & !missing(e(df_m)) {
		// display a model test
		if `"`e(chi2)'"' != "" | "`e(df_r)'" == "" {
			Chi2test `right' `C3' `C4' `c4wfmt'
		}
		else {
			Ftest `right' `C3' `C4' `c4wfmt' `is_svy'
		}
	}

	if "`e'" == "e" {
		// display R-squared
		if !missing(`e'(r2)) {
			.`right'.Arrpush			///
				`C3' "R-squared" `C4' "= "	///
				as res %`c4wfmt'.4f `e'(r2)
		}
		if !missing(`e'(r2_p)) {
			.`right'.Arrpush			///
				`C3' "Pseudo R2" `C4' "= "	///
				as res %`c4wfmt'.4f `e'(r2_p)
		}
		if !missing(`e'(r2_a)) {
			.`right'.Arrpush			///
				`C3' "Adj R-squared" `C4' "= "	///
				as res %`c4wfmt'.4f `e'(r2_a)
		}
		if !missing(`e'(rmse)) {
			.`right'.Arrpush			///
				`C3' "Root MSE" `C4' "= "	///
				as res %`c4wfmt'.4f `e'(rmse)
		}
	}

	// number of elements in the left header
	local kl = `.`left'.arrnels'
	if `"`title'"' != "" & `kl' == 0 {
		// make title line part of the header if it fits
		local len_title : length local title
		if `"`title2'"' != "" {
			local len_title = ///
			max(`len_title',`:length local title2')
		}
		if `len_title' < `max_len_title' {
			.`left'.Arrpush `"`"`title'"'"'
			local title
			if `"`title2'"' != "" {
				.`left'.Arrpush `"`"`title2'"'"'
				local title2
			}
		}
	}

	// put log likelihood at the bottom of the left header
	if "`e'" == "e" & !missing("`e(ll)'") & !missing(e(crittype)) {
		// number of elements in the right header
		local kr = `.`right'.arrnels'
		// number of elements in the left header
		local kl = `.`left'.arrnels'
		local space = `kr' - `kl' - 1
		forval i = 1/`space' {
			.`left'.Arrpush ""
		}
		local crtype = upper(substr(`"`e(crittype)'"',1,1)) + ///
			substr(`"`e(crittype)'"',2,.)
		.`left'.Arrpush `""`crtype' = " as res %10.0g e(ll)"'
	}

	Display `left' `right' `"`title'"' `"`title2'"'

end

program Display
	args left right title title2

	local nl = `.`left'.arrnels'
	local nr = `.`right'.arrnels'
	local K = max(`nl',`nr')

	di
	if `"`title'"' != "" {
		di as txt `"`title'"'
		if `"`title2'"' != "" {
			di as txt `"`title2'"'
		}
		if `K' {
			di
		}
	}

	local c _c
	forval i = 1/`K' {
		di as txt `.`left'[`i']' as txt `.`right'[`i']'
	}
end

program Ftest
	args right C3 C4 c4wfmt is_svy

	if `is_svy' & "`e(adjust)'" == "" {
		// -svy- F tests are adjusted by default
		if e(df_m) == 0 {
			local df = e(df_r)
		}
		else	local df = e(df_r) - e(df_m) + 1
	}
	else {
		local df = e(df_r)
	}
	if !missing(e(F)) {
		.`right'.Arrpush				///
			 `C3' "F("				///
		   as res %4.0f e(df_m)				///
		   as txt ","					///
		   as res %7.0f `df' as txt ")" `C4' "= "	///
		   as res %`c4wfmt'.2f e(F)
		.`right'.Arrpush				///
			 `C3' "Prob > F" `C4' "= "		///
		   as res %`c4wfmt'.4f Ftail(e(df_m),`df',e(F))
	}
	else {
		local dfm_l : di %4.0f e(df_m)
		local dfm_l2: di %7.0f `df'
		local j_robust "{help j_robustsingular##|_new:F(`dfm_l',`dfm_l2')}"
		.`right'.Arrpush				///
			  `C3' "`j_robust'"			///
		   as txt `C4' "= " as result %`c4wfmt's "."
		.`right'.Arrpush				///
			  `C3' "Prob > F" `C4' "= " as res %`c4wfmt's "."
	}
end

program Chi2test
	args right C3 C4 c4wfmt

	local type `e(chi2type)'
	if `"`type'"' == "" {
		local type Wald
	}
	if !missing(e(chi2)) {
		.`right'.Arrpush				///
		          `C3' "`type' chi2("			///
		   as res e(df_m)				///
		   as txt ")" `C4' "= "				///
		   as res %`c4wfmt'.2f e(chi2)
		.`right'.Arrpush				///
		          `C3' "Prob > chi2" `C4' "= "		///
		   as res %`c4wfmt'.4f chi2tail(e(df_m),e(chi2))
	}
	else {
		local j_robust					///
		"{help j_robustsingular##|_new:`type' chi2(`e(df_m)')}"
		.`right'.Arrpush				///
		          `C3' "`j_robust'"			///
		   as txt `C4' "= " as res %`c4wfmt's "."
		.`right'.Arrpush				///
		          `C3' "Prob > chi2" `C4' "= "		///
		   as res %`c4wfmt's "."
	}
end

exit
