*! version 1.0.0  11jun2008

version 10.1

mata
mata set matastrict on

/* random chi-squared(df) variate generatator				*/
real matrix rchi2(real scalar r, real scalar c, real matrix df)
{
	return(rgamma(r,c,df:/2,2.0))
}

end
exit

