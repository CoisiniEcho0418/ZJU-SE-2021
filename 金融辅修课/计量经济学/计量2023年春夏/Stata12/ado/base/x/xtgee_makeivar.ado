*! version 1.0.0  07sep2004
program define xtgee_makeivar /* rivar tvar tord maxni -> ivar */
	args rivar tvar tord maxni ARROW ivar

	tempvar pi ti
	tempname p
	scalar `p' = cond(`maxni'<=50, 2, 2^(50/(`maxni'+1)))
	by `rivar': gen double `pi' = sum((`p')^`tord')
	by `rivar': replace `pi' = `pi'[_N]
	by `rivar': gen int `ti' = _N
	sort `ti' `pi' `rivar'
	by `ti' `pi' `rivar': gen long `ivar' = 1 if _n==1
	replace `ivar' = sum(`ivar')
end
exit
