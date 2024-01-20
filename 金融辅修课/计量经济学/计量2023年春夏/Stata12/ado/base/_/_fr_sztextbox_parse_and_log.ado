*! version 1.0.0  12sep2002

// Parses options for a textbox and its associated style and posts those edits
// of the specified textbox to the specified log of the specified object

program _fr_sztextbox_parse_and_log , rclass
	gettoken log  0 : 0
	gettoken tbox 0 : 0

	syntax [ , WIDTH(string) HEIGHT(string)				///
		   NOASTextbox NOBEXpand ASTextbox BEXpand * ]

		   				// object edits
	if `"`width'"' != `""' {
		.`log'.Arrpush .`tbox'.specified_textwidth  = `width'
	}
	if `"`height'"' != `""' {
		.`log'.Arrpush .`tbox'.specified_textheight = `height'
	}
	if `"`noastextbox'`nobexpand'"' != `""' {
		.`log'.Arrpush .`tbox'.as_textbox.setstyle, style(no)
	}
	if `"`astextbox'`bexpand'"' != `""' {
		.`log'.Arrpush .`tbox'.as_textbox.setstyle, style(yes)
	}

	_fr_textbox_parse_and_log `log' `tbox' , `options'

	return local rest `r(rest)'

end
