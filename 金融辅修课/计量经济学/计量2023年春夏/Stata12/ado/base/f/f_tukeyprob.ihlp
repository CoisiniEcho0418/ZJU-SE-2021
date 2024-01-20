{* *! version 1.0.1  30apr2011}{...}
    {cmd:tukeyprob(}{it:k}{cmd:,}{it:df}{cmd:,}{it:x}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:k}:}2 to 1e+6{p_end}
{p2col: Domain {it:df}:}2 to 1e+6{p_end}
{p2col: Domain {it:x}:}-8e+307 to 8e+307{p_end}
{p2col:}Interesting domain is {it:x} {ul:>} 0{p_end}
{p2col: Range:}0 to 1{p_end}
{p2col: Description:}returns the cumulative Tukey's Studentized range
	distribution with {it:k} ranges and {it:df} degrees of freedom.  If 
	{it:df} is a missing value, then the normal distribution is used
	instead of Student's t.{p_end}
{p2col: }returns {cmd:0} if {it:x} < 0.{p_end}	
{p2col 8 22 22 2: }{cmd:tukeyprob()} is computed using an algorithm
		 described in {help density_functions##M1981:Miller (1981)}.
{p2colreset}{...}
