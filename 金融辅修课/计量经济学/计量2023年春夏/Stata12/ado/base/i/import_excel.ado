*! version 1.0.10  16jun2011
program define import_excel
	version 12

	if ("`c(excelsupport)'" != "1") {
		dis as err `"import excel is not supported on this platform."'
		exit 198
	}

	gettoken filename rest : 0, parse(" ,")
	gettoken comma : rest, parse(" ,")

	if (`"`filename'"' != "" & (trim(`"`comma'"') == "," |		///
		trim(`"`comma'"') == "")) {
		local 0 `"using `0'"'
	}
	
	capture syntax using/, DESCribe
	if _rc {
		capture syntax using/ [, SHeet(string)			///
			CELLRAnge(string) FIRSTrow ALLstring clear]
		if _rc {
		syntax [anything(name=extvarlist id="extvarlist" equalok)] ///
			using/ [, SHeet(string) FIRSTrow CELLRAnge(string) ///
			ALLstring clear]
		}
	}
	mata : import_excel_import_file()
end

