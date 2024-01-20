*! version 1.1.0  22mar2007

// ---------------------------------------------------------------------------
//  Drawing program for the barlike view such as bars, spikes, and
//  droplines

program yxview__barlike_draw
	.style.area.setgdifull				// set the style

							// find our base point
	local dropx = "`.bar_drop_to.stylename'" == "x"

	if `dropx' {
		local min = `.`.plotregion'.yscale.curmin'
		local max = `.`.plotregion'.yscale.curmax'
	}
	else {
		local min = `.`.plotregion'.xscale.curmin'
		local max = `.`.plotregion'.xscale.curmax'
	}

	if `.base' < . {
		local base `.base'
	}
	else {
		if `min' <= 0 & `max' >= 0 {  
			local base 0
		}
		else {
			local base = cond(`max' < 0 , `max' , `min')
		}
	}

	if (`.drop_base.istrue')  .drawn_base = `base'
	else			  .drawn_base = (.)

	.serset.set					// just in case

	draw_`.type.stylename' `dropx' `base'	// draw type
end


program draw_bar
	args dropx base
	draw_`.bartype.stylename' `dropx' `base'	// draw type
end


program draw_fixed
	args dropx base

	local d = `.bar_size' / 2
	if `dropx' {
		forvalues j = 1/`:serset N' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			local x = serset(`.xvar', `j')
			gdi rectangle `=`x'-`d'' `base'			///
				      `=`x'+`d'' `=serset(`.yvar', `j')'
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}
	else {
		forvalues j = 1/`:serset N' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			local y = serset(`.xvar', `j')
			gdi rectangle `base'                  `=`y'-`d''   ///
				      `=serset(`.yvar', `j')' `=`y'+`d'' 
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}
end


program draw_obs
	args dropx base

//	local min = `.`.plotregion'.xscale.min'			// not curmin
//	local max = `.`.plotregion'.xscale.max'

	local min = 0`.serset.sers[0`.xvar'].min'
	local max = 0`.serset.sers[0`.xvar'].max'

	.bar_size = (1 - `.bar_gap'/200) * (`max' - `min') /		///
		    (`:serset N' - (`:serset N' > 1))

	draw_fixed `dropx' `base'
end

program draw_spanning
	args dropx base

	if `dropx' {
		forvalues j = 1/`=`:serset N'-1' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			gdi rectangle `=serset(`.xvar', `j')' `base'	///
			    `=serset(`.xvar', `=`j'+1')' `=serset(`.yvar', `j')'
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}
	else {
		forvalues j = 1/`=`:serset N'-1' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			gdi rectangle `base' `=serset(`.xvar', `j')' 	///
			    `=serset(`.yvar', `j')' `=serset(`.xvar', `=`j'+1')'
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}

end

program draw_dropline
	args dropx base

							// drop lines
	draw_spike `dropx' `base'

							// symbols
	if "`.style.marker.symbol'" == "none" {
		exit
	}

	if `dropx' {
		._draw_points
	}
	else {
		nobreak {
			local holdx `.xvar'
			.xvar = .yvar
			.yvar = `holdx'
			._draw_points
			.yvar = .xvar
			.xvar = `holdx'
		}
	}
end

program draw_spike
	args dropx base

							// drop lines
	if `dropx' {
		forvalues j = 1/`:serset N' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			local x = serset(`.xvar', `j')
			gdi line `x' `base' `x' `=serset(`.yvar', `j')'
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}
	else {
		forvalues j = 1/`:serset N' {
			if ("`.obs_styles[`j'].isa'" != "")		///
				.obs_styles[`j'].area.setgdifull
			local y = serset(`.xvar', `j')
			gdi line `base' `y' `=serset(`.yvar', `j')' `y'
			if ("`.obs_styles[`j'].isa'" != "")		///
				.style.area.setgdifull	
		}
	}
end

program draw_area
	args dropx base

	local n : serset N
	while `n' > 0 &							///
	     (`=serset(`.xvar', `n')' >= . | `=serset(`.yvar', `n')' >= .) {
		local --n
	}


	local beg 1
	while `beg' <= `n' &						///
	     (`=serset(`.xvar', `beg')' >= . | `=serset(`.yvar', `beg')' >= .) {
		local ++beg
	}

	if `beg' >= `n' {
		exit
	}


	if ! 0`.style.connect_missings.istrue' {
		draw_separate_areas `dropx' `base' `beg' `n'
		exit
	}

	if `dropx' {
		gdi moveto `=serset(`.xvar', `beg')' `=serset(`.yvar', `beg')'
		gdi polybegin

		forvalues j = `beg'/`n' {
		     gdi lineto `=serset(`.xvar', `j')' `=serset(`.yvar', `j')'
		}

		if `.drop_base.istrue' {
			gdi lineto `=serset(`.xvar', `n')' `base'
			gdi lineto `=serset(`.xvar',  `beg')'  `base'
		}
		gdi lineto `=serset(`.xvar',  `beg')' `=serset(`.yvar',  `beg')'

		gdi polyend

	}
	else {

		gdi moveto `=serset(`.yvar', `beg')' `=serset(`.xvar', `beg')'
		gdi polybegin

		forvalues j = `beg'/`n' {
		     gdi lineto `=serset(`.yvar', `j')' `=serset(`.xvar', `j')'
		}

		if `.drop_base.istrue' {
			gdi lineto `base' `=serset(`.xvar', `n')'
			gdi lineto `base' `=serset(`.xvar',  `beg')'
		}
		gdi lineto `=serset(`.yvar', `beg')' `=serset(`.xvar',  `beg')'

		gdi polyend
	}
end

program draw_separate_areas
	args dropx base beg n

	local j `beg'
	local inpoly 0 

	if `dropx' {
	    while `j' <= `n' {
	    	local beg0 `j'

		gdi moveto `=serset(`.xvar', `beg0')' `=serset(`.yvar', `beg0')'
		gdi polybegin

		while `j' <= `n' {
		    if (`=serset(`.xvar', `j')' >= . |		///
		    	`=serset(`.yvar', `j')' >= .) {
			local ++j
			continue, break
		    }
		    gdi lineto `=serset(`.xvar', `j')' `=serset(`.yvar', `j')'
		    local inpoly 1
		    local j0 `j'
		    local ++j
		}

		if `inpoly' {
		    if `.drop_base.istrue' {
			local jdrop = cond(`j'==`n', `n', `j0')
			gdi lineto `=serset(`.xvar', `jdrop')' `base'
			gdi lineto `=serset(`.xvar',  `beg0')' `base'
		    }
		    gdi lineto  `=serset(`.xvar', `beg0')'		///
		    		`=serset(`.yvar', `beg0')'
		    local inpoly 0
		}

		gdi polyend
	    }

	}
	else {
	    while `j' <= `n' {
	    	local beg0 `j'

		gdi moveto `=serset(`.yvar', `beg0')' `=serset(`.xvar', `beg0')'
		gdi polybegin

		while `j' <= `n' {
		    if (`=serset(`.xvar', `j')' >= . |		///
		    	`=serset(`.yvar', `j')' >= .) {
			local ++j
			continue, break
		    }
		    gdi lineto `=serset(`.yvar', `j')' `=serset(`.xvar', `j')'
		    local inpoly 1
		    local j0 `j'
		    local ++j
		}

		if `inpoly' {
		    if `.drop_base.istrue' {
			local jdrop = cond(`j'==`n', `n', `j0')
			gdi lineto `base' `=serset(`.xvar', `jdrop')'
			gdi lineto `base' `=serset(`.xvar',  `beg0')'
		    }
		    gdi lineto  `=serset(`.yvar', `beg0')'		///
		    		`=serset(`.xvar', `beg0')'
		    local inpoly 0
		}

		gdi polyend
	    }
	}
end
