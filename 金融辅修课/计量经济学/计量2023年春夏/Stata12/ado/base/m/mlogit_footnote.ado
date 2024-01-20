*! version 1.0.2  01mar2005
program mlogit_footnote
	version 9
	local base = trim(substr(`"`e(baselab)'"',1,c(namelen)))
	di as txt `"(`e(depvar)'==`base' is the base outcome)"'
end
exit
