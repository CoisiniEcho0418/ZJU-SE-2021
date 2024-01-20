*! version 1.0.0  18jul2005
program _pred_missings
	version 9
	syntax varname
	quietly count if missing(`varlist')
	if r(N) {
		di as txt "(`r(N)' missing values generated)"
	}
end
exit
