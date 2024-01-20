*! version 1.1.1  17jun2011
program define unzipfile
	version 11.0
	syntax anything[, replace]

	gettoken ZipFileName rest : anything

	if (`"`rest'"' != "") {
		di as error "invalid syntax"
		exit 198
	}
	if (`"`replace'"' != "") {
		local overwrite "overwrite"
	}
	
	mata : zipfile_cmd()
end

version 11.0
mata:

void zipfile_cmd()
{
	string scalar file, suffix, cmd, overwrite 
	real scalar rc
	
	file = st_local("ZipFileName")
	overwrite = st_local("overwrite")

	suffix = pathsuffix(file)
	if(suffix == "") {
		file = file + ".zip"
	}

	if (overwrite != "") {
		cmd = sprintf(`"_unzipfile "%s",  overwrite"', file)	
	}
	else {
		cmd = sprintf(`"_unzipfile "%s""', file)	
	}

	rc = _stata(cmd)
	if (rc) {
		exit(601)
	}
}
end

exit


