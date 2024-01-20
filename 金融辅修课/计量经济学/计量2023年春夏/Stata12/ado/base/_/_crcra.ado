*! version 3.0.0  10/29/91
program define _crcra /* a b c d level tbflg*/
	version 3.0
	local a `1'
	local c `2'
	local b `3'
	local d `4'
	local level `5'
	local tbflg `6'
	local iz=invnorm(1-(1-`level'/100)/2)
	local t=`a'+`b'+`c'+`d'

	mac def S_1=(`a'*`d'-`b'*`c')/((`a'+`c')*(`c'+`d'))
	local sdl1=sqrt((`b'+$S_1*(`a'+`d'))/(`t'*`c'))
	mac def S_2=1-exp(ln(1-$S_1)+`iz'*`sdl1')
	mac def S_3=1-exp(ln(1-$S_1)-`iz'*`sdl1')
	mac def S_4
	if `a'==0 & `c'==0 { 
		mac def S_2 .
		mac def S_3 . 
	}
end
exit
cumulative incidence data, risk difference
F-76	Ra	(attributable risk)
F-76	se of Ra
