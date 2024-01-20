*! version 1.0.5  09jun2011
program define export 
	version 12

	gettoken subcmd 0 : 0

	if `"`subcmd'"' == "excel" {
		ExpExcel `0'
	}
	else if `"`subcmd'"' == "sasxport" {
		ExpSasxport `0'
	}
	else {
		display as error `"export: unknown subcommand "`subcmd'""' 
		exit 198
	}

end

program ExpSasxport
	fdasave `0'
end

program ExpExcel
	version 12

	scalar ExpExcelCleanUp = -1
	capture noi export_excel `0'
	nobreak {
		local rc = _rc
		if `rc' {
			if scalar(ExpExcelCleanUp) >= 0 {
				mata : export_excel_cleanup()
			}
		}
	}
	scalar drop ExpExcelCleanUp
	exit `rc'
end


version 12.0
mata:

void export_excel_cleanup()
{
	_xlbkrelease(st_numscalar("ExpExcelCleanUp"))
}
end
