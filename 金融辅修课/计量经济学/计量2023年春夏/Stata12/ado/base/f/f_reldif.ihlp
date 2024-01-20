{* *! version 1.0.2  02jun2011}{...}
    {cmd:reldif(}{it:x}{cmd:,}{it:y}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:x}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Domain {it:y}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Range:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Description:}returns the "relative"
    	                difference  |{it:x}-{it:y}|/(|{it:y}|+1).{p_end}
{p2col:}returns {cmd:0} if both arguments are the same type of extended 
                        missing value.{p_end}
{p2col:}returns {it:missing} if only one argument is missing
                        or if the two arguments are two different types of
			{it:missing}.{p_end}
{p2colreset}{...}
