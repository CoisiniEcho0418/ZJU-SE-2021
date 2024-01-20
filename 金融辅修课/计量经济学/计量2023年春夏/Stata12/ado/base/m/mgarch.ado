*! version 1.0.0  08mar2011
program define mgarch, eclass byable(onecall)
	version 11.1
	
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	
	if replay() {
		if `"`e(cmd)'"' != "mgarch" {
			error 301
		}
		if _by() {
			error 190
		}
		_mgarch_util Replay `0'
		exit
	}
	
	`BY' Estimate `0'
	
	ereturn local cmdline `BY'mgarch `0'
end

program define Estimate, eclass byable(onecall)
	
	if _by() {
		local BY `"by `_byvars'`_byrc0':"'
	}
	
	gettoken model 0 : 0
	
	local len = length(`"`model'"')
	if `len'==0 {
               di as err "No subcommand specified"
               exit 198
        }
        
        if `"`model'"'==substr("ccc",1,max(3,`len')) {
                cap noi `BY' mgarch_ccc `0'
	}
        else if `"`model'"'==substr("dcc",1,max(3,`len')) {
                cap noi `BY' mgarch_dcc `0'
        }
        else if `"`model'"'==substr("dvech",1,max(5,`len')) {
                cap noi `BY' mgarch_dvech `0'
        }
        else if `"`model'"'==substr("vcc",1,max(3,`len')) {
                cap noi `BY' mgarch_vcc `0'
        }
 	else {
                di as error `"`model' unknown subcommand"'
                exit 198
	}
        
	local rc = c(rc)
	foreach m of local matanames {
		cap mata: mata drop `m'
	}
	if `rc' exit `rc'

end

exit
