*! version 1.0.0  21may2009

 
program define _matrix_cmds
	version 11.0
	
	gettoken sub rest : 0, parse(" ,")
	local 0 ,`sub'	
	capture syntax [ , List ]
	if _rc {
		error 501
	}
	
	if "`list'" != "" {
		List `rest'
		exit
	}
	error 501
end

program List
	version 11
	syntax anything(id="matrix name" name=mname) [,	///
		noBlank					///
		noHAlf					///
		noHeader				///
		noNames					///
		Format(string)				///
		TItle(string)				///
		nodotz					///
	]

	confirm matrix `mname'
	if `"`format'"' != "" {
		confirm numeric format `format'
	}
	local bl = "`blank'" == ""
	local ha = "`half'" == ""
	local he = "`header'" == ""
	local na = "`names'" == ""
	local dz = "`dotz'" == ""
	local title : list clean title
	mata: st_matrix_list(	"`mname'",		///
				"`format'",		///
				`"`title'"',		///
				`bl',`ha',`he',`na',`dz')
end

exit
