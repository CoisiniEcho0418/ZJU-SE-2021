*! version 1.2.10  16feb2010
program define histogram
	version 8.0, missing

	syntax varname(numeric) [fw] [if] [in] [,	///
		Discrete				///
		BIN(passthru)				///
		START(passthru)				///
		Width(passthru)				///
		DENsity FRACtion FREQuency		///
		percent					///
		KDENsity				///
		NORMal					///
		ADDLabels				///
		BARWidth(real -99)			///
		HORizontal				///
		*					///
	]

	_gs_by_combine by options : `"`options'"'

	// note: options discrete and bin() are mutually exclusive

	if `"`discrete'"' != "" & `"`bin'"' != "" {
		di as error "options discrete and bin() may not be combined"
		exit 198
	}

	// note: bin() and width() are mutually exclusive

	if `"`bin'"' != "" & `"`width'"' != "" {
		di as err "options bin() and width() may not be combined"
		exit 198
	}

	// note: options density, fraction and frequency are mutually
	// exclusive

	local type `density' `fraction' `frequency' `percent'
	local k : word count `type'
	if `k' > 1 {
		local type : list retok type
		di as err "options `type' may not be combined"
		exit 198
	}
	else if `k' == 0 {
		local type density
	}

	local yttl = upper(substr("`type'",1,1))+substr("`type'",2,.)
	local xttl : var label `varlist'
	if `"`xttl'"' == "" {
		local xttl `varlist'
	}

	tempname touse
	mark `touse' `if' `in'

	local wgt [`weight'`exp']
	local ifin if `touse'
	local histopts `discrete' `type' `bin' `start' `width'

	_get_gropts , graphopts(`options' `by')		///
		grbyable total missing			///
		getbyallowed(legend)			///
		getallowed(KDENOPts NORMOPts ADDLABOPts PLOT ADDPLOT)
	local by `"`s(varlist)'"'
	local bylegend `"`s(by_legend)'"'
	local byopts `"`s(total)' `s(missing)' `s(byopts)'"'
	local byopts : list retok byopts
	if `"`by'"' == "" & `"`byopts'"' != "" {
		di as error "option by() requires a varlist"
		exit 198
	}
	local options `"`s(graphopts)'"'
	local kdenopts `"`s(kdenopts)'"'
	local normopts `"`s(normopts)'"'
	local addlabopts `"`s(addlabopts)'"'
	local plot `"`s(plot)'"'
	local addplot `"`s(addplot)'"'
	_check4gropts kdenopts, opt(`kdenopts')
	if `"`kdenopts'"' != "" {
		local kdensity kdensity
	}
	_check4gropts normopts, opt(`normopts')
	if `"`normopts'"' != "" {
		local normal normal
	}
	_check4gropts addlabopts, opt(`addlabopts')
	if `"`addlabopts'"' != "" {
		local addlabels addlabels
	}
	if `"`by'"' != "" & ///
		`"`frequency'"' != "" & ///
		`"`normal'`kdensity'"' != "" {
		local dens `normal' `kdensity'
		if 0`:word count `dens'' != 1 {
			local s s
		}
		di as err "{p}option frequency"	///
			" may not be combined with the `dens'"	///
			" and by() option`s'{p_end}"
		exit 191
	}
	if "`by'" != "" {
		local qui qui
	}

	// gen common histogram parameters, and display a little note
	`qui' twoway__histogram_gen `varlist' `wgt' `ifin', `histopts' display
	if `"`by'`discrete'`width'"' == "" {
		local histopts `r(type)' start(`r(min)') bin(`r(bin)')
	}
	else {
		local histopts `r(type)' start(`r(min)') width(`r(width)')
	}
	local rangeopt "range(`r(min)' `r(max)')"
	if `"`type'"' != "density" {
		local area = r(area)
		local areaopt area(`r(area)')
	}
	else	local area 1

	if `"`kdensity'"' != "" {
		local KDEgraph				///
		(kdensity `varlist'			///
			`wgt',				///
			lstyle(refline)			///
			yvarlab("kdensity `varlist'")	///
			`horizontal'			///
			`rangeopt'			///
			`areaopt'			///
			`kdenopts'			///
		)
	}
	if `"`normal'"' != "" {
		qui sum `varlist' `wgt' `ifin'
		local Ngraph					///
		(fn_normden `varlist'				///
			`wgt',					///
			yvarlab("normal `varlist'")		///
			lstyle(refline)				///
			`rangeopt'				///
			`areaopt'				///
			`horizontal'				///
			`normopts'				///
		)
	}
	if `"`addlabels'"' != "" {
		local Lgraph			///
		(histogram `varlist'		///
			`wgt',			///
			`histopts'		///
			`horizontal'		///
			recastas(scatter)	///
			msymbol(none)		///
			mlabel(_height)		///
			mlabposition(12)	///
			`addlabopts'		///
		)
	}

	if `"`bylegend'`plot'`addplot'"' == "" {
		local legend legend(nodraw)
	}
	if `"`by'"' != "" {
		local byopt `"by(`by', `bylegend' `byopts')"'
	}
	if `"`horizontal'"' != "" {
		local zz `"`yttl'"'
		local yttl `"`xttl'"'
		local xttl `"`zz'"'
	}

	if _caller() >= 9 {
		if "`horizontal'" == "" {
			local bmarg plotregion(margin(b=0))
		}
		else	local bmarg plotregion(margin(l=0))
	}

	graph twoway			///
	(histogram `varlist'		///
		`wgt',			///
		ytitle(`"`yttl'"')	///
		xtitle(`"`xttl'"')	///
		legend(cols(1))		///
		barwidth(`barwidth')	///
		`bmarg'			///
		`horizontal'		///
		`byopt'			///
		`legend'		///
		`histopts'		///
		`options'		///
	)				///
	`KDEgraph'			///
	`Ngraph'			///
	`Lgraph'			///
	`ifin'				///
	|| `plot' || `addplot'		///
	// blank
end

exit
