*! version 3.0.5  28aug2003
program define _crccip, rclass
	version 6
	tempname f fp x k topk lev
* touched by kth  -- double saves in r() and S_#
* touched by jml -- fix algorithm
	scalar `k'= `1'
	scalar `lev' = (100-`2')/200
	scalar `x' = `k'
	if `x'== 0 {
		scalar `x' = .1  /* need a better starting point */
	}
	scalar `f' = 1-gammap(`k'+1,`x') - `lev'	/* Pr(k or fewer)*/
	while ((abs(`f')> 1e-8)&(`x' < .)) { 
		scalar `fp'= -dgammapdx(`k'+1,`x')
		scalar `x' = `x' - `f'/`fp'
		scalar `f' = 1-gammap(`k'+1,`x') - `lev'
	}
	global S_2 : di %16.0g `x'
	ret scalar upper = `x'
	if `k'==0 { 
		global S_1 0
		ret scalar lower = 0
		exit
	}
	scalar `x' = `k'
	scalar `topk'= `k'
	scalar `f' = gammap(`k',`x') - `lev'	/* Pr(k or more)	*/
	while ((abs(`f') > 1e-8)&(`x'<.)) { 
		scalar `fp'=dgammapdx(`k',`x')
		scalar `x' = `x' - `f'/`fp'
		if `x'<0 { 
			scalar `x' = 0 
		}
		else if `x'>`topk' { 
			scalar `topk' = `topk' - .1
			scalar  `x'= `topk'
		}
		scalar `f' = gammap(`k',`x') - `lev'
	}
	global S_1 : di %16.0g `x' 
	ret scalar lower = `x'
end
