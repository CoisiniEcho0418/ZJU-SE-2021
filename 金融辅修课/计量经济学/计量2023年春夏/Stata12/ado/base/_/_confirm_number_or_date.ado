*! version 1.0.4  20jul2005
program _confirm_number_or_date
	version 8.1

	if (`"`0'"' == "") exit 9

	local dfuncs d w m q h // -y()- is redundant

	while `"`0'"' != "" {
		gettoken tok 0 : 0 , parse(" ()") match(par)

		// allow numbers
		capture confirm number `tok'
		if (!_rc) continue

		if "`par'" == "" {
			// allow missing values
			if ("`tok'" == ".") continue
			if substr("`tok'",1,1) == "." {
				if length("`tok'") == 2 {
					local letter = substr("`tok'",2,1)
					local l = lower("`letter'")
					local u = upper("`letter'")
					if ("`l'" != "`u'"		///
					&   "`letter'" != "`u'")	///
						continue
				}
			}
		}

		// allow certain date strings
		local isdate 0
		foreach func of local dfuncs {
			capture {
				local x = `func'(`tok')
				confirm integer number `x'
			}
			if (!_rc) {
				local isdate 1
				continue, break
			}
		}
		if (!`isdate') exit 9
	}
end

exit
