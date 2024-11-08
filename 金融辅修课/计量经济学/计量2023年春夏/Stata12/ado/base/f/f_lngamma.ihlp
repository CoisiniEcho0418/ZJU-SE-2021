{* *! version 1.0.1  15mar2007}{...}
    {cmd:lngamma(}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-2,147,483,648 to 1e+305 (excluding negative integers){p_end}
{p2col: Range:}-8e+307 to 8e+307{p_end}
{p2col: Description:}returns the natural log of the
	gamma function of {it:x}.  For integer values of 
	{it:x} > 0, this is ln(({it:x}-1)!).{p_end}

{p2col 8 22 22 2:}{cmd:lngamma(}{it:x}{cmd:)} for {it:x} < 0 returns a number
                  such that {cmd:exp(lngamma(}{it:x}{cmd:))} is equal to the
		  absolute value of the gamma function.  That is,
		  {cmd:lngamma(}{it:x}{cmd:)} always returns a real (not
		  complex) result.
{p2colreset}{...}
