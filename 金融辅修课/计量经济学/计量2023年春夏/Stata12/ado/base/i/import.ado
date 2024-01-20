*! version 1.0.5  09jun2011
program define import
	version 12

	gettoken subcmd 0 : 0

	if `"`subcmd'"' == "excel" {
		ImpExcel `0'
	}
	else if `"`subcmd'"' == "sasxport" {
		ImpSasxport `0'
	}
	else {
		display as error `"import: unknown subcommand "`subcmd'""' 
		exit 198
	}

end

program ImpSasxport
	capture syntax [anything] , Describe [*]
	if _rc==0 {
		fdadescribe `anything', `options'
		exit
	}

	fdause `0'
end

program ImpExcel
	version 12

	scalar ImpExcelCleanUp = -1
	capture noi import_excel `0'

	nobreak {
		local rc = _rc
		if `rc' {
			if ImpExcelCleanUp >= 0 {
				mata : import_excel_cleanup() 
			}
		}
	}
	scalar drop ImpExcelCleanUp
	exit `rc'
end

version 12.0
mata:

void import_excel_cleanup()
{
	_xlbkrelease(st_numscalar("ImpExcelCleanUp"))
}
end

